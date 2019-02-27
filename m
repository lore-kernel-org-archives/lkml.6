Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80838C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48552218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rwpf0R+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfB0Gi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:38:26 -0500
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:57376
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728905AbfB0GiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLHoTSu9Rz5KrOlHShbrJdLSTERMzY/r4jRfYY1HnrI=;
 b=rwpf0R+1JX6LpAFCZvzOpD/rWkPFhpNoJGU3rRzR/nUw3iJA/8om+a4ZJOLPbdds1abCH6i42lQUO4lsuiwzzRVKdp7mtY8OpQ4f7XUi1QhK/kZk3GMUjKW85EYGSYASek2FYNQx7GspShzVjVXfPXqDBKPHzDH0rwwPeVCf+C4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3615.eurprd04.prod.outlook.com (52.134.7.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 27 Feb 2019 06:38:11 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 06:38:11 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v4 2/5] bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma
 compatbile string
Thread-Topic: [PATCH v4 2/5] bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma
 compatbile string
Thread-Index: AQHUzmcCo56FvYibTEqgPhhCDNzweg==
Date:   Wed, 27 Feb 2019 06:38:11 +0000
Message-ID: <20190227063737.24445-3-daniel.baluta@nxp.com>
References: <20190227063737.24445-1-daniel.baluta@nxp.com>
In-Reply-To: <20190227063737.24445-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0152.eurprd07.prod.outlook.com
 (2603:10a6:802:16::39) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60684519-0efa-446a-f9c4-08d69c7e2451
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3615;
x-ms-traffictypediagnostic: VI1PR0402MB3615:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3615;23:03CycgKd8EeH+RkK9bbBA3q/PhF8WUKkNZC7N?=
 =?iso-8859-1?Q?3wLYSBMnHNFCZoH6MuQXmzX7qguWhsDToRbZdfsvNEuGAS0RTPOObpPWhg?=
 =?iso-8859-1?Q?1ELSwK1/st7NJlWjguUxtj2NgZkj3nCHOsnu2EwutjuUUQYuqwg3e31wxp?=
 =?iso-8859-1?Q?8XRK2I6qsjNXMLrvOuOxqs7wc7wFfqBjZhPOnZAt6isRBW9XF17SemSF+V?=
 =?iso-8859-1?Q?iY2i4XxdwL17diBLjblfkdPzzgYU+Z0dHTl61HbGIlZfSviOSwcR7b+YNw?=
 =?iso-8859-1?Q?ilUjOF1WTKfM4t88nLpzXWmNFWOZSQuhKfeON3Cm82HKfr1qWmdbTdgk6T?=
 =?iso-8859-1?Q?3OoZQEYREoUSNsZue1QaHYN+QDfWDCG9z7/H5C1AwBilOsXH2hmEnI+aXs?=
 =?iso-8859-1?Q?1oEd2+qIf0Rxrjw9oJ8Z2vUIs5PcEYyUj3jkQUnaLtcZHMnBLc26XsrdRE?=
 =?iso-8859-1?Q?2ZrqBexsOdvPt2rldQKQpByxuZgjgo1V7n8GbGJSBgQUxDarylGK2BxfNC?=
 =?iso-8859-1?Q?tdTDCXv7/Q9IDdyQX5R+Wuo5zFmerVjXTsz2Iu9MUxzA1yY5XllE1ZFHOW?=
 =?iso-8859-1?Q?n2nyTvYn3B3uv6QHGBxDPSDIgI4nntnYbPfkwI3jnSj3NmEaVVKu3AtiCi?=
 =?iso-8859-1?Q?PCjvViDWMMK9mx+WD3qzmQc0hdNbjrSKfKDInjZYef6FIqpl5wrikGN09h?=
 =?iso-8859-1?Q?XhQ6dLybQ6Lg9zn2aiMIxx/lklLpkL4s+X/c1JKWEJBZOynOXkEE/HOMk1?=
 =?iso-8859-1?Q?kWi2S2sNtgbDwX28hAjURglZz2EciD4I7Ea3mpPKJmFoRDycfR5SLVjoff?=
 =?iso-8859-1?Q?QWm2yJL/de5CY7rQO1DIlZb5/k0DS2mgUGpcKPTp48MJosyjzI2kmYO422?=
 =?iso-8859-1?Q?AaIRVf5EOiRbO/kShWfoNWy55PP48Nu2fWRF6XEvDLbKuATRRUKzI44yFN?=
 =?iso-8859-1?Q?gxa0XAOU3W8j0IcA0srFJvxMC+CH9QjVCmaidbIoAzV4MHbpcXgaVZWXao?=
 =?iso-8859-1?Q?ekHL5nZGWR9PYaN4SFo0oYgs3WLAFHY32YFT09jqzZg05RRuxBk6+dcdPm?=
 =?iso-8859-1?Q?RQB/LWFaBzERS4Swo0A92C797Bof9ahVj7Rb7beGBsIbBty4rcD1YWMUb3?=
 =?iso-8859-1?Q?Wiw6x42zu6B84X8RGeTdUZtmb9Ln+WEAMxOdmKlVd/Djz/e4yjRvwSBlh9?=
 =?iso-8859-1?Q?EnUO/k9zzYrtfiiPKLyiFz/mTXQpCvZyIWW5eJTqBgXsrLQwj7BvMHUHxV?=
 =?iso-8859-1?Q?yAqkX0TnYVRAJZMuNtqb+pqI7zFIi3ufffUrYVarvRdjdp1tgF2Hf0Lqxj?=
 =?iso-8859-1?Q?nUIxpsPlDh+HPoLq+CmuPY5iHTtN+Pvl1NybgLK4NBObAoD11OGoDGsqRu?=
 =?iso-8859-1?Q?2USwni2v0LBMOU/lWyZjFpYTtL293aZeGhmCghk6moqwWyP4gsSqQoKCfQ?=
 =?iso-8859-1?Q?RCYEn+CGBb4NtBXU=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB361549DB9DB035276DFC5032F9740@VI1PR0402MB3615.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(2616005)(446003)(71190400001)(7736002)(11346002)(97736004)(71200400001)(305945005)(66066001)(81166006)(81156014)(44832011)(7416002)(5660300002)(26005)(105586002)(486006)(68736007)(106356001)(6486002)(476003)(86362001)(1730700003)(8676002)(2351001)(1076003)(4744005)(52116002)(8936002)(3846002)(2906002)(36756003)(99286004)(316002)(76176011)(6116002)(25786009)(478600001)(53936002)(5640700003)(102836004)(6916009)(54906003)(186003)(6436002)(256004)(6512007)(14454004)(50226002)(4326008)(6506007)(386003)(2501003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3615;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qZ1RsSZKy/s/4nQWkixNo8nn/nySJ1XqDZ5kJFGcG9MmdFSSBMul/QSRptcqIsVEa525vt/lTbvhJXIiolcNHoe7xm33w0mZPkerPX3d7sBAbaCgfkRzyjgnAEDZG17qtoIizoeGLLvRLR1Pnl3FM9x/1jI1dBjpsgRheAqMwIZXvTmLHgwruYW7QuGJ3YDggLbmF18uv6FnNIjZMUS6WNAuAgStnyjJ+2+naLbR14ts09JfLuo5mEBRKrheJTFGbrsby1Ksrusjy1xwgAhjESilJM5XRhnetvHow+cEKXOFrotLIT5RvOJv0Kkht2/xbg8tAh3iY3A5Wg/dL42HYpCEnUmKiLgO+aC/fTr7X7wQTwMDFUBx+gfqIfo7rLkvX4jVueMI/b2o1U72mgGh8B5hyw5Tk8kkkZo6SLr8iuY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60684519-0efa-446a-f9c4-08d69c7e2451
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 06:38:10.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add imx8mq sdma support.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Docum=
entation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 3c9a57a8443b..9d8bbac27d8b 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -9,6 +9,7 @@ Required properties:
       "fsl,imx53-sdma"
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
+      "fsl,imx8mq-sdma"
   The -to variants should be preferred since they allow to determine the
   correct ROM script addresses needed for the driver to work without addit=
ional
   firmware.
--=20
2.17.1

