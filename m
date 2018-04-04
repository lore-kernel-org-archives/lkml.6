Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx49R48F3t2P9DeIQvnQq9gQNJn2F6CyIaSWc9uuiLtIoTeP5PJ//lJhGSiOzQzdSS+0x+jPv
ARC-Seal: i=1; a=rsa-sha256; t=1522829894; cv=none;
        d=google.com; s=arc-20160816;
        b=IsTaDStD/5kChrgJdrdEpLzx6xs0gE0HztEtZSTMGNSMiIZQG05vInQo4wJ9/9+9Fw
         /ThJpV5h5Z0jwcfOIZ9AKjg0ZmeWCnmQQ93IrKXdc9lSJF7988+qeeH57RiOIZLTxk4F
         fQKYlsx/WCnkuyILJxogGCivMock3vvrCtWv9+PGlwIsiR1EFwlqGpRAjYe/eA+Q0wNS
         nChcsPRMENbhaq1MECpiDYc2gwURwSTQpF/ZMvea+y777mRy54YJRk3LwuvLngSejHdw
         qe8kvDnS78U3wGhBwcfKXT1/DiKEwx6F9CHzhzj2+NcvaK2DVFXteWwf/s1RyMYo9DZ6
         xp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=K/pPRur+1FFuB0p/to36zSzosLOT8sGM8IEDmncmRGI=;
        b=rUJdU9K5bIpIm5D073+xy9EPoDah/uVX000V1YMaouaW4qOinJEp12yKQ5eu/0W1iw
         oTRc09MhWZapsEtiH6iuST7p0pwQYbwwMcM7PHhW+kNftfuUwoiYnhBcHUQrRK9VKk/w
         qaKzYMmae++K1cIUOmOLrgfiIOsSAjEn/tyCLj9+gXFytrzClwSAz4xGWtyLIFDSXlZT
         O/Bzsa6X6OmnBlYRBB3xgx8tV7Xe9qmbUKODIsWyj/8aMCXdN93+lNQ8p0C7iWZHOMMW
         8hbGerek7LdBlliLNWHeTPLxI9fiipGIEu4ePmcA/7c1xnHskMLF3CO9Nz6F6SvHQ90t
         B4OA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=sewVTCJR;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.38.66 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=sewVTCJR;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.38.66 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <sre@kernel.org>
