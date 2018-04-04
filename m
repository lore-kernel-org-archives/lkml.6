Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx4+sG+NI8EopBemBRXVdV/5n7U0irKr8vTlfkZqcVmMG/43AqFXvx4FAKFiUTtyr2r9kUIxG
ARC-Seal: i=1; a=rsa-sha256; t=1522829871; cv=none;
        d=google.com; s=arc-20160816;
        b=L9AsD7ByeB9ubBP5Xsq1gZB5Q33BZqS9ywkLfuDwciix+AToUPxJkpKzNlfzGCWeYG
         OwVC0lGNdHnJxsPw9KxGdfXj78/xRmivG70mgLyHg2tRBSQcCpMYyreBeOXFGzjpYly5
         kZGQseKe4yb1XxRgJI1hnQw+LBEi0swDGgQHuJTHm3fSPxjQedZEHItVRdRPG8LRqlIF
         WAK8WWAE7DuKCWBnJP0T8Tr4AOhrYN47zZExO2jrId+w7Y0aSr8kRVjUqj6QsVC0nfTa
         iyqTP/HXfdZjKdW9MkYPF+6X0wonAdig1g6X45pVhGlCLlj+NVckTetB++BiB1yLrVS1
         xsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=U3Z/uIjE9qPr48B159sw7XEXA3Adc9xzuwncEps1LT8=;
        b=k2FMswMG1DRiUvFin61zLiwy7+IJdDxKeF/Vtb53V6WI7EhgB7TdtPpyDUS0WB2xbY
         Egtq2qAGUdV4nhyOSek+aZOsmiMc3FfNfcwocEgPE3rzXfW6nUJWtEEvGx+siVdl+cUC
         /AVX0W2xp0NJ5MnsVIACAwOjVmU9R2Cshsw/11HpEmSImI1DNUX2ZVsPLOhQiOsT/ibN
         2/zhMvPGluIcQlyXR+hGKA9x+PvfKBjlfQ6uocmZ1MreV3OwYCzMKo2NMZFeLCUd6riR
         gLLakHbVSz0iKlhCoVUlDqEl5WGIK6Ps0+TnKPOBTs263vnzbCmbw2VC3+RhyUIyRLYO
         B+4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=Dp2AW9RQ;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.33.87 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=Dp2AW9RQ;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.33.87 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
