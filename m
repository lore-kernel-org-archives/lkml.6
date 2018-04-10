Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx497IbNP99NceMWzYukgSjlsfbemk4Crrm+h+AweRKbPXUXCLY/DiazYETChSV8Nqv0TbpY0
ARC-Seal: i=1; a=rsa-sha256; t=1523353901; cv=none;
        d=google.com; s=arc-20160816;
        b=i6yDA2T7e1skHSoddSziPaftLjDFupl7zhoOOMhNfIkGu5sB/OLy//JXdM2EYtJ5ll
         9GOLV8KLBffHeZho//+V3JP0q1nJx8gBSFucpwsNZcmrxsQKh4rk+N99d/MmIKOMyduN
         /kPIV5X3lIhm0S9fzvE3JfdbAt2P091BOME6ntoPs6eR3iqo5HZgIlH2L69B/3BK2iUt
         mKLe6xOxt1EWYd4PG0bu2zUChQCmclpLTDZo5vC6Pthwg0aMcNKtthc+3MMbkyduI2iX
         oftLUI495/5ahHL4VLmE6KGOr++6k8sO31tZ/tizLcovb9o+rXG95AgI5+XgHqSqGWNS
         CJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=QcS16gKWu3i1dWr7bUJekDr4Nq4+4MAA7xJv3btzago=;
        b=f4bUyLFNrO1ehwSe44CoOJD+OuzbPk+5OpOPF2iu4v7e9blPVoKYwQWzc+hDSH8uzH
         46LOOYlXw2jRWJLipkAX+AnDZ5lMb7hCJeMzpcLXdZ0lbHXqIJFaQm1XQ+efjVHA5iJd
         hPMlVeNufk7eUWovL0KXYLrprNgXPcg6o56MuYvQlcNTUXZKb4DhwxkqM38UWuxm0Da9
         PvdYX4eLgaZ8jg/CwBM+CNqWywbpE6YsIXXZY6am9zJ37cOiy7hKOVUK1ytV9fc/kH1x
         RxGvMJWaW+WpHOAuTzPcVz5CwP7eoaKlQ40NTsLWibEtfOlXc1RZqiALykKnGIfOjV00
         k1TA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=RH4gldtE;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.33.66 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=RH4gldtE;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.33.66 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
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
Subject: [PATCH v2 2/3] adp5061: Add support for battery charging enable
Date: Tue, 10 Apr 2018 12:51:14 +0300
Message-ID: <1523353874-23640-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522829877-7977-1-git-send-email-stefan.popa@analog.com>
References: <1522829877-7977-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(346002)(39860400002)(376002)(2980300002)(438002)(50944005)(189003)(199004)(77096007)(126002)(26005)(11346002)(6916009)(478600001)(107886003)(356003)(59450400001)(476003)(966005)(2616005)(106002)(7636002)(446003)(426003)(186003)(2906002)(486006)(336012)(1720100001)(16586007)(5660300001)(106466001)(4326008)(246002)(47776003)(7696005)(54906003)(50466002)(48376002)(76176011)(51416003)(6666003)(50226002)(72206003)(6306002)(305945005)(36756003)(2351001)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3055;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD023;1:J61Qh0OZE8sPBH25IWR/cGWqNB39sRJCcH08eudlCNWv9YYb3P23Gyb0mB3Of9sHxOcC1yRiy16PhTo/cV9TQB29AAV9EifgklSiCNI+DEvLCn3wb7m3e45WEOevZ9Bk
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:MWHPR03MB3055;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;3:74y3ooXYAhMtd3l2P1QQ4kSSs8/9//1w6NK7HpA5trQlFwoeHl5vzGSpBg+wPlArfr0Jeb9G4lZ5msmLsLM6ylVtDtbyxw5CGMm53aGeRIcU62mh/YEdTYtPLMbBcP9hUPjR60S1bWO59FaK7cpfoWyINt7tALDmHo01wkE2u/ZYi8OOx7I13d6nu7UbwedE8L7lTO+KXybYjxlyjfezBNKH6rFLO0wqiohFIGEhvufhR2bVgWzUUQRbgkdPDgXQCRqzpEV/guup+rKxRDSLyuDnWVseOBCffU75u8puboN40dZp+NOHUOL959pqQpXV6S6TX3xwHRP9Cck7PIuG2Gl7uM9xan3QlULnEtDBPGc=;25:pKw1n3p9mCNZt8h1uLYbaHmGvMJYlCwKJ9M2k3bg2/QMbhAa28cCk5LUNvUG6xTXv6y1aHU26flhkJI4rrIBi0R32XGlOJlmAi+iC20WzOhv/aCmoPwyBkNcQH/MA56qdnNqxbfMDuXJTmFWhWrwEbKk6aUZD9lpQigegbviMI9irtQOnog9EC5p8EPFapJaOp+YZy1Bjs9M3/6j8hd03xoeemS4XyVREs9LsaM2YWHcRpMNgJpy/Ov7Uc4Jq3f3AJ4GrzTtC76igSYTYs2h+QUOPISSspy3/YQWcg493+kVhRZ+Dw/3SCS9xV8avK/cyAIrz+iTEqiOcCh21sTW5A==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3055:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;31:AAvSmeTFouGq+cwZ8r6zVT16XPfGDWM9tVfz4IltTIXo6Y0yOzK6wAJyQugTx2FLEqbUriElgJNRrVgPKJkH65DFgqriRzBaca9Zv6TzJ0OVbIl9ST3m1F9+9iSFQyTB9vJUofYXIYL0UciGqXlzlResOAqGQYXV84ydyZSS9tcZw/QJqZs8UhzAu6xquQuqUuquT0nbk7YdWxwSArhsnJW5PNL73OApKh8uQeqnN2o=;20:5OUg+HUF+FoiGOSiDuJCPp3gq4WLmZJ1/NvOn1MBed8J2wZtrjBq8jLHuQ5oiACAewWuB9BTQ8/GFPR51F9S0jOaVXW+kBAZd+q1ltKnPuAPibGPjWVNYvmkH3nrhvpKXbZXBRXoS8hHa3igLxq/c0KOuL2WSpLeiBXdJ+pTR2yAW/0gpSEAFL7gBgWViACaGtkAKA7XsdokmmfkYfGdpG/1MewyMmR29obCZ8xn4T3Pp1aFhx8qUqDKgO3Ewmnki0ErO1FXu1tZsFx3scggObmFg/zX7EXhtzNuuJ/SD+QdEgKbkqA8rs2WzyZa0rBwjkUwVRfexHtvb9rlGCQ6kGYci6xL54dKjjZUYJ1crZ5JIy4KgqX/vxaGosy1Mj+1gaUFgQqZWt6FqHhtwLm22uRYbeO+6P+O373k0VgF832tdKbJg+bAV2rssbpQADIbjuWfkuaxDHH64sumQNQgM2XzCDH8ZW2zC1c/1CLDY09xcEOHx+kUEkOoT4E1zR+y
X-Microsoft-Antispam-PRVS: <MWHPR03MB30552BBD655D54398BCC06C39DBE0@MWHPR03MB3055.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231221)(944501327)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR03MB3055;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3055;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;4:qTDFFm+eTHMeb2rB/dnW14OfH6fPgyNyMTYKf6pdKjDBgU6yDEBk2KevJ/1A3B520uVwgrWrGqU4DMF53A77iHbjfaS1P1IGYJr9baEow786X54b5HW6cNwlfIFzkfHspRilJ2hVOtyVQQvWtTtuYb4uviFkqVdWWy8Fo15DFjYq7RY7eU5pi8OlqA+DwCjnN9Hq4KsocmcIB8u2SJ3InWV4Z0bNeQRFa46RFEgnxP/VYuSjpeswjcuKUFXMuiD54E8BxeOj2W1/8rgA6lqRgQQin1zTlfQKbAnhB6RgVkzkYE59H30/1GlDWYZSF6I4TywWDMPoD7cnVghd2YCp7ijIgiu+oYpmyYNKpn3IOB0=
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3055;23:0CxeZ8c0z7m3FVfDyAynHKBuaR9lsBwOWUwYNTNEH?=
 =?us-ascii?Q?iiFGjLuFuVbZ0ju3EWq6PAKSu7QfGnoKuDaFQp/gLX3PNdA1nTrL1xxiriF2?=
 =?us-ascii?Q?ngS31MKU3yfFTcT0Yqe7qh90rcF7TRffUBx3VDQPHs+bM4QZFFFMjLSaZpHW?=
 =?us-ascii?Q?NdzdtRLjzJkt6pKQ++PRUYXKVnDxAWd0Z52czX4urLw/JZq3chsvnwfJOope?=
 =?us-ascii?Q?+JVyiG4lI6WWd+GbDh385qqWwzNO9ijwV+meO6rwjuY+/5bgPO4rlUqeFGGp?=
 =?us-ascii?Q?kpBg5ibTIPhJRnqYGUt92QIVVrv/X76C9L0521pxh7zmJTgvFduYm0IP5UlL?=
 =?us-ascii?Q?BhNp2kRXD+gbzFCN30Aaohk1duZ2AFaw4sOYC/8KZ821TKVwumB3hgFtFe6V?=
 =?us-ascii?Q?hF2iJ9/UtqaH6ki0e0FM2r2m1bgvlkQ4TgO+S76fF2vSEb3gJwhExc/qkU7m?=
 =?us-ascii?Q?y0+2jzksgo0X6FZ0qr7jfPT/i4GsxciQ3vTVLCzjfwiw1nzG58JOdCsZfCsF?=
 =?us-ascii?Q?W574NPmvEri5r1KouxXqRkhHYaGaqMGc0N4s/dP+F7WEpuSg2sEvsef9o+JM?=
 =?us-ascii?Q?R38F7rraS7OSSpBMWycJEAarPqHWxy0588HLgtNxQdIn0WFz13xtdd2+PM1z?=
 =?us-ascii?Q?GnCNwfkqV5HX0Af4DgMonzEjbVUD1ezGjEFKK7jun92ed/Gf1httqhCflOjS?=
 =?us-ascii?Q?WjDdXkVRePAIjgfsA0DTrMzQK2DD2RJdhHLaPnLcr9IqurQP3Y+mIN35B+E9?=
 =?us-ascii?Q?aVtm7jI1r9kTgLrH660KEGcyLknBtU2rx7xF4SiqislxoMHzpd/gkH0d3oPh?=
 =?us-ascii?Q?owBSDH/fFBB0vk5IcUwvbUs/rn4AGwMizxtwg5CAqJ6auXNluAKA9Ib+/Y0p?=
 =?us-ascii?Q?6a/hTY152ZBky5NTz/R/UyHMr8kYcmB9d7RG2FzcVUzwgNo2l9lk4ArLs903?=
 =?us-ascii?Q?CDOsXeDganAxDcW3YcOSbvdCcm3EacGddSUiY3rVhD6MUSw8IsmYoJTWmnIL?=
 =?us-ascii?Q?RYBJT/RSd3hIFCztLLlTNTxUomKTFhsGpGnLxJADzZugdKLxVqVk/q4/oHFQ?=
 =?us-ascii?Q?jrhIRg2YJHICoR8s90Lpd3BqZyuzZiuVQrhkoosmIJkjJnLYaeyYUshuX7R+?=
 =?us-ascii?Q?vnZLf/zSKYxSUNhnt5Iam14T/NlUHFPuei4ldhYXJFDYxFOO6uwoQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: hs2W/sS97lqDPU+kUouVGemtDoz7lMDaytFXr/GFNAfltszX3FRt5Bp18tgGhiFiRidvYlQsWji2P2yYB+g9dDojPgA4sOIUDatWFSYSwAQTbkUjHsNCcRqA/I7/jzkeBr1Ez+Fr1xYdv08mVRnSmAfhwIcD1wAN4AYFCkOp+1HzKhYO0JrgqXpB+RlBxJ2N
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;6:VU7//jweJHdzZlL7CekjpETnGaouc5o1bA59dAbuPw1n/MsKoLDG5cuah31TnuCPQyInPhm0qw3aR0vlhKWBj9Y80a24LNGrjXhl2NcXdBrhgA0fJVAnshhO0cK5ozFdELjFWZmIPCVdRHcOLS7MvCsoYzC+qPzw7LEAcmX8m1vnL5VzLicFdnNeOCuAXgeuS67MOezsUPpemRgSIvnDGfzEcFjeJAEcsoTgASqB9aE4haPFxIPfcdOnT1Lh6aRg5xEDfK4M3HTvxmniC9537tDqOazm1DHIGi0F7+4WJcVTn/d7yRLJMC5e+hKz7mvDF4TmwkoW87Osks8P2wIxQ+KSPhKFCaoY49Iow1GNVOARL7W9v+ryGirkms68NavxVCuo8pvJtXGLiOkc5hpMJliPnFiTmI2NGjS5kfDP27e454QW2mj9TM/zjjC3rJumFjnpz3ImA6T8DG48ERnDoA==;5:T+x/AYOjx+2G4KOxY1AFzwkf+Lp2l/SOMEZtOXwzDY+wNyGMImLHpP3WYXkVjtqmSLbGbci+9XUJ/6LClRwqfGoeJeGTK0J2QlpHAg8wzg0uchHiLh5kfMJbm3/LsNv2p2XIrK9bvnn6Gah/S3ok70E1pgl24D7uWInZWEBAOw0=;24:/qzzkynDix+SX+X1BaZkS/smAMO2Jwcsva2RkKk4ewHYmcCZVWRPmji9KQMgbc//kkXq23gdZ78rm/Tm69NQseBn4JKA8ZR2UqXpCWjGZ8U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;7:WkqSimHAlvUBbsXTwuH0dZ8TN2kfpK4+YQKJfrAG3kvpzEsRvwN34Pa10PCHxero5rlJem9YS6MxJlEB7qOHLPbt+y2dBwFowfxGI07r5Gwp3Jy1SbZiQsrZEA/KuoLIVwUXR+a4sd+ZCZMnfsVzL6B2T5CGQyyWoX/v3kDkZ2WMh6EKuiH47p3eHFYlsn18IO9DsidxjqG7sfymvYFVHCvahpAvXRgaYzNoNMp791SRjYDAnKGChTthx2ePWnX0
X-MS-Office365-Filtering-Correlation-Id: a9e1113c-92e8-4b4b-1cc1-08d59ec8a62f
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 09:51:35.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e1113c-92e8-4b4b-1cc1-08d59ec8a62f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3055
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596802879382904823?=
X-GMAIL-MSGID: =?utf-8?q?1597352340604027719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds the option to enable/disable battery charging. This
option is not configurable via the power_supply properties, therefore,
access via sysfs was provided to examine and modify this attribute on the
fly.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
  - Fixed kbuild test error by changing the type of the
    charging_enabled_show() and charging_enabled_store() functions from
    int to ssize_t.

 .../ABI/testing/sysfs-class-power-adp5061          | 10 ++++
 MAINTAINERS                                        |  1 +
 drivers/power/supply/adp5061.c                     | 63 ++++++++++++++++++++++
 3 files changed, 74 insertions(+)
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
index c00a02e..99871e6 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 
+
 /* ADP5061 registers definition */
 #define ADP5061_ID			0x00
 #define ADP5061_REV			0x01
@@ -79,6 +80,10 @@
 #define ADP5061_IEND_IEND_MSK			GENMASK(7, 5)
 #define ADP5061_IEND_IEND_MODE(x)		(((x) & 0x07) << 5)
 
+/* ADP5061_FUNC_SET_1 */
+#define ADP5061_FUNC_SET_1_EN_CHG_MSK		BIT(0)
+#define ADP5061_FUNC_SET_1_EN_CHG_MODE(x)	(((x) & 0x01) << 0)
+
 #define ADP5061_NO_BATTERY	0x01
 #define ADP5061_ICHG_MAX	1300 // mA
 
@@ -692,11 +697,63 @@ static const struct power_supply_desc adp5061_desc = {
 	.num_properties		= ARRAY_SIZE(adp5061_props),
 };
 
+static ssize_t charging_enabled_show(struct device *dev,
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
+static ssize_t charging_enabled_store(struct device *dev,
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
@@ -722,6 +779,12 @@ static int adp5061_probe(struct i2c_client *client,
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