CC: <davem@davemloft.net>, <mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<rdunlap@infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH 2/3] adp5061: Add support for battery charging enable
Date: Wed, 4 Apr 2018 11:17:57 +0300
Message-ID: <1522829877-7977-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(39380400002)(2980300002)(438002)(199004)(189003)(50944005)(48376002)(7696005)(51416003)(4326008)(50466002)(2616005)(186003)(59450400001)(336012)(356003)(77096007)(36756003)(5660300001)(126002)(49486002)(476003)(7636002)(486006)(26005)(305945005)(8676002)(426003)(106466001)(966005)(106002)(54906003)(478600001)(47776003)(316002)(16586007)(107886003)(6916009)(6306002)(6666003)(246002)(72206003)(8936002)(2906002)(50226002)(1720100001)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB396;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD027;1:uMzVnP/+nzEZkheEmq62tnohZbCHtWaNTkG5BYIegKLyL84aaIt5hAdiEROZ4SOUykRjhPKfmae2Mk5qYSPP6ssbN2W4Xt/fZDWgSAKJRhviLjQ8W5QnasUomQnrAqo9
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e160ee2c-03b0-4d4b-e414-08d59a049a25
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR03MB396;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB396;3:NnoqwopqagvGdEJjCrvcsDkVZGpQH9n57V+EkQKQQFRcNQgMk20hREMWqsqRz0DAxirQlxmWD2+3qopA1Og9RklZ6Q1H98jyIOsYgvbbiD2mjBdvu5wfKZ9Agr6ZR8LKw+ChF5WYu6yWHTlk0efWkwRS9P5IPtaTX+cHmNWSfusF9y5LN9TPjnhkGJrKRI+A1nW6Y3KZ+zcQfLj8MNIvaJMaXUmYLG/+OymjgESSWaDIGEtunfV7v2rW7EtIT3v2zBYB2NKFMfBTdROehVZWZdgMa+0KLbUF7G5278FZchAead4urmcp0QGbnH4bXlkk/O1eck3okPRK0c+GUJpPYas13diCqN479j2BUXe8X0c=;25:rLx5Fn0BKY5p5hETsNvbPL8lu5iIUQbEGeSfVfp6uwFp4RE5nTPtcpu6GKiFZ6hIK/95C2LfEmOt8DKdbdWtwCom3ieXAWv8oGZgzt1z1YUb4UMxRzniwNRMDxHfb4hkEQUV5A+W4aEymZcWZlhFpT9teC1vfytu/7QrE8RoIS6qer6vdZBfiQgWCiO1UqbB7mBt8r21I6svdiMuxtdSfeZK50kcLDsii+fWiVljROTuAeWSW9HxxpQylX+rt85en2qTdp8LlvUZbduChN3rzK++AuvX7pB/j+/9Qo4dmB2BC0dhbJBMvE+VC+MHO+tuFGlsldhIBxBlt9b6LqCqxg==
X-MS-TrafficTypeDiagnostic: BY2PR03MB396:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB396;31:3mXIgHUYz2ixIamoWGB2nzhWk/9G+/3LUKiiTWmbabG0T+ks8eoXkEFwuMG8B7N+uesJBgMto6GQLO9W/m1L5FR6wfVxhauOe5v9ijfh166KZoV1y+CaqpSq8mFoaE0FcsFRMu3bgC0W7Bfyv8EWHutGDaetVof1oRpibyiB6s66Ayz6msjCmAarlyuTH27LXurEOm9mrpnBcdjHsQJfZPfq7a5QOE9ATEVFMVrVk8Y=;20:3gNJsgeWs8bW3Y4qMolbitsEuHQLrzAuVA5P+19uvTi5ITyuQG6viepmAhSOK0kgaI6PqVbv4+LVdEYnuT2bjX4+VHZQQssVK5SCKbCBTu5wsYPRZD/aArhFJ7dOmPqlNm4Mli6p1eDx/o6OnIKYgnk+Yo2DOANt2LsUtpLiq40ITWIyxC8JghEdIL2ze1B2RF0NYaHDCpOxVLDbxHX6sVYobIx2XBG6atWr9hSJcKjtKBm2TC/Y3wJokFSH04Oq8wfN6PGazmd1ccpa/mZ4nF9XgTOQL6P0K7SnVjHU6hMSobdzarCgY87EZ9sBwm8EwHJUc9zeZE3VJs81t7Naqa2kT8tKmxK4g3KuZ/3dOlE4N3jHQ56d0oNrAD365/ep2WQLCLmGpUXJYqYg6fwsLyl0QyyjxIbv3YPw4G2+8CsTtlbwKLbZBd34vENm6Tu2MQihcfv1YqUfNs98+X5kw/NsyQ8HVcwpV2fxGMC5I3ZM/M+LMoUkDMWAbKfa0R6p
X-Microsoft-Antispam-PRVS: <BY2PR03MB396F0AEC70E8D27D59086D59DA40@BY2PR03MB396.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR03MB396;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB396;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB396;4:ofRr8oYxsSCMOKgU+G1tD49hGbHg8Kjp0TGPJeotDl+tbPOw5TcfWE1oF9CR82oZIgBUkGgpXilDE10879TwtV7+UxxPSBzTSmX33zTUrsDZlZKyLxHqHr+S5lSJMb+scLA1yFbGbR1rCvLUu/j0CAgzd5T0EXgnszFlIGrY6CHb+K9QmKCKbizarhieP6lBW3JpaigA4Vtk61zyfFC5/ZuORUz64qWSlK2Hsd6fdAIcD7S0afowzYdMD7USZ1pBFgy60+yxiwm8Degc6hWv3Yn8WJDLfzFWv8BwOlcjmKsrlyzT2cq/aiccSu1c3eXFuO6e9Md6QWQ9+G7R4mfh209nxdL/LviLDPCHgT73MLk=
X-Forefront-PRVS: 0632519F33
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR03MB396;23:7lZdGh4UV4qAHLFV+Z0MDoDay876keR6CpJkId0QEp?=
 =?us-ascii?Q?7cU6X6fTKWit+I7qpyo/DqHPrZLqMR/sBI35w9VbJw6Wm3cKTzO45N1ljgzp?=
 =?us-ascii?Q?vuNS9PDZeHc/zEeRDrTYNg04yW+FU4RV5s2v9y6K/SNQ+i/dtiz1BvfdWLcM?=
 =?us-ascii?Q?RA8onl7sOJAVnWmSzmbqKenzSuCRIOBb3X05Z3dy/kJQhnmfN9NUX7VwLycp?=
 =?us-ascii?Q?0ciJZaIkwIBKu0crhNkjvKzTIzwaR6hWbU+GeKt57skSDUDs5F5FvM4PnQRP?=
 =?us-ascii?Q?1XVlzJQvuGlRrxDfTgIIasmHRuYPdvMztJ5P68fCCHeePxdoVFwu4rZXHKmB?=
 =?us-ascii?Q?fflADn2ik1DqcMFtn/WYYv12xOmOiQ4ODM6oI3/5xu5EcwJhD6oamiYIR99k?=
 =?us-ascii?Q?895l+U0PBK3FBqIvgwQCCG4zHz0PYHKNXFiV09AGnrtAdi9TYs6Iuef/cBFn?=
 =?us-ascii?Q?8GSL8oiaXQhBh//rPpxPtCKSvBt1RRAUStFsHv3AhC3QWQYKizZpEVt5O1DH?=
 =?us-ascii?Q?hAFaGTx9JIr8DRweBhkRLDw9r4P1aOSzFs3zWjdUT1jG6eFAXe7qtzWcK5Ul?=
 =?us-ascii?Q?DUmFFDANXs3A4flmHtJkovIp43tx1U0eIYE8qBtQ4/9vhE/x59LACS78MiJU?=
 =?us-ascii?Q?nmEwd9HLk+3rvhho5E8PQHJdMm9VgCIFbcFOSeYJLl2hDI1+Y0HeiSfMvvBo?=
 =?us-ascii?Q?JMdckdACf8OmTPR+OSBpSUFtWYJtxh5FD+Ng2xb9WEcsMSe/6U/VvDpZkgyM?=
 =?us-ascii?Q?FhpDwnSJA3EyHXCTOCUS040yBtwUcG3UTyNsEmCWZMHhEMloPea1A4x7ROgi?=
 =?us-ascii?Q?DbuVpvR9ycW3VB9kpMV/qMk3XmFXCcgImXBlLJnV3UTgJ202VBmWZRC+hJuj?=
 =?us-ascii?Q?4JNYAF4xashhkSktP0dOSgR5ysgS5X3BWooKZwKmMy8Mr2nH5+BKoyXY+/ky?=
 =?us-ascii?Q?VSghYWLSatuJQ+KpqiDhq1SOsrivSGJ2IaGoZEYBizCDKKFZw6lNR5XsxURu?=
 =?us-ascii?Q?zDJfc5/ssNjokmc3E6PPIk1LMeyk4vmfWSzm3A0r+tFZiE25PPLRrcepQunF?=
 =?us-ascii?Q?q7my5G03srhuFsuuhqA7UTs86gysmKvqnPTMFkyjuch0kSJUw5C3EOyJhZib?=
 =?us-ascii?Q?L8RazMyOAwSlq0ZQBJza/kk9yImDZi?=
