Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D868C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7882087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7882087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbeIJRNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:13:18 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:40552 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728126AbeIJRNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:13:16 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 9A/D0-21173-D41669B5; Mon, 10 Sep 2018 12:19:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRWlGSWpSXmKPExsUSt3Opsa5v4rR
  ogz1XNSzmHznHatG8eD2bxZvj05ksulbvZLG4dqyXyeLyrjlsFouWtTJbPFl4hsli6fWLTBat
  e4+wO3B5rJm3htFj06pONo95JwM99s9dw+6x8d0OJo/3+66yeez83sDu8XmTXABHFGtmXlJ+R
  QJrxvXte1gLvrNX7DrwhLmBsY29i5GTQ0hgPaPE3nnqEHaFxOmJn5hBbF6BTIn2TwcYQWxOAX
  eJd9NOsEDUuEk0bV0KFmcTsJCYfOIBG4jNIqAqceriTVYQW1ggSuLqwl1MXYxcHCICk5gkbtx
  7CpZgFmhglFi6ww1igaDEyZlPWCDiEhIHX7xghlhgIHF6QSNYXELAXmL6+6tAcQ4gW1+i8Vgs
  RNhQ4vusb1Al5hIzV89jmcAoOAvJ1FlIpi5gZFrFaJFUlJmeUZKbmJmja2hgoGtoaKxromtkp
  JdYpZukl1qqm5yaV1KUCJTUSywv1iuuzE3OSdHLSy3ZxAiMrJRCFrEdjBeWph9ilORgUhLllV
  CcFi3El5SfUpmRWJwRX1Sak1p8iFGGg0NJglczASgnWJSanlqRlpkDjHGYtAQHj5IIby5Imre
  4IDG3ODMdInWKUZfjz/upk5iFWPLy81KlxHmzQIoEQIoySvPgRsDSzSVGWSlhXkYGBgYhnoLU
  otzMElT5V4ziHIxKwrx/4oGm8GTmlcBtegV0BBPQEevOTwE5oiQRISXVwBi4RflQha9AZmfRk
  scxFaeLProfP/t8o5HDvq79wv6Xzxzmb1PjbDzKHW4fdz+Ir33Lk4+7eX/sOfvab+7+GsVdc7
  8wvWY/KOVz5LK+qNCa+QVyB6rVkzkWmr6XON7HNYXZMFDpgkmV/1F1Kff4X4tfGzEIsf6eGVe
  QwnWhkCOk+E4vO//9BCWW4oxEQy3mouJEAIKPLCwyAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-5.tower-239.messagelabs.com!1536581965!4707624!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15289 invoked from network); 10 Sep 2018 12:19:25 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-5.tower-239.messagelabs.com with AES128-SHA encrypted SMTP; 10 Sep 2018 12:19:25 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 10 Sep 2018 13:19:25 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 1FE233FBEA; Mon, 10 Sep 2018 13:19:25 +0100 (BST)
Message-ID: <3005ce7723546a48dfad529ce396033a973664b3.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 10 Sep 2018 13:19:25 +0100
Subject: [PATCH 3/3] usb: typec: fusb302: Populate tcpc fwnode for TCPM
 property handling
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/09/2018 11:14:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This update populates the tcpc handle's fwnode pointer with the
child usb-connector node, if it exists, so that TCPM can perform
generic property handling to define the ports capabilities.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/fusb302/fusb302.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
index 82bed98..1b464c9 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -1736,6 +1736,9 @@ static int fusb302_probe(struct i2c_client *client,
 	chip->tcpc_dev.config = &chip->tcpc_config;
 	mutex_init(&chip->lock);
 
+	chip->tcpc_dev.fwnode =
+		device_get_named_child_node(dev, "connector");
+
 	if (!device_property_read_u32(dev, "fcs,operating-sink-microwatt", &v))
 		chip->tcpc_config.operating_snk_mw = v / 1000;
 
-- 
1.9.1

