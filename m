Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA27C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACE020896
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACE020896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeHUPsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:48:25 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:31289 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbeHUPsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:48:24 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id 74/6B-19240-8650C7B5; Tue, 21 Aug 2018 12:28:24 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRWlGSWpSXmKPExsUSt3OpsW46a02
  0wfz5Bhbzj5xjtWhevJ7N4s3x6UwWXat3slhcO9bLZHF51xw2i0XLWpktniw8w2Sx9PpFJovW
  vUfYHbg81sxbw+ixaVUnm8e8k4Ee++euYffY+G4Hk8f7fVfZPHZ+b2D3+LxJLoAjijUzLym/I
  oE14/H+T6wFHewV28+tZGlgnM/WxcjFISSwnlHi/Ld17F2MnEBOhcSttVfBbF6BTInWbZfZQG
  xOAXeJB48WMkLUuElc3nwSrIZNwEJi8okHYDUsAqoSN99sAKsRFoiSuLpwFxPIAhGBSUwSN+4
  9ZQVJMAs0MEos3eEGsUBQ4uTMJywQcQmJgy9eMEMsMJA4vaARLC4hYC8x/f1VoDgHkK0v0Xgs
  FiJsKPF91jeoEnOJI9vus01gFJyFZOosJFMXMDKtYrRIKspMzyjJTczM0TU0MNA1NDTSNbQ01
  jUyNNRLrNJN1Est1S1PLS7RBXLLi/WKK3OTc1L08lJLNjECY4sBCHYwLr+QfIhRkoNJSZT3XF
  p1tBBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3nvMNdFCgkWp6akVaZk5wCiHSUtw8CiJ8IayAKV
  5iwsSc4sz0yFSpxh1Of68nzqJWYglLz8vVUqcVxykSACkKKM0D24ELOFcYpSVEuZlBDpKiKcg
  tSg3swRV/hWjOAejkjDvI5BLeDLzSuA2vQI6ggnoCHa2SpAjShIRUlINjBY3Vn+T3cOqvipfx
  mW98fqyjqaIzQu03k5QMLuiMq9Gd5X3y40dubu2rrCxry12vnZvt06Q++pItc+lUhOntXbsCG
  Y1Ff+azCqe0/9vgol78J+TntqrD/F9OcP7+er6n4opfcvFbjLzuepP/X/VZLvUiiOHPux8/Pj
  78vtnNqx1bFWv43FdJ67EUpyRaKjFXFScCADLOgcAMwMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-19.tower-268.messagelabs.com!1534854503!2532127!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11290 invoked from network); 21 Aug 2018 12:28:23 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-19.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 21 Aug 2018 12:28:23 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Tue, 21 Aug 2018 13:28:23 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 406C33FAEE; Tue, 21 Aug 2018 13:28:23 +0100 (BST)
Message-ID: <5ab35968fea28abb54326423523af38dd887ddcc.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 21 Aug 2018 13:28:23 +0100
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
X-KSE-Antivirus-Info: Clean, bases: 21/08/2018 10:54:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This update populates the tcpc handle's fwnode pointer with the
child usb-connector node, if it exists, so that TCPM can perform
generic property handling to define the ports capabilities.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
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

