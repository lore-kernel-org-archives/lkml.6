Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932283AbeEWJbo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:31:44 -0400
Received: from mail-he1eur01on0092.outbound.protection.outlook.com ([104.47.0.92]:54804
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932163AbeEWJbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:31:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>, Andrzej Hajda <a.hajda@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v5 0/7] Add tda998x (HDMI) support to atmel-hlcdc
Date: Wed, 23 May 2018 11:31:15 +0200
Message-Id: <20180523093122.27859-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::23) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:ms2eKY2LYvsK7Kv+iJHoIrRu+avzXHn2nQ5Tji746kVDCU1SrjhuhcQH9bD4frgOuvFZ1LwV5aXWJAqA/PT/wZSYG3Vicq+lv0WgYPj+1g3Zbs3awgmiWCq7BRFjzCv/DL6G+Lxfv4yIsw4wVWCordmCxHiGzT92t+62XRPdkgM1VSkvkuZhn/JHh862qT3k1hIvZV4DcJv9IeJpXMVzY2A8xxXfmM1NKOYXULP+ybiCBe2ygXgu/1aLHj0FW2sj;25:+3gkrLSoJo5iDymS/GV6GjprUP/QZGvEN9oU9GBfW+qvfqYy+KUbQ3mCF2vAfqy52l2oz9l3dW7H+TLOjQWfMUtRRckp8a8bmXmrBd5gfPCI7A0VTFkel6bLQ+xwfXxeZLBNeUGipyXoyE+y5Ix7gC695HHYmtgbr9PyybaXgCbG3UatZrjMzMRsYAzNsM3AgxkK6iojvoCsvtk6Q5tQvQIqhBo3OsjBKEPj+9VcE2dVxyrIlnJarCpX5RTpC8QGBh61pa2qxoN6d0Nri+ZrPXl8OBt4hujX7sgRJ2LAhRp2vZwT4yLbTxNKx774wNTnmZxXf5lDdSMoKXBQ8CA/+w==;31:l0ENQWjzrp22kmd0i5mdTGedKLEE/MoyA03N97MP+eYP+GkgK66Xp4oQJemAqRmrHu+4bykqGLFxUs5A4Dm7fiCfvwrjbvGfmXsyjdul3o5KLaGIydsgSHnlPOPJrP1SbP2bV/15E6S1/cq1rd+s9DATavmeI9pX4DKpau4EUvck9/L0PEQgJ4tMOSlPDUwWQg4lWjowMAZcTzPL1rCBC5wp+8/y2lLNP80TKyiUJDg=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278273A3F0D986C7278F6A22BC6B0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:ytVrnPrSLdBnBOfuow+bjw8wKNt1BYhtz8vVNWVWbk75tUz1U2ec0wjtRFC0Xw9QFczS3byxwihW5VHMG2QtRt5ad23hafPSJznwzkf2YeMxr7LfKSb/mgcg2LyZgxwVxOLYqjEr2jYuSdLnZyquvb9ffgH+57I21RGlO2BmsruzaTLkXRlD0+DhYq/yWtkCgaUAdiSLBWrXwbEz70BY7DRc+Kv0VSYyfOdWJeBbR2dj9Hc/d58rPWxo6R1n+vyhapZDL+u36dICpD/K2IcfEw==
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(39380400002)(376002)(346002)(366004)(52314003)(189003)(199004)(377424004)(486006)(68736007)(956004)(476003)(3846002)(97736004)(6116002)(966005)(478600001)(2616005)(5660300001)(6916009)(6666003)(53936002)(2906002)(4326008)(6512007)(1076002)(6306002)(36756003)(86362001)(16586007)(7736002)(59450400001)(52116002)(51416003)(25786009)(7416002)(305945005)(8936002)(6486002)(2361001)(48376002)(106356001)(66066001)(74482002)(50466002)(47776003)(26005)(316002)(6506007)(81156014)(105586002)(16526019)(186003)(386003)(8676002)(81166006)(50226002)(2351001)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:8herLbD5GHbaIsMBZjzJAfo7SFCMXH3LbAmWB4/?=
 =?us-ascii?Q?495YCzt/3lb1iOtMjxKpZhrM3IVDkrMrvoFIkYMKSDz+Ig1sn4mPBQ99yYxw?=
 =?us-ascii?Q?kNWIYC6Lk/CNXm/i/DWjukkuAHtzK1ZpX8K0qh+o6y0GYPrB3gK5x25nA4SS?=
 =?us-ascii?Q?OJjdMshHL9m03NHbk87pC6A+s1KryPhWEVLDLPrzKtNWAh9YjE3hobQ4PH0t?=
 =?us-ascii?Q?lfBVZqKvtrFlWhys7XcmzXywPaKbKCQo2anD1627wKMrV/SSVdaFyapNzDBq?=
 =?us-ascii?Q?CWrHgo48EXYz9kGm/1mmRazVjYZT5qqqg+ZKpnMmgB3ePLntyMpj9gukZTRJ?=
 =?us-ascii?Q?5/mxBid9aGNz0d1geKOj6862fnh70PUBA3PItNzFpyrHYVgf0tFmPOgzqtdS?=
 =?us-ascii?Q?fOF0CsBY8ciHJ1WgbxOVtRQclhDgR2EzQsKkGtkZwH2GqcCeTwmQOs3/ofPq?=
 =?us-ascii?Q?8DSwVs8EgfOzb5mYcTdtZm5NlvNWggsMBlx+jh5em7J40AMzNgLhH13Z8exm?=
 =?us-ascii?Q?YCMPTJaqL0En2e9jZpzxQG/HpVKxWxAVo1zF8Chi0JNGbadzqoZ3KJQzyZFD?=
 =?us-ascii?Q?iE4anX01v7KibkTDguRPY8zFk1hydVYAkmzBuXm/NuVQeahwJpCp/B24RVlT?=
 =?us-ascii?Q?HtPsFKdtmcWonDhG5NDyoOLx9/BYvL3EtM60l3E61o3S2BfHqFYWDELqpJ2I?=
 =?us-ascii?Q?RKonhiQwXVtX45yMeqAgG/p4PndO64oaKz7CJ0aT9UDX99GRzQUMCLWP1nqg?=
 =?us-ascii?Q?eXBw+iDawpVxaBxHglN7ids64MjJkOO2Wx0cfdNrA0p3BMuLO+stN+z1Gu6J?=
 =?us-ascii?Q?ZB+oE293owxtF34ug/LpoVTHoJ7rqvQ8Ci6Hgrs00PnBGNXTfw8raT8Z9jnN?=
 =?us-ascii?Q?m4/cAj09K2U6ByttEeZwSa1dvFTFYZVMkciGlc9ckpbkRfcrVZwXlzA73u1N?=
 =?us-ascii?Q?VRty8jFOUQ2Nw89E0z2nlY1H/bmkjUuQLMlr7JCFzUpKIzKcVqMDZRNE1941?=
 =?us-ascii?Q?nVtAaQOAPtAUT1WIZ610EOFfSVhvWyAAqo7Hycl82cQootbqB/3G+iAU7V2A?=
 =?us-ascii?Q?Hvp106g4pqdCl6YcAnjw0k0qcIdv773jPcNUELJjErp14vKAAYaTMiSuBbM5?=
 =?us-ascii?Q?G1Nyg47nDxxDFteuZkEJPTCruc3UVGykyAqIVnDcoyoAnW+BK7bReuZyxVHk?=
 =?us-ascii?Q?3zekNAdiYMLmKQeyZiOp7epBtpQlF8fjSGDuQM1yr8jtYJ85Cvs6F33lpg7w?=
 =?us-ascii?Q?e7KBMz+NzaXdvO2xHzBhvRphGOqGHgYI0TlGHD/Kmm4GyOt7KQTg1xmGu4SX?=
 =?us-ascii?Q?l5y+OgA7n0UMG+ufp8YtRbkOuShmwoCPXhdU4BPjn3y1AKyf4idzkJzs90cD?=
 =?us-ascii?Q?Salb5JzvCpqukjZYqyIUPqoOOjeg=3D?=
