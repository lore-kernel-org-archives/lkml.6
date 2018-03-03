Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120925-2-11506007845046799387
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
    t=1520120925; b=iciTzOVxcmOY2s7bJLhww8wcStE15G1libyINIIMm+NHnAV
    pcENApztYlqL/sfnS0dSQXu37334ec6+PI9SH1+kd3b8/8SDgw4wnU2RPCJdbHkx
    FELT5c7xynXbeosNyrGhyiy7t4kcHn8rG6lLBqALbjU2CIs+k1mvEk8UXr2RDJjI
    087jKFxmNNtZQcqm76c5yYvkaVcskCzovTaZeZtTxryl4trwcCIz1CmdrCWTLsd8
    HOM/c+eiXoULHlC/l94SZESyT3mn/APVGj8QAd9zw83/598G81cAsGcov188Rijm
    bZgYw/sErINs/NxKyiYo/Hhp42npCDZAXAcmBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120925; bh=dXSJ/u
    x0xcWyJhR7lpFRB80Zi8yuuwyWGW3vImd4a/I=; b=oykX1LmuU9CZxpuaGAlZ5K
    pXup9gcEdWDYu1H1aEIvDnbB++6EoZfKb3bZtLz0OauxSLbS81YTkMkudnO8etm1
    +DRM5TsoOkUD3ZrwCSjRZIRvh7tLjaFcJbFHjYzS7UgxwfSzbxgE4M8gukF7G0w1
    boVwIwAUoPa7rkeC6DVsHXqVu+dRHMBh/FOQua7F1Xr0BKAWlzozHgA9C7R2m7jR
    vB2sczww9FVBaBRNlRppMKv8QQauZ1WomFNtL7ADfTmWY1zFCPAAaTFhSf83Dc3A
    N4J+IS8W4wxkcC4PhjxRuOXfyVzNvks1bUbHSeA0YUV3ZvwF4E3vQiFEv3Ltjfbw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SFOWlQJL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SFOWlQJL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934097AbeCCWeA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:00 -0500
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:37280
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934079AbeCCWd5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 097/219] ARM: dts: r8a7790: Correct parent of
 SSI[0-9] clocks
Thread-Topic: [PATCH AUTOSEL for 4.9 097/219] ARM: dts: r8a7790: Correct
 parent of SSI[0-9] clocks
Thread-Index: AQHTsz8Bs+RJakEGsEOykzZPGlJXNA==
Date: Sat, 3 Mar 2018 22:28:51 +0000
Message-ID: <20180303222716.26640-97-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:0NvxYlSt3Jy8VjuZW24Pcjfe9IP6kFfiGY2I1UhQdWQEGU6BHL50Nyie+/04y100eWX384RzThejhDxT98EgjE4JdO+P8lGjoC7604LKWvyx863PGFaaHszxITBpD86wXB3VVd8gVgDHIJdDZij23HddLmF7koI5PlzZtVsHVmF9NGdIvfYM2hMLoLFGd+0rkVb/KppdY/VxrKaFayqVfx7M16fBvmQJD50TQwR6CDMr/MS8PQmSqn2isGT3eFrb
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b8b04c8-1edc-43dc-6958-08d58156d86e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10658D6F1E14C0894BD333BFFBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: U/lZxF+TSEnzmRKRhMDzJ3N15pvcDnzANZoIj3HPsYGUGEMKVQWqyANP4Ewl+zUowtSpbO1IuZ2+XVJonmWW82LQ+dbyTrxVtJvpx/9l3W2BVfEK2iCafsr6Y/gXBDaFXr/cQItBQEiGNC7ae4OBFNaBCFkfSAZp1ltMd8Y2a8I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8b04c8-1edc-43dc-6958-08d58156d86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:51.9788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
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
index b6c6410ca384..262a51205aee 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1437,8 +1437,11 @@
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
