Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754888AbeDZWcQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:32:16 -0400
Received: from mail-he1eur01on0092.outbound.protection.outlook.com ([104.47.0.92]:31648
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752991AbeDZWcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 00/24] device link, bridge supplier <-> drm device
Date: Fri, 27 Apr 2018 00:31:15 +0200
Message-Id: <20180426223139.16740-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0366.eurprd05.prod.outlook.com
 (2603:10a6:7:94::25) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:BVYeSQZdtOyX2vlQypok9kBcl+mhuIze+Y+t7JcW1My7yti2YKyRaP+fA3ZtY9vquGp7Ab4Mh1hrz48Cf59NZ/7gN86U6tXYGH4v5sI82NGIYthToaN6b6WKgU9w+sLeBGA2FkmRJNTe+XWF2ZOmt1mt0M2ONlA+V7OeEUnI+0K0OjzixVEg6zgiK+tcJDMhdAYsCfIdn+Gb636/kgRABQFZLUNATEkcuVPkfVrBpaTQ4Jiz8gC/q12xKLkAjtz+;25:g90kX3pPM660Wpy92Cxpjp1ASJDutYzK+FfjLd8FuVZp5GjUXvdbNGVVa4i9/6qy05rcMT9q1jqpl9ot99qyS5N2IxIUAYU9DCvDQxzkQ4rrfzmLAXRICQk41Nx1pvi4kJyI5Yv0MVbc40UQmV4DVeZyuVeUKxTp9TYVah+59P4IbvOdMmrjqNNuwHQBLNXPHywpKm/aB9k2eyfL8Z61r5CFOZM4M8H2fdiVgrlddc0E6dn7kqSlpy2NZA3L+s7tSrm5nyRAPUk3xJcP7/l3591Oymkw8UgNEPrrHbLgVwZvY6JxWdg6cd2fE+to4ruWCTCks3WMiSQ/M45mZZivVQ==;31:Jf/NEAiJmszTC0vj28rE/q/s6AXnJmIwkpi8TJygbW97xQU+5K6Y7QicA7bko4Nf3iC4zb4wv3+yl/FpOcnzMQ10DslsMdxy7DTqeOLyL6n1+OGGZBsviTx1fzNDiMYYme3ucl7u8YKR/IDBSOtbsWRmhy9eX9BNCWb1+AwtNHOy+imiYA8eAVjtp5anYARyAoU+WcuirH3oONPk+wltgij7N74RQ1UVURRQ+nqgHjs=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27826058D9BE0D27CB96423CBC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:dtHeGGJLYy0Zr/YFdw4+49PdL1wuYVLy5h50AJC7ao2/ZvUm+Ccld5c4xrV7pSAk+CTc1fkJGe4hjRNYznV9tAz5rK6zSg6iniZlzEkq5vnFRB2lfx4ViKrt7lBcJjCKaypzatLKsg+oe9EnNdx+Oj1VUYtO0q/01eSRklKXHimhM+DRa4Q4ijw1+IAZnEBYCFgp7cUrevY7MVJ/n+ezGfS3Z4TCAVhmd3fMw0hrB2cOQVM2hUo4O6i+7TgPH3mbCS7+Q+62GVcZlP8xrTBp+w==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39830400003)(199004)(189003)(50466002)(186003)(5890100001)(39060400002)(86362001)(956004)(8676002)(4326008)(476003)(2616005)(54906003)(51416003)(53936002)(478600001)(6306002)(68736007)(97736004)(305945005)(966005)(5660300001)(316002)(386003)(52116002)(6512007)(7406005)(26005)(7416002)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(6666003)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:893hoyeQrHFbwAcqBS/ZUQYKDSPaBCUMPjunbnI?=
 =?us-ascii?Q?mLzY/mWfp6JV4qXI1By5uR6mJSmrXPPusaA337TlEVLrY/lvu2ksh/akWmWh?=
 =?us-ascii?Q?VdUSA+1DsGMT9XJkpu0mgRSy7haC/I9cX8A7rjCko/PQINrIp+yXzHVGEovw?=
 =?us-ascii?Q?S7UsPCEAWDRsD083cEKIbU+ZsP5/NwdV9cX8my962oCLTpPnk4VZWSBluqWH?=
 =?us-ascii?Q?FjzYdL4LADf1+untW/7AZ9Ju7kYQj1tgm3ug4qozHxxd8ntapYyxII4nYVKf?=
 =?us-ascii?Q?YimqVjOjr2/sCvboQ8vY6vFyFTb/Kgs2jmxCj2qlK1UDH/0iE1amaP9f+uRd?=
 =?us-ascii?Q?6NKd/yrlntqZY+fhQadHVj/8vyteL8S6UFWp+FMUhOvwb2Y53CYfgWdWB/1d?=
 =?us-ascii?Q?cTfBhyr/+4py12EH8b09Dkx9fR4g+Es9SPj3Rf62BrdQ/vVDkkWjSW6eOLVM?=
 =?us-ascii?Q?oAVVetFJs9h7pW3LyysZOgtVwNXGEukvcCsNSpxlXSnA7u/SEZGDoTKflKHa?=
 =?us-ascii?Q?KLkwogw/yJ7e89HEKVcs2Nm4O/4TnKcGqsGbiGlo/u4Mtk8nSkDIE9JGh/r7?=
 =?us-ascii?Q?1NQKVcmOz9VlHhRch/UJ92nhxvCcMb6bgsI6ukFUcShhJMbSo4L2NbLahpYO?=
 =?us-ascii?Q?Jo9oixR75rwUMiKJX5Iy6f/T9f1dlvtddpc0+5K2J75qXirBd8HB3NAMrdSn?=
 =?us-ascii?Q?DlZaGpyyN1orjGAy81vPcbWsvluNAOBk+9PB+ENUlxyd+ETAPvDMnmeJ7raJ?=
 =?us-ascii?Q?PAhvDeINgjGPnYiFWlknU3C+yvxk+iboLqROpNwcMrpRiTKYltJnHi67v3Sm?=
 =?us-ascii?Q?IZB2JRRxnp59CzazlDgLc5hSdpq/eDF/FiRLroefAJLRfW2QyuvA72iKhQnK?=
 =?us-ascii?Q?HIZvJcu5KAyBkEKBII9NyPXldiRcLEdGk8cJ2eXz0hciXtu0qSezX6jW6+KU?=
 =?us-ascii?Q?uuYloCfsj0QqCLm1HWTc/6dXBnXPLAzzjIw17An+VbDXkhD6I3zRJpeNe+uK?=
 =?us-ascii?Q?JZSkh7/9tVUg/GOj5s1ETckepGkoJw15GPNsWS7/gdAXqOORcCEC7eGpyb/M?=
 =?us-ascii?Q?2D0rnar1eaN4cfbLiDwey0WdofiEUeU9ZnVMNTU9nonq6N25uR+yP2CjDBmw?=
 =?us-ascii?Q?tq0NW9ZqxRUcCb32OsgtDXUwHMnXQGKbik4PhibxnwuwJHZfA5SRWv1qPMZ2?=
 =?us-ascii?Q?SYPna0T5+2NdKce1NuYAkGAJbNsRVRzpAH14GkmY1TugIzE71ZW0udLHYAfl?=
 =?us-ascii?Q?DoQxr3aA1POlIf/7yNBe9AsPYl6sj+KZ52hvTn1nQJ6gm7IfuM/SIufo7qJv?=
 =?us-ascii?Q?854XjN9Nxllct665n2z6gPxWKI7JK9OO0+gaZlXC1OsXXncveJPyqcgSDqZM?=
 =?us-ascii?Q?OI/60CMnTFbM9AEfL5e1JV5MKyAo=3D?=
