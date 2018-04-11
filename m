Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx4/zKZqM/YK7AungPkaKp1qew2ExCjcHNy3qwyPirQAzDmd9+Fvbqu7N1ipbKtrtxGUCIFKY
ARC-Seal: i=1; a=rsa-sha256; t=1523459461; cv=none;
        d=google.com; s=arc-20160816;
        b=G0NxuNP/QeTy0terS1GuhwiYzpmtX/muiTb/ly2kXrOg8qLWTXtNUW/RKdKT3ozwn9
         N8CDHafhY8JpAxdUD+hhwRwo0szB1kkyACDiqe1LT7XvbWamSxYpGKvPRr/vE7/UNR1L
         dwnK2TEqoM9kqIKlbZB9e9mrX2C0EjOH5WFBl8OfOOis+EU755BxOn7JQ2HIB4f8tA9E
         jycAcE7zAmWUT6i3xNBEp/ptAIR+NSHTKL2DMFzpdr8Q9wBNaJHtw+bf2KYf2ELvOyJp
         dobeEs6IEX4heCZRlbHIISSD72kF0uJDjmC7trizH0BLF3dwTn0QXOaUmIf9Nl4Pqvxm
         GdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=OeNKEm4kvZ0y7N67l9MAuuL96Gcry2XEnUqDgYPJ1gg=;
        b=aexlXI8zWb+FdJDm+z7TCfPTd/uvN878uwe1W4I3rdl9bfF1Huv79ea7TIiwnS7BK9
         au978oXjhmZ96ODnoYQqAiuCwKiOZC/ZxEkuskOPnvgv93YI2zBi8CkcnnzNxBJ2J9+b
         IJd0IdsJt+LIZUraBtrkftzwaAejDPpemtPhH/j0ne1pvFPMAopUPhm7yGaTJc1uM68p
         0i4gMa0iPFLehg5NVPT7sz0A/OO2s990vjFTc7sZlk3ScVlYfyfYBtzdrHisCalrwGuk
         SCoTmNtLaTTf1YBZ2hYC6pGsjDfSg7SQo8dCinHCB+/jopkkz3uGAR+pX+jHqgC/FFQi
         w7Yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=I0u0ibVS;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.38.49 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=I0u0ibVS;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.38.49 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <sre@kernel.org>
