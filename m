Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4EDC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05E92080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AJax5weT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05E92080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeJWSAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:00:32 -0400
Received: from mail-he1eur01on0070.outbound.protection.outlook.com ([104.47.0.70]:21493
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbeJWSA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTAqCCACinXAuZQNte12dKQSA+UtLpD4EpPsu+Yo1dQ=;
 b=AJax5weT9jIWu8c82TD/BkEhf1BjymCq70E3oNTDVPqi4OYJnIRKaOT1OMKtb/UOZzFdZOFlaSSF4vznzoEhEoJkgjWbJeA85OMSQFxfAhP+Eoi261NJBnuALG4yo5tiOXIOqnS7sxJ9xc2YL9aRDoJPW6faTKzq0lo5U/59w7U=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5022.eurprd04.prod.outlook.com (20.177.50.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:37:45 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:37:45 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v3 7/7] arm64: dts: lx2160a: update fspi node
Thread-Topic: [PATCH v3 7/7] arm64: dts: lx2160a: update fspi node
Thread-Index: AQHUarQNpTOpT9Qzw0WWWurUQJ1BSA==
Date:   Tue, 23 Oct 2018 09:37:45 +0000
Message-ID: <1540287311-1572-8-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0141.apcprd04.prod.outlook.com
 (2603:1096:3:16::25) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5022;6:4S2SNm8L8wqiH1RhyrnBCV3sn8jIJDj18vtQcTszVnQZOUiF5jz8zO+L1F4NwPU6MOeZ4aoAWcs/0TIF7bBwGsVQCqJk0TnOVCR95s22qCm0cMHC7pHLtYpGAqbIiOsw+26u0HDlVjIBG9SWEZVx6wGe16DRedUpaytPRPibCJmTj6HkHyz4EWqxkr8JN9gcv2/XFp5DbkdWgyqtc0ebreCwN12Psv7JXPB2EBpjwTEscFogSltKqWNEwZjHvHez4U5s/AguVraH8Y97+merJk9EOyG4BgWORa+xFU2R/4MhKoqH7QA0pIOitLV+C0qpBxWhlgFySNR3VKuTA5ORykTtaYYfPvLjbjBm3zxbPoW5mgXG2KCYJRDNd15qiZovf6mLcWe4W3DEtBhBVZDJJC82TtPTjSdexN3pOVhUsU4d818t2mwYeuonaAG5wtK760fGTP911U1P/sID4pA1VQ==;5:XjmPgOzEgJIoba8eeT1i01/sWW6zdt3IuAD0INxjIZJuhnRowahvuc1wPddI0nEsRWVNT0sNYAgdt0yehhjr5xTaVcqnY2EdgRwOfAOngTEDy7GaDOeobM5EN/nIcwrrHfvapZXOryNoj6UNBcyEtWan2nZdJnyO063Pj7dWvh8=;7:4YnKUuE1MVlio2JPCdffG+RaWbeHUMKbxvdV6WEv67vuVrWcAmRTrQ3MLfQ0h427UjC5/Q5ouzG1Vlg75L3k5w1QcD0+dzbosEbv358uBzbjb7rrIgQAJAenrMmk3kmtHLJBc7pQ6vHRRdRqE7B1giKHdQqsRZiU6ME9SJxJ1esU6/RyKzqhs+MxrdG64ZbTapdTL3fNwrSsyyimGo879jcWTe2k0O/nOZazb3SVWFgWwb73vq5pw8G2pS2NYKmh
x-ms-office365-filtering-correlation-id: aeb0008b-4a5c-42f1-cad3-08d638cb2f71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5022;
x-ms-traffictypediagnostic: VI1PR04MB5022:
x-microsoft-antispam-prvs: <VI1PR04MB5022510978FDF5F16ECD309799F50@VI1PR04MB5022.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5022;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5022;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(8936002)(256004)(6512007)(106356001)(102836004)(446003)(53936002)(71190400001)(4326008)(71200400001)(2616005)(54906003)(2906002)(26005)(55236004)(110136005)(476003)(105586002)(99286004)(3846002)(81156014)(7736002)(6436002)(305945005)(81166006)(7416002)(6486002)(2201001)(86362001)(186003)(6506007)(386003)(2900100001)(52116002)(11346002)(478600001)(14454004)(6116002)(8676002)(66066001)(486006)(36756003)(97736004)(5660300001)(39060400002)(316002)(76176011)(2501003)(5250100002)(68736007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5022;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yKqvWg7ceVIV1fDzIdnW8LAgfPYZzaKJsr2MKQUubZsn9q3qIT10UyMbU7QaEkiVYae/ypO+Ja+wZDprzWKuCsOCrOEEgx3VygNa2ymD/jiMeXYEwUxP0eAQmx8GUdX83G69BsNEldFnBYfPXeO8eWcnf/iFd1C4bLG4ucbZqBVJFmyi25WJugTHupLFs/1IfGhjQ0E8gh1LUmP+tU5Dz5ds6mfPUIjwa5xc1jLNjyY7RZSyuSEVvprhWUxWA6n44FBmUmmYiAe1gRxO0/lmSWdpcqjPp9aUzDTvxRbEK/LDwjzgIrDUDRiZvZFrK1vUsWlvyDX1+9w87OYwdv/c55vSfKbq5teCytlaU27xNpY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb0008b-4a5c-42f1-cad3-08d638cb2f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:37:45.1251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flash mt35xu512aba connected to FlexSPI controller supports
1-1-8/1-8-8 protocol.
Added flag spi-rx-bus-width and spi-tx-bus-width with values as
8 and 8 respectively for both flashes connected at CS0 and CS1.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v3:
- None
Changes for v2:
- None

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 3b20c97..24cc41c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -45,6 +45,8 @@
 		m25p,fast-read;
 		spi-max-frequency =3D <20000000>;
 		reg =3D <0>;
+		spi-rx-bus-width =3D <8>;
+		spi-tx-bus-width =3D <8>;
 	};
=20
 	mt35xu512aba1: flash@1 {
@@ -54,6 +56,8 @@
 		m25p,fast-read;
 		spi-max-frequency =3D <20000000>;
 		reg =3D <1>;
+		spi-rx-bus-width =3D <8>;
+		spi-tx-bus-width =3D <8>;
 	};
 };
=20
--=20
2.7.4

