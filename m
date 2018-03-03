Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118735-2-8403216578377778410
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
    t=1520118734; b=M0FBFH82KTYZfTQjKrBeTUrnij1QwZ9VqmPCqsOC1+EpxD1
    GFe0f3+bWfqgXEFLJDOLu+c5HpyfubFmcRlUVBk5dQ7yj3+Lc6hdfrtkT8g2eY3Y
    bXM3w6sWaJ0aAJ0ZKmOysUk0HlbzKI4AtrZfe3NZMkvKBX/8DVhopDWSn0YovbD5
    DaIPpYYtR5o4SO0e4UTKowfhtyUJiLoW6yoPrlPTXluXvAdVJy9D9rSZY6O68KuI
    D+OHNB6eub9t977ob+qOwhDXnfyFP+x684BB2hU1HfRxITANFKo+XmSvdV6AUC72
    F+mrRgWQrmWrkquYsXH1S2MuB8TDb2PljzBFoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118734; bh=CtnU/I
    hQpaLHu02Wnfxl8CyZ0m2Ii9sYiPP6qMv+WEM=; b=j/BX6VffDToNE5A3pIsF+t
    WFX1xrHV/x+WR/Ve1EAQMCWwcq9+oU5l4MVqxyUCUIWVhJ3jgZl92icBm6BrPRTh
    Qn2F1hSC7ilsyXjWaAWbkJ/LLVRbHrnWldX/v3y/no17EWmp+JLR/hQfUvyLC0Ia
    my41vT9CxHHW1Pwr0GeDCA7bAYz/aknbaNppauHRKUhHhJuo6Tad1vcDUrPoRsME
    ZMn8adCHPPwZoNWE7bMiIFwzkCpVt2XD/MJzt28feNu0iU3JhMUzUnIXm1+XCVFp
    mFoidWvRjRdqIPbV30VYmot62+CovQrQtEU4zyU5Jjn9dRfTPVICwNdOK9zB5WRw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IaqStnqi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IaqStnqi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbeCCXLr (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:11:47 -0500
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:24173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935032AbeCCWjT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 048/115] ARM: dts: r8a7790: Correct parent of
 SSI[0-9] clocks
Thread-Topic: [PATCH AUTOSEL for 4.4 048/115] ARM: dts: r8a7790: Correct
 parent of SSI[0-9] clocks
Thread-Index: AQHTsz9YFmI7Enh5NUizPFwibPHYSg==
Date: Sat, 3 Mar 2018 22:31:16 +0000
Message-ID: <20180303223010.27106-48-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;7:9zi36QwCjTnLENFfWEkQAW17ijIhL6MA/q7sEn8sN/4VJWpaNpH5RIzRaDLmkWPiZIDThcvQVfdheqnlGPJ3QNgjkQTGxFJ6HVeCzrdKytpTmgXhXaKMJ4vsegckk68mH2sNvWVfzIhK5DG2wCjHpKqUa+cp+6IeKt8KlnhSOkQdFWtcgMWxQDFsHzAAjceQMhCMZ+MqgRCZiYKqhBrvDq8RuNWXpDwBIkz16k1zdag1U0yKpqgnHpMONXqj28QX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7059288d-19fb-44c4-11fa-08d581579840
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113EBD0E04EA2062BFA09FAFBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: yD+nf97NJ+MEFJb5I7//FXzDZmVsdUbI75ZgUliMVbNl+0QA+03TWgeJAKuC6p6Oudh9cbvYJ8fzsqAYjAEYQQusDirwJRTQ/3vU6C+u5awNO1DILOwmfPvFo88kxHguclQgFgexUvyiV1cyYOp6qIaN0itMDEqyyTnZhZeZIZs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7059288d-19fb-44c4-11fa-08d581579840
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:16.8228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit d13d4e063d4a08eb1686e890e9183dde709871bf ]

The SSI-ALL gate clock is located in between the P clock and the
individual SSI[0-9] clocks, hence the former should be listed as their
parent.

Fixes: bcde372254386872 ("ARM: shmobile: r8a7790: add MSTP10 support on DTS=
I")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dts=
i
index 7b39d8fae61e..bd83a61f724f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1360,8 +1360,11 @@
 			compatible =3D "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks"=
;
 			reg =3D <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
 			clocks =3D <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>=
,
 				<&p_clk>,
 				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>=
,
 				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>=
,
--=20
2.14.1
