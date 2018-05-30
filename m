Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932525AbeE3U5T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:57:19 -0400
Received: from mail-by2nam03on0046.outbound.protection.outlook.com ([104.47.42.46]:37184
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932337AbeE3U4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:56:16 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v7 00/10] drivers: Introduce firmware dnd clock river for ZynqMP core
Date: Wed, 30 May 2018 13:55:15 -0700
Message-ID: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(2980300002)(438002)(199004)(189003)(36756003)(305945005)(966005)(107886003)(9786002)(26005)(36386004)(77096007)(498600001)(8936002)(4326008)(8676002)(426003)(186003)(72206003)(336012)(5660300001)(6306002)(486006)(2201001)(7696005)(51416003)(106002)(2616005)(476003)(2906002)(39060400002)(126002)(356003)(48376002)(16586007)(50466002)(106466001)(81156014)(110136005)(54906003)(44832011)(63266004)(47776003)(7416002)(50226002)(81166006)(6666003)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2194;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT062;1:a/t43TIGIKa4LQyiUH83lAj/wG5+CqORASh8EmCYYUOw1nAYU1MQhSbWk2S7huUCA5lBkDZAbl8y+gwdbfesImAvtnK2vHNnrUT9+TBb8i6r0LSdo4j8kAXajD6sD4R2
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR02MB2194;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2194;3:/RgVI7FIf6KDii+74Ygzq3v+h3ZbaCw/d+PySzg+QdVGgsQrDukbZRUpk55IWTElpb/U0vt7RpYfDyjY94UOWWFPXo0DL/H2BvEw044KMfmlB7jiMixHjF2W5vjJSRd5DLKDVM1w8lumJI8IW3KDtqwBgP6cX9hMwi4MNJvObsqq2fEWnBtt7sh1/Kg7jP5F7gpJJ/2IuQAaGLmvfD5voJAmRm8Dou4sAuEYKKCshWfnhIQ1nsNvlNPrC/e2M7wKM4Cek2zXGQnEoB/w4fzHoJX6Ki5ytBH2a1sAuiyza4HdiD+2gtELKwWdtRSlL1SvPhRwcELbW79WiX246ywoVMYaqxvyRnkJ3DhyxJ+zX5Y=;25:EfjZDjOr8Q61ZvhXHJpCfdPMTE3gM+plnm2DLm36KqKUPsDterD/wVQ1LcPTbSY+tXNBNPcvz6+b1bXSab4YZoNOUdpb4MrKIiYt6OyMroRrp2kJgRG5PIg3kbJs4xOY+UWR28aC3y+XjPzvw8Mw3/exqLCC+3eqBMz0Y9nlS9SC1iHcnqQh+mDX08ssBMrfzqgF7kgRLYDMfmziLTgZ/RX5uoTWZHWgVYFNWBpUxg7V/5KwF3+T+bwy1fl1Zjo/zqg9zGqG52HJDEPbPvRAYNBrkupA/FqysJlYWtzRrViSONiX35412Y4W2fwChmVSx2FYzZItvyBiTgYCcvRqmA==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2194:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2194;31:IWnEakcBd5bWtg4qhaBSAY4Q5oLaiW+3E9DlMPZbemdMX0AvFNafY7y6KPZ8/V8g/JAPZFBY9RFNlJFjXwfMArh96LPcqJqAHTEkYGRtsiFPUsJH1/xWZ9DsHpNH0GIZhXVDd1p2hLheussizeKRXDhuyXST9yotOpdjDK8P9ntJsKfqTvbwcdYmJc02vyvZ4XxvpwVoJ1mgQlA/BzuMWw6/wryyoeHC8/6vDpckoYQ=;20:5lsh50W+inODkhYYMrlN7Z3KmSD57RTdqFrHE6yuOao4P3MMpt2RrGNwmLSB+9j6sOHjVU3qJa1+WuVeI2FD+Jay9tfTpktPHymsdAXDUIdY94AqoNxr5NPXbMvm9GMf+XtPbKUWxbOl8+4RWMNODzF80/RX1eaT2Apwfhb5oC3Qzsc2/72fsFEAcufrHesqJF1w0WZlQDO1+OiBueb5wIlHzezsythBUw/AtrvLB0LlfLAAb1DmMzofc8lsUAZwTgr5/jdfhLEJamBe5dYQdfxYphDtnmgQngVYmLoduXxw3mNKjDS91YuS995rZ0NAyhv7D676sbJa7ZhIEOixCMvPS25YWqkFQopcOcQBX8rt6TyYU9bFkW9F/02DzQggmmbf+zpFSNcSOeGcuW9oG1CjLLRBUAcg4entVcDA4gDEh12AqgAJMHXv3aMHr2xwKJh+0c78sWHSBmSRIJtSvhcvpBkTbNDvJNgair4EaDeVP7WdrwmC4ZETtNI4VE8D
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2194DB6BD3CC68749CB5C0E3B86C0@BN6PR02MB2194.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201703061421075)(201703161042150)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6042181)(6072148)(201708071742011)(7699016);SRVR:BN6PR02MB2194;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2194;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2194;4:EjwE7yMq2Ku5+6UiEOCaLl8acf7kcNCIy+SBeGfvF/y+xX2m/YqBdyRQNTZN0wclYoTbflLfTtJHD42DEChcx8BDz6wRhQrcwfcT7TBikIGRqaxcsicmmDPJC4uSCS+ijaF2UuxC575EfTivUn4Bh2hWL7NbU5KsR436oB1TWcjy4m7yyyvb9DLtPt7FwtnzmyltDLgEtrZBz6qSCWDMgGGAbaS7zRZx0Y7X/RHTWFONYTj5AcOo3uveW/l3FRuqYf+i2p3r0V9RckotN4iSrQ==
X-Forefront-PRVS: 0688BF9B46
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2194;23:PboMVwibSRhW6+PG9J6pESu3adnJZ4He/umVg4ZS+?=
 =?us-ascii?Q?B7D7DJ1BFDCgeUcViqjhAYGIhnwkmxnS0Tc+0AuczbZhf2pVRAv1f9XgGlTo?=
 =?us-ascii?Q?Z3isRHgmr/4JcZT1ygzBX7dMGmXll94uSADwLYlhjwdVk4AO0DlhbRvMHITX?=
 =?us-ascii?Q?5jd4QFIZlw7FQjB3EZ8+faeSUMjyYxPr5X8mYoCjXMccxByYgzYdA1no6g2L?=
 =?us-ascii?Q?pY7Y7L126/sKOIrjQQQw2ykpK/8uWKAZ2DA1iQMut5Wue7QDemhmvc1wXJuN?=
 =?us-ascii?Q?gNg+TR64PgMO79ivnM0r2Rl0CIkUbSnSdGwgJI5FY2AGnAr4LRKEOcOgiNV5?=
 =?us-ascii?Q?R9WZBgbVDdsBZSZ44WjKVMBGUyTvM2NTfW1hNBx2B1KUswBPm2kWytsjXtnc?=
 =?us-ascii?Q?rTzzVa7TZnZ3DL2pPEJAh/WwFLojPUryQUiukhX0DCkr6/tfoV4JW2iYc7rx?=
 =?us-ascii?Q?X5D1pH5NM7I9cAxDXYzrUMHWx5C6W4tlG0Tfjss31jd8N1CLkRzZMK349xGW?=
 =?us-ascii?Q?5SebrIKWefEc0rvLWA98dDT2SMmOITM66M4e0bF5KWdxri5+jaa4e/0AP7h+?=
 =?us-ascii?Q?HFqTr3gkjw2D2XH/TfiXtGeEDi7kaQAsFh6hNxysyOEbfUgWHKWvIICDRYXY?=
 =?us-ascii?Q?Axi8J9DL0RImhtISmL8LBaCTQbM88qgcw7FBDxFnoX51tBSGK/AH3WGm+QoY?=
 =?us-ascii?Q?QOobVaQQhWgjzCLr5gDfIfGXs51nmH8Bn2AYzrC5ZixviKc1+9iDAuSadrxy?=
 =?us-ascii?Q?cE3eC4SOZ2snFHhi6sqMQ0lzS6tL4FX59I9dB7oRXkMgXpefoSKSCtm8Yz+J?=
 =?us-ascii?Q?bvgunZyWAKMLxkRwHk9tbfw8fNXcdiNXer6x6r1HawHKdnlzIs7sFZtSJTGZ?=
 =?us-ascii?Q?iZvUMOGpHlrycRz2XY0kFcgLfjHnP4lgwWqu0RhhJrzM5cln8uLapeELNWMo?=
 =?us-ascii?Q?XzoXTNzV/oZPpwrJHXZncZK9+8NJ+j+wmGIDhHhpz+ybVwW4/ulYzbiWZ3pi?=
 =?us-ascii?Q?aLLz1RvI7xMHBnhGEzS6YOH+sIaXYPMKd7kzMtdkKY3SmM6KMj8n/RxvPla5?=
 =?us-ascii?Q?guI4GU+q66r+/708eONGJENO/KE1HNwDU04pMxv+m3hH5090QnEeSL5ym7xY?=
 =?us-ascii?Q?kMNASt3fGw=3D?=
