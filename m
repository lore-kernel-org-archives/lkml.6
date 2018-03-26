Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeCZVZP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:25:15 -0400
Received: from mail-eopbgr10108.outbound.protection.outlook.com ([40.107.1.108]:17766
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752171AbeCZVZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:25:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, Jacopo Mondi <jacopo@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/5] allow override of bus format in bridges
Date: Mon, 26 Mar 2018 23:24:42 +0200
Message-Id: <20180326212447.7380-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::27)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f272498-97b7-44a4-e5d5-08d593600c4e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:iV5zGsgRLvpFn+dztNy/PnYr62fvjVfTbhFcLKzQOwskV+ugOC+mw1OLSTmIlUMWEteZF1ibkSMoLSir7XR9UUDHZzK2TUYS22gN4GBvBz0lh8tvjbSvAjdHPdCJB4AQdkexuPq1/R2O572ipeZgeOAeQS5H7UwESV1f3RiaAXYQjvfXaSRm6fDid+GtzWKeIHBXbyLLjSYVc6qNAVNnA3WNnh14nM6ZK8Vo0c6y/Y4wnITjP/Lf2Qvy4zv92Kdh;25:UyjU/eIL+Q1Ffq6OJrARbGLBY83f5LXaeVdAGn78MXRRTcbRC25gKR4kdGvFCm29juT/wZdyr/1a+iW70b1uO8y9+49ALp7C5qu17miyws/qC3ODg07PYADAvpZJqrGYaWI1BlAMr9V8UoE8Kx+COooDM5g63dpybIFEz4UvGZHNL5b07Q1VhoFVIEpk0/cmuIgZNNnAThfvE7zn6ScrHB5S1Whq/k/Yvt9TIOd3Fjx2Q9itY4pPxbvtBUpuTAVrPsdK00aXLeOBKRjhBy2N1gHWzV0hl9zy8C4mSNZgM8azV2UCKHyakhc10ZDFaDVForIOSyBjmVtNvG3z0xu3Gw==;31:eURVcIyDvPlIv/iaSZ3B+tZhic09TX84nr81cd0udIzrLY5C+CLkan74mBVEmrH4fSNZ5OtqaXMs6m3s7Rz4pJCGficfy8rZDLqJvccaLxoGdTKZE8iXPllvpDytCoc1SpApo7a8qbV/0yYS+2Ksmm9CA5FhBxHFcnw0b4lBm5RBcPFelR4XmsVuxuXl8iw+piDYPlAQMIgNtmf0mKc0cugqdkHwUDYAEUMCmHE1A2g=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27693C9F7C6F129F04A0F588BCAD0@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:SEmv+aYz+gqg2ZQKS+Sb9OS9iYLGbOgXFYPI3m5XuKJaqZT2MYxojLCkeX97jzr6v8lMHqxFIA3xrAQQiHwBPSvm2iyMZm51Gtf7fbukE/Sg2MhOAcBmWcOUzgOAEhIvUA2gkeSIytdYe8mqAYK86Q5qZakJmvKo/PVJonZmZO1jBHi1r3HeZWrNWveeTpkh7mIXiPVh+YdV4b6VsJk1kgsrXnEGeyuGkcc4yJk6UE51Qp8Iuzyj9+2NHGDaJuuVBU5Ae017Py5cAPtB/yJxbA==
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39830400003)(366004)(39380400002)(396003)(199004)(189003)(2351001)(316002)(16526019)(186003)(54906003)(16586007)(6306002)(2361001)(97736004)(105586002)(6486002)(53936002)(956004)(6512007)(2906002)(2616005)(1076002)(68736007)(66066001)(51416003)(48376002)(486005)(486005)(52116002)(6666003)(5660300001)(106356001)(86362001)(6916009)(50466002)(47776003)(478600001)(386003)(305945005)(8676002)(25786009)(26005)(74482002)(6506007)(7736002)(966005)(6116002)(36756003)(7416002)(4326008)(3846002)(81166006)(59450400001)(81156014)(8936002)(476003)(50226002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:gU9onHMgmKOy5bI3ovVFxNiyxFIIKlbfm1hvbB9?=
 =?us-ascii?Q?294pC5s8z+Gwz02RmFEXZK0H6pBzfXXDrL8bcY/Hpz1SEh73oZWPvGwiztKs?=
 =?us-ascii?Q?uH8DzrIhCz13CP+HIX4/huOEx5aTuKYwYqAEZo66VSNQTgqbGG5ZIhwVh82r?=
 =?us-ascii?Q?BIA5Mx+CUwHX/Eqwia6iG6R9fBa8ZdSB/hxGgXqWpjn8x9ISgwKLL4RfSEsM?=
 =?us-ascii?Q?s/974CJ2eeQOUNuSnnBvBtaTogVjGYs7rVpVXSG4WWO4owXAHVCoSdWQYEL6?=
 =?us-ascii?Q?9n8UpgRTBQQPkQJFcDKyBPUy5DlGtDI+B+C91ChFfowJmHChHHuyrRwF3JtG?=
 =?us-ascii?Q?BUkiPzbNHxXn7sUOt9c0VzZ1yzDw7ViRKotspW27OQyz3GZ1URMoAwjAgEyq?=
 =?us-ascii?Q?q/IgjoWFrcTVfr2CGe1qqI+grI8E/tNht7HvwKG4rVP0avYngf0FSc4kVE2l?=
 =?us-ascii?Q?lYPZguCbACgzZuVowYr+76ZtDw0mTr2yRVXs97TtW29dko3k7q8847V+HOPu?=
 =?us-ascii?Q?4VwnRPTvafsp5mcMEVZ08NWiIEAXECA6BAx/3/9BQFV18zRagHhOs3dBCxgV?=
 =?us-ascii?Q?CHf59+jf1OcvKVSjYNrheovCO3OiOzJ1v2PLDnpGpwa4GUF+SS2izy1ywTpx?=
 =?us-ascii?Q?02uGstBhVlzmAY0U6JIjmHpnyKpci7sNsPliy4ytaRSRLP4JqrTVEHjJaUWr?=
 =?us-ascii?Q?TfTl+CNAkgdooNmEmdUOjwwSLGSyEH8MSZKEo0QZHHEX+VswepDFtjOnq+Xu?=
 =?us-ascii?Q?acjL1nDc4aYm6+MdykaEHtjYKf4wKmVDyDp5oI6rf2pSBUz84sSEw+y71U+q?=
 =?us-ascii?Q?wezC59xolA0aUnj+GHw3wZvSAAJvTKEKaFyax3dqgZad7hGRi7/R4gYuFsxC?=
 =?us-ascii?Q?ihKfKAlSVQzKFvzGlwBAMxiXrZBCqiOYQDuRJCnv3HYFoIeg5WM2iD9+CRFX?=
 =?us-ascii?Q?LMOhpzvtGB5vOIlcVtL2PhQIi3kpoFkO/i3TFPlSMmpKVXoDPyDRUxLuxK7C?=
 =?us-ascii?Q?QwiNo1a6w2r5SchxG282aMBHlgpN731LKPskok3NLoSYHXvreTUXymkBHMTh?=
 =?us-ascii?Q?Zf6Y4NaZvQKcm1NVnRXEAQum51nrGHYzzCTajQTLEYG8jnwhqhe0/QIh1Mco?=
 =?us-ascii?Q?WVKhWoOtP0WHzbQIe03sm7AoFrCc/f2Bhyq3Re5tG7dL9lpr3UJ7Hd/dNxXD?=
 =?us-ascii?Q?VjxEGZYlT2czuAZZFv5EHEkJ13kdojS8BK1juYsDkDPC1vWpGYjX78LlIjL/?=
 =?us-ascii?Q?Cr+Sk3wkirboppoQ7S+P1JqlnPuxll99RtlsKGXRcaPswXRNSmUVXqYUbV8U?=
 =?us-ascii?Q?jH8TxGS9QZUil1TeTS0xytm4LJEKV0SYebqKy2VbkpCzr?=
X-Microsoft-Antispam-Message-Info: TlQfzq2PKKrOgHYhPbOLsaFMq5uY5PTsfyPwFKQSD15gOxXGZ0hE+qLiTz4PRlk4VbPu147zNUrN14DFljpcxPZgRTHwxPxUDh1PXn+kvxERQoBXRBBkgMLh33hUyMvrWtX38KeXWcQABr3ADIfEqN4P65kcuA7KKGEA4cFyV/Gh66Y9LNtN2NyNSJzfPR2t
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:VibQHQWN/pWrOh6dVCFf1abeecwciv5kPse1isPNtS/6sL+msZ9oSu2orALwAXDv4IIgTvWfZlRUpXdiKhTX3X22SdP0Zx7EaXNntxVobomJ6Qo6XOiISfkibmjqbvo9JZBhg/oS2iH6iDrvhgQHPHiGJcFSf2o/6JWVF+rjCnMMi9qIyAD5tdtajgEY0kK5F8x3NfqJdNo+aMZHcwdBXJWNHlM2WA7PsmgBFsZQFOks0t+PPSysXBlwK4y292YVY5dvJ97MIFn4fTuV+17GXjqEQRPkYIlQXuGpvz/fz3KtuliEU4TtEj0PXonayYMW2dSSssu0T0e9VqlsY4UdaaG40icKSbXpAe5NhksnJqkusLjmu31Qf9uaULRAeIu6x85x6aVXxqzNFc+JpCMd/YRa33nkALJfxrG/GycuuLNn0muT6/iKVFNMzAD9TalD2q0WDj1EFJvwZWR0sSVPnA==;5:Fh+434T+dn2EwgWLAQDpAuV6sNjD3R7ixjkxfVw6x4JsXvmbRbTrLHw7tT5bohBVOcIGg3YE1eqLV4jCMHoTgbZgq5h4ojmLQNoSByNFA+qZdZOPiUygLnXu9pbF/hDlNrrYrLVvpPqwv6VAwDtLDeu24LPRio13P/M6+7rvYQ0=;24:kQ2etFnESS1sq1h1YRQwCvj0ftizCHCXBASVNWCMkOnnujyAHLotyaHvVsEEgBVMZHniCkuGD2rBFp1Ek8usVfxFslt5Z0sqZKKNuPIHeBo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:IAZbKSbqllKmKtpqqtipzfvwZl4IPncJBh/JTv6Ruk2nBxb0j5nHgtCv6+0HOGgYBdwmuEhTjvm3u4N/UDyZka8E2d/tvyqaB3/b/RXYPWdq05Az39tFwGAgAY31vbfJIDngCW2r/c3EKqE1w8WqfqxFCpXR2Qf9pHNctBxTOvYVmb+ZkQfsNUlHp+6ig+jXy3YeIiIXDI7CKdZrqPHGssiyJd37pHyerglvBo3JrTQE6/OZuAj/UXXDlrhI5oSd
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 21:25:06.4745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f272498-97b7-44a4-e5d5-08d593600c4e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[I got to v2 sooner than expected]

I have an Atmel sama5d31 hooked up to an lvds encoder and then
on to an lvds panel. Which seems like something that has been
done one or two times before...

The problem is that the bus_format of the SoC and the panel do
not agree. The SoC driver (atmel-hlcdc) can handle the
rgb444, rgb565, rgb666 and rgb888 bus formats. The hardware is
wired for the rgb565 case. The lvds encoder supports rgb888 on
its input side with the LSB wires for each color simply pulled
down internally in the encoder in my case which means that the
rgb565 bus_format is the format that works best. And the panel
is expecting lvds (vesa-24), which is what the encoder outputs.

The reason I "blame" the bus_format of the drm_connector is that
with the below DT snippet, things do not work *exactly* due to
that. At least, it starts to work if I hack the panel-lvds driver
to report the rgb565 bus_format instead of vesa-24.

	panel: panel {
		compatible = "panel-lvds";

		width-mm = <304>;
		height-mm = <228;

		data-mapping = "vesa-24";

		panel-timing {
			// 1024x768 @ 60Hz (typical)
			clock-frequency = <52140000 65000000 71100000>;
			hactive = <1024>;
			vactive = <768>;
			hfront-porch = <48 88 88>;
			hback-porch = <96 168 168>;
			hsync-len = <32 64 64>;
			vfront-porch = <8 13 14>;
			vback-porch = <8 13 14>;
			vsync-len = <8 12 14>;
		};

		port {
			panel_input: endpoint {
				remote-endpoint = <&lvds_encoder_output>;
			};
		};
	};

	lvds-encoder {
		compatible = "ti,ds90c185", "lvds-encoder";

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port@0 {
				reg = <0>;

				lvds_encoder_input: endpoint {
					remote-endpoint = <&hlcdc_output>;
				};
			};

			port@1 {
				reg = <1>;

				lvds_encoder_output: endpoint {
					remote-endpoint = <&panel_input>;
				};
			};
		};
	};