X-Microsoft-Antispam-Message-Info: bQXzPtphmpHPCqGrKDi5/IWu1M90cNGhvTDsw5BWvr1nnaHArZYxB0O5n9h0/lbQAzXGehQwnQH50CHX7DH9BNSyOvPWMOvkzI+8FxILEYCt/+bEdlEpMQCHEkhWjRoZoGBBpfm+P40ae507NQmTf1kZfIe6Z3+IVpBf5Mn+txt1yJ5oS4gexBRt3p5YzYQm
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:U1ombdqfnByx/Qu0vh9ZC4jLlyVu6xyfOIFV3c70o5DgPiiYfGbg1WdjoAJQ1RbXDqk83PuTpsSVShCTQu4rf0LUIqEYyLkggRSnIoYpTvXOMU+qWyI+rvDvV0d0X2ShfsK58nPb13XRMat7IK3+8Q9S7/YIhg/1JVpR41X+HK2KoYoqhpV4TZSBvQ8yArsMwY3y8D6pDDAE7sbVXwY81wTG0hYq2seAP520mZJp3fCMbz9GqaqaJYdDJqw0K2mIRJlTiOsn0azvYtQFnFIIfJE3XGfHnDnxmIwMtBl36fx85tKr23v57f1jsHPgiGuLnUZuW67dKk1btVpNz8JcEyYNggLqnMIxTxObXJ7UjmTHG35K7Lp2f3MPZ4/ebsak2bCGRILDUweS98sLx9j2+viFaxjGnGE18NDDW1Pqq+cbsSG9DHTo+V36hUqr+PbbGJH/rChS8Ud1U035H3iL+g==;5:QwPFYAknWMIuy4hejq0Ich1yi60St+WLxgFzdgVcw4wVxTAazPrxtdfJsX5+aoJK+REo0EbLGg/paNzi18r8BC4yQhgOdOZxwoV/HW/j74jFj1Jubub0kegkrkHr9UWJUc8Y92AsASR87C/NEbd9O4DgALWWAcKWgZRz3ndhuZw=;24:mZmyaeYprjHTTsBMOYcWg5sllV0ojuOPtVksIgaIjsyADv394RMY5CMLMYQg4cR/JyqowQVWumnTvYY2Gf/fnO7c+zL3bqrbj8juBeOHukc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:aOpzy0YUA9ASmuxW6Kw+kXD04wEPwrOSOE5efZ0WWe2FgN6qwSBbUkmX4JPDFchcJRgssoTxA0TyMsHvP+wVHx9+29aqcVNEmOlfqhazgeCdOo+eg5Kk4OY80cPpZZIRwyWaSytdTAClSVds2/UakK3WBkKbx2cXQOUVP0nwB+IsUqPRrznIHURw5IhF0Hky8irVsm7/yxJTsX0WUg0Bzg8EuQlO1fx03+cyt7AurNv2HJNRZ/05DMWK9fu2JE+D
X-MS-Office365-Filtering-Correlation-Id: 604c77af-f024-4c22-e676-08d5abc58a8e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:04.0726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 604c77af-f024-4c22-e676-08d5abc58a8e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It was noted by Russel King [1] that bridges (not using components)
might disappear unexpectedly if the owner of the bridge was unbound.
Jyri Sarha had previously noted the same thing with panels [2]. Jyri
came up with using device links to resolve the panel issue, which
was also my (independent) reaction to the note from Russel.

