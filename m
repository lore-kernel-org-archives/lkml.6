Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x224Dr+mOokO6wD5FOP3QmcMljbWMQ06a0V5QLhBHYBg6pNdwEZn6FeTJBPCJwNnjTnZeGsEX
ARC-Seal: i=1; a=rsa-sha256; t=1519154486; cv=none;
        d=google.com; s=arc-20160816;
        b=om1i/tP1kcEuwMsYzU+2BBcZeMKsj68D7l4we47qN4/NNHBWkoND/6MazxOirqFNGd
         U8N/L7E9i5605h+VXt4F8/eWr2B/1hEnLgb2KqeZI/T6kLgfRfSO4K2m+P4nfpoSOrGn
         RGQghQQqU6CPkbOxr4Vir+eLJee65EoZise09lQSIrYHh2abZ781NzKSX5h9XnWnU/AJ
         ilbWzffL5gwLGPI6v7UoFUug6ZWu0kY/N0whxNiakuKfciAvDIXyWfdharqOGuId78H3
         wle1Lzs5b7CIuDopiLU6kFv6QBTRHk6CnS9fR9xAeebYPeLWK0nNYY30zGnbcecwmvDQ
         8lGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=NFiAIgX41b6x4E5DpMO8p7gzSOYWAMNjZS0Zl0Y/Dyk=;
        b=fYNPMeV8ujZMMa4EWGLX1RQCm3vzDrYsCBhPjvAmyyNANpbscJXGd710TFct7jleCC
         4faZxfOHEO3NM6Dwui3yGrPcfz4OSAE5JKFM/4TL+PbUw8sTx9VLAYX4xaljHR089Lmv
         Mim75664nw7PUKeO36CkOKtBmfIbiRiQq/9w7iSBcnnY1B5fd7mTCuYFRuDIfrxwOD00
         9wmr+ZGu18nhumJWzXCEMJAUJEri3h3j+deqZOloUQtTrLKDnoiWBxfsDSTwIpFpopYX
         rbcCLTwNhGOvuHBnasuOdOXtbsTOsEEGWMXYMAZ3x5cEtLXR0f93JLd4U6bFQjKQ+/7b
         0jKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=zdygtsXg;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.52 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=zdygtsXg;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.52 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
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
Subject: [PATCH v5 2/4] drivers: firmware: xilinx: Add ZynqMP firmware driver
Date: Tue, 20 Feb 2018 11:21:05 -0800
Message-ID: <1519154467-2896-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(396003)(346002)(2980300002)(438002)(37524003)(189003)(199004)(110136005)(54906003)(48376002)(16586007)(47776003)(36756003)(51416003)(63266004)(316002)(575784001)(2201001)(7696005)(106466001)(36386004)(106002)(50466002)(2906002)(2950100002)(72206003)(53946003)(59450400001)(107886003)(478600001)(76176011)(186003)(336011)(26005)(77096007)(356003)(5660300001)(39060400002)(305945005)(81156014)(7416002)(9786002)(8676002)(50226002)(81166006)(6666003)(8936002)(4326008)(107986001)(921003)(1121003)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1344;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT057;1:EFkOzDQ8oISV4ZN5ztPXKvweiqJCketv7eQmds3vro25e1JpPfKcpLoYwl2HLDy5WEmFERd9n2R/6bNvBqs8pSyzSpOK+Cd/23ALhJ4LAjNCME4kq+bR4EJTyy+aE2Us
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9fdc6a7-4172-4967-c14a-08d578971f6e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:SN1PR02MB1344;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1344;3:5dabiVldDm0p7YoLRLs2ADSzw1ZftKVgmxxhE2KnEFzamm9cNjRQF6SkNKbfCZ68VLwX0NsJuL9Sn5d4zy4lLF3F03odVOz44ml7cJb2BcOjwMZqWQ1xVMUnfChDlYMjAl6DUfk+3Mix5HFhw0wEixZ7J6u/MnIarZDwHW2YsoJkqZmZR0i7oeTuUQwpsx6ECtenLktM8sRiS1frVKEbDNuu9yoW8xAGBSfXrdivdYUh9RhHiBCjav/4fd88QS4CRqWqDFibVeW3AP80e/2z32i+8eBUrNnQrBIWLRmb3H41StldVmfxCnDr2jIbFWoBiFdJy6TmrAQg6Rx7bANiUJgrqCIPdWY8MNHJWDXzPKU=;25:sPiQNvWIxdLNBJw8sSS5UzgZkQx2jb+FkXAc4doK3Ut4HZjeWOq1OKqHWguwfrNOHd5Gk+cublTo3S7YuqlyUyECBbtZsCoaTvEYCjDpzx2IfHVNxy203s1Efm5XWOabOkJc9IKECLm4VORA/Pc0OguBhqo69iR+FjAnDQ/KcM/T4kGEW5rno9WFy42RKWz5N3jTg6nAgjZZD/xB6eDyDPaHdaBPuIFqnWWwXCoDYJldBJZnOM+s7AbjM8MGOXoBzMItH3rBeuuzj9bPhrIQvHJafbI5Tw320olBGkQx2aXUjgMdz/BUzhg9kY/tkqykp58vq83hp1InUjMoDsXQxA==
X-MS-TrafficTypeDiagnostic: SN1PR02MB1344:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1344;31:NLiNdbft+Le0JIvKNBI93qPoZ1GxkIJYdNsJvZYuCP029yCvr57m/xtHEGY7ZmmeQvFbvRZOtdmmwwj12rcKVUMW41ee/VTJM1XkSA6khRa2CUBOM5xD+XDxKPuZT+MMIL0dSDbEdSACg7d1jGliMsqCc4pUmSmaS+Iyc65p81YDxX5Y/ZHcoXWLnHWk37KaLQ7rWD+8DmXB0xWLKaiUFDUDYXd56a5OzlGklH5/kF4=;20:Qb24HSndva/HnnLaTT99R+wvyOVvcSJ7UgK2MzGRR+pdzrqqH5u6RXObqIOevOVjWnGjufFFK4kLG0zAj8/1uDTGQT0niRvnEE52E5kH3OWxC3A1WyZYDq7lD5BYD3qbStvO2QmeNAj7xVebYiEfv+nz6Qy2DdTXVvkv3pZIEuzoz2JlnyBGC9/ffmmv2RHdxTMP4uNYEXxNdzUB9CtxIiBw/kYseOKJ2HxmMXoq2udTB7OtF0PbUNdvXLtunMvXGhpeL+1BuXN5eZfXUlzQvaMwglH50gWD3e/n8godgfZh2r6EWB7BUccHOuGCbtdvhbqwIKrs/IU8VtQbyieb/QxnQIK7ioOUIn4kseTHJExjtbLBytIqpCK3V9kK3XMwtdYa4D1T9Y780p8XMU1I3R0s+WzT5sFTve28fFAmTe2SryLGtjLNmbXo8vAab01oiry5uGm/fsHSISkEhOMPz09PsXwbPdr5An/QWEYP3qqRJLf4wqnC8fq3/grdOpYp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB1344B8F0DCC4C5EF79830B05B8CF0@SN1PR02MB1344.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001058)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(944501161)(93006095)(93004095)(10201501046)(6055026)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR02MB1344;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1344;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1344;4:hRq/InZlHDQ3CFF2a+zo9tB+2qzQU0pjqoaFgTuUYFcHfjxIAj9BVBCdO2oWeagkWSlb2fVZgX9IvhFJZliGl+Jugj71YubTYnhSPivA44jyEI5UIkXtxFrLF3jcujp2XVwGj2ub/dOuRucG0pQ/9aOZCtY0+b9Xf5Y93rAgQubZ2qLCibbeoZZ1kPs0ADZ+JppC0wFp6tER7x8Gz6epbMnptgm6YnC93UW8un5b06HXP+py2xnDUFyliqOx3T85dt3rsDZHEHJZ2ryTM41lQSdEMZchPHYa+99kh/sirJlLbbBEbjzPQ8yj+T50fYqv
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB1344;23:nqao1r2qlXk62pnrOQdwnnHLmNLspi62BKuNayU1a?=
 =?us-ascii?Q?9S9wnbDKchIUQOxzIRb951uDPJDdi4rOJ+zq4/IKkm/zw85OsVBHHJKhl6sp?=
 =?us-ascii?Q?PVgnNlkun5SZMjqlEJM1Lx/5Ql/KDClnQpz2V8hHwhbg5dfiOzh8cuRg6wis?=
 =?us-ascii?Q?Cv7G00c1rIkOaS37tFTafNVjk7/ZlZiLhBA+TbiUeT3eQ8VTXUH8m+FeAW5I?=
 =?us-ascii?Q?wWqCKdYZQSZzn6G+R38Zj8r1vyb4fEdip/w7ApWY4Qt056vl+JHtQhyW/+L8?=
 =?us-ascii?Q?G7hoo009zZBHNUxlFv+3HiGNkRwijUy81hJU++xDd+kLoM1sGXVyt0VnQeQw?=
 =?us-ascii?Q?XBjE2io4HtTqUFcpi+6G3F09TizfyI5p70QalHq2FuJWMhgFiShrYsuKuXqs?=
 =?us-ascii?Q?XPq7AI8GqCwysvVJae9wwHHrxemDCUT+jNBAxWoHLMq8AzUxHRNd9kU3vhCM?=
 =?us-ascii?Q?6tnQEl1G4WS+73qm8ZCRCD0p7UuvD2cwtkboDcp5vbuI33CABtWyhoXm2XMV?=
 =?us-ascii?Q?ugXNgIvLAki9vQQfYK1fkAKc/UaqzY9bdcBaz8ieBme8nc3hxSL1oYQJ7+uD?=
 =?us-ascii?Q?1OdXbmbPncoCq6vxXUVIyDhB4Ei6JJZ3d3cGB2Uw7+ZPO1fNRn0eQBjH7jY4?=
 =?us-ascii?Q?/lyRbhlnzCi/W+iDJCF+Uo44+lQe2CACKtrjtMaOEldR9qNNZVp3VRzQJ5OR?=
 =?us-ascii?Q?j3GiKvPmyqnfxDNS0XLyuLFeaQR/+juZsOgax8ZKrStNygv2fAhsF2sqxOub?=
 =?us-ascii?Q?xy2o4peHpmu7yTSq8OHavY32yw/aw/2nAVvmbJWIz/5RY1iBosVCwFkz6cua?=
 =?us-ascii?Q?Q7wGQHmvh2vtPFPGzF6oAj89e8tSPF/mywUGOsGhD1W/cOtq4F6inV1kBkH8?=
 =?us-ascii?Q?wimjyVNzNzlGHrXQwf0/shg+PTyTT1MrdjvNfAswLEkGXCF+h9nlqEPzJWSc?=
 =?us-ascii?Q?XdXSGaT7b7maSYKySsJDdu8jGB05Vw8U1sSnxbY7p64JOrJDOvgaOhLfcuhC?=
 =?us-ascii?Q?04Ih/9crVREYVS8SbyHKcj9gDDyI9NSFq2AiGr0ZPijLw+jlCEEQsF5XsYeH?=
 =?us-ascii?Q?PIb0O3O3mM6FWY6xkGEtIRePyFyh8yI3lNEyQZ8IkIix7oP5FRI03FNkKdxr?=
 =?us-ascii?Q?AXF0c25gj89f3vccFWb+o/kqiUjP7My7o7jJNQuPATENiHoNNC/WADSSg+dE?=
 =?us-ascii?Q?w+R/zsHdVhu7icfw4fzen0d8NioMUSuqlPd1/s1czksHS/UTBPbdeZ+PGYWU?=
 =?us-ascii?Q?ttBz5wxtw7HJgtyGqCcHmlvU5g8Gusy684PJJn9?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1344;6:f92fWIlYdaCQi00xBBggb/vGby4Sft34LVGmo3HC3QiLIax+3GGtVyEauxU4UPqCYyu1VYjJA7N4WhsDWTEk5wJc+kja2GpIuU6M1UiiO5O2Q76oiGyN730M+QLPhuuLZnBAalvbtwcYBpdiKCiMYmf82qAhykH1qPBe6NKfDxQFywqhJO9V/7tej2pfvZnhwVrdYSEr5PV/hHihSM5nAgxJ89F/Ym7WBiF+mz0flbVO8uIF/ZNibJ1dORKxwxwm/yhzXsGuNQbsPuN2qxOTEgfTkhwCDpmz/T3xL635ayIK9T9TfEcW5eJi5QDgQx6s8TcZDW5ZxI+IPHK7H4TBWvjSm6yPVnRdCjzOCAgqGIc=;5:hQ4ZGl4HcWpb1FA0PgHsFSaV7penDCS4v2enzb5MfT4CPzrcnAasrmg9zOiL1n3TJ/RuYiiKWZe09Oo8UqLfaJoFI/o0s8JMf+stTz/nmrE7ywm0eXP3bZKxtCQEUoClJobHDTn9w2lWLtMgSE22Iy1A8lTQWomc1JTYW8TsP0Y=;24:3WJ1cXt11BPb3JNGn+XIllBpcymCCblPta9EvWQwM4eloqOKYd1Xnf0UjA8G7L28NMgvbe/ZH8i4ZSbHCzpAoJ0WyGMT6RVQDNIP74ih2os=;7:zIOMOBR09M2dywV9Hgo6bPh4rLyrDdXwqofjzntl/AzAe1CvORCnNRzfancfdDB/kHT2AY2yIt95mrUc6ovSHcPW4xvoLW6K9diGIJJHxGYKgWSrLT0EAr3ZfIt5h8o1lPV0pv7zBjmxNyPZh6ODSIiqvGO8+XlAabmujsf9PHhLnaIaqCxsmyNi0wc6H0Yhx3nnNjXY71R1Ey9rHtwg+nGBPTL5+M7N9QRyApcSKwBiDGMN7LdaIPc4mMJQoHrL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 19:21:20.1790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fdc6a7-4172-4967-c14a-08d578971f6e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1344
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948934312896009?=
X-GMAIL-MSGID: =?utf-8?q?1592948934312896009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch is adding communication layer with firmware.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 arch/arm64/Kconfig.platforms                    |    1 +
 drivers/firmware/Kconfig                        |    1 +
 drivers/firmware/Makefile                       |    1 +
 drivers/firmware/xilinx/Kconfig                 |    4 +
 drivers/firmware/xilinx/Makefile                |    4 +
 drivers/firmware/xilinx/zynqmp/Kconfig          |   16 +
 drivers/firmware/xilinx/zynqmp/Makefile         |    4 +
 drivers/firmware/xilinx/zynqmp/firmware.c       | 1051 +++++++++++++++++++++++
 include/linux/firmware/xilinx/zynqmp/firmware.h |  590 +++++++++++++
 9 files changed, 1672 insertions(+)
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp/Kconfig
 create mode 100644 drivers/firmware/xilinx/zynqmp/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
 create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fbedbd8..6454458 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -274,6 +274,7 @@ config ARCH_ZX
 
 config ARCH_ZYNQMP
 	bool "Xilinx ZynqMP Family"
