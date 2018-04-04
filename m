Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeDDISf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:18:35 -0400
Received: from mail-sn1nam02on0089.outbound.protection.outlook.com ([104.47.36.89]:17947
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751167AbeDDISa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:18:30 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 3/3] adp5061: Add support for charging voltage limit enable
Date: Wed, 4 Apr 2018 11:18:16 +0300
Message-ID: <1522829896-8087-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(2980300002)(438002)(189003)(199004)(50944005)(6666003)(16586007)(54906003)(356003)(7636002)(305945005)(107886003)(186003)(26005)(72206003)(77096007)(36756003)(6916009)(478600001)(5660300001)(4326008)(106466001)(2351001)(48376002)(59450400001)(50466002)(7696005)(51416003)(316002)(106002)(47776003)(336012)(486006)(8676002)(126002)(246002)(49486002)(476003)(8936002)(426003)(2616005)(2906002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3106;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD019;1:CrRUfLAG6vELglNBFuzDY7vA8eIEygbXTqd9ArmfzGBy/pvRfrM6V+yPUZ3frdC1K0vR7FdqshOh5FKPOxMoAyRoEtx20bSGKz0FBpSVxU4Iab+mth8Jr97JmTpdDtFR
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fed56a2-e336-4709-02b8-08d59a04a4ab
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR03MB3106;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3106;3:ciEjfPKXfUTGBc7OQ+HImwugQdkjhqvh0TqjuEocyKpuHvzxem0QMvOx+qZ/ndh3Vy1t1D6ji0zIae4WjNlyY0LVFtYdt1prbkXt5umSxZXnw3wGzQ4zIFDwHWVu3pYJAKHbTGedQLuHXws7YZIN29QtSKrG3gg0joT5UNuuSHGrrG2TSmZ6QT6cmbDaNM6ttKbqbD94dLTp+KGCDnWJznuk0r1pwxdyK/KdNvSyZfNB/YDFl5i3QyRWbPmSoXxTHn2mc6onFtE72KBkDg2un5fY4Jm7Q2l3x2/Bey4WW8zKMzauVWCuMvRXbD4TlUQ4FDJDs7pnUkduqfKSNVDGyMd3hFHQx/gEa0124jnwDe4=;25:o5mwNAcSrb9d6yzsha0tv45gV6mfy77lsXoKxv3GQLp3yymKglpsOVqosWqlxC8kBN79sZ01JWkjvjl7tJTrX698QXZyGGFcf5j3KJObUAPdMR4lrvj5D3vInc3swRradpFQ3YwdB2N+YN2UoMwsrQicMzzdKEfAnHn2zgu5kynxViEDm7AbGVaQK+p7hO8ets289skFsO5XJT5ZcIMOfbwfbrCDdc9XtE9V4v5TaYkY6u3XVEFy2/kxqBGd0Fj2ht6FB2yE3CKgIoKcPEdT+HVWH7oxKBg3vqZJW+30SpGdb5LsBeKFhE5MaszpDqQQjNLVJ9XrkNHs3q7RnvM5Tg==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3106:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3106;31:EifMKB7LAaCH8ymCcmU8V3gmlYAKqqZlZkIlXsu5/gQY5JyroOpB277JwaEmybRwhej9vQsDfakTGwslfdCahZZgb3xM+DsUUjP3wHFdO98zJe/j99TscAEA/ooiCAzryfjsNgsAYgtLugSLeGqgyzvAMbSZXRxXykbCycNWjQVbxYl4nF7zcAf99TZWFMfVeTulAdYmbKbVrpCFEqobWnvsVuCJaAI8VDjTP7iQB6M=;20:Gk5g4iM252CludyvQ/nO1eR9a7QubFOB/KdMkqxxtBQdlRVUzh3ovzpy/rNPw5BKZ8OxP8mNPAlODcbqt5S9pq8HBnoTK9sdQny2/gYBPNX8y+orQaedufnkk7TJn5mNRpd2HIfRiAnLZlf48Thtik4MB1/B1o1XdJCN3x+uOP6y9NSYtc+PlvOSyQbG24LT3hoxYKmkVZgINDCezsYR2K6iNqIE7ZuD1lk2ujp6pndwfww/9mUtOdhhBlA4JN7ejxDw4dE7+FpmZvUsVZBor1mh6jhJ2vjirHkjNeAEqw3wmi/nzyBswJLCd06WVbGFGwIh27hOpO62Z/10WTk5AI/tmp4RuD1/c6GBd/JuB5oNrHLtbVBL2vQ6lNH7uWwaqaGpAPHBja/v1W0+3ghbrycqbWxRS7TkSW8//q9TFCFbWhflTkOWJqXnOWnyMaUB/iiFOA+NwXihbOPO8OfAwJw5Hy9RaIP8jsRcPKaXiXzXx+6DZRCCXBfaZ0nZHQjC
X-Microsoft-Antispam-PRVS: <BN6PR03MB3106A78D0C14A879889B32039DA40@BN6PR03MB3106.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR03MB3106;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3106;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3106;4:PCXuVod6rJS4z9SDBNgSNM0tOiSZ52wTUW93QI5D8qGqMXXalTOBNZTp5tpbuuJznKe0ost5mK0/jUbpyIj9e+m211TU5z4f70x3mK5Vbs/X0+19608ANKvDIVelYkNGcukpMeRcaWwFwFRrfhezUH9c8pemqSHmqOqauILW3P41zRtyzljC6HsAUziygF8oayAZkcobiTq/EWoAfSqssJpHzVxpyLfI4OpYrRezniJTkS/Tw0JZsKR1oPngjQRLLczzru72LDmwS0n9iPeworh19SUhv9x7KKKA8HGGilqV/dp3G5V7tWWBCMG3ujAv
X-Forefront-PRVS: 0632519F33
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3106;23:lteI3vvvpw27OWIVOnEiQzG3uwc7Efv6JcCzkMNsy?=
 =?us-ascii?Q?MsbC1McfwiUrLdhwzPaIaKsnO7OZEFu3V3nvDA00Ba2KM3F4J3coLLd4eKJK?=
 =?us-ascii?Q?mrhK9839of7la7uc/2K6PsX56ahF7MDvu8QlJfEn4O/dE0LXiAAMT6z1vh6/?=
 =?us-ascii?Q?e6Ie/6WLhHMRg7B7dwcneTySLvSykzLGFTsX2ZMEtdjqfLGAvD4dK2mDKOGN?=
 =?us-ascii?Q?Lbbot+nfrmxf/3fXZSRl1F1qYxRc25qwEs9uNUQLh4skUWPTekq6ZAWokdhS?=
 =?us-ascii?Q?JLRjSg8nPz5Y/utkYesSYPRvDfTWOwFfwkqa5tD60U5GnurGs/Bdz75zeF++?=
 =?us-ascii?Q?8In/BMR6Y3UaWMQq7uG23/T48hap+wkr/BVDTys5KFNs4sh5EEYNFV6PHbx9?=
 =?us-ascii?Q?6bCi07KumUXhZdOli3O0ng1xd/QTazRLxpDlS5lBclYRufFAELZW72daCccy?=
 =?us-ascii?Q?Ke8RGNasZty6VTB+DxyfBWtIehxn4rUN8g5OiGh179/Q8FhhfL9skgRc/zbj?=
 =?us-ascii?Q?55TvdgXCN74KrEMtBoGQklmsCpc+RODBzxNRykpC3NZynbT5njM6kB/0M6HO?=
 =?us-ascii?Q?kUnUi3/55Au50PdNilynG1NlpzUnpnylr9W5q+L0F9nNhGCPaKkMN/Ozf/Qr?=
 =?us-ascii?Q?wyXGsyRt+st+j6wIrPWTZQ84p62ZQKKFIVL5kTAba6oTz0H0jSm3VPGje1K3?=
 =?us-ascii?Q?BQKlllomzTISV9cNZAgIk3B+9PhrOyTOh9bc8g5yacvCkUcGnYSH6LSe4X/6?=
 =?us-ascii?Q?po+icj4L1zntVCzJPStodSH3ipzLRBUrPL0xxXBiJKBPfBjrWZWNz6dpmK8s?=
 =?us-ascii?Q?oWyZ0e39DvCYOkxw3MYVZFiHdV04DsU0liEQbyuZtE5XOLT9PG18DxMpL+JW?=
 =?us-ascii?Q?Sw77T0biIS44EmUxJElVK5ukMOoqel1+dX5Ps0kO7AOINmrlSAM+69S4j2UO?=
 =?us-ascii?Q?3tcrfXkMOzvPpBhIqGxz6vN4QLcfbdXt8IIRxVbCXywtt2zTr0fl20I9PZ9H?=
 =?us-ascii?Q?n/sxYUPwFcmwd5C61NfoZ+FeF3XXJ6N2farbMf1tesuSZQ74EElQjgNKwYqv?=
 =?us-ascii?Q?RIJ6QAMnN/lB7W+vxmAN0tcKknV?=
X-Microsoft-Antispam-Message-Info: MIsURnjNeNJUDchVoipBM2e4ylb3mC4R18mzsslv52mjzAf7EnzT62aWY5xru3ZX+BSokB/7aRDtcT65eb223zVmpp8qhUS2V1IW2YJJYR8MSArbLA4H1BCr6gyTmp273orfMG5kTusITC3NoGZukwpxsLblBUBODzgbko2BI87Ip7aSog3ZytQBJgGHqLfi
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3106;6:4j+TEKNqcWNqBDS9w7SfKcMMyFvMOZghRSiopkD1Mhh6CcVnYd03YtkD20t2S/YFVDZrVLwXiR+36tSVGZ6XWftuQSZ9DKzwwe60+AX/8sJaESzlyzq8/ytZvDfmf+DgKr5cooQU+7pDvJJaKgq1HqVRT6jgLGFzQ7HDRVz5rWdWzTWCZrK4N4hSavSpsNHyh+KbXe9czL4XCIG7t79ikMRIIIRIH22WatafrBRqhRhVDQbWctdte/28CFnO6SPHKGSP03Dxn9+UjPE+Hu/ybFTubyekngGXqEZoVD/QWBHIkU0x0swYovn8JxFVOOCtvX2Z2+TCXj1S75KXP2eQWDvXmqEhzQFyPTQMrMhLfLjVVGotJqTJ0irHLKPdlg1/ja1XcfS+v7Ze400kiFfprXvCF/izWDY/ZTra79TGtAl/lhak9FeM8m+huTi6ZAq3/iuEIzcwDrE8xEj9WigYRg==;5:iZY5NxeCtPk0WSwZZd8LhCdM9XM+acOOvFfRi70mIGy9VSnvPiP8jNBt/i8XCXZUc2tCpGbjqXe1Ks5ywGiaO3Ping6Q59l8Y9rmD0jNzj2slEs60Oic27yX4uIcsuzOGyablCj3+SKqj8Nf8MLtK8iNRucJFg/+N81hqvPZOjM=;24:3q3GZ0htteiNSWxbXxpS0AZhqjtICvZa/iXh6NOmY1dgNxasJuUPrqr5j6mvs0qpQwZeJWYDdBGeyQvZU8a9vv06BFI3zVtdEDAP4+K/S/Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3106;7:H5O0SU9FF1Y/J5MuEZdamI4fp/oB6Hxwl0dxQ/ZkF58EK5Q/5fMTMuUf33ZLpDJFMu8bPNiBLte0K/6zpyLZyzPU4A0Z2zW804S9Y39FpKXoopcpHmnBtc0HyD9wAcb1ENMcjh27EbCirhxlrFxT0gK71L2lojlHpfOn0CQVMgkLER7VEFFvSrQIsZvJB7E1MSUzFQInL73G5h/ewCZY/fFBidx0egouXzDdTA5LZUtIIP6hRtWNNU/vYVl7edoW
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 08:18:27.4918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fed56a2-e336-4709-02b8-08d59a04a4ab
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3106
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
index 7cd2e67..5931e45 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -83,6 +83,10 @@
 #define ADP5061_FUNC_SET_1_EN_CHG_MSK		BIT(0)
 #define ADP5061_FUNC_SET_1_EN_CHG_MODE(x)	(((x) & 0x01) << 0)
 
+/* ADP5061_FUNC_SET_2 */
+#define ADP5061_FUNC_SET_2_EN_CHG_VLIM_MSK	BIT(5)
+#define ADP5061_FUNC_SET_2_EN_CHG_VLIM_MODE(x)	(((x) & 0x01) << 5)
+
 #define ADP5061_NO_BATTERY	0x01
 #define ADP5061_ICHG_MAX	1300 // mA
 
@@ -736,10 +740,52 @@ static int charging_enabled_store(struct device *dev,
 	return count;
 }
 
+static int charging_vlim_enabled_show(struct device *dev,
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
+static int charging_vlim_enabled_store(struct device *dev,
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
