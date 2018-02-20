Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x225CeFg1cp+s0q0a2bveLyBxcdDjmKMJJNJvfXjaOMsH0fhktwlF6BYfdA25I9QRwBNoYfuZ
ARC-Seal: i=1; a=rsa-sha256; t=1519154484; cv=none;
        d=google.com; s=arc-20160816;
        b=cjJ2cEwMUKugZ1m3MxIo05xQPV3e6V7T7bxBxIK8BotXBC3hKlPte47BJrO/gsqSHI
         dn5galXeTVCtph0MBMy17ZbPHstiTzaB59Ct+p7YeBbftKD3cQpDlXtTIEsUAaV87b7x
         9zgNM0Wpgn9CsQ8MFeyvlf2ApXKEWuuW3im72WgZlQeJDx6EjaLr/OMuenJjbJPu69tZ
         93Xt+vyGcGp6SryzimQySAkUxvLAgbvpaORrRTD6Q04mRQX2yy3ElCNuV2QF5/5xbyut
         /JCZ0Zjgkr4/H43E34QHq0roA3X3RypHFroTptG8yrkogp1dDiXmXNpvr0HN1bWK1ZvF
         yprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=kwqYO7WmqzbLzfeGcsUKTZkFdzPsIMSncVS1RNe0Yg8=;
        b=vITFhGwM5EZDvXcDF1tU3AZmMmlNW77UZxiNE5l2m+RV51AMSA33OzY1BxGk4cFFhz
         8Tp2h32HcMFOBZt07O5uXDHweJEnpJhdLb7tmuTnlsnydA4oaosOlxj3wyKoi8l4fmAi
         CeZ1Bl1By9D9mSXkXpocP9Kr6VQ+VUU+XQwDTgyXLsCdLRUHBjF3q6NiwIpaoRf8JxOf
         CXWm8nagPKf7IVprDX8MniEhLghZO01Nl2vDPOxaq1ll0mvQBa7EA0+6Pu4OPgNsJjB1
         8/Lw2xSf+Fmvt6PUtFykPVYd9FqvmT5spNFOsled0I3lm1hOQ9fcbemlVBTHLz63nsY9
         zn3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=3L+AJpHU;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.37.74 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=3L+AJpHU;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.37.74 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
	<gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
	<sudeep.holla@arm.com>, <hkallweit1@gmail.com>, <keescook@chromium.org>,
	<dmitry.torokhov@gmail.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Jolly Shah
	<jollys@xilinx.com>
