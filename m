Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x226tQCjkWYN4c5jNSvZJ+jZf1H506Hdkj6cxtckfH2NUV8ydv+P614Wuv0NHFVZLJY1k0nb6
ARC-Seal: i=1; a=rsa-sha256; t=1517957705; cv=none;
        d=google.com; s=arc-20160816;
        b=xl/+cK1LS6Qmir2aZOakcCPGDMwjpcCKu/mNfu5taNXU6dQ8fAZbcmsqMZX9wf9mi1
         MlezSulMV9/YtJeUA9nwzVJCiR/GpSABssOf5sQ1NsH25hNDbkWRrcdlg84oq5UEvL7k
         gja9h5WDy/fXUw7UyrifJGFMbyAv+pxqMurDlsYoacgyUWu1fXy5ykEsJNOaNyv7Ahe6
         51gHoBVQ/Vi5KWN5R4I9TFtG7xxLAvwT3RRpZbz2uK9OxJKDhiHLmDCxynOW7zMJGcwn
         Euy7/ugFB4LoABMvginrwcH7iYNGbTkY8XM/T1Y/Vz7sPtLrH4ZTQjBx80JHNzqIoY4P
         ORNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=S4o0Baw+wUG8kKGDJhbIfMljnIJ4NZeGYZFsakvkYTc=;
        b=1HLkb9CB2oDqNUxTalK/mK1TiO/wRHNpItWJ9C7PGRgGTPOTzkCCqp/WePSLGda+OB
         bEFMhKSv7RRxd3K4CHGJ+vsPJHkNCuX5YkxfIt3UQjJuk7w7Kv6m+HGh3w+ZS4VrEcmd
         m/IVzOBR7f9ep8vuSGT2rMNyzJbSkkNFEJE0y4PL2p7bynDcscmO48RENaf5+kCzt7P3
         7nOSEcPlDNNDeB0censPW4MOa1Hc+g3ugoeyKPGKS9LH/OLpATLpUHuReg5j6yctFO8T
         deKbjIfoykw1slFR4wGz1BBwQI421b46JCpU6Wf5OrqSyhv1oiNPfrJQ1r6gEUH5MtxJ
         GTBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=w+w/6y4v;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.83 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=w+w/6y4v;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.83 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
	<gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
	<sudeep.holla@arm.com>, <hkallweit1@gmail.com>, <keescook@chromium.org>,
	<dmitry.torokhov@gmail.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>, Rajan Vaja
	<rajanv@xilinx.com>