X-Microsoft-Antispam-Message-Info: a+t7dVVl3cHQJqWNeZE8mDl1ku04IhX6lpkriZuN7Gk0RU8I3zCuVvnIeRM0Y1HeDEq4uHpRFqcodDq8mvz9ERsszKMr6WPBBEWK+NXODp5+xMDo0TdU2vkOTyRpmam783gNVnjQmDhW68ebD4oX5i2A99Vx33iKr76koiJjApYi2XehY+7FfYjW6ZUz1ikO
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB396;6:8XQ803ezbNHBVg+UFCtvUHHNR7HxpZd1uvd0WmTf0mQLMCO/+boIFZLNGSEFN8WYZYk1HnMNb/PjR18Q4dHQrClEwbzyWlKLli2FYgmhj5Pu+0R/DObJDWxWnFIYgI7EyuAK7hPSP9Sc3crv9ce4FeIc6ku2sy+sbCicj3bh0cGzhlKGMhrqzICQkNh/Vhz3YOkBRtzYxl/ESG0wA8+6yhXLcUfgWpbr6qnokb3Cs/E2WW4CHj29QZL0Vr6cj1l7w6RxTmqbT7IPTiekmAPi1MMpiCUWFn8ZlRiuHWaCEDYtSBsR+a1E1g2AZKX0UavAC04kc2IVwP0RbFsUmV1PU3HICgemVxNhTZoG2AdFXhxe5p6rc0QBFfNrIi0UcvGWHVa/UFY9wJziuvgPmU39lxtMENpiIx6IOemtg1MT/zVFaAaLlHev6kfmh+z6yAzge3I7Cz97EbKLWovLz+FXoA==;5:HoVvRucQ5IPSxH7MOi7ave5OzGHkls63WV/pO3NzFAtiLSrAQN3Kl4V+XhglKPg7WTpsKte1uT0gMcBd2h5AQZayHtZJIu0qw0SURZ+CtCe3QLCjLzMrJtGUOTnAyPlqvN7NRBeEHvjiJVvE6Ps8C8vXHR8tRNwi+V1JxfG8wKo=;24:nxg9yL1mcYJW+pNBMdRfTgo27JUDL7lGZKQ1pUoOHH66ClCnItC8jIdfbxh2f00B8XVXPm+iFffyRMAAEofLA40qJ9dsIFQ3zR4A1J/kSjc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB396;7:PBCSxVtpBRhF84TDBccr2gQg6LlLXlwBoIwilhf+kv0cbddzXf2MztKV4GkwzGaA7BYv4GcXgb04jCQfYzKykmWyb1ttQJ26N4QyWup/YIDkmy3b44/ngaOf/mO009UJn7bxC89ojG6JY5rwFVHoe5eHw0u/tRyP9c7v/j/P5dJS2A3c85TNGe2Q3AcDBzvVXUzhWv16Zdug9sMMfLo9m25gxoDKVAgaaYb071abGnSvAlqH72sUK5MMTAmHY+J0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 08:18:09.8422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e160ee2c-03b0-4d4b-e414-08d59a049a25
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB396
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596802879382904823?=
X-GMAIL-MSGID: =?utf-8?q?1596802879382904823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds the option to enable/disable battery charging. This
option is not configurable via the power_supply properties, therefore,
access via sysfs was provided to examine and modify this attribute on the
fly.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../ABI/testing/sysfs-class-power-adp5061          | 10 ++++
 MAINTAINERS                                        |  1 +
 drivers/power/supply/adp5061.c                     | 62 ++++++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-adp5061

