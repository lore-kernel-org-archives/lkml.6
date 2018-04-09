Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245394-2-17325161153770878429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245392; b=h/SDhdgZZ8Q4tww+7KJzUu9Y+KoioRLOh/I6mfqNLJZhj8chWV
    +wLmoQk0pQRs+XiROLwR1+wjl+KYCR8emSXHuvJoTWGGEmE+oW+VdfRwcvvVgBXI
    NsA+lStgN97lPwmI7pECHS8Q8n5d8KijESnRZEDRl437mlw8QAOVIPZgRjBlfGRt
    4XDBYR0A0Czt6LnB9YG5+q18oNMwq610PxhxmmtFtNOVNIp+vE6dPnjgM654yspR
    p3VcmTR7jR0rKk3Qu8Ub6v7CyunIyF+HRmvKCehGj8MoEHTUNHeQ1rvow69xK80T
    fxNdtbNIDXiyq685dkEAuSG8mMM8A42jcwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245392; bh=+/Dqa7FbR5
    j7K1LjP7egbAkmgRZyQcZi79+r1TCp51U=; b=NOibLFEgDcbH5shaBOtwoknw3O
    YFBZhnTQ18e7sqpiT8VvRkhxX54bTKzK4KQCMrNsdCh/ztB4HTJZk5pGgCJ9hJNq
    w7Wbb1zLBhgOoS7Qmnv9GDUovUTXvcc/gd/eF9yRN4m79+UzImskKDpBvTGhKBta
    DILDfDtbKA75aUQaCmFi4Vs05NLTLGHoGZL+AGfUoTq42smzE1A5DBY/XWzFojfk
    di8dI0fDFfDt0cCsT5mVfoEGK7lHQ/HgS8xVEaUnDPsnMsK1kkjxrfl8DfXcvX2T
    bLc5WioxTD4cuTJjEPqwRWuLrYtq/D7ZPO3ZBNNyrRwQIkQl5oe+NFXr5VDQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RhDNc/6I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RhDNc/6I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNdIiAY3NGQSbr6T67JFe8nNrhIlVovC3lXDgrEdQ/7XRs09QVZYYGXy2PHTLvvwyN34BmdcVxboMvSvNZV3ljeOFiJlQ/jiSn6SOXceXFJ3vc6ihI37
    f0Ufoa4Lbu7ScceRx0SHU5icnhIaMr5inV1iMi6opWSdBOJAes8ep+6Rcf28+hVYWavoTmY9QymA/H3RpnoVUmJdP9I3Hg/oJonYEGnv+nVeZN4iRZxE35Qh
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gPJu0pBYAAAA:8 a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8
    a=yMhMjlubAAAA:8 a=K82gfHmz9ML5UqyqUwAA:9 a=wPNLvfGTeEIA:10
    a=AlIIF0cMT2hfDT4axODj:22 a=AjGcO6oz07-iQ99wixmX:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeDIDm4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:42:56 -0400
Received: from mail-dm3nam03on0097.outbound.protection.outlook.com ([104.47.41.97]:45238
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754259AbeDIAUf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 148/189] MIPS: TXx9: use IS_BUILTIN() for
 CONFIG_LEDS_CLASS
Thread-Topic: [PATCH AUTOSEL for 4.15 148/189] MIPS: TXx9: use IS_BUILTIN()
 for CONFIG_LEDS_CLASS
