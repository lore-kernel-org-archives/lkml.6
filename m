Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79943C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3569220866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m0qA25J8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392523AbfAPLso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:48:44 -0500
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:27264
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732702AbfAPLso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VznmnMkDrn6gkOG5hFSTeA7x24Cx2nhhIFbHBsd7WUY=;
 b=m0qA25J89kecAM9OiRajYkjEhaxUYEdI/hRZQznYeJ+rlf+c+Ylg/+cUpt/Nkp9XCFUmgLVAWn1SfqGJNGRfjuSV4pH/WQQ6uy0/+qBoYXZvsc/8gkyvjd2dq8yktHbZHMjLuzeJNWtgacfKZYjaYF8u9n1vKThHEp5/03kdfJc=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB6101.eurprd04.prod.outlook.com (20.179.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 11:48:38 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 11:48:37 +0000
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
Subject: [PATCH 00/11] Add support for DRM bridge and additional pixel formats
Thread-Topic: [PATCH 00/11] Add support for DRM bridge and additional pixel
 formats
Thread-Index: AQHUrZFr5/xx8xzEl0eR+VGDCFZAeg==
Date:   Wed, 16 Jan 2019 11:48:37 +0000
Message-ID: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6101;6:U9aJ+/oT0gq4yhI1YiltnIyD89dE4HePurunqI2ojtLo3wGW0W8mlXgJye1g+kwAMqcqbQxCDjiGzMLr/ZN4UdYBl3YNdkI2XzTgtPDbdYX7bfMzstfHk6kEhfccUHWaMHbc4MQRnQFPJEQEFiNmPVVHogJp9KPyNKNYUVrNZrhhiL2er2Bp0WbLCZIQwuwqDxXKArjUaml+jwL2QgfKvL+6wuD28XIqFkW41RR1az1+YKvyehb4T+QyQmQUJy4ria106ZXibhdleZZeoj9cCTOvRBwTI/qKY1Qxy9C5W7zrWpafHd1nBpSr+wJ3uGyxMGeKEoltqIR24kJkkl8DW6aYj0A5xYS5Ja8+mfi6bms46b2eqPq5oI7kZa5SfNQabjOjeWfaIzuezOVukusqWPlco8KO85yh29nBf1GavQdq1gxYYyT/EuBvnkBAN4bXe2Sf8OOhZy9Q54WgaFhXHg==;5:WOnij2EbPCbvy1+w4M39YzUixJ0pl9tdJ2qMYeILhJdg9LbGLmgUCj9zpA53Bq2+wd9BnriJxUW25prhnviryLE362yKdHDjuQ/KhXOE66pE3BVOe5aYawOm912PB86w0vRbW+SEnhIp6Z3xXOSioSHq6Go8PxPiodb1XxioosXTZnGKf/WWWFPJ1HNhBISUNzIfGN2E99disSiHYLcN+g==;7:vuH/CFTD/151yTqTSJlb0wNkKyk5iqGB6t8TeAE/ySwysFGLUUThEAAdDdv6lHR7yf5PdZoq7DR/plO20I0upmUscSrcCeH5I67xt7twOJS2YY/hPKdj9Epvvx6DbkWAEui7iz+JaZavtpVxdzXA8Q==
x-ms-office365-filtering-correlation-id: cb4e3554-4b5d-4967-23bc-08d67ba88d5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6101;
x-ms-traffictypediagnostic: AM6PR04MB6101:
x-microsoft-antispam-prvs: <AM6PR04MB61019338924CE3B5001617B4E3820@AM6PR04MB6101.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(316002)(81156014)(110136005)(102836004)(81166006)(476003)(26005)(2616005)(186003)(8676002)(7736002)(66066001)(3846002)(50226002)(105586002)(305945005)(6486002)(8936002)(99286004)(54906003)(6436002)(106356001)(6116002)(86362001)(2906002)(44832011)(14454004)(478600001)(486006)(71200400001)(68736007)(97736004)(5660300001)(53936002)(36756003)(5024004)(256004)(14444005)(25786009)(386003)(6506007)(6512007)(52116002)(4326008)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6101;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FjKINOzXhUDZkk3K11on9nuzDPpJsz726ngtQOwMFxYErY/KVAsfPGwec5nuDtlOZW5P5MVhhKCZvIHb++HHg4KYmZAQsVlZmDbl0g/faj5m/Mcga+92NmYFwl3U6Mlyj3ofcoCAuhyenEWp2C1rfFvLSWfNNn7yHmXLQg3s/F16aqp0zjBnCqgmW+nOoBzmn21AD1Xuom+Vt8Y/6UuuN2nTtgdyusU79AmDC3h9mg7gyoFVeIGH3Ze8E1WL9FAXmNRfQ21QQjLiV+6lmLsUCegXDkzkXpggHiILLyZll+Rx7c3yf4BYKDhv97O3rZPgc/46oSyNqjBHXbN4J9ux4rcAw0mnDgv3VYIamBXAgEGt4OEF05TOFmcpFLX9u2R0LF9HSihWXJdmFoCkXQp9L55wzGg3tCHyGX61tlN37oM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4e3554-4b5d-4967-23bc-08d67ba88d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 11:48:36.9481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
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

Changes since v1:
 * Replaced for_each_crtc_in_state (removed since deprecated)
   with for_each_new_crtc_in_state
 * Removed unused MXSFB_FLAG_* flags
 * Split the patch for LCD reset and moved the pm_runtime_enable fix
   into a separate patch

Mirela Rabulea (2):
  drm/mxsfb: Add support for new pixel formats in eLCDIF
  drm/mxsfb: Signal mode changed when bpp changed

Robert Chiras (9):
  drm/mxsfb: Update mxsfb to support a bridge
  dt-bindings: display: Add max-res property for mxsfb
  drm/mxsfb: Add max-res property for MXSFB
  drm/mxsfb: Update mxsfb with additional pixel formats
  drm/mxsfb: Fix the vblank events
  drm/mxsfb: Update mxsfb to support LCD reset
  drm/mxsfb: Move pm_runtime_enable at the end of probe
  drm/mxsfb: Improve the axi clock usage
  drm/mxsfb: Clear OUTSTANDING_REQS bits

 .../devicetree/bindings/display/mxsfb.txt          |   6 +
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 | 215 +++++++++++++++++=
+---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  | 183 ++++++++++++++---=
-
 drivers/gpu/drm/mxsfb/mxsfb_drv.h                  |  10 +-
 drivers/gpu/drm/mxsfb/mxsfb_out.c                  |  26 +--
 drivers/gpu/drm/mxsfb/mxsfb_regs.h                 | 112 +++++++----
 6 files changed, 429 insertions(+), 123 deletions(-)

--=20
2.7.4