diff --git a/Documentation/ABI/testing/sysfs-class-power-adp5061 b/Documentation/ABI/testing/sysfs-class-power-adp5061
new file mode 100644
index 0000000..0d056aa
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-adp5061
@@ -0,0 +1,10 @@
+What: /sys/class/power_supply/adp5061/charging_enabled
+Description:
+	Enable/disable battery charging.
+
+	The ADP5061 charging function can be enabled by setting
+	this attribute to 1. See device datasheet for details.
+
+	Valid values:
+		- 1: enabled
+		- 0: disabled
diff --git a/MAINTAINERS b/MAINTAINERS
index a9ca73b..9271246 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -804,6 +804,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	Documentation/devicetree/bindings/power/supply/adp5061.txt
 F:	drivers/power/supply/adp5061.c
+F:	Documentation/ABI/testing/sysfs-class-power-adp5061
 
 ANALOG DEVICES INC ADV7180 DRIVER
 M:	Lars-Peter Clausen <lars@metafoo.de>
diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index c00a02e..7cd2e67 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -79,6 +79,10 @@
 #define ADP5061_IEND_IEND_MSK			GENMASK(7, 5)
 #define ADP5061_IEND_IEND_MODE(x)		(((x) & 0x07) << 5)
 
+/* ADP5061_FUNC_SET_1 */
+#define ADP5061_FUNC_SET_1_EN_CHG_MSK		BIT(0)
+#define ADP5061_FUNC_SET_1_EN_CHG_MODE(x)	(((x) & 0x01) << 0)
+
 #define ADP5061_NO_BATTERY	0x01
 #define ADP5061_ICHG_MAX	1300 // mA
 
@@ -692,11 +696,63 @@ static const struct power_supply_desc adp5061_desc = {
 	.num_properties		= ARRAY_SIZE(adp5061_props),
 };
 
+static int charging_enabled_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_FUNC_SET_1, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval &= ADP5061_FUNC_SET_1_EN_CHG_MSK;
+	return sprintf(buf, "%d\n", regval);
+}
+
+static int charging_enabled_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	u8 chg_en;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &chg_en);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADP5061_FUNC_SET_1,
+				 ADP5061_FUNC_SET_1_EN_CHG_MSK,
+				 ADP5061_FUNC_SET_1_EN_CHG_MODE(!!chg_en));
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(charging_enabled);
+
+static struct attribute *adp5061_attributes[] = {
+	&dev_attr_charging_enabled.attr,
+	NULL
+};
+
+static const struct attribute_group adp5061_attr_group = {
+	.attrs = adp5061_attributes,
+};
+
 static int adp5061_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct power_supply_config psy_cfg = {};
 	struct adp5061_state *st;
+	int ret;
 
 	st = devm_kzalloc(&client->dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
@@ -722,6 +778,12 @@ static int adp5061_probe(struct i2c_client *client,
 		return PTR_ERR(st->psy);
 	}
 
+	ret = sysfs_create_group(&st->psy->dev.kobj, &adp5061_attr_group);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to create sysfs group\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.7.4
