Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584F5C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E527620834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HOECJNdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E527620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeLCLct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:32:49 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:21376
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbeLCLct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytAjl0B4jgsiAQ44SJwX8ZlIYhstJHaeBUDZlIg7wn4=;
 b=HOECJNdiz75vAz2cZ//4hOtNG4d29MeS5EFIAbmy5BEdsj9TugJZe/FFfl+DL+e4HKoCAA6HoaLddeuFUzRzzSClgIvA50x06c2ZUKkAsUATosmqpiQvUjbEaELsVhqWa7P98rr8tTXpL7N0MablSvW385VaWe8LkdkW9IgTnKg=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3491.eurprd08.prod.outlook.com (20.177.108.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:31:57 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:31:57 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [RFC AFBC 03/12] drm/afbc: Add AFBC modifier usage documentation
Thread-Topic: [RFC AFBC 03/12] drm/afbc: Add AFBC modifier usage documentation
Thread-Index: AQHUivvMkW4rU8xqaEiSmrzvNF4+cw==
Date:   Mon, 3 Dec 2018 11:31:57 +0000
Message-ID: <1543836703-8491-4-git-send-email-ayan.halder@arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::27) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3491;6:UaGw4Ddo0t0pIqwfXYrJqqIcadA+RSfFHvNbob64L1YgW/gWQLeoWQshcY0vpGLvNtlWxfEMHECBdlBuFkXH6cUo1+5WtXmq2oiCIUYuISmBBeT1URmpwuiveyBYiLDcuGph+5IEncH1cbmPKcrU8WwD83oGfsU7aRagPqNTuKZ5s0RGAVKIgiOvmxqeic1iFEr8H8HA/UlaaP65gjQf+UFizOzo/m6/eYc3UOqxnhVIxpwR5tJK57JE8+E8i9QsD03LnfeEpBhSXaa9Ns1uA1TcxoSZgdYilkpqBm8y9G2ogt0QOk2o94wLAU+5rjxvBW4pdlJ8zMa1NRTjB6wrRCVS1GtJJvdnsWNc5yeekLH1wNTkd6sxA2aFqbIiY0cruDErpHmNh5/1JmEsLfrSv+f15iFrQHa8/jJiB8a9S5Jhgo5nsTiJZEPlU8yuivkk5G0wTcXAIl5RSwOQOg8yPw==;5:fVu/5xfXIToG1x3tRnuk3XInNNFx7TtKP7orJ6l8aQTqNaoEDVJn76eAycuvugI485L1TXSXgkVMyeHE37c+jbSaigQ/Lvdg8r13sc2jZCG3AO5qHZZ46BJUHPcsVX+xN3AqexFMDkaEOI+EBD4n0GNvBeTU70PAPDHsDxp7OBg=;7:azU3r/ixZWqJYSxkS5RXs0yIJjelv7yp80C5kDW6EuLQxECD3HVp7pUfg67RRXf0nMR0DqkKaG0Vu46N4yFKTl4532qjXLs3k25rKNXynm81nmnzOl9zFI/kaNLKUPbBGJJPhiy1AfBYvtIVl23n4Q==
x-ms-office365-filtering-correlation-id: 3d31dbbb-15ce-41f1-3a5e-08d65912eefa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3491;
x-ms-traffictypediagnostic: AM0PR08MB3491:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB349199CF25ACB036391459BFE4AE0@AM0PR08MB3491.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3491;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(99286004)(4326008)(71190400001)(97736004)(36756003)(71200400001)(106356001)(6486002)(68736007)(72206003)(256004)(14454004)(66066001)(478600001)(7416002)(5660300001)(81166006)(8936002)(7736002)(25786009)(2201001)(81156014)(305945005)(3846002)(6116002)(26005)(102836004)(316002)(186003)(6436002)(11346002)(486006)(2906002)(2501003)(8676002)(14444005)(2616005)(44832011)(476003)(6512007)(105586002)(217873002)(53936002)(52116002)(446003)(386003)(6506007)(86362001)(110136005)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3491;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ua1pp1hP7OHhdB3vDLcSgm+dotbNs0lHPGOvjNcVl1bDPkEokjFi3ciXaYkJCEVUVuPdDHs/qCjfgUR3w0l3oOeEN3k0ehdXocgZPLIpsGLiU6O2QllNur75e9KcozKxZdYXFXvJFMEXhkkv2u1IHRYwCr+NRV1JDvBLr0ZRZ+TaS/lyQd83pAboNAij1kjv9hwctT3yVL/Jk/2HelH9eJ5XDL0TsFUtQyACfE22pQd1I0sUx69IiT/1x0cg3jjswsWEqwMHpfYsGRlkMRqh/0ZjONJhC5LvBORh66BEM6QcGAWjf0Kto6L+xTLz6arpKktWz6Ohnazco4YqlWQR8jFbc33oNVmTD3i1skrhA1c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d31dbbb-15ce-41f1-3a5e-08d65912eefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:31:57.5705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Starkey <brian.starkey@arm.com>