But, instead of perverting the panel-lvds driver with support
for a totally fake non-lvds bus_format, I intruduce an API that allows
display controller drivers to query the required bus_format of any
intermediate bridges, and match up with that instead of the formats
given by the drm_connector. I trigger this with this addition to the
lvds-encoder DT node:

		interface-pix-fmt = "rgb565";

Naming is hard though, so I'm not sure if that's good?

I threw in the first patch, since that is the actual lvds encoder
I have in this case.

Suggestions welcome.

Cheers,
Peter

Changes since v1 https://lkml.org/lkml/2018/3/17/221
- Add a proper bridge API to query the bus_format instead of abusing
  the ->get_modes part of the code. This is cleaner but requires
  changes to all display controller drivers wishing to participate.
- Add patch to adjust the atmel-hlcdc driver according to the above.
- Hook the new info into the bridge local to the lvds-encoder instead
  of messing about with new interfaces for the panel-bridge driver.
- Add patch with a DT parsing function of bus_formats in a central place.
- Rephrase the addition of ti,ds90c185 to the lvds-transmitter binding.

Peter Rosin (5):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  drm: bridge: add API to query the expected input formats of bridges
  drm: of: add display bus-format parser
  drm: bridge: lvds-encoder: allow specifying the input bus format
  drm/atmel-hlcdc: take bridges into account when selecting output
    format

 .../bindings/display/bridge/lvds-transmitter.txt   | 14 ++++-
 .../devicetree/bindings/display/bus-format.txt     | 35 +++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 49 ++++++++++++++++--
 drivers/gpu/drm/bridge/lvds-encoder.c              | 25 +++++++++
 drivers/gpu/drm/drm_bridge.c                       | 32 ++++++++++++
 drivers/gpu/drm/drm_of.c                           | 59 ++++++++++++++++++++++
 include/drm/drm_bridge.h                           | 18 +++++++
 include/drm/drm_of.h                               |  9 ++++
 8 files changed, 237 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bus-format.txt

-- 
2.11.0