This series builds up to the addition of that link in the last
patch, but in my opinion the other 23 patches do have merit on their
own.

The last patch needs testing, while the others look trivial. That
said, I might have missed some subtlety.

Cheers,
Peter

[1] https://lkml.org/lkml/2018/4/23/769
[2] https://www.spinics.net/lists/dri-devel/msg174275.html

Peter Rosin (24):
  drm/bridge: allow optionally specifying an .owner device
  drm/bridge: adv7511: provide an .owner device
  drm/bridge/analogix: core: specify the .owner of the bridge
  drm/bridge: analogix-anx78xx: provide an .owner device
  drm/bridge: vga-dac: provide an .owner device
  drm/bridge: lvds-encoder: provide an .owner device
  drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: provide an .owner device
  drm/bridge: nxp-ptn3460: provide an .owner device
  drm/bridge: panel: provide an .owner device
  drm/bridge: ps8622: provide an .owner device
  drm/bridge: sii902x: provide an .owner device
  drm/bridge: sii9234: provide an .owner device
  drm/bridge: sii8620: provide an .owner device
  drm/bridge: synopsys: provide an .owner device for the bridges
  drm/bridge: tc358767: provide an .owner device
  drm/bridge: ti-tfp410: provide an .owner device
  drm/exynos: mic: provide an .owner device for the bridge
  drm/mediatek: hdmi: provide an .owner device for the bridge
  drm/msm: specify the .owner of the bridges
  drm/rcar-du: lvds: provide an .owner device for the bridge
  drm/sti: provide an .owner device for the bridges
  drm/bridge: remove the .of_node member
  drm/bridge: require the .owner to be filled in on drm_bridge_attach
  drm/bridge: establish a link between the bridge supplier and consumer

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  2 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.c          |  5 +----
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  1 +
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |  2 +-
 drivers/gpu/drm/bridge/lvds-encoder.c              |  2 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |  2 +-
 drivers/gpu/drm/bridge/panel.c                     |  4 +---
 drivers/gpu/drm/bridge/parade-ps8622.c             |  2 +-
 drivers/gpu/drm/bridge/sii902x.c                   |  2 +-
 drivers/gpu/drm/bridge/sii9234.c                   |  2 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  4 +---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  4 +---
 drivers/gpu/drm/bridge/tc358767.c                  |  2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |  2 +-
 drivers/gpu/drm/drm_bridge.c                       | 23 +++++++++++++++++++++-
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |  2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  2 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |  1 +
 drivers/gpu/drm/msm/edp/edp_bridge.c               |  1 +
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |  1 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |  2 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |  2 +-
 drivers/gpu/drm/sti/sti_hda.c                      |  1 +
 drivers/gpu/drm/sti/sti_hdmi.c                     |  1 +
 include/drm/drm_bridge.h                           |  8 ++++----
 27 files changed, 51 insertions(+), 33 deletions(-)

-- 
2.11.0