Subject: [PATCH v5 3/4] drivers: firmware: xilinx: Add sysfs interface
Date: Tue, 20 Feb 2018 11:21:06 -0800
Message-ID: <1519154467-2896-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(438002)(50944005)(189003)(199004)(5660300001)(106466001)(2906002)(305945005)(7416002)(107886003)(9786002)(36386004)(8676002)(8936002)(81156014)(81166006)(186003)(478600001)(50226002)(63266004)(72206003)(59450400001)(47776003)(77096007)(26005)(336011)(2201001)(48376002)(76176011)(36756003)(50466002)(6666003)(51416003)(4326008)(7696005)(356003)(39060400002)(316002)(54906003)(16586007)(2950100002)(106002)(110136005)(921003)(107986001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB3379;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT064;1:4Xik4ZSD40dpX3civU5UUtb3C85epWRg8E4q2k5LRkxy1NNF1ZH6a4DTz5NIrOTz5zuK3+GD00OKrX5HGqYPiXrtz5btEiB+JPqXYqPxO81FAnH281b0yvf2NiuY6Vrh
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee54a964-f476-4095-9485-08d578971f61
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060);SRVR:BN6PR02MB3379;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;3:h5+Rq18txh09+zQOe2eKuB5yuMYjXHbZXnE4+HudzDw+p6wFmlvzrvhjTi3sBa3acYrRMAi5l5cjP09lyqkcXyRX94wv2GJrJQR/Ky+E4iRnfBNUovwE0ZSaepCAUWV6hY1/UrHeZNwYJ2PM+fQ0MCK1jBByK8lmKF7AVKgWeGjO4KlwBB6KevlpBUprCI4gvr/irQATYdHpRWtAHjN7cXXC/ySoBy4TvvhXIKxJBBd3ZVpBJg85osxJTcRZJT2pVKSNmdyxjE0FiSSHRISZmOLQYFvSOe+mSyb2zFNIUb5+5h5YimACHbxz/VzsW1F4OP+eT/ungNpRgH0iK3Nmt9FZA9HxHMBdq8WaRyUPObM=;25:lxoWrOe/ls0XT8vaanAzMDaNXP9rJbokE367h7TMZtSYXEZxnYiyuQ6d+1YwFakHTEA2NmPuhD1XNhFsISWfA4I6/J+8Vs/VPjGh3HxOhlWWF6UUmlhuQOcBDmKphdwTJRGPgxt4UhYReBeRNy1FUc5g+/gSyIrglY7Pvhu9ovqKePTVn/1ar3qfzATl5eZgLw6LCsMU4SEcGutnje7sCqV3p1v7cUUcS0pWZM4G4Y36o4Eq1YdP3m+D58YCGeD8gjL4TFCOqAUM8dOWedcGGDXRxsBordTrk4ljY6VsrwklteqOhpxIAKSzyTYeOAkURl7ENibZAhNC0g6FT5QgsA==
X-MS-TrafficTypeDiagnostic: BN6PR02MB3379:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;31:6Fy8GDY/15iGS8GFr68YEtCmRkKBScMLGoDPEM9LP7AgT04Vyd43zNiX3j0yFi6/bEtz9L3emQs1+HyBBpL2J2rzS76lSopXUaJMSVRBEbPLT6uUcgf8+vTtfE9rWGJpjZQfWiR+Tph1ZTUrW40qT67KErxnl8Zhkw7eRjQjJnryMtWplayf98jB0oP/xH9uAfL/Xie8htSUZjKWQVTHAZG2LKFKVXsj7K4pFwBsTwM=;20:Bn38TTQi7QZUe6TcvZg8TJej77VPDTru+TgRpFvKIfMZZ10VLMslW0SuSGr0Cs20+ahQedI16WJ3ThQu1EgU/hR65DZcKhVmz15HBnekaCDzkhPp5zeCuoz7zxYfjzMO7hi1sbjOGxoZI+uXq4fXyycd9D9pIZ3bNqGmLyzikFM+mj/i7XlovniQSlNLQX5KYuWIiguuYQ4fHUg9Yv21S+qa22HJkPQ5u39KoNO0chFCCmmoWKNqOphwcvmBVKuGWSnJrQwj/ozAm9RPMrQi+OlmoXrEuNvLC33wc21MAL3y2CGsGe1WW4MGZqfuss7O+ydmRHAJxr20Z9GelX1e2rIO6r6x4eJO/gurnQ24Fu/bXJPyHso0nQG9SYYKKOa/P6RGbvR9Orkxmod+xkp1bXQfdKuZ0Q7y+haOzn0AWxyAJg3N2MZlXAgS4bH9A9m4oacwAt0So9Hs5MfXurfuuPSjZiSWd2T0uUFTv1XPoa4WZPqUBsVIR9A5SPcSAq+s
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB3379A4A5FC0C46865B9E9F3BB8CF0@BN6PR02MB3379.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001058)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231101)(944501161)(10201501046)(93006095)(93004095)(6055026)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR02MB3379;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB3379;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;4:3ym7+yr2ZPKLxVgJ1Z90eAiinEpgmasuQwQrgoS4CeqVumC8bXj41ZZOT7x78J2n1eEFcEp+6jBvWaFDlJhySr8GqkZeHIIhIIlX1aqRHMWZhcl8v3gHHeuhG4Z3dpedfjQWHURyY0bz4i86M205NjiTr7sgPbcgv2/3HnX/i4r48/ARUnSFCLy6WOE3KhUA+3OmxZiQsT0xTznxyuuiFULhagu/mKrFS03pehZGTP9x+QXcYQMEFIdSTMxkovh/A9nFY95GCBs8kh3hziCZzJGGEyUmZGKIJMGSl8CX6hB2g3mq0c5ir4bVUUf8GkuB
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB3379;23:bCc7jNXb2SCb4ABza23ywgUiZYsLCoIk/xsGrP50T?=
 =?us-ascii?Q?VccsExDQzo7W7d2NWYTkf6ixUzIAGDO44k0JQbj1nZJv2jjUYjN5emWD9V4K?=
 =?us-ascii?Q?br4oBjGiM7MFkROgBw4H65EWBZM5jcd+4Nf7RdzdEovwYkOCDVMLvDR6O9jD?=
 =?us-ascii?Q?o4u4nr5KPw+tGlcUsSBdLxl9BOo2/293utamZoH9yBqUsZsJhWzQ9TVS/m06?=
 =?us-ascii?Q?/j1MQSZLxQ4hCRGD2q54iF3FxyqCrxu9mKdr9iq2YviQcD8N3tGhj5yjmTQz?=
 =?us-ascii?Q?3i5is/cTIAHTgEgrr0UPRzNDiNShUiUIAKBtdo7dnF4B5OSQFwwrE9GUXASY?=
 =?us-ascii?Q?GyJzQm0GXOXDoY5r3It+pfufnC0C8lq2Gg9VxgbAgZ0oAF24AncBkaAMYVuh?=
 =?us-ascii?Q?B2sQyXZt9Dkel1l465Z55cQt+etqp68NVvjmQUxgWOoH4xMNu87CS1JFlEC/?=
 =?us-ascii?Q?a/fXNbTANqfdyi5XcjC0DkMfusWfSMXHIP89Gxb2rbM2snVd9+AJhaEqeeHr?=
 =?us-ascii?Q?EAIs9jo8ZjH+uX8njiy0Lp62CMropMe1NSEotsdqC6i7Df9WI6gekRguCqMS?=
 =?us-ascii?Q?QsiZhMampep7jP9HfE7DNJ5CMEIqUri6Jb/OefhSYotgePV6mSPEAgENryV5?=
 =?us-ascii?Q?5YYbOHPug1xt23DjoqxLT/Tz1KbxPNjLPBMb6l9pb4lzSWYe6K+9fqOpbVyj?=
 =?us-ascii?Q?yaIXPr9pm6eFG5Hkip0JXEJ8FoQU11GdLmj21nkW5P80T6LSHZy/d2RfibmG?=
 =?us-ascii?Q?zZuMAeaZO2ZXvRnWpns6XSNXsuL30rRPawrEuCNsyLXmujLZG6wnniX2Xn5Q?=
 =?us-ascii?Q?3oGQKVLWZ9v6bRmTnrvc0H2JVvZz6hp4gLZy7hM7rgwYkswdNRj2NOpvGbEk?=
 =?us-ascii?Q?mpfylEh+WrbDU6+2dtfKdwjICF9UTeTxqgOWcNgRsPmHc6z6g7OIlaws/MxC?=
 =?us-ascii?Q?48DIVk2ioSEkSfnkyUXVRXzHced0MMljiOva6g4SJcsSywb4u2fBizO1Y6Cb?=
 =?us-ascii?Q?ZhdXDZ+QrONDBXm+xfnglpYvKQUfQhisi2KeYM02R9U8ziKKyJcyngboKdRM?=
 =?us-ascii?Q?YAIvqKf9Zs3Yb+Rh1i79sQOAVkkcBtQFUw7mOJGfLCQjc1qhvUzeEIn0Re+L?=
 =?us-ascii?Q?gOlJmkauA2MUqwhvUuES4nu9qYGLhy3eXM2t+YjkOTluSFaNf+AH7wpwC3Qm?=
 =?us-ascii?Q?YebdTAao1A5HaSIKVa11BIl+fM/NTz5eN4UbaGgupzHrJxKHL03NLTn7w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;6:ZYWRK53PoG1RL7AjVxcoenuvMpXhMHe1EdGtB6A3WzD3Mc8jq0HtJ9LfM24QImicg+UF5Wogthh2oXbaQZsVlGIAE4/CxFvOCZO8F18rWZC0OGsrhLml8O9L5FgOqCpbYWZrp5u5s4KVyfspg3BbBDEOOZNlXugKjDTxDIlUNWupLXiHph4hLe0Muk6snGglCBHM5iR75g7KpfSFbnKnIxdf+VJXFTk+fxca8Rc6Nke/pReqCIRvGnQPdCmhMJtPV5KH7RoWxxVSNn4LTgSDvY8FdTRVNquNduRFy0h3ByEScuOVv7KmnFBsWyylegSd1zaa3g3XrsaJNFYOQneRS/y/aPxy03QnpakFvTPP9UI=;5:c4ZeWH2PKcN4q6oCnR2IZsI35rYXZKNFIGRUuhSe8hoIet2hpcpQ+TMR6yxTPJ99D5UsRYjT4kv4UxIbsVvV3tDfGZFoEzZ3NJj2xQaFEgw6vfReTguLceRZ5CPMUAg8F8fjghyZEWdPj11CWGSvrWcI5wufQX4gxh2VU/Ou8OE=;24:jESSGOWW7VqR7MlY3gyN1krjXS8GQTilLC/HDgFI6TWDqyOod8Vk03EcrTp8hdV+pQn1en51wDK9DUmZleZL+QBzqagmMVZEvKHI+06awhs=;7:AOckFFTYqeGMwr8PqX69ztZAPHDt5kgLQ7k/riCnp6VcQWj2XFdf8BaoIGfnextQYIIiQxZUz2Xv2jorSMCXDb7fE4M2eLTP0GRowws7kZaU6DJNWTrWzH183mIQLp4t3YWMB96ZlOZvPaIr3M+IRUkMdYaQ4V2L79O6f9qjTqVG8Nv7hu863AoT/NUNZWODY0LVcjvduKuvaqSYKok0OrsRYt+Xib8x31xr2ezcW4omI6u8BAGCJ5txDur7t6yx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 19:21:19.8739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee54a964-f476-4095-9485-08d578971f61
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3379
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948932748631222?=
X-GMAIL-MSGID: =?utf-8?q?1592948932748631222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add Firmware-ggs sysfs interface which provides read/write
interface to global storage registers.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 .../ABI/stable/sysfs-driver-zynqmp-firmware        |  50 ++++
 drivers/firmware/xilinx/zynqmp/Makefile            |   2 +-
 drivers/firmware/xilinx/zynqmp/firmware-ggs.c      | 297 +++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp/firmware.c          |  13 +
 include/linux/firmware/xilinx/zynqmp/firmware.h    |   2 +
 5 files changed, 363 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c

