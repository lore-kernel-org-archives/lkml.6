Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682510-2-574219807724125657
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
    t=1517682510; b=IaXOpCBLMRUbTqckRlshO3AxJencYg9gmp/Ple8Ty1r2ICs
    D82tjlYfLSw95Oms7m6w382+MKnkwRCP3Az5BK5T+VrK62dWmHgZQhOdzGgSS3PE
    RaS4ODeXorrM2IyLwtTvK6flS/GNeL2SA9fcr9t8Ed7lQrPWFpK1YQPfthebUli+
    NMG0C/fVwpL3EW8vshxfDlC578aG4Na0ukl3iJL7Ubn2CZGhyMhyC0I4x22rBM5v
    yn3bL2WTzXGH5q6rdtJaIN891Ceh3kgzQ9wJC8V2R8OW1iU38t0NHlax9wsC4F+g
    w1V1uVvKq+dlO+7lmipV5X12MCFXkRT4+LSq+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682510; bh=R/DdgZ
    eU63mGtS+qMKGnh5VD/lIhD4wEAzr5lmFlCKk=; b=WZ1LpU2l5Ro03UeT89pBII
    wtFPjNMMX9Lps4lyAdIqJdf5bS+SUiXNML/HvI7tMNKREtMYJUn7/6rZ58bTgA+0
    C5tqsQ7+/Llw11Efs5o/YZOApt19c+GJ1ILR18UTWpvk12lU7Gbm2Dk45FNYahMl
    KA+5ZZjbbJOdCw5w4H97HCUaJ3tYXA4h8jJe7f3ko6FbOliiTc1Vw5W2BhkJgTT0
    UrLiTJlxKylFhYSjLVYp4HDw0RnoM5I6AczwkLWVgrHRX96eWWYymhpKJwn3cP6X
    aF0JkS8ZKO1r+tmfyfQf/3mED9811q4LZxuLU2YO5pjdpmL1iqVEk+PqH8K2a4Og
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P2cqz7u2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P2cqz7u2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754407AbeBCS20 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:26 -0500
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:50832
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752712AbeBCSE6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:58 -0500
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
Subject: [PATCH AUTOSEL for 4.9 30/52] genirq: Guard handle_bad_irq log
 messages
Thread-Topic: [PATCH AUTOSEL for 4.9 30/52] genirq: Guard handle_bad_irq log
 messages
Thread-Index: AQHTnRlYAN9JJ8WYOUCRCmngo0gxhQ==
Date: Sat, 3 Feb 2018 18:03:50 +0000
Message-ID: <20180203180303.8490-30-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:rtpRTOwBC75p9LpLGLzVMWG80emJ0KIKtwjvJti6uvULGiX1fUy83MSIw7hTlNVuLyn5nVPSSb7VZpVobrsqLW65kft9Vof8DgyCFYbbui+x9Gup/asoy8Ce4qz3nZ36ixFN6VhcBVgQn9u5cmr1RVCVSKdlVDU2tZ+RDygAyO7Of9f5fs/Vj2peHZr+Rzp/cCPvad2iJVSR13MIGGzbimlZCv4afasNSIO5HYT3zOFvUkPCRP5P5Mk5hRGdBANk
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f61fa90-3ebf-49f2-404a-08d56b307ac8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB101253DEB73F5CFE3A2B5AF5FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(6306002)(76176011)(86612001)(86362001)(575784001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(15650500001)(478600001)(68736007)(14454004)(5660300001)(966005)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: bIyskL/n8eBcygTLKqXJ2kiFoemHoLPLoI81ZGUrmcR6B90yQ0XGOArsx1pfnRlKYSZW9inRIyjYUrZduVx06w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f61fa90-3ebf-49f2-404a-08d56b307ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:50.3776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
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
index e75e29e4434a..3514d955af94 100644
--- a/kernel/irq/debug.h
+++ b/kernel/irq/debug.h
@@ -11,6 +11,11 @@
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
