Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234689-2-18408250714204437832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234689; b=oGVHjBX8E+9bpNmwIUkdcM/gypkP9Qkj1AJ06dpI0xa8Nt8J/y
    GQf2Z3q8/kWLQVZjm2OHMrL5xkh13eMMSwux0AimBryLiRPK/QZYa72AdTAKOuAE
    5zGyhbd7WvK6krlfCtgukpEiv8KZ4/8kyycKXhN2x1KoVqsF4UruaCxQSCXu+DDs
    sM7bnTBiTW4LFdr8xuqcQ5kpT3Zk3/050aBVGRshf8WW9XgsDur5UFUXVvjmBpBL
    abXWej851Gu8f+BYKferuRQjvregdFYLzLbUbmZSWVMsPC+Vf7iSlUCxvgayO2tK
    O9O93/ms2UY2T/JfgYnmIpK7hrXsdhNSH7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234689; bh=nTU6nQCrCZ
    yC9sciR7TmGfG7IWc0S+TdPPBez64/SYo=; b=FWfNxwvxlhjJoA3A7tkG0boCrZ
    1EJV3BryTx6gNSJacjQOE//y3N1ChGgxfUBkalXiXc9aJKB9GSjKkkUv+JG/C50a
    gWoqUV/9EwE3/25jLWamFSpzSi14enR9EKnXdSfJ4ltADqhQ1Qy/1MTwDETHXFF0
    U3Kwd2YevbPmQ7MXCKe+D7H2/ahauytxmb7mKE4rHjWJu+LDt43TL/qLBDcqPuG3
    vpbeCPHf0rkD4YPywgnuf0Hs8gJwQ0D1xl3Fq0cMiOUzIRL84l6m6Rg64e4mX/Sr
    TlGr+4Fj3NFx4DbgPcXzQNFn/d4gLXLh9ZHfUxMiuMTAUnK4YU3NDHA3lulg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fyZ4f4N6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fyZ4f4N6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFVW33+bUxbKe3ZQlj27UcSZ3OS4jzVRcCuWQ4kRnJrsTgnmaJh+oPQpzJWLAovasaaZGNb+K4WGAXMP5/M3vrXLAIQPaxRuqKQfushOgyfKd2AjPUAJ
    uPkSbtI9ocKdpN7pGEckDOckRCi9TEQuaH1Rq36ofEluW2mepHzDufQTNzghNBBfJIfcuOL4mxsAIsWVBNOochXXgG7gb0PS2APKnTAgZYnB36BEbImpC3D8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gPJu0pBYAAAA:8 a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8
    a=yMhMjlubAAAA:8 a=K82gfHmz9ML5UqyqUwAA:9 a=wPNLvfGTeEIA:10
    a=AlIIF0cMT2hfDT4axODj:22 a=AjGcO6oz07-iQ99wixmX:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756864AbeDIAob (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:44:31 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:44046
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756780AbeDIAmd (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 092/101] MIPS: TXx9: use IS_BUILTIN() for
 CONFIG_LEDS_CLASS
Thread-Topic: [PATCH AUTOSEL for 3.18 092/101] MIPS: TXx9: use IS_BUILTIN()
 for CONFIG_LEDS_CLASS
Thread-Index: AQHTz5uLgVtOV4R39UK9TnRTnbSZNw==
Date: Mon, 9 Apr 2018 00:41:49 +0000
Message-ID: <20180409004042.164920-42-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:Ce+7/SjKz6gh6W6KSrV9gPPuGFdw2LUCyUyDdJpPPuq1o174YX+mPTBsrEaLwSnWzFwA1CLTHZ5yJlOu+puDu5GpwQxsUuQAWfGlaU2laIB5uW6YzjE6FKNoLlqc1N+j7aOqtiNX7KmvVW+Gy4BoHwKoJy3ywg+l2DlnE5PyjKI7Ro6dwbBJD7nYhfc6CkcEGQKPhk87MDvLlabsNMc2ipYSSgoBjCXe7ETd/FHbUyiJIU7Mb/4QuRPZbCZrKhSJ;20:RgUmIGVgpwR4mLKfopeSV9HH0E/FD1FixK3lvfmQezZP62WehbxJy6EPy3bcMN8/VMj/+D1DfRA7tmifUBch69RiaECRhqVyfVE8I5HIRUpFykWUApkvRo137V75evFYJS47MT2fICMo1FZwta7eK70CWZjETmO+rrxxVeyp9vY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a31a1222-0b9e-45e7-2cd5-08d59db2c2dc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062635288F96CB00339ACB9FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(6306002)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(966005)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FwN8BmC+fZ78VqGEiT5Hk7xM+KrHcXSP5SKTxHOge4e1yDHi2P9cWmXCU5TioMz1mY1ZmicJbCjOai/KXUTLNfYREBnpOiB3q/hQllFFO/l+E9n/26ITVMSltTTXR2ZvH+1Ol6d7wX0XnTkMRR8b1NX9lnah8l4IGQNqdwnYPAvhZVFNWVxXiPNykdOskYruYPBFmRPp0zck51dvmKRxsdKKsJ8zkJ+KWNs/TzRL77NEBmIxnkoKj8bA61F1VPU2SJIzEnNcNte5LHGO8Zr+KLIO4SI+PezbR3PNTa3HnP327da4N1H8LBJJm9tYuMgr/d9bpdWxY+DsTJ/RZLh/Ey0CDHGZswU+wQc6NbJaq/v68e7r9CGgJoqQM6H/pUyl5Bh0yvTKJW/u2N4duA15PCiC35bVJwKMwNELfv+5AN0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31a1222-0b9e-45e7-2cd5-08d59db2c2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:49.6116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
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
index 2da5f25f98bc..e802259b2a59 100644
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
@@ -262,7 +262,7 @@ static inline void rbtx4939_led_setup(void)
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
