Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeDIK7c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:59:32 -0400
Received: from mail-eopbgr40097.outbound.protection.outlook.com ([40.107.4.97]:6910
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750982AbeDIK73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:59:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] Add tda998x (HDMI) support to atmel-hlcdc
Date: Mon,  9 Apr 2018 12:59:13 +0200
Message-Id: <20180409105918.20792-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::37) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f567f7cf-f3bc-4db1-5d68-08d59e08f5a2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:iEzSVRXu4HT9DkkPSGlyRbKUvApkAVRMCcB37Np9eE9CziXJBQwE+B/FE8Rx+tfq0HQOkg1NmbbDh7+epq4Mkh/c8z/1I5IRmF5fotg8LesFCNNg3oYVliLNUu72adqQ2T6fOx7oNK95AMkKF3Kp7gLxBuaZVFL8STRv2RBfK8+s/1+rcSGnrSH/wOg6dMAgr/Okxkz9ebjF8r8u0f11wA+AWcj9WssEYrYsAzmjzCpcYslrAmUeCuIqfRsm36wi;25:w3EjR752hDyFeVI2uUEhUjXzmmZdYO/xZAkv9CBrHvLfsZmUDlWivxJB8SMAy8tvWtf1xdaJG0zZTOa5Pc7ZwUhHx8jMuQsqkU0WFJv+7hMcADLzGzqJCDu/diEIlZbS4ZctVOOu6If9TgPoIjSlNjb35MTn4Cg4tQ5MlEiUFSfxykHpsJ83xiE6NesrN3hKycqS6nfCeE836Zhrn5ySBCyGRDM7LFeIi2AkoBDYl5aNgihHc3DggdtyLmsMD4R8pV3XEYtkv+MqTcTCA0SbpUeqFaoEW65fgLathYcjfht4blgahnV0vqfcn87kbiUQrp9KWLMtnZkNtRrdtNQMzg==;31:OUftWagLswA1rl0E6VsOwvQfg1tl86ao4WsqtbwUP1Pxd6HJGZ8APh78ALt/kwoB26yqWar9DYMnQ+LzReUaJobsJE3v1cvWQ91vjqibeaG5CXGECUpYSFe7i9BzsdRGO5hLGavvjUVauT2xtBbPcg5lZFjfbr2vsHpZynUx8Fm/FEdaBLRH85X8+ArZgtjT99ilyCbkZQf7rZvic5D//DEBykZPHM3F3VoLpstXw10=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775E50E3ECE702077F8689BBCBF0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:jzD5nqIgQIfgKgng9tUuG0zm5v7J7b+MWw/nzQeiq9WgQgJCCyd4IaWogMVlrTgpvH50MxnpIV6M2flI0Z/htVEYlrmg4IvrKBCfGMVX2erV+EpiU/1DkvjZsihtVdfmqhCGyKgoBTyQdz3EcU+Sffiv1k9IY+cNbJxk+cCMv67Sgj9aa5eus5ind69SDXrvz9GtO1P9jgt37dgYLAxIa7el/MMOz8qIv/AtvllNviRos184UDRr+X2mvJXDOu7TU2iM5HB3SIsqUhrWQ+3T/g==
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(39830400003)(396003)(366004)(199004)(189003)(52314003)(86362001)(68736007)(26005)(106356001)(478600001)(186003)(2351001)(16526019)(2361001)(74482002)(48376002)(16586007)(50466002)(54906003)(386003)(6506007)(316002)(52116002)(51416003)(6666003)(6916009)(2906002)(6116002)(1076002)(105586002)(66066001)(47776003)(97736004)(7736002)(6512007)(7416002)(305945005)(53936002)(5660300001)(8676002)(3846002)(81156014)(81166006)(36756003)(8936002)(476003)(2616005)(486006)(50226002)(4326008)(6486002)(25786009)(956004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2775;23:PRDXZngXM3ZWIeRJbALFo1Y/GZ1xNZvjWoMygVJ?=
 =?us-ascii?Q?8jXEoyaCGgDoG1XIz+y/+9X8rBRs0gAIiGqn7uB2ozHXqRTjkPPNJNm0xasL?=
 =?us-ascii?Q?p/tzIiOYXeua5N+/2HU+gi5a3Pp/LYxDrND3bAt98+jGGvSakJZNuXmGXd4Y?=
 =?us-ascii?Q?H8e4dpQtcOtEOcRnw3UzBCtT6NcsTBr4V3ntMFAe5BZDQH3hOFTdJh8u4Q/S?=
 =?us-ascii?Q?RYTjv4jhVzNh/2qyArz4mNhlg2mcGoxbfglXnLCht3DtzmmGKn52HLJTD1OP?=
 =?us-ascii?Q?nIfVE2qBoK36rh+MIfpHDynmus2TGfI/FG0HX2HSry0HrV1EumelozJcXs3s?=
 =?us-ascii?Q?wR8FXQJWSbp8iDGJpv85XtM60iJ0twWCxp7lRN5TOZAeYtb2HMYnEExeEVUl?=
 =?us-ascii?Q?NQdd8i9oHBcJaqSoucwdKBzVwDqwmSKBmPYPcTxM3CHOfTK4O02K7/ps7qhE?=
 =?us-ascii?Q?qE/bJ9L1n9S+i8smHtvF68N5nesKSdYyhNKw1Sexpd/XVQwOChUcPYinqLl2?=
 =?us-ascii?Q?RvHkyefOXJlhGc/L7bsmCHKadSsC6uA1/UPhkrQyslh4BSGu53pt+QCCNFz6?=
 =?us-ascii?Q?Ccv7MWm4IQ/Z9VPvhGhMV6XOM52dZhOIUDYAXy0ZUU/DNh17L9heflenJy43?=
 =?us-ascii?Q?HDj10XH8eyy3hbf2mr5EnJTLmNc5T4Lj6RxgH9InRZsGQ5SJLVDwGoUGXnic?=
 =?us-ascii?Q?qLI4OOvaz6cbSf7wEwKN4EYT+p/mdSMb5RuiMMhtjjJfv48ZFBSgHmxQgB1r?=
 =?us-ascii?Q?peIxnOiwG1rJzbpqv7yQgMYUfJvH9v5TNyCI1aY2Z+/EBsMLUix9kGHTS9v5?=
 =?us-ascii?Q?xjwyNVyKPpVy4jOmYaQJwUkXzYlyvtmxGquzwZp6SRLX38WpxU7hemkUr2oc?=
 =?us-ascii?Q?K/L5sQBW8KBbnxrW6QbwVYSRnpHOEbjdQtoNOKaHIG5Rf8rP/ERiHU+Ydfug?=
 =?us-ascii?Q?A/tFLhgM6c6f1fSUh1SCikFq5KOFz5IR0Yl+mywW0gQkdk6tdbekcTOhJgub?=
 =?us-ascii?Q?TwOr2X0ng/dYb+fRpny89kE+04E8i7QakgCmZNcBZ7S0QxiRF7aNNV04sJHY?=
 =?us-ascii?Q?TL/Ue17cWyU4eBmYuXcsrQxG45VFBSBOm3LWpXdYct+qKqwukKycD37q+nWe?=
 =?us-ascii?Q?CPtV4UEsOc9HWr1HA240ZVprWbnzDkN0EvdtLl+HVCqXunbaB6MeqySA4yxT?=
 =?us-ascii?Q?f/hyXUoIA0xAcwbcIslrjtqADR2Grcs0+UwY12sTTihJnpZnibt2sAGiyipE?=
 =?us-ascii?Q?/1LRd3QXNuMKKkA7Xia4BNRovdwiM9sFNgK8VJAZNEwCOskaawNGSEzkmV2p?=
 =?us-ascii?Q?Hfw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2et1/wCD9xF5/L366FZwaN2PF7KPwgXrnCbtLsX4sgYoXKAz05qKvVoKXaSmw/A0jMmfIZ/TKZ8W0GpFLfH2c5bVhQQrjZ/9meEbUZnXU8UxD63f4kt06gZepQMbO9fzneqC+TFnuCpJu48foLTTukGp0Gi4Hp1aLCs2TQ6aw0Gv2M7nyCSsgKTUbZk58CEf
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:egcVaZtPHUOs69COqLdDRKJAtNZ6YaNj6xfiuUQ93eyApjN6QDPZe6P51DD0kI9T2X605SDFaa9wwt26rV2vZ21IBbZz8CWYJTAPGUgxkrRuWsGKpShTXOC1k1JeLmYn6UIVlJVxbswkIVEmpvdmqvvjezOc+xTNc+Gtq9ouNWvdynS6ohyeRE2Ti594Q6QWwS7kWQMiUH2QOd1oHiGpqPPCXj5gH3oBt/aS/9ePKno25BNqWa4GtsLvQUynGbdk2gM0NvmF9Qv2Kek43z/4rMrKtp8T/RDjP7l+Q0YlN3I/7PXQgYe2wugIZ91ahktImWwxC/6XcSSfOSNhnOQPvs+6e3Rttac1juvBVZIZJxc+nBMNvkJGTtjDM87G0CQfCpHSLpCd3FjXkI/dEMWPZYYYr2r5pO7wHhHqFSByr10HJQ+pHveXdW45Je9kjq2mSzyMdMlzkc3dIaDSbEfcJA==;5:HYYgTfsGzYiz1dtTR94qUZLdMntP1aA4KOYipfnzbVDGgcAo+jEMFwb9zksc07V2IINhvGjtXv3ZH3t7gqfcKjmI1QRZ6J8fQLvwiARLRQsawWRvdcCOOKdRwFcMRkCkcfWt630+owGlOPIf6cnXofdIXr0SQolQBU340kgNVZU=;24:uq/eN3kAcdcqYmyKJP61iWG/2lxxD7+xGfZ9Q3mMhSmj5Upo7vpP3VAQEeb/VML1UzzV2AGjX22V+iYSk3L3/3+YDFA3k3hJok9ajSdcCx4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:Fl7JAEqeq+yJKM/KKLb2XjScd7S3YH4v7aGSShfIsTexhU3sBpqd57zqlXfyNbQ+CjuvlhhQVyh2p4qf+mU1DAwyzZGwJ+PhbLnYKkxfUGxiBYbAxhCYYc11vLUo4Sk1gQbaO7iR4/Mwoujg0jL9K/remGA4p6oQcDCTisEEX45Zxr5cNOV8lHJP2IONmSAW/gQnoVgnYvntgc8Ftg8iAsJcYh8jeEgGXz5P++ROHK0LDhQO5c+4wkZu4XTmedGn
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 10:59:25.4528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f567f7cf-f3bc-4db1-5d68-08d59e08f5a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I naively thought that since there was support for both nxp,tda19988 (in
the tda998x driver) and the atmel-hlcdc, things would be a smooth ride.
But it wasn't, so I started looking around, and found some missing
pieces in the tilcdc driver. A "stole" some things and made it work
for my use case.

During this, I found that the tda998x driver never sets the format in
the connector display_info. Thus, the atmel-hlcdc driver fails to select
output format. Since I had similar problems with ds90c185 lvds encoder
I added patches to override the atmel-hlcdc output format via a DT
property and things start to play together.

Since this series superseeds the bridge series, I have included the
leftover bindings patch for the ti,ds90c185 here. I also noticed that
the driver date for atmel-hlcdc is bonkers, and added a patch for that.

However, I don't know if the tilcdc driver is interfacing with the
tda998x driver in a sane and modern way, and I don't know if I have
missed any subtle point when I "stole" the code and componentized the
atmel-hlcdc driver. I also have not tested how this behaves if I run
with the components as modules (not targeting that).

Anyway, this series solves some real issues for my HW.

Cheers,
Peter

Peter Rosin (5):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: add optional output-mode property
  drm/atmel-hlcdc: allow overriding the output mode
  drm/atmel-hlcdc: add support for connecting to tda998x HDMI encoder
  drm/atmel-hlcdc: fix broken release date

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt |   4 +
 .../bindings/display/bridge/lvds-transmitter.txt   |   8 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  12 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       | 104 +++++++++++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  23 ++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 130 +++++++++++++++++++++
 6 files changed, 266 insertions(+), 15 deletions(-)

-- 
2.11.0
