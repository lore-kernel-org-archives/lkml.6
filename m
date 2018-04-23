Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeDWHXT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:23:19 -0400
Received: from mail-eopbgr50112.outbound.protection.outlook.com ([40.107.5.112]:56730
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751216AbeDWHXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:23:14 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Russell King <linux@armlinux.org.uk>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/8] Add tda998x (HDMI) support to atmel-hlcdc
Date: Mon, 23 Apr 2018 09:22:53 +0200
Message-Id: <20180423072301.11962-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0128.eurprd05.prod.outlook.com
 (2603:10a6:7:28::15) To DB6PR0202MB2774.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:ujJqbkHEg+PnHXSTapAuJ4CnHQwvbhATBg0m01/9UqjZcA5fD0zSqjhqlaSGUvVfk0utJXDuzN6yjs7/pl1J6tcSpWt8H2t2f1j/tsOp7DAGSo24bBfsQEjbhRS5IEgxL1u1RCOtppox/MzuM3kNVSaooYEeADjB6fxKo4X9/QnhN/T2F+UGzuE6huTEnIVgsHV204P5tXveaNWFJahxzwVp7mqgJT53B2CaHCL8CdYak3js6UYz9iyzSsIXr4Pe;25:by4f47zaE1d0CrU9Lpa9fmbs6J1KYsTnzI1gUJHUe4A4zeKMB5aWLYpdJASaevh6H9ntesoKCOO5vkmVN2QPlPlT9H5GH1CGlOt24Qw/QSEVDYAhNVIcs3Eh+bRXs8hobJDN+/NJx18x8CCB5hU7cKa/VfVwyap8pN5pAKVWclNepCWR1l/ciU5yCsLmABqtjyMloiBjK9YhLGLifSraUuCNCPlJuqeeXyrnxrgX3WpoqTbhJokWZdZnEXSoZ1gAYfRlhchbKxAA5MJqIxxE/akHZBWDDl0AIUprZMSTh38JsZ8jyFmq3G1I6oryduqpmx0XAcvL7XyH4Wb+LHe3DA==;31:92vUYMpkvbfZPbgpzBy9bezaGQU19SvtEzA3dlu+gFMPT2JXgpckKrocqETvIBGIXOSJvh2KA3/xhBBekbPVpSDZWbAIthvir24mCfhrlB4Ocg0XbzLTkhdAKLNtydVB1Q7Bo7Cy8HmqlrSrp1TLoxptvq68k7Bt+rZHAVqoF1q6K+/OkeOnLQxu0os5+j23vwwu2Tn8EAJsoSik1pQORa6piiETor93at7pz8uOye0=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB277408555FA7103A4FA0C06CBC890@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:bog3iWSQHc0fPhCGqhyu1KmQqv0ellyMKOkmpaAunuooIMTfXcK9hp/+Iydq8X876uNqjBgKbw1BLhChS8Cu8tJN7BIjserrX19kn3TEy8PYnHZAkp3FYRRXeEyvuQOE/lYk6nfhx7j0GcVyENRqMA+Fsulefi+IViN9dBQ3BNJFnc1EdCydAx+kM1a6Vxil5YukjJmzhzjSKBrZxPhizFU38rYYBOwLwUXIvweN2KhqHgEW3E89x69ewHLcgAa9BUGquu+/3WvTS59xcY6lLw==
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(52314003)(377424004)(6506007)(386003)(59450400001)(2351001)(25786009)(2361001)(966005)(1076002)(26005)(476003)(3846002)(6116002)(956004)(2616005)(478600001)(52116002)(66066001)(86362001)(2906002)(16526019)(81166006)(48376002)(5660300001)(305945005)(8936002)(6486002)(6916009)(74482002)(36756003)(6306002)(7736002)(53936002)(6666003)(316002)(54906003)(7416002)(4326008)(16586007)(50466002)(186003)(50226002)(47776003)(8676002)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2774;23:C50FGvMyewVwb1c2hvj390q1eMRoSKp7XIbKFcL?=
 =?us-ascii?Q?HzzScBq5ViDiGnsUbLz5j7aFlKP5QikfoKkjeU2zEvX7AQgo0mS4g5kh7c4A?=
 =?us-ascii?Q?1Ean7IDCDFHrsz5rjcOssGAfh+iq4HeuXHYfTuOZYs55rgJXRi3NqacyX/QX?=
 =?us-ascii?Q?L/9ysfMYTz2Um4iilKQjK/T+asAwpe/XXX3xCl2DVdAIikhqPZNXxI/a2Ris?=
 =?us-ascii?Q?lciHCQ22Q4sUGqyxcuEzodHOyBZNQsUunYOUtBXVpU8gKHU9fr6OoANISl6Q?=
 =?us-ascii?Q?7KI0x/J7YaHRao6Cszffo6F6zckZMYmNRuUEsL7Lcq51RYpHkHNC/XPn1YSv?=
 =?us-ascii?Q?s0kLP5rRAefDuRrUAbS0hyyIKGMD8tjWiyeowiu80kE2tNVeqvvpBh0U5oW3?=
 =?us-ascii?Q?vILufPYOMzab0gpISNk7Cu/GB9B2nVK1DE2t1pV3ClNMU8l+e93Jdb+mmqeN?=
 =?us-ascii?Q?e+ksjqGxDIK/L/syV9Iz7SiS7AMTZSxfrp3KNXL4X2v3z5kxL8RUwjm/cOf0?=
 =?us-ascii?Q?0spbhWqy0nz330Xg1WfdsPxIpC+Hxi7MDyaRURIrH/xt/wrEUkQNsgVZGDkQ?=
 =?us-ascii?Q?FQATXcUPo/jwBaFnoPD7wWLUQOwqpXnjc05bLcheICdzsK8aKkAe7gsWGPzj?=
 =?us-ascii?Q?S3JHNFWDZRmvsKPMAjUXl0PPMKND60qv/RA3E1DKy8p+J5j5cmJRwBq8sNU1?=
 =?us-ascii?Q?PXawdtuRp2Y0zG9gK/4JZhM0Ymi/c7HI4RtgirI5+DvJtQV7JR9Y5+c6ufl9?=
 =?us-ascii?Q?QPyZ7ic19gNHRXekXwehtsRLjCKa0rpD9rWLnKOkUcNRGRLmqVC/D2hCOdii?=
 =?us-ascii?Q?I6wEeurKE6ldJyGJJAh7VMBEUMXXIAzS8SFq7Q0Ee+QK1+oe+sO0h9fgPY6o?=
 =?us-ascii?Q?EocpyeMgJcThYfJ9s5Au8c4faH/rXy/EzwfG2BgHcbtcT9iVBxX8cJPEsZCR?=
 =?us-ascii?Q?MQA+iVqq496r2aTRpoSdir0JVD4DweAcZP5i8Xjs5z8DvEtgpIHe9zh0z8SN?=
 =?us-ascii?Q?Z6KouZ/fB6YRqpRGe8bymvGZFCIpAkzAX+UyzrMUNqwN3L/s8xSAPpY1U4b6?=
 =?us-ascii?Q?9Tu/wK1pjWDTriSkQGTUyk2LWnTc+CSJUZWFbbqj0pjFY7ZGXvWTDW1nGgwT?=
 =?us-ascii?Q?DgujsM8p9I11f6VITrY5ydUHlmo7qnzIsg8x01ETM4Af/ZxoPvlijxQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: kLzbjw4j7mMUMTV9rAdxHs7+tV4huNNex336D6Fp/EUnvLGsy3NbGrikAwu6BMycyyIi7tMQZAIlRIRGt0jtYxCPt/uTHyy5wKMP3PKSDY7muVWwEhA8Ix6r6T6vyCfSBfxJ9gSTl+Uh7WkA3rZIBOnIAYBf2WPgogGVPeOkmZws/MsDUVCrwKbco5FMT3ae
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:Jx/4sXMedisE+Proav+18f29dJnLkmpc/VjxgViw3YtiEXUBh86R9TgWeXg0Xs5t4JB55RpPYOK5yu1JaAsqHq1QweSFmrmVKQOrqaVSPpSa//zMS0BuzaE6EpIwONAss4hlyuvBLuPheG4QTErNBeonSkurpF7+TTDdEH2hfopNAsTWM9gXay7OJF3U2rGc6QXk5TmI1QzORPZsiX6k4DieYgwRj6ADAOcixr/lrJqzl5wn5QM66JQt3eBh2OUwqchHosdT4RPXM3nj26JE26t9NQENZDPmxir2aUNpf9H4FSH/R8yGmzCE2SxiY9D+ZZQ8te/sumLCbr4+7pjT8bqglApAxRbwM3bLlfrx/VeU1Dr9vjj7djZBXARyHmuYkSJKIdk73Sbn8V6yesF6iC4o32eeNpqHoQcXG31nFi6Glbeo7SVtXA84JZA0oWXbeaPIz7A93Bg+o3qz8Mcl3w==;5:pQ+hTypjU1QWjGCxMVKg1u8D36DLBf9KTO/T69vO+KxwXVOcxngLM66T0TdWEkSzyJxBY/pkvkh23OCAHcMEJKsXJCQ8T5uUiT6OJntmxDJBxiUKweeGdQKtyUkVsNUiUt6xGY3D/GvaJLBSaFhAJhZXuASDmtG7ZV7paYSS+J0=;24:vT9p1Dzwf9j+MsvK9SiCWmEo0Ej//SIvGPzxgGv27V0ExfVbfA4UeX1ltAVIvG1o8snao15gKkdiPHGCp8Uz8k93GWCzEVpcm0IXwk/tmrY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:HvxQIRdXItpq8WYfDnV/jsbs9Re2DK/3RGQb/BQmpVXUJ1G05ciLjXpm+tlcFGErvOhBRo0DNO4GKTW8zeqAS8SHHdDEjO3wQYh6moENlTvxZ6ykXWbaUcm5Rk0SyqBkKmOPOIhUHUdy72GBw9omRugsgiZhl4EPx2bLKHbveBkZ6HNDqFCd0lH6tvoR6OFQ9XzvK1zOpVh5Y8Yw3Lua4T88EY6ceSRIYkazugsX6QTdHL815M1c6Nozkflsct6Z
X-MS-Office365-Filtering-Correlation-Id: 1a31d878-a445-4610-c87b-08d5a8eb11f4
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:23:10.2797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a31d878-a445-4610-c87b-08d5a8eb11f4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I naively thought that since there was support for both nxp,tda19988 (in
the tda998x driver) and the atmel-hlcdc, things would be a smooth ride.
But it wasn't, so I started looking around and realized I had to fix
things.