Subject: [PATCH v4 3/4] drivers: firmware: xilinx: Add sysfs interface
Date: Tue, 6 Feb 2018 14:54:22 -0800
Message-ID: <1517957663-16668-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517957663-16668-1-git-send-email-jollys@xilinx.com>
References: <1517957663-16668-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(346002)(376002)(39860400002)(2980300002)(438002)(50944005)(189003)(199004)(2906002)(5660300001)(76176011)(36386004)(63266004)(48376002)(72206003)(36756003)(2950100002)(478600001)(51416003)(7696005)(106466001)(356003)(186003)(110136005)(54906003)(16586007)(26005)(6666003)(106002)(47776003)(77096007)(81166006)(2201001)(81156014)(316002)(107886003)(336011)(50226002)(39060400002)(9786002)(7416002)(305945005)(8936002)(4326008)(8676002)(59450400001)(50466002)(921003)(107986001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3386;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT015;1:Sf8KSXd66toJVep3XKsDUPe2llcGzd0FJfa5QMyUf41b36Z/qR5wId79NNYWllY2TP5oNuFxYpa67ULTYLM+WAUMkfEuvgJOs2O+pTGH8FfHy5S/wimolW2tKy0bi20U
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 295dbc4c-cbac-4549-a2ec-08d56db4a73c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:DM5PR02MB3386;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3386;3:GgiFPYuQXiFrMOl7pOyjqpXdV9N1IxyZpW0SO5DqkJc6klS7E2OMzrmABpDb1zANU1756XliUwumRq0/S6IDtW0LLUyAeWxoInzYSEGiNgt8iXZoTAYMBrXr7KpMP89rH4Mlgcd+o0rxFgrYPbzUy1aZGepCSVcfDQH+mYiOifAFVFp0kwM2Z7CaKewQ1Qn56DH/Raqct0EEB9bWn0d/5Bc8Lw5nP0XbQmn2B1AA4ZAoYpK0xrhryIWQ4MVT8uT43D21ydP9hKq1t/ZUdW7n8JZCjFVxrIi3cd5VzDI5W//8WLKgVShQ3C0Skv7RmzOguO6QeBGmJFZWoSoyhgHL6BI5cGQAEL2NZBVtB6kC49s=;25:RARKxy53+Y2u67zfRTrxYi6JHxEKlhVDQLFQdetWpqh/M45za/TkJZaoz0bE+LhInSMznxmQgRVKtfBE3D4O/TCtFX2W3VbmA9IWtnps0a2nGhwBRAMGicajpyRDm8fa7KZnYtc6DjaGFnw+S5oWqmsEoslnX1HtWovDeTTPt2PpVlNeAiIuJUtsQnalcgl2atCTJKXFjGFF+owPishiWdcPDrtgl3pRjBF4trGPMuBY2daE1jxo/RcpOMpg6GnLcKkNzCCNp8sEkMlD/uZld8+lxuyKGd7kyEO3lB0xJxK8OJQTutxP5nNarI+ylWh+ZiwTY3FpwP2JdPFl1JXmhQ==
X-MS-TrafficTypeDiagnostic: DM5PR02MB3386:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3386;31:8nDUESzg0WuVMEpD+xejqrEMwIzNltF1GUyKbsJXInm1KaPoXNbQt4k4u3UGeAxuyCJc8aElXpofbVyyMY1VavrYPVcO2z1M/H+xsXs1g+C+CNuF/hhWLv/N1Oevv5WnCqTHqD86CtV7tqZ7J6L5hauHQZBffZdFl4/Gq9JhYGzwfoVTe5gQf3OVHLpaORo/YsIQWYPb7cy7D/wTT/tHvXEfQpSIaWPmJTXTw5+0qQI=;20:VdUWnkmCU9ipUMP5MOUJRyz0Ds+7a7ByfzFaf/M7TbnS//rZgWP5jAC/nQ0JFpAruJU5M8RnNziUHCYEujzUGhSrL7Dpta+/L+UrYGevFR++zvRpw1pYDAn/Sz0Z50FGWtvM/8WUMGayCCW9XkfqeyFaCbwApHPvjvANPIYzyeUz41MgTgtR/Jaj1dzx3qRypnMJpAAz//x5nl8aj3rujLfhnuMWJ6tBOxGqTzLqmaxtb/rQO540O3OSHH26oirP45a0LAViacoNoRiYfHz4v2RNKSeW6wFe7W5+oijg2eBizALTG3FnlCe8B1/pl5lPHd2gd8KPihy+9+LwPwHafabTixs+xI8amog/I08TUwnsbD9GEYjNCFLLzNCM7CUMXGqPCGLc6Na7v6ADBGxCrHE/veZdoNPDdE21Te93Wm0nkCY8BUIUercxwZUTe6BK1x4b+/7yj2xErlHFh6X0WpsBTQjtY8B/tZI6AZAMQ5E8cQ/I9Uzw9GUktovvoBIv
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB3386776994BCC4EC94DFDFF5B8FD0@DM5PR02MB3386.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93004095)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR02MB3386;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB3386;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3386;4:BKPh/RosMbhFhpZIup2JJTJcBmiiwbCq+FmtRMHAeEJyYIRsl2vUNYWvVrtwmOsghEdtKhEGtFReqE9zX1zIxafcNf9CPFQsoIX/JFxpH0hG8NqVHjQuKmRgnvsfUw6S7V5tZSV79W///ALasN+Yb0whIBjqk9q7uWFr8IIG7XnfG9vY+eyLiXy/hjl5Aas2vQkK2W3CEtvwvNNpSIFzeZyt1ita9oGBNk6YukImCOkK4hdf5ta/aP32J707CRHnUNNt6eI4fS6vPt36YxVSgUUqvPOU4zbz2scdxK32/a+5f1ZA2v0xMuKb8yr5LR2N
X-Forefront-PRVS: 0575F81B58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB3386;23:z7ZWkIerhfqqQcnoayC1RRh/y1RyHCpxhcNlvzHoY?=
 =?us-ascii?Q?LPFElStNorv/V/9uUB+vCfYp3P+7gK6tm49M7z7q84Uo7PBdsLpnOH01+K27?=
 =?us-ascii?Q?ZdOKdj3U5SXxxLaRd/NMEW1gTpVa7fWCh2spiqbZRrz1s8yDJqpM3Ywr5H7R?=
 =?us-ascii?Q?S9quo8878HbsfsI/vgtpURRiRoLYv/sl2Q16gRAf2mN+qx9APBhUPqXDv/xw?=
 =?us-ascii?Q?Y67jMj8mdITHbRAhYzluLhpFHVkOZR3UH2LQLH3VHC/3SHPUHrvn6V1Xd6t8?=
 =?us-ascii?Q?YJHTK4rTmdoLBuv07VRilm7mmS6bMUOWypxP+L+klYne2ocDGX7U+vJ16pyo?=
 =?us-ascii?Q?xpIsxWxkJyUhittzoWcScUaJOrDxsyUD7OaBbGFbez+uSfBIHEhehNxMgOta?=
 =?us-ascii?Q?idEyMWNnfDknffSXBTYm56cKCE0Fd/GqhgbbXbLjGAU5v/vK63d04Dh36Ks8?=
 =?us-ascii?Q?Y18N3fBUFgcWsL9WZAqamjBs1liivpTzH9uZ1pvfqyv1GyRmkiWwvOZhTtrp?=
 =?us-ascii?Q?SENvxdaatmOw4iPSjqZNmE3nTAMkYkQaQaldBl12kMubU9PEI7xkSRkRrWt6?=
 =?us-ascii?Q?+aYJ6sAN20p+8Ezyg/TZXxOJ5DkxMpjh6cjuJQ2Ktel5s6zxspQiasUbqE0h?=
 =?us-ascii?Q?8l6+vdqFYfHCxDwT/RHbyBRRjxEPBs908Bp2FjagHOxtKWbHpjt8M6B2NrAT?=
 =?us-ascii?Q?iU50Oh47zNJclU3c2UzBVNl5kZ0Rdpymc8I1O0smxUfFZ1+bSoK5KKtOIvpT?=
 =?us-ascii?Q?hCWk67hZB2zhT4/c5HCN1bU0N6GDpiCv62rokxH9OpTxRvMzBsULnh3gORKL?=
 =?us-ascii?Q?SXgyqRO+AmFofWPVkup+Q0twnG7Btj0zhxJ8zoi1NbgQ5H9OZMrJoJQo95oX?=
 =?us-ascii?Q?FszNqLIikukx4xMuXIO03jHOadRtyDDg80bi3VgrDZ0+kxxekXX77HIpUgNe?=
 =?us-ascii?Q?p50JEGkscoXgUfjUObdpnE8dk5QyTkdRn9S9vUOHxlZpH17weCSxSGnEkxOI?=
 =?us-ascii?Q?F03Wmorh3QLxzit6zlY2ajivt4mC9QN0XJvTKRSCcVNOxPFGiO5c33BtADgE?=
 =?us-ascii?Q?UNz/sEhe17FyoCWTZLNNpg8T/7inUOM+UvkFyM7pqFZ/geDriOfvzzlBUo1/?=
 =?us-ascii?Q?gI8zNUpjmJtL8PU0JMh5vYkUq2qgJQTLruebPxTzCbuf0yO9MkxUBQtzVPXp?=
 =?us-ascii?Q?iLDSNP5oHmJXbA8pCIXGIqzSPpz58Yi4Ad1Ovof2UMBl4ssvv8D9+yKMA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3386;6:IMSjEgx/7gkzWRq91hIdIvWSL7JqJf/US2QyHiwnpBhNuixeeUNwc2tUCJingg0Oe9q5k23iQhBkfdLTkcCGWbFSJHaVJW2N84CkZS5mXHRNY+sULq4LJqZXAe5vU14oESxYD+ZRgURcW4Nbj1LP/DxlD66RFeyTPF8jvoPzgUzQoFQ2jZ1h5k395y+3SOpOdY/9VjrjVmrNOQXhGfzlTxZILuA1m8nzP7EHqrgrgYnkQBWI8N8FAHTtvyGAUw5rwSXGpTi5nY80Z1jLHa3tRGAGVDRxwekOe6XwwPZYeayJtUtoBGMvvIxBKmpL+VUeMT2Ea19YDVs0DkznnleUZ7op4i2GxqfYzVLzdHPUzwQ=;5:KLwfY6C4l5nPCKVLZ5HroqG1EpJWDY8VqAH7J50kHBPrpuGT0CR9HfbKibqddov4VxwFAF7r7NMeI1ZIIeS7pRO63poBUOXXToSCDI9Ph1B1YWiZiENAhvrcnA7imvU61kDR2ZbSVwMnzt05JaJI27snYJFzbSzaY5/k1gM+yqE=;24:f66V/zNABfBqv7cBfsKqNX3acNE2xSkJ7eRPBcnMRCdll69CVEQrj3x/CQxTn2RN/lLIhhwljjrEKmU2JUX1RdFFx8UsPJjJODdUzj+dpDY=;7:YU1dfrBSKGEFGTUX3geEshfBiH1r8gQLbI6qJ++rA85B6lz4ByEh4VJQiCqljQXK4dskFq6cPHnKJRs/ITNza+soTBW0W7ibKBF9ukIarMjMyEboe4KGe8zBRosHUFjaoIr5MzlHpYcid4xrpvLEHEwQT6USg7lNsyWJlXgWhqky/0HUdz+IbMlNJz2s8q5TBPHjE43V7gIy0VFYK+yeLsS4Ocf0TDvtMvdsZj7PxOnHvlPoiup/FHQc+WFP8MB+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 22:55:00.4296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 295dbc4c-cbac-4549-a2ec-08d56db4a73c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3386
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591694018795149913?=
X-GMAIL-MSGID: =?utf-8?q?1591694018795149913?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add Firmware-ggs sysfs interface which provides read/write
interface to global storage registers.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 Documentation/ABI/stable/sysfs-firmware-zynqmp  |  50 ++++
 drivers/firmware/xilinx/zynqmp/Makefile         |   2 +-
 drivers/firmware/xilinx/zynqmp/firmware-ggs.c   | 297 ++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp/firmware.c       |  15 +-
 include/linux/firmware/xilinx/zynqmp/firmware.h |   2 +
 5 files changed, 364 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-firmware-zynqmp
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c

