Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487621-2-10949583168545620860
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487620; b=tw958yig7NxkXkJOAYYWca8rJSD26EDotmqKOMzCzfrOm9B
    rapkmGZy+gCLFY7Y0DELL1YitB8NJa6nC2Srlp8kQwx3W2EX6Eedbgy8ATUV91IY
    R+6XhO3f10CLF2WzrOrvSWznaYrKai3jvY4gSFfPmIRLvJ/WFYeqizxO9NSKTn9t
    yxw49jYxMMdbI1DiMo8mg3sSUmUlvB9QaSAXybAWvG5mAk4HWHPlZX6+w+sS3Xy7
    YI+Hkrr6C0dX+72N3nVdk8C1fHPWjVB5Jwtnzo/Wtxpy373XfIvCXDVbfGAzF0rI
    qV2e5fK5uEDBbvpW0jIfuSWeur0AMt/fMoyTRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487620; bh=TeLtpx
    2CyY5sKWONIel1/U0U5QqM8NQRwtO3j3Xc6i0=; b=OVpT5di41xPDNGDRl65Enl
    7JEXwcl+AtObN+7hWZrW34MI2u2XFDLWwl1ZsWNyEfZPsJydxBrnOqcptxTinCOP
    SWgOjTsrCkGCJKEU3zPYx9b0tEuEYhD0rTiZLNsUyGAtmsoH7I480q4eEFzgSLgD
    Rj1OZhb7i5NPdvfjQ+Rixu2w82RpRR4Q5utSLTq4HHdjrs/b1GjnSJMEnqNQDMw3
    I+e2loHbp2gOfDUNvEcUTPR4e48wuq8xw4E7TZo2rkYzA1XVu+Xm1/OKaUXZvX2T
    s9M3dUmbFN3RFJp8PBgPIk7zuUghByZwG8Oc/l5GU1AYKXv+QF2fiKmNnFwNrc4g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b0KwrRzx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b0KwrRzx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966232AbeCHFFY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:05:24 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:10302
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966190AbeCHFFQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dong Aisheng <aisheng.dong@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 012/101] regulator: anatop: set default
 voltage selector for pcie
Thread-Topic: [PATCH AUTOSEL for 4.4 012/101] regulator: anatop: set default
 voltage selector for pcie
Thread-Index: AQHTtpp7Vi0L78LOrk2/qO8cxNE4qg==
Date: Thu, 8 Mar 2018 05:01:13 +0000
Message-ID: <20180308050023.8548-12-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:pTrMYUZEWibGxcutpBsHBvAAvzK5sTnAMr1/ZLmjpoyV19ycwmMjQIBY1Ukg1C6oFeZAfIneDiKr+i7EbDwSvnFNjEPQRVLEhcsRRh354B8Pad4v7Gbz8oefKUGK9gHiTXPcxQw165w4qk0ib5oO6iVrUakPVnP1KgKILAhYhEd9Z4IB/R7bvo/GjJCYv8BoYuQMVDPSJmYaJE51PR2jYLG5egPZWXTaeRPkCxtAF+aalttM5YaN0pyTcH5ioVMx;20:tZTOYFPUciD/4m7vtw1yKRwsr6MiVuC6c4shIfTcYfmnbHwXrVc1Bi8qZKmfpeWFdNLHbVvl4odOLXr4ofk/qjUa0S6rN5duGyb7OBG30x2pAkLYR08gFX7gXWr6Khq1hhgrBA5xN/ZwcOE240PxG16Uliuk2pDvxs5+VyUhZXM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c694213-94df-42b3-86c3-08d584b229fa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727C95BB0DF6DBB56EF76C7FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(39060400002)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(5250100002)(53936002)(8656006)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: UIyNq0S9KR0zOg2k53/DNLR2dwDpYcTH3p/D/vdUUjurRbnNljpTg7Y+2Gy76vmpa1CKvEbyXikCq2FFX7QCPGz4r6yEqAO+aiNHVBPFYoPfAAxxbQHKThsQAWQtbFwzkHuPsu5KHzRvowJOlbHSH4Ee3e0dcXqr3OVeeYcQOIvct0xO4pMw/SFCbaqpQEDtCrvfKq2E2nNniOwvlY0JvETpKSE0Vccdq3q2xsc/gylLHSCkaLZRQ5sC9AS/0Rwat8fu41tkjwIS91jNWGyRcsVRTMcnYhGu6IsroFwf0fHtckcgMADcWpU6rqfwkGReVObVq/X9W+ELvGkS/0RkAg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c694213-94df-42b3-86c3-08d584b229fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:13.6274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dong Aisheng <aisheng.dong@nxp.com>

[ Upstream commit 9bf944548169f6153c3d3778cf983cb5db251a0e ]

Set the initial voltage selector for vddpcie in case it's disabled
by default.

This fixes the below warning:
20c8000.anatop:regulator-vddpcie: Failed to read a valid default voltage se=
lector.
anatop_regulator: probe of 20c8000.anatop:regulator-vddpcie failed with err=
or -22

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/regulator/anatop-regulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anato=
p-regulator.c
index 3a6d0290c54c..c5e272ea4372 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -296,6 +296,11 @@ static int anatop_regulator_probe(struct platform_devi=
ce *pdev)
 		if (!sreg->sel && !strcmp(sreg->name, "vddpu"))
 			sreg->sel =3D 22;
=20
+		/* set the default voltage of the pcie phy to be 1.100v */
+		if (!sreg->sel && rdesc->name &&
+		    !strcmp(rdesc->name, "vddpcie"))
+			sreg->sel =3D 0x10;
+
 		if (!sreg->bypass && !sreg->sel) {
 			dev_err(&pdev->dev, "Failed to read a valid default voltage selector.\n=
");
 			return -EINVAL;
--=20
2.14.1
