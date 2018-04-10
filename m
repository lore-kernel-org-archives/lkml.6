Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeDJJv4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:51:56 -0400
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com ([104.47.32.74]:35280
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752016AbeDJJvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:51:54 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 3/3] adp5061: Add support for charging voltage limit enable
Date: Tue, 10 Apr 2018 12:51:42 +0300
Message-ID: <1523353902-23748-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522829896-8087-1-git-send-email-stefan.popa@analog.com>
References: <1522829896-8087-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39380400002)(39860400002)(2980300002)(438002)(199004)(189003)(50944005)(54906003)(246002)(316002)(50226002)(336012)(4326008)(426003)(478600001)(72206003)(7696005)(6916009)(106002)(77096007)(126002)(8936002)(11346002)(486006)(2616005)(446003)(16586007)(48376002)(6666003)(476003)(5660300001)(186003)(76176011)(356003)(8676002)(59450400001)(7636002)(26005)(305945005)(51416003)(107886003)(2906002)(50466002)(47776003)(36756003)(106466001)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3049;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD027;1:gdT6AoGKihhKvMNvADgpt8JKmCkAFQut9KqXaKYVbx6SLo03fhrI01zhQaaQ7h7EQ+a5e+vRFTWezqQwHNq0Z+N+OBGEG7MnueUNbzsWg1SZEdAxEuUPjaU8VzsZ2DkR
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac125fdd-fdb8-499c-4d17-08d59ec8afe6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR03MB3049;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3049;3:ly/I67Dedi+nL3T+nYJSznywCb72X1qgCDDq62dFEQe5rWEyeGP5Tk0DFfCKh2vj6wQUiQCdj5RYluRB9pkbODK8fDL/zN5KtiVycfCcV1/1qoOYhtCwgiaF47YJaRNbKitRLBiVFV4ctJITXjPULj1oVIaUHbyqEe4LmIRtfzXY4D+qS5nkjl/w70Q9wWaeeqaxvCVgo1nWq8T6Nl9MDEE3ozw+feq4JMW8cZCwTWRsfRNTjNI4SyzEtDOxeFewcDeUWqNDwUhtkvo5kLWC0Lb0GSw+9SLWrAEF8MHfnnVdzgnTJ+awwp8grMafe8FgX56i5KFhNiCahRyCpuhbjGhimK8YFRg4BFi6zGWhmXo=;25:UsVjQI1dZrJJGhdYgczDHTR6mYvDi4oiqchQUXBW4eiuV86cOCixyxrLJCV/kV7oIc9Oyby3RWCa5ht94TbzIBSIkUFR2/WCu8RtC2FVDXeUZRGyQim5UWC02Un047ZJhlSXm1VjH5AdcbucgZSKZtHXXGeg2TYItwDrUKezPl5xwUn14cg6akWvkuC86BGGA59hlUQD0wmMQ8YfJDUVbNhW47HMd4u4IDfuQPAisO5N2yoV17E3qIorzKpp5MbfBferPss07PJSci9KX8RJBXrEEbmBOLswcTkGImvTPWmYszlXwrgzfb9GijJESEMYOaRxk6bkc9QsUkGFOSk6sA==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3049:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3049;31:7kw+hmScLzj3/XgEqGDC7IxLPXmvc6LOFtpH6QD+renYNg4JBxEWKTW0Cw8dn3uKk9DIlbIW+L9sJZtME8Ey+KxIDT9cYCAMZPsEgZ8pXSYKF9sD6GsJkTT9HjfwSeaOYY8/gv/1cchVDkK2Gk5j1ykdxt+RhJkg7ylJAXdRj2FCk+dyyPoGY0ujxv4eAY1bb/af4wgxTFvBOUTzxVE160g7RrqWzUWXPVt4AyKV14k=;20:CWxzEulSdP8VnAv6HcKKdTVNBGI8TvtWxgSvZKJpkNOMFAwig/9PBJKstdi3yLkDBTIjC7AvVfF6hgI9+QVvjcCkFQwALdBbu2f48LmigBpxYyQHISEDM3ehsD6QEzP0mRQxLdUMG9+aVRtyKzsvknoAD1rTLtX7TuOn3epRu4Y+8V6GPovPZT7pE227M/A//C1JaWDemoIcDXz2eee7QQQuu4bEoF4LetVop3Rb+h2Q/SBoDpEv/KOLCAj54JoF4OSQ4eYmpavIwb6CIO42hMLISi1VNwV01KQjFbPNK8VCBZ9LmIUR1d6Go+CrSJFcPI67XYkK+JX0UGBf+z7k8YX9E0Ci4lqMpQh+rtri6cs7SK58Bfm4kaIaCiuVBu7sg7/08Zcdu8ZvymTE7iQuw9cWQ3OKA0XGBe4mdvYM9YaENTi0BmHEiB6JLv40q85PBu2iF9E255KojmDjKj461iF3HWb2FQXfyCD5qIICWpwIsEYhlftHD3iWH/IsOiG/
X-Microsoft-Antispam-PRVS: <DM5PR03MB304938BD68AD5A2F97ABE9AC9DBE0@DM5PR03MB3049.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR03MB3049;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3049;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3049;4:VBQ5KeV1jlG8dm4iBnaeP6HIShCKd/L1ya3Lq1UdJuVnkrl/7w1PqZyQ+jPSJGKoIPDajqat7j3N/dN0MjDLIoT4wePEMPb+eJtxey1XVGPh029q03j3x30UaA+E5snQ9RQF3fDtWLcXZeTYauL9XZV/DYkMVfUtMMXsiwYIDt6z7DYYwWfKHQ5oVG56Dg1rHb+30i5kcK/D4lg2YO76/NdcJwYM2Nj8Ln4oSdxwwMW2+8MaRvfXJ+IPQ+y3MRE8D7hhvNYLO2sXzIPEGxQJPWfXsYx0VVUmMR7e78vDQhTmlDTKsUGUCvh2B9KzeZbV
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3049;23:xi0Zo6OzKg9vSQnMl9Ekrh99+6ncenAY5wtZ78X6s?=
 =?us-ascii?Q?LHroe0iS5YH847V3FGRUi/uV3ckRJPMwPM6d8agr/jkt5PTaBkWAcmcXWeVh?=
 =?us-ascii?Q?0oDEt7HXzie1POQnVTrPdc+WzxBgDq7dR8mqwYVbw3rbJytiLfj9PAsLK5WX?=
 =?us-ascii?Q?bQbRc3JV6wOyBpAukRwRHmZdlfH87T2vCYWDsiWpz293zV2x6vZ7THmg87rg?=
 =?us-ascii?Q?AEdgX7xUUtJ7qEDZ6WfZ0RwtnDp0X3Hk1dmsH8gCN81ceEOGssfntgvtiuy/?=
 =?us-ascii?Q?2XEbj5ODtVRd2ka9AH5w7/Rsi0WUCqKku3nrM9J30Ibn5/kHkp1+v2KJ1sm7?=
 =?us-ascii?Q?m70xjnCAcr4dBYu6lDm6hrqsdcSHKn3us9D+Jhh8qTMBQax2Aq0KjIMbkFWi?=
 =?us-ascii?Q?J8ErAq9gF4zso/tO4BVDpfDyW6OFEXVFguTL4pg1ai45XoBD/nNcaTNB7/io?=
 =?us-ascii?Q?lq3o1wks0bf/tSgyYlHN/onlTmdjl/biLr9ZnnChF+Td1ukzpphnFsHDgnNb?=
 =?us-ascii?Q?IP3CJe4PP5qU+tfRMBgsVQZ0KZ2MSudVp9b9x7v3RTTorVBpa3PhYnN5zHhD?=
 =?us-ascii?Q?kJhBjjo1G/Qk+5mnhGNGTJgUzlAtu9vFmR+zkzGKvm0FcZppnlGtzlAt5RjG?=
 =?us-ascii?Q?KPaJ0RbynUTBoZY2DQQQC0j8tmtmIusy6pRj/9UIPKaiRXeshIU0G1iErd0U?=
 =?us-ascii?Q?Y4luYl0GzGmTJpdg3o78r6m1U+BpYuNm3Yx3uNP3TdgL1FCOhr3+ssLJUprK?=
 =?us-ascii?Q?2/TrK/dm1H+tG9NZFMpVp+mEbIK97ciTmn+qYgftxCIwp3QwG63vV0aa3nrQ?=
 =?us-ascii?Q?ERB05qiKTa40u3R7rQ7UmAkvU61cmCOys4RbwzppPtYaYoJDi1rBQSFWSEY9?=
 =?us-ascii?Q?K49svmcxyLFr0LOjgy1QJAr12/Jc+mG0Y7RLOyMeG2qXmp8759cPLgABlhpI?=
 =?us-ascii?Q?9BBqD14/MFzv4WAsYdaV8lJNz0a46tMWAddELj9ueHgOKZVcwgJ9jLHLEtAg?=
 =?us-ascii?Q?4IjchtV3UFgzaubiOl4s8FtpH20Rc3CPwDiXu7F2f1u/D9ndCAfIiFWyR8D6?=
 =?us-ascii?Q?+LHY8AYsZQutsG632gtipvCWXNvkp87E7VJ+cYCH3zpoJjrvvVvx2tQacWei?=
 =?us-ascii?Q?zI0HAtpdcQ=3D?=
