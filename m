Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E914EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05742084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05742084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJHUFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:05:39 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.132]:16938 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbeJHUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:05:38 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.eu-west-1.aws.symcld.net id E7/9A-09011-9635BBB5; Mon, 08 Oct 2018 12:54:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRWlGSWpSXmKPExsVy8IPnUd3M4N3
  RBi0rNC2aF69ns+havZPF4vKuOWwWi5a1Mls8WXiGyYHVY97JQI/9c9ewe+z83sDu8XmTXABL
  FGtmXlJ+RQJrxt9LL1gKrglWPNs7jb2B8StfFyMXh5DAOkaJtf2PGbsYOYGcColpV16D2WwCF
  hKTTzxgA7FZBFQk/p79CRYXFgiVmDz/CAtIs4hAD6PExiNL2EESzAJJEmvf9jCD2LwCDhL7J9
  xkgrAFJU7OfMICUSMhcfDFC2aIZQYSpxc0gsUlBOwlpr+/ChTnALL1JRqPxUKEDSW+z/oGVWI
  usXNhD+MERv5ZSKbOQjJ1ASPTKkaLpKLM9IyS3MTMHF1DAwNdQ0MjXSMDI11DY2O9xCrdZL3U
  Ut3y1OISXUO9xPJiveLK3OScFL281JJNjMCATik41bqDcXVL+iFGSQ4mJVHeExt2RgvxJeWnV
  GYkFmfEF5XmpBYfYpTh4FCS4A0L2h0tJFiUmp5akZaZA4wtmLQEB4+SCK82SJq3uCAxtzgzHS
  J1ilGXo+3p9RnMQix5+XmpUuK89wKBigRAijJK8+BGwOL8EqOslDAvIwMDgxBPQWpRbmYJqvw
  rRnEORiVh3mUgq3gy80rgNr0COoIJ6IjfCTtAjihJREhJNTBaHRUpCrZh27BS4/aq2QHfunR+
  FnTMYqzRPaQd9OXvC8cmf0+VOff2TO27f3S9wiyOOQfWXI/mPXJIpiKZv0xWWLmqdSOvc4DvT
  M2UZ85L1yx6rmay6MOMDw9KqqffcAneWph75Z5WvubnyoMh2yttz+x4PSXr5IHAMx95f3u975
  q4uVT2UVCwEktxRqKhFnNRcSIAcSJ8J+4CAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-10.tower-302.messagelabs.com!1539003241!344230!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31405 invoked from network); 8 Oct 2018 12:54:01 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-10.tower-302.messagelabs.com with AES128-SHA encrypted SMTP; 8 Oct 2018 12:54:01 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 8 Oct 2018 13:53:59 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 2D56E3FB79; Mon,  8 Oct 2018 13:53:59 +0100 (BST)
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 8 Oct 2018 13:53:59 +0100
Subject: [PATCH v2] usb: typec: tcpm: Report back negotiated PPS voltage and
 current
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <support.opensource@diasemi.com>
Message-ID: <20181008125359.2D56E3FB79@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 08/10/2018 11:03:00
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
Changes are based on usb-testing (e7a2c3fa2857)

Changes in v2:
 - Rounding down of PPS voltage and current values moved to relevant API
   functions so stored values are correctly updated prior to all subsequent
   usage and decision making, as discuessed with Guenter.

 drivers/usb/typec/tcpm/tcpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b06eac8..dbbd71f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4113,6 +4113,9 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 		goto port_unlock;
 	}
 
+	/* Round down operating current to align with PPS valid steps */
+	op_curr = op_curr - (op_curr % RDO_PROG_CURR_MA_STEP);
+
 	reinit_completion(&port->pps_complete);
 	port->pps_data.op_curr = op_curr;
 	port->pps_status = 0;
@@ -4166,6 +4169,9 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
 		goto port_unlock;
 	}
 
+	/* Round down output voltage to align with PPS valid steps */
+	out_volt = out_volt - (out_volt % RDO_PROG_VOLT_MV_STEP);
+
 	reinit_completion(&port->pps_complete);
 	port->pps_data.out_volt = out_volt;
 	port->pps_status = 0;
-- 
1.9.1

