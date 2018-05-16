Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeEPKXW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:23:22 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:21089
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752387AbeEPKPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:15:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 02/26] drm/bridge: adv7511: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:46 +0200
Message-Id: <20180516101510.13215-3-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:7IIiKS3mARslXw+eMvaP3C+mw4Lp+BQ4JPHpr3+xdCbhihf/YIvPKq4Z9AECvg7xNdpBF/uby7LsBINggYg+7dCsGacWpQg/HXAE4u+W8cMXcmZbOvYtUGQy4LBpMKPUpseXTGCIJSPxOrrIR/8PeBv7x+WDpXi5yjL/yF/Cp+Efsg2nwfPjmOMP64t3g0zHGPVTbUvj70ToP10sVitmmCCxmpz6uT+FerkeJBPTzoSU9VL4PeNRh1XMFnXDgQBT;25:sX8QGRmnQT9aOoKkXYlBIH0e9lKgYHvW5oYzhcnMf/SxFYgeCeNraTnyL2tbm0O213BpN+M8PopAknd3e22nK8LxGGcH5ZMaSqKzNwncehc7sV8ZY+bYeU2Rv3OCicjKc8KfRupXxfv4jvhFZ4YeddvXThIxzxH9CulolOFDQrysrBmOHW6Nkv9yVKLgv7yck2/g/a2nOIhMHJbRSuMsUEeGrKoc48y9VuAbCAqXnUTDtTo/LX1C5FfKqJ7AwodkuhY8enjWeXou41bv9QcxCBgb+h3/0bpafb98MOwxpMxoGFi1kmKuwQgBP8+DMa+ydv5L/tTyw8hjIKv7kwDr+Q==;31:uZSbZXdudNfGvXEzrDLhlIHPUPxWSR+4tqoeLxdh8iEg9rZpMgpQG0JL08Q9BzXqA9s7mPDPH1+5T4YOU5Kayeqi5xguYdtOiueDBL77/Hm19rOIbc7pxho/KpEp8Qsrthvz68rcPrviMzGbgOxYfcayn0fC4qI4Pkk9daNEmGH3SGXBQ6lqahKRz9fjeqNClHKV/ZFD7+5hHKk2U+p1zN76Gcwp96nvuvC3ljbl8Pg=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772867B76557071260F87B6BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:hPl9gW+NJ+dqUpHfRV5Ol3TkVfnE2TrzHMhjKUne7h5m5evvwkf2UGO8zGJ+cehXDGLftFoUnRa9cp91RYRoc+ir+QTcqBiss3UaA/wEIgYXh/licTd9oW0+ja5qNaoCIXab7IhPLw2rUfFM1HTFFs4+fpHf0sALsbwaiAJLPd3ZeFEAkdxbhYTo+MlwjEQKcd8LwGCEWPj1d6GpoFdxQD7dZpVWW6uEl4sSia63ZiinqFPwU3TLKIjItSuYL6k10y/XuFcq0tAPrcZ/zToFZg==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(39830400003)(396003)(346002)(376002)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(575784001)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:qbN4I/Wo8hZYCjnFRRHOy5xqeN/O/o7vrgfBvzj?=
 =?us-ascii?Q?xcmxvrm+Okxrg80cHPsv1q/foSQBdc+HAd8olQKeSglacu5uXB1A5AnDH5Rt?=
 =?us-ascii?Q?Bm4JOdCS+tgKLJ4nYwmvCyMTV+I/EpFKmX8b+whcqUVqBb9JZkYQ603QnE6/?=
 =?us-ascii?Q?tzeqH3uFzaEogYx7fZcPw9wqKeYUk5YU1M6Lfdir7x4NmardgPX7FLE4PHa1?=
 =?us-ascii?Q?dbrsh7Ly9PgNQNcs6TH7oAarc+v4U12860IdKiPgCe1U2Igndo344vnQoQFX?=
 =?us-ascii?Q?rv71771a/zQL+ZEfkCIoEMwJtxSIOjifTCF7KvVdBOzBKHUHBssPcEBMRQ65?=
 =?us-ascii?Q?MvN1IX3WycYNp3aOwvlfnFHZYyCiWRadYS++n0h/sVjC26XRTvA/2PzaW5ZA?=
 =?us-ascii?Q?7hIIisbEp5f+WaVVFxHIDCy6qnnrz9vmmMH34SIabi5LOBPi0+LnVZdpqAEC?=
 =?us-ascii?Q?UaS3jnSIO9K3foDMljWIBSWefabEC8FAiY1REPDMy1AFaOEB++hAKy1b0ir+?=
 =?us-ascii?Q?cXrNyabrAxfpgNlhLkO/Lw7IaMneMHR+4SzEUzCCUJwTCPDWgoRg6dQ/TM5D?=
 =?us-ascii?Q?f5r3m3lBHodT9Ek9lzEMWcL8y1BK2ZxvlWkyt8PNeAMs3ZrhPCUEyQflxGdm?=
 =?us-ascii?Q?+OlH0YyH0HyLebH78dg0OXGwpCqdslYc0p0dQ3gAzEFoGI43KjLNrubE5k5c?=
 =?us-ascii?Q?AvZuXtPfsDpgZ0wyPsRANJJ5gBW1jnJFHSq5P3cAywHwHHjjrhFOiEXMTGd8?=
 =?us-ascii?Q?hsTN3+Ay5RVnronJE81Yaard9AS4kmZQFCrERVrv26zZmDRMwF8rNGgf+AyG?=
 =?us-ascii?Q?Ce0yTnBfJD5WloVJ8LlRIwCBzyvueInAwDQv0URYd/jgyfzIW91YsLLhHt0k?=
 =?us-ascii?Q?HLh5LRkwILF+yUXhGJiSkNrD4Z0zDvAxKfKQxlpg+XfSX8xAHeFzc6r4Uxfd?=
 =?us-ascii?Q?3iEW9k8smrlUDgY1nwjMZONjwM//VE54EF30WRhlbdG/didEs+Ov0nrFPf7U?=
 =?us-ascii?Q?XrtbyKh5AAgkBbLoRmx5wIuCUq+KnMcFgGzRfU8FzrzuNkV0V/MElyuudUBw?=
 =?us-ascii?Q?rJKzu+Vian+CZPtQBoN9KwxTXcas96CnJKi1aqX95wPyG0/Le85R3Y3G7Ggz?=
 =?us-ascii?Q?kUduOTqLj5gBuj5O4qs5zTofzht5poII3jy/JQGkYJMyiyHIiv3eqnld5gAG?=
 =?us-ascii?Q?4rLaretLaMWIeeo20Q/N75JLInbQqQKN3Z7hfHrxhpad09PWDvKM21IzgfaW?=
 =?us-ascii?Q?B25sit3nRFDf8d/X1euqjUapLJhR++GvXLsHzDUfav8s0IFFDMT8jNBSxp52?=
 =?us-ascii?Q?ugDN/FRvJ/pZVTjxe1BFcxE2nmCcFgSu0JVm07aJELtqEZNlkuRPr9TgxvUd?=
 =?us-ascii?Q?kFGxksx0BQL0wVQ19N1D8WWy0y14=3D?=