X-Microsoft-Antispam-Message-Info: Hc6cggeouZvK4n1wzQslWTT8kcj2Id2c6l5paAZ+T6vzgVTgAC3KK7sBUkU/yNQSm+kpG3JifKCyE8oIu6mV2pci0kJVF0JZgE9fzVvJAAm93atvp7DoFc8pVqnvoqs66J3vjUiOL5i0KVVPmGr5LX30/THOiRDWL0ToABDuz5mRGXpBxZgOpE3zD4a8fieg
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2194;6:Ki+LV/9+O9RZhznbfZ8DowOZua40vy75Er2UYMlXEJph6sim8OPt70V6zSM68/2P/JvqR1r/318uXCoR7a2XRxSTPRvo5Xo4ZIKixKy37c2u6M1+nR3old1PQukCLFu5TTUFJoaMRivZrmSamFr/uzmpvmb5kYQvuCy6ubFENhT8FHyDLlDDu94ol1O0AfQP8PR9Cs3nOsyESY6OV1i6UDIVKQbB+gmsVDvtPa7vsdrN+DZneXWlrwE5NEPPoVC61cbpiY/Yawv2DsVM1AM9Jp1ZY5UDNKDAF4DFECgcIfWolMkQVmnvaRrtp01zvwvVDk0ATWVJoQqmUTreVnlIgu3mWTQ64ApyXVQpM0l6u4O6Jmg4Qqd2hRRkluElMUNoobvOSXONEn6flh/GzflKiPYR5/CN7y2T2jT6sqF/qMbXHfH4E5V7XCYCiKM9TrHHq2NFwv436hgieFva1cY/iw==;5:uKjWt7TyUL87iBh19DPv4lq0acAjbiuSfGAuL691QNDuHEgn8LtgfO9p/IFx5yzearRMt1n7lXo3d72ewgPjiiHiodNO3KQ2OFZQgMIqnt90MSktohEKM14OUojrAovLQzZV6LfSwsPWWgCz8eXRQDhJBJwIYuqnTejulAo68lU=;24:/MhB0fe1Y+r7fnu0aO72qLACJWSkFdkb0o3yW5CXqzMyFjrgmkp/WSTxOWY2dd75c+S+EWOwiJYipKgcUHUL3TJDoySz7pyGAhLHFZKTSbs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2194;7:iVfwQAIiKF3YiNd4w9UtkzAR3j60pbNvB92jZLwlejrWB34hx4d0MgY92EwiKJaOBugvEFZLfrYC+/WlCEEzFbIhP9sB2RhSsvWDAkXfPdZma2z7BfwIVibxln/0rYy6CTTWwr79vHWGFsRs+z9txZ3IjO2epypZwuORJXZaSQq8lgdag8mPvGWe3UjV4lk8/VPLtqhvspQEkaiBh2d9KouJc2h8kc1lJL2UxqmLvsCnQJKEBweKrVgRaEQkPUOt
X-MS-Office365-Filtering-Correlation-Id: 117bea2f-92a4-4d0b-9d64-08d5c66fc2e4
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 20:56:05.0287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117bea2f-92a4-4d0b-9d64-08d5c66fc2e4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2194
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v7:
 - Removed xilinx specific clock debugfs API support
 - Added reviewed-by tags for FW and clock bindings
 - Updated clock node name to clock-controller

