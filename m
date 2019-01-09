Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCF1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EF120859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T6VQH5Lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfAIONu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:13:50 -0500
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:4544
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731154AbfAIONq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59szHa/J00T8soUfxZmHlJfS0uZ5kTQvpzaKv9KPxzQ=;
 b=T6VQH5LkcMOKuPvYLPClyeQr85Xk6X3lLXXuechDz0q2PrNggGBX8ygnEHDdAm4lpqa3NhX1iMviU2PQs9yqocAmlCXdYWOtFNQN8fXLFcooFCEGSZ2MnIA2CUkV9F8YZ3OJbPt+89A6zEQPKh8iYwwwLzL+nYUoaL4aN6tTsds=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB5157.eurprd04.prod.outlook.com (20.177.34.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 14:13:39 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 14:13:39 +0000
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
Subject: [PATCH 00/10] Add support for DRM bridge and additional pixel formats
Thread-Topic: [PATCH 00/10] Add support for DRM bridge and additional pixel
 formats
Thread-Index: AQHUqCWEXtisTM/gQke6JWnDvUfQ7A==
Date:   Wed, 9 Jan 2019 14:13:39 +0000
Message-ID: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5157;6:9Rcu/gdA9Vu9YF2/xczHuanyR/rOzPZ8JPWKNJFQVdkO42DWsPBXALaQTIxfYK6/mKR8GpIT5ZyTVVqazWZdNrUDK39w29O9fpF5lCwVUiaxUaJQaM2RrAZUiIAXnhZ+/Ha4xdW1xVvUSJ4/ZPYdiRxWxxYvvZidF5Kji2tK3JtZO9f1bEMRa3VM783VM63I2g8n0CEi5KWYfKkKOcKEftHRNfJ9MEu8cD33sGh2UJw76naNbazjnSys4jGl8AdEHd3kQC3zFhwlXzZG12iz0MdyBCS+HtKJ1JXzZyazbpJeSN1MI4bonUF+Xo9Ywe4nWvlDwLaNdYePD9m3iki7xnkBpfsCUouXOWng12HTgsoI/Q0Y7K7Blv0YKvazzeP4SohSei03JHRWiE9ww+HYxkEJYlU7G8kdwaRzTfdUHurxcUHbsRLRCiS71RUOo3SnprTtbTdmNw0+KAPpUXR5Rg==;5:EZ+V/kHwbjmvFOzQHBlVRbeyTl+n1oyKDYDc464cUWGqCN6uzSeOqluEyn14DCIalTHAmr2pBMmuXYMwb9UC3bGMbrWBtb2DQFWiHailHJxs04v2F0vZw0eNvAZiGEp+uL3q7M6sHfD6xFkifr3BYxq8tG/DtirPI2BRJeZco20ugIIaZerLjE4qij/xL2HHxHftO7wkD739xkF+HV7P1g==;7:LLk9vwN/QmpRBl8vqAKoG3hQoByVE42+96ZwXtPackV6DqnJYgy8crvIP0jVXMMjJEVEMTUozrtnhgKVImRjc3YeAThq+haKJixQwHiXHIwpObtaSanf3kl0YBSq1YR7wufsDDVW+6PqEt150dlfhQ==
x-ms-office365-filtering-correlation-id: a9a3b2c1-a604-4f09-ef8b-08d6763ca6c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5157;
x-ms-traffictypediagnostic: AM6PR04MB5157:
x-microsoft-antispam-prvs: <AM6PR04MB51575613BC5FC6CED344D863E38B0@AM6PR04MB5157.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5157;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5157;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(50226002)(99286004)(110136005)(2616005)(256004)(316002)(86362001)(5024004)(14444005)(54906003)(305945005)(7736002)(8676002)(71190400001)(6486002)(71200400001)(8936002)(105586002)(97736004)(81166006)(81156014)(36756003)(106356001)(476003)(25786009)(486006)(6436002)(186003)(3846002)(6116002)(478600001)(68736007)(53936002)(102836004)(6512007)(14454004)(5660300001)(44832011)(52116002)(386003)(26005)(6506007)(2906002)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5157;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n6jcM5ZjasixFuUr4n1oRBit/OnCkMJavEz4r45YFttQluH0/S8tOehH0wW+H17DqsJ42YlvIyjsFg4rHJkRqlwa4xgomcYA+MGJmOaxw6JIOh+7ft8/Tk1kXD1qSKfeDDZi1u2yJPnzsgQEx39/aGY1iXX6JredwgbJ/7Xvi6tNF+Ux0txipUxLi4VRy8OYqO/qEdiYlMV1JWcJf3fxfYmb+/eIkI4I7j23SW0FR0ZHIa/RLvqqzPgiQLxDsyhcPDB09CuSKjxNjxMaPAKqZPycI2gbw4dUJINoDv/tLJeMxvVvVXPb9q+UGG6UGTzE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a3b2c1-a604-4f09-ef8b-08d6763ca6c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:13:38.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset improves the use of eLCDIF block on iMX 8 SoCs (like 8MQ, 8MM
and 8QXP):

1. Add support for drm_bridge
On 8MQ and 8MM, the LCDIF block is not directly connected to a parallel
display connector, where an LCD panel can be attached, but instead it is
connected to DSI controller. Since this DSI stands between the display
controller (eLCDIF) and the physical connector, the DSI can be implemented
as a DRM bridge. So, in order to be able to connect the mxsfb driver to
the DSI driver, the support for a drm_bridge was needed in mxsfb DRM
driver (the actual driver for the eLCDIF block).

2. Add support for additional pixel formats
Some of the pixel formats needed by Android were not implemented in this
driver, but they were actually supported. So, add support for them.

3. Few minor features and bug-fixing
The addition of max-res DT property was actually needed in order to limit
the bandwidth usage of the eLCDIF block. This is need on systems where
multiple display controllers are presend and the memory bandwidth is not
enough to handle all of them at maximum capacity (like it is the case on
8MQ, where there are two display controllers: DCSS and eLCDIF).
The rest of the patches are bug-fixes.


Mirela Rabulea (2):
  drm/mxsfb: Add support for new pixel formats in eLCDIF
  drm/mxsfb: Signal mode changed when bpp changed

Robert Chiras (8):
  drm/mxsfb: Update mxsfb to support a bridge
  dt-bindings: display: Add max-res property for mxsfb
  drm/mxsfb: Add max-res property for MXSFB
  drm/mxsfb: Update mxsfb with additional pixel formats
  drm/mxsfb: Fix the vblank events
  drm/mxsfb: Update mxsfb to support LCD reset
  drm/mxsfb: Improve the axi clock usage
  drm/mxsfb: Clear OUTSTANDING_REQS bits

 .../devicetree/bindings/display/mxsfb.txt          |   6 +
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 | 215 +++++++++++++++++=
+---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  | 187 ++++++++++++++---=
-
 drivers/gpu/drm/mxsfb/mxsfb_drv.h                  |  11 +-
 drivers/gpu/drm/mxsfb/mxsfb_out.c                  |  26 +--
 drivers/gpu/drm/mxsfb/mxsfb_regs.h                 | 112 +++++++----
 6 files changed, 433 insertions(+), 124 deletions(-)

--=20
2.7.4