X-Microsoft-Antispam-Message-Info: 69iWOmcd4qFPFooO6fsYXw6WvybmpQAFnCU0YQcwfR12C7IoSaTtUWJTUw3u/WPpnt9bwji4IeqpGK/M90k94GJThN/s9aCOBe6y+DXBMsdyrfV4Zl28uKt8QowWTKuYLR/UKDBMKILRVrHQnGEUR2K2CYDd+rK8qaZZZcGjqg+u8/5u0X5+yf/CdDXCI5LD
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3049;6:HoTgCJUMp8pIT84HvLAtq63PciekfW5UDiqQSzHjum2UQR7MMXYP0fYPjMn/4OrezM+TF2KqMyMzaXmXYtmoIFO3eb8jQ4AJAtkG2XAbZHtiHfkhgp++dAM8rzj/ppo11xpUjMi92Sc+Tu+6btqRWvrbHQXg1O7FsiFBFuqmvDGKgKAy4RyDYmayNVxdk8w+XcbFo/KADk6JG09jznqqIbuWucUSb9rdvWv7EgzzZCUdldPRTWl7paO9x/cePkvC1RM2YDpabXvGvr1yYHg/HlEgO1EUS0LoKbKaiQBnZpOQztHr0HCk1OpJ3/o1tyj28cL7pIdBp1BRAuS/iFUdDgq8CuK2pUfAtvT7yZFcqy8B1qt2y06sWt0x9j3oipaTaTmoDADPZKL7g1hIgGInimQyhUt/bYlaqOXudf4asH6Ms2tBx+XN2JvRfBPlSyJd+7Ps95xHX8hsth6SJXMgQQ==;5:XbUTWPBN0huH1G783+1q1ldlkoRmbdb4OCSMU0ELbCUNYcYrooJ2m+XZICYqEEuMkX3Og6LLOvIK3y+itH4mEVQKWJ8SD+LqwNSSnMZGuU0MZLK95vdiuPxkzh+fbSktsCaUtz4TJxm3zfDsrcjiv2Vn7q6k9Sm9HEj81JYk8Mg=;24:YMoXc0EkZCSKYgn7J4tMzg9FCY9IlEo/TfkCPbm2oIw2eRlE9h9mrU7mugiShuFXS4Mktp+6RNoV9SZVuZGLhH7f9wjp+/GIoM0mVYjbuvA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3049;7:bcBdlHGFKp5bb6oyQRK7YdnZ9HazRRTwT1ooksc2Ng/2gjRhr2voPgQTjGi0xTeeLRMFCqzoIt9OWrRtj8bdncJWCMqrzYCclFTlwI/jwIQU8u7/Sb1cE+Ftf8MspQFjuKsrBQRhF121Q7N4BwzRFuhytrwa0wmj3LMGRafg4AS/CrRtbn5FXCSG+IbpDpTJuzD/NqwihgP9Gs9PTtoXwFmRgSrUVps98wiyCmuEFRa3Yngq8OQErZEMxkckSpsX
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 09:51:52.2830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac125fdd-fdb8-499c-4d17-08d59ec8afe6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3049
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the option to activate/deactivate the charging voltage
limit. If activated, the charger prevents charging until the battery
voltage drops below the VCHG_VLIM threshold.