X-Microsoft-Antispam-Message-Info: pa+SNgCUw9Dbq/sE20NiAtbtcl4f1+ZNuGdJetrDy00SP38iEk0tdQvHIKoFJyPLZcd+k0knirHfPeTCNV5P4abBEjykMjEWj5vM6EK38Lbl1+1I4eWoblZ3hzIVVSvNM0Ap9lPuA4TFaetqAcAQFTnBMA94kb8MmmVydBXa3ORI4g27e2RC0317aWSd6ur+
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:cyThwfLFqhePbloJ0IAAzZ6REs1haDY+1rs8pIAcSotzVTUW1lWQfgqIFbHiNmsiOBSM3v+hP6Ku6uPZ9CGcx37WBC/ipfdUWuVXexDUtaehcK+44XsPUI3Z0xGp+NrKuOsCSM48beKzqF+ocF4mx/CyMLfcHZJw3Io9iyrSh3a2VhKHy4eBMfUrsHh14xdcVcvtBzsv9f2o1VQc7SAvR49d00y/Nxc6NqwoLRFnZ7Obw1Ovxyffk/N34UyHSY2B7MprcgqoTE8hGrYbjlBFj5ah9oE3a0/deseWZ0XPOArhPeICdvHlXYrvl1y9z/ytc0l1+aJyt56nYho+mK4JxZooqKRBEmFQn7cOCoC9aJ9hNHyXRFyWAP8KeXkL/ESHSN33mUYdRfBRh5hTQz5yJIWQveXIJxbpHXZtgzix3s91jXUhgiHXtzzc4ejrY1G+9B2kZ1T+DEGI5EsuO4OMsg==;5:JVe4GgtXAWK7aHK79G0N61tHBcSysDKnsqrOEsZEAoCckBVWGbrDml8Gy+m1T4VOptN/N3RLMq3euNJWcP/YVipLuhjPOCe9vXNv6GmSI16iVomBjK1X1wC36KYkJDxo1LYeV6rp7Dg7Lm9rjYL51MNbxU/KETyxZ0UsrxMseLE=;24:SlCl6evon3mRtsYxbqwAMPuPRaKL5S5bqMBJjqHJbOJTHBcOHZoi0tvgBM87HnYvwBfGZ0QTb52KIxXYOE0LINvPgH4dqJyrf8qAUOwLzYs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:gvvcKn/OIe64M6pw1MeCaALo5wNfT7a5mRPGZ8v+8QvwpqaGI45dAnrl6pLdF7198GC9SSJJ1B3Zx6zuzEbObrib6ktjM7/g5IGNVqcFoheSCByyUU3I0q/uRAR0SuHP/KPUQSLVFOK7Nl7m0FJmmjD6JVff12hwMtuWF6qJpdVKZGDbg/wIW5u/r2gxPx3/xGfqq8FpA/jRX5MxXIMqbIZ5LlSbQiOmEtyRIDEEhsqXoCZgGTis0sAb4EigZoTP
X-MS-Office365-Filtering-Correlation-Id: 9e9ce3e1-aca3-45b4-8f5c-08d5bb15f59a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:15:32.5902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9ce3e1-aca3-45b4-8f5c-08d5bb15f59a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 2614cea538e2..fd2eef916b0b 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1204,8 +1204,8 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	if (ret)
 		goto err_unregister_cec;
 
+	adv7511->bridge.odev = dev;
 	adv7511->bridge.funcs = &adv7511_bridge_funcs;
-	adv7511->bridge.of_node = dev->of_node;
 
 	drm_bridge_add(&adv7511->bridge);
 
-- 
2.11.0
