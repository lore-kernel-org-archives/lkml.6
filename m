Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeB1KxJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:53:09 -0500
Received: from mail-by2nam03on0060.outbound.protection.outlook.com ([104.47.42.60]:22688
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752473AbeB1KxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:53:07 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jayachandran.Nair@cavium.com;
From: Jayachandran C <jnair@caviumnetworks.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: Fu Wei <fu.wei@linaro.org>, linux-kernel@vger.kernel.org,
        Jayachandran C <jnair@caviumnetworks.com>
Subject: [PATCH] watchdog: sbsa: use 32-bit read for WCV
Date: Wed, 28 Feb 2018 02:52:20 -0800
Message-Id: <1519815140-5336-1-git-send-email-jnair@caviumnetworks.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM3PR12CA0063.namprd12.prod.outlook.com (10.161.151.31) To
 CO2PR07MB667.namprd07.prod.outlook.com (10.141.227.25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6483cdd7-6dd6-447c-5ffe-08d57e9970f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CO2PR07MB667;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB667;3:YWQX7pDqhBPUWOBW/WYpbA336UoQMuOJdh+0HOClAxzlf9B5qWDMQTFOqGCp7U75jt1jXHyS61dqq5wO50lokQ8g5LDuXzBNBFUbs7ZnTh+IQ+nrOcJUko8Zo9hmqZeZ4p+HZc+5l593ySeReLXwpWLsMeVBkPgw9E5mdWuQwButnIuoV9ew8M8XH2nG6C5VkF+COajLNi8AEN4dEALy5oAnQPiNmL7FKO4yXERs0vcMWnhuXtiQFgVqE0eKvrhB;25:Psk8YTccKzz7zAwa02cY9R3MlXdjQxU4UeXmsmW8ednp2vv6QtEhkp1QM5GGoPcQjiPOneaza8GWzS4x0cBi2HXvlUpvYtmztYqOyTqh1W4p4Mm+/ygW3Pl8z9zKvewmIjPypO0si7CsbM5t9bKOS5SEiUXVJxO0cbv/lE/07vQSXoC2gTgHoK+r9yJXUmgbjUXNpsLIkt9THYKiFiq6IdO1IWWvGOq4cclQezLEQCEfft//LoN911mPZVLWO8ngpQGJx9KaSDD8r8EdZw1Ld2Ex9BH8q51T1XdYaNO4CtZFEa2EYq2XR0Jnt3AM88T3PQeQI8CEOS/w6hdBexmZf2J9K6nJM1thXxJM4zlr7TU=;31:uD5WhDvoZGmeafjGCg3bft38MazWWUUGiAAfxHA7y/+a483tmpOtzri2PQiL3/TPI4seHo0g7fNaUROiz6ioUUVtY3N7s2qbKtfuYo2HL3sqc98y7C6J58ue08+qrln+0pDIzQjWQwCISrL2lMgEE+jub15n3dsHXooQ46Zzp8VE54Vp5YtjwX/pQb4/rbqDV2OdKu8C2VLsQhInnvkSgnI1bO0HCcXspBixomg/6nQ=
X-MS-TrafficTypeDiagnostic: CO2PR07MB667:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB667;20:+6evF7ZNjziY4qn7HA514p+Cx77CsiaBMpPqeD4j8GqPqj3BkoV1c+LniSH23kLW+9i3YXLmL6+nSQ79Bkqd/2Mlb6baRiHDiRL62SlG5tfCRQZlXUk0WNR80KJz4zhRfHAFSglaPpIzDS2GTuhtZ/TR36lLwDw0wResWEKqyP9slFA1cLbLDNIe4XsictxejVpxjWPTunjkyHO5PRM4x+lxMxjVItKUU8e1jI1Uu0Lp5dBqwzN0DA/2B1kMvhZltWQS9F04FW+mQZGcsJyZiyUl1Xy3AtQFa5OyGO/83RaaGHjmYr63pNg7HOquN5iML2hWhQuhFymGle4aZakdGR7k7qKiRVauaJeatw8F2jNvIkB1T+GOWbWxqAM4JaoH7nAuCBaheT1aX8WNvpNVi6yNM5vSk1Q0EEggmN3xYBk2cKzq+515tznQvSjSCDOQ/IZppPUyuKfyAxEi0gfL89owXIIj4DnobcJYyyKFLtZFEqnGdiDLEpyTaM5gKsgpPUsv4iRDF2SYsK0Ai3FDK0yrCWQrsq+l/i0wQoED6+pHDdebP2k71QEhlwxeVzRxQk6gXN8ZZkVWikAa3yolejBDnoJYcA4wYWej3xSkchk=;4:2mOtierfnHz9PjvAUEyCebNuq5kSfY4klgOr2fe/u5e2uYUAUIh8zR6sE8/e2RYUE7PZsmC+0j1DoafNHKEP+xBzmHF459QRztUxMolIh5MR61YjZSYbEblEWkP4JLN2Bi3D452tBLLpMbDusHgOoj5CeI5GrzxH8w5rMuDJRW8xudf3R5OgkGHn4ozmsqBO87UyfvM9LF9/AB8Po8AvilxUrLC7N4+GzJ3oPeaNsGo+Arl+6M26DSaexigxzr0ib+N4DJVHY46H7CDp/MbljA==
X-Microsoft-Antispam-PRVS: <CO2PR07MB66786C26E25E150D6BC378784C70@CO2PR07MB667.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501217)(52105095)(10201501046)(3002001)(93006095)(6041288)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO2PR07MB667;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB667;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(186003)(107886003)(386003)(3846002)(53936002)(16526019)(47776003)(53416004)(6666003)(66066001)(105586002)(6506007)(59450400001)(1857600001)(106356001)(26005)(52116002)(69596002)(54906003)(68736007)(8676002)(72206003)(48376002)(305945005)(51416003)(16586007)(81156014)(25786009)(4326008)(81166006)(478600001)(50466002)(50226002)(316002)(8936002)(6512007)(6486002)(2906002)(36756003)(5660300001)(110136005)(6116002)(42882007)(7736002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB667;H:jc-sabre.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR07MB667;23:PrNKbmJv9WixPEp++a0HtUqfBr0Yr2sgTPd3bdV7Qm?=
 =?us-ascii?Q?/fpOYrcrtiEznnLN/Wn0NVpMHad76pVBnCD4rql+iGiPut6HYgBltB4LUt2R?=
 =?us-ascii?Q?vqKFPk1PS38hFghLBakBq39yV2LbOF0B/x3wDhviL+pirBiM/u2mSDU7+ZG5?=
 =?us-ascii?Q?2eWlpC33nX/YNg/bHrAkPlwE0u6W3SnkpB8YTaNo2JZ2OUv70VRt+9uoA1Du?=
 =?us-ascii?Q?x5lrXpFiHztMvuBk4rRNmPQ81PuHDHeJX9zdKGszZoUWc7+Lg4QAZGcDsgtG?=
 =?us-ascii?Q?NMioseAWBVQMdT8yo80DVUhfJ19BvlDO0gaoeTDKXIZFRZjnGefseWTib+LH?=
 =?us-ascii?Q?FvUmb2obz94ARE82Dlvq2NtghdQ64iu3kGSe78tJD0EsFwQsUS6kovW5A/Ux?=
 =?us-ascii?Q?RCQBINHZkU16ywJ3BNc7Ea4dqKyppnIGsml4yktUrDba0/0f9phInVQbXqFH?=
 =?us-ascii?Q?w+Hf7e59Ra/CiiaeEU25fBDJlLLysEA0MjNP24FJaF45Nw9id3XtPZbJE2vy?=
 =?us-ascii?Q?nZBKFLczVIkTKiF+aQOL5UpPitDKqi3Zp5gvsvpK/FIRqB3pgwM61jkjpT4J?=
 =?us-ascii?Q?S5CYeLX0cXfJhiKpmTRQoux3Wm+rsiP2MRRzUDvURXUcEoCdNRwHYE79xDXj?=
 =?us-ascii?Q?/zuCV4T1Nb61QAuklLU+O4EJ5mrTVcb0yy9d3Qef/fKmN5zpzEyZT8ZWlmIy?=
 =?us-ascii?Q?irM6WDW1bymqFUpeqOKIsEjAhpJRRzkJA0YKCMVZHpJxP0flub4G6V4Sf8Y6?=
 =?us-ascii?Q?+ikT6hVCWTzn8Lb2pv6X3KDxN58EyKgpf8iJFjlnDVDi4UnBKkcM5Ee//7ML?=
 =?us-ascii?Q?dKS+ZEP2JUXuyM/ofYcdjJEOFCF1nAO8jRy/4aKjkD6CK6ax8DACQaLdFhms?=
 =?us-ascii?Q?0qaOn1cAERnlfgHmhxVhhECPMgSUGvbYl1+sR36CMeqk9j5pCsGfuvSwJaWD?=
 =?us-ascii?Q?fQPh35hyB+ZxzqOg4/4W+aVrluJi65aQAK72MIP/+Q+X2IqbeRwiKJQmVfss?=
 =?us-ascii?Q?pVkjDCIyqWcCA/rUerWQF3y7OpaWANiOp1neACMy2lcvTTMilq1PUF0g/EEl?=
 =?us-ascii?Q?NjkHJh6fBZX57jE512YCdU8ofGl4oV8CVvyWjqBiFxBt+T8mHO1ETUiDpuEJ?=
 =?us-ascii?Q?U9dnDY31TFKonXabCTqICAlbb5yqKXPNMhde4jznzaVp/gTem2RDaMXW8fx1?=
 =?us-ascii?Q?M+Kpzu9ZK1fM4Bai8sa1pHrpF9l6J/Lv/8?=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB667;6:Q/ZwOu97oL52eiwpOAGZR3/VVuos+qfP1F9XeFDf1g3o+HAEvlk5X+YUqaVBcbYEqCPjg94AjDegUCpRqct1cIqDZsOIaeoB4RU4KlAVRErAKUPa3qWkQQ86ZamY8+J8LYFdNzfyoDULSuiK6NtWou0ONn/u9UDpxWcYw28PvTL7amLlEla8QElQIMJeHP+d4rq1d9VDf5i5g95glU/moam7aMkec2ybvdxaQHVwSQqAv2UKcKN+GgzF4ZhTX1mCL7h+wCvHG5PpKuOKdn0GLB0nHhYbkVBT35qfUX5JnJZvmemSkn1/i5rtfLlwn3TXXwmZuDC30kvaGpnUlkl+kP33It0tjArykA9PV6/pHHo=;5:3AvuzXn7cVen88H9bOHnKFpD+unyr2d2lfbGDGY9JH1Mcy4Z8gV56Y9DCx/69WARs3Q3GJSJBfplURKKHkcD+Bz3x/9StBW/ERNhNkKIsE/3fI37sWoIJWHmLe1cDRrPSDO+VYisAVoaRLx7fup+XhRS2rImWzoqXmDcImB6nT4=;24:rJMa19O229GavQffKdX6RwrR2dEqIM+fMPm1yOaaaXc7K1Aspj+zmcqN4js07WEPTo6s6wl9DzAIavQBOlvkPx0fB+7HIF4jIB+jsfetaes=;7:CvmNy2/bphxZUy/mXcF0lATl+gXlmsqhvwbgLOqWllGohnSO/zeTKmwZTXZwAQ12T4w530Yvd91efEHzlpLY2lavzRRW1kxew/mO+Q/C/G6HdPfZ1vcCEOICoNVky3dO9DjVun963Ikth1/AnbmirYQ0SITAPYc6yXlf/tpt2AqaHf3DPwyKOthziLWe9FLNf5HHcuRjqGH4SAOGQ9pDacQbWtzofttFFWGngJ4TySHIPaI+tFI0UtWScZjXnsNX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 10:53:02.6208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6483cdd7-6dd6-447c-5ffe-08d57e9970f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB667
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to SBSA spec v3.1 section 5.3:
  All registers are 32 bits in size and should be accessed using
  32-bit reads and writes. If an access size other than 32 bits
  is used then the results are IMPLEMENTATION DEFINED.
  [...]
  The Generic Watchdog is little-endian

The current code uses readq to read the watchdog compare register
which does a 64-bit access. This fails on ThunderX2 which does not
implement 64-bit access to this register.

Fix this by using lo_hi_readq() that does two 32-bit reads.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 drivers/watchdog/sbsa_gwdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 316c2eb..e8bd988 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -50,6 +50,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -159,7 +160,7 @@ static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
 	    !(readl(gwdt->control_base + SBSA_GWDT_WCS) & SBSA_GWDT_WCS_WS0))
 		timeleft += readl(gwdt->control_base + SBSA_GWDT_WOR);
 
-	timeleft += readq(gwdt->control_base + SBSA_GWDT_WCV) -
+	timeleft += lo_hi_readq(gwdt->control_base + SBSA_GWDT_WCV) -
 		    arch_counter_get_cntvct();
 
 	do_div(timeleft, gwdt->clk);
-- 
2.7.4