This option is not configurable via the power_supply properties,
therefore, access via sysfs was provided to examine and modify this
attribute on the fly.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
  - Fixed the kbuild test error by changing the type of the
    charging_vlim_enabled_show() and charging_vlim_enabled_store()
    functions from int to ssize_t.

 .../ABI/testing/sysfs-class-power-adp5061          | 13 ++++++
 drivers/power/supply/adp5061.c                     | 46 ++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-adp5061 b/Documentation/ABI/testing/sysfs-class-power-adp5061
index 0d056aa..25064c1 100644
--- a/Documentation/ABI/testing/sysfs-class-power-adp5061
+++ b/Documentation/ABI/testing/sysfs-class-power-adp5061
@@ -8,3 +8,16 @@ Description:
 	Valid values:
 		- 1: enabled
 		- 0: disabled
+
+What: /sys/class/power_supply/adp5061/charging_vlim_enabled
+Description:
+	Enable/disable charging voltage limit
+
+	The ADP5061 charging voltage limit can be enabled by setting
+	this attribute to 1. When enabled, the charger prevents charging
+	until the battery voltage drops bellow the VCHG_VLIM threshold.
+	See device datasheet for details.
+
+	Valid values:
+		- 1: enabled
+		- 0: disabled
diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index 99871e6..9716059 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -84,6 +84,10 @@
 #define ADP5061_FUNC_SET_1_EN_CHG_MSK		BIT(0)
 #define ADP5061_FUNC_SET_1_EN_CHG_MODE(x)	(((x) & 0x01) << 0)
 