From: Stefan Popa <stefan.popa@analog.com>
To: <sre@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <davem@davemloft.net>, <mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<rdunlap@infradead.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stefan.popa@analog.com>
Subject: [PATCH 1/3] adp5061: New driver for ADP5061 I2C battery charger
Date: Wed, 4 Apr 2018 11:17:12 +0300
Message-ID: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(966005)(7416002)(246002)(59450400001)(316002)(2906002)(6666003)(36756003)(106002)(107886003)(106466001)(1720100001)(6306002)(7696005)(5660300001)(8676002)(77096007)(186003)(476003)(575784001)(8936002)(336012)(48376002)(356003)(49486002)(72206003)(26005)(6346003)(126002)(2616005)(50466002)(4326008)(426003)(51416003)(305945005)(54906003)(478600001)(50226002)(16586007)(7636002)(110136005)(486006)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB393;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD018;1:c4FPhNioq5jMbGMKJtp4juTkKIy761sGOUZ6Jc0GVLXuIa76ZKUy+P7292wNFab7RIVha0xojZouOPmSIfL8SZ1LReVtrl0JkY3LQqooMa5Nv+BIJTWTFgpWwS1AWm1I
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 196aa716-8a9e-4230-eead-08d59a048d70
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR03MB393;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;3:sjZcc14n/wrP75+tAxUgrQ2K9PeXaxJr8hpAdWctDmpaX4D/y6V3Sd1dFkIhuc7/tg1RQr6Tpvov1sE12sQ7c3iCN093nxYsqr5JhtOHfYLHzml7sWr+/UqsDm8eoIRxygsqNe3kHpSaMkMFmvBFRcXchQJiVqZVSu7lR3DBsB0Ef7rIuCH6aOerAfgias/rwa2qpTVKrwVjtL1RdTufEBQ57QjR4bElzFELCno/eXoKTMALProesRUVwgHRvap5GhMkQj8bf9RoI+YP06z+AV10zqOBMp6eRymytz38HJgWTWJ2UMrE5KGgjCijQZqMf/dNzPXKeLHbuCr0ieDDTKpmzd0oD5OHRdSl9nMT4l4=;25:XsOwyyIxRo+Vb83iGljHe9/xMinuo9Znz39Ve1v2ZWmkYl63YBg8gOsW9hK3K0ny3Z5+C7yBS0VFiCLZrbh3vjLAlaeKFK7Fe+cgDQzsxOTzK2hkMtCG+GYf90T8ZKckXvyX5mG0vrb30K7nwcXcCSbqPYLBGJYbc1i13IKsbBDuWxexsHD/cuPu2oR6pvf4TdH7HZTrAsbCkf5XDeav0XU0HZXf5g2EYxVdBnqVT+BZAsHSkOZw3JWX6nNm/jSQJGhH7AIC4vvD0d8ORcBj+fVp9qojombyrCXgfI4aj3y4RDT2z3KW6GToxvOHujxtlJ4VePlm8/QeQzmgWzdXSw==
X-MS-TrafficTypeDiagnostic: BY2PR03MB393:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;31:VHyounD3YgMVyap6leI3Ra6GJDXUsqMd/R3HBTjn/+cPbOAtBLGXzC3L/sN87pJWQZU79O0AwVO9rS/nv5uo4Oz7KDBdtr7oeiLZnVX/X9NQnMY3Cv7HvvEL1iZ8yI/GTr4FdyZ6zCRj1+G4r4QU6X7PjA90MG2Pyijf6eHsvJiCeG6XqeUzVYT8lHULw8dnDvsMmJ2JEyPRRlp4pk3aLyzOPJXcvkt5d1uIIdUKRn0=;20:v7GYc43vBSuD8m5umr+mPrfsExkPvrmQiT9bA0FmilhIJ2ZIFdCXnftdTesmXoyVCw8IEkmmPFVkjTDXidqq9QlWKxUF29hNGY60hnvNneRsWdSrNy6VGelFGmHnn0KvhcyCuOuK5jd64az7clMmI1yvTR/s3VJchdL7N0QGeJJEkYNuaJcdm595x2HTf1Ua6rBEb/IbnY/zBcD789cKDNo8WtDwiX5xw3oQwQXAmWx74ezbaIk/Ec78X/cOvv1dBjKIKzEA+E0DEX1boo2HRYd7dwMK3RnwrZRwyf1bapgw/aCNUetdhCDpphscE+E9fdD8JTfeIsuXr4W7mHauGCv5xl+TWAqIZXASzRgrs88Jfp5S4aOYkV1DXP5duno/C0cQKdYvMkrFpwQ1olIfwV+NhOxc9alV4HcEhrLqHA8bEChCTa8Hdzal7dvL79l8/pdMWXPa6apbH2fhSfO6K8ebbdLF5wbsDLzP9GDSq9wQZL/3qf9+KvNvUfreRXVY
X-Microsoft-Antispam-PRVS: <BY2PR03MB393D93F21CC9D358DF266C89DA40@BY2PR03MB393.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR03MB393;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB393;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;4:d6O4uppftaGogZZ+G8oyj8qccQ3BXie4nM4io8GQKFUywrCYv1ln0S0bUaN+p0R7JY4YrjonMOfvkZLym0JGjkb51sNAoFxqohmGzBAia9wX9X/ZQz7gVHbABWvj6PM9ntRDZ4HFFp8SmNHLnq36npLtH8OyaJ9ZJ9ynmHhSA1LhmNKpSYO2KalK4tOIBCQRJpJqhCEdswnCao0Msjld5IGif68xX3LgVWwK8ghpnesC6OTuBs0B287CyXXG8m7AYFZ9fqmxvqmQV4A4iJ9pz+K1BBJreZsEAAHX7PnYohCaB2BaCV/S/ZaMiakD9oKZQsS7r9Izi/xL4AZNmILCID8GrJNGq/xju/tT/KtxW4A24evHFkJWgCqrELyT9OE6duyM7d37F5zCnwwuDDOc0/gSS85b0S+tulCtkKSLWXE=
X-Forefront-PRVS: 0632519F33
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR03MB393;23:xd7DHe2pS2bgC+vvUyb+jA7GaeLv8CxlEk28kO6b2t?=
 =?us-ascii?Q?h4sXkM3nDk8cpMcrGVbEjxwhiikq2YzOPWql6xrqNch1hnSI8MumN9n4ukqo?=
 =?us-ascii?Q?lJG3XlAIgVnaCHfVK7UPha5zVZD9+afeeP02O8guviBQygJOd/r7sN5wsO6u?=
 =?us-ascii?Q?/XkFvAmwZ23KBD9JesisNvE/x80afh1opjR3uYiYqQ9qwz1YMdrC6zJz7weW?=
 =?us-ascii?Q?WKAmB3mTpzXofdTxBkeHNaPNAjPuauWVnVQZCYAuQjCnGeQvgzRFoUCholIt?=
 =?us-ascii?Q?euth/1HXZ6Bm+h+TiLqun7TGw2LkEKfsYcRLwxpB0A4qmSMYQm5fe4NFvFLT?=
 =?us-ascii?Q?9qfUANvkmFUpXr8Ft6mTNW56GmNVTofybSay4/vKoQahYphVWSHPfRZT/YBj?=
 =?us-ascii?Q?7f1K0MRYuMYdxXA47sclyqUbwf/yL7K+Oun/YPdeesACRsZxlwZVjcFMh4rt?=
 =?us-ascii?Q?5FS0AaT97KB78zsJvVI1DeiV/SnY65498C2tH4yqMS+0kbPmKOeyZcRfQ1eT?=
 =?us-ascii?Q?B6HnkRu4HItwuVpGL3iNOIsrFdLZ8egEk+LZob3S4vUgSGM24lzRhGcZS7EW?=
 =?us-ascii?Q?ptNoO1DJnEqIXiuoIiCmJTEz+OeBuYxjaiOaLVBM2vW4utHOQgA7k16MNwVo?=
 =?us-ascii?Q?S5Z+7lje4QAdIRTq6gVBYnpm29Nxv93VuC4rII0GY18cTXKLxoamyOyEFA+d?=
 =?us-ascii?Q?UPsFquRbDWLT8NBp2PSLPOmBQ/RYtmf+9CWQ5gGNPaHD9S3jHZK4atdCTV+b?=
 =?us-ascii?Q?yf9Vzizw7T3kd7NritKQAeCgzeVjtvJb97rZtD00VhzInkbb52Lwhb9KKQi2?=
 =?us-ascii?Q?YfTlGD+08MPuFxFrStr3LP6CEPZyZF/uuX9rPEMK/QOos0NiYUNWAUBVkBYH?=
 =?us-ascii?Q?p4yC/mtH8qgEu+uS4Fe5tReBfPRGKFlmHjTyxu2E105hMDGOGiH8s5wRu8Es?=
 =?us-ascii?Q?PZnpz+MJ1+qvBW/yzEa/jJOoPYykhcykAbryTbSXcMTFS3x/YD0Cf25YlFXX?=
 =?us-ascii?Q?+hOMoEal7ZSdm+9J6c01qLkcHTYbbh5iGlp3LWXtKtwFeA8IAEYs25Z5VD/3?=
 =?us-ascii?Q?bGiQth4A9ru7jEdjqCDcmXLroRY6srzGrPlnfDNcauzpsRF01n/yas4gJP0H?=
 =?us-ascii?Q?3kk0Y8CSpCKnbUndbn35HOjEzGjreiGErGIBdpdi2JBDpg8ULHJw=3D=3D?=
