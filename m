Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A63C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8095F2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8095F2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeI1V6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:58:11 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:63458 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728765AbeI1V6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:58:11 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id B1/F5-27472-ED94EAB5; Fri, 28 Sep 2018 15:33:50 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRWlGSWpSXmKPExsUSt3Opse49z3X
  RBmte6Fo0L17PZtG1eieLxeVdc9gsFi1rZbZ4svAMkwOrx7yTgR77565h99j5vYHd4/MmuQCW
  KNbMvKT8igTWjL1vvrIUXOCtmNjwna2B8QB3FyMXh5DAekaJ9vXPWboYOYGcComZbQ1MIDabg
  IXE5BMP2EBsFgFViTPzulhBbGGBIIn5e+cxgzSLCPQwSmw8soQdJMEskCSx9m0PM4jNK+Ag8f
  PhZVYIW1Di5MwnLBA1EhIHX7xghlhmIHF6QSNYXELAXmL6+6tAcQ4gW1+i8VgsRNhQ4vusb1A
  l5hL7lrxmnMDIPwvJ1FlIpi5gZFrFaJFUlJmeUZKbmJmja2hgoGtoaKxrqmtippdYpZukl1qq
  m5yaV1KUCJTUSywv1iuuzE3OSdHLSy3ZxAgM6JRCVr0djLOWpx9ilORgUhLlvayyLlqILyk/p
  TIjsTgjvqg0J7X4EKMMB4eSBO86D6CcYFFqempFWmYOMLZg0hIcPEoivC4gad7igsTc4sx0iN
  QpRl2OtqfXZzALseTl56VKifNqACNVSACkKKM0D24ELM4vMcpKCfMyMjAwCPEUpBblZpagyr9
  iFOdgVBLmlQCZwpOZVwK36RXQEUxAR4gcWANyREkiQkqqgVFXviZR5gNz2ikOKS0dxWTPvatv
  +fadXaAyY0nIu744P41b8ekKDc3h3+wLdgt0/LnhaVvOyJMxe9cne65r//m9FrS7rtV4cIdzW
  vGNlUd5DJllBLIXCX/8Wtvw6/QL8XnSV5OmPzy1eHLh5cDVrdvOMP+6ITKVKc5Ds1L3z0Jv3U
  4x3WnuAkosxRmJhlrMRcWJAPExM1ruAgAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-13.tower-246.messagelabs.com!1538148830!540505!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15621 invoked from network); 28 Sep 2018 15:33:50 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-13.tower-246.messagelabs.com with AES128-SHA encrypted SMTP; 28 Sep 2018 15:33:50 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Fri, 28 Sep 2018 16:33:49 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 DC14D3FAF0; Fri, 28 Sep 2018 16:33:49 +0100 (BST)
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Fri, 28 Sep 2018 16:33:49 +0100
Subject: [PATCH] usb: typec: tcpm: Report back negotiated PPS voltage and
 current
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <support.opensource@diasemi.com>
Message-ID: <20180928153349.DC14D3FAF0@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 28/09/2018 13:49:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when requesting a specific voltage or current through
the psy interface, for PPS, when reading back from that interface
the values will always be the same as previously given, if the
request was successful. However PPS only allows for 20mV voltage
steps and 50mA current steps, and the psy class expects microvolt
and micro amp requests, so inbetween values can be provided through
this interface. Really when reading back the true values negotiated
should be given, and not the ones originally asked for.

To report the actual values negotiated with the Source, the values
stored are now rounded down to the relevant step units prior to
building the PPS request, so that those values are later correctly
reported through the psy interface. In addition this improves the
adjustments made to meet the operating power requirements of the
platform, which previously could have been slightly out due to not
using valid PPS units of voltage and current.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
Changes are based on usb-testing (ae8a2ca8a221)

 drivers/usb/typec/tcpm/tcpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 4f1f421..33b3981 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2433,6 +2433,10 @@ static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
 
 	flags = RDO_USB_COMM | RDO_NO_SUSPEND;
 
+	/* Round down output voltage and current to align with PPS valid steps */
+	out_mv = out_mv - (out_mv % RDO_PROG_VOLT_MV_STEP);
+	op_ma = op_ma - (op_ma % RDO_PROG_CURR_MA_STEP);
+
 	op_mw = (op_ma * out_mv) / 1000;
 	if (op_mw < port->operating_snk_mw) {
 		/*
-- 
1.9.1

