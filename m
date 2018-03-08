Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492087-2-1220242519418931521
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
    t=1520492087; b=iDh7FfcSWXFyq1CxO9lwkHTbZ5078EcZsin22HClxXIifex
    7MGP1X6B/7N26Psn/nEraiPT05viT5oUOeof34dxP/BAj3rgqamfhzMuhcztonkR
    7sBQnvh8QsvO3hXDtNB2knaEfDpHaxOf/ijDm3DMWlJzk6EyQlJwmVKj++X4R0Fd
    f4E2mHXnU4b81EbI6eQOgz5wUW3o4Gy6xobJyar/ZH7SOuv3cKDgsmo5MxKFcZOu
    iTtJBslABnOGBTDfW6eqKvU25f3HPi8GcIXw8OyFbU+33zS+FifenvAse5x2XKcy
    VMqiWDXXsg/JjF882xdOY1P2DNcow+imIake6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492087; bh=+qTeDt
    ncnSuKzkBfbB+KGYk1CMEdZ7IK8yC85C2CtaQ=; b=ah6xPqaisv31U4lCqnpPAs
    q5ZJ8YUyh/gmolg0I6IjteFzJx03YzIPEMvVM6D2BDVDPjp0WxPGLXOWTnbpyOGj
    bbzRJDgCnTcBqg3FWP+f3ZCwhca6o6lMo1LU3q6zdjP0/4jVAfINi38ZJKDFeerZ
    52bCzL02hRL8XRVwUWgfOGZM7q7KP3eVVitPnClGGqHG0XvpkaMGl20NdoBgSCKs
    1ETytuzvQv+ZyxR9FC2ZH+GyGEtWKSPa1fndzfOQuaY8odJOb44rVHXGsxwCv08/
    w5ovJABGGMM4TuMph2clcarIrV8ncN9A70HpG3TGzrXodKtanqxTZU6NLj6c2D1Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lm8G1WjY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lm8G1WjY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964990AbeCHGyp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:54:45 -0500
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:8510
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935216AbeCHE6E (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 74/78] clk: axi-clkgen: Correctly handle
 nocount bit in recalc_rate()
Thread-Topic: [PATCH AUTOSEL for 4.15 74/78] clk: axi-clkgen: Correctly handle
 nocount bit in recalc_rate()
Thread-Index: AQHTtpnUX10Rb+2zTUev7ENcwTLCFg==
Date: Thu, 8 Mar 2018 04:56:34 +0000
Message-ID: <20180308045525.7662-74-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:8IVebXjaMiE9GVApowU85gRQlVZXSfWTJSesrlByVuHFNjbaTp072k9NeNPHKR6DHvCnVxk8Lz7kHCNkegzoJBJZIZVbiuiW/k85P/V9R6i3JKbOPX9VLngkUt85saduOs225YurnuyN+Cy8qA6pYpaCvm5BUgd/wfcnwFVZynBirGX4srapSZyQiCsR16NTTVQmnzk9zV4/3bJz7idrHg00cxA0h7qw4b51kYILq6K7U7Z3IRgZBCw6jzLWC1iP;20:71BPphWdoN0moHj7nwqBWNExxb4av0VwBfmzyc77oqrtY4PommqFlFrrJM0EYa1fL1zeGiWQqy/06L2VlOXSRecfFM7V9Y27ni0ETYXWXV+ABlWVPBGPTysr1tDdjy/TcD4DJZnS7uJNep53tIgDNhI06idccOM3/S/EBHM6Ke4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17f20b39-2ab7-48b3-16f4-08d584b12a40
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB093626A07D433F94EE14C45DFBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(6506007)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: FDsZIYSN5P0BZ0uDb0s1RjVW9iKcs4PvPcrRDO1EahHoljir6HbiHG4QAgoRkhJ+eVNfhdwA2NSVNWA4eHAT9EjJZ7Y+UpXxLNq/x0zyHpAJUEdsx20PknwrOu9aWFv/Tpl6tu0aph9JEHHE221uXvSdTfblYhQ+knvrl0IoG2mCDkuTafNPnCZRrDwkO/e0yMTTNjBnB30KgUF4QQFqHQztD1GbQKTIJ/Hju5qTxV1sDZY60u6WzFrvQ92qR72q8iTS/Wdq7J/N9FsVFoRHI6NVScWY2KYOikHPKj7re1BIr58FbzaiWfPqdDrIFZxMh1gwPQGjl/yOPb+/n0JjvQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f20b39-2ab7-48b3-16f4-08d584b12a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:34.2858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