AFBC is a flexible, proprietary, lossless compression protocol and
format, with a number of defined DRM format modifiers. To facilitate
consistency and compatibility between different AFBC producers and
consumers, document the expectations for usage of the AFBC DRM format
modifiers in a new .rst chapter.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 Documentation/gpu/afbc.rst    | 233 ++++++++++++++++++++++++++++++++++++++=
++++
 Documentation/gpu/drivers.rst |   1 +
 MAINTAINERS                   |   1 +
 include/uapi/drm/drm_fourcc.h |   3 +
 4 files changed, 238 insertions(+)
 create mode 100644 Documentation/gpu/afbc.rst

diff --git a/Documentation/gpu/afbc.rst b/Documentation/gpu/afbc.rst
new file mode 100644
index 0000000..922d955
--- /dev/null
+++ b/Documentation/gpu/afbc.rst
@@ -0,0 +1,233 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ Arm Framebuffer Compression (AFBC)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+AFBC is a proprietary lossless image compression protocol and format.
+It provides fine-grained random access and minimizes the amount of
+data transferred between IP blocks.
+
+AFBC can be enabled on drivers which support it via use of the AFBC
+format modifiers defined in drm_fourcc.h. See DRM_FORMAT_MOD_ARM_AFBC(*).
+
+All users of the AFBC modifiers must follow the usage guidelines laid
+out in this document, to ensure compatibility across different AFBC
+producers and consumers.
+
+Components and Ordering
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+AFBC streams can contain several components - where a component
+corresponds to a color channel (i.e. R, G, B, X, A, Y, Cb, Cr).
+The assignment of input/output color channels must be consistent
+between the encoder and the decoder for correct operation, otherwise
+the consumer will interpret the decoded data incorrectly.
+
+Furthermore, when the lossless colorspace transform is used
+(AFBC_FORMAT_MOD_YTR, which should be enabled for RGB buffers for
+maximum compression efficiency), the component order must be:
+
+ * Component 0: R
+ * Component 1: G
+ * Component 2: B
+
+The component ordering is communicated via the fourcc code in the
+fourcc:modifier pair. In general, component '0' is considered to
+reside in the least-significant bits of the corresponding linear
+format. For example, COMP(bits):
+
+ * DRM_FORMAT_ABGR8888
+
+   * Component 0: R(8)
+   * Component 1: G(8)
+   * Component 2: B(8)
+   * Component 3: A(8)
+
+ * DRM_FORMAT_BGR888
+
+   * Component 0: R(8)
+   * Component 1: G(8)
+   * Component 2: B(8)
+
+ * DRM_FORMAT_YUYV
+
+   * Component 0: Y(8)
+   * Component 1: Cb(8, 2x1 subsampled)
+   * Component 2: Cr(8, 2x1 subsampled)
+
+In AFBC, 'X' components are not treated any differently from any other
+component. Therefore, an AFBC buffer with fourcc DRM_FORMAT_XBGR8888
+encodes with 4 components, like so:
+
+ * DRM_FORMAT_XBGR8888
+
+   * Component 0: R(8)
+   * Component 1: G(8)
+   * Component 2: B(8)
+   * Component 3: X(8)
+
+Please note, however, that the inclusion of a "wasted" 'X' channel is
+bad for compression efficiency, and so it's recommended to avoid
+formats containing 'X' bits. If a fourth component is
+required/expected by the encoder/decoder, then it is recommended to
+instead use an equivalent format with alpha, setting all alpha bits to
+'1'. If there is no requirement for a fourth component, then a format
+which doesn't include alpha can be used, e.g. DRM_FORMAT_BGR888.
+
+Number of Planes
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Formats which are typically multi-planar in linear layouts (e.g. YUV
+420), can be encoded into one, or multiple, AFBC planes. As with
+component order, the encoder and decoder must agree about the number
+of planes in order to correctly decode the buffer. The fourcc code is
+used to determine the number of encoded planes in an AFBC buffer,
+matching the number of planes for the linear (unmodified) format.
+Within each plane, the component ordering also follows the fourcc
+code:
+
+For example:
+
+ * DRM_FORMAT_YUYV: nplanes =3D 1
+
+   * Plane 0:
+
+     * Component 0: Y(8)
+     * Component 1: Cb(8, 2x1 subsampled)
+     * Component 2: Cr(8, 2x1 subsampled)
+
+ * DRM_FORMAT_NV12: nplanes =3D 2
+
+   * Plane 0:
+
+     * Component 0: Y(8)
+
+   * Plane 1:
+
+     * Component 0: Cb(8, 2x1 subsampled)
+     * Component 1: Cr(8, 2x1 subsampled)
+
+Cross-device interoperability
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+For maximum compatibility across devices, the table below defines
+canonical formats for use between AFBC-enabled devices. Formats which
+are listed here must be used exactly as specified when using the AFBC
+modifiers. Formats which are not listed should be avoided.
+
+.. flat-table:: AFBC formats
+
+   * - Fourcc code
+     - Description
+     - Planes/Components
+
+   * - DRM_FORMAT_ABGR2101010
+     - 10-bit per component RGB, with 2-bit alpha
+     - Plane 0: 4 components
+              * Component 0: R(10)
+              * Component 1: G(10)
+              * Component 2: B(10)
+              * Component 3: A(2)
+
+   * - DRM_FORMAT_ABGR8888
+     - 8-bit per component RGB, with 8-bit alpha
+     - Plane 0: 4 components
+              * Component 0: R(8)
+              * Component 1: G(8)
+              * Component 2: B(8)
+              * Component 3: A(8)
+
+   * - DRM_FORMAT_BGR888
+     - 8-bit per component RGB
+     - Plane 0: 3 components
+              * Component 0: R(8)
+              * Component 1: G(8)
+              * Component 2: B(8)
+
+   * - DRM_FORMAT_BGR565
+     - 5/6-bit per component RGB
+     - Plane 0: 3 components
+              * Component 0: R(5)
+              * Component 1: G(6)
+              * Component 2: B(5)
+
+   * - DRM_FORMAT_ABGR1555
+     - 5-bit per component RGB, with 1-bit alpha
+     - Plane 0: 4 components
+              * Component 0: R(5)
+              * Component 1: G(5)
+              * Component 2: B(5)
+              * Component 3: A(1)
+
+   * - DRM_FORMAT_VUY888
+     - 8-bit per component YCbCr 444, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(8)
+              * Component 1: Cb(8)
+              * Component 2: Cr(8)
+
+   * - DRM_FORMAT_VUY101010
+     - 10-bit per component YCbCr 444, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(10)
+              * Component 1: Cb(10)
+              * Component 2: Cr(10)
+
+   * - DRM_FORMAT_YUYV
+     - 8-bit per component YCbCr 422, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(8)
+              * Component 1: Cb(8, 2x1 subsampled)
+              * Component 2: Cr(8, 2x1 subsampled)
+
+   * - DRM_FORMAT_NV16
+     - 8-bit per component YCbCr 422, two plane
+     - Plane 0: 1 component
+              * Component 0: Y(8)
+       Plane 1: 2 components
+              * Component 0: Cb(8, 2x1 subsampled)
+              * Component 1: Cr(8, 2x1 subsampled)
+
+   * - DRM_FORMAT_Y210
+     - 10-bit per component YCbCr 422, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(10)
+              * Component 1: Cb(10, 2x1 subsampled)
+              * Component 2: Cr(10, 2x1 subsampled)
+
+   * - DRM_FORMAT_P210
+     - 10-bit per component YCbCr 422, two plane
+     - Plane 0: 1 component
+              * Component 0: Y(10)
+       Plane 1: 2 components
+              * Component 0: Cb(10, 2x1 subsampled)
+              * Component 1: Cr(10, 2x1 subsampled)
+
+   * - DRM_FORMAT_YUV420_8BIT
+     - 8-bit per component YCbCr 420, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(8)
+              * Component 1: Cb(8, 2x2 subsampled)
+              * Component 2: Cr(8, 2x2 subsampled)
+
+   * - DRM_FORMAT_YUV420_10BIT
+     - 10-bit per component YCbCr 420, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(10)
+              * Component 1: Cb(10, 2x2 subsampled)
+              * Component 2: Cr(10, 2x2 subsampled)
+
+   * - DRM_FORMAT_NV12
+     - 8-bit per component YCbCr 420, two plane
+     - Plane 0: 1 component
+              * Component 0: Y(8)
+       Plane 1: 2 components
+              * Component 0: Cb(8, 2x2 subsampled)
+              * Component 1: Cr(8, 2x2 subsampled)
+
+   * - DRM_FORMAT_P010
+     - 10-bit per component YCbCr 420, two plane
+     - Plane 0: 1 component
+              * Component 0: Y(10)
+       Plane 1: 2 components
+              * Component 0: Cb(10, 2x2 subsampled)
+              * Component 1: Cr(10, 2x2 subsampled)
diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
index 7c16721..c176b34 100644
--- a/Documentation/gpu/drivers.rst
+++ b/Documentation/gpu/drivers.rst
@@ -17,6 +17,7 @@ GPU Driver Documentation
    vkms
    bridge/dw-hdmi
    xen-front
+   afbc
=20
 .. only::  subproject and html
=20
diff --git a/MAINTAINERS b/MAINTAINERS
index 254b7b2..aef18e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1131,6 +1131,7 @@ M:	Mali DP Maintainers <malidp@foss.arm.com>
 S:	Supported
 F:	drivers/gpu/drm/arm/
 F:	Documentation/devicetree/bindings/display/arm,malidp.txt
+F:	Documentation/gpu/afbc.rst
=20
 ARM MFM AND FLOPPY DRIVERS
 M:	Ian Molton <spyro@f2s.com>
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 75c4b5a..0adde4d 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -597,6 +597,9 @@ extern "C" {
  * AFBC has several features which may be supported and/or used, which are
  * represented using bits in the modifier. Not all combinations are valid,
  * and different devices or use-cases may support different combinations.
+ *
+ * Further information on the use of AFBC modifiers can be found in
+ * Documentation/gpu/afbc.rst
  */
 #define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc_m=
ode)
=20
--=20
2.7.4

