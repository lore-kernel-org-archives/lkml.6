Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238212-2-11760102792362260914
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
    1523238211; b=X+5CMM/5SREuF0xX9U/RCIEiXMBF2IE654gPpkmt6BQimEzKqi
    FyJgQgg6cYtWcXVspSI5/tddRpUeQ3SEbefd1srgjgTJmISja8BeJhbZ1GB2mLb/
    pFu672LagqVJ4KndipEvxdja1UdcZ5FCEnP+wpD9CYDh0eeFo5+pClAmQETlHpNu
    elG6lsT6PXlZotwmR0Z+0lB6CAX7Xp4J10W2ZKKW0+v4qXx1hKXxA2s+/6A36fpv
    tTJvxXVzOlORs1UpnA9feV4fBfBQNS9Yur5ISgiOstOwY/ZKSD1FBAoADmRpqHXx
    uDq30r4JxXlm6GWC/utjlm/pCziHABoHvDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238211; bh=+/Dqa7FbR5
    j7K1LjP7egbAkmgRZyQcZi79+r1TCp51U=; b=wFY/xzDVydeEvuSElceL1Xt0Jx
    D7TP3B64vfixdHuBTVrg97yV4HpAYvanRwaeOUJlSEbRXhgZDm/uhbYUL4ySb6dQ
    V00oxhQHK3hSjIyEDn0KRszZ4pDzfD2DEwzMkJcDKUh83pvHIb9yKC7xhb/jmUsM
    INOCfwRKmfZJYovf3YJ0gMn9MicwJ925tCMlDUwEFzsH+qamDIdpPHTw0uQh+sOP
    H6RIKwxaMPTCJQpnFVyzgD3sGdKduij2fjd/Zwt8BxT3IXJDmLrC+LKhNq8UawmA
    cGXlRHD8FYNary4KRTamkgcSEWaahoUoRCSYxDobgmpRqJPalnfohhQ/vz0Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GRzzhYSY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GRzzhYSY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB/Mvic9oFr85Wo8lPdTIlCj1kyu40KKH/ax6XHyyJAugioZKVx95R0Y0+uXJ11GMTVUWmMZJNMUaE4+oUHIwrdKZAQbjAAjsu40afplE5MSYGcZzeJy
    L48P3wTMoNo7VE6yhjT4Fn4Kwt9SmtfTrn2bH1H4/9j9yDug1p6PxD6x2At5O7eK3Hnl8Gdp4KVdfa6tl2pcXYsl2RKsQOYVmytaz9VnThlCQAvKVEbBu6w5
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gPJu0pBYAAAA:8 a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8
    a=yMhMjlubAAAA:8 a=K82gfHmz9ML5UqyqUwAA:9 a=wPNLvfGTeEIA:10
    a=AlIIF0cMT2hfDT4axODj:22 a=AjGcO6oz07-iQ99wixmX:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932505AbeDIAeo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:34:44 -0400
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:14317
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932484AbeDIAel (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 274/293] MIPS: TXx9: use IS_BUILTIN() for
 CONFIG_LEDS_CLASS
Thread-Topic: [PATCH AUTOSEL for 4.9 274/293] MIPS: TXx9: use IS_BUILTIN() for
 CONFIG_LEDS_CLASS
Thread-Index: AQHTz5lneJy1gzRQNkGN6y6N4bQDrA==
Date: Mon, 9 Apr 2018 00:26:29 +0000
Message-ID: <20180409002239.163177-274-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:PtpD+Wbw8oEhIHgm9KCDv6qABmsStnN/ZTYRHumXtYfQR3tbZhSqqlvmfUP3WBEzWhdiKfjx21jSG1ysQrNsvU8A1nS8orL5RwM0jreZxmA0NHaJJnS+S/efKqbPDTAkBW3GFhkc1ep1fe5yKNRQnBCB/C8jGG5G+7Yy/vMeQY3s62xxLCEyoO7CldsfDXPo67MbEZTDs203w+2QRuYu/OGQQ7uA+G/Z/0JuRWNUZU8CdgPFTDvTKfGMeVu/Px0G;20:ihmrXt6XqgQHo0/6cY9MnfSy03Qpy8cGXN4LvQNfDwzuYqQoJVWGkNTcmUTufiuE7lDMM7MMM2HPMO5DvmedabCSy94psPwdhce9kg+LHfmk+ns6wbKSisqMufgC0kKMk78Fy8FxSI51jDGY6HzSS+uGePzMKRc01Mfpe4vQPpU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: bcc6b15a-3e0a-44c9-31fa-08d59db1acd2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984B95B552EA84FDF70465CFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(966005)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(86362001)(305945005)(2616005)(476003)(6306002)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XEGB6iQo8XuLAnHSxc/JFORs6tGyngV5KqGujJ3APDrOae8aFTdwoDV2Gm1qlh01Yy4OXfnhyotQoiXaeVQOJn2znOd+4gt5Bs0s7A5HFgAfgSIvfJLRcfLLTVPL7Km9cDdbm1ZpwfcfwGHR4UZcw+7HdL2xYmQtmmD6vV+M1LYlNkVcwZk+xOn+Wlt40OT+JA57SENneP8cUtNigVVF6Y9X4aaPjPt9O+mifYMn3v86mlVDzsMSRc96knqGYJPSLP/LI24vYO/WeNqGcFuu6e6SbCZmSq4K8ZcSw4Waxxe5DXQpgxI3Q2ky8FCC+XT+PyYiP3bge+yQgKrcqQIYBpHYmPP27oVGiAgs2XG4wNRr7WnoTs7gjm22w8WUPuubkpZ48y2bwubbi6NJRE9obriW36v7W9h3olsmwMsAbxE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc6b15a-3e0a-44c9-31fa-08d59db1acd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:29.6758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