In v1 and v2 I fixed things by making the atmel-hlcdc driver a master
component, but now I fix things by making the tda998x driver a bridge
instead. This was after a suggestion from Boris Brezillon the
atmel-hlcdc maintainer), so there was some risk of bias ... but after
comparing what was needed, I too find the bridge approach better.

In addition to the above, our PCB interface between the SAMA5D3 and the
HDMI encoder is only using 16 bits, and this has to be described
somewhere, or the atmel-hlcdc driver have no chance of selecting the
correct output mode. Since I have similar problems with a ds90c185 lvds
encoder I added patches to override the atmel-hlcdc output format via
DT properties compatible with the media video-interface binding and
things start to play together.

Since this series superseeds the bridge series [1], I have included the
leftover bindings patch for the ti,ds90c185 here.

Anyway, this series solves some real issues for my HW.

And as a last bit I remove the master component code from the tilcdc
driver. It should no longer be needed, but I have only compile-tested
the patch and there could easily be some gotcha. I marked it RFC, and
it should get a Tested-by from someone with a tilcdc/tda998x combo
before it is applied.

Cheers,
Peter

Changes since v3   https://lkml.org/lkml/2018/4/19/736
- moved the meat of the drm_of_media_bus_fmt function from patch 3/7
  to a driver-local atmel_hlcdc_of_bus_fmt function, and squashed with
  patch 4/7 (this is now patch 3/8).
