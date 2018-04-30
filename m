Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeD3HET (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:04:19 -0400
Received: from mail-bn3nam01on0085.outbound.protection.outlook.com ([104.47.33.85]:35918
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751759AbeD3HEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:04:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Adam.Thomson.Opensource@diasemi.com,
        Support Opensource <support.opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: da7219: read fmw property to get mclk for non-dts systems
Date: Mon, 30 Apr 2018 15:01:55 +0800
Message-Id: <1525071715-17796-2-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525071715-17796-1-git-send-email-akshu.agrawal@amd.com>
References: <1525071715-17796-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::25) To DM5PR12MB2358.namprd12.prod.outlook.com
 (2603:10b6:4:b4::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2358;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;3:NGlzHd6yEuUrQR+iZeXixcYzhqIpKt71cy9J7dmRo+aY+2Z9Q1JBd1nwzLQ9UYzKvDSf/ziohdbY+9k1JrfWTNzpcHr75l7QZq7ItgBlw9c7pqh5HkFndxC8K//9b6dlKsE3xJDV4EegM7I/OO+knlLUmK2kQ2GGtRaAcsuYM1OdVgoTU9kgOwS5daMDuHtyXBiplYjKE7R9gOorF9XFXdQZf2ZZdDglKx/dmAsnDkK6H8dsOEpnOhIhSHODbivC;25:daFaH7eDG68s/84phXXMe2WaEH0NJUeD+R8ZpgrhpJIXwnk/rYAAEN1rVGBB+8Mfw/FuHfmb4QcH+rxmxz569wf0ooE70SQ0HHSZnEORu7V5efTpK8evAlITbGdN0sfGbi5RIQ98km54m+HKWFWOoGO0gfHKfSXv1kOC2EzWNWIQ1hXF0LzPWXx8Z40cgGGjHcuQITzZpCQDQNRzMULW+mYCCH6XkBV5MkQfNgIPqXxTMzpv4i7jQ7AhjapRl81Arx5dFxB6KdRw2A+ZHtYnFiLO+xF5KJk+WVYNYsRPVN7wK+/d6kfN+Z+5CmXvWcs5kf6zHUZ3hjrRkY8gEAusoQ==;31:S2tvnc0G53UPJLQ+FyVUqCgDsHUlc/HujHL9SEF6po98ygZH3W4nhaSciFVQIHpZ3908Ab/s1zXbEdYrDHNinIM1rjvNHPHDwgb0nm38CS5zsPhFd4RuNnyMqUnYl2hLpRuGiXVvyhsevZLK0bi36EmTCxvSkCjis0j0khGliornT4nLLivoUayKudRqonsRJ+DVFleMi1vRs/Z8pOOLAisyiP33/k0K8+Gy7PqApok=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;20:OZAr3TJprcsRsFQhqr2vqcS9dMhD9YaA2ukjfyxHJyDbjxfdcUvegO9Lk0V+r2GOvzxdNR0lziM6talS5qIb2tNL16nPeLaDnQwb1SXap8aU0igVp/4egZKFtsgImSDs8QOOXh7s3HIbwIMLZ8ATdJIhU+LFgBf0sVY4PFFCynMy8vgyN3IO8ie+exSXZRjbFPVB4PLGbbGAxVlkyvbB0xhcBM6vbF33CToxJ+emomZJ0IqUFOSOwBsSgbfmvM6GML2V6xBkiaTz3VBoU0I3SyOfvqI1Mtef1YCwUM/s830fEsrBMKgejjYaPzfvRQni+0uH03d7HFCYO0QEIOLRDEVTx2dFBXWWyFNGVIN37b/gKEQ10XlyRw6RKvWqicrXRm4qe96i7/vRmXENIgmCi6uOCxP7/r6p1l8H1KKRCHhaxHxJ/0BHVEDCL7jmu78ZTlNk7v6/xtiN5etfnO7IWKu0IfVzJeFQhp4rXr83E3PRACRnDPrcViUlNEVIknQm;4:0VLc3Ya4m9bRhE+e2wt1FplVZjuznCQrqu5wbKSbwO0fBr04jPD1rDDN4gU/qWz5rrLGLTogtEHiQbEblZTP++y43+RVWQN8lLZItONyyWNFwUZESQjGILZER7sP6lc04bDwiBPhdnYTsfYQxQDffMFqySCLNfpOjvflix08ZxrVRRNTdt+dIABUBKJDTckN0i+6m6skYpVqcoU+9K0MA7IHWpZoyi2tEOnfk8nyWJ7W7U20LE5bU4sPeHlstbWelBEXfxJWYfy9yZAAfqL1aS0Def7jo371MWxnLdqFgCLPbJ5BZLINacS4RjzpY1a6
X-Microsoft-Antispam-PRVS: <DM5PR12MB23589C06F1DECA455D0B0C46F8820@DM5PR12MB2358.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB2358;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2358;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(6486002)(6666003)(97736004)(16586007)(8676002)(47776003)(81166006)(81156014)(7736002)(8936002)(4326008)(2906002)(305945005)(16526019)(53936002)(186003)(66066001)(50226002)(109986005)(26005)(106356001)(53416004)(6512007)(105586002)(54906003)(39060400002)(48376002)(6116002)(3846002)(50466002)(1671002)(316002)(69596002)(72206003)(446003)(476003)(1857600001)(486006)(68736007)(76176011)(25786009)(2616005)(956004)(5660300001)(386003)(478600001)(36756003)(44832011)(11346002)(6506007)(52116002)(51416003)(59450400001)(86362001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2358;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2358;23:naWJoTBnfwJM14VNrwCeyyILMMi6f0H8g65CXOWel?=
 =?us-ascii?Q?u5JHvQlcrcNvSYhXL9TNeW7nzrosDFp+EP/5+MaZJDkYVTk13BD+Edfpp9s1?=
 =?us-ascii?Q?ag/gHYqAQb6CuUeJazRHPUj83pPism/iR2A2M6Ad2DE5uHzjbkLd2bI7ANJw?=
 =?us-ascii?Q?pbuV/NYhzg0y/fB1CzP28I/CBc90V7ZU4IIl+2Fud0qQKD6CZfb4v2lJJAKx?=
 =?us-ascii?Q?6oEhCHUR1oKYvY/XVrAtfO3kP8pEtQtU09kTJk+1tEL49kV7gmi935aypZeE?=
 =?us-ascii?Q?1QI9h6XMBqJhgEzLW4ohony/l51NWqUNMkLaAXHyQ6C4wg3x5SEpFvQ37vVm?=
 =?us-ascii?Q?Tax4Q6wGsjFuy3odsg+QlFZ8CCHnu96Y/hf8oWMwj1Yc5sQMJJNtyoHBBOio?=
 =?us-ascii?Q?QEzJDx78TOJUbKNkUf9XDqPBSHQTzgDpN1bf+lR/nVWJATQvupdUsl9Te/1H?=
 =?us-ascii?Q?G6ID+Zb1iCg2HPohuzECRQ+KeLXGgHMxW31Tzmv4y9gjZb3Uff62M/Jf2UGl?=
 =?us-ascii?Q?rHtLTZxN9bkMxIhx7cuSEvvCbYYOmYqhL+sj4dehY7oym1gYneEdYbltiC9w?=
 =?us-ascii?Q?YUrNQJOupdmzs1JbjsVAaP89N1DWnPohcYLHQRWNteb3JEXCAoWt1J0edDm3?=
 =?us-ascii?Q?SeUFBOjMCG8xrQ4Zw5QPgovqJpv0ct+UPuf3HGkYP4/5gR3MyxhjlGJxXRgP?=
 =?us-ascii?Q?Z81x9i2HzOtM9Li4AGbLYgz4Gymbz9M2fHeiMe9fTzwp7kpqwjCH3bx1oiaq?=
 =?us-ascii?Q?Ypt5/SLZqBKYKZgJzotVgCo9OZZM/KeI6H5eInh3qdxu5MQb5hUKybIzfpDL?=
 =?us-ascii?Q?oLByW/PgvLcJ0r71/bNjCf2AnIGnZvlXoM29KEYvWATKQtsnTjCYT0GXGoEH?=
 =?us-ascii?Q?HoinxiBNYXHW4r7eyiGH+yBOHY+k1Ih161VfkbGAj0oYryplsT/K9T3MWBuU?=
 =?us-ascii?Q?+UPDZd+AeGDyvk4FZb8tDktmkzjaG/D0nzuDs71ugNPKg84l5mSwUDwOsKbk?=
 =?us-ascii?Q?mHY4FomnMgjdRz3N+ykbJxUl2cp3/WQh57CLlKMELuH7SmNBQ+v6p+QKPk3/?=
 =?us-ascii?Q?5mufXOVN665V9CJ3fk8pu0p+CePAf42G23kZLSQGML5owPXquLog5Y0PYx+g?=
 =?us-ascii?Q?+sRZC2BajrmzdqALq2mZHAn2vCTEBrrTBj05K6ZW3iOFKjjvGWwmFSn095n4?=
 =?us-ascii?Q?CNBU37X4RghmCEIEB9qfAmIoIW80HZakA7KKMo89XB9PbRUV5vLQuZRDDGRl?=
 =?us-ascii?Q?ECMvKEZ9gwGKV7G5JOC5DjA6Uj7ESj1iW86Se2F3hcGGw/PZB9FktW3y9sw0?=
 =?us-ascii?Q?STdKspNLVn/THjPC/6/0WeMDGy4VgYFs0ZA/85/sbXHALj7UurkJlJJ8o0Dq?=
 =?us-ascii?Q?AB0I6vdBSAxg//b7v+jgnY9bcWb6A9NadwzocH3AEdwjNCu?=
X-Microsoft-Antispam-Message-Info: T/aSWTSH3xyM/Vy+DmwBTLWj8VcOSBep4WbuWcoQGG0c+s7ycLElbNhXRQ9jX9Imey47tu1h8s87tK3wi0SQs2f0OpbDulcglcg3bvUha/19zee4FFsqZdv0LUUaWhddcUG51/NjRdS+WxkgDc4iUXkLvXPNWWopkIg7TmIEIlXvSPWimwKoMjytxOxTHrba
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;6:QGihPWn+cvMSdck2XaDPf+YINMEvQ0pUJl18fiZPC71rz7zg8VolKs8tdhGixDfRjdmiYYTUIPqFGOlKPSHYwYxhd3anaCP/8J9VepHerC810OwUG1WvKy07nkBY+pAxlnrWlODL9iz2zi90Eh0Kcq2EIJo++3WB//BX3kUWRGszr5JzBHRIisfqcIEkO4O4geJlrWJBwIkGrkgCINW5K3HhQixNSoWMUXn6ZR2p8WjRhLep2v8wO+tZBZExy7xBlyPIPDzYFSq8I91vM7EVe4AG4Eew3HlHF1SMkdeHJRArHS2DZgSHKZktfrGCPiCokTw89p6DSrZbTRJW6xHjhsM7j8uhujbeN7yEeZjHSz1//MYO2scL8oDyrVZ3KYUuvqhAxgw7JWdRYygNmSikamEvues969nWinX/pYU9Khgt7vXTRduMpOnSl7Msbn/PAIfw0t1TMbffE6BOwPGAiA==;5:n6eswQDGXHhb6C0K08NHzkDAy14fcvaqnnl8DSVGOxHan4c8bC/ROlY/fejYMrXlIHxsNEb654i9+zyKTj7T63cLSXJUv3HmFIGlHwe6bCjOqj0AuZtgWXS5sU2gxzLwCUW9l7faNUF3+dSePaiy9XFI+vazOSIR+kI0Y5/C4sQ=;24:0yKaWRaGWMsn4CISXp8gA03H/0+4TScuUZV5V8D6wSlrjtLfG1PGy6sRG3GOTPXzaL5oYtC/UsmnR/Epleizx/mZx5VPxUeF0Fi96XuYaVc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;7:fvA/Z4gjwjmiUpJj6P+S7lM7K/CT1ty7k5Pm3OqfA3cv5KUnqPrwiSXbB9xb4l+PCaltWXxC179Kx0NVhxMZTD1uW6qyLJ9qX7/ZFg1w+togh2PLbR01Fp/ELNR//5kaM+CB3GlmtI6OTecXMvTUp+r22jg39vPF5zcfmTgm4xZpAsUwJgilgrlGRQgvkOGPlJmzNbzl0NKZn2TEU0KfJgfu7erYlVhL1/RHFA+6OHITgrL11WKDzUGe+ranDd/0;20:u1EQ3J4gBbidqYCRMqeZ1XP6MhzU8NgFoyvj/iNyC7pNFXjODlzlh8feBwgGTfhCtofl3a1m1h8AJ3adxQDAntw8JTbtPaQSNSCrda+L4vWjPGfd3bXDwqHQ3DLZwWFG1ahiuonWM8gWO7+uOuDesQjIlT+6Vf0xXjmKAoyWcuJbNt4O1eDo9S4i4bIWe15h3aZ2bVaFZslCpNCVsvvkaejiazyyAL6/y3Y7IzG7ZPXTrUZCUhAcBV5vi9LJ8hqz
X-MS-Office365-Filtering-Correlation-Id: 91754708-8cf9-418f-7dc0-08d5ae68925b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 07:04:06.5439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91754708-8cf9-418f-7dc0-08d5ae68925b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-dts based systems can use ACPI DSDT to pass on the mclk
to da7219.
This enables da7219 mclk to be linked to system clock.
Enable/Disable of the mclk is already handled in the codec so
platform drivers don't have to explicitly do handling of mclk.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 include/sound/da7219.h    | 2 ++
 sound/soc/codecs/da7219.c | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/sound/da7219.h b/include/sound/da7219.h
index 1bfcb16..df7ddf4 100644
--- a/include/sound/da7219.h
+++ b/include/sound/da7219.h
@@ -38,6 +38,8 @@ struct da7219_pdata {
 
 	const char *dai_clks_name;
 
+	const char *mclk_name;
+
 	/* Mic */
 	enum da7219_micbias_voltage micbias_lvl;
 	enum da7219_mic_amp_in_sel mic_amp_in_sel;
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 980a6a8..47ffb35 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1624,6 +1624,8 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_component *compone
 		dev_warn(dev, "Using default clk name: %s\n",
 			 pdata->dai_clks_name);
 
+	device_property_read_string(dev, "dlg,mclk-name", &pdata->mclk_name);
+
 	if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
 		pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
 	else
@@ -1905,7 +1907,10 @@ static int da7219_probe(struct snd_soc_component *component)
 	da7219_handle_pdata(component);
 
 	/* Check if MCLK provided */
-	da7219->mclk = devm_clk_get(component->dev, "mclk");
+	if (da7219->pdata->mclk_name)
+		da7219->mclk = clk_get(NULL, da7219->pdata->mclk_name);
+	if (!da7219->mclk)
+		da7219->mclk = devm_clk_get(codec->dev, "mclk");
 	if (IS_ERR(da7219->mclk)) {
 		if (PTR_ERR(da7219->mclk) != -ENOENT) {
 			ret = PTR_ERR(da7219->mclk);
-- 
1.9.1
