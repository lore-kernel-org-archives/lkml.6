Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeEBHlA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:41:00 -0400
Received: from mail-ve1eur01on0122.outbound.protection.outlook.com ([104.47.1.122]:13088
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751257AbeEBHkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:40:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 1/3] drm/sti: do not remove the drm_bridge that was never added
Date: Wed,  2 May 2018 09:40:23 +0200
Message-Id: <20180502074025.12421-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180502074025.12421-1-peda@axentia.se>
References: <20180502074025.12421-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:7:66::22) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:9YS59FX68wHLhnJ2aFzE9PA/tHqFEmtLPRjzKbD4cqs0TWo0+9W2UF8qfYHBDHKE3kBt+rhDXBbO9Fn70hTTGaUj0RjkQuecQOd3fD02I1TkfrUmClQiScbl2w6f6qTNq8mP8RjL5FddFKQD9vhZPi012hX3/YqhhS8ZVoxjhHjo55v01YW9XfxyuAYvtU/LjNx3c0qD4nukhn0XH9s2iAIiWJaUeOFMQOdzNRmQ4nYmky+jlLmeIYSn0RzssC7V;25:UQQd18S6EhqbPQwr66uuBPjm5lVNxUwVcaKJbqFOIJsF2krfTKouISkfH5ezOfWDLtwabVuoCLB1OaBZqt1fRo8GEtC2USwMhecQcVhnUwWk1VneehtRmLkNyiZ0yYCQ+D65F5CUduwiXZSzoB3Ajs80KL3YDGFnmxZci/HHlX//XWIA9PpH4DjO50PiSVKjgd5lckA932e2bCnWvZsKl6RiXAY9jvpzmuCHVaG6fajuuI1lIdMEE1iF/hYkknqBsoO9+MZL8bkaMCwGjQlMWjtNaUqktlsVOQOQ2CnN0PW1vntuufo8wcmGU/yKWxdOOm6m+Y+pXpGsfE4S/R8Jug==;31:vSfnpnOp2RsUze6LSNOe+Xil5RAqvKLbul2zigwOuW/XAuJZ/PORYzTzlGjR1E8t9ZdxZmJWeHCxUhauvLm8hiGX0wcMLgwW1+0GWD2ON17R/6tE+aNTEJSAWUlJsgxte6iieLLasy7amxt3g1P6qyynyhjDVVZzowvmtcuMqUkUqndrzxRPJXdz0gKlyChtuzrcDHwya1YOaxtE2HGTjsKx07bBAmSjZm0YHghipfc=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27848DC14094BD07FA526ECBBC800@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:fYNJlK+WGOxyXOVWNImQ6eFB5cGvB0pUKG0biaiLuifGAjIND4IwGBYn2yp6EOauYLWu0NaXaEoAeRi9qAPvKECjYK6j1Wk+NegKvUB5aDwM4cQxK2RerzQDWblVxj6G86MMQE4/hjGUEbelCMmT48Zkki7e4N9/twUwQSBlbbWDhxeIdfOuqX51XPaP03MNDyxG4KfpKPxcNrni4Qp3kUwDYv5qr+x/caJn2XUaftnxwqln2STK4Uk5qeqViusBhvRb8qwW628IAztvxJHRZg==
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39830400003)(39380400002)(199004)(189003)(105586002)(36756003)(7416002)(50226002)(86362001)(81166006)(5660300001)(81156014)(478600001)(50466002)(48376002)(8676002)(8936002)(2906002)(106356001)(6666003)(6486002)(68736007)(7736002)(186003)(305945005)(6116002)(1076002)(16526019)(6916009)(3846002)(2351001)(74482002)(2361001)(97736004)(26005)(53936002)(66066001)(47776003)(54906003)(6512007)(386003)(6506007)(16586007)(316002)(4326008)(25786009)(11346002)(486006)(476003)(956004)(2616005)(446003)(52116002)(76176011)(51416003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:XtefpdgolJDIDhX5cQG5o3cS45BG/MnwLSJkR6s?=
 =?us-ascii?Q?DvXPObYDupQOFJ/dzIfM91FrrlsLUJqpjf3CCoN28UIPdzAXErbygsK1/vnq?=
 =?us-ascii?Q?AuwFQ6FxpD/fbrD01YT6npx2BDdXNnXePsmkDDjBDnv6O4NHPfnYespH3ijZ?=
 =?us-ascii?Q?0RMEr9Ze614DvQrQWz6euoec+AMdjrELWrWLJQTZ/C54vfpqx9VIuQNzM3on?=
 =?us-ascii?Q?ps5Sj7CK8l+Y4WjqYHmRpUYwOdO7ziinYqoFUg8r0m8xunVMYPXhErX4p9w1?=
 =?us-ascii?Q?77YehxbaXID7FKDcGAm2VwzwyV9EHt2F7lthwlkMmhzs1f16P4SYhN0YBUST?=
 =?us-ascii?Q?h2HJtPZjnXMw9jBBqAFOrDXfERjp3ntrkUXTQ10t4SPt7Bge0esgPtab5yIP?=
 =?us-ascii?Q?EoSYCUPnuFf+KFOFJrod2Dg74AUF2V59C0zISehsOWBlARUKW2+tzLIbbAxR?=
 =?us-ascii?Q?RUpzzR5lFpmLfTHeUAOelrTROUYZcAT1CJvxGcXdhCHzWbwokayPTFVyHGdR?=
 =?us-ascii?Q?yDpv1R68GrSRAVJxvVGQi8QFjLCxd7I/GXnIG/JHU2pXmWR/BAqtymc99CxX?=
 =?us-ascii?Q?FsRGIX/UbX0r6AbbCXTDJcquHaBs0TF5xntWC+8jsy2u9pEKWXJhfRmrqtWu?=
 =?us-ascii?Q?tx3tnFnChx2io86pI0DTg6W1qbXohqNczOaHejbSFADakCJdxBROMTVII2WY?=
 =?us-ascii?Q?MQuArr4VsoCad+77H0w+qm2dq1zNKDxlkZIUm/rwSG00bqyZHJ4kU1egeiRV?=
 =?us-ascii?Q?eFJiYNsxMnLUijRlqmeWvauYs2MsHJ34CYCLv01HvLIAN/IcHBIE7LFwVY1d?=
 =?us-ascii?Q?40SC9dzlzSpy9cTzRmar4nR2M3CejbaWskxtNOmuSutlA/ApbOySI0EmmGgy?=
 =?us-ascii?Q?bhvk8s3xWGm5c1A8YBIuck8Ut7gVaHL1+e7gZzqP323bO7IBbTiSXDcGKIbO?=
 =?us-ascii?Q?SFEKGoSObyKQwch9/9b4goaPMOTYrxMIVxEbBxQPvtyEKSoakkggUH5RrYt4?=
 =?us-ascii?Q?VEtW7eIXJgQLQ2hGuFpPUYU4RpBoOiic7rkJxy2fGA+vGUtLZjkCxuzuGGwh?=
 =?us-ascii?Q?Ivm9K31NwuxNMKK7s+L0jh48GhM0/HR7flqG0KTMGY6byaHipKOLS+yBaQWM?=
 =?us-ascii?Q?byYW/ofENxFdOJei3l6hA8NcMFaI8QmGCpe6LdR8Onh2woVS8HEQr8WyGP6a?=
 =?us-ascii?Q?e2Gh6grIZbtiMGG1TeodPpJGAlidqYs1uOn9SZHXCIAsIvt2JPV+EFeccCrg?=
 =?us-ascii?Q?3L8ojjdJ2XLSOHS5tGEXtk4a9dGitvghA2MNcV2Yq6Q6Obn8wtbPmo93//tN?=
 =?us-ascii?Q?WNMtc56pVj5HmTiGtgEZ5tyk=3D?=
X-Microsoft-Antispam-Message-Info: iWbd8cTA4nuNm5DiWEjOC/BhqklpchoXYrnxa24D9MQ2waoCIDLAyDcjbEeIoYk6G/0LuH77g62rchRqU6SFmCg9B8xt2iAkoBTW4j4YXBIvO4tAjmLFMEoH0NgOkQs/p0txbqkeDuPemzA6/eGmnPf7Y0pPXuKHpe6NfNnwQOuwFvRKcr7KP4gIME4IJEMb
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:pMpIKXJeeFFrbt24wxjBYtfZvzgR0jbb75HSDYgtnYgq8E3gyNcPwrZr0hG+t6YUnLcmgr+jxHy8F/Lc+ogqcv3mImZwW/FhpJPsqIDhlSAXMgjb4PKNSo6M07WVLKy7ERj5KqayFC0+BbC3r6su6G6JKh4cPcQj2tWl9h/xWHB5gpn2G6Bgx2QbfD52pbcsVgSx/QdYGcNxVYtcmq91t13AxA3wohqcWAoXDY0xSQp+iToDcS1+rwqXmNQCWCeIY9hVB9lf0KbwtYyMtoVO2UKP8SnvjUDI3S/nlYO7PuvQ1PbBFHkTegds1zT0Vx7++pnYKpXkeGjSSyrY/RiMs02Nz/1At/eFEQ0VJcOhKApyt3sBkDwz4Y/WG34/IN27QwE5e1yZrMgeUW9lNiydko6EPL3I1mKWlR+xFgTtBMr8McXWgJWXoi7lkmZVHoWPamu4uErGqoeDMuay8nNzGQ==;5:R+O4FlecOmKQ6YYBsUn+/iw++VwFKkxNUvaHeuJHKvCmyt9/tlSowvF0FSapI5SxJmi980+SD8U7z9SiBRpm2qrm5Q4bEKwp0KsUZz/x5nPKo8v0oEKlcO0gouB3I1PY/wmWGZHj3xOcLHH0pc+4YhucVSUgDDiaubRC2S43Rns=;24:7nJiIs7Aiq7NUR7F7wfBYrvudzlbTVnjBYS9sQQRQYwGxGLCB+SAFohfHy4V6XPPg3VHP0nqXu44Ge6v6UHriAKPlvIzHber5u6chlAzZ3s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:DfA0iUUxUwQlEfoGPbTdnxGZlj84sNZzZhuS3a7LRsTuW1x+3fyABYgyTF9jSxj9LroU+iOugYIUZDtIcW/dUrOcpMgGPLJSHZjJxI4vwfy3cU/xQvWsNxhrclZ+eR+Mn91qkpIiRaFnp78maRL+0Jow4RZMzOUtrZk1+Ccz/+ubjPQGmnz22qL5SAeWqz9TyTxuLdFQN4meOgFsNlkyJ0UHHkQtMAAvYgsl8B8hsr3kHJ/FgPkGxP4/riw68irZ
X-MS-Office365-Filtering-Correlation-Id: efc6c373-8004-48e2-e708-08d5b000038f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 07:40:43.7169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc6c373-8004-48e2-e708-08d5b000038f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The more natural approach would perhaps be to add an drm_bridge_add,
but there are several other bridges that never call drm_bridge_add.
Just removing the drm_bridge_remove is the easier fix.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/sti/sti_hda.c  | 1 -
 drivers/gpu/drm/sti/sti_hdmi.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 67bbdb49fffc..199db13f565c 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -721,7 +721,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 
 err_sysfs:
-	drm_bridge_remove(bridge);
 	return -EINVAL;
 }
 
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 58f431102512..932724784942 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1315,7 +1315,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 
 err_sysfs:
-	drm_bridge_remove(bridge);
 	hdmi->drm_connector = NULL;
 	return -EINVAL;
 }
-- 
2.11.0
