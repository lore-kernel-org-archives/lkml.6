Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118851-2-10557979224405429247
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118850; b=gznb6qT2a/WrVf6esObHtT85JbSKooMOKiO2+thwbWrXtMw
    VQIEdaTjYV4skjWXsmATH70aiycsuoKIqCWc5pZH3G+Rpm2H0BuuCG8XFT5YBob0
    q/e/vYSji5kzlfyAtikK48pcqyNwbweHbec4Wiyi7iyKS3165oU0ShfN39ZEJ5mI
    N2mrsf2bqlRVbK+kSCuAjAu2KxFtko1HERZ4z9rWeVe6q7P1mSVmyywVq9SP4OM/
    /YooQ8qCtx84g4E6ywKuV5fNFUoHuo9Jc8TPAGypVJ/ngb3yiJ74N3/atPPd1E6n
    9LdIMZkbU6fhZQAuRwBTvc7cHv5+C9aKcvHhuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118850; bh=+RxkDx
    jEBbZPvL8UxKobDsUjMwWocXte16XjA0kVSro=; b=A9Wsl1z+MKcqeg/jaFmdob
    0MmaHEkrtyW8q7EMeKbwIwtLj/EPMzSXSQpX5FQGcMEpnWVXg2AgLui3NE2H5HYV
    scyD3pVu0mmB60RqQe5SRlK1cpDvPU4jorlmLhEBsc5BpLCC//2FPNfsg9UrOSRg
    J1KBh8dmCUHulfSxnIN0NRg77e0TTpaa2ATi+tu71vgZomuGaqeqkjt8ceNDm9+U
    kd3WjOWo6xJ4Uoy2DpUHbHA35yHQsQaMTjnCTuwNEUoVOubIaqOE31j1Qv7O8d4B
    T2G6DmiGoU4IO/I0WsqSOGvWkdwm8mvsvgY4Rx+ZZulypS/Dp4BA195NG+uzzYRw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=loOmp6Ne x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=loOmp6Ne x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeCCXNj (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:13:39 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:65056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934392AbeCCWjJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 039/115] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
Thread-Topic: [PATCH AUTOSEL for 4.4 039/115] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
Thread-Index: AQHTsz9Vk0O3sU9SkECHvFNDogBe/g==
Date: Sat, 3 Mar 2018 22:31:11 +0000
Message-ID: <20180303223010.27106-39-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:E7k8EE6DhJytX+Tf1YjeQiECTOENwFL0zRnQYbrApX31I3S0dkbWen5Jz34M0MhTWJ/vPB/45YhLyDUxjX3EVbWfg92yvEVEjxoDqlTwpNTYXTj33UAGLGQZE4Ce23U5/T7qXE2qi6i661ScDJwBfLQAR5585oJWzraJXFmg0n6vZXsNsRG+NLci3RqrAb7jDFjomQ1sWpJLP2s7ukDPswCwc7IZktkSuVows6gLDUTwZ7AbH248c/TfeT++v2UW
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5322ab39-c8f9-4af9-a56a-08d581579221
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0938954E54F776D88D97C70EFBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: UXSu2P8IIB7dtJAGQupH5IA+GekWyRBzlL+ccOxdybsrsn4Hs3B3JZhs3idDH1gCWuggrfaP9Z+fvQIzvFshaVCuHSekAsQdbpmCW9m5TLznCq3JyPJ5Qn/FhGGluGj/LAkL2mBFnghZ1Jm/omTKMkajBnZPEmA2izI2c4EP0Wg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5322ab39-c8f9-4af9-a56a-08d581579221
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:11.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Roger Quadros <rogerq@ti.com>

[ Upstream commit e2d54fe76997301b49311bde7ba8ef52b47896f9 ]

It seems that if L3_INIT clkdomain is kept in HW_AUTO while usb_otg_ss
is in use then there are random chances that the usb_otg_ss module
will fail to completely idle. i.e. IDLEST =3D 0x2 instead of 0x3.

Preventing L3_INIT from HW_AUTO while usb_otg_ss module is in use
fixes this issue.

We don't know yet if usb_otg_ss instances 3 and 4 are affected by this
issue or not so don't add this flag for those instances.

Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap=
2/omap_hwmod_7xx_data.c
index ee4e04434a94..692c93da5807 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2240,6 +2240,7 @@ static struct omap_hwmod dra7xx_usb_otg_ss1_hwmod =3D=
 {
 	.class		=3D &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	=3D "l3init_clkdm",
 	.main_clk	=3D "dpll_core_h13x2_ck",
+	.flags		=3D HWMOD_CLKDM_NOAUTO,
 	.prcm =3D {
 		.omap4 =3D {
 			.clkctrl_offs =3D DRA7XX_CM_L3INIT_USB_OTG_SS1_CLKCTRL_OFFSET,
@@ -2261,6 +2262,7 @@ static struct omap_hwmod dra7xx_usb_otg_ss2_hwmod =3D=
 {
 	.class		=3D &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	=3D "l3init_clkdm",
 	.main_clk	=3D "dpll_core_h13x2_ck",
+	.flags		=3D HWMOD_CLKDM_NOAUTO,
 	.prcm =3D {
 		.omap4 =3D {
 			.clkctrl_offs =3D DRA7XX_CM_L3INIT_USB_OTG_SS2_CLKCTRL_OFFSET,
--=20
2.14.1
