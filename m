Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681774-2-12756038657541665948
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681773; b=s2KYpdBqIaC72KzdMuGGHIUsy+hJsP0ebMoBbLKvhx0S8cf
    BIVEGhp/bV3zyfpqxbCdJO4KldYwImVtv1CiTUFQaLdrN8idkT+fFPA9xE7taScw
    dze/UfNcNRFAebyXGGkWwLzm50XMi9fCktmX5kq5V6U2gaFR0dP/BHFC1n/sIoGV
    W3C1Yd91SJTYHTB8gsozpkA7dnce/Gt1ry+XuUbP8fc77fd7s6uIB1EU34QWnWpV
    9k4zfIGUgnPKkh7eMZkwvuPe6JZbYd+M6YadPGCmQjBEnGbv4HN80Y1w8IYbldm6
    coFPOrPR7KBLeQ6+VIt1xppzPf8X4RCSQ4giBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681773; bh=o3tIj8
    N+PX0d73AnHCahhoRnPfaTfbxH3u7la9eR4u8=; b=t3LFk4lfpoHJTyyeDpXiu4
    Hof/9yyye0Cqlk60Z37f2QaIWxf0GWia9yoSm+2TF6afgI1n9LDGypRc8oLGG+XI
    tGZj8IB4zcmnwc22BYbUWFJRfzNlD1+pyTFCwTjzSJ7s0t7/DWxxIAqsCWMXz91R
    MjSwMS5VWkDMuz6mh4LgXt5N7kGA6UeFBsDWRJdy8Q/bt71mUycYtArptAgoeaBF
    v55FZ5+rqWA+0oaQohgWbV2pUojdM/B7huiym6PqSEQIplfJsYJ6otTsTEVD3fit
    ksjdAuCGzWiTNVMHYIDPPOXbSmyCCedUMkPvvD01VX1kPtLRspxdXIV8HQiaLziQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N6d39aOc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N6d39aOc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753782AbeBCSOv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:14:51 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:45338
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753543AbeBCSHP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 11/24] led: core: Fix brightness setting when
 setting delay_off=0
Thread-Topic: [PATCH AUTOSEL for 3.18 11/24] led: core: Fix brightness setting
 when setting delay_off=0
Thread-Index: AQHTnRmE1eqLbZMTvkOjEnsPtJz89w==
Date: Sat, 3 Feb 2018 18:05:04 +0000
Message-ID: <20180203180444.10801-11-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:VhYLtPjTVYEZZlgt6Pa4bXnizNb0oqbcoMoh9cvJxeoHTXIvE/tZhdOXbm8QyGu2p1rhgnzCvu0nRTAPXuVv0q9bFJcoOa4Q3gpFfELIYw2XBaO+AqVJng1e5R4w5UAUgk7ow2j891dbUI/o0NZzwjYB2dPGxuabsMhxuUu+ELNMU7w3ozoAKXix7XuZ1Kd80Vv2W/dWeT8lRsUkm8OmR/jdmSVlUcObEqam7CZKuYVA/MR6bGfGU8vi8wTlmlF1
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 828cadea-91cf-4b88-9c68-08d56b30dfe0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993C567EEB7BA515809BF2EFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(39060400002)(54906003)(110136005)(66066001)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: gDrmydoodRkCY3PHwrWYayrynL0v/iTR/4S7tzMlGUWzrsY8y8rAZ1DQB4xUAqct1s7PRjLJFpbpcYpJIlqgZw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828cadea-91cf-4b88-9c68-08d56b30dfe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:04.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthieu CASTET <matthieu.castet@parrot.com>

[ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]

With the current code, the following sequence won't work :
echo timer > trigger

echo 0 >  delay_off
* at this point we call
** led_delay_off_store
** led_blink_set
*** stop timer
** led_blink_setup
** led_set_software_blink
*** if !delay_on, led off
*** if !delay_off, set led_set_brightness_nosleep <--- LED_BLINK_SW is set =
but timer is stop
*** otherwise start timer/set LED_BLINK_SW flag

echo xxx > brightness
* led_set_brightness
** if LED_BLINK_SW
*** if brightness=3D0, led off
*** else apply brightness if next timer <--- timer is stop, and will never =
apply new setting
** otherwise set led_set_brightness_nosleep

To fix that, when we delete the timer, we should clear LED_BLINK_SW.

Cc: linux-leds@vger.kernel.org
Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/leds/led-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index aaa8eba9099f..0633cf033645 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -76,7 +76,7 @@ void led_blink_set(struct led_classdev *led_cdev,
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	del_timer_sync(&led_cdev->blink_timer);
+	led_stop_software_blink(led_cdev);
=20
 	led_cdev->flags &=3D ~LED_BLINK_ONESHOT;
 	led_cdev->flags &=3D ~LED_BLINK_ONESHOT_STOP;
--=20
2.11.0
