Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86FCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1B720657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s8pE3BF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392547AbfAPLst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:48:49 -0500
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:27264
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392534AbfAPLsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwoTh8l7KL5OmiqhQkTHUFuig6xYZpQp0xHtmguGmS4=;
 b=s8pE3BF8tAXoU5XCpblFGWzI/huoMjjezE+Qi1PbrO1tUEYIe5+cikPZUSO1R253WyHCkR7ecpPb3D3glmJl+WdmsLxr/ugsoR0S09fAJlNAeoAiXxy4Yc3wzqziwfCgIysrGQ5Z5bTsIZEQI78Kc5gGvgEKtCKOwNnF4p2it/Y=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB6101.eurprd04.prod.outlook.com (20.179.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 11:48:40 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 11:48:40 +0000
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
Subject: [PATCH 02/11] dt-bindings: display: Add max-res property for mxsfb
Thread-Topic: [PATCH 02/11] dt-bindings: display: Add max-res property for
 mxsfb
Thread-Index: AQHUrZFsdA6WPKRvzkKgu8MjAEIBog==
Date:   Wed, 16 Jan 2019 11:48:40 +0000
Message-ID: <1547639306-19151-3-git-send-email-robert.chiras@nxp.com>
References: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:203:91::28) To AM6PR04MB4007.eurprd04.prod.outlook.com
 (2603:10a6:209:40::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6101;6:VSP0gt+DmekzQ4M2oJwksTLpNzelfcXHxaSLTAUSvuS/zuVlgLpvnL3NExuGh8FFCIQD6bW682BBhHm21Bgc9Fva0iBLMBaf3Pd0TuiWSxtKOgI5FXfOsZurkzuwFrEUr9fL+1WZw1Q2Cmzvf7zRe33nryMb5VydOi/XHuou3CLHVR5DGMXkFK5/ZiZOXIo+Ec/WdGtdPQH0Y8UJC4TPQYEjqiOSVS6n6QhEk4416vKwSLyTJRZKYTfocI8kfERtAAP7qqkvdqQAaqwDB6ie0tyPzbj+1DfAfZc47DEIcVNmBDshrOM52VU6O4IuTR/wSGqjKVVwVOqHJ96+X9A+rcxerMuy9hdY4gBlhVA5dLa2X1tNKhLL2Ots9JAnfgq3JRBIL+5St3lyvjo8G9ZAV49atEiRWdoue81LYM8Pl5tJIDLiprp0JN/YkSfbODa3Za/sYM6TC/jJMN6BqFBV+Q==;5:uf29pIwZnyfNKIqCxNhu5Z5/HmlgEaBYGZj9u+jqiygD5ns6dsKjZ91veZUMVwfiV+yg45E/psaesmc4JyBlNRRHFPV1MU7V5gaqXw/KNHm3rBMScpbOKn/+6O5AIdywq2v/jkWZHdd7yosMCEzV4syzFbMzT24SPJ/AZSnO716Ww9iOUna6IRzLmjMYeUlDc8TOGxBEPP/FQ4gw5DFzMA==;7:V9+sKAoNuzhsXJ+ih/GzuWvgWB3E1rMmkm7v3Gb3MjwEwRXsoFWSAjRXOewFQ0XVaQA9T+eP/qq27nYPyLYgVVdP9jYdx2UQsJ/S5mSjcOLPBellf0+6XozcNfPtezgOq1Y6hA5iw9CnMRgAKKptJg==
x-ms-office365-filtering-correlation-id: b570ea9f-c3d2-44a3-756c-08d67ba88ec9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6101;
x-ms-traffictypediagnostic: AM6PR04MB6101:
x-microsoft-antispam-prvs: <AM6PR04MB61013656456C11073FDAC769E3820@AM6PR04MB6101.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(316002)(81156014)(110136005)(102836004)(81166006)(476003)(4744005)(26005)(2616005)(186003)(8676002)(7736002)(66066001)(3846002)(50226002)(105586002)(305945005)(6486002)(8936002)(99286004)(54906003)(6436002)(106356001)(6116002)(86362001)(2906002)(44832011)(14454004)(478600001)(486006)(71200400001)(68736007)(97736004)(5660300001)(53936002)(76176011)(36756003)(256004)(446003)(14444005)(11346002)(25786009)(386003)(6506007)(6512007)(52116002)(4326008)(71190400001)(17423001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6101;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Py2jcMRvSWLW7HBtMvlenQb90/rPGRLVNMjYNrbaO2icrZk/lX77sTQqp/Wv7jsgod9KnO6g8DYbqZuHRtoADilB0L+A3kjkMF7mv7jHhTX4NjMPEyteUuBOAgs5IewX0RxMWvD+UDK9/nnU7UhqRnNIpAdC6xG7KAt+bhKOvh/igyG+WqwP8uAGGqGroOBCTRAtYjxosqRlvix3XV6c7fyWOLxLF4KNuZ0m86QQq2uvV/5JB74+ZlAh3+z0tYwGETp3jr4eh22v/eMepMNdK5O3q0smzVSYZXfYE9SEkd05DnlcO19E/TahLkySsDY5T8qBXWikn+RxxR0QUt7eUEm2O1o3FHD8lSBa9Nd3wso4RsLEoXhICupCRHnB4HhtCdAcEAVcPdqZaqAVdPSP2+4ELlTwvVqqf962WP5bWEI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b570ea9f-c3d2-44a3-756c-08d67ba88ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 11:48:38.8605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
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

