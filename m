Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14012C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC3C21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QEw6aDlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbeLUJ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:58:48 -0500
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:18550
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728691AbeLUJ6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0v5O6TxWeLeA9ATpt966ht2J6+ndLbF12YGVDFHdYI=;
 b=QEw6aDlPVvx9UWy7/JJZOCGg6tffcWwy+c2bQM/hCTNDAHpamAt47ae5gK8/6Z7fLhg8QzpiUrnDkQOcFem6oZJHBgRDNn9tMsxt5CymsMNUgZh3R0AyrJaSPPSvAyhNIgQKt9j7FIuLwI7WWdVcZIy0Mkofy2pe8yd4FFbnnH0=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3777.eurprd08.prod.outlook.com (20.178.22.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 09:58:39 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db%5]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 09:58:39 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
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
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v3 0/9] Overview of Arm komeda display driver
Thread-Topic: [PATCH v3 0/9] Overview of Arm komeda display driver
Thread-Index: AQHUmRO/VOvvqhFHBkue/CeT6eTehw==
Date:   Fri, 21 Dec 2018 09:58:39 +0000
Message-ID: <20181221095757.15510-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY3PR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:19::32) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3777;6:zRYjRt3bTNeW83GxJPXF4EI50j5HWhCV2vLrk5RcuAm3Qt2uWD30DeE5Q3MwORu5LhpOFB61FHZucgwUQ9bXtj2syJAEceIfif751ckjSlePS2Egg0ezjFy8E2BvkJ4an5oQIKE7l+qzThIXe3e6RgTw9KQj0JCfe9A9ijTvGYFnkg2oWUEOsXkl6M6NPa1tGWVwGzgYBs1wnQ9dLJcNKL0m3vOWMI3WKJaWmmZXGnrgsA0H0ndi+KYtjr1gNhAR8a0FVVMilK/ASwlNUvhtrRI3rHAxZusQVBPek0IiZ9pufKFvwaEc1zdSScxJ4bcITKuahXcEGqFwlFlvtwNbfEhENM5PgtROOqkHtdj3XKWmVPt5XQdk+v8U+3oG/L3WMgvKAXP9n3IGDA4icV472CIc48WTLtkQXJt1dIzWJYQP5hc19xzTkMVcUKmKJGE/juXHGt34muWtvB9f8gSx2g==;5:mLkLoLuSaAU4RSqGDMF3MObIagVBelOiH7mPpEdLI9ylWUNIi2o3YJtvdzE7VPZ8EdJbabHugIPXZ6oYFd0b9HW+99In1Rs9YhyVLK6pmCKvc6L0iMmpAPIyefiqp4SnzPPlg2cmNKRMyzBbutqGjwKEpDCF0waphylb2rReFMM=;7:+NBa6cIfcgu/3TU+fDAaz8Jx+/T4jupKhAMU/WKPnCzK5f6AUBybua3UaHkfsGTgd4tKbGUm0CtABuLAz/3ukiB/opkxyju2DAcAST55gD4FOe1b6OAjLH82YP8IRkFVugYdClOQ+D8rU6Z/MVjnMw==
x-ms-office365-filtering-correlation-id: 494f1aca-7f7b-4338-8c24-08d6672ae17e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3777;
x-ms-traffictypediagnostic: AM0PR08MB3777:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3777134BEAC3A2A96D3DBCF6B3B80@AM0PR08MB3777.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(8220043)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3777;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3777;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(6862004)(36756003)(26005)(1076003)(55236004)(102836004)(4326008)(7736002)(81166006)(7416002)(6636002)(53936002)(106356001)(186003)(6346003)(52116002)(8676002)(6512007)(81156014)(316002)(68736007)(8936002)(6436002)(476003)(486006)(2616005)(386003)(6486002)(14444005)(256004)(5024004)(6506007)(99286004)(2906002)(37006003)(54906003)(478600001)(71190400001)(71200400001)(66066001)(103116003)(14454004)(25786009)(86362001)(97736004)(5660300001)(105586002)(305945005)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3777;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-microsoft-antispam-message-info: JsoM7dxUXic6AS1bumnpYSeuv7OcwmPXuJjTy+zXosl9WcX5xIYOZRW1mOO125YIuJoCD4B1JRl5mfvLOCFPvmecS55I+oqCbspgbFp03BhWSj9hPvCSys2ewnxwkvrGqfMoJZuJbjjPIoBqled4r+MBrlg1xEdeN1Gds3Yu9GoD87ZSN4ap4+wI1UYtWYPMrqfnp+5Bfw7uGWhrs91tlOEgUeZJnyL6rONYxQBVrePNuRIuRuCFkaJwWF8DHBIK0PyWpGWrR00tywNTwcBphlPSu1an5okxVlugnhAgLWWC6gArW2Yg1b4xZIn20iBm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494f1aca-7f7b-4338-8c24-08d6672ae17e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 09:58:39.2390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3777
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

v3:
- Fixed style problem found by checkpatch.pl --strict.
- Updated DT binding document according to Rob Herring's comments.

v2:
- Use "pipe" (to replace "ppl") as the short form of "pipeline".
- Some editing changes for document according to Randy Dunlap's comments.
- Adjusted the position of KOMEDA by alphabetical order.

James (Qian) Wang (9):
  drm/komeda: komeda_dev/pipeline/component definition and initialzation
  dt/bindings: drm/komeda: Add DT bindings for ARM display processor D71
  drm/komeda: Build komeda to be a platform module
  drm/komeda: Add DT parsing
  drm/komeda: Add komeda_format_caps for format handling
  drm/komeda: Add komeda_framebuffer
  drm/komeda: Attach komeda_dev to DRM-KMS
  drm/doc: Add initial komeda driver documentation
  MAINTAINERS: Add maintainer for arm komeda driver

 .../bindings/display/arm/arm,komeda.txt       |  79 +++
 Documentation/gpu/drivers.rst                 |   1 +
 Documentation/gpu/komeda-kms.rst              | 488 ++++++++++++++++++
 MAINTAINERS                                   |   9 +
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
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 195 +++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 113 ++++
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 143 +++++
 .../arm/display/komeda/komeda_format_caps.c   |  75 +++
 .../arm/display/komeda/komeda_format_caps.h   |  89 ++++
 .../arm/display/komeda/komeda_framebuffer.c   | 165 ++++++
 .../arm/display/komeda/komeda_framebuffer.h   |  31 ++
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 169 ++++++
 .../gpu/drm/arm/display/komeda/komeda_kms.h   | 113 ++++
 .../drm/arm/display/komeda/komeda_pipeline.c  | 202 ++++++++
 .../drm/arm/display/komeda/komeda_pipeline.h  | 361 +++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_plane.c | 109 ++++
 .../arm/display/komeda/komeda_private_obj.c   |  88 ++++
 27 files changed, 2769 insertions(+)
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

