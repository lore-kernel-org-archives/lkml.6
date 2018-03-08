Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490748-2-337680352906323197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490747; b=n+M/XuhVLdMg1ZQ2TV8E9AmUcBMxiRaE5BhVtwkAzuVkMpr
    aClpgDAAua9MHea4QfSfCLJkTVQz2eIEBssRbsiETJVaW2J4znzL1EHjLsWgLbyx
    KrMrQ5asIN+Cq9mDUt26KFWBHC8DJXBritgy7GCdLsNuJA9ITIrAMvevUSxZGJea
    ZTkfNL2D75h0oBfZPwFD5o7VwhbKX81VrgKSASKREX3Xw3yqj4NWacxC2XvgfuN9
    K/dt6uissM1+pmT9ce67AlRkGXrn5beqWNnRK53YxI/75eXV0m2eGQhV5Hr3xpyQ
    q85/OO05uGPVRz1cBMUJL9dXBjz6UGa+GuiJ6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490747; bh=CvU2xT
    RncdkMGYx8E7xz5d90UT8oHQcuDmtgZ4lif4M=; b=xBdlVEDQES1lAHEj6Q2DKm
    byBB/EmrIj9RLZc3+2xsig4ZJpHSScoFYr1so55W9H5PQkgc8o19pjmxae6GuI/2
    Hzk0uVTqW6btFQx0wRd313+hEE1vGjGd5xjET807tXYX0/AR9p43U8WM63hOw0NM
    BxGSsw5hOw2DIhZHSbv5pcHK7yXiTHKBeTRbHZqawcXdr64wNBvJNu21O6fnvUan
    dsDy4dWiKOcC+GOHZGP6KuVoe2HS9F/WqPhoOr90Pf59slZ2D1xsSXRTiQ7d4AJa
    bVsfVp/az/Hy0JQEF8I0pCGjbcizARqBQMnB0ifEpTHDorOcSdeRyIkMoIKhahTw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D67CsjVC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D67CsjVC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755411AbeCHGcY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:32:24 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:44208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965562AbeCHFAD (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 016/190] clk: qcom: msm8996: Fix the vfe1
 powerdomain name
Thread-Topic: [PATCH AUTOSEL for 4.9 016/190] clk: qcom: msm8996: Fix the vfe1
 powerdomain name
Thread-Index: AQHTtpoqWaYV1g3TWUiXSANoXlFU7w==
Date: Thu, 8 Mar 2018 04:58:57 +0000
Message-ID: <20180308045810.8041-16-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:rrXlHn+qjMTgHhgbc+NWGqNyau/LISZEPSTUDPCZVrr/yn52/z/FkdCAgT03kpBn4CcyexVdxbP8jL4ej2Dh+YnlSe3COBTnyjjAs9TVMbaNE5aSsAWdm7jfAhB436ZUrwRWa5j3fvWGMAuokQO2JYMj3gnYMko+4aMaeAD+fnUVKmDY0DqMSOlCbi5EyG0SfnJaeSa4IiRmg/6wqglKLug2ElohW4xT6a+zZERe4E9uS6wMnNJVCFnbTVOg5jWF;20:G/ISRZFWIfDn/+LGVxl06BDAToU91jsqHum+GBcfpxm3nf9lfqglw1RGo7zf5EeRjj+opU5dKQhZ8diCByF/wuzSsP40VTdGsOp+EJStJC4VPos3iA5jQO7/QCpeA8KOrZyRpYvrAYgpJNfrIIsJzhfChc3a50P7sUZwWARoJtA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd9e75b4-4186-4c0d-67b0-08d584b17112
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983BB06CBFC87E35F8E031BFBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 3PhqXNjxc6SdFI4QfeTWsdADqUpO381kiDrHAeW0suJwPeSH5/ITVTpJzIkB6kX+/G/XsNlcCxbo4SE7DTeFTW/2bq2jPUYduDhtSHEl7jTLxyCjJRQmPLUXQm2H/U3VvoRlotQmoAFHUyP7kIo6jMC5a4OxiN1xHJaB5XWMtiDAXj7IUG9p/83pf7U1UB4K7GIV18oQ+J8ZOcJkGEJlAi6GNBznXOUUhArfw329YOYk6KUjleSKFxLouxePttZ+MQOg5dpm0S1v+3a4d74lVFfjeyzvUhfFhHu5Q2BlCW5vKFsg3tkBGeaUOgbHuxp2Ta/jsfZ8KlTEFNKCX1wRSg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9e75b4-4186-4c0d-67b0-08d584b17112
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:57.0708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rajendra Nayak <rnayak@codeaurora.org>

[ Upstream commit a62ca337b36e31621b582cbe8f17d9404a48e120 ]

Fix a typo which caused both vfe0 and vfe1 powerdomains to be
named as vfe0.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Fixes: 7e824d507909 ("clk: qcom: gdsc: Add mmcc gdscs for msm8996 family")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/qcom/mmcc-msm8996.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm899=
6.c
index ca97e1151797..3b171bef913a 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -2984,7 +2984,7 @@ static struct gdsc vfe1_gdsc =3D {
 	.cxcs =3D (unsigned int []){ 0x36ac },
 	.cxc_count =3D 1,
 	.pd =3D {
-		.name =3D "vfe0",
+		.name =3D "vfe1",
 	},
 	.parent =3D &camss_gdsc.pd,
 	.pwrsts =3D PWRSTS_OFF_ON,
--=20
2.14.1
