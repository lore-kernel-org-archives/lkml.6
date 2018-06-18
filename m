Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F6EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6D4208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ATLuFpO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6D4208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936893AbeFRKPc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:15:32 -0400
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]:61833
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934281AbeFRIQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQxUpx5mplm1n+zXTVGkJ1vOEXO7HlsMbbHNinfvM8c=;
 b=ATLuFpO0mPUxsZUVWUbBJ5lLSWWU5NP38FpNQ28s8CghR0HzaR7/Hk6E6OQLRSEiykqrgGIxLqsy+2VMOBq1aKjPHJE1OxjtO1LShP0MyqH/n7D5RMZGOieALKwHKzavqCWgpNlFUAn1avsVhBOYIiydxJ9xDplhBlrh27Io3NM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (2603:10a6:803:3f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Mon, 18 Jun 2018 08:16:08 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: imx_v6_v7_defconfig: Enable imx6qdl-sabreauto sensors
Date:   Mon, 18 Jun 2018 11:15:45 +0300
Message-Id: <04bf3c71c57201fd89b121a56f1112e233d5adfd.1529309235.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
References: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM0PR05CA0068.eurprd05.prod.outlook.com
 (2603:10a6:208:be::45) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b187b974-dc77-4a93-d08b-08d5d4f3bf28
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:J2s76ezzun91/vNP7S5GYuxo1JV8HtcLoHI16Yws0s+2GAwAr1wBO8J50r9+N7st+xfq9D7zI+zHIPP7WXdQqRwCEAtDEQgV/s6+D/D3rS5drCRBJ6m7X4uxKKP3hRPl7fZ8XO66goxdt35tFyZ0jpiy4p1L9OMk+q7eqWrdiYv+ZsdcrNJMGqEXwrtdbOs2ZKoehgvneZsp7m4rDYJjIlsoSNOLmM5y90ftx687X82VpeakuwDz+Qhwapvo1Q6J;25:Os3yCPsyDflmL6ExTts0EVOTVuP/H45Ko9RYUOtEbjfJBc/Gebj/hthW6B2h0q3gkQsyD8yf2JqUXdoQgD4kcB5n9qDFi6zwy6dP+W4+KOIrN12YCotpDyNPwbWqO/quHpf30BBqhQyxbkvNZxYyhqjgHRXGu0iUkGefwPZSeb1gGElOTe5DRG2dgE+wBoRFQwJCbi+E0VX4mDVDuSkNK4sSJz3jOP+hsvbV1Sj8pB8uCAdSbTuJa1zQsQypAyZTMZ+GvfC3uL8StvYACFCthZJAUR7oNrHwPZbmYBi45IViDW7bexuArlAavkx1sS9pZXSkbFQMsBqDCcaqEL6Hgw==;31:+UaEnSItsGOuGegkkWvsF+l0TmIClLEzt9zG+p4jdKx0km5H3mpm0Yuv55RpCAlcxVKGe18vGys+cS+tBDgMSOC6JlkDl6+VinXb0+Uk6ECp1i6H7sfPg7R+AEQrM83O1Y5dRCG+eiZPHr8U7iVGXQCZ2wTRtq/zFAyKKJaoyvG2/3lEQ3gUyORqXnwDkk+aRhhSukQAF8Ez0vn57CwCfTslqsqmDcj8s1lvPLBYOqU=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:15EnE5lTaEcE+KAMBUUDQJ5Dm6IBnR4b8KR1yKFT0mURyWFlflTZ438ePkwZ5f3blqnYHDWd3woNsdjsNJ1Rr/TuRZ3o8F/G5ckt5Uge7j8AiOeEC0AHsySw5/YLukIS1h5mDOLbRt162SKcNfaMuPTRUV815UwzvCpMlr2VENpMA0ivGSux2SAugxTCEO0Yot/TKEdSsVy/ej3CWfHW//6Q0TIibZn4h4d2cbglOVyjmR1EQtF+4eqRU8RQ4IJqHT9HjGxinpEAN+Xv+YfcTO+CbRzM1HAQftz0i/WSM/dsar585uFb6cK5k87zLbNOMwMt7QtyrCC+STyhhc2hal5sVCCuOdTvCZiAorr8HmAncTCvsEE/d4Dlv8TxVUzxi6J1bUIAc5JHrWfsBVAG6zTcmySlYOblp3bD3z8DQIxi/cJm8I1y60kjM1CcNqUJmwWrnPu9VcDajltFlxof4f/Mykd3ZaUw53fXPrENKlaDMxVi+5ODZ/czojhD5sMx;4:gC+xghU7gx/YoGeUZoePQXCO6ufewKR1y2d22uTBFGBJBwMmRHbd4Yz6yhRfZtDTbPZ9MXeK4DbW/TPFBKgo7M+nuxgXOxk44hW658Bg2GzXN/yC4x0Zi3FtQHjMUjbX5MOodMKn0P06BBd8N9gazkuZIL0JkyFD7dXM5a2wL4uMF9GmeXqN/TkSKsLzrc9zvN5E5bpfvfJoneDGnfPQUwueB8LET/4ADUa+ABMXzmeq8vug+9JHQdDR2cJXQfltptkWtUDNYtnMS+sVXRfyriY+OKLlUVaGZAqgvfwQsdncxVJMJGUbUGruiFvbNU1V
X-Microsoft-Antispam-PRVS: <VI1PR04MB43014CA8A70A45F2593A85EDEE710@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(39380400002)(346002)(39860400002)(366004)(189003)(199004)(26005)(76176011)(97736004)(52116002)(5660300001)(478600001)(47776003)(7736002)(51416003)(305945005)(2906002)(6666003)(106356001)(118296001)(6506007)(110136005)(6486002)(86362001)(16586007)(575784001)(316002)(6636002)(15760500003)(6512007)(54906003)(386003)(486006)(2616005)(476003)(956004)(11346002)(446003)(6116002)(3846002)(48376002)(16526019)(186003)(44832011)(8676002)(50466002)(68736007)(36756003)(105586002)(66066001)(8936002)(81156014)(50226002)(4326008)(53936002)(81166006)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:cwgr7q+j0d8KgXQJKSV0SDsafYA8STrGY2Z8tmXLq?=
 =?us-ascii?Q?Z+zCp0NiU0ekBExvvk03AUpNWpRxv3dtUmSsXng6p4S0dPFaNUuj0/AFZbcP?=
 =?us-ascii?Q?IIAPaDtcAV5Zc3LdwiSpE1NPG6t3+hBZE0k7y875M3PgIg+5pmL0jmaXe5Jx?=
 =?us-ascii?Q?U6iLYdYCrCEwuPdcuu3T6e6Y4WlTGvyFSTwb/a0aA8bQcgGV7EpFieGjjIWM?=
 =?us-ascii?Q?FoTohJ1/LgvfzXQLFLfkOXW+av0Pywz/4aeMyQAxa1zcuxt6Tnxn2jXkjabq?=
 =?us-ascii?Q?pXvpc5dztD4KvSRW1sNcQM+BSOL0nGiuIYpowHH5ZPpXRfVGyWxt4FBIFfQe?=
 =?us-ascii?Q?PYkAqW4abjSYI49UJanEe2Rvgei0zjYMLTjgTdFwbfm1A9dgRARcp7fxjqmM?=
 =?us-ascii?Q?D6ApzrEZVU37PZvzejiZkeV+GjVUv0wXcehnND/GOZ2/GIRbIEmFmMhwoYhA?=
 =?us-ascii?Q?rmijU0RicymO+aRpSPA+Es2RfpHO5SmrUYIwwEl/Hcs9b780Mvh4kXnOXvbS?=
 =?us-ascii?Q?GX9dnMvI2PpXm0kYvEV+O6QsEc6CYwVlZ29FVjaSR01kScq4k8sLdE4lcSR8?=
 =?us-ascii?Q?OGCQniQ+0uwJY3BxMK0k9I26hA9bkMhKnRp0+8vqw+L6zBH8oK0VrvEIv34G?=
 =?us-ascii?Q?POvrQWb1lQY9j0/gF/iwsreHcVD4GGipgHSI0Nfxz5M7ZkIxFYwEwihiibj6?=
 =?us-ascii?Q?oy009B8JSYgjosZgDX0tj77M1eiCWwEID8vn+J5ybBJXv/szyetW4e0YW/NN?=
 =?us-ascii?Q?wEpQ9M3BMmWhJ6uaFPpExSyeXvfuKxBW3/2rYgaG+KcbvZDVRjWh2xr2DhlO?=
 =?us-ascii?Q?MG7o3XGIy9xSZiUzMxtZpzePEylDuLudJMI3/TjEAo5GtdIyB/Za3qoLuoRV?=
 =?us-ascii?Q?y+pGgX1iRJBKPo7x4s+PdXSm4knN70j2z6I0WlAT/RbfqEUlOo5b4fe1dKjY?=
 =?us-ascii?Q?1TEyuL80CpANqHQTz0MxOA/RCknbnbsSd46krcHwihleXcNvSNXPbsTKX4bf?=
 =?us-ascii?Q?f6zqjPs2rMSP4XPrupvNo5YM0l2CcoxrDOyS07xaJx3MpqZ5uHbmn4AEzoR+?=
 =?us-ascii?Q?oBQLnIHCkOJT0Lc3pl4xTQp18Hq1ZotEpZ26bL84s/lAzNgxUhUvmK43A4W4?=
 =?us-ascii?Q?UPm5BVFqUusd0rrDsBcc9SvYKCVqZApj/U+IvmD0NSecqqSGL/5DcF5N6anI?=
 =?us-ascii?Q?H8rgwI5lVtfViyxnGTaJCz9Lz5KMqwx5kBGqa+zwlH0kVOtoxG2pX/5qUJ3+?=
 =?us-ascii?Q?eDjcipgUtr154N+2t/lkgWUYP7qMjX+AoEbgOR17Dho5h4AWKj6UX85SlCRY?=
 =?us-ascii?Q?K+6oU7/EYbNSfawCyJhUltiBbYr9RA7cBb2pg/85NMCPZC0+cInEvaBgXQOZ?=
 =?us-ascii?Q?7gYaA=3D=3D?=
X-Microsoft-Antispam-Message-Info: W573nQ8FDchbZ40kaD2XCglFPAxXK+/2skNI/rrj95I94LMebImFAboAeQfnvbXmdCxqhQmC0X1+gsm3tT6lrZC5mX8/Mx4qEZ3ZypwjmNosHcLfXRKAJ4QfExudgqLRcc7+di/gFQUNB+WZCQ4Glso2PH9zsBNC1Srgi1hNBxcomS0ncP1U41bZ39IwOfqpU9IWNVkRYvXC9pUna6OWZ5a3Rd50gmRI7AsIl5VVsW+dsTyPRUhRGtTHV3DoO5fIBpU743fc8VGIyz1LgxyeJCoFn3acWlQCff1N9B7P3r1f5Ze7SV7z1ZhL72gBc/lkrCwMiZb+rQ/SGXbuYF9E5Q==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:dH4jBoY/MpaqcpvML3oCqnpSblVToOjV8z26LpiKc1R+sjZJmusCwJqaxUwOpyih4qQSKZxCLlFHt6oiSjiwvzS5yihDd2kPDQLbA4iQZTrjuK9bshzxwDhci5sIjAd6laxSWHOj0BPiZq7DXoYxhvjXIh0To5TTHEOTBfn9qIs9t90cCnLxc5wkp5YMULu9IGCwJ+xxN94pvNlBaraDjyApAVnoUWvnHoqMscz8NPNUiwjA54biTPPt7ED7Mw6KqJsrnDDT6Z9C2pUhYDMp78Z2SExjNa/XjZfgWi1TWeDRUZq75ShC9eabo/dAPxebvd+yoiqKl2/onmP/2JcX2DfrK3vZsY3y3Tu0fH39tCrkXquSFt89oCxMc9rZ8nCAowo0oNTSyvhbWsEaWcZPMhBDRCxQdlaqLfiJK5hxlJBzdyp/y0RQ+8xbE3OO7xML5YNmbMh11cC98lzQIe/GCg==;5:j1CEMV8hJj674APqi++Gg79cWNhE8YG+q3snY8kdoCuTO552TdXmd7rkGDZX6X12RNo+sHVU3KtmpjuI0Iwty7BURDrx0QM7r8ct7ER9VyT03RJxUBICynuu3DMz6EPa6n3UuNE9OdEOfz/GL/wr2OQX0dGlLrir0mwwPvOCQJ8=;24:TeQCmq+9ictDEcwDIXpvJ3ae6lqu5Fuz2TuVDb0o6aQQ/aonCOmXSKx1PuNe8wwSOVq7kn0nGSwHU2Tf4nLFrD5JeRSM/pXsdHO79LS7HNk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;7:2w1UbyxxgUGZJkZuDZRLu06r/Pl746xNvmEKQuhBlIStsc/h8By6jquK+rGnDRsSFBGrusznDPoEHbOqf9jC4uer2r2IG5xRDJO97/Ayq4UclOQxjWdczPjzcnkQvzAQ0CQeX5NIku6EZJhYE/OxSE3Nfd2JklX3n78GscQK9BrXsF8QWt5rFBMRujXr6pg/fL4BCyhKmfUdzpV1S//2Kg/5eKEOLSxY8CcKnZzUzMFMEy77uvXUF1TTEnVvEQPV
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 08:16:08.5473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b187b974-dc77-4a93-d08b-08d5d4f3bf28
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SENSORS_ISL29018 supports isil,il29023 light sensor
CONFIG_MMA8452 supports fsl,mma8451 accelerometer

CONFIG_MAG3110 for fsl,mag3110 is already enabled

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

Changes since v1:
 * Added "ARM:" prefix in title (Fabio)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f70507ab91ee..a647cbb0e59f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -372,12 +372,14 @@ CONFIG_MXS_DMA=y
 CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
 CONFIG_VIDEO_IMX_MEDIA=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_IIO=y
+CONFIG_MMA8452=y
 CONFIG_IMX7D_ADC=y
 CONFIG_VF610_ADC=y
+CONFIG_SENSORS_ISL29018=y
 CONFIG_MAG3110=y
 CONFIG_MPL3115=y
 CONFIG_PWM=y
 CONFIG_PWM_FSL_FTM=y
 CONFIG_PWM_IMX=y
-- 
2.17.1

