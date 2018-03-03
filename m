Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117462-2-668400762047050385
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
    t=1520117461; b=DvF5IVLbM9iscr+WjK2gy1h9KKQUFGxeMFDUMxJfCXCsEzp
    BJS32iuD4SGpOJscTYOtq/Y44U6diwfjZeNKnEEOoph+4ACvtboDnr+e/U4sErY4
    8+nTgyAFkio21DhnLpV7ShXYM9yQagXbqmyEXo+Zd4BiDrSkBXmZ1dBybg51hsyM
    BBpD+BafRSaV1tkw1AKRqmGgiw7e0MEqrKok3LarDV2IfvXmJLE8r3cqKlUJu7sP
    JOs19qEJwJeuL6zyrpNEOxVEsgJx0tvD7I/NCi32leRK1UJndI9JL28E2/Cq0D68
    R8Ggqa77g5Xpf7pPFch68ZQ37Hh62u0YGPGNXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117461; bh=DuW7YV
    Mlen1LYXECkfTyiutL18dfZticLv1yBet1E98=; b=gLjvRkoetaAEvbBySZR0Af
    s7hVtQPdPAqRhzoCR3Xj3/mNofSXhoud8NuS0Wu9FiP1B5bDuiuKom8jxAPObAtI
    Q54xMtd79QFI4Krx4M2TzygxJGm35NAzTgyBYScz+YGG8BBzr0KYDiuwCezNnzTH
    vlNMJNLIqIQdaQR2OevdQxcyAWbJdPlnsrvJ8dA005PA2jPhIFZmaAEyBPlfbgiG
    51JLN5siAYWW3TJnQcdIrONCMO1GrP6Ysi0xVgCISbT9ypuYSqFU9DAN9j7B4CS9
    KqOxHof68fYmattIKlV+PtHF/omxo7tUUmGZvtKD/u3q75CBGbS5euljSV4K3ZOA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=APx5E/UE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=APx5E/UE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935458AbeCCWlN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:41:13 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:64496
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935449AbeCCWlL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 27/63] ARM: dts: r8a7791: Correct parent of
 SSI[0-9] clocks
Thread-Topic: [PATCH AUTOSEL for 3.18 27/63] ARM: dts: r8a7791: Correct parent
 of SSI[0-9] clocks
Thread-Index: AQHTsz+lEi1Tg2o+A0OQgSa93Ax8mQ==
Date: Sat, 3 Mar 2018 22:33:26 +0000
Message-ID: <20180303223228.27323-27-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:XjrPYSW+9zX9p+SlGlurms+uw8GegQen+A8hq5nzt3NnDbjaMKDyCQ828jKPcOf3yIR3AY90jCxbD3Ai1v4lUz6W9KivzQGgzJMUioqv7TSUWWlCOW/HL+1Vte6hSaT9miEiaSNPMxDoJcJd613xQ0ANgV6fRPQkQoHUlSQgKW9lk4A2s1pYbgoY/iZC+5YJQuoAOaG4PcvGebqNZoGudov0VStYYZk7Zukiy0INoR3LEv0cVrItFqjPSiqvtGzr
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7538657-44c2-4ade-55ad-08d58157dbe9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB0639BFD7654EA0240E498FFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Od2ZSaUCD1CLhjprQAV7ThKvBjvrJKcz+jxSe5BTUFtp0Gpb1CPxkVPIDQhPpvBfEL0oalqQTuHoP+zOxnstoJbRKCuQyYuzWoerKtX3KGfop697I8/YgV9qjt6dOAtfkbT+hw6ALsby+wS/Ttz7pnALs9R3hC/jJ1Db8Kr+mjs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7538657-44c2-4ade-55ad-08d58157dbe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:26.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 16fe68dcab5702a024d85229ff7e98979cb701a5 ]

The SSI-ALL gate clock is located in between the P clock and the
individual SSI[0-9] clocks, hence the former should be listed as their
parent.

Fixes: ee9141522dcf13f8 ("ARM: shmobile: r8a7791: add MSTP10 support on DTS=
I")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dts=
i
index 516d62ac25a9..297a19de3c66 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1001,8 +1001,11 @@
 			compatible =3D "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks"=
;
 			reg =3D <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
 			clocks =3D <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>=
,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>=
,
 				<&p_clk>,
 				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>=
,
 				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>=
,
--=20
2.14.1
