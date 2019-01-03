Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C82BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161D321479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dsDmb44R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbfACLbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:31:38 -0500
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:57024
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbfACLbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7Xoac+Y6NGqyCKklwpx5HT8b4rzFuU6zmpbkhX1Xzk=;
 b=dsDmb44RygnjEVIqNNIHQGqBC2kYgn2KdJn7Njs+zbv7Q8TU/e9GyKu0vDVw9mDC9jXT7OOscm5ozXvKPAQl2xTI4WYq8zAq3S8WkBMqasWZkkZjFguPV6NDc4rsgDJeOetOafDYuSf0RQLGlYWUG8o7jejhJkezpN3YtQVrimk=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0182.eurprd08.prod.outlook.com (10.161.35.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 11:31:23 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 11:31:23 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 0/9] Overview of Arm komeda display driver
Thread-Topic: [PATCH 0/9] Overview of Arm komeda display driver
Thread-Index: AQHUo1faKNIioKqxJEuhbf+Gjn3THw==
Date:   Thu, 3 Jan 2019 11:31:23 +0000
Message-ID: <20190103112957.15203-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0062.ausprd01.prod.outlook.com
 (2603:10c6:10:2::26) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0182;6:QbPxqaumkLw6h1Dc90V6SXS4J/AKktNnkTkI7NM3rkqRoKT0LzjbrgQeAeZvK4C4TC73iw4coy+sK45pHMV3VLUBbF7lQKDPsLTMn+hn8uV8fyDXA6CNNXyJ4O1RBZwwYjoxms61dGp4L6GMS/rU7KN31OOFgTukQfhqIvE9avZ/atOkWXpX0itw3egstUVwCn6ePMZKD0HfvAU7mKBR7i41wRFY8tKjLqUH5L8AMREe9ap/f/az+toSQkYTj6EYVkcKhXKVVkN/pK+LHqRO62Xr5NoW2vGbqHNKM+Hn0wxbehkSoD7sDapjF2ncjg4mZq0SHiow6y6wfAX7D7vY/Tsq+6nClvzQMeVLNIHFv/84pfNH9f8UgoL/BpY2AyKtvUKA6hXmpPmoEClWxPc7M2bkdifRKzTXFRCo5dLROIdeYya0M/zjNChOmSsMsgRbbKTE4UGe8Io5XZAH8P/ylA==;5:fjFeM3ktaj2fu/YSk4Hwxe/afT5ZuMdqZEw4tzHKGxp7W6N5Gzu7ZMXP2FwHQ1Dx6MI4I2zCVIJGSqPHYUaUYOBOhVKNAFTwcFxbH15LL8YdzVl9kmwjhnUiPApw1rx3/GrAqavCyOjfKe6ydgCQ3D8pCbxBSDSCV5Wfu1QsCUTmvcnfjmZDrHvIkw7OI4uTIN3+0WLILHFx40wBH/+Aog==;7:JGaUwn/qdxjsvRGpZndviy6JQzg31/aQ9g7b2/DSsFGJva+qGbN23DjFl6wI+f2dM9+aCo72DrmueRpCkAvtMeWM0eYjvXoKQpvbuTNQtkWcL9SbAXg2p82eMtPJJ9PAj7jojJ3RhinZS3uE53ARsw==
