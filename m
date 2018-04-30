Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeD3JZY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:25:24 -0400
Received: from mail-sn1nam02on0081.outbound.protection.outlook.com ([104.47.36.81]:55867
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752285AbeD3JZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:25:23 -0400
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
Subject: [PATCH v2] ASoC: da7219: read fmw property to get mclk for non-dts systems
Date: Mon, 30 Apr 2018 17:23:22 +0800
Message-Id: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::15) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:ebul0DylhSQR1Z9I0PK+r6r1wEdqck0kl1a84E6mllqCooaM08LcJikV6TBOFXiSLAfGl4bWe6EWvIRaY0V78U7nDpWqOFqWje8v0z6tP3AjVxb8LWd91TaV69TEKMF/zn09cFFZkjWStpiO3bqh+DGLcIE7Yl2QWszVopyIQwhHKR1lrSv+hshNSoQL54sg5hclJ+VRPuHWIdp5H5MiXoGNlb8A69qv6lMU5nzVldIXorgF9d5wOV1lMzr1V5g1;25:t7eGosVmotQguLdMunNxPpGJOikX7Vg+R88FRVx/RnuJfPGDdLheUgbkzIpmIpIygmEB0Pjk6swRzTkvPUatzq2Oe72bQY6E8CQbOXNFmF6ar6XIRy/WvVjJ6xZnsbkU3RjCuyeYUYCJff37x7pWB5d3/0l9bYFXeoek/wNdsZj4TJR7BByqqs0N6V+pPCbOIbUr2lzstUEWdkz71ycfoAfG0SWJefphd+XK0s4q69torNZa74vGg19kEtsSNW5pInBluFzd3OgJjUDV5EYD89p/ajaX99W1xKYjcPyhyeXP9q+8H/5OujwlOnwDPkepJQqSgYNoMzpgsuPKrRtDPw==;31:EGLYskQNkdwkfJdo8ZLpL1gaPWfuQzsb2ii1MxHFA8acZmYC6OpoRbaZYG+lCxvkDNpM6DMQ6byEivJH2Yr2jV0u4HRI/7c1pmOBcArAyb3uWL4vb84r+jKFfI4f/P+ZPCQUr7FS3EV6CmItxnZdYJIbEHgrBR27c5aN86Wk2AZHMvbCEsAun21ZgjHsKNdLIerhidIBz1OvUsjhwKAmxCAuzG8LHxMxc2lpXssWqyE=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:GYYNCyDvsEDRttEgb8fv5cYijaSPzOpBNxhBsRTIegGj+TVE8n53EuVg3/UIKEt6tF+LEpAbQLCB3nV1+sdtXWISdRtD/Q/W2XXoogJTpaTO9KjXA0R7MJwizoy9KrbVJsbXO617DSEkl5p10QYhy/iR3XBWdIyWbhhPhqL0LGesEfXakj5T+sq/TnMJ1/XbzkSbg4rLfuKXYBihCpO20M8Oo1pusRhGz0GKLWLRQBGM/+Hy2d9KQiL+NY8sIGaAJJWZ29IhppdxLo6jnTMve4M3DQieOi5UpsgNRPSS5kSbk42QtzeXCoHHBy5LhBKSlRDsHaUs0YCMbQ+DbWuzuaz78kEYxX/WLubet54OQitlPXCLQgbx0JHXzJ/fLsJIk26bAKTztTAr1tSnVFDSda4lTHHlQtBA3L/LLwoTgUcuJ7F+EunWyBpfe/qmgkd8Cs9dAhhdsYtTU9xjWgxi2sK0cXOz9PzZaH/nd7y21/D3dQXreVYV7erzu52jpqju;4:thk2IUXEVK+q7d2vopa3Q4bKUSVsTdEUcOoXebPuextGEafC054AsWoVP/X1Go8YHO2HLp99TfhNpdTGxLJ46TX0PTi31XxEZOKi5dM1m+62lfsSoTr6ptThR4mKDy8ggG+R4YCsWHgoIhtR1j5B1bxxwaqxgNkP9ujsC3QUlxlaVoWpZlE5bLo4rnoajwIHRlvks84NNERTc4b4yYL+w0ioNuL5iaUr1kk4vCTEBtNUcN7CEB6HlO7Ojtu2hmjaSdfwrrBN5xKsOJb3IeMe+y3MWh81zy43JCQJn6rFWfb6nO1RQHe+1tHP5BE6+DvS
X-Microsoft-Antispam-PRVS: <DM5PR12MB23596AB6D73692F7E1AF6803F8820@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(199004)(189003)(81156014)(72206003)(51416003)(52116002)(6486002)(97736004)(81166006)(478600001)(106356001)(486006)(186003)(5660300001)(25786009)(36756003)(59450400001)(47776003)(8936002)(50466002)(386003)(48376002)(39060400002)(6506007)(8676002)(1671002)(66066001)(69596002)(16586007)(3846002)(54906003)(53416004)(2906002)(16526019)(68736007)(6512007)(6116002)(53936002)(109986005)(316002)(26005)(44832011)(105586002)(7736002)(476003)(86362001)(2616005)(50226002)(305945005)(6666003)(4326008)(956004)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2359;23:8pm/BJ3vRg/QPR0ZgwiZUt6TPWc+9E2PWQ1xxNqot?=
 =?us-ascii?Q?sghF+QtVi+Dy1Ee7FXWIE7h/GlYqOHEe/AlX8PGOigjcfrsNVM4QWWT+b3kL?=
 =?us-ascii?Q?sjrLLx5g0k3W0MkUH69LoE7nfnrmF0AjqpK0l/dky3adhxig/hqmAd+Bce8W?=
 =?us-ascii?Q?xjVGfW2TvxGLQdxgwg3qO9zRkQYvHJOS3ThXkIlmhHfFUKS1wAC/HMWQmQdn?=
 =?us-ascii?Q?GDv7hS88hvoB/dT5S2OF1+1BXrENdCLN8nN7ZNd0URPrVnGBw2nN5sy9Asf8?=
 =?us-ascii?Q?j6FhJdAEYOiyxclndU0OVivtN9eOOsu1zSohIUTfrG6T+OLPq4/YkE4tWeze?=
 =?us-ascii?Q?k90zbHluJoqFm60NszT4Qy+daUTYSM3AoDoz86q9Ee7ZVSv7UKnS2Kzk3MwG?=
 =?us-ascii?Q?yQjD3TaH6XDJAIuKAhmLYcYD99Sv86VLTQQNWXfLK65TGIemMXoAhaucSCAJ?=
 =?us-ascii?Q?fwuG+KRy8QtvUlP97S4L5LmvEsd2LAMNIogyNboSv9Nu9KVEuX+MikYD2U9r?=
 =?us-ascii?Q?VCbafpdVDuCA5w1kuqlNJPF+8oEJtgeQR6P7UCd5r35FaWXPaZbF8mfomq0o?=
 =?us-ascii?Q?TDDSxKt/xDqCILwEOzTXuUoz5AIDnstnrMwvY1UQyTJkoiSK98LSrD/2nc+1?=
 =?us-ascii?Q?o9IAEUJA/tmlmxOgy6pyXodEKm0Qbn7zkNYgPjpaH455MEmFcVPlDbULA2B2?=
 =?us-ascii?Q?NpuafMRoVIAT3QzqdkGfJwmm9FEzlCbkYkQzhqrlTLPIRC2w4iJcF2AqZaY6?=
 =?us-ascii?Q?4hViRAxWy5nK4iVHWpG1csc4SMUoaljKnk6CmVrkuwrpzNj+wox7cYddMn8U?=
 =?us-ascii?Q?Klh3NxTKHcBffbmlc/Ozda2mgJ2wKU7nHYM2qOm++/eRjJiUx4XmA81cQdH1?=
 =?us-ascii?Q?lH3ymVcpp8nn+N/9dgW3HKe1MqSGxIOIIvMOqKq8pTjckM1escFch+9hV8TX?=
 =?us-ascii?Q?niUmcHgWB54Dt6N5/tPo+i+T0uCDI0adAMbcfHoqRcgpH6V4GkpjqBcWpihA?=
 =?us-ascii?Q?zZf8izBJ6gb5zBPuTDI6JvwyFVLu4hitAWw1lAno6o1OlKD+OiwmZlLCa+AT?=
 =?us-ascii?Q?hJZ2jW4qgTV6qbwseFOod3h07+pyb2RxZrSFaFD+NX7Z3JvAlBkJDxvhil2m?=
 =?us-ascii?Q?4pfu47Mo0HyusQfbDdri1lzD9KZogoVwaFHXsMcqcZb0cX2Q+GOsec1lRhuE?=
 =?us-ascii?Q?FBV8QSnfj0PA8soLrfYYfz50y05d+f8P99VQlhu5L39yXnJGvyXyqlpQxK5B?=
 =?us-ascii?Q?tnPnY9HrAV9bCEFJqaLjuql9unLUEuO+BUgG3mRxEm+rhZjVokZNvuMWoXGz?=
 =?us-ascii?Q?TiI8JcyWBL5BefcCb+5kl8=3D?=