X-Microsoft-Antispam-Message-Info: H/MRbG6x2gui4J5O6NVGp8VAuo5LLs/7E3Ixkx+Pnw4oBMR3xQ74tEjuKT2kGE8Hol25PzJ4rUoHswHGZwASWB5ygGjScQ5sfEpj8QIIW/IcL4qHx97txktqxV3K7OzhSyHEhQ9/yeScox6EemVUbGB5Y3M5oEm1K44LsC9NOM1TLhifKtxzpxewsAAdzWTz
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;6:hI8VWQ9ImHfASfNhPSPFgtUn5LFHNSiQPCUWMBsGfsOhS/4lSC646WmqFiRjP0mxfJ7z7xg3ZFVw8IgKUf9C5dbYuX0A02z9wQxUhc0StVYUIDGZ4k+r5la7BLa62BK6GDDE7QJ6bECwq+gJ0PTMqjDbx8RblGR3CiyuW3stAfS22d4PpN6ieLFmNS/hFkycJR9l6TU135JPZ14QJ6MZb2DOZrsirPK096OBXc2CQwJ+eeWB5GxseA1pDAOcC4iGfV35knVHdlcFFiuzPriZNdkSKs7Mrk/2LuPEWnYAuE5NyfxUlJMQjBYHb65VRvGY53VkvVsTvrc4dvFhsDcHsqDoBO92hQBDG+Iby8rSyAuwiQ4IKQnyYWsgyoVjwAujn8CLLdcz7UTJAbs2/DB7SIjIm24vJ9wWjpxQxHIwDHnkAfH6MTonXYjovb/+qaUcH4r8cNxqpLgrsgJOnLZt8A==;5:Cbe9m+C+piMgEX7VcFaAZj2bdpXUWKLler4CS9zS6DSQWQ+u1wBCCBh81lL06BDKSTDbY5Hpr+CIiPff75wgt2bxUNH921IcHZu+uDfVq1BWzrveJdaxImGTJEYhU6TXfeVkGJXtLAUKDWhrPhYqKfk8mYbnZcafgMYP/r3liKc=;24:SNAi7aanecftwCXyr3+uKgmXSD0Yk6CeN78iQ9FeD1rwOqshOi85gY6z2rkzT2CYqRn0VMpPhWp59Uy57Md2wI06EXbSEyIPGpNouRPBJvo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;7:r7msv0EjJLj9abpwaCUnGIvst3+fRZj0KC6PEeO42mzcNVZnGXstavncPZBLNDwpHA3ZwMMrp3H0qADd/TyR6VUcFdcrGAt69Rvw4pe9RWeiNhqhitx4v45L6C76u5Mo2tTfr21toOvfAjop1j26mN4rONR+uQAYJ2T49jDHNfRRkbQ1WtgPCqbVoLDFqfGx9L3UMET37z1oR7EUckAFzY6kupOOr4KnU8F9FWAzuvSRhd7QoDWAgOUTCPwTk4da
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 08:17:48.5080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 196aa716-8a9e-4230-eead-08d59a048d70
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB393
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596802855517909169?=
X-GMAIL-MSGID: =?utf-8?q?1596802855517909169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds basic support for Analog Devices I2C programmable linear
battery charger.

