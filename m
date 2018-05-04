Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeEDIiC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:38:02 -0400
Received: from mail-bl2nam02on0075.outbound.protection.outlook.com ([104.47.38.75]:58272
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751508AbeEDIh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:37:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] ACPI: APD: Add AMD misc clock handler support
Date: Fri,  4 May 2018 16:34:44 +0800
Message-Id: <1525422930-27826-2-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525422930-27826-1-git-send-email-akshu.agrawal@amd.com>
References: <1525422930-27826-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::18) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:Hyx5K0U3w2Bfjolr+LNLa7QECe/q4a/GcF494vu9pI1QHsMQNneRvFbscrMdl1NZY1HA2OuY1O3dphCxE82io/Lscb9ImnI63JM50Xl5SJITQTxe0oyS7/7pnfxEJWXxC94Xk58gEr5DJIFd9xoRmWkLhYjg8FPEfknWxD2sGtP4q6ZITcwLklq4f0kIOCj4CGrU45YCJ+8fy+LovbcZhX3EG/ngG7DFzFmE+ibHt45jyjUzVve/AVxdPzbPbSEu;25:AP/9/XO+/GFXNUjNYUZPPnDML0JuStyiRQpFqvHUVFj254kpMIncF2tjiEHDiRhEzTtbk3GqzK+iwrBny/FAZxW0T4c99Tlf0eIIzYMfhMwMEBtcAs8DY5n8b6IWFtlZ0UDkWZ5eT6GdoZrJJYj5Gob18OcHUV3h8tll/iDF68F5vSjCXnPT+FnqKtL67n6qpqzkSrjZtn6TlDPrEW3EUxbS/HfbB186v1wEfmiyRT6S2cHDslpiq8kZbDl3taC/ChgEJwu3zDaKQM+KafBkjnGmbO8YX/6FrRMBRZPH1LhjpgB++3uYvPvhx17Wc9Fl3oDa76gLE+lEjdOXUJTlmA==;31:NH4Ra4EsuuY7hH7br2lzLa2Nn4SKn6i+YDWQfRaHcKjVitmsvHuRoIi1MBayc7hMmnWrZ4XDo+gHgfK6cONHyynC6ASF6uvrVS3Y8BwBDoDIPImsr7CLm9vQPnJCI/IyVXxg8sVOaOftfOSQ7l3YoV15A8WjaV0oE+Uqb6tv2Ks92QB5BT9gIYhi8D3F3E+kyJIubMW0xgmqaE1VDsp5TyhGwtTgPStChmFOmIAw4ts=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:tQJzYiaTqO0lU1qtQkWQ3Yuf5ZlujjKqZ5Qj0goXJeMdRKnmIDW0FRTAvs1XtQ7PW3NHiO2oPsoGQvoExvxev9ZIP05f903W7XXnG4CLbcsECUt31PsdGoDJTEN+7b2NhZLtWv33BIvEe4bb1LABphczcZQFYxWRC9JeJxqMIHnTSd9Ps+VUy/2QMoFKb5AX80MG2Pv6l0aJxwePJsFKPaCNP+AkbXCabg8HXCCSSEiWpnLDUJCaABD/h77EPzylPJdCDvuWdpDjZA55FJfASxpQvwDHHT/xH+9vhQOIejROrhay+WkPy1silwvEGDVAsYIGmit8nyRu1QcpV/mEj2oE2rDsAg79DP1+gxqvn41ql4INEZGHFGCHVgK34/3aX8Z1SMhHPTLRJB1CwDJsTR783lqLnomaiwaq2pKrdeNr1ZedzrFbkA69WUsvYh02TFIWldYb4lfR9ndwz3kusg6XuaJCpLPwnygTobixAXn42f3iIQfsAdtsmtkthbEA;4:OLQ7gYL6Sft8CJGlAXUpb7wDFNHtrBSGt+f3eml/kILH9vmDT8zOEMZJ3x6PpWwxu5tVNfFRx5nFqU6ZAmDbxPx9bdHlvlvoP6kGo1hgqczfvJ/5D+lCuy2HEh9vl6KzJSn3vcG4v2RCe9c2MySPWYhy7Jq6EZng9qKp2Hv5GaeKID7X5tFZoKBrqDtJ7mzROQBzTuoJ1LBhMYLuPQxt7xgyk5eVol0KreaBmpC2ixxRK4wcDn0TNH6DNcyhvGBiVc63zm4HlCwc0YBCI57fnPMoIGE7hOAF56VbiFAhNnNG4+7ZYqBte8S7EK/nl0snlt2tWbjvB+WWOMudNLZsYQ==
X-Microsoft-Antispam-PRVS: <DM5PR12MB2359D00B2580A9EC1C724905F8860@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(366004)(39860400002)(376002)(189003)(199004)(305945005)(5660300001)(109986005)(7736002)(97736004)(4326008)(36756003)(106356001)(53416004)(105586002)(50226002)(81166006)(8676002)(81156014)(575784001)(66066001)(54906003)(16526019)(50466002)(478600001)(1671002)(316002)(69596002)(86362001)(186003)(26005)(47776003)(16586007)(25786009)(48376002)(446003)(6506007)(52116002)(11346002)(76176011)(2906002)(44832011)(59450400001)(68736007)(72206003)(2616005)(476003)(386003)(956004)(51416003)(6116002)(486006)(53936002)(8936002)(3846002)(6666003)(6512007)(6486002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2359;23:F2OUUufFp8F11+6ou4NOmcgLs4AtO9eesphH8Uc9p?=
 =?us-ascii?Q?t4o9J4h59BvGB22PRXYq/QiiROJjFhpqTrPYN/Gcggftx56FwTxiXLsMVQkM?=
 =?us-ascii?Q?1uqUAXwT2DRPrOCpZFm4XjfXRxClPiVitR6k9w2xorUrqEBjNCmbBVMuMnxK?=
 =?us-ascii?Q?U4ccU/kwndBa5Wio3QM4A/PBE+ZysdQUVvqcyZmjsR/lOGl+J7Lku1fMtxip?=
 =?us-ascii?Q?788JJ9m1OdBJsky3009WPD9OtNUT1RhDhx1KEhsj0OlmKnUX9dMFluO3h3YM?=
 =?us-ascii?Q?DNS7WUtLMZZaHr6Lgn/mm+WopcPMDpeyT7iwTgsoa+dqHZGF2+bQazABoe2Q?=
 =?us-ascii?Q?DfS1xSTemTE6gXgRNalSccerC4ypzdaCMTVVu4S5whMcXdrZickW+GzwpKx5?=
 =?us-ascii?Q?06t9gahnUEbkHIp6c9q5zFdEwRr7iimjZSdxaSSSf4IOFIKeO+H9Xt5MHQDV?=
 =?us-ascii?Q?igzkJUIUDrcNrEVjpUifaGgNgQYC/zsB6km1SGAGXd82osa8hzSCKTX1wy4k?=
 =?us-ascii?Q?RxRuM4alCMSLLlnEbeThgDhPBUqJrmBRTnGOaTQfjWfpC7BVuzeUKBFRGKA+?=
 =?us-ascii?Q?fwXaNjowPKOeTaGz8xrBAwVqzmMND5UyBfUxH4gXUnL4JEUKR6SRp5PBYEAS?=
 =?us-ascii?Q?ldFiuusg3VxaXbHQAMypnYlT7pT8su6pq6zfvPt8Q8sYdpejEecublQep04D?=
 =?us-ascii?Q?pN9O7UihDj++ni+f+haFxp6meSuDecBHMgLjZ5HX0m+cuFYh0fsSuFNYaSkT?=
 =?us-ascii?Q?sVuLUX/pgPAOMT/dDiXfyXF9tgBh4UVN9taREHJNG/6El9DeltK+MnQvzJGC?=
 =?us-ascii?Q?lDCivR7XKuiu6jcvAoz0hOttCdoxJbhRYfUWHvHhnmnWyjxA/pj2inovWiHr?=
 =?us-ascii?Q?0TX6AvxzQjvdcW939NAyHRATLITORErgb/kEypIQ/N9kIqsWLJxXOQTR4aw3?=
 =?us-ascii?Q?2M8TXS7yoIQ27MU9QIVOZN0/1K+gtTROOWVJXrBgWxDpYbrsBuNtG64zFluO?=
 =?us-ascii?Q?ri+vjZ1IGPvk2ppCQDE3poxyeVBWj2MqrVYuaxjCvYMLHkA3lV4NXAB2jjs0?=
 =?us-ascii?Q?ZcdrqCc+a3Z3JjTve0YZehPh8V95BDSuVpCRcyDjZkSzdqhnyBHmfrO3jeZw?=
 =?us-ascii?Q?uGgctgC7bjrw7RQBqZ7aJY5L89H26KVXNFFTZjlq+obESt9DA+pY6MCz4kLd?=
 =?us-ascii?Q?lbNpI3z/6A0fMw4UQNZqZt0SDfvDv2QaMFANEjBhtTPwy5nNMHAKdSHnRiOT?=
 =?us-ascii?Q?G/jj1A9CpE42dn+MYjDq9D0Tjr//vXczn2IhtMEcOoaY4mwEhUyqozFPGcxb?=
 =?us-ascii?Q?4CHrTFO6kaRh1pdF0a8zkUwaVcJRlVqYNfz+J3ZVHk1PwqY7FXyQLTu4CfUZ?=
 =?us-ascii?Q?V8g6/JNnW1yvd2CkX4q6YEevLc=3D?=
X-Microsoft-Antispam-Message-Info: 7tUjrfjArnJVKSEZePsZsmLboQQu0uSr6aqOM6pdnA3EJW3nLtZFEF1Eq1IHN8Xx4IwWii3J9rNWEBoYv+SNuJ+0EcxwKa18zMbHWCKALOKjMQE9S65df2neJCtPDF14qv4W9Pzb59kVti8C7GTZQH3cht8tCFLn7VIQVGFk+BA9Q2TUCBi8JXri2iXl8Zzs
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:0d5q3Cbe7/lUCJYL6uvPPnoSp/fGERO0oZ9MN63VN4LM5rMmp5sQNnmK5U/0oeYAB7JfjCwhd9gLP3Va25r9B3AMmpt1IuL5Ei9tmvU4qFnOFVUY6EWZJAcGJBo5jmtGYFj7o27h3OSY8WmUTdKry1i2ZogoJBPILRJf0Q09gmEYmrrE6AzrVFBJ8gwWQwuoyUol5yXsq1W/ZZ9ex5pnqMu6u8K/YJMyG3Pk/Km8N/sSYm82UQBotUKG46uWVyMyBvAe79SEHJv4fWHNV+H4mlwkjsGDRZdkebqhgbLakPhdN1cnlYuJkRCk7yHKuyg6dDVQ2iab3LYOu0X/n9OVABPl6RL+BxZKbT3u60mGW6uCoMdYmDuLNwCDT2hDjiELooBy92L8Fbw7sGE2OxuFPZGYeySMTKGj/Njbq1GLRpKxBF+YOK6CzoOvjAKEAH7c5h7jxLa8Q9VYfLDwZKSS4Q==;5:4F4GK+I94O1At0aYr9BCLpd75BOAsQZOrnZdI6zwNFxgXvkynyvlnK4vcNxLq+HgAQ85o9Su0eOO4xU9qhTb+bcVGLH9E2EDM9HKIgxbxJIhvmYqhHT6HUHvdvdrUcc4xKKSFAVwuE/WsXQc+NirwmNP6FXC2frhIKyb0fuDrEw=;24:bhG6dqZxoJ+93DER4D+5OINa0qfbcHKo78LRb15x6oXGVvgG8MGGuvXnKJKT0er6rq754FWqG7bs65uZGfTzi6jdUE44M25+whK5qPUCJfo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;7:CLacTsLKnRNZeTTGbHBdumrG9xtR/gB1NVRYpabvj5N2quF5PwwWLDLVRXOD1jXmDT6vFKH/s44mMIpytfRdnngMJAHGXi7kHFb+YMdu6I8kSF98tnNeTuuQomdwXzx2oENZECtIrP2BNZfFTQZ+/fQ8gjopKMraCZHrZky/31/Kd4u8AIET6bE5m0PHDPRob6qXErJ7iLVOeRQxuG7hefdK5CORxpZ3cna1DR88NoOPOWG1OQK3P+J102WiaM01;20:kD9mNgG/XlFtuT73zfvsrmG8Y05pxqzQFIvDaoCzB2ws0YHqNQbMLys2t9wG4TXXlOz+ItgqjVawPPRakaBCpgsgxedl+/yP1tI2Jm0rWAht9Xn7L9aF11zsfrrup6o8/Zirptuk4W+sNyMqgrK8pHcgmPkVfH4VvJtnQFwRLyFxWK5i6QiI0Hj/5mVtXDDPUMUwJa6ZZJ/ypVZkUl1WBarIuLxTUpJ36pcFyy5Li9d/FZegEn4Iy89rQiY8+7In
X-MS-Office365-Filtering-Correlation-Id: f6372343-8816-4006-a4a9-08d5b19a5423
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 08:37:51.4525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6372343-8816-4006-a4a9-08d5b19a5423
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SoC exposes clock for general purpose use. The clock registration
is done in clk-st driver. The MMIO mapping are passed on to the
clock driver for accessing the registers.
The misc clock handler will create MMIO mappings to access the
clock registers and enable the clock driver to expose the clock
for use of drivers which will connect to it.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Submitted with dependent patch, removed unneeded kfree for devm_kzalloc
 drivers/acpi/acpi_apd.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index d553b00..88b8a3e 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/platform_data/clk-st.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/clkdev.h>
@@ -72,6 +73,50 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 }
 
 #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