X-Microsoft-Antispam-Message-Info: iJuP0qXNQboMKKcetBn/aLGktLakzXXtsEm+YU9sOrqwlDFeC9huXGdVrLtJcXSFoMGoO87hsr5ITfG0xlK+yzgJPtdRbVSmQA6K+WXJru8vx8BRERH14CQI5ZhtBpS21QdCElStabemBZirGkTh5blkarM0eAY7PjDc9QRHYoqpJXD4Y/mMwR7CQc0R8/GK
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:UdmIKqtFQ/66fNyQUZofACu4iP2d3QE13Vaz+Yqhg4fHCTZZEDRSJQmXOodWSwjY6fGKx0Ojhy89MKxZeyAx+Thb7AJBJ6fqWi8/7kM9h5PdIEkIzn8gI4wpeNP/RpS5WcNHYupBBl61Tbo0O+f1brfa43juvKAPVicYs5F3/cl20keZPzv6U9v1JtcuJ6tqo67U8xpffkQi3BmHzSlggQceFyHAXd70IT4tt+1HQP4gyr46YuZBk60qx6JfV3VQ2+yHhnxnNKaciR8eGzcuBt7k902PaquanHjk+KaEM1dicN3v2oLKOLkmt14DNiK6AKyHLPGeGcEkEaVjKu6pjC6axiafItHossA2fmF1kY63jn671znpNSPcph2L0QuLxdi4pdbXBzJQJDzrAYsRqiVYc9rL8b9QZOhDBoOZZqqT+xNfosMdZarYS7qCyt12DHt8+5RORag6p7rmXtNt+A==;5:mo+A+VJB96rnL+uwfgbDlIbd4fNy/tQccnlCfsZNZhnm1QN0WlvZW4b9ZE9ctbLdLG2xPOn6cRHuxttkH2CLhadXfgdMSSZ9goNVwnRBq4hMYrMY0Tra796rVSrSmXM41+M0j7KXdMQ13gKN8ygIFYWPZm/5ob52NVQbhYn9OB0=;24:jkM4CMZ1wFzu4fcLaDAkoDgBxH5m61JfqKg7vvmXdcvEksRparclGpK8dGzw3Eu4T2QWr4azFaRQ1SsQmZBzxQRxe9WB4tG+kHvZjnJcNNg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;7:dBmInY1tOzqXdK0qxtMyrpPqquyBgdy83TQzYo5vM2JmNgeBY1+Y08Fx5QSfpcrhU3WCmcovcf5y0t9sKo8AJaGW2Pry46t/nCZL54Jv1fos+n5zjg2tuFbLFfoo4zlC2qenVAeSt3Sv1xqZMdzj6Kjix+Ce1n3VTrOJosbwUuzG64bkUJbsU5f8gIPJkB6AMD5wjhXoStRsqFM0XrqqGNwT9cRSwMpHLVNoo6+Jopg/NnVp0K2B7yMNe4+JTJwo;20:QDlg/FTxt/CkVJ2/9py7CbZAfJoe42b3W4iOsxFV79yV/jgR/zDvPzgeY6oVa/+parN/spZjDpxVAuTxnti6DoH3AmS87bKYWdrVQOwIzPYL8fC+CfnfWdUSUwI8UDIsOpqGpESAR/b+7pBIOk1m1dnEH4CzzmEvM8KTVnAfhCJxxR/8hPIvSDIqcGg+iJjS41E3iwWu45l0iSbhuBBJxys4jYpmisIOu8ML0/8BH8HOnuwC4cgOvF4E+eAO3bKW
X-MS-Office365-Filtering-Correlation-Id: 3685fcec-1263-4269-5ef5-08d5ae7c4b26
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 09:25:16.9182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3685fcec-1263-4269-5ef5-08d5ae7c4b26
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
v2: Fixed kbuild error
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
index 980a6a8..aed68a4 100644
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
+		da7219->mclk = devm_clk_get(component->dev, "mclk");
 	if (IS_ERR(da7219->mclk)) {
 		if (PTR_ERR(da7219->mclk) != -ENOENT) {
 			ret = PTR_ERR(da7219->mclk);
-- 
1.9.1
