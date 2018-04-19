Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754003AbeDSQ2M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:28:12 -0400
Received: from mail-he1eur01on0133.outbound.protection.outlook.com ([104.47.0.133]:26742
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753239AbeDSQ2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:28:10 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/7] Add tda998x (HDMI) support to atmel-hlcdc
Date: Thu, 19 Apr 2018 18:27:44 +0200
Message-Id: <20180419162751.25223-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::49) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:R9sFQXWOtdzXhTXvL6NXOdOrmlO16uoafjzToQDNGY3GVpU9QktPxeexyQ8ujMWPoAys+S4qQicyQJFBZsMKcs8hZURqegVXNmWh+1I48CA16XEOBc0IVUqUUT+fFARBoId51DBTS9UQ95EjFrBhrBOufEjonEPoyAT4iRAAvsas/tqva38LU8IO4jL25YtTKxA+2e857S44LPIVzPTGgNaXv3ePQsmdn0FBcLm2wiL9U+jE2F4L3fi98AovnAYx;25:Knhq5HaHM5XLXxCPsMN9XTKcVYRMJ2F4mQzdRzveVEtBCpXxIq+mUnKOcTSsLxWs8EanXdcjGHYV+6A/c849S+h1DQeyoK+jkOcSqJpSnguNtKKIKtYDaxyPA+ROvy1ki0Wv+o9U/GxAEVOh47Mavth0MN/mO60yAcPjKQIXlv1VcMWpvIH9IFNBmK+PDj/WRGV+pEuVp6M/64L4UU/BGe6EU8cID3njBRhANkjvqZze9BOBvn/obTQZZn8ZI3g1PbjdIM/c8A3SVJQjrDtZ3GhJRd8kDRJJSmBbL1QdZH3SdqdXcRrG+a6Sx048AH2WuOVBjJJpnzSAn9TyL7XETQ==;31:BkLnoGeilt9cfabJyFAIalDknnvnHp/8g/9mvbsoqmIFuwcPR6K10FPTxWLwsUeCnawXSFaT0YHT5NPFrJEyCVMXKN7+ou2gKxpZcrZ/gYKyeY1BWBmrf+8GEaJs48IyvknBNs9dLj7KaTetbL35WzSO6Pu+RKqObOnZmZtGXSVtaBRHTWAJy92BQXnAXQP07Hc8xAiUs12qW+h6wTnDnK8naMQurLqVTYKt7eiU5Wg=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278465A9D2979DC0A83B1EEFBCB50@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:sIwPisSO+jb03LfboeM3yMRf/kmazyYuZDRlmC/W44QCAOqZNh1sJlBuKQynK6Px55zX4bjNG/HInGrjNNiGB+uUQ3YWr+SMxAiTXO3XhEq7k3jS1UV38jwWiXOUZhw9fJiVtdkurmppY3cAomPMrOLbsq6d7hs3rZF+/XcnH/8zC/1fHCjTvZ4kAl2BXkKvERhIPoY8KWs2tUgo7Us7bgHciiMqIH8TI33/LX87BrwuCEbnKP/TZaaMFGVLYawcuhPQ4eB70Z0xYMGMlth3Zw==
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(377424004)(52314003)(26005)(86362001)(50466002)(50226002)(8936002)(6506007)(386003)(47776003)(1076002)(59450400001)(2351001)(66066001)(6116002)(3846002)(2361001)(16526019)(305945005)(186003)(74482002)(956004)(6306002)(2906002)(6512007)(52116002)(53936002)(6916009)(6486002)(476003)(478600001)(316002)(8676002)(4326008)(2616005)(36756003)(7416002)(7736002)(6666003)(48376002)(16586007)(966005)(5660300001)(54906003)(25786009)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:C56lIJwtUUtbaWboLTBgdb0+arfOYCrHfCVecv2?=
 =?us-ascii?Q?FGpMGkwZdvs+k8lINbil/KWwpWgeyuNf81cB+4+/lMovLNWKLgmaGv0XPidz?=
 =?us-ascii?Q?gwRLth7LIAR2PSJLOCwHHPtjR4ZI6093KlWZPKGmmM4GVtl5o2RyS9tafQKv?=
 =?us-ascii?Q?fLqNG3WLLDAUar+phCu7COSbHL+EB4PEbj+jndVxWrL6lXNc+tddvAF1zgW5?=
 =?us-ascii?Q?REenwDU1kMsMJOqCgpct+x/H3HngXXbyNNjuap7Te5CquVaOf7XYQp9nVz0b?=
 =?us-ascii?Q?qAnMYkrcfYLgqt/rqMjMwMzzFI+Rf+4Piuus+nVMrk2EEHpCUubl59+Xb5J+?=
 =?us-ascii?Q?IqflKgPB32pnqecpVuxR+Ql15QdJjJ3FiX2lWOcA4pvFaVLK0RAKNYeD0cgw?=
 =?us-ascii?Q?zszg6FgJ+XH72jYz7lj9BxTgawajrRSBZFqz6QxOwzCLMj0CiNtyAB3NS8bS?=
 =?us-ascii?Q?asVT9psYeWLKiUKMbE5oS+MJQyioLOsg4fWsy2LXLAVuv/3gUVqWaaqkFahl?=
 =?us-ascii?Q?TWmOPV3D2ilRiLPcDDAshbqoaZpavwxQS8A/ml4wYmo0wwm3/6x812zK4vrT?=
 =?us-ascii?Q?7R8eAcyNKuqZIvPUgdIeyNldFH0Pc4qVYnncm7jconhdLYXDVdOtFdQmAqSv?=
 =?us-ascii?Q?WJe2aj0GmvNBeSRJYA9GPsdcqocfjTYfC9Z/hm6dd7xHinxzkk7gRcEFutRb?=
 =?us-ascii?Q?SnIl75EjpmmW6g87glfH06KQLktU8bNuOF+pmZoz1ME+3E7fZ/6zHQDaAFxa?=
 =?us-ascii?Q?amSdZruZUUtODLOiAPUyghR5GcYr90lL7iqpkhxn2Rvv8rtJp09MReh2Rhmt?=
 =?us-ascii?Q?JO0c083xZeo6vrSsvuEpcnM9XEMT7a0MT85TuEn0nFjAjxMY3PPb1nKHdbYS?=
 =?us-ascii?Q?Rowq5eSnpejGVDucV3J9+vYI2T8Nwn+MpQ3ZvmjGpiAMI4reV49aQdyMCU6P?=
 =?us-ascii?Q?r1cPe1wq3DHzB6tgXztTX/iSLizNvmGykLlc66Q2g2jQRkhNCa9HLYsz/ken?=
 =?us-ascii?Q?Pc1iF+te14Hw+ZIXIOOSHbpcHq+QtppKTpmkVondEd8YzLT16jLupKTea7ui?=
 =?us-ascii?Q?QIJD3bEkliRHuF3UiVEAMS5mGzeYjJTSCDi75Y9wR1ytWhgl1KZ2ukPyae9a?=
 =?us-ascii?Q?B8MjGSRCvEymUrl/0YloYbpu/6kwgsHzvB1wfdxX1i+9YDpHc+f1cLQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: RYs7pC4APEX3IorwjmFOUXE5njPSXLjW0ShhW0fx/cdjUrvgse/bAYXGDTHdk9axv+62Eh/d5dP7tJObRDQgneFlGzd1gz48DaMAanBPx6wUg6awazVz+FeMIXekCsnZ8SsA+p4P4rJJBxPEVuWBPaQedWAeIZlrvMUpcUPylMFNzVC/qZ/Mq6BDSay6k+Ph
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:vgjwSbiQZxaIxfgPxx3YOmQJK4d+Y7dWAC5rqtDIuhcttE1751ZycIIB+hykdwOZd2f9hl5XgndmudE8XRsGYpUrfkXLmp5lSOtiFlqkHnK2NTWR3xIPBie8n/5+KVs8XjtT2b1ywOLZmQH+3gh/3Loq2C3S4QNGDWPCwOfW0wNoYh/j+mHVBm9TSjWJ/JFzxKPCb2qI/9Gmdd/HRYg6637ytyW73LFKfM8drr2iYyNQv6s+SxKqFvkNOLh9ZTdtj/SlTGBX2jETWDoyFC/58J3zLK23Zqcj8i7+sD4DNiyLXKe2Wf9dPwjb5fK0VZHp6qIKnSWC+wLnsUMIR6TitpZcROsiFXyO2dmdTuwL9O8FKPoPNZQ5S30Ez5GrNs3PqeKdkbLYdE1AE2P+Tbg3Tp7HMsg91uoTJ5BHecNpHq85kZSb/BaXjUJfYujIKiyg2tgpFhKZW824Qa+oy5Hgww==;5:JcwRGrj+KoChf/+vsySAHOIrzEGvZHo6fWaiON0jdlPCnk2BIzQVu9TxmHuixSALRVJfwfvGsCQP26BZFRP8RVo9eqp+28OCSPTi6jp37ek56cPPViUrg7EqQdGazWgAuikPoOOwNoPWyuuVkxIsF8jy/GLth5mVdUEs7br4+2s=;24:ptuSuQ6EVspuYFpaqyVuN/eWspJttvsjKLizY0Sy8B2Wb+scA4t1dIQijkyCzPyYa8RN4A5eLHKYq8k8Sfj4Q9cdoPxsnoxx/FQQlC+2I28=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:ARvx5PUDNtQGhAeysJ3rEjPI0gGj8ftXu+jLE3kDagJXKigr02eQ92iENdI26C627weZqi58vFV6uBfAY13jijC7I4umFnaCXhWFkNc1PpTUEnLtOF9Um3hjrtkMOLQMGvkkIGhWmd6YRKlx2ne8JizIIa+2mSBbNmszvJ9kI0pgR3/mRvLSz6C714Y+YuUMPmjgNmgm07qKJEo1N7miounZQbIXBSCMYd+gJjZJ+4OE1ZrTzdFQzp1q5Fpu/VMd
X-MS-Office365-Filtering-Correlation-Id: 42c55e5e-c1b9-4663-b452-08d5a6128804
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:28:05.2706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c55e5e-c1b9-4663-b452-08d5a6128804
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I naively thought that since there was support for both nxp,tda19988 (in
the tda998x driver) and the atmel-hlcdc, things would be a smooth ride.
But it wasn't, so I started looking around and realized I had to fix
things.

In v1 and v2 I fixed things by making the atmel-hlcdc driver a master
component, but now in v3 I fix things by making the tda998x driver
a bridge instead. This was after a suggestion from Boris Brezillion
(the atmel-hlcdc maintainer), so there was some risk of bias ... but
after comparing what was needed, I too find the bridge approach better.

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

Cheers,
Peter

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

Peter Rosin (7):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm: of: introduce drm_of_media_bus_fmt
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
  drm/i2c: tda998x: find the drm_device via the drm_connector
  drm/i2c: tda998x: split encoder and component functions from the work
  drm/i2c: tda998x: register as a drm bridge

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt |  26 +++
 .../bindings/display/bridge/lvds-transmitter.txt   |   8 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  71 ++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   2 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |  40 +++-
 drivers/gpu/drm/drm_of.c                           |  38 ++++
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 201 ++++++++++++++++++---
 include/drm/drm_of.h                               |   7 +
 8 files changed, 342 insertions(+), 51 deletions(-)

-- 
2.11.0
