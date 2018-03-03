Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120869-2-6324437217852715228
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
    t=1520120869; b=EIAjkruDvTpOoSmU7RqOofqp4R6mXSEPRZxEA/i9+wtQyig
    oGh5ECFW7DqV+SZ/8R0rU9FjnfH2mQASyM2D76JU9Jh2KmeO7+SqduKwEcay4pXU
    +IWjYszZhsEh4mgdOoL2KxBlE/ixAU/Z5D3Vf+lzKrC7YXkHhot1YCsAAynADXpp
    OsZ6nG6TdjGZ0SYKqAIl/k/L2Dyp0TiHwAvgCOP9bj9Wt6C2hQF4fyCnotuejhdP
    x+Oj4Zs3BniecQ+qds1WDBpwAWVBWEX3C1mR1Pd5TR1BdZNwtKMfGCXqoZpNgW/g
    to97o7PwyLMbdGYb+jl/iCtPRCv1LK9EXLljApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120869; bh=EW5PFA
    kpAGndn6cBO+zgyOIag5hu4c6GK+VWICcZxVA=; b=LPtPTIEZPnfMGcMPXPrn6W
    RBbEp0pTPAKiilCTcgi01qMuuB6Qlp2i2xhQsRfVjd8Z5jTw1Wvoqr70iHcxpVXJ
    xMKECCObxx2st1o2uZ9t7ucaQYeXX9Z2B2sE6mEwnIJpfS1HhlTYsvlVu1nrI+Iu
    3BuXj1kMGPC9Vhc/ocDopWO7id/gj+EYuVfmG6OnAwtP9Vegw3bFChi1HjxF9zDB
    eXrOvhp5T5UfFfOPHyW9EDNpEMDQVIUlPnEZwa++7+YwFm1FA/qm7671TEcY5ysa
    1F/i90NQfdTv3Sg+ofYaOkgAvSZrTJpKlrU92n1Iqqby2KvpFv2dT+2cFt2PKVJA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YuJGNZKK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YuJGNZKK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933862AbeCCWeC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:02 -0500
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:37280
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934081AbeCCWd6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 099/219] ARM: dts: r8a7793: Correct parent of
 SSI[0-9] clocks
Thread-Topic: [PATCH AUTOSEL for 4.9 099/219] ARM: dts: r8a7793: Correct
 parent of SSI[0-9] clocks
Thread-Index: AQHTsz8CADVHgr96FEO8yUC2Is8nXQ==
Date: Sat, 3 Mar 2018 22:28:53 +0000
Message-ID: <20180303222716.26640-99-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:rfy6xX8+UYARVt1J5+ZN0UNagQ4PaMZ98qYVDt8WtPPIsuNc+7SZMWzT2T+4bw1FDesE2KUbClLTppECuxcBwNfGYLV7GLlH2Mq9RsQktUoKmnrvdUxf2jVV5MFA3ByTVM7n4VxCkL28NAMTOKBPBoz6DEsIii9jpugiDcMipIq80C/5rH7V/iNGJSUIuQ1Haw0mvQ510a8o+ZcVfh4qr1CfStHxbG4ouxdv6bGIIc8h6DPgUDV6DTCgOzRz1V4w
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3378c3ad-56fb-4d08-509f-08d58156d8f6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065AC4B92A10E78B6EB00F4FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: oOLwHonyH/GKY/X+D4iFjcyPdTHyTKLvgqWyPWoAlxSBPoL/6F71kpQJbeqm64UQZvcvhVvAtp/XXj5Kr4VW8p9EiRISvVNkVXTxG809HfIKc1ClSEUjKFiVSqcJRK3e68Yn6VEmrozqGQk4u73E/zS8Kij35TfUnkifnNIPJaw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3378c3ad-56fb-4d08-509f-08d58156d8f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:53.0413
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

[ Upstream commit 1cd9028027c7a7c10b774df698c3cfafec6aa67d ]

The SSI-ALL gate clock is located in between the P clock and the
individual SSI[0-9] clocks, hence the former should be listed as their
parent.

Fixes: 072d326542e49187 ("ARM: dts: r8a7793: add MSTP10 clocks to device tr=
ee")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/r8a7793.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dts=
i
index bd7ee309f509..e9625cb3bbaa 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1234,8 +1234,11 @@
 			compatible =3D "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks"=
;
 			reg =3D <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
 			clocks =3D <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>=
,
 				<&p_clk>,
 				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>=
,
 				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>=
,
--=20
2.14.1
