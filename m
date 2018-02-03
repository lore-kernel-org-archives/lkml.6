Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682867-2-1372778361492333978
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
    t=1517682867; b=ge1NUwBRSha6n0J72R6WSvEctAIMK27wlD8TB8yLd4Rz6FB
    Mw+qtqwD55M/mar1gTRAKT+jXsjYxpf5erIjjgC43JnSQ86QyCcJbASeo9gvIXUn
    l6E833MlvcfwGNniYVl94GAmIjtQjxZZEwSoPLYnN4CfKLjZesOK7Q0caSBJiXYc
    hdcDVG4yclByRO80DDVaKaWlxl/pHvu6HLbi2B3xdsVDUEa5lSZSijnFfToaTQ6o
    bV9HVsHWxTz9uyrivdC4rJlnfFtq4h58ftn7IBp+4QB3smIoTt6ilQTAs4w4PUgq
    buN/VbP7uj1Z5UqDx5NMShPbOhDXrZGUEv+gpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682867; bh=/fR45M
    VN2GzmKi701ZI7Q4uhKjobPQSYOkkjYj58Gi0=; b=IXKpkpATGsk0oXUq2SshYM
    UU7rAaPWmzBcogmLYzh/8cAARmkDub/AlvDDA9DtZIPYm18EpmrIZUBGIRdnveqO
    KTaBdsJLtfTpTGPb4cZa5jp6Ek7RYmMmB6cHQEY2jZWjlZ/1dtc3LJs+kRMoZPKU
    sju5jkcXos/687G0prPJRMk08DFyuAeRedu9fafSB8hL/ekRYQjlQ0LMvmrusxtT
    xiNyHuCB1nhWDtePmnUFnJDKrpsXeu591tEtC1bOj0bM67Z9cMCxHiGZVbPAmvba
    129VO+7qE9kwlRNAVkr3zUtwzgvF81Ha1MawXo+5bvAYwFUB90X5AGTDym3LDjrQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MArE0Zie x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MArE0Zie x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754453AbeBCSeX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:34:23 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:53600
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752788AbeBCSEX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 28/52] led: core: Fix brightness setting when
 setting delay_off=0
Thread-Topic: [PATCH AUTOSEL for 4.9 28/52] led: core: Fix brightness setting
 when setting delay_off=0
Thread-Index: AQHTnRlXKVeBnVVYEUSQKYnMdZ3pmw==
Date: Sat, 3 Feb 2018 18:03:49 +0000
Message-ID: <20180203180303.8490-28-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:qMFYq1shVZviqN9fODTB8V+TqrhH/S7nmNroVU9iQdotwbQOr77qx62buaSL+UooYx92KdSa6cm83SPe59Q908bG5Lk7Ft/SinklpCpWJK3zNWZBfxLxTwASV60j1jwAe1FbrM7oUkRGwe8LLri74Je8yXG1LaEzxc9AMzvMuJ7KQIAjUEAq9fKPtqgK1XZHQYvc9TFddpSkayxEhisDZOtnDYQeOi4xb9ru4E3iK62hmJCIaXgqHF//gLByjYA0
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d550fbd-7e77-485e-bdff-08d56b307a23
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB1012A3C3BB5F9E0A85B3975FFBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(575784001)(39060400002)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: ZWMIGIUdIYsoxHCIEu5lueHnRlphcEy1NxTOY63dgi8hFqVim/GtwdzUC/0pKBoycGkMtLiGWZRZps49xor9fA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d550fbd-7e77-485e-bdff-08d56b307a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:49.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
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
index 3bce44893021..d70d4a5273b8 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -186,7 +186,7 @@ void led_blink_set(struct led_classdev *led_cdev,
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