Thread-Index: AQHTz5hTmFysGteWY06iOgBmMm3SuQ==
Date: Mon, 9 Apr 2018 00:18:47 +0000
Message-ID: <20180409001637.162453-148-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:FkiO9iBfy6RtuZ2TCkFDKL/WXMXcwIwyjhARsqWhByc05ATuh0sus6YgzEPua4sAOW1InGQhK6sMktK3XmrmCMMNUpR7gObI5RFZYHUr8jJu5XVemoMWkGAd+w79VJ4dRwpLhmTE95KBSjwgqD1sXZFalqXC1NDbQ0cViXIDlgABKpe3PM11lSXpGar9YNBo2dqJYvMyEHs793Avkmnfkkrwrszws0rXE0oonr0lMXcGI52eYkJK2dww9cXQmesl;20:JH09718h7w0YRDkRo+czdYAO6XuzmeBeZzO6NFDhMTeej9xiqzpx29N4BgRcoN9r27Rnj2K4n696COoOQfpIYdWvHhhC0icuqnMFDpRY7gPVF15/sojF8NZA/cXnXGA5YMkKHkA1FHQcLqA68exRrguYopZz+5XJEuVtFoHaO/A=
X-MS-Office365-Filtering-Correlation-Id: d5360f1f-f4f7-4115-21a4-08d59dafb095
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920C1F1D2DDB2F4079E4121FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(6306002)(5660300001)(478600001)(6436002)(105586002)(10290500003)(966005)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6NZFQ9u86Df4dsRnZW1gtKLb5FUGa2twRs7DuPmIXDdBZKdF/pDCRcbLAl41yM1jPkEad7U0SfyFtmotYrwACuEjJLI6cW5+y5rvUl6mLEjOixYXZSnmPPEAkT9Lc9LjNkGwNBLETSDjP8LIhTaA6U8AaSQeniMKxWjp9gXlbFWIh7w6b8k7G3xHWpRMkhTsWxqGhXb7xToAlgzgls6kQFhQzV4OyBMgSMhgeMtMyWMfvVpRAwJ47QtrDh6m5e43espWe8qNgkFsZTADvcJTmBotmY2AQcH9l6ab2j6hkCVsoCjOfcQvaZZJlgBsPyF0c3Cu3azI7gczKguegP8imxAysBR4AEIoK4R5M9QQGzAmgXxqjWHIHuhd+6YB80B1cZgKsgeoeaM2EL0lcpKZjODxpdNEnupiv/F8x51C1aY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5360f1f-f4f7-4115-21a4-08d59dafb095
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:47.4561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matt Redfearn <matt.redfearn@mips.com>

[ Upstream commit 0cde5b44a30f1daaef1c34e08191239dc63271c4 ]

When commit b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
added board support for the RBTX4939, it added a call to
led_classdev_register even if the LED class is built as a module.
Built-in arch code cannot call module code directly like this. Commit
b33b44073734 ("MIPS: TXX9: use IS_ENABLED() macro") subsequently
changed the inclusion of this code to a single check that
CONFIG_LEDS_CLASS is either builtin or a module, but the same issue
remains.

This leads to MIPS allmodconfig builds failing when CONFIG_MACH_TX49XX=3Dy
is set:

arch/mips/txx9/rbtx4939/setup.o: In function `rbtx4939_led_probe':
setup.c:(.init.text+0xc0): undefined reference to `of_led_classdev_register=
'
make: *** [Makefile:999: vmlinux] Error 1

Fix this by using the IS_BUILTIN() macro instead.

Fixes: b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18544/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/txx9/rbtx4939/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setu=
p.c
index 8b937300fb7f..fd26fadc8617 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -186,7 +186,7 @@ static void __init rbtx4939_update_ioc_pen(void)
=20
 #define RBTX4939_MAX_7SEGLEDS	8
=20
-#if IS_ENABLED(CONFIG_LEDS_CLASS)
+#if IS_BUILTIN(CONFIG_LEDS_CLASS)
 static u8 led_val[RBTX4939_MAX_7SEGLEDS];
 struct rbtx4939_led_data {
 	struct led_classdev cdev;
@@ -261,7 +261,7 @@ static inline void rbtx4939_led_setup(void)
=20
 static void __rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
 {
-#if IS_ENABLED(CONFIG_LEDS_CLASS)
+#if IS_BUILTIN(CONFIG_LEDS_CLASS)
 	unsigned long flags;
 	local_irq_save(flags);
 	/* bit7: reserved for LED class */
--=20
2.15.1