diff --git a/Documentation/ABI/stable/sysfs-firmware-zynqmp b/Documentation/ABI/stable/sysfs-firmware-zynqmp
new file mode 100644
index 0000000..0a75812
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-firmware-zynqmp
@@ -0,0 +1,50 @@
+What:		/sys/firmware/zynqmp/ggs*
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
+		# cat /sys/firmware/zynqmp/ggs0
+		# echo <mask> <value> > /sys/firmware/zynqmp/ggs0
+
+		Example:
+		# cat /sys/firmware/zynqmp/ggs0
+		# echo 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/ggs0
+
+Users:		Xilinx
+
+What:		/sys/firmware/zynqmp/pggs*
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
+		# cat /sys/firmware/zynqmp/pggs0
+		# echo <mask> <value> > /sys/firmware/zynqmp/pggs0
+
+		Example:
+		# cat /sys/firmware/zynqmp/pggs0
+		# echo 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/pggs0
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
index 0000000..27e71c7
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
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
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
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
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
index 809ce50..dc33e96 100644
--- a/drivers/firmware/xilinx/zynqmp/firmware.c
+++ b/drivers/firmware/xilinx/zynqmp/firmware.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -1003,5 +1004,17 @@ static int __init zynqmp_plat_init(void)
 
 	return ret;
 }
-
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
index d435615..45d02b7 100644
--- a/include/linux/firmware/xilinx/zynqmp/firmware.h
+++ b/include/linux/firmware/xilinx/zynqmp/firmware.h
@@ -574,6 +574,8 @@ int invoke_pm_fn(u32 pm_api_id, u32 arg0, u32 arg1, u32 arg2, u32 arg3,
 		 u32 *ret_payload);
 int zynqmp_pm_ret_code(u32 ret_status);
 
+int zynqmp_pm_ggs_init(void);
+
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *get_eemi_ops(void);
 #else
-- 
2.7.4
