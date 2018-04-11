Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeDKPLf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:11:35 -0400
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:21473
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752664AbeDKPLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:11:33 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v3 4/4] adp5061: Add support for charging voltage limit enable
Date: Wed, 11 Apr 2018 18:11:21 +0300
Message-ID: <1523459481-31860-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523353902-23748-1-git-send-email-stefan.popa@analog.com>
References: <1523353902-23748-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39850400004)(346002)(376002)(396003)(2980300002)(438002)(50944005)(189003)(199004)(107886003)(11346002)(50226002)(446003)(2616005)(126002)(8936002)(476003)(8676002)(426003)(246002)(59450400001)(51416003)(7696005)(186003)(2351001)(76176011)(106466001)(26005)(77096007)(48376002)(50466002)(336012)(478600001)(36756003)(54906003)(7636002)(4326008)(2906002)(305945005)(49486002)(6916009)(6666003)(16586007)(316002)(47776003)(72206003)(486006)(356003)(106002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2483;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC011;1:3hmjfb+H3TLy2OOPmCCn27a9ZEPLh6yEMZjhsdgmQzApmdGw2FQ73POCARJYu0luI00rxTH08ATlzJq1iT1YOiwVCM9RgBLkFGr3GF+SVkbRRkuWigm7Wclr715wyZ/h
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR03MB2483;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;3:DDDfqHh4uYihCJmRoBWMHtOTgSoGJ2V2LL8X7PHnk+0aSlif4w+v/1ORJMKiz4QKhePFWeAcdWc2bXuIUmmqdis3RP29qytg+2WuUooatjdGf0/ClzbiPpnv0n5DzS//EYaqDm/2Mu6jraGPdE3TC1epPIH1yUV16tHRQtlzbWmaG8ZAIXR38JeE1kCc1ssFQE9jb0SR945GQbE/4Ogh1rKNvAfuZMO/MvmfQAUVUqjUpxcTXuZbM4SEnCXGGoinfl+GQMg26C8uR19EaMy7RAfLzTMfvhKtvEwaV+SugHGSWQWGqy4q+FhWi6p0WN9DJjKJD8qH7TPyhCxEJWNrFqJIUzmKLS109Ma7aEOhIUs=;25:XpM4mm9PQMjQ3W9YCx++/jdttkVxbuZvExW7eLJ5FWR0/Q3TcWSGG9dmBXaiKfUKB8y6zbsOhIaeumqi7UpQF6drqqPraLROA7+0m79tAF3p4MwUFi/KcfCdFaLAE/L+n5sDFtoxNZAKu3fautvfJORRA1r+alAuoGvSKjT7m2bJNyZgvP1zXUyjeNCGEmsWi6WNn+iRRIkkfNz1xaDzuD+4twLcnTv9KHVcuyNxDXRywACaXg6+W6ind7nseXUiAOnYNM7TqMFgDRk4XSjqqB5xrJx7dbXMPKvF+8xCqF7JwQyOxzEmWysErjIu6bvPIBQnG+mefkiGJFtix4I41Q==
X-MS-TrafficTypeDiagnostic: BN6PR03MB2483:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;31:1JRB5xYRml/bxnT3469CtTWiv8zCbTKfLECPnnm3jfp5BeT8FaQkhE6J+UiZQ/BzViq62JyZ4AFtxsXJw2QNa414PVIxBbMCnih86lbrvC8JWJCIpe7DR9OVBkD//oCuRak4oytU6b6VJ7TX1QJBMHkYXea1bjnip2jGfG8vp1adreSekB/G0y2OoWbfa7EJxHgo2wvblmLFRo72oa/aEAQ7FMsUik0sMzx7646oc+g=;20:09IXT+G3NA4yHF1wWJML2jYddEL4D5l1FP/ZML1MJNbs3WOjosxLeHLnILCNu/EGf2HHKOgRwDvWJRyk2yqLGW2Nt3OFitQ4UbIzoW5e57137OSDJROY+RKnanIeLCReVH71CQeLWfXKtx56CQhlX8PE/Fw5k2IU5KpEJxglRcOfXmjJz9jRlurPOlS2DHIPTHXQ++cDanufN5+qEuGrnXA85ya+RyhBJ1k6UnN4CF8T0L0UmYP7zxnAY3jxD7qSq2ZXVdoDsK2gCHERFdDGdHZRUitdbYQdRGrC/YWKePMNDA6ikQKV+Nf59Su1rg8Sousye0GIuKNfIdC2+koFy1+bJ/g8AdDA+DTTjQNmkx22s5ol8hOba7xbJdV54NozCXtsYhSzErtzuAC3jAfzQHscvyCj5/n/KjFc7bizR+6wattM0Yyw1tCinrpFGYzlfxZGMWN0RRR6pwETxw8iY+r4xQ3XEZT8FovmAotUB8fv5yaQ5zzLsvrlQ9ZFo77W
X-Microsoft-Antispam-PRVS: <BN6PR03MB2483ACC6FEC3066AC138A6949DBD0@BN6PR03MB2483.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR03MB2483;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2483;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;4:UIbGAkNf0AHuSSHlPFq+a+rl+I5NDrvbSiqUM24ZaD5K167ig9Gzwk2LjWiuM23k94YJ4Jb6KgwJ30hpPw/LVKVbA4bBfMZqz4cvJJ3Mm7/jCxQLmMNSZU7VthsPY92sOjCuYKOyqKoCFRsbW1LTEElGUWvXZzsLMNFfwZ/vZR1MlyuzuwzSwHS0fSOZq64otxn8SmXmDGdIKiwAQXhkQ1u9WBIv6MEdVjr7OLwhV6xkSwUz6pFXlJpExLibTFvPUCL4EVcFg7ZcLOvBUsdfze7N5um7tMeexYlU2JXjfJkMguGWANrILUtMFYjzEGJW
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2483;23:ekpg8ndHoA+xc6ay/If/iBgSAdWmCMI50OZyr3DLD?=
 =?us-ascii?Q?tSX83GwDIoZnRejq7CXqP9+ZAMHzi5rO/VNzrkAlCzdnPLar6OAVZyV3v70+?=
 =?us-ascii?Q?GueAws7/75b8kBHuXZo2057wm5xcwkSjl/hRUi35Al8MOe890V0Btord+UtZ?=
 =?us-ascii?Q?rLoGylMWzsQe3PCby/2sfaEa1w491PYbfFYqRnfIvq3Y1ruQq+ONdMWfHqnt?=
 =?us-ascii?Q?6G9g9fZITX2TNgvJH8pIX6nk4dwZUpvldUbWjGfPJqahY5RlrIoaf3Bz6Ybt?=
 =?us-ascii?Q?kJY+9QNQQyJr0l5WewmahjR5T3JLByL9S52oqyO9iY79e1XUBaMzxq2/3gVt?=
 =?us-ascii?Q?kffz7LEGQ2qUrgd8lCow+27jPvGT9ijMz6N40sa3QZTrThfvM0EIRzqxUAM9?=
 =?us-ascii?Q?ePvKb6SXEhxBXvkwAUNcb/SrxHoOO/HyWOAtm2fIPCM0L41isrtIWm8CqkEv?=
 =?us-ascii?Q?aWa4m5Cj8yk0YMvbT98pmreZl7GyKew8Y1c53xYZiyzUMN97NUe7Ro8zWtBB?=
 =?us-ascii?Q?YBRm6XevxloWfj6Dq/fM9Qc2QX963r1NwXz+I/UHckuD4M0FweeQ/RIjE43t?=
 =?us-ascii?Q?tFwd1uJFvUL4YHd84X8wnjcoaUlYWCG3lAH9Xj7rQsFCk9lcR7vPnB6L4ujE?=
 =?us-ascii?Q?ozGgrkIz+44ObATL44RO5FsBKwgaY8lthZrCV1nGpj9n7CRbljOir+tIvoYu?=
 =?us-ascii?Q?YVjlI1ve2PgTOk4WR656pxRx/YKmVSroiEo1oQmVikUJCXoOy57ZfC+nWezd?=
 =?us-ascii?Q?CBX5JBDLOz+zadtBFpdKXfsh3u9/+pRBNeEgpq4+ctaur2DJUtL6Dt5hPYKp?=
 =?us-ascii?Q?2URjbwEufezaBJY8a1f7CRKvsWsUpbre2w1m50Z0//pVEOSN605bMrZ+EaCZ?=
 =?us-ascii?Q?Oj/wOnZOIrCObuSFRnisoxZ3qWm+3zGrj7CzZyvs+tJrt5buUwpRcXZL0wIr?=
 =?us-ascii?Q?Gxs1xBcqZICaCoCY9CiQcGsiQ0gkbsv6VYFJOeuJQcPfJtIav6SUXVgZHOtb?=
 =?us-ascii?Q?cLAl0pGUvTcEZBdzqjaI+AqlwyCVmxcu5soFCQwhwdT6eBcBM5xPs9bsXmv0?=
 =?us-ascii?Q?G2deNUZWuLnED6GxzAThpCBLQFL3mWHJtnBHzFXzhArD/Q351AZx9c/bwSL/?=
 =?us-ascii?Q?c8MCBSdAryCXfxqYB3sg2PHIbVaQWrK?=
X-Microsoft-Antispam-Message-Info: H+I/jU3Qxkg+I5zMkHIP6iE9um1jvdc21gUAtSD9qjIQVg2lNzRhbvvFlnUFRJDOZ75d0frPKf2M4PO6Y7bnri/5asaWMkmr2izRtNKvpRqXImH3JfM/YQ0N85XIyDaVSDysINUBa7Q4DDMIGEpq7XN3HNYmyO/QOq6trCLnau7cU5m4ZcWwOC6gJA5aUdxw
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;6:Nkew9tHeCAVVSUZLWO5zy43TiwXuxI7hJj3nvvo+w/HSM87zsY2vIcnf5rlCsgOFf+ETqHq963dEChAYSFUZaxjVxF9lhAHCX0YoVQEAy8o6cbH6RgUSCxvqWGMuMGJWFv+RItQyMst0xBKUSujD1FVEYWKAznS3W753JAiEbig8xpAcjAwN27d3KHF4W8EVnRNP7zNZVAZQdYGgoc4luhiNYrJ8MVFYlFvQLW97G3cHlowa0yblNyNrjGBYMrpInwxqkEFnV7wPxnzvfZMwJIfJedsCcrSZYomi51rCDszxke0IECDYtCppBuWZs3YjnYRAds83mSW+FTTcSkbluc98igIAWIbAMkvuhuwXARhd8A7IbU93DhqMp6w9joSpwglIXPzcJF85n9x+GpNMd+cjwGbl7ZsumPaKAeEKH9pbQo1rBVs618+wvWpoxMQfcaFKK/YruTO6oahKA6FX6g==;5:pmWgbE0uZvOmzoy2zKy6AvVkQBgGbZXEGPziQL571aVAw9JVmA9ukx0h0k+tWfYfEUOL3YYrA0Vn9t/gPmvC1rG02l0hgtsdIeP1oJ5CKVIVxqPsUvIhLrIKdSNTcQsHOLJ35m/wDyzB+VJBqd10OV4qGiuZNl1hvqe4Dl/lJKw=;24:Llan6VN/69lBTurQZXz2nxoA5HIw7KYvQvF0AKlWfllHCINlbERrsF31Xp7sLM0kq8w/uirPC78t8olWz7m1IMZJmCVgXUIkGdHwi5uN8NE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;7:10IpsN8ygEl4irdzriDdvtQ3JRxujhPbRjhs0sh7tzNLp7OND5Uw+QrZ/FvCMbOZEpneMQEP7gVybTKrYsEQNHVZyf/InvQqibo2ZlO6IMT50HvhmBQtIBDSh6jlg0uaA22M2xWa0xOusyoPn/+2w/cnRUDCORyZAn2NrhyjBT8y/rHmOewFWrhfUbSA7/yZ/rE+zsY2mziri5Vg/TDE2u2qkQFNWDvJeBnKpICAm/VXforYooRrvR9JxkelTp5o
X-MS-Office365-Filtering-Correlation-Id: 2f13f362-aaee-4297-7a4a-08d59fbe811c
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 15:11:30.0431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f13f362-aaee-4297-7a4a-08d59fbe811c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2483
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
Changes in v3:
	- Nothing changed, just to follow the patch set version.

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