X-Microsoft-Antispam-Message-Info: dK6ZQJP6KPf1kHrAPAbA5+k540f4trKQ5Rk6deSnJ0EGM+f2nOasK8ymJgXs0ToOcioix3KsPZi7a19MfFMk954f1GJV0loj9tJdI/VqV89r+VYWy61OcMBKbO4S4VnzsGjXRrIp4XYSGKcXen2J0GPjxAbL+j5CBCFrJt9eH8l6YCT181t3jfENp6iQ3eqB
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:ZpPaOk5E6peIz5Xk1NpQLGk5bg2zOYUmdM2snFN9quZ0gZnu72F5UWi9s6x5eYRHRz2P4XdH8XaT0YTUg87/SZVKo91owe0Hf6LwL1EFHln1hslCFgpZgcYb2Rjvq2VNxWXcXKNaKtAsXmCoECYuAvhBq0f1qgnemeK2Ru93yXx+Pqj1naEyEbwCxYsakEjqwxJPF7oJacbVlp9gYRckyaIXKAqKkJTX/WFywfBDa5zkh3JSDYuY3bYClG9/qFeokzvFtMzpIWF4qD3t/nahkJx/SucbSM6jaUc3SVQld2IvYkLOdQk4t4kgiAjdAPKaozkNU67YF7IefMO4RE6Fpoz+kLgp/WI1MDknC+A87Rv4PfF/Q0Al64kILg6ey2jRAd6iwctZvEIU7LhEB7V7BBmW5/CLhLQBMgjoa1SpB60Ybus1FH5HjJJedMPKhxVJXqkFGmJShO45v+rtq/I3dQ==;5:8dijfIzcwgbsMhMX/kz0iEVxBCwSRyaguLgKwkt7vz69wWl/AiKRuvcNCJTFfEH9AbmmKioPno1BGl02egbZTW4s0CCs8RagA3RMkpuyVKYKpEjnMHPeeuk3FK0kN2yT08Y2Q8WsBiSZXc+Gnzxuu0oBRI29QmbIIfL9INUAqAQ=;24:+1gk8DtpGBKH8cZJU9Ri2ZBsAljFGLP9c9chBFzgUODXfwjuGWioybOZC8KjIBeBMkjUys3TwYgj6mDVHTm62zDcYtZIw8mNp4rEE16Vlak=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:KR6Lt3KaJdyeksV0VUZNjzoe/9JZGBGhXVSFJP1I8KQEqLvKbpodXl1MKshupCXFP/9Kh9PrQ0SWA8U8b+vQbLSGQajD6OcRyzVxWM76mTQdJisG6i7+z00xy3qTVrEY2CQW/Lu3j/VK73oAZ8eSmIhcX21i89Mz0MCl/xSWEFFctosJumZpuOyfnn5SBSIPe7xy36R5+V45cqctOoSMbZ2FHG60DYAnzJ3PRNNu0eeeU/Vlrv7bSyCeanGHoqH4
X-MS-Office365-Filtering-Correlation-Id: 26c4f003-6b97-4056-6e13-08d5c08ff891
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 09:31:31.4211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c4f003-6b97-4056-6e13-08d5c08ff891
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
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
comparing what was needed, I too find the bridge approach more direct.
In v4, an issue was noted by Russell King in that the tda998x device
might be unbound with shattering results for the main drm device.
This is of course a real problem and it needs to be fixed. I have
submitted a series [1] that tries to do that. However, since there are
currently *10* other bridges (analogix-anx78xx, adv7511, megachips_stdp*,
nxp-ptn3460, parade-ps8622, sii902x, sii9234, sil-sii8620, tc358767 and
ti-tfp410) with exactly the same problem (they are all I2C devices that
might be unexpectedly unbound without safety-net, at least that is how I
read it), I think it should be ok to add one more and then fix them all
instead of holding this series hostage. Apparently people don't go around
and unbind I2C devices all that often...