diff --git a/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware b/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
new file mode 100644
index 0000000..b04727a
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
@@ -0,0 +1,50 @@
+What:		/sys/devices/platform/zynqmp-firmware/ggs*
+Date:		January 2018
+KernelVersion:	4.15.0
+Contact:	"Jolly Shah" <jollys@xilinx.com>
+Description:
+		Read/Write PMU global general storage register value,
+		GLOBAL_GEN_STORAGE{0:3}.
+		Global general storage register that can be used
+		by system to pass information between masters.
+
+		The register is reset during system or power-on
+		resets. Three registers are used by the FSBL and
+		other Xilinx software products: GLOBAL_GEN_STORAGE{4:6}.
+
+		Usage:
+		# cat /sys/.../zynqmp-firmware/ggs0
+		# echo <mask> <value> > /sys/.../zynqmp-firmware/ggs0
+
+		Example:
+		# cat /sys/.../zynqmp-firmware/ggs0
+		# echo 0xFFFFFFFF 0x1234ABCD > /sys/.../zynqmp-firmware/ggs0
+
+Users:		Xilinx
+
+What:		/sys/devices/platform/zynqmp-firmware/pggs*
+Date:		January 2018
+KernelVersion:	4.15.0
+Contact:	"Jolly Shah" <jollys@xilinx.com>
+Description:
+		Read/Write PMU persistent global general storage register
+		value, PERS_GLOB_GEN_STORAGE{0:3}.
+		Persistent global general storage register that
+		can be used by system to pass information between
+		masters.
+
+		This register is only reset by the power-on reset
+		and maintains its value through a system reset.
+		Four registers are used by the FSBL and other Xilinx
+		software products: PERS_GLOB_GEN_STORAGE{4:7}.
+		Register is reset only by a POR reset.
+
+		Usage:
+		# cat /sys/.../zynqmp-firmware/pggs0
+		# echo <mask> <value> > /sys/.../zynqmp-firmware/pggs0
+
+		Example:
+		# cat /sys/.../zynqmp-firmware/pggs0
+		# echo 0xFFFFFFFF 0x1234ABCD > /sys/.../zynqmp-firmware/pggs0
+
+Users:		Xilinx
diff --git a/drivers/firmware/xilinx/zynqmp/Makefile b/drivers/firmware/xilinx/zynqmp/Makefile
index c3ec669..6629781 100644
--- a/drivers/firmware/xilinx/zynqmp/Makefile
+++ b/drivers/firmware/xilinx/zynqmp/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Makefile for Xilinx firmwares
 
