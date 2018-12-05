Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA9FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5E220659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="sBpVwnEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5E220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeLEKRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:17:49 -0500
Received: from mail-eopbgr10075.outbound.protection.outlook.com ([40.107.1.75]:17762
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbeLEKRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJWs6yXvlQkIjo0GFfTS+oEluuny915aK8YavWTXQQ0=;
 b=sBpVwnEtH4xqCZBeU9VxnNvEAM1JcJzLoqCCdpprcZlOJIeqsWIF2Z4FntJ7Nv9rrLlvRiRADYoaHXmelqkiVnqC00Yd8Lv8KQhMPpeoFgluAuf9n16sBz5l2ZnYK/Mv8xfx9/FzdAANhT3E2g8SlpBzwal1CR/ZSyGv2UDyFv8=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0580.eurprd08.prod.outlook.com (10.163.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 10:17:37 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 10:17:37 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v1 0/9] Overview of Arm komeda display driver
Thread-Topic: [PATCH v1 0/9] Overview of Arm komeda display driver
Thread-Index: AQHUjIO/PUoZ3J9BcECqpUqTB+zDuA==
Date:   Wed, 5 Dec 2018 10:17:37 +0000
Message-ID: <20181205101635.7696-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYCPR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:10:31::26) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0580;6:Mr5DmD53xPdrZ+autlz1KEi4t7CjwvtXadqB0+As4JNlMZT++88pZ37bzUFtX4r8BlNulw1ykwtqLNC2uVBFH2ibyqDh6/DxQ/dquHixk0Ul2Ib0pNOha3vBCenfomxHO+uGd6dN4zsGGME2VH5idX8LLgUDhZ/7Xdr5CLapjdcv+CDDp3HpKjTwqw0AWVIQciImvdp26OY19NXUzvM2AjtD+LOBlgNU60CInpcnsKR3Gi76AlSvgpINFTephAtIHSkUvwD8tAfis7C/NQnb/RyTKugOR45jHXqhCS0yJ+q3TnH17KbXiLOdqbnwuOl0LseTbrXqTo7T0WLb9X37GhmrkUu59g8MMDlfyMe2Bz5xdtxSLq+sCkWVOoHKg3CiRZcPeXQ9SyuOZAwq47kxr2p4wissho8FFQKTnnf/eKqeLCQiytyMK7TV2LGe2RRQZWPwkIWedDrZFLuJ6mrNiQ==;5:J47vawKax0I3+XDRrxWOilWdQ4c1xw+NEmdGpygGuEJkYo48SeG5joTrzyrG1f9YCjDOFnB4tWSLIM9ZWfE/sMKsVxa4c+j57s0NMo/3S5IuMXRSda95YuV8XaPKIRkP1+l5GTyWvDAoGLkzmX/stGLH20120rTTHWnLApMwvEc=;7:u6pxuMUZmiLHD8UbsdgVdeNfNmm+XCJsQhA/lguX92splcTWJ1ei6RZwMMSXtHebKLSxYOLCXOl39xPhtF2CJ3tP+x9Pbpxwn7HfJ9UnwYuD93JTFPyGYBdHWT00UZSzl4H1kTHTX76qG19DZoR9rg==
x-ms-office365-filtering-correlation-id: 2cdb981c-77c4-4081-c48b-08d65a9ae155
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0580;
x-ms-traffictypediagnostic: AM3PR08MB0580:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB05807E3E1A5BDBA50DC16788B3A80@AM3PR08MB0580.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0580;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0580;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(71190400001)(25786009)(4326008)(486006)(71200400001)(3846002)(478600001)(6116002)(5024004)(186003)(256004)(102836004)(55236004)(14454004)(6862004)(86362001)(97736004)(26005)(14444005)(105586002)(103116003)(37006003)(53936002)(106356001)(36756003)(476003)(2906002)(386003)(7736002)(6506007)(305945005)(6436002)(8676002)(68736007)(2616005)(6636002)(6512007)(8936002)(6486002)(1076002)(81156014)(52116002)(99286004)(66066001)(316002)(81166006)(54906003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0580;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fDUCzAjGM1O4PR9wgu56K6CAnhCDBBP9a/Tyoi5JWoRFSYR9T7Y4JbsZus2bgi+GZoJX2+zfrv/Mjdh1pTS3zhwMcBKHsYnuqu75K0+yD1D4eKwCsBLYh2fNssXk8Br4Y4mxF6mW9PbKt9uJxyaUAWXqZTixY773xedBwU3MpVkvWY5qVcLLfg4UGtvSW+9xb6UdmUeomGxP0LRi3AVr+UmQI0qSWrPMeoM0+Q30eE/gBzptEtasKiJwXxu5JYWFfxNyg7E0eQ6UJtdF1bR8q/92Y4gM82mG6yXjvrvzezLyo5Fo/4arwj3OhNLvvDqaRYQFfvXPaHrjLUtLX3fZWXWGmRXobwqm6dMn+EPNQSM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdb981c-77c4-4081-c48b-08d65a9ae155
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 10:17:37.6856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first patchset of ARM new komeda display driver, this patchset =
added
all basic structure of komeda, relationship of DRM-KMS with komeda, for tri=
ng to
give a brife overview of komeda-driver.

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

Benefit from the modularized architecture, D71 pipelines can be easily adju=
sted
to fit different usages, two D71 pipelines can work independently and separ=
ately

- Single pipeline mode

  Layer_0 -> (scaler) ->\
  Layer_1 -> (scaler) ->\          /-> (scaler) -> wb_layer -> memory
                          compiz ->
  Layer_2 -> (scaler) ->/          \-> improc ->timing_ctrlr ->monitor
  Layer_3 -> (scaler) ->/

Or work together to drive only one display output. On this mode, the compos=
itor
output of pipeline_B will be merged into pipeline_A as an input of composit=
or
of pipeline_A, then pipeline_B doesn't has its output and work as a slave o=
f
pipeline_A.

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

To fully utilize and easily access/configure the HW, komeda use similar
architecture: Pipeline/Component to describe the HW features and capabiliti=
es.
Add the DRM-KMS consideration. then:

A Komeda driver is comprised of two layers of data structures:

1. komeda_dev/pipeline/component
   which are used by komeda driver to describe and abstract a display HW.
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
   which connect Komeda-dev to DRM-KMS, basically it collects and organizes
   komeda_dev's capabilites and resurces by DRM-KMS's way (crtc/plane/conne=
ctor),
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

 .../bindings/display/arm/arm,komeda.txt       |  87 ++++
 Documentation/gpu/drivers.rst                 |   1 +
 Documentation/gpu/komeda-kms.rst              | 483 ++++++++++++++++++
 MAINTAINERS                                   |   8 +
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
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 193 +++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 113 ++++
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 144 ++++++
 .../arm/display/komeda/komeda_format_caps.c   |  75 +++
 .../arm/display/komeda/komeda_format_caps.h   |  89 ++++
 .../arm/display/komeda/komeda_framebuffer.c   | 165 ++++++
 .../arm/display/komeda/komeda_framebuffer.h   |  31 ++
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 168 ++++++
 .../gpu/drm/arm/display/komeda/komeda_kms.h   | 113 ++++
 .../drm/arm/display/komeda/komeda_pipeline.c  | 202 ++++++++
 .../drm/arm/display/komeda/komeda_pipeline.h  | 356 +++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_plane.c | 109 ++++
 .../arm/display/komeda/komeda_private_obj.c   |  87 ++++
 27 files changed, 2763 insertions(+)
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

--
2.17.1
