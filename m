Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681000-2-3096954169108942790
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
    t=1517680999; b=VkI5G3LvJvGvBf0tk83XLUOsR8RJHhJxJVXs4nJNEbDZEfb
    0qDYjNO1S6CHaSi9dXJKIxoTtWhyUQxGXlHFOGpeV+9BkYDPgwk3VSPSUTmeeZcI
    3vq7TW1dp8I6IptmejjzQy65K3NZlfyTBmz8RD1HDiES8VstPz/XGzakyZ8SZmr6
    GyYOkvxEwtHyXJGqQkhYmVNDW94dtcEJNOcaPMsP9BwTeVLhroABhrCRpHqa61RG
    P106GAD/iWdrle0ta24cUlmzq9MjjyFxPXGlCeSM8rg4PcbTyQ56SvWlKN7G8Ozf
    EpKWG5W+UVL0Hv3kFZaeJb0k/GwMWSUxDZYv06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680999; bh=M91UX0
    U2DadGGaqAPUTF5W7Py21jhq7mghZxJI7fcG8=; b=Rcikr+jiemcxrcjqCw56Ae
    ZOHdAxtoEvctuhnYayJhwc2tUo7tISiUmada+tzKcgdbmuV4D3/yoogTcOzsKuvC
    5xDaY3S3IjKk8yzJnHBYjAZG/FvCko+ktzdRLMs80gGhuPjWimYErr7sNgRF85Kb
    p/v5ZHRmVBtcltDo8Z5rm+Ea3P4DVICC3Uh4dgajaGRADOKL/Nom9cZpFi8IkoMR
    pOziU6+rY/jsBDxfcQha0cTDwA+zRDPvWkOR24R3oMi9ZcxGephhnpylUmXVTcAp
    J84box6oRnuQyB/taWeNppQ894qrclkG25qd/xUJS7Q+LyxwriEEjN/8RmC6YRfg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jpvoSmGG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jpvoSmGG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeBCSDR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:03:17 -0500
Received: from mail-bl2nam02on0115.outbound.protection.outlook.com ([104.47.38.115]:21822
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753038AbeBCSCJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Torokhov <dtor@chromium.org>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 067/110] genirq: Guard handle_bad_irq log
 messages
Thread-Topic: [PATCH AUTOSEL for 4.14 067/110] genirq: Guard handle_bad_irq
 log messages
Thread-Index: AQHTnRjz3GDEVRhlgECezaLSKuHfBg==
Date: Sat, 3 Feb 2018 18:01:00 +0000
Message-ID: <20180203180015.29073-67-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:XJQ7R0dM1pD/em0B7rwWsGhILSyq3taEfLDS+5U1M3DsTibBYxndW+MpZM0Brj0dOQ26R3rodJYFsVDArWhqpb7n8N6q8KsbLyzosxQuX3Dhm1F9gAv5Jo/b0ZVpDCUvCan5S7bszboXlH6ZC7/3t1VJBDN9PHcqqrNfCjh9Z1UpkxU9uHUq8j8gSDVqt+AQ364+26SiP7FLPBm6sCDZi1rjzZAwrBY9kzZnLe7BgFi3xqHn3ry0Ush3duKSq6i6
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9c63203-ae4b-4236-72ae-08d56b303c2b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB10413B500B52F772974528AEFBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(15650500001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(966005)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(6306002)(575784001)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: TdLqpyTZBLxL7BdyU5KoJOsM8nwm/ObZL4JBQSIJygAjf4cISbKdV0J3qgGhIooBLfo6zUfYt/9Ahnbqw68y3A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c63203-ae4b-4236-72ae-08d56b303c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:00.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 11bca0a83f83f6093d816295668e74ef24595944 ]

An interrupt storm on a bad interrupt will cause the kernel
log to be clogged.

[   60.089234] ->handle_irq():  ffffffffbe2f803f,
[   60.090455] 0xffffffffbf2af380
[   60.090510] handle_bad_irq+0x0/0x2e5
[   60.090522] ->irq_data.chip(): ffffffffbf2af380,
[   60.090553]    IRQ_NOPROBE set
[   60.090584] ->handle_irq():  ffffffffbe2f803f,
[   60.090590] handle_bad_irq+0x0/0x2e5
[   60.090596] ->irq_data.chip(): ffffffffbf2af380,
[   60.090602] 0xffffffffbf2af380
[   60.090608] ->action():           (null)
[   60.090779] handle_bad_irq+0x0/0x2e5

This was seen when running an upstream kernel on Acer Chromebook R11.  The
system was unstable as result.

Guard the log message with __printk_ratelimit to reduce the impact.  This
won't prevent the interrupt storm from happening, but at least the system
remains stable.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Joe Perches <joe@perches.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D197953
Link: https://lkml.kernel.org/r/1512234784-21038-1-git-send-email-linux@roe=
ck-us.net
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/irq/debug.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/irq/debug.h b/kernel/irq/debug.h
index 17f05ef8f575..e4d3819a91cc 100644
--- a/kernel/irq/debug.h
+++ b/kernel/irq/debug.h
@@ -12,6 +12,11 @@
=20
 static inline void print_irq_desc(unsigned int irq, struct irq_desc *desc)
 {
+	static DEFINE_RATELIMIT_STATE(ratelimit, 5 * HZ, 5);
+
+	if (!__ratelimit(&ratelimit))
+		return;
+
 	printk("irq %d, desc: %p, depth: %d, count: %d, unhandled: %d\n",
 		irq, desc, desc->depth, desc->irq_count, desc->irqs_unhandled);
 	printk("->handle_irq():  %p, ", desc->handle_irq);
--=20
2.11.0