+
+static int misc_check_res(struct acpi_resource *ares, void *data)
+{
+	struct resource res;
+
+	return !acpi_dev_resource_memory(ares, &res);
+}
+
+static int st_misc_setup(struct apd_private_data *pdata)
+{
+	struct acpi_device *adev = pdata->adev;
+	struct platform_device *clkdev;
+	struct st_clk_data *clk_data;
+	struct resource_entry *rentry;
+	struct list_head resource_list;
+	int ret;
+
+	clk_data = devm_kzalloc(&adev->dev, sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list, misc_check_res,
+				     NULL);
+	if (ret < 0)
+		return -ENOMEM;
+
+	list_for_each_entry(rentry, &resource_list, node) {
+		clk_data->base = ioremap(rentry->res->start,
+					 resource_size(rentry->res));
+		break;
+	}
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	clkdev = platform_device_register_data(&adev->dev, "clk-st",
+					       PLATFORM_DEVID_NONE, clk_data,
+					       sizeof(*clk_data));
+	if (IS_ERR(clkdev))
+		return PTR_ERR(clkdev);
+
+	return 0;
+}
+
 static const struct apd_device_desc cz_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 133000000,
@@ -94,6 +139,10 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 	.fixed_clk_rate = 48000000,
 	.properties = uart_properties,
 };
+
+static const struct apd_device_desc st_misc_desc = {
+	.setup = st_misc_setup,
+};
 #endif
 
 #ifdef CONFIG_ARM64
@@ -179,6 +228,7 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 	{ "AMD0020", APD_ADDR(cz_uart_desc) },
 	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
 	{ "AMD0030", },
+	{ "AMD0040", APD_ADDR(st_misc_desc)},
 #endif
 #ifdef CONFIG_ARM64
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
-- 
1.9.1
