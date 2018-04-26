Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757254AbeDZWdT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:33:19 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756177AbeDZWdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:33:12 -0400
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
Subject: [PATCH 23/24] drm/bridge: require the .owner to be filled in on drm_bridge_attach
Date: Fri, 27 Apr 2018 00:31:38 +0200
Message-Id: <20180426223139.16740-24-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0366.eurprd05.prod.outlook.com
 (2603:10a6:7:94::25) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:qAlx9HUmSM0gr1FjQra3OeVK6PhEJHT60uFFSg0ZHgzCFiezZnygBLe7KAYAz/erUDe1f4MAwSRedEfzca9zWqFOylJeMqzq6301EzHMXHHJl9wkPL7F/Cw75UPWXFtex4wHSCVs4/J3IyC6dw1t90MhpMS543NhK9W7Yu8qLfNfJhf6WO48YCmnt98GKJmFGEWAR/ge6BQcGPcTzi5SYeZonPBgLqCFcjUS+qc7zAtp9pGD1hPrWhYNkxqRFVGm;25:RYUeCTGqWvRhbf7Ho096SjE+G0EgtnK9AZG5XDZRq6P3T1YfVCGYD+Bb0ZHtdl/XlGZ38oglw68b1+/aup+1TMdYGxfAn+rUgYQmk0AR7lLaKDWCzE6Vk4V8yfri8gWNya+5S1iSWfz6gZIvxHZUB+CKklWE+SWgc0BaJPFVda3zRBEJJGKNqLYLLLEdqtyiWHy19rXZeR+4D4BSsQ7MPQhfkDE9vgwwfAGzzpeoNU/OaMLR9XgFUNAAqpIgHIsWeRks8pkeTGuUzb0XFxK5jJTtz7OTxQxx/4jL8g+iv5yv8E018iPh6wsHG8Sa4E/ywjRaenSTgd4XJ7OMYdYZHA==;31:djmCt1KnRDUeghKViY5LY60odcthhNIuAO2LLd7J7zvo11DEDySm4xcSM9Bl9hh4YWk3v/WiCRFYF7A4o74q8jZIuES7J1/DIC2nV/SGZbK+eaDBHnQzI6qxSyq6DfE1Lgwlqcn6UhbpDk5xGU9UfAb0fEflTJq0/R8pygAOD6TzRsvQeDo8LOMEpSuZ7gtrLTEt9kxLU1rPz00Jm6G+8p7AFxdomLLKf81oAkWWNeE=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27822D07F0AEDC92C625B06ABC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:p/0iV5vFsWd73JMVch2NUlWogNSlGHto+iGTwInbhRjmzF52vzshFczWRaZDnrWWpPmjN37KltfxOPVzrxJmkBtrfCBpDYpI11LwIHuSPlvcLnN9ztwY4sSVhFVNCHCY7rnmzftk2PuxM1nfAFGG1TN5WeYkD3+4IRJrXtRYAuabaDhkShc4jRl3DEJVEagEeaIC1CcjXPHJ4wgg79koE4iB+PWjzN1Ca5Iz2nodmAwi6nzfJI5n/kljqIOdtB6l76oi2hTpY8MgqTyR3QyVjg==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(2361001)(66066001)(16586007)(6666003)(105586002)(3846002)(7736002)(6916009)(6116002)(36756003)(74482002)(6486002)(48376002)(2351001)(25786009)(8936002)(50226002)(47776003)(81156014)(2906002)(16526019)(1076002)(81166006)(53936002)(11346002)(51416003)(54906003)(68736007)(97736004)(478600001)(446003)(186003)(5890100001)(50466002)(4326008)(476003)(2616005)(86362001)(39060400002)(956004)(8676002)(76176011)(26005)(7406005)(6512007)(486006)(6506007)(7416002)(52116002)(386003)(305945005)(5660300001)(316002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:tPuCrA4+0ekIAXVkF49rIIFNu5HBWD7E/HzJGG+?=
 =?us-ascii?Q?sEHL/jLmxioIPy23TVH3kYepqHtUSy8ShsNJGBWMmYTflzBJH+4LYS6KUES2?=
 =?us-ascii?Q?zGuctpfRNjvcOBAGI1kVyUTEa//INlSCLuS5UxtgG+hv6Khz2g8LW1iQpYV+?=
 =?us-ascii?Q?CoyR02oPydt0R4DCKj/cq+tXP12/Ld167w88HpHEr7CWIZ2gIDgrxwflIOJG?=
 =?us-ascii?Q?S4JchiR/b8WHNUa0sIwtb19PC8J3nNsOCJBobCnSZ05gJdvtI0ZzRec4eyj2?=
 =?us-ascii?Q?nvi9LYDkJyKpm+PZJL/3UtgYMePran82jwTX3kEMndcTdfHWYcqVTaScNVbi?=
 =?us-ascii?Q?cwOTXKNVoV45JgNiTgOCo16GbWmMmnGRUltrThWGBqwXDohGk/c7cCCWQFan?=
 =?us-ascii?Q?5C9WS1ERG3Mt1MGhEV3xNFx/u44cGw0pe4NY4J9DFQdHByyosIIXX4wSDUR+?=
 =?us-ascii?Q?H7F722VMOPeUryVREVAuRJYrFt72AKp5cOn1JUMshryJidWSYUjid7sgKRD/?=
 =?us-ascii?Q?E5tJzhAn1grJp67gGatjg6rR9arJ20su+nx6pOlF/QH0XP/oW79S6267xTLw?=
 =?us-ascii?Q?ZKyy/bJ7IzM+Tviuc3R6H76Kn8LxTkr9qav3bRnnSbCbunK92q1jLShjwW0q?=
 =?us-ascii?Q?++5CJ0KjXusx9a/sQ6r22wxO+hLrLnv26VqbE2uZiDDHV07aZACJxYrsG8H8?=
 =?us-ascii?Q?3Ugpij8v4zXSiBORSENGT6zWnA8DQvUZMavfUESkm1S7b3Jpxgwf0LmVtJbM?=
 =?us-ascii?Q?MoDE2Kp53vJkhIvdkzZ8LQRnp0ChAEMEH9vuiijLB9EuWBHIjiEtZosxCCBq?=
 =?us-ascii?Q?fucsAAb3VO61v1gp84TwXlsQT66OwgRptZk5d+cODPgRHDnNtsiSj53qIiQ2?=
 =?us-ascii?Q?NFURq720YwOVnA5QXN0m98kIdF+I4Mavx5pTjx/bfZOy7a+OzDotfTWuWoYF?=
 =?us-ascii?Q?kRUI3k9ooXlMmGy6pDXz2JxXd4NvP983oSB6wp3EV15kMHmwIBQ92dJr2She?=
 =?us-ascii?Q?1p6jw7mRhKj2wT6bHGzUalnD0aeUyacTZ6F11uUnSMwu6MVp+JBm9n5BhBG+?=
 =?us-ascii?Q?CovkHIVaxGOjk9OOpG9w/E/xin1lvhgpjedal9Kj96DNMKr4SUd0qNFSIQzS?=
 =?us-ascii?Q?TQbmyFHYIgrLo+wwQ/66c2FxSDwf8B9FIWmqukbq2yBCCwWliT65NpFp1DJo?=
 =?us-ascii?Q?Kca0Z2/6ujYqBARqyhbWYb0ma5PSskQGMp6Pw8qvXcoxxreZMXFcU6YdNzS7?=
 =?us-ascii?Q?anNFiTMvuRxR90loWyExh1covFbsmPzXMIfzrZF7McL50i0z+8HdNAwxAwa5?=
 =?us-ascii?Q?j2apJxqk6w39SYegTG0E3HxebAKD4wWo+Y75gDoRLPMbZIZEhH7ItM228sAb?=
 =?us-ascii?Q?gRlnmKL3DkfwqSQ/mx3BAqEFPV4LJW7tvGePseUT3wKYwWujMDiGYoj1CeW5?=
 =?us-ascii?Q?ks4yDzPQVbA=3D=3D?=
X-Microsoft-Antispam-Message-Info: EqpygF8r8kK2e/ddm9yow4WemtmzmKebvHev4ySvnhjYRb3FPnQlcdKoAzdpocwWidgRxvxLcTOJaEcu8vOMgWYv7lSiYHLey47iSKpsuQ3hSJxIBeJqvoXNRy1coPVbbMO5m/pldbeXLcV1F6cG9Y584wFMjR/NctLAsmIGRDItkrlRd2+k92fvfr1z3fEy
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:mct6syj/Zt7VGrlx8fWPUxjukr5OEc68J3fRTblNEoTCp/COc2Y2Ub5knll5yC5UcR4lMQUo2fkN74hBltq/v+2CxIbtSvnFZX6rWggtQDmm7XC1U64FeneGobdJKrkYezTli/obof2ytmYBhZ45bNxcoL9jr2XI+sKmZ2Ne46dmim17lhIFKItYJS4ILhhjqrdcCKqPG5CrgFVloy/+0ITdbMVeW8x12M7SIUR8uas6vVr5t+ws/fRcwPuWYe3eXQ5WsxdjdotyrxPRmSEI0d5tSRt6RyFvjtGcQXBio+96Be6oWU5rn37O5eD+izVeWi3R3H53dXxCfcAZaPQw7OhDT+/+Ey7z0q2QMK5XtlqyP7VA00nrqdmHSJzPGw5KuJ/kMtw0+eUG0zh7aECsBJDbbahYIESHb/LI4gmMW4CuqNVH1qfe78cmmwWtwOwcwxQmczlN4nOdvftI8inqmw==;5:78fhxW3Li0K9Wu0+R4o5RqD/ABJriVPfPeOexGUBOzXqNlwiBu6XnBcUupIGDSIyfJeUjphz5IBy8Izhe0NMxo3Z1iASUQ0DSr077wgZFlQ5ZWk2x2Qa235nxlcTzEtpfAxFsppOHGBKcKRfiySs51kksq2EpCDVWc/hz/u1Lbg=;24:F7aPsKa2BdVuYmZVOEWbKcxdeQt+wEuq084fAKkV8wADOGtLqF8ws0TAQqB7wb6YVxvDxL3pRl3cPk6pbP302TZ7gTZWFc3RQKjC9bih6+c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:e3ihm4iYSAvi+PzRsdc5Hw0Cfb4DSpewdjJEydHJYqUS2bcptmR2huPQi1OUGS3z7ZQM5UlC761Qrx+4YxcAa+2zg1LLaLb4UUTD2sUa9dlu/vUD3oPE7BRHSNlrxXQqInUYxye8QiyfKIlB4O93elQ5IzYyPYXOaDD36BMmra3R8lLft1ooTEN+hAbgQlKl8eLeF50q7oyaaE0+JoTRxXXr6KVx9iHqjUF5SXV5q8UBpppWFok2HfdjtgnLgOHL
X-MS-Office365-Filtering-Correlation-Id: 18032e98-0daa-48b6-f6dc-08d5abc5ae6e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:33:02.4957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18032e98-0daa-48b6-f6dc-08d5abc5ae6e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .owner will be handy to have around.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 9f023bd84d56..a038da696802 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -115,6 +115,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (!encoder || !bridge)
 		return -EINVAL;
 
+	if (WARN_ON(!bridge->owner))
+		return -EINVAL;
+
 	if (previous && (!previous->dev || previous->encoder != encoder))
 		return -EINVAL;
 
-- 
2.11.0