In addition to the above, our PCB interface between the SAMA5D3 and the
HDMI encoder is only using 16 bits, and this has to be described
somewhere, or the atmel-hlcdc driver have no chance of selecting the
correct output mode. Since I have similar problems with a ds90c185 lvds
encoder I added patches to override the atmel-hlcdc output format via
DT properties compatible with the media video-interface binding and
things start to play together.

Anyway, this series solves some real issues for my HW.

Also, is it perhaps possible that patches 1-3 can be taken independently
from 4-7? There is no hard dependency between the two parts of this series.
Patches 1-3 have the relevant tags and should be uncontroversial...

Cheers,
Peter

Changes since v4   https://lkml.org/lkml/2018/4/23/92
- added reviewed-by from Rob to patch 2/7
- dropped patch 8, since the issue noted by Russell King is not present
  when working with components as tilcdc currently do when handling tda998x

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

[1] https://lkml.org/lkml/2018/5/16/380

Peter Rosin (7):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
  drm/i2c: tda998x: find the drm_device via the drm_connector
  drm/i2c: tda998x: split tda998x_encoder_dpms into enable/disable
  drm/i2c: tda998x: split encoder and component functions from the work
  drm/i2c: tda998x: register as a drm bridge

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt |  26 ++
 .../bindings/display/bridge/lvds-transmitter.txt   |   8 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  70 ++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |  67 +++++-
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 268 ++++++++++++++++-----
 6 files changed, 351 insertions(+), 89 deletions(-)

-- 
2.11.0
