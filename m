Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757327AbeDZWhn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:37:43 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752991AbeDZWcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/24] drm/bridge: adv7511: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:17 +0200
Message-Id: <20180426223139.16740-3-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:gtkTa6BgbZj3Z7cAUGAwggIFOi43feDoPrAr0PxUkIHAwSqD192dFuc55KAhwrszZ+i84OEvef9ZNQWcgvcEKQFKP7tICl3MrTukQyEyA2YsAdjO2kwlNGm7and9qUmIjCpYbKS50+J3Vc/Me4/iZKzSx0vJ9/tRGrqUH0iuoROLtegIn/If9mzmHV1TKXt8z8Yaa433QfHEEQqS3ucwZu2RTDe/IeVR+s+WeIyX+qzyJaLCXl1WUAzaWU4+rns2;25:oLbpByYHhRcjVXmh37NT4bz0quFprT5M38DpDALKjFjAHfUKKLNI1hlLj06b04qhPo5NVYeAn/HP/dX1yBStTl4n7m2ELoJX4v85Z5+2vq6HaFIwA1TnWGIqRQBoc0Lg2nLn9bEkIqgcKBLU6ytCYfBq/KP6IdfW4Z+VlHQbipwndr2ABKrU9N7gdgD0W+Lxq2vHjqipcRd/v2XQSDCJl73Ayj+Vb866qjPV6W/SsTbMO42dI5Agg+CtWnNwYCEuTo34J7fgNTn/y/inokG2TLHzmE/2F3xT4M0ywW3DnK7OOZHvPHDKOxG4mERe7abyLBBeiipf9LQaWd2M0Ufqfw==;31:RSLqZrt+QxyVVGNVLGI8bqBOkupIwS3XgqTF1U15nkPwE7IvRkPO54Hsa29Klf/0EtmZsDOS5IjF5iLCyDvPXq/PyXz22T/xinhIVp+XaabPfYbAKR93ubdu/Xp45t18YRNJeN3QeXyaaUYAMqniH38yqLsQqz+xFrHfifcLkJLm7knOuMdlyzx5u8b14EXCpjIg7xtLhZW/y6rE/GdrnxXCcCdvt21IkwkF1yZCJOc=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27823FB67D0177BD43785871BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:oPNzHFl94Etcshh59U8HMJRl85bHtRy3B6tbyhzIdFdxduwV+vN1qNXxABNTo3Pjs8ACs93Hio/16OO7yfM0HjBSL+DLpbsG7pY4rWDZtwFHQdIABXtWLt7Dq4gPgSwXyxPfSjGkGUmRiu3m1UVrDsUnjV0yQWgnfp4vCkHm2F2Rz4pT7NnoO5tKTFzPTEJX7PJZuNS+XO2IxV9cQIKituCZ4dIGSQhed8MPqNv94K2Qy2GoBtV1sy4LT+Rr55KM4Z9kwZF/0SEZuMvTzltTUg==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(59450400001)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:JYJOulru7ENGNkGIWWV0ifrLFekaHYIp/hX2vyh?=
 =?us-ascii?Q?4Fyn2Yw9Tc9GUhji6GK2BChnT0l6Q4OgWbuAS77cB7KU+UxO2k1xtUhIBju4?=
 =?us-ascii?Q?rly184Fx8LqMItfpuyphH2g23JUeb3tGR8/xI+NPgEBOCHs4ldLyZ/TQUE4y?=
 =?us-ascii?Q?5LJiGX64CgF6UfpA3CvHMC9i5r1bn5MXwuCI2s61qsuKq57vj+yXlC0onykw?=
 =?us-ascii?Q?FFyqoI2dYmz4Hggj3Zz927PivyMP+lBf3RVEcjzFnzWTYVb0j4bcYR/0DeSU?=
 =?us-ascii?Q?9y0kfAFmjy0xg2g59WsXhQdA8u9rb8WMor/MBUZ5lhzEAAOEZ0F0GaMqLp3M?=
 =?us-ascii?Q?AavBRS0xEry6E56u7Dtpa7wFfO334HQ5TnYtDh2MO4lo0x3qTRDIf1+tknoJ?=
 =?us-ascii?Q?ayRkBjzl7/rd9o2ftkTkWZaja2Y/X6z5pnxCK5eZ1JTf6jzJyvd4oLfCzfSs?=
 =?us-ascii?Q?YDgz1yAvykLV97R8JPyj4kKcEwtrHKnx9SvOAxUra4OlYZOVro7fzI7kH5L7?=
 =?us-ascii?Q?OOeXqE8xtoR4xl9qVrtrnHLaNMdVkcKTtAZhHuCpYNjLuAIYzvFszf3IZT8D?=
 =?us-ascii?Q?x16AzQCr5FezeXH7jm6hfy+2KoaEcqRHA5zYICf/o8tSSFALEFcBH/DjkYym?=
 =?us-ascii?Q?bs97Gx5A0MStBg3uGvtItVnRNnHojnZNeIFubEyGrRW7otWaAqQrL5RZpZ1w?=
 =?us-ascii?Q?OyGGvc8VOTp5Ubsv7JVOj7C+E598eSFwBdpoi770ZNJ3RLQxeS2Sq09efSsm?=
 =?us-ascii?Q?6TsMy2p+nEF6yKzT+SYPMi1oeWhR05NOiPrMmjkRWgWy2U3+oqzjCh3E1SCz?=
 =?us-ascii?Q?ZZtuI6aC/ICy09QXNMy7eP1WHDks0Zj9j9jQ9Cy9+cD1dsa2mqi8n9KRRrKk?=
 =?us-ascii?Q?RnkzXE7ZjvV7Panwuzo5JhseRKoxLFS8WROlw7W+tzCHiXHHU/hImZ9nfdbG?=
 =?us-ascii?Q?R5sK8Jr3mbpcyTGDflFQFA12D2jIxFWK2T0EuOBF42ohNKACG2bI64u2Whas?=
 =?us-ascii?Q?qIC+Lwwgew7KyKusv5qYFz/Rw5lo9LD8DKiyKn7gTCDzoU5ICw6EfKreXob+?=
 =?us-ascii?Q?RJo5+kf0ZH/QiQGMe9FMG8gUUMfwpzRkdgLgx4zzvkxRyU3RcB82I7QUnRm6?=
 =?us-ascii?Q?4H1J53K9PpGLyzCZ7Gn7+T3nEzffbQq2fvxVuRA9jMdeRmLndGCdi62529FQ?=
 =?us-ascii?Q?gLGfJvvr4II2I3x5VoEbUy/ueVgDtasBzh817BchtlBiPbv55/Qj+AED/dPy?=
 =?us-ascii?Q?X+5ZOL6zJLfLubQLhY6jBivx3aHlJ/AUGsbadoDh5CzHThbTdnUalMVNrC9e?=
 =?us-ascii?Q?UEFmg9b/qwXRLUv5en+fBpszghbUEVluDCSBuwOHFFB3i?=
