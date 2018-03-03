Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122642-2-2383088814971713551
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122642; b=oA68al94dHXOHuCxbP3wMvKKyET2VkvKx62eC+Mwr6dfE1a
    z7DxUMG7zZeDguMcHMXLSgoiHAs/P1CEdmohpmSNilpWnb9dgN8j04KMELFejQ1Z
    j4c0CaAsdUuVuB3x4EgEq2NPj0gfp9jtWJFVxQ+81vWHSuIOJbRIt1e9jQiqRK4G
    5CjilEk/ls0i7THqXzbS47JH9v3ywFKnuO73H+C/ReV1MRB0SFyChZshPCgcW+PJ
    cfZu425nzFAOnqiVs86t9NMeDRT8F3ORGyFQ1+jJH310KadWSrpO12ZjfwVl8tMY
    YbwipzcVTQ4//0u634CK43++129rKDXT5wse2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122642; bh=FR2zvR
    I7y6S4uB19EbOoFKwSRgi9XHPfq6fBdcJkAm0=; b=kwsfaaskz4zBltof7K7spi
    JCRZaAuLT8uRDIVHyOk1F59yFAWpIMMdnymIEFsfW/sf7QIya2sBdJWo97EMj4Px
    cnyo6EO0t2o/1/ltnzEXg8XCjOzJY2WHYUkAoVI/0BIpL9oVxQNCRI/ogGQSfBIz
    vIJXoAtFDFsED5elLJe0gfLT+PS3Ec+JCQ/wXghjlBxl8CMU5FKl1NobHfoGPVAP
    Sx3UbVxMRltniFdA9fvFUsGG41zvGZDxy/l/KJGLN/uhfKybl0oOzptbZGeJqMfX
    L7QSmdd0XxS2e+JoYx6yyspIR5kZ56MYXTHhai1xU94rF7jFEF9XrZPHZihKoLHA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XVMpuzGT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XVMpuzGT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933319AbeCCW3Q (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:29:16 -0500
Received: from mail-bl2nam02on0122.outbound.protection.outlook.com ([104.47.38.122]:14153
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932465AbeCCW3M (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 47/84] pinctrl: sh-pfc: r8a7795-es1: Fix
 MOD_SEL1 bit[25:24] to 0x3 when using STP_ISEN_1_D
Thread-Topic: [PATCH AUTOSEL for 4.14 47/84] pinctrl: sh-pfc: r8a7795-es1: Fix
 MOD_SEL1 bit[25:24] to 0x3 when using STP_ISEN_1_D
Thread-Index: AQHTsz6rc41ZlIPfUkiLiIFhDTQ4Vw==
Date: Sat, 3 Mar 2018 22:26:26 +0000
Message-ID: <20180303222518.26271-47-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:RE8c6Mps96VaRsUR7KM+iGBlXXoHm9EGDHJAuyFAWm17lsgmtSA+IPVLi4g63jHhB/FXQu3dr0uJtCB82Gq4Rn705GZ9jC245SKRNNMhmIyhypUaQFMS2uoErBbQwydHrwZdYLnEK6m/GcEUhNObW2csXx52p4yTxi781hcPpkXibdQkm95G9bOD5x+uUJqF3U0k/jNUgosuDQLVfcNZZztNizxAHUy2u56bp6q/kYApGS0yI4IOFg+d0f2dqPeS
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84dff281-2ca1-49aa-b414-08d581562ee1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106511F24B2DA3EC279E26CEFBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(39060400002)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: TdcMsHkSPdI6fm2Ys1gXTXo10ZEmGhLmMtQNkA9rPHDbCqQbDZbnxbXdqBJasQmjg+BAxNkTBM5eUpLr2RFYiYgemFNBGeqgpFYzVrYHXU4bKaFbV5EsLNUY97p2Gn5ErtE8q9kOytlDhitiAUNRIFzVIlRj05bzvSKmCm1a2Ng=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dff281-2ca1-49aa-b414-08d581562ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:27.0098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

[ Upstream commit b16cd900de7911f96af17327a081a2141a0b763f ]

This patch fixes the implementation incorrect of MOD_SEL1 bit[25:24]
value when STP_ISEN_1_D pin function is selected for IPSR16 bit[27:24].

This is a correction to the incorrect implementation of MOD_SEL register
pin assignment for R8A7795 SoC specification of R-Car Gen3 Hardware
User's Manual Rev.0.51E.

Fixes: 0b0ffc96dbe30fa9 ("pinctrl: sh-pfc: Initial R8A7795 PFC support)
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-=
pfc/pfc-r8a7795-es1.c
index 95fd0994893a..ad037534aa13 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -1397,7 +1397,7 @@ static const u16 pinmux_data[] =3D {
 	PINMUX_IPSR_MSEL(IP16_27_24,	AUDIO_CLKOUT_B,		SEL_ADG_1),
 	PINMUX_IPSR_MSEL(IP16_27_24,	SSI_SCK2_B,		SEL_SSI_1),
 	PINMUX_IPSR_MSEL(IP16_27_24,	TS_SDEN1_D,		SEL_TSIF1_3),
-	PINMUX_IPSR_MSEL(IP16_27_24,	STP_ISEN_1_D,		SEL_SSP1_1_2),
+	PINMUX_IPSR_MSEL(IP16_27_24,	STP_ISEN_1_D,		SEL_SSP1_1_3),
 	PINMUX_IPSR_MSEL(IP16_27_24,	STP_OPWM_0_E,		SEL_SSP1_0_4),
 	PINMUX_IPSR_MSEL(IP16_27_24,	RIF3_D0_B,		SEL_DRIF3_1),
 	PINMUX_IPSR_MSEL(IP16_27_24,	TCLK2_B,		SEL_TIMER_TMU_1),
--=20
2.14.1