v6:
 - Broke patch series to have base FW driver and Clock driver user
 - Incorporated code review comments from last FW and Clock driver patch series. Discussed below:
	https://patchwork.kernel.org/patch/10230759/
	https://patchwork.kernel.org/patch/10250047/

v5:
 - Added ATF version check support
 - Updated some functions to be static 
 - Minor function name corrections

v4:
 - Changed clock setrate/getrate API prototype to support 64 bit rate
 - Defined macros for get_node_status return values
 - Moved DT node as a child of firmware
 - Changed debugfs APIs to return data to debugfs buffer instead of dumping to kernel log
 - Minor changes to incorporate other review comments from v3 patch series

v3:
 - added some fixes to firmware-ggs.c
 - updated pinmux get/set function argument names to specify function id instead of node id
 - added new pinctrl query macros
 - incorporated review comments from v2 patch series

v2:
 - change SPDX-License-Identifier license text style
 - split patch into multiple patches
 - Updated copyrights
 - Added ABI documentation
 - incorporated logical review comments from previuos patch. Discussed below:
	https://patchwork.kernel.org/patch/10150665/


Jolly Shah (1):
  drivers: clk: Add ZynqMP clock driver

Rajan Vaja (9):
  dt-bindings: firmware: Add bindings for ZynqMP firmware
  firmware: xilinx: Add Zynqmp firmware driver
  firmware: xilinx: Add zynqmp IOCTL API for device control
  firmware: xilinx: Add query data API
  firmware: xilinx: Add clock APIs
  firmware: xilinx: Add debugfs interface
  firmware: xilinx: Add debugfs for IOCTL API
  firmware: xilinx: Add debugfs for query data API
  dt-bindings: clock: Add bindings for ZynqMP clock driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  82 +++
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  11 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 146 ++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 150 +++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  53 ++
 drivers/clk/zynqmp/clkc.c                          | 737 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 219 ++++++
 drivers/clk/zynqmp/pll.c                           | 345 ++++++++++
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/xilinx/Kconfig                    |  23 +
 drivers/firmware/xilinx/Makefile                   |   5 +
 drivers/firmware/xilinx/zynqmp-debug.c             | 249 +++++++
 drivers/firmware/xilinx/zynqmp-debug.h             |  22 +
 drivers/firmware/xilinx/zynqmp.c                   | 562 ++++++++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/linux/firmware/xlnx-zynqmp.h               | 115 ++++
 21 files changed, 2844 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

-- 
2.7.4
