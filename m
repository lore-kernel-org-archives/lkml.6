Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490941-2-10167025936946111065
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
    t=1520490941; b=bnpP88T8ipweMC5nowNWB0sqCfaMCxTX/IhQVBC9TVe5YoY
    uxWwq9Cs1U+/hTW17WeseR+FRhGJaVNR3TrXABbesnAdCPFEFub93i7YK8gr4Mk6
    fh5YRt8ui1tPRtQAI/6C69xVj4r7tcb2/2PtE6AdDKDHZdJd3yuuzyJcezOfn/XM
    W+fc2uMEpSMqyCQO36ceWQhkyg7sT6Ya4fV7Uu34p1FY8letBj6su1X2l0DfcHL9
    24bRAYXlxu/vH/+nAmEfzMqiKT2JfO8CsQl9xXHUY1pKeZuX14067LIDGlNpLl5/
    QbW7YWKWsZs5egvLfDkc8rwPEnJAHIVEJc6CgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490941; bh=+qTeDt
    ncnSuKzkBfbB+KGYk1CMEdZ7IK8yC85C2CtaQ=; b=Bll6kPKzoc7A4o/j8WI4WB
    PQrDa8KtR4mFTm3lwH3PzdR5qkHdfumLx9JF25nO79EhF1HHzIYgrU8ugkZmajcr
    n64Dd9TjvF6rfYYlGxrAR+sVDIrgwHnp1hzSIHqLVyAl22IJfVYGJZ0kEdz5wLET
    ulnsIsD8OGVSBwwlcyEpmMTxACRGB8KkIoK0PGG7h06K5IwPfjnYZD5WKqYGsfGx
    G+VgLuZm4TUdJfEmxHIjO9RcQQc22Lt6nH7B+1GHTo6LNZ3K+Gks7HKlNl0E1G2J
    Fqm56l7xIsU9o1/5qo95RoKWL50HQk+eaYONEYaUv5fGwHa+YQ4Xk4kxI+im7kzw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bTvuRGgK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bTvuRGgK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965504AbeCHE7z (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:55 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:59552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964809AbeCHE7v (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 64/67] clk: axi-clkgen: Correctly handle
 nocount bit in recalc_rate()
Thread-Topic: [PATCH AUTOSEL for 4.14 64/67] clk: axi-clkgen: Correctly handle
 nocount bit in recalc_rate()
Thread-Index: AQHTtpoIWry0wdBYgE6uK47WLUPgKQ==
Date: Thu, 8 Mar 2018 04:58:01 +0000
Message-ID: <20180308045641.7814-64-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:xRnyk6kJ31Z87yfkC6Plt/e/Ffb+8LNv3GgeuxJ+0mRNvFo99KG2+GgXF8fEZAat370oJM6eRsk68iXcUkwoRH+G0BwFo9L0tYoyTG8gt8XuggDBKYzSTITLliEzIdx4leLLyOlmT4IM2styJocX4BMWOY6x9vu4sRzA2/+Ds2PKYYtq8oBySQZaiMKS2N0wWoWIRymQHMfsZn0ZbNkAvy9hWwOFJifANJQP47cxeybIg16UITfXqjiE6AEOABSz;20:KrE77kGKpR2PKxm7MeoxkGqAnW/G/+X4j5umJ6+mK82QnQbAl+t4WAL69hWw80dd2WSouXgn1/jQ3mBNpMvSnUMz6geOpAfXF+WIlfxA0eYDk8iPFB3MR4ThpOjBHSMYPYy2ZZSgUjkj2X089k1wFSJSUc3Jh+o1b1WBfRl/TnA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb443ae0-075e-4e9a-90cd-08d584b16b3e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09202B696087666815C14361FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(68736007)(105586002)(2950100002)(106356001)(102836004)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: +wYjhBKic8v8elPBSNYlwUC7tpnfkhcaCnt21tuFu2pE2urztKLz+sd7zJOR1HgRfQV2CDop+Ip+CQsITsTfV6w4hrAdNKSvp2e/DecyEt6mszgsA6ihdoGd7sT6JYOslzzLJODtEuvmxBhrP7bwFMKLlNMHmNudZIZDWo38hudLgr1Quts71DIoO88VeRReh3TydbcK82sv8dMul1xQh8gsap7JiLw1vpP5J/1GwoqD9xMIaVWkJLWNoonllAqv1qFqa0MPD75WqiJdJm7RJ3J4JSeFzBBwygD3kLwh/EmNTWRgyGuHzjDMsUL6gqK498C87u4LUTrfvOgQILv2xg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb443ae0-075e-4e9a-90cd-08d584b16b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:01.0554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
