Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488097-2-2172501457721215648
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488096; b=u1n3VLRUPrifLo80FCOFnHCN+lHmhiBniAK+MmAuCkaI4rQ
    qLC96/J4mGVV5TuQKSV78N/F3dImAl2cVcCI/3aFwIuYXFOiQn0mUkpQWeb3SgJ8
    Ko4m5+LrvRjHJGTbrJg2Bm9MjxLWXAqfHA3SxvxfWHHULwc9wKc3wpFMc6mIVDLl
    KZiORVTvFKpP4qAPafzfnuy+WC4edPEn8HGSAYVfc7OosU7oKqmb+eyneUUdC/IW
    AixKsLmrqO/QpqACOT3AkHyeIFYB2TXvdZKrmWaTRuU2cCbSff8ukDifl2b1WlNE
    3d+ShzDIe8LsGYlJhLveNQXKaqwArAEJDbqguDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488096; bh=+qTeDt
    ncnSuKzkBfbB+KGYk1CMEdZ7IK8yC85C2CtaQ=; b=mynlkza0S2lfj98xUlaUO3
    0lZZ41mL4LBk2aqwG4O3DfrMyrj99wwZCNRs692HW9f5qfQFtgbO2Ld19sPak1Kg
    c7iGQp7dE4Ul2NvKET7AGgnWkm+66/orAtICZlYr6y4yBA+qTJUY+cn2gfCeB0Ly
    twv2Qd32o61P8RB51iX9kCHbrWxjWCi/LmYxmRVtToq8ZYI8AvMXuuzAdlIKcmZ/
    +9T1KXq4MXfQkptH8u+x/tGNcEPSvf7o+E5QD3DXi+p1E4BsdEqvN55ztRt+hie2
    Yx3pMey9kklFIvEfI0oSZ2OKGLvHyaEWsjETBmn83osGNtn5MIVlfCRQHWDP0IQA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zn3nLdjn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zn3nLdjn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964983AbeCHFsA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:48:00 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:45712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935595AbeCHFFG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 188/190] clk: axi-clkgen: Correctly handle
 nocount bit in recalc_rate()
Thread-Topic: [PATCH AUTOSEL for 4.9 188/190] clk: axi-clkgen: Correctly
 handle nocount bit in recalc_rate()
Thread-Index: AQHTtppY8X0jmoCMP064B6jRgzAzSg==
Date: Thu, 8 Mar 2018 05:00:15 +0000
Message-ID: <20180308045810.8041-188-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:2z9x2OXJGyTqSrNDOlIgfWN2Y4OypEzMNY1O2h1WIGYQSBFNHJQ72PD7wc9WnSNJoLk49IYdNqHwLFfc7T4PbPxpCDK3hHMXfyr6OjEgLOR+Ntf6VrjTT+r28NIqrQu8EYxAPJl5oOVTzfQ83XQj+Yb4Asmm7SNiQzV8htjOplr/Ta4SxakKyMoCuraQxgY2V6UBVCXRb6qhKSe3sdtuKIOPAHCuyJVE6/h6ybIRBn5VB+KgbBK043kDXDzfpnOI;20:cNRebMlzUQHhZP6Kaok+JUfcAIUICacfuCu2RAU1j+7UP83KpUS8gMOOV1yUVTC5It5Bkmx3XJvaFdU8v8wnOi2dsYT/zzjbM0U+iJd/oWrGikiEGRH5VQLN665a4JWIM0cxJ+yXypf6dkpI+CZZSE3dFwOIBdB1Iy0P5ousFFQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e27055d1-a0ae-412e-8a7f-08d584b225b1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981D98A8C7A40B1E4F2CE27FBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(6666003)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(107886003)(25786009)(8936002)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(6116002)(81166006)(99286004)(72206003)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: QMSPNP9QV3GzM5p/KBj8K9oMfnxCpA23AKzP3UdeCZ0hMuJY0uFOZT6oxti0TJ1htbubKawTSxlz3NbEU3Id5ke/6cUH3LP/RQ6oLnrtEnW9w8ND5VtD3f9u9UFzeg/s9xMR1D8Y6kyow/Zhyks7C3ghT7d9TohixEG3vS6PwHv88N3udKSkVDXd5qYOzaa5TOCh7r7IeY0suJanSwGijolNAiO5zMUbD0OjqHlra5NHBtJjotR6VCLqnX/iHoGStht87aR/twrBiMqBte53VgnhrsjRV+5SMHC/n8mzWLmOAITWxxiueuPPndKM0K7jU2pOVsniCd882+OZ8AOb0A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27055d1-a0ae-412e-8a7f-08d584b225b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:15.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 063578dc5f407f67d149133818efabe457daafda ]

If the nocount bit is set the divider is bypassed and the settings for the
divider count should be ignored and a divider value of 1 should be assumed.
Handle this correctly in the driver recalc_rate() callback.

While the driver sets up the part so that the read back dividers values
yield the correct result the power-on reset settings of the part might not
reflect this and hence calling e.g. clk_get_rate() without prior calls to
clk_set_rate() will yield the wrong result.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-axi-clkgen.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 5e918e7afaba..95a6e9834392 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -40,6 +40,10 @@
 #define MMCM_REG_FILTER1	0x4e
 #define MMCM_REG_FILTER2	0x4f
=20
+#define MMCM_CLKOUT_NOCOUNT	BIT(6)
+
+#define MMCM_CLK_DIV_NOCOUNT	BIT(12)
+
 struct axi_clkgen {
 	void __iomem *base;
 	struct clk_hw clk_hw;
@@ -315,12 +319,27 @@ static unsigned long axi_clkgen_recalc_rate(struct cl=
k_hw *clk_hw,
 	unsigned int reg;
 	unsigned long long tmp;
=20
-	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLKOUT0_1, &reg);
-	dout =3D (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLKOUT0_2, &reg);
+	if (reg & MMCM_CLKOUT_NOCOUNT) {
+		dout =3D 1;
+	} else {
+		axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLKOUT0_1, &reg);
+		dout =3D (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	}
+
 	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_DIV, &reg);
-	d =3D (reg & 0x3f) + ((reg >> 6) & 0x3f);
-	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_FB1, &reg);
-	m =3D (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	if (reg & MMCM_CLK_DIV_NOCOUNT)
+		d =3D 1;
+	else
+		d =3D (reg & 0x3f) + ((reg >> 6) & 0x3f);
+
+	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_FB2, &reg);
+	if (reg & MMCM_CLKOUT_NOCOUNT) {
+		m =3D 1;
+	} else {
+		axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_FB1, &reg);
+		m =3D (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	}
=20
 	if (d =3D=3D 0 || dout =3D=3D 0)
 		return 0;
--=20
2.14.1
