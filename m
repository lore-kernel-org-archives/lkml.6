Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeEQHbT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:31:19 -0400
Received: from mail-db5eur01on0088.outbound.protection.outlook.com ([104.47.2.88]:62368
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752405AbeEQHbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:31:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: Linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regulator: pfuze100: add .is_enable() for pfuze100_swb_regulator_ops
Date: Thu, 17 May 2018 15:27:22 +0800
Message-Id: <1526542042-28485-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526542042-28485-1-git-send-email-Anson.Huang@nxp.com>
References: <1526542042-28485-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To HE1PR04MB1322.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1322;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;3:+Uo95TfBWgWY4hC3vexaBuxJDmF1CVve1EvN6bK7QXLJp4Cu3XE/2syyTjMHL8DRwaI5dsPSu6KCzTTJoc4K2o8sLN63bW9Plf3mR52kGgNQYaA8fk0FKduG09BmiFQuHCzYw5z17SRgIED9YhmGiHlCbrgSFGEOXsMh8crdjeMjGO97eTOtOaBxQeLQaGQWuqeZXhdqpqKVRCHO93l5NmeMND8wtimmKBlDMPuG2sf9tM/UELhhVPwxeCfnCx8Q;25:Iz5HbtJ0Q4k4xtxSHPk6XemzbKedM+dZvhW27dZQn881/PEstXmO3mvu6KHbEIZe7UBAukhhnMy1f8knuwAFNLn6Fy/BmBvzKuyklBOm90A94246t1erlaOUb+7PnOi5wrbZbspGchHeGREUpu7vxREdF9MOfVtJwmWQ19ZT6685/rL4j6JaD7IwbVHtTmYx+mve5qqxU7sUz0TImJemKWTfFGqTwHQ165ZVXx5ZbT00w2F7qjD2co90l22C318FSP9u4Us+w0VXuU5H2mOZVsXiIgymzbRURabiwFF3nHXwYx6n/rPw6iBK+62NT8/4lr67FnbRDV/otH2e1imJbA==;31:L3A2jNiEG4zGWj6t1wB3R6NP4Pl64rVCQW4e9faswMmqD2cjd46tXzMpDOZF6/pL7+7WdgJDfnUEc7E610vA1GLV89a05x0Sd8CsiRr7vHSIRmAbGX22zWtj1OxrnyErw9PP3tOO0NReteFWaj4cF9zRGMBx87I+vnuPXfLx6l36CbwRvGQFOAxAXXoiHvvYYtxKoaJLUZIpjMnLrbqw8gfuVQobpRd/8Cj98OYCyT8=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1322:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;20:XGuTZweTOLI/Fq/p++JtnYWVsOdZT1x6vVn3pGSMdo6xIyT3moaQaBL+DiIxT73OE92+fdP8U84uJDVKjoUpUz/NENdwM8ksldeoT9PO9y2Mf5IQmUr5aZh3YqimVu+oBsUu/KDoTQL3Q2BDw7peWL2AW8JCNO1I/fL428ucGEqzYwAEFUs/rWZJ+mLWzfZCYsLS8u/+PjpQKxXWAghMefNbrRqRVi9Uhh3JUHtCj/FTQj2gnbsDd9memuz8APc+EW1E5GnYx5FzPgfjYEFlqIjyFZmzoN/BAiJy52Ov7Lc5s3nZaJnlu9Igo0kViMmD+3+dk428AutPNCtM887mUv0b0g/MLjLYZAQ4Rw/UjXhtL+OvdVxEVt27g1eSYYP1nIzQXC1uKG/MZ/jbyr+dWtftyZPS8dKZNplyiOb6JlI0yLe4LFi6NwDKux8+7sKF3H2LmBW+1z2GBJOY9uG5GdBmbPGPPeMk1qXaWQeXqrkyj8OqU1mlz14jDplxbCiX;4:z/7s8Xd895E2ujLZYa0/Kdn6JlnE/2gyepPqo40gYD2AxlaBchNDJBaXEn6xHAejV+GtnV3SuzqiupYxO3+fhGC7LK0MppOwmujZB0Kj/slrDLePnvpRLntYScgr87/4wv2+rxaNVupQWRoV6k4fvI8Actvnfu74pX+XPold0VDu7+kV/g0eFhmayNvUS6LZkQepCb6s0EFEzArju+Bn6i5ljMEvIQAJqSjO7qqkvWfGzSLjKkFJYm9Bx3UrQ68nn2ZVony2eBAT29X76KPreQUT6eTAGe7jpGMjEnXQnoKTaIaX8Ren8eiTe0pkVkcO
X-Microsoft-Antispam-PRVS: <HE1PR04MB13226351C11FC8188B8A3ED3F5910@HE1PR04MB1322.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1322;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1322;
X-Forefront-PRVS: 067553F396
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(15760500003)(478600001)(446003)(25786009)(2906002)(39060400002)(76176011)(66066001)(36756003)(2616005)(6486002)(47776003)(68736007)(486006)(11346002)(6666003)(476003)(956004)(51416003)(86362001)(52116002)(50466002)(7736002)(316002)(16586007)(97736004)(106356001)(59450400001)(48376002)(3846002)(53936002)(6116002)(8676002)(105586002)(81156014)(6512007)(81166006)(50226002)(186003)(386003)(8936002)(305945005)(16526019)(5660300001)(26005)(6506007)(4326008)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1322;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1322;23:+LhxE/yL9nlAg/vL1IZ5XshKkNEb31KlzcHc4JLkt?=
 =?us-ascii?Q?rad+DaKvnc7qpJcvsp9QTdgvkfdhdvQ7yrcU2xR9RhzNtW6mQRh5gcGyPf37?=
 =?us-ascii?Q?9MYlNqjWyAPjH3mpKM1EAz+bintvpNxsjO9vzsp7HLGL9GrhRm6H6w11Ynxp?=
 =?us-ascii?Q?ugdzJUcCS7CUdHQKOU4FEK3cI3hW52DJTIpnBeqqg9IbcN9qGHP8Wd/ODHhg?=
 =?us-ascii?Q?dHrOVx2WZPMBnrxqo07Eoh73BnWHufChFgRZgQR/k3ZOIX5RlxCDo7V82jap?=
 =?us-ascii?Q?xyUKKSvrMgo2zmBa5gADNfKE8CdkD0F/v+U03NRyMvB8sNS5lCaKBQr/MV5u?=
 =?us-ascii?Q?YMSITkrBuMN+tWAlzqybIIuTTo9Kga1cGr7d148mGx2MnvZ3bbGSfbL9JZTI?=
 =?us-ascii?Q?q+BZLgSxOXsNX747U9kn9UlUD1q8U6z1XfFkrhRvckDplz+Ap9QQ8c9pFlGl?=
 =?us-ascii?Q?N5XlpIKtMCdX0ZUGLJ/LELaPw4hmWzu24AjOuxLIDVP/qVfeWLm96r2MKXej?=
 =?us-ascii?Q?OK3JMgzsQ8/QBHDWr1Cif1b7DJSvl1WQ0Fp3ob8B1oxE2f0/y6nZJJCrmU5g?=
 =?us-ascii?Q?MNN8B4qwG/x1lt1PxN2WPgbUqHvN4OygZncMg0I+YU9do/9StDOEf4790XHm?=
 =?us-ascii?Q?loAul8E1uLPb7SODI0qVwchwPUAMJ5lsxD9HPIT6PS7RLMnX+9h7gPk7KhB5?=
 =?us-ascii?Q?QD9CmQj1rZl3zl1NedDMWG0qsLXcE9cmPWFnZZfIY9umuFFn2LsdJ384LBgT?=
 =?us-ascii?Q?qAs4xMk2T9oZOlxR2qThSC3/Vxcge4BVdPQQCSrotRfrALo1G38tIWniJmCP?=
 =?us-ascii?Q?tQLehnhVgqtmcIFGvC6FM96I2rUtiQUCU9Guc8EiUiu547aR7lef5xEOB1uR?=
 =?us-ascii?Q?HcbbMZX7nkPpnu7pfokhYhTec+PJzIQEoKC8I0mDR3mzY8vbHbkufIe/w/90?=
 =?us-ascii?Q?FxrzDy7YGEg8cwgU0j09YPryrtxjVXQ71v4JLK4wYLyrcUp4a5G4WTp7xUFi?=
 =?us-ascii?Q?Z9+5kSkf1oGc7tz2H5wRvTuNYI8hjNyJLV/7A2AnA4LFXhNGO8OLhBtogcym?=
 =?us-ascii?Q?D95WLUZvmdkjiFuQKXiC2nFqxa+ZxdfR6fHpKnyaN4dUSrt+45+3GNpP3dHM?=
 =?us-ascii?Q?74ndiz+gwreH+fCr+ygYqlU3GtjRvXcpo4P9L4TFoXYWeRnAGgAH9yXdQnvc?=
 =?us-ascii?Q?lYBjt9ZpqJTjwcz+YUkGR+Non9UfmscFudpH5xFB2+igknmu2/i/0vw/Z8ug?=
 =?us-ascii?Q?5DzIApIWz89pXTpfP1+Xp/mTpXDapFrB7OcKH6C?=
X-Microsoft-Antispam-Message-Info: JV3ywpBfsiyp5nAc7creLBqf1FScPlwPXA0m9Dm/bqkLOtMvx+qLV+comEL0iMDh36R9bVpkYzUaeV3o2YGDVl1ldOAcG0v8GNCvs6ZnPd7e10ZjRILJ1iPgj5ocxJ7nuLbyy1ysjzmmpVPDHuJ+KFcK0/wsFQcpT/fzPwWe0pRyoQfPGGiZGuIZt4rg5LSk
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;6:WyE0qvoKx94q9gDRtDaNLCV2oJneHtfYuS6FT2XEoaazua/+6f+AhMHmYkmrswQWa4ghkxb2lA7F0CyiJD1V9Ba1/dVXnT/w96rSo27vxNPVsdIsKNh/TRgdOgReM9RgTBqpM6LtypXQj04SQSDAKBFzZxCFSIvp++AWPAEboQr/u/LUukG8mtWq1VE7KUqcrwRmI0VLVULl2FHuLIy+9E33eYjy0oqL45NCyA6E4fYB3YwaCJZSbmEPCOTGWkb0hP09onstnJ32qHZSNADjXjNupdfXrF1hAMPgamA+QQT1GO809blVd34fAM+fsOYUXKGHnx5pkHbk/+D82afpujSdHsYz6fGCOF4Gxxqj55XchacVeFvucg/8dEzsQrbVyCjRg/0081npigAMDIMJcO6SrvXQsbq0tmvCptQJBd3X8NSf/OV2hd9E9yQvZMz0iI+AjMD/mNYpgrYJuSKHuQ==;5:tMT5tKoo9ZcvaSLe+qDn6S06m4r+xMA3NgG6+/hZu+LfgXtMQ4PpiTpL3ChI2msJaLnxivTFdp4kn9AnQvdzQSsmhVglj/lktkuSaSCb4fgqJ3uoQiPMQoD3zAOfIO888z2B+CIvrtwmKnr+gYns6YXVdqcrqpd/Gp7s4CkKZ3I=;24:xyORnRDV/Zn6GRUxYNtxLDIRDbSCEpB4qGr53MMsGNBnHidZK8XFRPDoTylAe10rBzFeQOGJ4Ll7suBDDEhy5iRQ63aWlgmEXtKHG1dlZvs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;7:2WEHuO1BhZeYDXkqVChkn1LID7vsup8zheQDU93t/WhL0zPNscPkft7dwa6tgpDMiLi3ykTR8p3c1c2DOkF0ysTYMhQ1GUuskPN/Dm3xAqgEwfpGVl1c+8f2iZVn//Dt77e8DImzCbHFo1RC8Isr6HS/OMnESMAeIVED43HVsfhDm80ZuAYNdDtUIl2nSvIACZqTtIDYi2EFKMxALmR34/NcXoWLYykLVV/a/D3mG5BUWUArlhbHnNKTho7KgW97
X-MS-Office365-Filtering-Correlation-Id: 12f4a6a8-a043-4c86-e8f1-08d5bbc82290
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2018 07:30:57.4161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f4a6a8-a043-4c86-e8f1-08d5bbc82290
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1322
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If is_enabled() is not defined, regulator core will assume
this regulator is already enabled, then it can NOT be really
enabled after disabled.

Based on Li Jun's patch from the NXP kernel tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/regulator/pfuze100-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 053eb1e..677a070 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -168,6 +168,7 @@ static const struct regulator_ops pfuze100_sw_regulator_ops = {
 static const struct regulator_ops pfuze100_swb_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-- 
2.7.4
