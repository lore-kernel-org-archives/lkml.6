Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeCQWPo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 18:15:44 -0400
Received: from mail-he1eur01on0135.outbound.protection.outlook.com ([104.47.0.135]:39352
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751911AbeCQWPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 18:15:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH 0/3] allow override of bus format in bridges
Date: Sat, 17 Mar 2018 23:15:22 +0100
Message-Id: <20180317221525.18534-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6P189CA0021.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:2e::34)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46ead965-b950-4fbe-e122-08d58c549b64
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:AVs7oWPg+C4RHz+uZz0JkjcmSmt/vkvoq4qhCAvi9fmpE7TYqKV4XQDng9cYJiE90OU5M0VqiBaUQeZiaCEANjPrdyjJe9bvPVPYye9vv8pU5Wfu0LbEq2SLOFt+l3ljI5hg3RgCjtqBbVS1h5QsY8u7zulZcMEAG6LmZ+tdlZrcWx1uqJli6iZmwqgdVmJAHSUNnvr61AMwGLn2s1jtWQMH067f/dNOvrc8en8N+6vGGZzvD3AKsgm9SRhSHEjc;25:/PzkuZ5pPjtuvmK/BqltangtffNhQZ7K9YpJyUx51l34DPvCYOY2py6G75Q1pwcvxRZTSpf4p1JVJLUcbn4LWQlaGm8HTiK1JDlVhXYoJo0hUGUWmTlZLrK9JBck4R0/Ej1obn22LWgJwU7p4kW3t69IQZSoRf+3ygnNu8/jSY3QyUBgO9HDWfViuFsVtRDSPvbJDJZQMMW9/WPiwKfFzAeHBu26pao7qIs8UCp3hrVG4wHXAGb4UiMso0CnnlpqE3lK75bj3BcJY6cD14hCTDTuvhQkzDFDr9GzrdIGlf+2bAD233xIZ3qyQP1Ntcs+iBUbPkiWo6zHOP7SS4uadA==;31:zXF3uxWe64AMoW6vrBfcY56N6oMhRB9x+ySh8FMEkXj5ygZeYXo6VXPMU/2qmPV2Cy9r3TKuQwZ+7NZT160xY8i3jug2xuZov7ejHOOel9GQHA6G1RUfps5+QmJVxCmrUoliUMEglvH3qbAqHHmG/pFSNHWSwRy/Jsx4rKfkPUO8B7jVl9YexO+P0BbPeSnq0LpFDTRNU535t2nGyQ9+TDBPgtFFLIEtN0Sld4ndWeo=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769CEFBC2118075B729C07EBCD60@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501300)(52105095)(93006095)(93001095)(3002001)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:0X1ZMjY9KbCbr6GBB1bIQ917H3XCFDuocLKz/69nzZxLSJAvWNAwWLshnTfd9wqszMZkiwYK1GLudRxep5EMLOzwxzMucz8OmmG5OLMDYptEvVm5wJfKKf6++WYq5cPQ54T8//f/42wSRnLwX4pQyxGY+e+aCMUPVtP5xkKb873e5DuDF5vcCPEMJg/jwT+OomZVFIG4Ql4m5BFpjbY0mRSVPGbo+67u/9ZghHVKetSEKUe7aizuUJ/SHCGtY1MzjQEKDuJfmmToxO+KjsphBA==
X-Forefront-PRVS: 06141B80DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(376002)(39380400002)(346002)(396003)(189003)(199004)(52314003)(26005)(25786009)(4326008)(86362001)(50466002)(59450400001)(316002)(52116002)(51416003)(5660300001)(186003)(66066001)(68736007)(105586002)(97736004)(16526019)(7416002)(48376002)(386003)(6506007)(47776003)(81156014)(81166006)(2351001)(16586007)(6486002)(478600001)(2361001)(8676002)(6916009)(53936002)(50226002)(8936002)(6666003)(6512007)(74482002)(106356001)(36756003)(1076002)(3846002)(6116002)(305945005)(2906002)(7736002)(54906003)(42262002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:sg6omdGgVtzE0NKcUbHWlnHjcUinsNFPfN1vXGz?=
 =?us-ascii?Q?x0HnJneDlhFYwBCh0hed5hFeikvjjOc3ZJXFqorxhqUWXiijdUzVbwxf9eO/?=
 =?us-ascii?Q?ytRhny2ts0PkDClpSWeSBiu0/Z+gg7Ukhko5i3NUmLKjdenUJHeKtsQ3u8PM?=
 =?us-ascii?Q?nlWcw7LWiKMP+yZ4zaiDPs/wM99tUypkDu7re7xtP41skuAz+B2sc0NozIkp?=
 =?us-ascii?Q?9V2caThtTo91vsGb0GWX74++TORtCuhqqQSXsAK76vZsKIUj1dZv/7zBF78R?=
 =?us-ascii?Q?p05vfF+7UCtTnJiHjohRkF8zsGyUxnj+v7yzf5WxuK6Aal9qtCxVVGEjqaw8?=
 =?us-ascii?Q?OA/HMhyrCP2//EKNXXeg6xSqjEuhA5iDpdTHyA7h7i0IpapYxgM70DofYUVe?=
 =?us-ascii?Q?agdMDItxeP+4eTNlvQHZMhymPAVn7ySNnJSdBfARP+/8ASNTvBojCqBOJVn6?=
 =?us-ascii?Q?/pc0flPJHRgR1fxo5oiWOJn9TgTH1tJ+4DKqNYcAn9oAnivTFsQh3VX98W33?=
 =?us-ascii?Q?37Wlt5BYopE6p9c/82GNaXO+k2xGPyyEUv9Ydb+s8pz9WMGTIFfsJgQHYp4W?=
 =?us-ascii?Q?6aMtH7m+0n+pKDrKX4gCFrsqST7Ld096nxrlAeifx6/VKC/Tr8D1G9O6KUCH?=
 =?us-ascii?Q?UqSa3dUpOAjL/Fus6bvIzUV29NkmnGS8QH53ZvbFCVdMoyELkJD1TQzpH7Mu?=
 =?us-ascii?Q?qV4dWZG7hG6SpUdrvFEFPPQSw2L8cBvCQvCWQIvNRc0NT6YjazB91MCEGbhr?=
 =?us-ascii?Q?mcyv2VkGHbXgJztjnKR4v7zXkCFfKc7hZtUbVVhwvW3WwXS5kSqnfZw2oMFG?=
 =?us-ascii?Q?kojF2WAwGYVZY6cNH/QPeGnlFVMUMlQixF4YQJyUeLnYkK5tBlAQys8lLFHW?=
 =?us-ascii?Q?YESgoBbPzD1EUizruNKvf98dU9+nAyverRB+rCtj1N0sX9IFajLmM5GBCnyx?=
 =?us-ascii?Q?QwjPL0Qo+56DW1QByG9iExlyCv2pDs6ROPFnKtq7dMYqLHx+wj/JOqwrfBFr?=
 =?us-ascii?Q?R1zvFtsBpCRdWjQ/9FdEEqbOWan8I3K0sM+S/HFk1JyIEZlu7MgO1L7F/w8M?=
 =?us-ascii?Q?ujd5aTeQf61Qh0e5gVQMzz1hDk5n3uvgCt2EOZ2bra9nCKTenh64l88vEF9R?=
 =?us-ascii?Q?YCXPNwmtjpDZdFHldeyOdXhSVMEAocft8IfhCgE0AWblCe5Vt3G5UZmkrmst?=
 =?us-ascii?Q?yxDjEh8LyfSrAlfJWUPVCgDWIITvEgLeKRm3+4zNYEnihLZzWYw3Vn6naach?=
 =?us-ascii?Q?xgy+QdPzqpKAAsNdreBNG+YloR5fjzqparjKEJMRm?=
X-Microsoft-Antispam-Message-Info: OaD9HHFqfWfPxLKzU3ZZIq44C7EMqfkfYrTQBvCKeLb6yZL4GgURbhWIXFDP8eOD+90m4ffCBVgV6LOatHdino8d8SCFqIjMp4mABUkV2BZU2ZWQS7kywjO8Z45FFq+kaLhU22vOT0MXO7BMhIFETo65Lob840RD5GWjljIINP6U9OyycG0g9ZtpDwlUEOuN
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:+BTxyAvK4ts24jrgT1CdEmVszl7PF2nrgUzBO1RuCe1TvpoWRdjUMTy7CC6TWhc1Uzfec1N+7F6tmJkbxupkjusrKqPQIjU09uRmxcAlC0VgiC+X5hU3DgxFQqRGbMY3sZXse84c5CsrCDIFIbynaX7Dd+/w0MFiU9hdGW2QdMibrtyfJEwRulqPpg8aZ/6wCWd+pcKOEPP75DqjMgkk0QyDzKbbOwlOalzjBX4xibROtbqNuibmkQP5N5+QxOLj5YL0fmJRef5GlZDaJnYT1yHmgnRgv0FdLEnJK9cdPiT0yPumUrCIPaKD1TB4O274l2bFH0o6KTsEZG7Kr7kJ0hlWCQELQuhlUqExvO0XyQo=;5:6wvQ8s75+5JBaKa9ulsehYtoqkuHvoXLjqigtfBP0mVLMAIQTRnfSzT/x+TU0rVtA7YwLw5wlss3xuVagMfhwr2UCWYh+Qgr0B7lXn122NPNfEY47Ek9AlG5U4Md70rfaG47sveTdEOudlzNKSJs3BE+p3mo/Ou6rUJh7vxWkwg=;24:bwonJGTjM7ZJQsU6gTKn6DOOYY59AAyDt64Yy4DiPSD3gqanUPE5K6XPPladibX7g53Xt6jx4UEXD+ZYPDAC5vglZshoYpMd7xZ9a/5vYdg=;7:vk3DrK0M5HU0xiKs3G7Vi7eQFGxk1Mei2vPt97RTUj2eEMqH7OF0n4S8kYA1c30s0WRbyxR4A2l6UP8P71cgJa0JtP+O9QGSizi3t3cr1JTijqPclzRxlK2mv2MSAcZTTsrHKu3FTv4V8lUxuBKAcp3V1uU+4RGAiuVbQ8pqgME32I3LCPThVG3wsGRLTlosjFMnVnScJuriUpznfoEwvJdD7SZOQBG/UpSIBIbCvvHrrSCNi4gGe/E+OmRHa7c4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2018 22:15:34.5326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ead965-b950-4fbe-e122-08d58c549b64
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get something to work that I assumed would not
need patches, so I think I might be missing something completely
obvious...

I have an Atmel sama5d31 hooked up to an lvds encoder and then
on to an lvds panel. Which seems like something that has been
done one or two times before...

The problem (I think) is that the bus_format of the SoC and the
panel do not agree. The SoC driver (atmel-hlcdc) can handle the
rgb444, rgb565, rgb666 and rgb888 bus formats. The hardware is
wired for the rgb565 case. The lvds encoder supports rgb888 on
its input side with the LSB wires simply pulled down internally
in the encoder in my case. And the panel is expecting lvds
(vesa-24), which is what the encoder outputs.

The reason I "blame" the bus_format of the drm_connector is that
with the below DT snippet, things do not work *exactly* due to
that. At least, it starts to work if I hack the panel-lvds driver
to report the rgb565 bus_format instead of vesa-24.

	panel: panel {
		compatible = "panel-lvds";

		width-mm = <476>;
		height-mm = <268>;

		data-mapping = "vesa-24";

		panel-timing {
			// 1024x768 @ 60Hz (typical)
			clock-frequency = <52140000 65000000 71100000>;
			hactive = <1024>;
			vactive = <768>;
			hfront-porch = <59 107 107>;
			hback-porch = <59 107 107>;
			hsync-len = <59 106 106>;
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
		compatible = "ti,ds90c187", "lvds-encoder";

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
for a totally fake non-lvds bus_format, I came up with an optional
bus_format override in the lvds-encoder driver, which I trigger with
this addition to the lvds-encoder DT node:

		interface-pix-fmt = "rgb565";

There are some issues with the interface-pix-fmt name. I copied it
from the freescale fsl-imx-drm binding, but a) I personally don't
like how that binding uses rgb24 instead of rgb888 and b) I don't
like how the implementation of that binding selects rgb666 when you
say bgr666 in the DT, but for parallel hardware interface the bit
order is not really relevant so I swallowed that. Anyway, it might
be better to use something else than interface-pix-fmt? Perhaps
reuse the "data-mapping" name from the panel-lvds binding? But that
seems somewhat lvds specific? Then there a couple of instances of
"bus-format-override" in some dtsi files, but that name is not
mentioned in any binding, nor in (upstream) code...

And maybe it should be fourcc codes or something instead of these
"rgb565" names?

I threw in the first patch, since that is the actual lvds encoder
I have in this case.

Suggestions welcome.

Cheers,
Peter

Peter Rosin (3):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  drm: bridge: panel: allow override of the bus format
  drm: bridge: lvds-encoder: on request, override the bus format

 .../bindings/display/bridge/lvds-transmitter.txt   | 13 +++++++++++++
 drivers/gpu/drm/bridge/lvds-encoder.c              | 18 ++++++++++++++++++
 drivers/gpu/drm/bridge/panel.c                     | 22 +++++++++++++++++++++-
 include/drm/drm_bridge.h                           |  1 +
 4 files changed, 53 insertions(+), 1 deletion(-)

-- 
2.11.0
