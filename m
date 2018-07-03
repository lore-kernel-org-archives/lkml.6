Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CC4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18D320871
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18D320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeGCWUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:20:07 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.46]:11891 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753183AbeGCWUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:20:06 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 52D8FC3306
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 17:20:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aTeYfIeoGSjJAaTeYfnapS; Tue, 03 Jul 2018 17:20:06 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=51138 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1faTeX-003zeh-L3; Tue, 03 Jul 2018 17:20:05 -0500
Date:   Tue, 3 Jul 2018 17:20:03 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] scsi: mptfusion: mark expected switch fall-throughs
Message-ID: <20180703222003.GA4593@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1faTeX-003zeh-L3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:51138
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/message/fusion/mptbase.c | 3 +++
 drivers/message/fusion/mptsas.c  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index a625ac4..c8c8186 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -642,6 +642,7 @@ mptbase_reply(MPT_ADAPTER *ioc, MPT_FRAME_HDR *req, MPT_FRAME_HDR *reply)
 			freereq = 0;
 		if (event != MPI_EVENT_EVENT_CHANGE)
 			break;
+		/* else: fall through */
 	case MPI_FUNCTION_CONFIG:
 	case MPI_FUNCTION_SAS_IO_UNIT_CONTROL:
 		ioc->mptbase_cmds.status |= MPT_MGMT_STATUS_COMMAND_GOOD;
@@ -1886,6 +1887,7 @@ mpt_attach(struct pci_dev *pdev, const struct pci_device_id *id)
 	case MPI_MANUFACTPAGE_DEVICEID_FC939X:
 	case MPI_MANUFACTPAGE_DEVICEID_FC949X:
 		ioc->errata_flag_1064 = 1;
+		/* fall through */
 	case MPI_MANUFACTPAGE_DEVICEID_FC909:
 	case MPI_MANUFACTPAGE_DEVICEID_FC929:
 	case MPI_MANUFACTPAGE_DEVICEID_FC919:
@@ -1930,6 +1932,7 @@ mpt_attach(struct pci_dev *pdev, const struct pci_device_id *id)
 			pcixcmd &= 0x8F;
 			pci_write_config_byte(pdev, 0x6a, pcixcmd);
 		}
+		/* fall through */
 
 	case MPI_MANUFACTPAGE_DEVID_1030_53C1035:
 		ioc->bus_type = SPI;
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 76a66da..b8cf265 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -4327,6 +4327,7 @@ mptsas_hotplug_work(MPT_ADAPTER *ioc, struct fw_event_work *fw_event,
 			}
 		}
 		mpt_findImVolumes(ioc);
+		/* fall through */
 
 	case MPTSAS_ADD_DEVICE:
 		memset(&sas_device, 0, sizeof(struct mptsas_devinfo));
-- 
2.7.4