- patch 3/8 now parses and stores the DT bus format together with the
  encoder in a reintroduced struct atmel_hlcdc_rgb_output instead of
  allocating a separate encoder-indexed array for the bus formats.
- patch 5/8 is new and splits tda988x_encoder_dpms into a pair of
  functions to enable/disable separately. This fits better with both
  the current code and for the followup drm_bridge patch (7/8).
- adjust patch 6/8 and 7/8 to the above simplification.
- added patch 8/8 that removes component master code from tilcdc.

Changes since v2   https://lkml.org/lkml/2018/4/17/385
- patch 2/7 fixed spelling and added an example
- patch 4/7 parse the DT up front and store the result indexed by encoder
- old patch 5/6 and 6/6 dropped
- patch 5-7/7 are new and makes the tda998x driver a drm_bridge

Changes since v1   https://lkml.org/lkml/2018/4/9/294
- added reviewed-by from Rob to patch 1/6
- patch 2/6 changed so that the bus format override is in the endpoint
  DT node, and follows the binding of media video-interfaces.
- patch 3/6 is new, it adds drm_of_media_bus_fmt which parses above
  media video-interface binding (partially).
- patch 4/6 now makes use of the above helper (and also fixes problems
  with the 3/5 patch from v1 when no override was specified).
- do not mention unrelated connector display_info details in the cover
  letter and commit messages.

[1]
"Bridge" series v2   https://lkml.org/lkml/2018/3/26/610
"Bridge" series v1   https://lkml.org/lkml/2018/3/17/221

Peter Rosin (8):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
  drm/i2c: tda998x: find the drm_device via the drm_connector
  drm/i2c: tda998x: split tda998x_encoder_dpms into enable/disable
  drm/i2c: tda998x: split encoder and component functions from the work
  drm/i2c: tda998x: register as a drm bridge
  drm/tilcdc: decomponentize now that tda998x is a bridge

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt |  26 ++
 .../bindings/display/bridge/lvds-transmitter.txt   |   8 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  70 ++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |  67 +++++-
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 268 ++++++++++++++++-----
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |  11 -
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  67 +-----
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |   1 -
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |  51 ----
 drivers/gpu/drm/tilcdc/tilcdc_external.h           |   4 +-
 11 files changed, 357 insertions(+), 217 deletions(-)

-- 
2.11.0
