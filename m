Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682493-2-12195476858107421822
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682492; b=ICRiVC+UV57cmlv5farZV+qc17xpy3by9CPhL99CG1NMJvp
    R08m5jeAzzZoUBGpjoQ2SgxCwLBPAwpYIeeBu3sCwrAnHHyG7E2QhFfz8FPdo4Rd
    UYVNAoxLU6L+EvcauGbdetY+p9SPOzKfW9HQq+N2l0XNePxFjGs806xNM+IIBr5m
    VvtbUa8JdJ+T+UDFmi7j52KBpzvkGmXheKMiK398tEuGSggtSIgq8MAvOT6jm7cH
    pAdxHb/u0NhZUAm3FpvY06GpLuqbcZ4YutUPZvVA5zrdlIYhWxdysp92Am6V61co
    EPFTFQgBQUNGlyu6puE8ftmPaXqu5MfnMOb17gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682492; bh=FaLwfX
    4BzormDuOd5QxJoHMI4j1BxYGqBXbZLvHIKEA=; b=PY7Uj11AkvlvrRDnh9n8bT
    SYWNrrKhy+0HVkutAO1APZOOkMNrSoRHYyxEc1DkLLa4lBQqxy7+da9YRKh9npyP
    M5OwepBZsnhtzt0QnpqpyILhk416mvHYPRGR+ULxjAqhTtN+baCC38j8HHYlHiyz
    ay9cam6yF0noG6qihjilk3GkGwG6tIU5tkqnxcLKhfMJVRH8AYM7bNxmupLxZt18
    FBEb4Z3iLbKBs626K4DELHqtfhYfaJy8tA8+/fEM1nN70KdTP5l0bff0jm+0dT/U
    J32E5llpAWNivI7Oh7K4JO2C9iFFUQnqXZL2I2DSxizDaRjxv96DBPWDZrS24wKQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=md3SRhDe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=md3SRhDe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754081AbeBCS2G (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:06 -0500
Received: from mail-bl2nam02on0109.outbound.protection.outlook.com ([104.47.38.109]:45293
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753039AbeBCSFA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 094/110] leds: core: Fix regression caused by
 commit 2b83ff96f51d
Thread-Topic: [PATCH AUTOSEL for 4.14 094/110] leds: core: Fix regression
 caused by commit 2b83ff96f51d
Thread-Index: AQHTnRkDfUnjDm9BfEW/CBSMf+PRKg==
Date: Sat, 3 Feb 2018 18:01:28 +0000
Message-ID: <20180203180015.29073-94-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:tt3oQfYjUD7IBr1+evj2t2OrLRgHyKcW8w1qvEj6bFaDJEf0gwrhgj8CU2DiS+ktKduJ95p1bsXm6ZfFObFuQDvO4xML77kFor0TOqdWSY+LFKI3cHFU6Wh93v3CsVCoar8lTCnn4P/WwSLOGen3xgsGSCJeUVmQBtp3l15MkepTxXz/6qRekdmhnNbAORwolfFglAWDueTpgaYK1oeenHUvkVBk9ac1KYU48lED8LyXCtzlO+uZcdNRbpC5Oi0T
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 214a1a50-65e7-42c3-fff4-08d56b3055bb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB104169C670515163700089EDFBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(39060400002)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(86362001)(6436002)(6486002)(22906009)(98903001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: DqxZpaODTRY2K72lLzDaYvA3XnHRufh1eegJWR7gISuMc425XoSzh82LJCtxufWDGnUfv2itgQfJNjDJM5FwAA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214a1a50-65e7-42c3-fff4-08d56b3055bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:28.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jacek Anaszewski <jacek.anaszewski@gmail.com>

[ Upstream commit 7b6af2c53192f1766892ef40c8f48a413509ed72 ]

Commit 2b83ff96f51d ("led: core: Fix brightness setting when setting delay_=
off=3D0")
replaced del_timer_sync(&led_cdev->blink_timer) with led_stop_software_blin=
k()
in led_blink_set(), which additionally clears LED_BLINK_SW flag as well as
zeroes blink_delay_on and blink_delay_off properties of the struct led_clas=
sdev.

Cleansing of the latter ones wasn't required to fix the original issue but
wasn't considered harmful. It nonetheless turned out to be so in case when
pointer to one or both props is passed to led_blink_set() like in the
ledtrig-timer.c. In such cases zeroes are passed later in delay_on and/or
delay_off arguments to led_blink_setup(), which results either in stopping
the software blinking or setting blinking frequency always to 1Hz.

Avoid using led_stop_software_blink() and add a single call required
to clear LED_BLINK_SW flag, which was the only needed modification to
fix the original issue.

Fixes 2b83ff96f51d ("led: core: Fix brightness setting when setting delay_o=
ff=3D0")
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/leds/led-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index af630c11c284..9ce6b32f52a1 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -187,8 +187,9 @@ void led_blink_set(struct led_classdev *led_cdev,
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	led_stop_software_blink(led_cdev);
+	del_timer_sync(&led_cdev->blink_timer);
=20
+	clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
 	clear_bit(LED_BLINK_ONESHOT, &led_cdev->work_flags);
 	clear_bit(LED_BLINK_ONESHOT_STOP, &led_cdev->work_flags);
=20
--=20
2.11.0