+	select ZYNQMP_FIRMWARE
 	help
 	  This enables support for Xilinx ZynqMP Family
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b7c7482..f41eb0d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -257,5 +257,6 @@ source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
+source "drivers/firmware/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index b248238..f90363e 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
 obj-y				+= tegra/
+obj-y				+= xilinx/
diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
new file mode 100644
index 0000000..eb4cdcf
--- /dev/null
+++ b/drivers/firmware/xilinx/Kconfig
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Kconfig for Xilinx firmwares
+
+source "drivers/firmware/xilinx/zynqmp/Kconfig"
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
new file mode 100644
index 0000000..beff5dc
--- /dev/null
+++ b/drivers/firmware/xilinx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile for Xilinx firmwares
+
+obj-$(CONFIG_ARCH_ZYNQMP) += zynqmp/
diff --git a/drivers/firmware/xilinx/zynqmp/Kconfig b/drivers/firmware/xilinx/zynqmp/Kconfig
new file mode 100644
index 0000000..5054b80
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Kconfig for Xilinx ZynqMP firmware
+
+menu "Zynq MPSoC Firmware Drivers"
+	depends on ARCH_ZYNQMP
+
+config ZYNQMP_FIRMWARE
+	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	help
+	  Firmware interface driver is used by different to
+	  communicate with the firmware for various platform
+	  management services.
+	  Say yes to enable ZynqMP firmware interface driver.
+	  In doubt, say N
+
+endmenu
diff --git a/drivers/firmware/xilinx/zynqmp/Makefile b/drivers/firmware/xilinx/zynqmp/Makefile
new file mode 100644
index 0000000..c3ec669
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile for Xilinx firmwares
+
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += firmware.o
diff --git a/drivers/firmware/xilinx/zynqmp/firmware.c b/drivers/firmware/xilinx/zynqmp/firmware.c
new file mode 100644
index 0000000..6979f4b
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp/firmware.c
@@ -0,0 +1,1051 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/compiler.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+/**
+ * zynqmp_pm_ret_code - Convert PMU-FW error codes to Linux error codes
+ * @ret_status:		PMUFW return code
+ *
+ * Return:		corresponding Linux error code
+ */
+static int zynqmp_pm_ret_code(u32 ret_status)
+{
+	switch (ret_status) {
+	case XST_PM_SUCCESS:
+	case XST_PM_DOUBLE_REQ:
+		return 0;
+	case XST_PM_NO_ACCESS:
+		return -EACCES;
+	case XST_PM_ABORT_SUSPEND:
+		return -ECANCELED;
+	case XST_PM_INTERNAL:
+	case XST_PM_CONFLICT:
+	case XST_PM_INVALID_NODE:
+	default:
+		return -EINVAL;
+	}
+}
+
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
+				    u32 *ret_payload)
+{
+	return -ENODEV;
+}
+
+/*
+ * PM function call wrapper
+ * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
+ */
+static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
+
+/**
+ * do_fw_call_smc - Call system-level platform management layer (SMC)
+ * @arg0:		Argument 0 to SMC call
+ * @arg1:		Argument 1 to SMC call
+ * @arg2:		Argument 2 to SMC call
+ * @ret_payload:	Returned value array
+ *
+ * Return:		Returns status, either success or error+reason
+ *
+ * Invoke platform management function via SMC call (no hypervisor present)
+ */
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+		ret_payload[4] = lower_32_bits(res.a2);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * do_fw_call_hvc - Call system-level platform management layer (HVC)
+ * @arg0:		Argument 0 to HVC call
+ * @arg1:		Argument 1 to HVC call
+ * @arg2:		Argument 2 to HVC call
+ * @ret_payload:	Returned value array
+ *
+ * Return:		Returns status, either success or error+reason
+ *
+ * Invoke platform management function via HVC
+ * HVC-based for communication through hypervisor
+ * (no direct communication with ATF)
+ */
+static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+		ret_payload[4] = lower_32_bits(res.a2);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * zynqmp_pm_invoke_fn - Invoke the system-level platform management layer
+ *			 caller function depending on the configuration
+ * @pm_api_id:		Requested PM-API call
+ * @arg0:		Argument 0 to requested PM-API call
+ * @arg1:		Argument 1 to requested PM-API call
+ * @arg2:		Argument 2 to requested PM-API call
+ * @arg3:		Argument 3 to requested PM-API call
+ * @ret_payload:	Returned value array
+ *
+ * Return:		Returns status, either success or error+reason
+ *
+ * Invoke platform management function for SMC or HVC call, depending on
+ * configuration
+ * Following SMC Calling Convention (SMCCC) for SMC64:
+ * Pm Function Identifier,
+ * PM_SIP_SVC + PM_API_ID =
+ *	((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
+ *	((SMC_64) << FUNCID_CC_SHIFT)
+ *	((SIP_START) << FUNCID_OEN_SHIFT)
+ *	((PM_API_ID) & FUNCID_NUM_MASK))
+ *
+ * PM_SIP_SVC	- Registered ZynqMP SIP Service Call
+ * PM_API_ID	- Platform Management API ID
+ */
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload)
+{
+	/*
+	 * Added SIP service call Function Identifier
+	 * Make sure to stay in x0 register
+	 */
+	u64 smc_arg[4];
+
+	smc_arg[0] = PM_SIP_SVC | pm_api_id;
+	smc_arg[1] = ((u64)arg1 << 32) | arg0;
+	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+
+	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+}
+
+static u32 pm_api_version;
+static u32 pm_tz_version;
+
+/**
+ * zynqmp_pm_get_api_version - Get version number of PMU PM firmware
+ * @version:	Returned version value
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_api_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM API version already verified */
+	if (pm_api_version > 0) {
+		*version = pm_api_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_get_trustzone_version - Get secure trustzone firmware version
+ * @version:	Returned version value
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_trustzone_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM trustzone version already verified */
+	if (pm_tz_version > 0) {
+		*version = pm_tz_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
+				  0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_get_chipid - Get silicon ID registers
+ * @idcode:	IDCODE register
+ * @version:	version register
+ *
+ * Return:	Returns the status of the operation and the idcode and version
+ *		registers in @idcode and @version.
+ */
+static int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!idcode || !version)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	*idcode = ret_payload[1];
+	*version = ret_payload[2];
+
+	return ret;
+}
+
+/**
+ * get_set_conduit_method - Choose SMC or HVC based communication
+ * @np:		Pointer to the device_node structure
+ *
+ * Use SMC or HVC-based functions to communicate with EL2/EL3
+ *
+ * Return:	Returns 0 on success or error code
+ */
+static int get_set_conduit_method(struct device_node *np)
+{
+	const char *method;
+
+	if (of_property_read_string(np, "method", &method)) {
+		pr_warn("%s missing \"method\" property\n", __func__);
+		return -ENXIO;
+	}
+
+	if (!strcmp("hvc", method)) {
+		do_fw_call = do_fw_call_hvc;
+	} else if (!strcmp("smc", method)) {
+		do_fw_call = do_fw_call_smc;
+	} else {
+		pr_warn("%s Invalid \"method\" property: %s\n",
+			__func__, method);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
+ * @reset:		Reset to be configured
+ * @assert_flag:	Flag stating should reset be asserted (1) or
+ *			released (0)
+ *
+ * Return:		Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+				  const enum zynqmp_pm_reset_action assert_flag)
+{
+	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_reset_get_status - Get status of the reset
+ * @reset:	Reset whose status should be returned
+ * @status:	Returned status
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
+				      u32 *status)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!status)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
+				  0, 0, ret_payload);
+	*status = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_fpga_load - Perform the fpga load
+ * @address:	Address to write to
+ * @size:	pl bitstream size
+ * @flags:
+ *	BIT(0) - Bit-stream type.
+ *		 0 - Full Bit-stream.
+ *		 1 - Partial Bit-stream.
+ *	BIT(1) - Authentication.
+ *		 1 - Enable.
+ *		 0 - Disable.
+ *	BIT(2) - Encryption.
+ *		 1 - Enable.
+ *		 0 - Disable.
+ * NOTE -
+ *	The current implementation supports only Full Bit-stream.
+ *
+ * This function provides access to xilfpga library to transfer
+ * the required bitstream into PL.
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_load(const u64 address, const u32 size,
+			       const u32 flags)
+{
+	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, (u32)address,
+				   ((u32)(address >> 32)), size, flags, NULL);
+}
+
+/**
+ * zynqmp_pm_fpga_get_status - Read value from PCAP status register
+ * @value:	Value to read
+ *
+ * This function provides access to the xilfpga library to get
+ * the PCAP status
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_get_status(u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_request_suspend - PM call to request for another PU or subsystem to
+ *					be suspended gracefully.
+ * @node:	Node ID of the targeted PU or subsystem
+ * @ack:	Flag to specify whether acknowledge is requested
+ * @latency:	Requested wakeup latency (not supported)
+ * @state:	Requested state (not supported)
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_suspend(const u32 node,
+				     const enum zynqmp_pm_request_ack ack,
+				     const u32 latency,
+				     const u32 state)
+{
+	return zynqmp_pm_invoke_fn(PM_REQUEST_SUSPEND, node, ack,
+				   latency, state, NULL);
+}
+
+/**
+ * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
+ *				be powered down forcefully
+ * @target:	Node ID of the targeted PU or subsystem
+ * @ack:	Flag to specify whether acknowledge is requested
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_force_powerdown(const u32 target,
+				     const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_request_wakeup - PM call to wake up selected master or subsystem
+ * @node:	Node ID of the master or subsystem
+ * @set_addr:	Specifies whether the address argument is relevant
+ * @address:	Address from which to resume when woken up
+ * @ack:	Flag to specify whether acknowledge requested
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_wakeup(const u32 node,
+				    const bool set_addr,
+				    const u64 address,
+				    const enum zynqmp_pm_request_ack ack)
+{
+	/* set_addr flag is encoded into 1st bit of address */
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
+				   address >> 32, ack, NULL);
+}
+
+/**
+ * zynqmp_pm_set_wakeup_source - PM call to specify the wakeup source
+ *					while suspended
+ * @target:	Node ID of the targeted PU or subsystem
+ * @wakeup_node:Node ID of the wakeup peripheral
+ * @enable:	Enable or disable the specified peripheral as wake source
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_wakeup_source(const u32 target,
+				       const u32 wakeup_node,
+				       const u32 enable)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_WAKEUP_SOURCE, target,
+				   wakeup_node, enable, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_system_shutdown - PM call to request a system shutdown or restart
+ * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
+ * @subtype:	Specifies which system should be restarted or shut down
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
+{
+	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_request_node - PM call to request a node with specific capabilities
+ * @node:		Node ID of the slave
+ * @capabilities:	Requested capabilities of the slave
+ * @qos:		Quality of service (not supported)
+ * @ack:		Flag to specify whether acknowledge is requested
+ *
+ * Return:		Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
+				  const u32 qos,
+				  const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities,
+				   qos, ack, NULL);
+}
+
+/**
+ * zynqmp_pm_release_node - PM call to release a node
+ * @node:	Node ID of the slave
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_release_node(const u32 node)
+{
+	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_requirement - PM call to set requirement for PM slaves
+ * @node:		Node ID of the slave
+ * @capabilities:	Requested capabilities of the slave
+ * @qos:		Quality of service (not supported)
+ * @ack:		Flag to specify whether acknowledge is requested
+ *
+ * This API function is to be used for slaves a PU already has requested
+ *
+ * Return:		Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
+				     const u32 qos,
+				     const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, node, capabilities,
+				   qos, ack, NULL);
+}
+
+/**
+ * zynqmp_pm_set_max_latency - PM call to set wakeup latency requirements
+ * @node:	Node ID of the slave
+ * @latency:	Requested maximum wakeup latency
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_max_latency(const u32 node, const u32 latency)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_MAX_LATENCY, node, latency,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_configuration - PM call to set system configuration
+ * @physical_addr:	Physical 32-bit address of data structure in memory
+ *
+ * Return:		Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_configuration(const u32 physical_addr)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_CONFIGURATION, physical_addr, 0,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_get_node_status - PM call to request a node's current power state
+ * @node:		ID of the component or sub-system in question
+ * @status:		Current operating state of the requested node
+ * @requirements:	Current requirements asserted on the node,
+ *			used for slave nodes only.
+ * @usage:		Usage information, used for slave nodes only:
+ *			PM_USAGE_NO_MASTER	- No master is currently using
+ *						  the node
+ *			PM_USAGE_CURRENT_MASTER	- Only requesting master is
+ *						  currently using the node
+ *			PM_USAGE_OTHER_MASTER	- Only other masters are
+ *						  currently using the node
+ *			PM_USAGE_BOTH_MASTERS	- Both the current and at least
+ *						  one other master is currently
+ *						  using the node
+ *
+ * Return:		Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_node_status(const u32 node, u32 *const status,
+				     u32 *const requirements, u32 *const usage)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!status)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_NODE_STATUS, node, 0, 0,
+				  0, ret_payload);
+	if (ret_payload[0] == XST_PM_SUCCESS) {
+		*status = ret_payload[1];
+		if (requirements)
+			*requirements = ret_payload[2];
+		if (usage)
+			*usage = ret_payload[3];
+	}
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_get_operating_characteristic - PM call to request operating
+ *						characteristic information
+ * @node:	Node ID of the slave
+ * @type:	Type of the operating characteristic requested
+ * @result:	Used to return the requsted operating characteristic
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_operating_characteristic(const u32 node,
+		const enum zynqmp_pm_opchar_type type,
+		u32 *const result)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!result)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_OPERATING_CHARACTERISTIC,
+				  node, type, 0, 0, ret_payload);
+	if (ret_payload[0] == XST_PM_SUCCESS)
+		*result = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_init_finalize - PM call to informi firmware that the caller master
+ *				has initialized its own power management
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_init_finalize(void)
+{
+	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_suspend_mode	- Set system suspend mode
+ *
+ * @mode:	Mode to set for system suspend
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_suspend_mode(u32 mode)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
+ * @address:	Address of the data/ Address of output buffer where
+ *		hash should be stored.
+ * @size:	Size of the data.
+ * @flags:
+ *	BIT(0) - for initializing csudma driver and SHA3(Here address
+ *		 and size inputs can be NULL).
+ *	BIT(1) - to call Sha3_Update API which can be called multiple
+ *		 times when data is not contiguous.
+ *	BIT(2) - to get final hash of the whole updated data.
+ *		 Hash will be overwritten at provided address with
+ *		 48 bytes.
+ *
+ * Return:	Returns status, either success or error code.
+ */
+static int zynqmp_pm_sha_hash(const u64 address, const u32 size,
+			      const u32 flags)
+{
+	u32 lower_32_bits = (u32)address;
+	u32 upper_32_bits = (u32)(address >> 32);
+
+	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, upper_32_bits, lower_32_bits,
+				   size, flags, NULL);
+}
+
+/**
+ * zynqmp_pm_rsa - Access RSA hardware to encrypt/decrypt the data with RSA.
+ * @address:	Address of the data
+ * @size:	Size of the data.
+ * @flags:
+ *		BIT(0) - Encryption/Decryption
+ *			 0 - RSA decryption with private key
+ *			 1 - RSA encryption with public key.
+ *
+ * Return:	Returns status, either success or error code.
+ */
+static int zynqmp_pm_rsa(const u64 address, const u32 size, const u32 flags)
+{
+	u32 lower_32_bits = (u32)address;
+	u32 upper_32_bits = (u32)(address >> 32);
+
+	return zynqmp_pm_invoke_fn(PM_SECURE_RSA, upper_32_bits, lower_32_bits,
+				   size, flags, NULL);
+}
+
+/**
+ * zynqmp_pm_pinctrl_request - Request Pin from firmware
+ * @pin:	Pin number to request
+ *
+ * This function requests pin from firmware.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_pinctrl_request(const u32 pin)
+{
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_REQUEST, pin, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_pinctrl_release - Inform firmware that Pin control is released
+ * @pin:	Pin number to release
+ *
+ * This function release pin from firmware.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_pinctrl_release(const u32 pin)
+{
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_RELEASE, pin, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_pinctrl_get_function - Read function id set for the given pin
+ * @pin:	Pin number
+ * @id:		Buffer to store function ID
+ *
+ * This function provides the function currently set for the given pin.
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_pinctrl_get_function(const u32 pin, u32 *id)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!id)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_GET_FUNCTION, pin, 0,
+				  0, 0, ret_payload);
+	*id = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_pinctrl_set_function - Set requested function for the pin
+ * @pin:	Pin number
+ * @id:		Function ID to set
+ *
+ * This function sets requested function for the given pin.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_pinctrl_set_function(const u32 pin, const u32 id)
+{
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_SET_FUNCTION, pin, id,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_pinctrl_get_config - Get configuration parameter for the pin
+ * @pin:	Pin number
+ * @param:	Parameter to get
+ * @value:	Buffer to store parameter value
+ *
+ * This function gets requested configuration parameter for the given pin.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
+					u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_GET, pin, param,
+				  0, 0, ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_pinctrl_set_config - Set configuration parameter for the pin
+ * @pin:	Pin number
+ * @param:	Parameter to set
+ * @value:	Parameter value to set
+ *
+ * This function sets requested configuration parameter for the given pin.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
+					u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, pin,
+				   param, value, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_ioctl - PM IOCTL API for device control and configs
+ * @node_id:	Node ID of the device
+ * @ioctl_id:	ID of the requested IOCTL
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * This function calls IOCTL to firmware for device control and configuration.
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
+			   u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
+				   arg1, arg2, out);
+}
+
+static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				   qdata.arg2, qdata.arg3, out);
+}
+
+/**
+ * zynqmp_pm_clock_enable - Enable the clock for given id
+ * @clock_id:	ID of the clock to be enabled
+ *
+ * This function is used by master to enable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_enable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_disable - Disable the clock for given id
+ * @clock_id:	ID of the clock to be disable
+ *
+ * This function is used by master to disable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_disable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getstate - Get the clock state for given id
+ * @clock_id:	ID of the clock to be queried
+ * @state:	1/0 (Enabled/Disabled)
+ *
+ * This function is used by master to get the state of clock
+ * including peripherals and PLL clocks.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*state = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setdivider - Set the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value.
+ *
+ * This function is used by master to set divider for any clock
+ * to achieve desired rate.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getdivider - Get the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value.
+ *
+ * This function is used by master to get divider values
+ * for any clock.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
+				  0, 0, ret_payload);
+	*divider = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setrate - Set the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to set rate for any clock.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
+				   rate & 0xFFFFFFFF,
+				   (rate >> 32) & 0xFFFFFFFF,
+				   0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getrate - Get the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to get rate
+ * for any clock.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setparent - Set the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to set parent for any clock.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
+				   parent_id, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getparent - Get the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to get parent index
+ * for any clock.
+ *
+ * Return:	Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
+				  0, 0, ret_payload);
+	*parent_id = ret_payload[1];
+
+	return ret;
+}
+
+static const struct zynqmp_eemi_ops eemi_ops = {
+	.get_api_version = zynqmp_pm_get_api_version,
+	.get_chipid = zynqmp_pm_get_chipid,
+	.reset_assert = zynqmp_pm_reset_assert,
+	.reset_get_status = zynqmp_pm_reset_get_status,
+	.fpga_load = zynqmp_pm_fpga_load,
+	.fpga_get_status = zynqmp_pm_fpga_get_status,
+	.sha_hash = zynqmp_pm_sha_hash,
+	.rsa = zynqmp_pm_rsa,
+	.request_suspend = zynqmp_pm_request_suspend,
+	.force_powerdown = zynqmp_pm_force_powerdown,
+	.request_wakeup = zynqmp_pm_request_wakeup,
+	.set_wakeup_source = zynqmp_pm_set_wakeup_source,
+	.system_shutdown = zynqmp_pm_system_shutdown,
+	.request_node = zynqmp_pm_request_node,
+	.release_node = zynqmp_pm_release_node,
+	.set_requirement = zynqmp_pm_set_requirement,
+	.set_max_latency = zynqmp_pm_set_max_latency,
+	.set_configuration = zynqmp_pm_set_configuration,
+	.get_node_status = zynqmp_pm_get_node_status,
+	.get_operating_characteristic = zynqmp_pm_get_operating_characteristic,
+	.init_finalize = zynqmp_pm_init_finalize,
+	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
+	.ioctl = zynqmp_pm_ioctl,
+	.query_data = zynqmp_pm_query_data,
+	.pinctrl_request = zynqmp_pm_pinctrl_request,
+	.pinctrl_release = zynqmp_pm_pinctrl_release,
+	.pinctrl_get_function = zynqmp_pm_pinctrl_get_function,
+	.pinctrl_set_function = zynqmp_pm_pinctrl_set_function,
+	.pinctrl_get_config = zynqmp_pm_pinctrl_get_config,
+	.pinctrl_set_config = zynqmp_pm_pinctrl_set_config,
+	.clock_enable = zynqmp_pm_clock_enable,
+	.clock_disable = zynqmp_pm_clock_disable,
+	.clock_getstate = zynqmp_pm_clock_getstate,
+	.clock_setdivider = zynqmp_pm_clock_setdivider,
+	.clock_getdivider = zynqmp_pm_clock_getdivider,
+	.clock_setrate = zynqmp_pm_clock_setrate,
+	.clock_getrate = zynqmp_pm_clock_getrate,
+	.clock_setparent = zynqmp_pm_clock_setparent,
+	.clock_getparent = zynqmp_pm_clock_getparent,
+};
+
+/**
+ * zynqmp_pm_get_eemi_ops - Get eemi ops functions
+ *
+ * Return:	- pointer of eemi_ops structure
+ */
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return &eemi_ops;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
+
+static int __init zynqmp_plat_init(void)
+{
+	struct device_node *np;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
+	if (!np)
+		return 0;
+	of_node_put(np);
+
+	/* We're running on a ZynqMP machine, the PM node is mandatory. */
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
+	if (!np) {
+		pr_warn("%s: pm node not found\n", __func__);
+		return -ENXIO;
+	}
+
+	ret = get_set_conduit_method(np);
+	if (ret) {
+		of_node_put(np);
+		return ret;
+	}
+
+	/* Check PM API version number */
+	zynqmp_pm_get_api_version(&pm_api_version);
+	if (pm_api_version < ZYNQMP_PM_VERSION) {
+		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR,
+		      pm_api_version >> 16, pm_api_version & 0xFFFF);
+	}
+
+	pr_info("%s Platform Management API v%d.%d\n", __func__,
+		pm_api_version >> 16, pm_api_version & 0xFFFF);
+
+	/* Check trustzone version number */
+	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
+	if (ret)
+		panic("Legacy trustzone found without version support\n");
+
+	if (pm_tz_version < ZYNQMP_TZ_VERSION)
+		panic("%s Trustzone version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_TZ_VERSION_MAJOR, ZYNQMP_TZ_VERSION_MINOR,
+		      pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	pr_info("%s Trustzone version v%d.%d\n", __func__,
+		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	of_node_put(np);
+
+	return ret;
+}
+early_initcall(zynqmp_plat_init);
diff --git a/include/linux/firmware/xilinx/zynqmp/firmware.h b/include/linux/firmware/xilinx/zynqmp/firmware.h
new file mode 100644
index 0000000..859d809
--- /dev/null
+++ b/include/linux/firmware/xilinx/zynqmp/firmware.h
@@ -0,0 +1,590 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __SOC_ZYNQMP_FIRMWARE_H__
+#define __SOC_ZYNQMP_FIRMWARE_H__
+
+#include <linux/device.h>
+
+#define ZYNQMP_PM_VERSION_MAJOR	1
+#define ZYNQMP_PM_VERSION_MINOR	0
+
+#define ZYNQMP_PM_VERSION	((ZYNQMP_PM_VERSION_MAJOR << 16) | \
+					ZYNQMP_PM_VERSION_MINOR)
+
+#define ZYNQMP_TZ_VERSION_MAJOR	1
+#define ZYNQMP_TZ_VERSION_MINOR	0
+
+#define ZYNQMP_TZ_VERSION	((ZYNQMP_TZ_VERSION_MAJOR << 16) | \
+					ZYNQMP_TZ_VERSION_MINOR)
+
+#define ZYNQMP_PM_MAX_LATENCY	(~0U)
+#define ZYNQMP_PM_MAX_QOS	100U
+
+/* SMC SIP service Call Function Identifier Prefix */
+#define PM_SIP_SVC			0xC2000000
+#define PM_SET_SUSPEND_MODE		0xa02
+#define PM_GET_TRUSTZONE_VERSION	0xa03
+
+/* Number of 32bits values in payload */
+#define PAYLOAD_ARG_CNT	5U
+
+/* Number of arguments for a callback */
+#define CB_ARG_CNT	4
+
+/* Payload size (consists of callback API ID + arguments) */
+#define CB_PAYLOAD_SIZE	(CB_ARG_CNT + 1)
+
+/* Usage status, returned by PmGetNodeStatus */
+#define PM_USAGE_NO_MASTER			0x0U
+#define PM_USAGE_CURRENT_MASTER			0x1U
+#define PM_USAGE_OTHER_MASTER			0x2U
+#define PM_USAGE_BOTH_MASTERS			(PM_USAGE_CURRENT_MASTER | \
+						 PM_USAGE_OTHER_MASTER)
+
+/* Global general storage register base address */
+#define GGS_BASEADDR	(0xFFD80030U)
+#define GSS_NUM_REGS	(4)
+
+/* Persistent global general storage register base address */
+#define PGGS_BASEADDR	(0xFFD80050U)
+#define PGSS_NUM_REGS	(4)
+
+/* Capabilities for RAM */
+#define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
+#define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
+#define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
+#define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
+
+/* Clock APIs payload parameters */
+#define CLK_GET_NAME_RESP_LEN				16
+#define CLK_GET_TOPOLOGY_RESP_WORDS			3
+#define CLK_GET_FIXEDFACTOR_RESP_WORDS			2
+#define CLK_GET_PARENTS_RESP_WORDS			3
+#define CLK_GET_ATTR_RESP_WORDS				1
+
+enum pm_api_id {
+	/* Miscellaneous API functions: */
+	PM_GET_API_VERSION = 1,
+	PM_SET_CONFIGURATION,
+	PM_GET_NODE_STATUS,
+	PM_GET_OPERATING_CHARACTERISTIC,
+	PM_REGISTER_NOTIFIER,
+	/* API for suspending of PUs: */
+	PM_REQUEST_SUSPEND,
+	PM_SELF_SUSPEND,
+	PM_FORCE_POWERDOWN,
+	PM_ABORT_SUSPEND,
+	PM_REQUEST_WAKEUP,
+	PM_SET_WAKEUP_SOURCE,
+	PM_SYSTEM_SHUTDOWN,
+	/* API for managing PM slaves: */
+	PM_REQUEST_NODE,
+	PM_RELEASE_NODE,
+	PM_SET_REQUIREMENT,
+	PM_SET_MAX_LATENCY,
+	/* Direct control API functions: */
+	PM_RESET_ASSERT,
+	PM_RESET_GET_STATUS,
+	PM_MMIO_WRITE,
+	PM_MMIO_READ,
+	PM_PM_INIT_FINALIZE,
+	PM_FPGA_LOAD,
+	PM_FPGA_GET_STATUS,
+	PM_GET_CHIPID,
+	/* ID 25 is been used by U-boot to process secure boot images */
+	/* Secure library generic API functions */
+	PM_SECURE_SHA = 26,
+	PM_SECURE_RSA,
+	/* Pin control API functions */
+	PM_PINCTRL_REQUEST,
+	PM_PINCTRL_RELEASE,
+	PM_PINCTRL_GET_FUNCTION,
+	PM_PINCTRL_SET_FUNCTION,
+	PM_PINCTRL_CONFIG_PARAM_GET,
+	PM_PINCTRL_CONFIG_PARAM_SET,
+	/* PM IOCTL API */
+	PM_IOCTL,
+	/* API to query information from firmware */
+	PM_QUERY_DATA,
+	/* Clock control API functions */
+	PM_CLOCK_ENABLE,
+	PM_CLOCK_DISABLE,
+	PM_CLOCK_GETSTATE,
+	PM_CLOCK_SETDIVIDER,
+	PM_CLOCK_GETDIVIDER,
+	PM_CLOCK_SETRATE,
+	PM_CLOCK_GETRATE,
+	PM_CLOCK_SETPARENT,
+	PM_CLOCK_GETPARENT,
+};
+
+/* PMU-FW return status codes */
+enum pm_ret_status {
+	XST_PM_SUCCESS = 0,
+	XST_PM_INTERNAL = 2000,
+	XST_PM_CONFLICT,
+	XST_PM_NO_ACCESS,
+	XST_PM_INVALID_NODE,
+	XST_PM_DOUBLE_REQ,
+	XST_PM_ABORT_SUSPEND,
+};
+
+enum zynqmp_pm_reset_action {
+	PM_RESET_ACTION_RELEASE,
+	PM_RESET_ACTION_ASSERT,
+	PM_RESET_ACTION_PULSE,
+};
+
+enum zynqmp_pm_reset {
+	ZYNQMP_PM_RESET_START = 999,
+	ZYNQMP_PM_RESET_PCIE_CFG,
+	ZYNQMP_PM_RESET_PCIE_BRIDGE,
+	ZYNQMP_PM_RESET_PCIE_CTRL,
+	ZYNQMP_PM_RESET_DP,
+	ZYNQMP_PM_RESET_SWDT_CRF,
+	ZYNQMP_PM_RESET_AFI_FM5,
+	ZYNQMP_PM_RESET_AFI_FM4,
+	ZYNQMP_PM_RESET_AFI_FM3,
+	ZYNQMP_PM_RESET_AFI_FM2,
+	ZYNQMP_PM_RESET_AFI_FM1,
+	ZYNQMP_PM_RESET_AFI_FM0,
+	ZYNQMP_PM_RESET_GDMA,
+	ZYNQMP_PM_RESET_GPU_PP1,
+	ZYNQMP_PM_RESET_GPU_PP0,
+	ZYNQMP_PM_RESET_GPU,
+	ZYNQMP_PM_RESET_GT,
+	ZYNQMP_PM_RESET_SATA,
+	ZYNQMP_PM_RESET_ACPU3_PWRON,
+	ZYNQMP_PM_RESET_ACPU2_PWRON,
+	ZYNQMP_PM_RESET_ACPU1_PWRON,
+	ZYNQMP_PM_RESET_ACPU0_PWRON,
+	ZYNQMP_PM_RESET_APU_L2,
+	ZYNQMP_PM_RESET_ACPU3,
+	ZYNQMP_PM_RESET_ACPU2,
+	ZYNQMP_PM_RESET_ACPU1,
+	ZYNQMP_PM_RESET_ACPU0,
+	ZYNQMP_PM_RESET_DDR,
+	ZYNQMP_PM_RESET_APM_FPD,
+	ZYNQMP_PM_RESET_SOFT,
+	ZYNQMP_PM_RESET_GEM0,
+	ZYNQMP_PM_RESET_GEM1,
+	ZYNQMP_PM_RESET_GEM2,
+	ZYNQMP_PM_RESET_GEM3,
+	ZYNQMP_PM_RESET_QSPI,
+	ZYNQMP_PM_RESET_UART0,
+	ZYNQMP_PM_RESET_UART1,
+	ZYNQMP_PM_RESET_SPI0,
+	ZYNQMP_PM_RESET_SPI1,
+	ZYNQMP_PM_RESET_SDIO0,
+	ZYNQMP_PM_RESET_SDIO1,
+	ZYNQMP_PM_RESET_CAN0,
+	ZYNQMP_PM_RESET_CAN1,
+	ZYNQMP_PM_RESET_I2C0,
+	ZYNQMP_PM_RESET_I2C1,
+	ZYNQMP_PM_RESET_TTC0,
+	ZYNQMP_PM_RESET_TTC1,
+	ZYNQMP_PM_RESET_TTC2,
+	ZYNQMP_PM_RESET_TTC3,
+	ZYNQMP_PM_RESET_SWDT_CRL,
+	ZYNQMP_PM_RESET_NAND,
+	ZYNQMP_PM_RESET_ADMA,
+	ZYNQMP_PM_RESET_GPIO,
+	ZYNQMP_PM_RESET_IOU_CC,
+	ZYNQMP_PM_RESET_TIMESTAMP,
+	ZYNQMP_PM_RESET_RPU_R50,
+	ZYNQMP_PM_RESET_RPU_R51,
+	ZYNQMP_PM_RESET_RPU_AMBA,
+	ZYNQMP_PM_RESET_OCM,
+	ZYNQMP_PM_RESET_RPU_PGE,
+	ZYNQMP_PM_RESET_USB0_CORERESET,
+	ZYNQMP_PM_RESET_USB1_CORERESET,
+	ZYNQMP_PM_RESET_USB0_HIBERRESET,
+	ZYNQMP_PM_RESET_USB1_HIBERRESET,
+	ZYNQMP_PM_RESET_USB0_APB,
+	ZYNQMP_PM_RESET_USB1_APB,
+	ZYNQMP_PM_RESET_IPI,
+	ZYNQMP_PM_RESET_APM_LPD,
+	ZYNQMP_PM_RESET_RTC,
+	ZYNQMP_PM_RESET_SYSMON,
+	ZYNQMP_PM_RESET_AFI_FM6,
+	ZYNQMP_PM_RESET_LPD_SWDT,
+	ZYNQMP_PM_RESET_FPD,
+	ZYNQMP_PM_RESET_RPU_DBG1,
+	ZYNQMP_PM_RESET_RPU_DBG0,
+	ZYNQMP_PM_RESET_DBG_LPD,
+	ZYNQMP_PM_RESET_DBG_FPD,
+	ZYNQMP_PM_RESET_APLL,
+	ZYNQMP_PM_RESET_DPLL,
+	ZYNQMP_PM_RESET_VPLL,
+	ZYNQMP_PM_RESET_IOPLL,
+	ZYNQMP_PM_RESET_RPLL,
+	ZYNQMP_PM_RESET_GPO3_PL_0,
+	ZYNQMP_PM_RESET_GPO3_PL_1,
+	ZYNQMP_PM_RESET_GPO3_PL_2,
+	ZYNQMP_PM_RESET_GPO3_PL_3,
+	ZYNQMP_PM_RESET_GPO3_PL_4,
+	ZYNQMP_PM_RESET_GPO3_PL_5,
+	ZYNQMP_PM_RESET_GPO3_PL_6,
+	ZYNQMP_PM_RESET_GPO3_PL_7,
+	ZYNQMP_PM_RESET_GPO3_PL_8,
+	ZYNQMP_PM_RESET_GPO3_PL_9,
+	ZYNQMP_PM_RESET_GPO3_PL_10,
+	ZYNQMP_PM_RESET_GPO3_PL_11,
+	ZYNQMP_PM_RESET_GPO3_PL_12,
+	ZYNQMP_PM_RESET_GPO3_PL_13,
+	ZYNQMP_PM_RESET_GPO3_PL_14,
+	ZYNQMP_PM_RESET_GPO3_PL_15,
+	ZYNQMP_PM_RESET_GPO3_PL_16,
+	ZYNQMP_PM_RESET_GPO3_PL_17,
+	ZYNQMP_PM_RESET_GPO3_PL_18,
+	ZYNQMP_PM_RESET_GPO3_PL_19,
+	ZYNQMP_PM_RESET_GPO3_PL_20,
+	ZYNQMP_PM_RESET_GPO3_PL_21,
+	ZYNQMP_PM_RESET_GPO3_PL_22,
+	ZYNQMP_PM_RESET_GPO3_PL_23,
+	ZYNQMP_PM_RESET_GPO3_PL_24,
+	ZYNQMP_PM_RESET_GPO3_PL_25,
+	ZYNQMP_PM_RESET_GPO3_PL_26,
+	ZYNQMP_PM_RESET_GPO3_PL_27,
+	ZYNQMP_PM_RESET_GPO3_PL_28,
+	ZYNQMP_PM_RESET_GPO3_PL_29,
+	ZYNQMP_PM_RESET_GPO3_PL_30,
+	ZYNQMP_PM_RESET_GPO3_PL_31,
+	ZYNQMP_PM_RESET_RPU_LS,
+	ZYNQMP_PM_RESET_PS_ONLY,
+	ZYNQMP_PM_RESET_PL,
+	ZYNQMP_PM_RESET_END
+};
+
+enum zynqmp_pm_request_ack {
+	ZYNQMP_PM_REQUEST_ACK_NO = 1,
+	ZYNQMP_PM_REQUEST_ACK_BLOCKING,
+	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
+};
+
+enum zynqmp_pm_abort_reason {
+	ZYNQMP_PM_ABORT_REASON_WAKEUP_EVENT = 100,
+	ZYNQMP_PM_ABORT_REASON_POWER_UNIT_BUSY,
+	ZYNQMP_PM_ABORT_REASON_NO_POWERDOWN,
+	ZYNQMP_PM_ABORT_REASON_UNKNOWN,
+};
+
+enum zynqmp_pm_suspend_reason {
+	ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST = 201,
+	ZYNQMP_PM_SUSPEND_REASON_ALERT,
+	ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN,
+};
+
+enum zynqmp_pm_ram_state {
+	ZYNQMP_PM_RAM_STATE_OFF = 1,
+	ZYNQMP_PM_RAM_STATE_RETENTION,
+	ZYNQMP_PM_RAM_STATE_ON,
+};
+
+enum zynqmp_pm_opchar_type {
+	ZYNQMP_PM_OPERATING_CHARACTERISTIC_POWER = 1,
+	ZYNQMP_PM_OPERATING_CHARACTERISTIC_ENERGY,
+	ZYNQMP_PM_OPERATING_CHARACTERISTIC_TEMPERATURE,
+};
+
+enum pm_node_id {
+	NODE_UNKNOWN = 0,
+	NODE_APU,
+	NODE_APU_0,
+	NODE_APU_1,
+	NODE_APU_2,
+	NODE_APU_3,
+	NODE_RPU,
+	NODE_RPU_0,
+	NODE_RPU_1,
+	NODE_PLD,
+	NODE_FPD,
+	NODE_OCM_BANK_0,
+	NODE_OCM_BANK_1,
+	NODE_OCM_BANK_2,
+	NODE_OCM_BANK_3,
+	NODE_TCM_0_A,
+	NODE_TCM_0_B,
+	NODE_TCM_1_A,
+	NODE_TCM_1_B,
+	NODE_L2,
+	NODE_GPU_PP_0,
+	NODE_GPU_PP_1,
+	NODE_USB_0,
+	NODE_USB_1,
+	NODE_TTC_0,
+	NODE_TTC_1,
+	NODE_TTC_2,
+	NODE_TTC_3,
+	NODE_SATA,
+	NODE_ETH_0,
+	NODE_ETH_1,
+	NODE_ETH_2,
+	NODE_ETH_3,
+	NODE_UART_0,
+	NODE_UART_1,
+	NODE_SPI_0,
+	NODE_SPI_1,
+	NODE_I2C_0,
+	NODE_I2C_1,
+	NODE_SD_0,
+	NODE_SD_1,
+	NODE_DP,
+	NODE_GDMA,
+	NODE_ADMA,
+	NODE_NAND,
+	NODE_QSPI,
+	NODE_GPIO,
+	NODE_CAN_0,
+	NODE_CAN_1,
+	NODE_EXTERN,
+	NODE_APLL,
+	NODE_VPLL,
+	NODE_DPLL,
+	NODE_RPLL,
+	NODE_IOPLL,
+	NODE_DDR,
+	NODE_IPI_APU,
+	NODE_IPI_RPU_0,
+	NODE_GPU,
+	NODE_PCIE,
+	NODE_PCAP,
+	NODE_RTC,
+	NODE_LPD,
+	NODE_VCU,
+	NODE_IPI_RPU_1,
+	NODE_IPI_PL_0,
+	NODE_IPI_PL_1,
+	NODE_IPI_PL_2,
+	NODE_IPI_PL_3,
+	NODE_PL,
+	NODE_GEM_TSU,
+	NODE_SWDT_0,
+	NODE_SWDT_1,
+	NODE_CSU,
+	NODE_PJTAG,
+	NODE_TRACE,
+	NODE_TESTSCAN,
+	NODE_PMU,
+	NODE_MAX,
+};
+
+enum pm_pinctrl_config_param {
+	PM_PINCTRL_CONFIG_SLEW_RATE,
+	PM_PINCTRL_CONFIG_BIAS_STATUS,
+	PM_PINCTRL_CONFIG_PULL_CTRL,
+	PM_PINCTRL_CONFIG_SCHMITT_CMOS,
+	PM_PINCTRL_CONFIG_DRIVE_STRENGTH,
+	PM_PINCTRL_CONFIG_VOLTAGE_STATUS,
+	PM_PINCTRL_CONFIG_MAX,
+};
+
+enum pm_pinctrl_slew_rate {
+	PM_PINCTRL_SLEW_RATE_FAST,
+	PM_PINCTRL_SLEW_RATE_SLOW,
+};
+
+enum pm_pinctrl_bias_status {
+	PM_PINCTRL_BIAS_DISABLE,
+	PM_PINCTRL_BIAS_ENABLE,
+};
+
+enum pm_pinctrl_pull_ctrl {
+	PM_PINCTRL_BIAS_PULL_DOWN,
+	PM_PINCTRL_BIAS_PULL_UP,
+};
+
+enum pm_pinctrl_schmitt_cmos {
+	PM_PINCTRL_INPUT_TYPE_CMOS,
+	PM_PINCTRL_INPUT_TYPE_SCHMITT,
+};
+
+enum pm_pinctrl_drive_strength {
+	PM_PINCTRL_DRIVE_STRENGTH_2MA,
+	PM_PINCTRL_DRIVE_STRENGTH_4MA,
+	PM_PINCTRL_DRIVE_STRENGTH_8MA,
+	PM_PINCTRL_DRIVE_STRENGTH_12MA,
+};
+
+enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE,
+	IOCTL_SET_RPU_OPER_MODE,
+	IOCTL_RPU_BOOT_ADDR_CONFIG,
+	IOCTL_TCM_COMB_CONFIG,
+	IOCTL_SET_TAPDELAY_BYPASS,
+	IOCTL_SET_SGMII_MODE,
+	IOCTL_SD_DLL_RESET,
+	IOCTL_SET_SD_TAPDELAY,
+	/* Ioctl for clock driver */
+	IOCTL_SET_PLL_FRAC_MODE,
+	IOCTL_GET_PLL_FRAC_MODE,
+	IOCTL_SET_PLL_FRAC_DATA,
+	IOCTL_GET_PLL_FRAC_DATA,
+	IOCTL_WRITE_GGS,
+	IOCTL_READ_GGS,
+	IOCTL_WRITE_PGGS,
+	IOCTL_READ_PGGS,
+};
+
+enum rpu_oper_mode {
+	PM_RPU_MODE_LOCKSTEP,
+	PM_RPU_MODE_SPLIT,
+};
+
+enum rpu_boot_mem {
+	PM_RPU_BOOTMEM_LOVEC,
+	PM_RPU_BOOTMEM_HIVEC,
+};
+
+enum rpu_tcm_comb {
+	PM_RPU_TCM_SPLIT,
+	PM_RPU_TCM_COMB,
+};
+
+enum tap_delay_signal_type {
+	PM_TAPDELAY_NAND_DQS_IN,
+	PM_TAPDELAY_NAND_DQS_OUT,
+	PM_TAPDELAY_QSPI,
+	PM_TAPDELAY_MAX,
+};
+
+enum tap_delay_bypass_ctrl {
+	PM_TAPDELAY_BYPASS_DISABLE,
+	PM_TAPDELAY_BYPASS_ENABLE,
+};
+
+enum sgmii_mode {
+	PM_SGMII_DISABLE,
+	PM_SGMII_ENABLE,
+};
+
+enum tap_delay_type {
+	PM_TAPDELAY_INPUT,
+	PM_TAPDELAY_OUTPUT,
+};
+
+enum dll_reset_type {
+	PM_DLL_RESET_ASSERT,
+	PM_DLL_RESET_RELEASE,
+	PM_DLL_RESET_PULSE,
+};
+
+enum topology_type {
+	TYPE_INVALID,
+	TYPE_MUX,
+	TYPE_PLL,
+	TYPE_FIXEDFACTOR,
+	TYPE_DIV1,
+	TYPE_DIV2,
+	TYPE_GATE,
+};
+
+enum pm_query_id {
+	PM_QID_INVALID,
+	PM_QID_CLOCK_GET_NAME,
+	PM_QID_CLOCK_GET_TOPOLOGY,
+	PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
+	PM_QID_CLOCK_GET_PARENTS,
+	PM_QID_CLOCK_GET_ATTRIBUTES,
+	PM_QID_PINCTRL_GET_NUM_PINS,
+	PM_QID_PINCTRL_GET_NUM_FUNCTIONS,
+	PM_QID_PINCTRL_GET_NUM_FUNCTION_GROUPS,
+	PM_QID_PINCTRL_GET_FUNCTION_NAME,
+	PM_QID_PINCTRL_GET_FUNCTION_GROUPS,
+	PM_QID_PINCTRL_GET_PIN_GROUPS,
+};
+
+struct zynqmp_pm_query_data {
+	u32 qid;
+	u32 arg1;
+	u32 arg2;
+	u32 arg3;
+};
+
+struct zynqmp_eemi_ops {
+	int (*get_api_version)(u32 *version);
+	int (*get_chipid)(u32 *idcode, u32 *version);
+	int (*reset_assert)(const enum zynqmp_pm_reset reset,
+			    const enum zynqmp_pm_reset_action assert_flag);
+	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
+	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
+	int (*fpga_get_status)(u32 *value);
+	int (*sha_hash)(const u64 address, const u32 size, const u32 flags);
+	int (*rsa)(const u64 address, const u32 size, const u32 flags);
+	int (*request_suspend)(const u32 node,
+			       const enum zynqmp_pm_request_ack ack,
+			       const u32 latency,
+			       const u32 state);
+	int (*force_powerdown)(const u32 target,
+			       const enum zynqmp_pm_request_ack ack);
+	int (*request_wakeup)(const u32 node,
+			      const bool set_addr,
+			      const u64 address,
+			      const enum zynqmp_pm_request_ack ack);
+	int (*set_wakeup_source)(const u32 target,
+				 const u32 wakeup_node,
+				 const u32 enable);
+	int (*system_shutdown)(const u32 type, const u32 subtype);
+	int (*request_node)(const u32 node,
+			    const u32 capabilities,
+			    const u32 qos,
+			    const enum zynqmp_pm_request_ack ack);
+	int (*release_node)(const u32 node);
+	int (*set_requirement)(const u32 node,
+			       const u32 capabilities,
+			       const u32 qos,
+			       const enum zynqmp_pm_request_ack ack);
+	int (*set_max_latency)(const u32 node, const u32 latency);
+	int (*set_configuration)(const u32 physical_addr);
+	int (*get_node_status)(const u32 node, u32 *const status,
+			       u32 *const requirements, u32 *const usage);
+	int (*get_operating_characteristic)(const u32 node,
+					    const enum zynqmp_pm_opchar_type
+					    type, u32 *const result);
+	int (*init_finalize)(void);
+	int (*set_suspend_mode)(u32 mode);
+	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	int (*pinctrl_request)(const u32 pin);
+	int (*pinctrl_release)(const u32 pin);
+	int (*pinctrl_get_function)(const u32 pin, u32 *id);
+	int (*pinctrl_set_function)(const u32 pin, const u32 id);
+	int (*pinctrl_get_config)(const u32 pin, const u32 param, u32 *value);
+	int (*pinctrl_set_config)(const u32 pin, const u32 param, u32 value);
+	int (*clock_enable)(u32 clock_id);
+	int (*clock_disable)(u32 clock_id);
+	int (*clock_getstate)(u32 clock_id, u32 *state);
+	int (*clock_setdivider)(u32 clock_id, u32 divider);
+	int (*clock_getdivider)(u32 clock_id, u32 *divider);
+	int (*clock_setrate)(u32 clock_id, u64 rate);
+	int (*clock_getrate)(u32 clock_id, u64 *rate);
+	int (*clock_setparent)(u32 clock_id, u32 parent_id);
+	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+};
+
+/*
+ * Internal functions
+ */
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload);
+
+#if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
+#else
+static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __SOC_ZYNQMP_FIRMWARE_H__ */
-- 
2.7.4