-obj-$(CONFIG_ZYNQMP_FIRMWARE) += firmware.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += firmware.o firmware-ggs.o
diff --git a/drivers/firmware/xilinx/zynqmp/firmware-ggs.c b/drivers/firmware/xilinx/zynqmp/firmware-ggs.c
new file mode 100644
index 0000000..e08f6a6
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp/firmware-ggs.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+static ssize_t read_register(char *buf, u32 ioctl_id, u32 reg)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->ioctl)
+		return -EFAULT;
+
+	ret = eemi_ops->ioctl(0, ioctl_id, reg, 0, ret_payload);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", ret_payload[1]);
+}
+
+static ssize_t write_register(const char *buf, size_t count, u32 read_ioctl,
+			      u32 write_ioctl, u32 reg)
+{
+	char *kern_buff, *inbuf, *tok;
+	long mask, value;
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->ioctl)
+		return -EFAULT;
+
+	kern_buff = kzalloc(count, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+
+	ret = strlcpy(kern_buff, buf, count);
+	if (ret < 0) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	inbuf = kern_buff;
+
+	/* Read the write mask */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtol(tok, 16, &mask);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read the write value */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtol(tok, 16, &value);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+	ret_payload[1] &= ~mask;
+	value &= mask;
+	value |= ret_payload[1];
+
+	ret = eemi_ops->ioctl(0, write_ioctl, reg, value, NULL);
+	if (ret)
+		ret = -EFAULT;
+
+err:
+	kfree(kern_buff);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * ggs_show - Show global general storage (ggs) sysfs attribute
+ * @kobj: Kobject structure
+ * @attr: Kobject attribute structure
+ * @buf: Requested available shutdown_scope attributes string
+ * @reg: Register number
+ *
+ * Return:Number of bytes printed into the buffer.
+ *
+ * Helper function for viewing a ggs register value.
+ *
+ * User-space interface for viewing the content of the ggs0 register.
+ * cat /sys/firmware/zynqmp/ggs0
+ */
+static ssize_t ggs_show(struct kobject *kobj,
+			struct kobj_attribute *attr,
+			char *buf,
+			u32 reg)
+{
+	return read_register(buf, IOCTL_READ_GGS, reg);
+}
+
+/**
+ * ggs_store - Store global general storage (ggs) sysfs attribute
+ * @kobj: Kobject structure
+ * @attr: Kobject attribute structure
+ * @buf: User entered shutdown_scope attribute string
+ * @count: Size of buf
+ * @reg: Register number
+ *
+ * Return: count argument if request succeeds, the corresponding
+ * error code otherwise
+ *
+ * Helper function for storing a ggs register value.
+ *
+ * For example, the user-space interface for storing a value to the
+ * ggs0 register:
+ * echo 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/ggs0
+ */
+static ssize_t ggs_store(struct kobject *kobj,
+			 struct kobj_attribute *attr,
+			 const char *buf,
+			 size_t count,
+			 u32 reg)
+{
+	if (!kobj || !attr || !buf || !count || reg >= GSS_NUM_REGS)
+		return -EINVAL;
+
+	return write_register(buf, count, IOCTL_READ_GGS, IOCTL_WRITE_GGS, reg);
+}
+
+/* GGS register show functions */
+#define GGS0_SHOW(N)						\
+	ssize_t ggs##N##_show(struct kobject *kobj,		\
+				struct kobj_attribute *attr,	\
+				char *buf)			\
+	{							\
+		return ggs_show(kobj, attr, buf, N);		\
+	}
+
+static GGS0_SHOW(0);
+static GGS0_SHOW(1);
+static GGS0_SHOW(2);
+static GGS0_SHOW(3);
+
+/* GGS register store function */
+#define GGS0_STORE(N)						\
+	ssize_t ggs##N##_store(struct kobject *kobj,		\
+				struct kobj_attribute *attr,	\
+				const char *buf,		\
+				size_t count)			\
+	{							\
+		return ggs_store(kobj, attr, buf, count, N);	\
+	}
+
+static GGS0_STORE(0);
+static GGS0_STORE(1);
+static GGS0_STORE(2);
+static GGS0_STORE(3);
+
+/**
+ * pggs_show - Show persistent global general storage (pggs) sysfs attribute
+ * @kobj: Kobject structure
+ * @attr: Kobject attribute structure
+ * @buf: Requested available shutdown_scope attributes string
+ * @reg: Register number
+ *
+ * Return:Number of bytes printed into the buffer.
+ *
+ * Helper function for viewing a pggs register value.
+ */
+static ssize_t pggs_show(struct kobject *kobj,
+			 struct kobj_attribute *attr,
+			 char *buf,
+			 u32 reg)
+{
+	return read_register(buf, IOCTL_READ_PGGS, reg);
+}
+
+/**
+ * pggs_store - Store persistent global general storage (pggs) sysfs attribute
+ * @kobj: Kobject structure
+ * @attr: Kobject attribute structure
+ * @buf: User entered shutdown_scope attribute string
+ * @count: Size of buf
+ * @reg: Register number
+ *
+ * Return: count argument if request succeeds, the corresponding
+ * error code otherwise
+ *
+ * Helper function for storing a pggs register value.
+ */
+static ssize_t pggs_store(struct kobject *kobj,
+			  struct kobj_attribute *attr,
+			  const char *buf,
+			  size_t count,
+			  u32 reg)
+{
+	return write_register(buf, count, IOCTL_READ_PGGS,
+			      IOCTL_WRITE_PGGS, reg);
+}
+
+#define PGGS0_SHOW(N)						\
+	ssize_t pggs##N##_show(struct kobject *kobj,		\
+				struct kobj_attribute *attr,	\
+				char *buf)			\
+	{							\
+		return pggs_show(kobj, attr, buf, N);		\
+	}
+
+#define PGGS0_STORE(N)						\
+	ssize_t pggs##N##_store(struct kobject *kobj,		\
+				   struct kobj_attribute *attr,	\
+				   const char *buf,		\
+				   size_t count)		\
+	{							\
+		return pggs_store(kobj, attr, buf, count, N);	\
+	}
+
+/* PGGS register show functions */
+static PGGS0_SHOW(0);
+static PGGS0_SHOW(1);
+static PGGS0_SHOW(2);
+static PGGS0_SHOW(3);
+
+/* PGGS register store functions */
+static PGGS0_STORE(0);
+static PGGS0_STORE(1);
+static PGGS0_STORE(2);
+static PGGS0_STORE(3);
+
+/* GGS register attributes */
+static struct kobj_attribute zynqmp_attr_ggs0 = __ATTR_RW(ggs0);
+static struct kobj_attribute zynqmp_attr_ggs1 = __ATTR_RW(ggs1);
+static struct kobj_attribute zynqmp_attr_ggs2 = __ATTR_RW(ggs2);
+static struct kobj_attribute zynqmp_attr_ggs3 = __ATTR_RW(ggs3);
+
+/* PGGS register attributes */
+static struct kobj_attribute zynqmp_attr_pggs0 = __ATTR_RW(pggs0);
+static struct kobj_attribute zynqmp_attr_pggs1 = __ATTR_RW(pggs1);
+static struct kobj_attribute zynqmp_attr_pggs2 = __ATTR_RW(pggs2);
+static struct kobj_attribute zynqmp_attr_pggs3 = __ATTR_RW(pggs3);
+
+static struct attribute *attrs[] = {
+	&zynqmp_attr_ggs0.attr,
+	&zynqmp_attr_ggs1.attr,
+	&zynqmp_attr_ggs2.attr,
+	&zynqmp_attr_ggs3.attr,
+	&zynqmp_attr_pggs0.attr,
+	&zynqmp_attr_pggs1.attr,
+	&zynqmp_attr_pggs2.attr,
+	&zynqmp_attr_pggs3.attr,
+	NULL,
+};
+
+static const struct attribute_group attr_group = {
+	.attrs = attrs,
+	NULL,
+};
+
+int zynqmp_pm_ggs_init(void)
+{
+	struct kobject *zynqmp_kobj;
+
+	zynqmp_kobj = kobject_create_and_add("zynqmp", firmware_kobj);
+	if (!zynqmp_kobj) {
+		pr_err("zynqmp: Firmware kobj add failed.\n");
+		return -ENOMEM;
+	}
+
+	return sysfs_create_group(zynqmp_kobj, &attr_group);
+}
diff --git a/drivers/firmware/xilinx/zynqmp/firmware.c b/drivers/firmware/xilinx/zynqmp/firmware.c
index 6979f4b..02266d9 100644
--- a/drivers/firmware/xilinx/zynqmp/firmware.c
+++ b/drivers/firmware/xilinx/zynqmp/firmware.c
@@ -1049,3 +1049,16 @@ static int __init zynqmp_plat_init(void)
 	return ret;
 }
 early_initcall(zynqmp_plat_init);
+
+static int zynqmp_firmware_init(void)
+{
+	int ret;
+
+	ret = zynqmp_pm_ggs_init();
+	if (ret)
+		pr_err("%s() GGS init fail with error %d\n",
+		       __func__, ret);
+
+	return ret;
+}
+device_initcall(zynqmp_firmware_init);
diff --git a/include/linux/firmware/xilinx/zynqmp/firmware.h b/include/linux/firmware/xilinx/zynqmp/firmware.h
index 859d809..94b5a43 100644
--- a/include/linux/firmware/xilinx/zynqmp/firmware.h
+++ b/include/linux/firmware/xilinx/zynqmp/firmware.h
@@ -578,6 +578,8 @@ struct zynqmp_eemi_ops {
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
+int zynqmp_pm_ggs_init(void);
+
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 #else
-- 
2.7.4
