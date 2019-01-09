Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E59C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEE72075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mz5Ea+0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfAIONy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:13:54 -0500
Received: from mail-eopbgr00047.outbound.protection.outlook.com ([40.107.0.47]:52304
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731381AbfAIONu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwoTh8l7KL5OmiqhQkTHUFuig6xYZpQp0xHtmguGmS4=;
 b=Mz5Ea+0oQUW2eekI7aGtxPc1nIhoaKRP/fj6dUhM2nYZiKSbIUisySthNYM3xNStQR+2Di/xvqDpgHaEAgQjz/Mxkz+NZOCGIoiEEnAC+7vGdhGTJEYFxBicmcQ/2Cm5Gn2GNrRjglNve3zPV7ee5nm74sLJxF0TCdQbxApA1LE=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB5157.eurprd04.prod.outlook.com (20.177.34.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 14:13:41 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 14:13:41 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
CC:     Robert Chiras <robert.chiras@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Anson Huang <anson.huang@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/10] dt-bindings: display: Add max-res property for mxsfb
Thread-Topic: [PATCH 02/10] dt-bindings: display: Add max-res property for
 mxsfb
Thread-Index: AQHUqCWG24WyMv0xAEqQZYodFazeHw==
Date:   Wed, 9 Jan 2019 14:13:41 +0000
Message-ID: <1547043209-8283-3-git-send-email-robert.chiras@nxp.com>
References: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0015.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::28) To AM6PR04MB4007.eurprd04.prod.outlook.com
 (2603:10a6:209:40::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5157;6:tj9/I8T9Enj0GRjlkiJkpDV/+X2GTCYCEhMrGwVBtq4pIJEFaNya9hrNFn/0e3dBEwvQy7HE3Y35VxROWgfe0IOSSCcBm4h1IqO0GwnEfPVKyI5xHpg35N8LiwU3YZzVVxhie9xe3CMUhiGBTERwunqogrSqneWrTjEFqi5AJXHRtyaoh5sq2j8x2hKo3SUE+Yot/1eL1lrm9XY+axM90QWkWIxye0736DREZOPCESf1ei9tIvP5YbIZ8jAOTtg7ODyR0sL+po0DwrhGyBHuHVU1tbshwrrmutp3TeBInSDkNTXjREr+TecPBEnAYcCz9F8own6uinUmPVuohoGmgN6rS01IHp4pdCaLvrOUGjqE+htkiaYVyzKlf5cK+lSpf7PkCdqP8XlQ4yxRbUPWmVZfd/5flaTsnF3dALY8KGNsskdgRgtKbM5MPq5guSB6dMJ3DUL6w2Mtf0bV+KIJZw==;5:3i3DtltVNaDUIj5Jd7jV/J5vbbehMkhLbEmDT1t3E9p3iKahIoI+zY8XS2WUwW7Beo6DKr/Q8IUirIFRsNKuzakx4ybbj5Y/oI7AImd4YR4ndmvaYkMmmcEfkfBl5dlpsVJECNk3bK3JStGQzgSD3dRztH8KqBmvb7Tx/ZI+Pr1N2RDvARuifUkZTaqk+PRtfQTCBOkWrfNeRDJVkJm7fA==;7:XG6sdAhTlXEMfGvuUW1Ss0B5aOf6TdXV9TffN/20U5oH9cXNVWDqJsBTrdFm/mb16ozycAoijCvQw/79APFRDSZemXi++Cm4oHZn4NfokkhQDhpkZFb5NFExjngZMyATwYJ1AvQzEHsCr7tFnlyV6w==
x-ms-office365-filtering-correlation-id: 7fa5995d-dc81-4abf-d923-08d6763ca853
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5157;
x-ms-traffictypediagnostic: AM6PR04MB5157:
x-microsoft-antispam-prvs: <AM6PR04MB5157008587D8382547ECD5B4E38B0@AM6PR04MB5157.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5157;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5157;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(50226002)(99286004)(11346002)(110136005)(2616005)(256004)(316002)(86362001)(14444005)(54906003)(305945005)(7736002)(8676002)(71190400001)(6486002)(71200400001)(446003)(8936002)(105586002)(97736004)(81166006)(81156014)(36756003)(106356001)(476003)(25786009)(486006)(6436002)(186003)(3846002)(6116002)(478600001)(68736007)(53936002)(102836004)(6512007)(14454004)(5660300001)(44832011)(76176011)(52116002)(386003)(26005)(6506007)(2906002)(4326008)(66066001)(17423001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5157;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gdY6JBo4mRximATXOEbc6cAPLBYROpTllD3uRQy+0Udq0u6KfmCDxwpHgdCj5Gon1wWIWFNoBcpL6eeweiNbw0+YROOwWNCf9ZQ0nLfMXBS44zsl41bEPYWEaRiz8Mt6Gy9L23KWiDRQbV9HkaohlUNFZKzlIeLxA5yFpIVJxx6eX0bovK9JV0f/JJhrnJHJRkH138uFgikbA8uhjYaQjphKL+5jWEjNzbfO6TTdXGYHcCtQVK5FOSg1A14DpSHxXP8ZK7U34viUqZeYuyOFE0jdBabfhXDumzyFZ1nVEfnTq6BfmgLrvgl+WpgV7/PV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa5995d-dc81-4abf-d923-08d6763ca853
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:13:40.7061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new optional property 'max-res', to limit the maximum supported
resolution by the MXSFB_DRM driver.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 Documentation/devicetree/bindings/display/mxsfb.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Document=
ation/devicetree/bindings/display/mxsfb.txt
index 472e1ea..55e22ed 100644
--- a/Documentation/devicetree/bindings/display/mxsfb.txt
+++ b/Documentation/devicetree/bindings/display/mxsfb.txt
@@ -17,6 +17,12 @@ Required properties:
 Required sub-nodes:
   - port: The connection to an encoder chip.
=20
+Optional properties:
+- max-res:	an array with a maximum of two integers, representing the
+		maximum supported resolution, in the form of
+		<maxX>, <maxY>; if one of the item is <0>, the default
+		driver-defined maximum resolution for that axis is used
+
 Example:
=20
 	lcdif1: display-controller@2220000 {
--=20
2.7.4