x-ms-office365-filtering-correlation-id: f2a301e1-90e8-4a83-bc4f-08d6716efd1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0182;
x-ms-traffictypediagnostic: AM3PR08MB0182:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0182C53E3512B86801CD6B9AB38D0@AM3PR08MB0182.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0182;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0182;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(105586002)(7736002)(6436002)(71190400001)(6486002)(71200400001)(97736004)(8936002)(2906002)(81156014)(8676002)(81166006)(106356001)(103116003)(305945005)(36756003)(14454004)(54906003)(110136005)(316002)(68736007)(99286004)(478600001)(476003)(2616005)(386003)(6506007)(55236004)(102836004)(186003)(26005)(2201001)(86362001)(486006)(5660300001)(53936002)(66066001)(5024004)(6512007)(52116002)(256004)(4326008)(14444005)(2501003)(3846002)(6116002)(1076003)(7416002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0182;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gVtCdm9iN66f6LeE4ZX7MuYFzOpy9EtsoI8LWzONm+RXAXnfFJqOJ8Th9uZQavViiSuguWKYArYtIZAGtG+KdXml2RtZTtjLONXuTgZrShMhhX2Q92VJyNL6TiST2GgYWO/YKwHE3MhXQkV6WcJD5/5faj9wVq7xvaqTxPSzp6MOI9LhOcly87DaGBUytbu+s9yVUt4tM8hl0wWYpfoT8OMVoZYh3ZWlwPkYkAJeYLcSAJodYbVZLVlOElUb+hN223xsm54B81tOSN+Wut0ITM5yGdEX9KNRgwLaaQtRxMPzxns3FwKZpfHyUhD7Sync
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a301e1-90e8-4a83-bc4f-08d6716efd1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 11:31:23.0586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first patchset of ARM new komeda display driver, this patchset
added all basic structure of komeda, relationship of DRM-KMS with komeda,
for tring to give a brife overview of komeda-driver.

komeda is for supporting the ARM display processor D71 and later IPs, Since=
 from
D71, Arm display IP begins to adopt a flexible and modularized architecture=
:
A display pipeline is made up of multiple individual and functional pipelin=
e
stages called components, and every component has some specific capabilitie=
s
that can give the flowed pipeline pixel data a specific data processing.

The typical components like:

- Layer:
  Layer is the first pipeline stage, It fetches the pixel from memory and
  prepare the source pixel data for the next stage, like rotation, format,
  color-space handling.

- Scaler:
  As its name, scaler is for scaling and image enhancement.

- Compositor (compiz)
  Compositor is for blending multiple layers or pixel data flows into one
  single display frame.

- Writeback Layer (wb_layer)
  Writeback layer do the opposite things of Layer, Which connect to compiz
  for writing the composition result to memory.

- Post image processor (improc)
  Post image processor is for adjusting frame data like gamma and color spa=
ce
  to fit the requirements of the monitor.

- Timing controller (timing_ctrlr)
  Final stage of display pipeline, Timing controller is not for the pixel
  handling, but only for controlling the display timing.

Benefitting from the modularized architecture, D71 pipelines can be easily
adjusted to fit different usages. And D71 has two pipelines, which support =
two
types of working mode:

- Dual display mode
  Two pipelines work independently and separately to drive two display outp=
uts.

  - Single pipeline data flow

  Layer_0 -> (scaler) ->\
  Layer_1 -> (scaler) ->\          /-> (scaler) -> wb_layer -> memory
                          compiz ->
  Layer_2 -> (scaler) ->/          \-> improc ->timing_ctrlr ->monitor
  Layer_3 -> (scaler) ->/

- Single display mode
  Two pipelines work together to drive only one display output.

  On this mode, pipeline_B doesn't work indenpendently, but outputs its
  composition result into pipeline_A, and its pixel timing also derived fro=
m
  pipeline_A.timing_ctrlr. The pipeline_B works just like a "slave" of
  pipeline_A(master)

  - Slave enabled data flow

  Layer_0 -> (scaler) ->\
  Layer_1 -> (scaler) ->\
                         compiz_B -> compiz_A
  Layer_2 -> (scaler) ->/
  Layer_3 -> (scaler) ->/

             compiz_B ->\
  Layer_4 -> (scaler) ->\
  Layer_5 -> (scaler) ->\            /-> (scaler) -> wb_layer -> memory
                          compiz_A ->
  Layer_6 -> (scaler) ->/            \-> improc ->timing_ctrlr ->monitor
  Layer_7 -> (scaler) ->/

To fully utilize and easily access/configure the HW, komeda use a similar
architecture: Pipeline/Component to describe the HW features and capabiliti=
es.
Add the DRM-KMS consideration. then:

A Komeda driver is comprised of two layers of data structures:

1. komeda_dev/pipeline/component
   Which are used by komeda driver to describe and abstract a display HW.
   - komeda_layer/scaler/compiz/improc/timing_ctrlr
     for describing a specific pipeline component stage.
   - komeda_pipeline
     for abstracting a display pipeline and the pipeline is composed of mul=
tiple
     components.
   - komeda_dev
     for the whole view of the device, manage the pipeline, irq, and the ot=
her
     control-abilites of device.

2. komeda_kms_dev/crtc/plane:
   Which connect Komeda-dev to DRM-KMS, basically it collects and organizes
   komeda_dev's capabilities and resurces by DRM-KMS's way (crtc/plane/conn=
ector),
   and convert the DRM-KMS's requirement to the real komeda_dev's configura=
tion.

So generally, the komeda_dev is like a resource collection, and the komeda_=
kms
is a group of users (crtc/plane/wb_connector), the drm_state defined or
described the resource requirement of user, and every KMS-OBJ maps or repre=
sents
to a specific komeda data pipeline:

- Plane: Layer -> (Scaler) -> Compiz
- Wb_connector: Compiz-> (scaler) -> Wb_layer -> memory
- Crtc: Compiz -> Improc -> Timing_Ctrlr -> Monitor

The features and properties of KMS-OBJ based on the mapping pipeline, and t=
he
komeda_kms level function (crtc/plane/wb_connector->atomic_check) actually
is for pickuping suitable pipeline and component resources, configure them =
to
a specific state and build these input/output pipeline of komeda to fit the
requirement.

Furthermore, To support multiple IPs, komeda_dev has been split into two la=
yers:

- Komeda-CORE or common layer.
  for the common feature validation and handling
- Komeda-CHIP.
  for reporting and exposing the HW resource by CORE's way, the HW register
  programming and updating.

With this two Layer's device abstraction, the most operations are handled i=
n
Komeda-CORE, the Komeda-CHIP is only for CHIP-specific stuff, easy for addi=
ng
new chipset or IP in future.

v4
- Address Liviu and Daniel's comments.

v3:
- Fixed style problem found by checkpatch.pl --strict.
- Updated DT binding document according to Rob Herring's comments.

v2:
- Use "pipe" (to replace "ppl") as the short form of "pipeline".
- Some editing changes for document according to Randy Dunlap's comments.
- Adjusted the position of KOMEDA by alphabetical order.

james qian wang (Arm Technology China) (9):
  drm/komeda: komeda_dev/pipeline/component definition and initialzation
  dt/bindings: drm/komeda: Add DT bindings for ARM display processor D71
  drm/komeda: Build komeda to be a platform module
  drm/komeda: Add DT parsing
  drm/komeda: Add komeda_format_caps for format handling
  drm/komeda: Add komeda_framebuffer
  drm/komeda: Attach komeda_dev to DRM-KMS
  drm/doc: Add initial komeda driver documentation
  MAINTAINERS: Add maintainer for Arm komeda driver

 .../bindings/display/arm/arm,komeda.txt       |  73 +++
 Documentation/gpu/drivers.rst                 |   1 +
 Documentation/gpu/komeda-kms.rst              | 488 ++++++++++++++++++
 MAINTAINERS                                   |  10 +
 drivers/gpu/drm/arm/Kconfig                   |   2 +
 drivers/gpu/drm/arm/Makefile                  |   1 +
 drivers/gpu/drm/arm/display/Kbuild            |   3 +
 drivers/gpu/drm/arm/display/Kconfig           |  14 +
 .../gpu/drm/arm/display/include/malidp_io.h   |  42 ++
 .../drm/arm/display/include/malidp_product.h  |  23 +
 .../drm/arm/display/include/malidp_utils.h    |  16 +
 drivers/gpu/drm/arm/display/komeda/Makefile   |  21 +
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 111 ++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 106 ++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 192 +++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 113 ++++
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 144 ++++++
 .../arm/display/komeda/komeda_format_caps.c   |  75 +++
 .../arm/display/komeda/komeda_format_caps.h   |  89 ++++
 .../arm/display/komeda/komeda_framebuffer.c   | 165 ++++++
 .../arm/display/komeda/komeda_framebuffer.h   |  31 ++
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 169 ++++++
 .../gpu/drm/arm/display/komeda/komeda_kms.h   | 113 ++++
 .../drm/arm/display/komeda/komeda_pipeline.c  | 200 +++++++
 .../drm/arm/display/komeda/komeda_pipeline.h  | 359 +++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_plane.c | 109 ++++
 .../arm/display/komeda/komeda_private_obj.c   |  88 ++++
 27 files changed, 2758 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/arm/arm,komed=
a.txt
 create mode 100644 Documentation/gpu/komeda-kms.rst
 create mode 100644 drivers/gpu/drm/arm/display/Kbuild
 create mode 100644 drivers/gpu/drm/arm/display/Kconfig
 create mode 100644 drivers/gpu/drm/arm/display/include/malidp_io.h
 create mode 100644 drivers/gpu/drm/arm/display/include/malidp_product.h
 create mode 100644 drivers/gpu/drm/arm/display/include/malidp_utils.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/Makefile
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_dev.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_dev.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_drv.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_kms.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_kms.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_plane.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c

--=20
2.17.1

