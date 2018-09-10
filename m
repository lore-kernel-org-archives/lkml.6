Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7673AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C18F20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C18F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbeIJRS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:18:27 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:13769 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727727AbeIJRSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:18:21 -0400
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 9F/87-01664-C72669B5; Mon, 10 Sep 2018 12:24:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRWlGSWpSXmKPExsUSt3OpsW5N0rR
  og965Whbzj5xjtWhevJ7N4s3x6UwWXat3slhcO9bLZHF51xw2i0XLWpktniw8w2Sx9PpFJovW
  vUfYHbg81sxbw+ixaVUnm8e8k4Ee++euYffY+G4Hk8f7fVfZPHZ+b2D3+LxJLoAjijUzLym/I
  oE14/r2PawF39krdh14wtzA2MbexcjFISSwnlHiRPsSti5GTiCnQmLzigXMIDavQKZE+6cDjC
  A2p4C7xLtpJ1ggatwkmrYuBYuzCVhITD7xAKyXRUBV4k7HFiYQW1ggVuJqw1FWkAUiApOYJG7
  ce8oKkmAWaGCUWLrDDWKBoMTJmU9YIOISEgdfvGCGWGAgcXpBI1hcQsBeYvr7q0BxDiBbX6Lx
  WCxE2FDi+6xvUCXmEjNXz2OZwCg4C8nUWUimLmBkWsVokVSUmZ5RkpuYmaNraGCga2hopGtoa
  aZraGasl1ilm6SXWqpbnlpcomuol1herFdcmZuck6KXl1qyiREYWykFRxbvYHy1PP0QoyQHk5
  Ior4TitGghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErxyiUA5waLU9NSKtMwcYJTDpCU4eJREeJV
  A0rzFBYm5xZnpEKlTjLocf95PncQsxJKXn5cqJc4bAVIkAFKUUZoHNwKWcC4xykoJ8zIyMDAI
  8RSkFuVmlqDKv2IU52BUEuZdADKFJzOvBG7TK6AjmICOWHd+CsgRJYkIKakGxn7WLVb+thlFh
  xw99FiuFXOa/9I5KZYcvFCiX8KpXOPxl6Sgs+2req6YqeZpf+19dfv9nZaOS46RW7fMu9ogXO
  TMsEowcGd+/q/zccH7mGxPL5sudf6Z7cmeu15CT65dj5vY+lvMPN9XoiX2rv+ELQHBXdk+7Ez
  b0tn7v87M9m3srtqUUaWqxFKckWioxVxUnAgAPJoCCTMDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-24.tower-282.messagelabs.com!1536582268!6826374!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18854 invoked from network); 10 Sep 2018 12:24:28 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-24.tower-282.messagelabs.com with AES128-SHA encrypted SMTP; 10 Sep 2018 12:24:28 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 10 Sep 2018 13:24:28 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 0DB683FBEA; Mon, 10 Sep 2018 13:24:28 +0100 (BST)
Message-ID:
 <3005ce7723546a48dfad529ce396033a973664b3.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 10 Sep 2018 13:24:28 +0100
Subject: [PATCH v2 3/3] usb: typec: fusb302: Populate tcpc fwnode for TCPM
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
Message-ID: <20180910122428.MMEhPco0LQVmP8B5FcTF0p_3pTnXTluv7NN5ZL2Cs_o@z>

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