With this driver, some parameters can be read and configured such as:
* trickle charge current level
* trickle charge voltage threshold
* weak charge threshold
* constant current
* constant charge voltage limit
* battery full
* input current limit
* charger status
* battery status
* termination current

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ADP5061.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/power/supply/adp5061.txt   |  17 +
 MAINTAINERS                                        |   8 +
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/adp5061.c                     | 745 +++++++++++++++++++++
 5 files changed, 782 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adp5061.txt
 create mode 100644 drivers/power/supply/adp5061.c

diff --git a/Documentation/devicetree/bindings/power/supply/adp5061.txt b/Documentation/devicetree/bindings/power/supply/adp5061.txt
new file mode 100644
index 0000000..7447446
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/adp5061.txt
@@ -0,0 +1,17 @@
+Analog Devices ADP5061 Programmable Linear Battery Charger Driver
+
+Required properties:
+  - compatible:		should be "adi,adp5061"
+  - reg:		i2c address of the device
+
+The node for this driver must be a child node of a I2C controller, hence
+all mandatory properties described in
+Documentation/devicetree/bindings/i2c/i2c.txt
+must be specified.
+
+Example:
+
+	adp5061@14 {
+		    compatible = "adi,adp5061";
+		    reg = <0x14>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260..a9ca73b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -797,6 +797,14 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/ad9389b*
 
+ANALOG DEVICES INC ADP5061 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-pm@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	Documentation/devicetree/bindings/power/supply/adp5061.txt
+F:	drivers/power/supply/adp5061.c
+
 ANALOG DEVICES INC ADV7180 DRIVER
 M:	Lars-Peter Clausen <lars@metafoo.de>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 428b426..761cc52 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -75,6 +75,17 @@ config BATTERY_88PM860X
 	help
 	  Say Y here to enable battery monitor for Marvell 88PM860x chip.
 
+config CHARGER_ADP5061
+	tristate "ADP5061 battery charger driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to enable support for the ADP5061 standalone battery
+	  charger.
+
+	  This driver can be build as a module. If so, the module will be
+	  called adp5061.
+
 config BATTERY_ACT8945A
 	tristate "Active-semi ACT8945A charger driver"
 	depends on MFD_ACT8945A || COMPILE_TEST
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index e83aa84..71b1398 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_WM8350_POWER)	+= wm8350_power.o
 obj-$(CONFIG_TEST_POWER)	+= test_power.o
 
 obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
+obj-$(CONFIG_CHARGER_ADP5061)	+= adp5061.o
 obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
 obj-$(CONFIG_BATTERY_AXP20X)	+= axp20x_battery.o
 obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