X-Microsoft-Antispam-Message-Info: /2PJDLvfO7ThEzX/SR58wxdvtjcb13tV0hS7P1sHQsKs9tb/T8Hk6Pj+5LlpCOLBkYhyUBIOQ4KC4UC3T6tVSVmMURehfstDHU/IdlXpk6sOKmFLV/J2E3OIBr2LMpILSVmkuTIp4O20VTjRK3jS8+Im5QtT9DcEqYOakzsFBkXWcyoh4GK7pjszfvU9GeYf
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:nULKnxSr2F7mT4koTlvoxcmLrJMeqR2xcwmy8NXIVrpsecWmPzWPLXL05bjnPiLesMngKWYD+TXus6uitmm6MUTo7mGZnRHE5SMFVjH6MEpPNo1YJqgtlkfSi8HSdW900gIAPbzckr5d0MNfeVGrmi3nu2OC9Jx4j/jZ9yfPA3QvUYfhRcjJDvvcfN5WyNin1FUwf5sDYCcd6CzanRFaeuFsX5PEiS2Iu8GXQN9cxmNPpfe1oHLr4chadNDzpn+7NcZ9HqIA0uqkWBMUPHG4WjAjG1VuWWcfgX75rUgbbNIgtfA+ywkPAuRi8nXKpjkLtCN6WP1vpI8I0LQmiKSoNw0ZEVEA5eqw+H+MWkJhQHd23czENU2hWa4u5dCBn5XGlGNfK5yIc6aIW6zDJb9c9UG4t8P8sfiqwx9L95QD+77iJ1KeCWVXxUmBoSrEk6spaxqN1NAHEQC4YtzdbdPvLQ==;5:SFXWL/7PAzAKEN4iRk6ArJG1a0u47vupS01BoBT4KMzkpWgNyBC0smiZxetAdRqrSHB8pMHR5iLpruwmL58VwlJRifxP6ujDTQpC9zTlpDk9yAFlKwxjtHWGNzOzwAbKUXZXdK6qmuerryLBBacGdcbRztksznAxb0T6nGRZLZA=;24:n9D/o3TqqXH1xWU0LGCgBlFLTaUf2ZYeyjXTXXEzYsqxT9jt+beuJZZNT49Q1IGeyKStihXxtPKmLeiP9uWGsRHLcBMDfAjCtAVI5INBPAw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:n3nURli9BZmHz+wNZhOvH39nn6mJ2j4D0tIrsX9b5TLGRANPZh4qz0eXIwwsjm5b78Pe5UeGA5NnppH27GNu1Q0oviGHmzJPFBPMAxQQBlpqQCHgqbpzxg0d2214XZv0uPFnT75YBrudJRpxBNXDK8wUZrJB2phx23fI7GBSflLuiBR0hlnal8IxB+x1PuvDkv+PrxQsubiudG/bvvEP0wth4clBQfb50MsCHESi8EHUDezPYzbUqlTSO1Ye4Sh+
X-MS-Office365-Filtering-Correlation-Id: ec5c914a-a9a4-430f-1c3e-08d5abc58ece
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:12.8541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5c914a-a9a4-430f-1c3e-08d5abc58ece
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index efa29db5fc2b..866f3ebe9e60 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1195,8 +1195,8 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	if (ret)
 		goto err_unregister_cec;
 
+	adv7511->bridge.owner = dev;
 	adv7511->bridge.funcs = &adv7511_bridge_funcs;
-	adv7511->bridge.of_node = dev->of_node;
 
 	drm_bridge_add(&adv7511->bridge);
 
-- 
2.11.0