CC: <davem@davemloft.net>, <mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<rdunlap@infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 3/4] adp5061: Add support for battery charging enable
Date: Wed, 11 Apr 2018 18:10:36 +0300
Message-ID: <1523459436-31746-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523353874-23640-1-git-send-email-stefan.popa@analog.com>
References: <1523353874-23640-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39850400004)(346002)(376002)(396003)(2980300002)(438002)(50944005)(189003)(199004)(6306002)(107886003)(11346002)(966005)(50226002)(446003)(2616005)(126002)(8936002)(476003)(8676002)(426003)(246002)(59450400001)(51416003)(7696005)(186003)(2351001)(76176011)(106466001)(26005)(77096007)(48376002)(50466002)(336012)(478600001)(1720100001)(36756003)(54906003)(7636002)(4326008)(2906002)(305945005)(49486002)(6916009)(6666003)(16586007)(316002)(47776003)(72206003)(486006)(356003)(106002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2483;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD004;1:X3R3yIoxhasxQNUw9KlXiX3Xlb5Q/dUDAMGNnz/gldnTMu8wLKhWvGnJZmaweWc/f0wfnKXWdzt4mlmc7F+ETK8V6V2BAAPV3UgZ88GK3d62Elk7glycvla7eG8sV3sF
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR03MB2483;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;3:HWlEeWVtiu6//yj23DpG4bauSG4Kxxb3PAmhm7ffUrRurVZQs+PdHYC/dJxvYDg5iYsqqsXK1xwBSwA74+vuIjziBUW77ReEWhj/2zR6nIAxsf3PuJpN5Dui9bIyOBB3+yvQBWO16okz4vSitCcW1WxknFio3WOAUfy5mrsc81niYJVruX4ZzWrRhpm4Pdbi3dTGV2Hut2+qs8y0mUwV4CFqCSsWiGHHtI1JUap0N5fbrWNwOAUDz3e/h8sqWCR83Fd/oGyfbnIDwMLzZp13YMORFj4tpaxZQ5Yd9iSq3fFv76Z/Jc+GJYBVPQf6scK+uMT03X70FTbx6sdqIPI/jMmPnVoUPGAB84gi+7BZw60=;25:viCCVfuCGN2A65I1YIHOhff4/fsbBikhy/+/fMPsXYnBLhL3PcCvE2ubloXbOEYDJ4YJpeL27lcZGL45X2srru/feQ10Bq4nzWtMg0eibw3txLr87f/g0jBgT+2BiYzySdibsyICTqpEt640Tq/pz6zLnWMfoyFOx11/3+odl5NUTtj1MS+ef81jMdZMYiOQdRGYkdT5X2J4j0Pz3Nfq4ZIP5hVrZ7JJgBRS2EOPucrqjIz0qHbUXKSde+P5rToZGV0fwsTzu1DOb4Q8yho4/V+ioYWs2/vqlXracqwQiluf2JVd8FE7YgEeo9vt/AY63VKMHhGAnFcgsf/MIw8bdw==
X-MS-TrafficTypeDiagnostic: BN6PR03MB2483:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;31:1+hy1RMvK5BY26XrgY18ro3wQmr2Y5W+h12u4x2TR2JechT5gxeoQ4RLdomFTeLdHLk+i30GaiTc9R7493BkzscFf+YOmftX3DPKm3LLgbXF4Xu3k402+oDv3HT52paWIfBgLBBoKDwO+kCgX8HpNlAJ/+i6pJvV8tt4Z0M8gr9uIN32ZfKLwqsxde7vC3kyy5t7e+QRKe7m/mhYsmME64El0uNIOAJVBScS79k84ek=;20:O0ISV7EKAf+XVXq7AgTZ83Nhmywt2GqbZjbOYdkQz5D3cQkmtEJXaFj5atgM1jpFYtH6S2qh0h2PA0G/y1x89RYO5WYI+VNSbn1A1dFFHFfqUjGpFyTJr1Qh6uVNAEpwn+0ot7ah6fpWj0FRv5w3Ny018IESS1c/RaCHhEOBmdPCPhB95sCuJumgF6la/lXMnh8RicFDtBGazn1cMiOWGBM7Mmnrgic0iKmRmqMBwGifyrPEh2/TDTibI2OSubDKlk+VC1TpQnK3uvd3qQ5aUL9sQyFpZx0FbwmNfh0YkkLGTV7LH03ZafFEym10fhEdMfvtP/vW1JQ46FIuVVEXE3GGfTyYV6R81GK+iBpXYXqhgOESo9E3vlsjaDeROqxjZc4QT92IDE/kQjyq4Rc9TpwItvC2bE2Iu3/yJL8xVq1WT8n1j/XyiFd9+BDKwX3QYQSVVeImWaGqZ1mgLLFQClfG42LAtbx880j6iDLMtlTWTIJozRnaLs6ncZUmfLSP
X-Microsoft-Antispam-PRVS: <BN6PR03MB248307C7B74754075766486E9DBD0@BN6PR03MB2483.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR03MB2483;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2483;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;4:lgalSTrQu5uo9IsbUVw0pQpqsUOm7jBp/miiz2jmZ281JL0FYlLy1xtneCkQKHTUSZvC3E/u2aq3gksS/J6LxrXY47seTQ0N0Uv/HUsTMHj5a+ciEr3qj+7w2YbN6ye9vWGR0Rc3Imh0Wd4fFOmdobLzJUTX7BWIZcMAS/f60Ynx+LoT25XnnGu/WjvD/SjgHewWGv4182N7SrJnriT1PwJugf6/WvK0Vbj+EooDZusJ0qcdEk4C2EnzksgoVwy/+ytvubmDoaYqEyKblVNi8rTWSBv5/c88tETOFUn4rnw5EQOYOxCCXAfkaATIKxH90epFWzkr1RLTlkwjjnsC4NP31a70TJYLFcMJik2ebfE=
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2483;23:T9675UY3IdGg0UgRb4kz9dkRWupOKjrO3SVXQl2FU?=
 =?us-ascii?Q?/j5mPcfXMtKxWWAePAA3ws7ArRKXJ43NZL2dHBW6fEhcjTutzuw1VKgyrIc+?=
 =?us-ascii?Q?eIQZ9QrXcTDY4dGS7XEpEX20QZ5aEDe0onhjdc5i1nsKZz6fbuMQolq+Sz9u?=
 =?us-ascii?Q?Ks9/JNIGLefIbBG0d9Lz9HTJoJzZ8SHiNUEj5i2BIMZk+GOLLk24PpATBJ24?=
 =?us-ascii?Q?HPPTuEAoEvE7+PIjn74ie10iqEBx4jwwrga1BGjjusida/Xg+LBOPnwLBK1r?=
 =?us-ascii?Q?0cNESPQah3oggcxLeiJLDY7zpTXYklRY4BGow9uo/xIhZk0gk3FczxVm5SDF?=
 =?us-ascii?Q?WtqmR1t2ol2mmBzJFIBhnvIalChOez/3GdDjHmP0ceCd8reW0kJ/DJQz7j9p?=
 =?us-ascii?Q?fewxB82HDNXnJUqFWDYqx8l+QvnORHfI1j51MAEQqRy4XVyX7eeprlMYEmg3?=
 =?us-ascii?Q?W8D4u3/+tQf8GG93RAgj/N7ZovmS00IcACvac0uNwTHYFUr2CzCejJHr7zZL?=
 =?us-ascii?Q?xc0ZxBpg957DLNFB9/qSoDYzrWDFeI7yqubRZ8ccpZeC1JEhtkP+Kjg93wea?=
 =?us-ascii?Q?1Eprds7c43Al4LhgSRauGbXYKd4pOHSm9dS6vZE7/RozkLke/fZUP6elxVYW?=
 =?us-ascii?Q?q3cMf0QsQz5abSsHqAsHczzKGzM0gZQ/bOmi2TW852v4u1MhPayYuBpASXdF?=
 =?us-ascii?Q?jTCdTswCiPuR0BsNp6mJ/MOFxR/w3rdkyYKxPHBThKsbwniarvF95nlwcLk5?=
 =?us-ascii?Q?Fwjms8uvsuLvnw1NHnJIBOTX8WYWbiY3jl40VYY0UI4YUtoRxei0T28BqXnn?=
 =?us-ascii?Q?pPo9HRGe5wrEsvymdIoH6mJk/galJBe93chC6HU3cVFh3CPmccU84xpIC/ZL?=
 =?us-ascii?Q?W/Haa9TbsCltQKebkoEz0uvY0HA211jngULafdWgBto4CoLJpf2dQcz8NImg?=
 =?us-ascii?Q?IDulIYKOXImnfYrT3Y6JdvWgRITNC2tMk5UPLts6ua8DQDWo2BE5jimLNwK+?=
 =?us-ascii?Q?vBG1/LTUFo95vQHEpy2ETsFiv2YxMXYkDw5jsuskDGaIOghualmfXxdh7a/K?=
 =?us-ascii?Q?rS7fepoMg8b0bMs2E8hP1ADeFAU1LFezQ6ePj8rOVAyLWdZfXh2QKdWItuNC?=
 =?us-ascii?Q?NlnnEwXcqscObcvbLsQyXxiGEHc5wJH0ZQW+ZVOzYBMZB91n9rkMTA3XmIMV?=
 =?us-ascii?Q?P7YF5AvznOC8xM=3D?=
X-Microsoft-Antispam-Message-Info: S984cf5/vkK0jUVMV9UV3mHa9qI+NPJ5i8EJ3UhLaoRc7WXpCw0KVcnwvy81Y1T/j8N7k2lVAD0mC8MRu3XZi1l0Xetlh2W94m8Jhq0yHdAz711bO8uzt0PY65e/nvE5k6HHIlRmGzYSNOjP8k6iqf10PD2zUzvfZx76edMT8/Yi8mmR70XedfTvm6+QbQAc
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;6:s7yQSFRhoCdArzydC3uL96VjREVDep3T76eFSwTzTAomPti3SntoU85FuKv7mA3ZAmEMYvhmSEZX3tfz1nBL9mgpslFyb0RcEad2gUqd9ZGJ7Mwe8Loh0OrtP1/HoErX2K6Ml/CKxJiijCPwOAlsy/2klaVC6Z3Ai8VqfQPLkUCNLq4yyUFP8iQgL+wkG8o7tYBNLiSGqFvLxMckmhVMY7oXKumPswS7gyztA2VqxUTM/puTSwyPc91Wg25uRSMKthxe3qf6fbApQDVeXeAfqLeYG8sgKj165iWRyoV6EKTh0jV2uUEYnHpOXy4evVVid7jY/vjPrArM8JiFYa6iXIbusny3iAefXOpZ5Iyzkl4h3gGkSd0zhLY8J9f0unEsHz5qPX18f26SbvHyVKCec5QkoDYt9ozYMQq8t+wfcAc53repLwu2lPhu3KCW65Py34RGW8YZaP6n5LHASWbxNw==;5:Po+9SBGJMMksuohlVo1W3/VP1R1SbwKj7YM9eFfoW1UXY4Ffj5fpuAepij0VgjrIUJ9TyS+hMv7z8560Ef5NR4oI/5vMALIO2jzeVWoPsE0BUFpac9lHYw+ol5fG54Lk73zStgClKR3a4uyq2Nyy5oeBXsX8J4hEnK45SB0wMjw=;24:D50ul/60j3KLljnR/gY/ix8BD+iDfrlBCvwMGl9fXCAKzgi1eheI7dLHmtPy8/0VVHFKVCCYMtBMP01V/CxC+z6MLMfX4AJfp4NhBKH+M48=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;7:m/ZygoMbTYj+m+iVJzYfjX+IhVveqro80pWXs4dW+0brVy6ato7PX5BPiAkZ4gc+gvd2q8V6RzVgZJEVSBYDYirNuDgp4fU63ctNc8RFgg+R3VSX5L3bGxji5kKDmrQhINprHttqQlTuZ+DVi1EgzMijnOP1LwavivnRD0ya3nPbHlPCF7ZLP2xAVm9dUEX1LNvzhtOAAVBayxZKQdXWoQp4xcL5ue3cCqXHYDkpj+ygacFUmlDrz6n3TG4pOqFC
X-MS-Office365-Filtering-Correlation-Id: 30968bc1-e763-4304-bd6e-08d59fbe6d3d
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 15:10:56.6754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30968bc1-e763-4304-bd6e-08d59fbe6d3d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2483
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596802879382904823?=
X-GMAIL-MSGID: =?utf-8?q?1597463028058583553?=
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
	  charging_enabled_show() and charging_enabled_store() functions
	  from int to ssize_t.
Changes in v3:
	- Nothing changed, just to follow the patch set version.

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