new file mode 100644
index 0000000..c00a02e
--- /dev/null
+++ b/drivers/power/supply/adp5061.c
@@ -0,0 +1,745 @@
+/*
+ * ADP5061 I2C Programmable Linear Battery Charger
+ *
+ * Copyright 2018 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/mod_devicetable.h>
+#include <linux/power_supply.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+/* ADP5061 registers definition */
+#define ADP5061_ID			0x00
+#define ADP5061_REV			0x01
+#define ADP5061_VINX_SET		0x02
+#define ADP5061_TERM_SET		0x03
+#define ADP5061_CHG_CURR		0x04
+#define ADP5061_VOLTAGE_TH		0x05
+#define ADP5061_TIMER_SET		0x06
+#define ADP5061_FUNC_SET_1		0x07
+#define ADP5061_FUNC_SET_2		0x08
+#define ADP5061_INT_EN			0x09
+#define ADP5061_INT_ACT			0x0A
+#define ADP5061_CHG_STATUS_1		0x0B
+#define ADP5061_CHG_STATUS_2		0x0C
+#define ADP5061_FAULT			0x0D
+#define ADP5061_BATTERY_SHORT		0x10
+#define ADP5061_IEND			0x11
+
+/* ADP5061_VINX_SET */
+#define ADP5061_VINX_SET_ILIM_MSK		GENMASK(3, 0)
+#define ADP5061_VINX_SET_ILIM_MODE(x)		(((x) & 0x0F) << 0)
+
+/* ADP5061_TERM_SET */
+#define ADP5061_TERM_SET_VTRM_MSK		GENMASK(7, 2)
+#define ADP5061_TERM_SET_VTRM_MODE(x)		(((x) & 0x3F) << 2)
+#define ADP5061_TERM_SET_CHG_VLIM_MSK		GENMASK(1, 0)
+#define ADP5061_TERM_SET_CHG_VLIM_MODE(x)	(((x) & 0x03) << 0)
+
+/* ADP5061_CHG_CURR */
+#define ADP5061_CHG_CURR_ICHG_MSK		GENMASK(6, 2)
+#define ADP5061_CHG_CURR_ICHG_MODE(x)		(((x) & 0x1F) << 2)
+#define ADP5061_CHG_CURR_ITRK_DEAD_MSK		GENMASK(1, 0)
+#define ADP5061_CHG_CURR_ITRK_DEAD_MODE(x)	(((x) & 0x03) << 0)
+
+/* ADP5061_VOLTAGE_TH */
+#define ADP5061_VOLTAGE_TH_DIS_RCH_MSK		BIT(7)
+#define ADP5061_VOLTAGE_TH_DIS_RCH_MODE(x)	(((x) & 0x01) << 7)
+#define ADP5061_VOLTAGE_TH_VRCH_MSK		GENMASK(6, 5)
+#define ADP5061_VOLTAGE_TH_VRCH_MODE(x)		(((x) & 0x03) << 5)
+#define ADP5061_VOLTAGE_TH_VTRK_DEAD_MSK	GENMASK(4, 3)
+#define ADP5061_VOLTAGE_TH_VTRK_DEAD_MODE(x)	(((x) & 0x03) << 3)
+#define ADP5061_VOLTAGE_TH_VWEAK_MSK		GENMASK(2, 0)
+#define ADP5061_VOLTAGE_TH_VWEAK_MODE(x)	(((x) & 0x07) << 0)
+
+/* ADP5061_CHG_STATUS_1 */
+#define ADP5061_CHG_STATUS_1_VIN_OV(x)		(((x) >> 7) & 0x1)
+#define ADP5061_CHG_STATUS_1_VIN_OK(x)		(((x) >> 6) & 0x1)
+#define ADP5061_CHG_STATUS_1_VIN_ILIM(x)	(((x) >> 5) & 0x1)
+#define ADP5061_CHG_STATUS_1_THERM_LIM(x)	(((x) >> 4) & 0x1)
+#define ADP5061_CHG_STATUS_1_CHDONE(x)		(((x) >> 3) & 0x1)
+#define ADP5061_CHG_STATUS_1_CHG_STATUS(x)	(((x) >> 0) & 0x7)
+
+/* ADP5061_CHG_STATUS_2 */
+#define ADP5061_CHG_STATUS_2_THR_STATUS(x)	(((x) >> 5) & 0x7)
+#define ADP5061_CHG_STATUS_2_RCH_LIM_INFO(x)	(((x) >> 3) & 0x1)
+#define ADP5061_CHG_STATUS_2_BAT_STATUS(x)	(((x) >> 0) & 0x7)
+
+/* ADP5061_IEND */
+#define ADP5061_IEND_IEND_MSK			GENMASK(7, 5)
+#define ADP5061_IEND_IEND_MODE(x)		(((x) & 0x07) << 5)
+
+#define ADP5061_NO_BATTERY	0x01
+#define ADP5061_ICHG_MAX	1300 // mA
+
+enum adp5061_chg_status {
+	ADP5061_CHG_OFF,
+	ADP5061_CHG_TRICKLE,
+	ADP5061_CHG_FAST_CC,
+	ADP5061_CHG_FAST_CV,
+	ADP5061_CHG_COMPLETE,
+	ADP5061_CHG_LDO_MODE,
+	ADP5061_CHG_TIMER_EXP,
+	ADP5061_CHG_BAT_DET,
+};
+
+static const int adp5061_chg_type[4] = {
+	[ADP5061_CHG_OFF] = POWER_SUPPLY_CHARGE_TYPE_NONE,
+	[ADP5061_CHG_TRICKLE] = POWER_SUPPLY_CHARGE_TYPE_TRICKLE,
+	[ADP5061_CHG_FAST_CC] = POWER_SUPPLY_CHARGE_TYPE_FAST,
+	[ADP5061_CHG_FAST_CV] = POWER_SUPPLY_CHARGE_TYPE_FAST,
+};
+
+static const int adp5061_vweak_th[8] = {
+	2700, 2800, 2900, 3000, 3100, 3200, 3300, 3400,
+};
+
+static const int adp5061_prechg_current[4] = {
+	5, 10, 20, 80,
+};
+
+static const int adp5061_vmin[4] = {
+	2000, 2500, 2600, 2900,
+};
+
+static const int adp5061_const_chg_vmax[4] = {
+	3200, 3400, 3700, 3800,
+};
+
+static const int adp5061_const_ichg[24] = {
+	50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650,
+	700, 750, 800, 850, 900, 950, 1000, 1050, 1100, 1200, 1300,
+};
+
+static const int adp5061_vmax[36] = {
+	3800, 3820, 3840, 3860, 3880, 3900, 3920, 3940, 3960, 3980,
+	4000, 4020, 4040, 4060, 4080, 4100, 4120, 4140, 4160, 4180,
+	4200, 4220, 4240, 4260, 4280, 4300, 4320, 4340, 4360, 4380,
+	4400, 4420, 4440, 4460, 4480, 4500,
+};
+
+static const int adp5061_in_current_lim[16] = {
+	100, 150, 200, 250, 300, 400, 500, 600, 700,
+	800, 900, 1000, 1200, 1500, 1800, 2100,
+};
+
+static const int adp5061_iend[8] = {
+	12500, 32500, 52500, 72500, 92500, 117500, 142500, 170000,
+};
+
+struct adp5061_state {
+	struct i2c_client		*client;
+	struct regmap			*regmap;
+	struct power_supply		*psy;
+};
+
+static int adp5061_get_array_index(const int *array, u8 size, int val)
+{
+	int i;
+
+	for (i = 1; i < size; i++) {
+		if (val < array[i])
+			break;
+	}
+
+	return i-1;
+}
+
+static int adp5061_get_status(struct adp5061_state *st,
+			      u8 *status1, u8 *status2)
+{
+	u8 buf[2];
+	int ret;
+
+	/* CHG_STATUS1 and CHG_STATUS2 are adjacent regs */
+	ret = regmap_bulk_read(st->regmap, ADP5061_CHG_STATUS_1,
+			       &buf[0], 2);
+	if (ret < 0)
+		return ret;
+
+	*status1 = buf[0];
+	*status2 = buf[1];
+
+	return ret;
+}
+
+static int adp5061_get_input_current_limit(struct adp5061_state *st,
+		union power_supply_propval *val)
+{
+	unsigned int regval;
+	int mode, ret;
+
+	ret = regmap_read(st->regmap, ADP5061_VINX_SET, &regval);
+	if (ret < 0)
+		return ret;
+
+	mode = ADP5061_VINX_SET_ILIM_MODE(regval);
+	val->intval = adp5061_in_current_lim[mode] * 1000;
+
+	return ret;
+}
+
+static int adp5061_set_input_current_limit(struct adp5061_state *st, int val)
+{
+	int index;
+
+	/* Convert from uA to mA */
+	val /= 1000;
+	index = adp5061_get_array_index(adp5061_in_current_lim,
+					ARRAY_SIZE(adp5061_in_current_lim),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_VINX_SET,
+				  ADP5061_VINX_SET_ILIM_MSK,
+				  ADP5061_VINX_SET_ILIM_MODE(index));
+}
+
+static int adp5061_set_min_voltage(struct adp5061_state *st, int val)
+{
+	int index;
+
+	/* Convert from uV to mV */
+	val /= 1000;
+	index = adp5061_get_array_index(adp5061_vmin,
+					ARRAY_SIZE(adp5061_vmin),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_VOLTAGE_TH,
+				  ADP5061_VOLTAGE_TH_VTRK_DEAD_MSK,
+				  ADP5061_VOLTAGE_TH_VTRK_DEAD_MODE(index));
+}
+
+static int adp5061_get_min_voltage(struct adp5061_state *st,
+				   union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_VOLTAGE_TH, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval = ((regval & ADP5061_VOLTAGE_TH_VTRK_DEAD_MSK) >> 3);
+	val->intval = adp5061_vmin[regval] * 1000;
+
+	return ret;
+}
+
+static int adp5061_get_chg_volt_lim(struct adp5061_state *st,
+				    union power_supply_propval *val)
+{
+	unsigned int regval;
+	int mode, ret;
+
+	ret = regmap_read(st->regmap, ADP5061_TERM_SET, &regval);
+	if (ret < 0)
+		return ret;
+
+	mode = ADP5061_TERM_SET_CHG_VLIM_MODE(regval);
+	val->intval = adp5061_const_chg_vmax[mode] * 1000;
+
+	return ret;
+}
+
+static int adp5061_get_max_voltage(struct adp5061_state *st,
+				   union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_TERM_SET, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval = ((regval & ADP5061_TERM_SET_VTRM_MSK) >> 2) - 0x0F;
+	if (regval > ARRAY_SIZE(adp5061_vmax))
+		regval = ARRAY_SIZE(adp5061_vmax);
+
+	val->intval = adp5061_vmax[regval] * 1000;
+
+	return ret;
+}
+
+static int adp5061_set_max_voltage(struct adp5061_state *st, int val)
+{
+	int vmax_index;
+
+	/* Convert from uV to mV */
+	val /= 1000;
+	if (val > 4500)
+		val = 4500;
+
+	vmax_index = adp5061_get_array_index(adp5061_vmax,
+					     ARRAY_SIZE(adp5061_vmax), val);
+	if (vmax_index < 0)
+		return vmax_index;
+
+	vmax_index += 0x0F;
+
+	return regmap_update_bits(st->regmap, ADP5061_TERM_SET,
+				  ADP5061_TERM_SET_VTRM_MSK,
+				  ADP5061_TERM_SET_VTRM_MODE(vmax_index));
+}
+
+static int adp5061_set_const_chg_vmax(struct adp5061_state *st, int val)
+{
+	int index;
+
+	/* Convert from uV to mV */
+	val /= 1000;
+	index = adp5061_get_array_index(adp5061_const_chg_vmax,
+					ARRAY_SIZE(adp5061_const_chg_vmax),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_TERM_SET,
+				  ADP5061_TERM_SET_CHG_VLIM_MSK,
+				  ADP5061_TERM_SET_CHG_VLIM_MODE(index));
+}
+
+static int adp5061_set_const_chg_current(struct adp5061_state *st, int val)
+{
+
+	int index;
+
+	/* Convert from uA to mA */
+	val /= 1000;
+	if (val > ADP5061_ICHG_MAX)
+		val = ADP5061_ICHG_MAX;
+
+	index = adp5061_get_array_index(adp5061_const_ichg,
+					ARRAY_SIZE(adp5061_const_ichg),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_CHG_CURR,
+				  ADP5061_CHG_CURR_ICHG_MSK,
+				  ADP5061_CHG_CURR_ICHG_MODE(index));
+}
+
+static int adp5061_get_const_chg_current(struct adp5061_state *st,
+		union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_CHG_CURR, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval = ((regval & ADP5061_CHG_CURR_ICHG_MSK) >> 2);
+	if (regval > ARRAY_SIZE(adp5061_const_ichg))
+		regval = ARRAY_SIZE(adp5061_const_ichg);
+
+	val->intval = adp5061_const_ichg[regval] * 1000;
+
+	return ret;
+}
+
+static int adp5061_get_prechg_current(struct adp5061_state *st,
+				      union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_CHG_CURR, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval &= ADP5061_CHG_CURR_ITRK_DEAD_MSK;
+	val->intval = adp5061_prechg_current[regval] * 1000;
+
+	return ret;
+}
+
+static int adp5061_set_prechg_current(struct adp5061_state *st, int val)
+{
+	int index;
+
+	/* Convert from uA to mA */
+	val /= 1000;
+	index = adp5061_get_array_index(adp5061_prechg_current,
+					ARRAY_SIZE(adp5061_prechg_current),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_CHG_CURR,
+				  ADP5061_CHG_CURR_ITRK_DEAD_MSK,
+				  ADP5061_CHG_CURR_ITRK_DEAD_MODE(index));
+}
+
+static int adp5061_get_vweak_th(struct adp5061_state *st,
+				union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_VOLTAGE_TH, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval &= ADP5061_VOLTAGE_TH_VWEAK_MSK;
+	val->intval = adp5061_vweak_th[regval] * 1000;
+
+	return ret;
+}
+
+static int adp5061_set_vweak_th(struct adp5061_state *st, int val)
+{
+	int index;
+
+	/* Convert from uV to mV */
+	val /= 1000;
+	index = adp5061_get_array_index(adp5061_vweak_th,
+					ARRAY_SIZE(adp5061_vweak_th),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_VOLTAGE_TH,
+				  ADP5061_VOLTAGE_TH_VWEAK_MSK,
+				  ADP5061_VOLTAGE_TH_VWEAK_MODE(index));
+}
+
+static int adp5061_get_chg_type(struct adp5061_state *st,
+				union power_supply_propval *val)
+{
+	u8 status1, status2;
+	int chg_type, ret;
+
+	ret = adp5061_get_status(st, &status1, &status2);
+	if (ret < 0)
+		return ret;
+
+	chg_type = adp5061_chg_type[ADP5061_CHG_STATUS_1_CHG_STATUS(status1)];
+	if (chg_type > ADP5061_CHG_FAST_CV)
+		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+	else
+		val->intval = chg_type;
+
+	return ret;
+}
+
+static int adp5061_get_charger_status(struct adp5061_state *st,
+				      union power_supply_propval *val)
+{
+	u8 status1, status2;
+	int ret;
+
+	ret = adp5061_get_status(st, &status1, &status2);
+	if (ret < 0)
+		return ret;
+
+	switch (ADP5061_CHG_STATUS_1_CHG_STATUS(status1)) {
+	case ADP5061_CHG_OFF:
+		val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case ADP5061_CHG_TRICKLE:
+	case ADP5061_CHG_FAST_CC:
+	case ADP5061_CHG_FAST_CV:
+		val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case ADP5061_CHG_COMPLETE:
+		val->intval = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case ADP5061_CHG_TIMER_EXP:
+		/* The battery must be discharging if there is a charge fault */
+		val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+	}
+
+	return ret;
+}
+
+static int adp5061_get_battery_status(struct adp5061_state *st,
+				      union power_supply_propval *val)
+{
+	u8 status1, status2;
+	int ret;
+
+	ret = adp5061_get_status(st, &status1, &status2);
+	if (ret < 0)
+		return ret;
+
+	switch (ADP5061_CHG_STATUS_2_BAT_STATUS(status2)) {
+	case 0x0: /* Battery monitor off */
+	case 0x1: /* No battery */
+		val->intval = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+		break;
+	case 0x2: /* VBAT < VTRK */
+		val->intval = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+		break;
+	case 0x3: /* VTRK < VBAT_SNS < VWEAK */
+		val->intval = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+		break;
+	case 0x4: /* VBAT_SNS > VWEAK */
+		val->intval = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int adp5061_get_termination_current(struct adp5061_state *st,
+					   union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_IEND, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval = (regval & ADP5061_IEND_IEND_MSK) >> 5;
+	val->intval = adp5061_iend[regval];
+
+	return ret;
+}
+
+static int adp5061_set_termination_current(struct adp5061_state *st, int val)
+{
+	int index;
+
+	index = adp5061_get_array_index(adp5061_iend,
+					ARRAY_SIZE(adp5061_iend),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_IEND,
+				  ADP5061_IEND_IEND_MSK,
+				  ADP5061_IEND_IEND_MODE(index));
+}
+
+static int adp5061_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	u8 status1, status2;
+	int mode, ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = adp5061_get_status(st, &status1, &status2);
+		if (ret < 0)
+			return ret;
+
+		mode = ADP5061_CHG_STATUS_2_BAT_STATUS(status2);
+		if (mode == ADP5061_NO_BATTERY)
+			val->intval = 0;
+		else
+			val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		return adp5061_get_chg_type(st, val);
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		/* This property is used to indicate the input current
+		 * limit into VINx (ILIM)
+		 */
+		return adp5061_get_input_current_limit(st, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		/* This property is used to indicate the termination
+		 * voltage (VTRM)
+		 */
+		return adp5061_get_max_voltage(st, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		/*
+		 * This property is used to indicate the trickle to fast
+		 * charge threshold (VTRK_DEAD)
+		 */
+		return adp5061_get_min_voltage(st, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		/* This property is used to indicate the charging
+		 * voltage limit (CHG_VLIM)
+		 */
+		return adp5061_get_chg_volt_lim(st, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		/*
+		 * This property is used to indicate the value of the constant
+		 * current charge (ICHG)
+		 */
+		return adp5061_get_const_chg_current(st, val);
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		/*
+		 * This property is used to indicate the value of the trickle
+		 * and weak charge currents (ITRK_DEAD)
+		 */
+		return adp5061_get_prechg_current(st, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		/*
+		 * This property is used to set the VWEAK threshold
+		 * bellow this value, weak charge mode is entered
+		 * above this value, fast chargerge mode is entered
+		 */
+		return adp5061_get_vweak_th(st, val);
+	case POWER_SUPPLY_PROP_STATUS:
+		/*
+		 * Indicate the charger status in relation to power
+		 * supply status property
+		 */
+		return adp5061_get_charger_status(st, val);
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		/*
+		 * Indicate the battery status in relation to power
+		 * supply capacity level property
+		 */
+		return adp5061_get_battery_status(st, val);
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		/* Indicate the values of the termination current */
+		return adp5061_get_termination_current(st, val);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int adp5061_set_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return adp5061_set_input_current_limit(st, val->intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		return adp5061_set_max_voltage(st, val->intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		return adp5061_set_min_voltage(st, val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		return adp5061_set_const_chg_vmax(st, val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		return adp5061_set_const_chg_current(st, val->intval);
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		return adp5061_set_prechg_current(st, val->intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		return adp5061_set_vweak_th(st, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		return adp5061_set_termination_current(st, val->intval);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int adp5061_prop_writeable(struct power_supply *psy,
+				  enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static enum power_supply_property adp5061_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+};
+
+static const struct regmap_config adp5061_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct power_supply_desc adp5061_desc = {
+	.name			= "adp5061",
+	.type			= POWER_SUPPLY_TYPE_USB,
+	.get_property		= adp5061_get_property,
+	.set_property		= adp5061_set_property,
+	.property_is_writeable	= adp5061_prop_writeable,
+	.properties		= adp5061_props,
+	.num_properties		= ARRAY_SIZE(adp5061_props),
+};
+
+static int adp5061_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct power_supply_config psy_cfg = {};
+	struct adp5061_state *st;
+
+	st = devm_kzalloc(&client->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->client = client;
+	st->regmap = devm_regmap_init_i2c(client,
+					  &adp5061_regmap_config);
+	if (IS_ERR(st->regmap)) {
+		dev_err(&client->dev, "Failed to initialize register map\n");
+		return -EINVAL;
+	}
+
+	i2c_set_clientdata(client, st);
+	psy_cfg.drv_data = st;
+
+	st->psy = devm_power_supply_register(&client->dev,
+					     &adp5061_desc,
+					     &psy_cfg);
+
+	if (IS_ERR(st->psy)) {
+		dev_err(&client->dev, "Failed to register power supply\n");
+		return PTR_ERR(st->psy);
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id adp5061_id[] = {
+	{ "adp5061", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adp5061_id);
+
+static struct i2c_driver adp5061_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = adp5061_probe,
+	.id_table = adp5061_id,
+};
+module_i2c_driver(adp5061_driver);
+
+MODULE_DESCRIPTION("Analog Devices adp5061 battery charger driver");
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