+/* ADP5061_FUNC_SET_2 */
+#define ADP5061_FUNC_SET_2_EN_CHG_VLIM_MSK	BIT(5)
+#define ADP5061_FUNC_SET_2_EN_CHG_VLIM_MODE(x)	(((x) & 0x01) << 5)
+
 #define ADP5061_NO_BATTERY	0x01
 #define ADP5061_ICHG_MAX	1300 // mA
 
@@ -737,10 +741,52 @@ static ssize_t charging_enabled_store(struct device *dev,
 	return count;
 }
 
+static ssize_t charging_vlim_enabled_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_FUNC_SET_2, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval = (regval & ADP5061_FUNC_SET_2_EN_CHG_VLIM_MSK) >> 5;
+	return sprintf(buf, "%d\n", regval);
+}
+
+static ssize_t charging_vlim_enabled_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	u8 chg_vlim_en;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &chg_vlim_en);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADP5061_FUNC_SET_2,
+			ADP5061_FUNC_SET_2_EN_CHG_VLIM_MSK,
+			ADP5061_FUNC_SET_2_EN_CHG_VLIM_MODE(!!chg_vlim_en));
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(charging_enabled);
+static DEVICE_ATTR_RW(charging_vlim_enabled);
 
 static struct attribute *adp5061_attributes[] = {
 	&dev_attr_charging_enabled.attr,
+	&dev_attr_charging_vlim_enabled.attr,
 	NULL
 };
 
-- 
2.7.4
