Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeEPKSC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:18:02 -0400
Received: from mail-he1eur01on0131.outbound.protection.outlook.com ([104.47.0.131]:54176
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752611AbeEPKQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
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
        Rob Clark <robdclark@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 25/26] drm/bridge: require the owner .odev to be filled in on drm_bridge_add/attach
Date: Wed, 16 May 2018 12:15:09 +0200
Message-Id: <20180516101510.13215-26-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:a+nKViyBCNdbfLARgrkxPoaIUsBDKj9V5CIPBPCiueDjHFcDfZNo2vs7fMHcEiQ5CyC9IOKZPoOVsbdCR2Uh8jl7p7e7JocP4q5X2sX/pC55J7ladRk5SWjmZaTmSobbDE0+5vzPXBrwxvp8EWJTn6S8+H2i8SWU98JMHDWDVnQmdA4eHAPPArEElDFv/S58jYzX28n2BFFxChFOAbpZ1R11AID1BLLHL2Re7BqU0HuwIkQbrPT3oOfSKWAAC2KS;25:gbLMoN+oy2DGQNFnWaJySE/kjiHe136geaHZiz+8gNDHwLoKu2BY9lPf5C8bay9tZYTehpXd6fJIbzTbBCB1PADJRtrVUwIxhLJIjl+ZLLE78Zk/AzUR4mEsk9x1x6yA110XIdzPRYGjBtVCQ67ZaxCDhP+pX8NjEA/u0IzAZnSyqyC5ZPDJAjoOhsgOIYscOzinSP+R9Kv+VaZeuV76ZQO37of56fhTAHh4XikfZueej2/yPZ2Cixzmii34WGlcIXImcXTYuqIaKJRIvORLLPDfJIm48ug/8P68CmchM1rdv9pSJ8wEnVha11Wt89SW9QUT5/KhaYBvUWo77MiKUg==;31:Cj2BrLGwNuLxFucDvzga/K3sp3OZScfIuBkp/QoCJBIcN5KRmGnPI5lxm0Sbs/uf4JDRARQny4xcZFIgokqTecBqNewD6FaMdmXjYrGjk4O8IgD3pqHNpqISBnLxRrlgE6hojxexR7i4FcAuHW27cWEzcsc0GfRFYbQgfih3bn2QHvhNkSSbBDybsehhwtS1Qa0BjiMsgeDgqEwY6/zaxJL8RbIJzfyKYhHgFZyxYzI=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27729A6CBAFE75DBBD8DE77CBC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(7411616537696);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:bg4rxIQ4bRdctY1Q6Xj9cRVHMx5svWh9hQ2+nwR6NoRgSBy4hsU50Rl6tTpbk8liUvlhYdgKwoEUwmCG5uPrNP0BvYQhMdxEQuCNzQ7FiVrZLvtcd8AEPl6eHJxM9gUZwzSpgvmN+TMFH8jNnBznHMkK82Ul0p7LpnO72tjXH4eVM7oqyl77DF1SKyBC7r4itgvnkJB1MfkWrTItxzR4LDRPk1/JYGDFrPbMwGs2kJtuWke3pvOJI33vyR+Eb2gASlxIIFNN+cDYIXc0bSELKW4T+bF1QzDQF6EFK0XDTjfwa+gz3Fo19Ke762q4iyNz
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(7416002)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(7406005)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(39060400002)(5890100001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:O368dKT+P7NmH1ilp0Bj3zi/evIBkNtmTR/ogjA?=
 =?us-ascii?Q?N2lCXVA7gKWFNC+XSRyfsMYWfB9nhaPGMADqBO8jIT+f/7+0v7ILsznTwzhs?=
 =?us-ascii?Q?CH4MZ0Z8vBod4PI4yJTgTtdBZ1xSYWkEFI3jv9343fFDh7ClzNaSTMcJ4M07?=
 =?us-ascii?Q?L0w8w3VRVORh8sAUgAHpkG9UvZd450COeO/yLESSaE55eyDC8QaxZOTgt9YF?=
 =?us-ascii?Q?dzyw+nD6xFNL/vStfzcCFBhWWWzqwGg/R39SamnaGkGFJpy5xuJvOFilfa7d?=
 =?us-ascii?Q?NxXrkdTg1AYjnbLC1+k8hTxMtA24/H5Poed0GHE7gKW5IWD+8zvZgAx2cK7T?=
 =?us-ascii?Q?aHlskK4eez3cneVSjeknyR4+tJeqa/8muEHZwLWDDdq4ODJkBNruVqWms+vG?=
 =?us-ascii?Q?HWFy5XzwPjtBz/6KyWqYGWlT12JnVwus+idnPdujurvj6KlfTUbYx2yna/Tz?=
 =?us-ascii?Q?FBUPhn3iel6ZLyQQJMbMqefaf5xjAuHYmRsV0oF4zSw/L2nSC9J6sjzoCaZH?=
 =?us-ascii?Q?9POzDOP3kegdJZiqgdL8lvrLNPPwsaAdQ3R7hudV9ZUbFu7Uo9wS0iBmXB+u?=
 =?us-ascii?Q?QVrOqIdFtddjJaXOwf5TybY2dIqJ4oAYQ3JzyrpIt53+hTR1NWb31MOZ/Dmd?=
 =?us-ascii?Q?9jYw53ja01+1F62+x3FbIAatR0YmWFXAWkRZVJBpcpwU1mS2zCVSBsm3fsG6?=
 =?us-ascii?Q?xsVaA/lfDb3Zj/vLPG+IO8gtsA7UEuvT1Xpm3uvtpuAXbhS/YypFwqh2NT+t?=
 =?us-ascii?Q?RoZnAHNJrHr8gtL5irlFA3UwolQ8LvNFUVYlMqA7KT3LXdjnrBMa4BArwYDv?=
 =?us-ascii?Q?3Rnp37pk/xuKiIUFpSRJKPhdB/lLwXHN7DEGaab093x2gv6/nTyFaRp+xx8N?=
 =?us-ascii?Q?GqqDkEwYykNXXtaXEZkfTlokcWjHDd9CR+bH3oDLp3eVEihLIhUH5wS615wX?=
 =?us-ascii?Q?GwjdaCS0PUkFhgH2vXQDxmbwXe8Y0klAmoMgRlYhpvxuM7m0yKU+29Q3zSUH?=
 =?us-ascii?Q?AIzJ23kXE/BP86l9kliyuePu8bNtpPLHsr67n4D37riPmI15JNmx2rCRcDnr?=
 =?us-ascii?Q?OlrsvY/GSNFpFAsC50KDBB28ycRPg2+TGX47lRQCFVeS32fzsgd1rKgzQUre?=
 =?us-ascii?Q?ttYTCQONnOzzhs51t+ua7D0mbyjh5+HFW4EZyFTdCfPmDdqX/rUASCqrh/hB?=
 =?us-ascii?Q?NMu5RU2bB/ai8y5qJ6Z1a0NwZtrvZJSP6fZEOg3YIzx2xmBf8KI+3KLWyE5i?=
 =?us-ascii?Q?dLVUEXvgOex6mbGLnTesLYYtduf52zkQab5/xojNXUTpcqniMMltiCnezTqH?=
 =?us-ascii?Q?hiHBAx4teA/MHxdHP8x4ykte7d2uct32dQj/uQuLxj27cpFSS5Mw9tcmwfEa?=
 =?us-ascii?Q?XlMgmh7EvmcNJ5H5MAE+lI8rn81igQAiQ5KfIRHgajlyPibjJqI2ul3oIDoM?=
 =?us-ascii?Q?UgSsdFLZcNxB4xt1rPvq6wkHxn/Ep6EQ=3D?=
X-Microsoft-Antispam-Message-Info: 7/I9hlfkybuwTcT/id9+Tuqp7KX0e2xg8BIgyGzrm4gEtE4fiiUi0zZOXUhSUUBF0V2l5tezrI+KhgZ/3Yoq5bfEt0aTCu/vJl4ZFDZX8eOYggv+bTCSP8xnfCFneaC0BfI3zSmPO9gdyKnG2/B5Uk1jvW9B8k/oh8Cyk3WP27iqAFAF9GYtMY+22ObKOlBA
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:M0GxP3b4ECAiZsAFigfixotvn25TAOqBEB+hkGjaq3rLI8306xMZAw7mYpznSQLBrFbwlTr05iS7EWZAALpuSldc+i7PmPsWbnI9pgmfNl3/K8JDH+1VnjAnebFAFsW71Z0P8uXdttUiZ8RuDo4Yfe5G6r3uvM8GjQTQh3cpURv5QhrDluBVwSBvRa/n3Fvmj5K2Hefyqc5RnBjQoAmC271UXm27MD48GWsqvSSfKa52tGy9sjSbXzwTt8fyKsLrfHfSVnuUWSyuG3pSZODtb7SQk8XSfcL4NJd4MSXQ4uV2LsMdOXkD4Q3mXzlIOBTTAPVGqQbK5AG8e8tcbi9e/Dl2FkihIzHkpjPktSGxqg6T7PhbCjMCrbO598O9o3G+fFc+VYUYcIJI6RA2osap5ohdx7HnPoU6BeGesDNFEvBxjTCW1FX26QUx8quNaF2x0uq0EhP5cxYW5dLke3bA4w==;5:c/6n1KtqDxiKUQnatlWS2J8vCs6SgxBla1VZINs1c9Y3AHQoBJUb1aPJ+3feEPCKN0bhhjRYNScbMUGHFh2xAQAfibbZRXV7w0Tsa6llAqMJ4pIk6PehKmEKstpGWEoxL8oliWYy1Z7GuAsX7B7ta9jON4U6lj2HM8n25M6WxJg=;24:dXUuEhKrkV/iutrjdGP1apwx7NOZhRRS9O0fULRiuCB85cs3/4Kbh3PkX6iP83F2d8vB4NnGNKjnC4MeAMpE8fTg+ds670uBL12eh8EiKK8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:Iw9MBrCOKbAvXIhZRQq6ADhQHZnAOiChResiEf6cl+ooIL9ne1UdEhmBeovM1ZMQu3+X3eqoNxzNO0wArUEG5RFnvBME+vZlTJB8cOF/aQ+gP0yXn08FP21xEDjWJyCUiTeoHGNZvo3RVAQXNXaSW9NY6bWo7GWjORN5HDESIjf9FhIEbp2fMdfxfWU/NgTVKv1AydvZ5Hj4pLoS7hO4Yl0VpYg2IwK4fiDeiqwwaSly5xFJIQqPHUCZn/wCkGH/
X-MS-Office365-Filtering-Correlation-Id: 73e4dc1d-1dde-4ed4-4156-08d5bb16235a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:47.8898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e4dc1d-1dde-4ed4-4156-08d5bb16235a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .odev owner device will be handy to have around.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index df084db33494..78d186b6831b 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -70,6 +70,9 @@ static LIST_HEAD(bridge_list);
  */
 void drm_bridge_add(struct drm_bridge *bridge)
 {
+	if (WARN_ON(!bridge->odev))
+		return;
+
 	mutex_lock(&bridge_lock);
 	list_add_tail(&bridge->list, &bridge_list);
 	mutex_unlock(&bridge_lock);
@@ -115,6 +118,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (!encoder || !bridge)
 		return -EINVAL;
 
+	if (WARN_ON(!bridge->odev))
+		return -EINVAL;
+
 	if (previous && (!previous->dev || previous->encoder != encoder))
 		return -EINVAL;
 
-- 
2.11.0
