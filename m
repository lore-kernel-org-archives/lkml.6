Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A7EC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C773D2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gvTWA9CR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C773D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeJOVNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:13:01 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:30160
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbeJOVNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcwUTNMoaGfHgDEWCp4IFCimYYiWDcpvCB29pVxGXr8=;
 b=gvTWA9CR2164WSYKt8ErLz1V7P3vqBcwJL3i4o5oSwNjNlrRBdmA+661wJUCKyYFrCzKKdaWiclV2czN3o06tMUMi5aeKqc9or/6IK3E2jhxSP7zb4o1mDTquxL6EwM0g2xfVkrlXl2KvjQnaqSG4ijMmS9f7zYixaulU0IXwWU=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4948.eurprd04.prod.outlook.com (20.176.215.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 13:27:36 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 13:27:36 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: crypto: Mention clocks for mxs-dcp
Thread-Topic: [PATCH v2 1/4] dt-bindings: crypto: Mention clocks for mxs-dcp
Thread-Index: AQHUZIrW9F9rEIQbEkCniL57XcBvJA==
Date:   Mon, 15 Oct 2018 13:27:36 +0000
Message-ID: <cc337772e1b7ed0c0884b5035c1d0bd4adfee10f.1539609921.git.leonard.crestez@nxp.com>
References: <cover.1539609921.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1539609921.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0502CA0071.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::48) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4948;6:Goz93h0PTf7FFI4wtPmA11zgT52AJAxyRCj3WKysKF8+ShCghz+tP77TOWTcthqKJicErlNXZhoQHoKuhtLf2h1Sur40f1EKj0eg575akRhAZpOFR3szFmG65WCaLDpozrIp1oj3E0P5QWBMyCVi+YJgJEK5E5VIhgX7NJg+RJho52VncNsQ3leAuIdXWq/ge+IPVyR/mvE4CqME40XV66CKNp2p76SFTEN5XXRolDggAdLwwgLVt+tE6kOex7o+53KslXBpRQbKrt01p+ZFvZohj5ksAeQFbE2qb73VYaypYlRb7AuiQEx4RMh4SCVd1OU0DoL0L8sVF5Bps79YSsCDM1O1xvWOdawWirBD+8ZQ8F4EY4DWMoVwia55osPdEElSl1dAkQCwGJ+fOXXHW7oFbj5rog3YOLIu9d21w/3rgu++qqyOUlJfiN6fZF0fVzurx8lbOx+JrJv5ndfAfg==;5:W99nRkLdXDYw0gsCJ2VXHL4xW8KHHqFQE7oZ5RmcCjXHHD1G/9fZVLpQmtuZKGNSt7R2hQluwmLE77jwcM5I99z9eofboNSDFm4QQ+M2sjQH00DT3VvWipHwVOKU/MJGGj/3XjGqI0ptjaQF97tfAtw2TBF83ZQFh9L+CeEeW8I=;7:YX2Aekb9BdvkgVLLhI6oLzq+2MTEfXbeaRIVWTUN4TOvO05AACjKClHK5f0xu2A6wSFcvcmMHGS9Zk0ErpgoqwwTqLKFmx6r93EA+R0kAVUQwcz3g586NgVlLZ4NZ77VPTtQq8rdBU+aO+SGO/nuHGOUV+o8AT5QyvFBPjPt1dVN/Q0s6vSX8fCPYsx3enpIypJjM3AdVPln+WX9j9Qo2ogZQCf//T1hHhssqfSzBAkV7mhMk9LTR8DmGYwYMwak
x-ms-office365-filtering-correlation-id: 396719bb-b11a-402f-4c31-08d632a1f893
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4948;
x-ms-traffictypediagnostic: AM0PR04MB4948:
x-microsoft-antispam-prvs: <AM0PR04MB4948C50CB5F2468FA2D0A41EEEFD0@AM0PR04MB4948.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB4948;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4948;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(97736004)(105586002)(256004)(2906002)(106356001)(53936002)(102836004)(52116002)(6116002)(3846002)(118296001)(36756003)(5250100002)(6506007)(386003)(76176011)(66066001)(81156014)(81166006)(305945005)(486006)(8676002)(71200400001)(110136005)(54906003)(99286004)(44832011)(71190400001)(7736002)(478600001)(39060400002)(68736007)(4326008)(6436002)(25786009)(6486002)(446003)(11346002)(5660300001)(316002)(6636002)(7416002)(2616005)(186003)(26005)(8936002)(86362001)(575784001)(14454004)(50226002)(6512007)(2900100001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4948;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EakfQwhE7sUQfbnCTSyZuqo7vQtSTMknGuthELBlKi7z/MUQETIxNXAX4DsYxh2U2OcESnJplYVZVnD0svRPoGITGX4ViJ23j/G1lpKMHzwlXWI1goNm+nIyi3YW7403+zKYGy3SiNi1WMsOtHYH7wp9jv8Ef64Iq7U7FwxOYIpyKu4HNHzDJCrquZU+HddhVcI5uh2YHf1nm4WRbQyQoCSzrDlWtSiZFMkdb9/uqdv6QVxpa+2pEt98zcB5O4K7SB0g+TBTt9STdiDutSjbc8g5XBcyClqhvSckexMxAKYXzx4YO3llzk8NoXqw2PaybpBYoEYOFegtrVz3DPO7RGXxKq7C8cZzgNAQYwAIx0c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396719bb-b11a-402f-4c31-08d632a1f893
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:27:36.4052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicit clock enabling is required on 6sll and 6ull so mention that
standard clock bindings are used.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 Documentation/devicetree/bindings/crypto/fsl-dcp.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-dcp.txt b/Documen=
tation/devicetree/bindings/crypto/fsl-dcp.txt
index 76a0b4e80e83..4e4d387e38a5 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-dcp.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-dcp.txt
@@ -4,10 +4,12 @@ Required properties:
 - compatible : Should be "fsl,<soc>-dcp"
 - reg : Should contain MXS DCP registers location and length
 - interrupts : Should contain MXS DCP interrupt numbers, VMI IRQ and DCP I=
RQ
                must be supplied, optionally Secure IRQ can be present, but
 	       is currently not implemented and not used.
+- clocks : Clock reference (only required on some SOCs: 6ull and 6sll).
+- clock-names : Must be "dcp".
=20
 Example:
=20
 dcp@80028000 {
 	compatible =3D "fsl,imx28-dcp", "fsl,imx23-dcp";
--=20
2.17.1

