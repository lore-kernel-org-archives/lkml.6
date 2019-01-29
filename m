Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC0DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4482217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfA2FBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:01:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:53334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbfA2FBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:01:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F95EADC3;
        Tue, 29 Jan 2019 05:01:42 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        support@enocean.com,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC net-next 1/4] net: Reserve protocol identifiers for EnOcean
Date:   Tue, 29 Jan 2019 06:01:27 +0100
Message-Id: <20190129050130.10932-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190129050130.10932-1-afaerber@suse.de>
References: <20190129050130.10932-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EnOcean wireless technology is based on ASK (ERP1) and FSK (ERP2) modulations
for sub-GHz and on IEEE 802.15.4 for 2.4 GHz.

ARPHRD_ENOCEAN
ETH_P_ERP{1,2}

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 include/uapi/linux/if_arp.h   | 1 +
 include/uapi/linux/if_ether.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index dd7992a441c9..327ef052329f 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -102,6 +102,7 @@
 #define ARPHRD_LORAWAN	828		/* LoRaWAN			*/
 #define ARPHRD_OOK	829		/* On/Off Keying modulation	*/
 #define ARPHRD_FSK	830		/* Frequency Shift Keying modulation */
+#define ARPHRD_ENOCEAN	832		/* EnOcean			*/
 
 #define ARPHRD_VOID	  0xFFFF	/* Void type, nothing is known */
 #define ARPHRD_NONE	  0xFFFE	/* zero header length */
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 0b5c30f78261..3e22948cc329 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -152,6 +152,8 @@
 #define ETH_P_OOK	0x00FC		/* On/Off Keying modulation	*/
 #define ETH_P_FSK	0x00FD		/* Frequency Shift Keying mod.	*/
 #define ETH_P_FLRC	0x00FE		/* Fast Long Range Communication */
+#define ETH_P_ERP1	0x00FF		/* EnOcean Radio Protocol 1	*/
+#define ETH_P_ERP2	0x0100		/* EnOcean Radio Protocol 2	*/
 
 /*
  *	This is an Ethernet frame header.
-- 
2.16.4

