Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kZ+DMPNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1769605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbeFFHv0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:51:26 -0400
Received: from mail-sn1nam01on0070.outbound.protection.outlook.com ([104.47.32.70]:27094
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932320AbeFFHvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:51:20 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To: <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <wmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <miquel.raynal@bootlin.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v9 0/4] Add arm pl353 smc memory and nand driver for xilinx zynq soc
Date: Wed, 6 Jun 2018 13:19:38 +0530
Message-ID: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(39380400002)(2980300002)(438002)(199004)(189003)(6306002)(16586007)(110136005)(9786002)(36756003)(486006)(476003)(2616005)(126002)(50226002)(81156014)(8676002)(81166006)(2201001)(305945005)(426003)(54906003)(356003)(336012)(36386004)(77096007)(8936002)(316002)(7696005)(51416003)(26005)(106002)(2906002)(186003)(50466002)(48376002)(478600001)(966005)(106466001)(5660300001)(7416002)(63266004)(4326008)(47776003)(6666003)(39060400002)(107886003)(921003)(107986001)(5001870100001)(1121003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1494;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT034;1:T1iVcdug5vmRooNpUjKzAAPRlZEhnQTf+V8J1mfuW1gf2uzPUb9pedimKwD5q5R/zByrXKlZoRXwvCX8+hiE2Z3BcVSUfVKhiX92DawOudkgAq53XPuMwvhNSo510iUa
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR0201MB1494;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1494;3:BicQUpjF4hmtHElOrMy4is8GgrK5/S3vcsg2zbTWy27fdByOl0EQ1yfSxPZRNeyL5Br/9LZ0znaHSt+R0XW7lLUuYeDZ6RH10TcVrkYi0Mfpjzl8W94Pj6JiWhENnxr4H7VG4+fC08rj8/EVfQFkNOWNBNIXsRYPWdXhU2XkUu3nKIX221SQlpwbNu1fUnA8GhwnAm7PRbE0J0TDAEGNPGnX6QVPR6YdQPx9AclxxXHu14hygpwupvV5ZBVIM2CwZKO1TK2JDz8JneH3TzD6dqjcxMqpNg5kZqrhfNmpL+9fMVrGHO+OyS5+1p6p6YTBnCme26YWsM8LVNZr8HuLSNlJiz9Jw1Z+o8Bq5QaUoDA=;25:ubb9WHWb8aP7rjuAmwlwOe/sbe6dgPAu/LSSdJhy5FpBTiL40HsNOxQs3L2H+2mWPLwHsr/uh0tc6+T5evGx4eXL+jrxXYfXgYsnXzW4A/0pF8efYEJRoYzR4+CKO5CmcnYa/XD6iRkD87jI3Mu/RFZtD8QswSNd6Tt+BdrkqYa3J4cWyy6vM/wkWS7rYRYcaF3G2O3Crj+SPndJFvhy9HrS5wV5iYzUhswYWH4e/7SBegYd1OFtzhPTk2i4YFcZV0+ZmV51c5xceUxnB1+uChimTfCSRvyR0KHFzoC4epjKq+AIhptHxVRyC12AkTbhYH1IthwSJ47w9Cmw8m0Fug==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1494:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1494;31:Ff1rs3ZFp8g7lbkZrc7Mpw94Dd3or6u3kb+D1MZDga+QhH4NtsEKzfvzIPaRFstUBhPwf38YVgNenlg8DIqVcqRoomm+zmiNkw2NR9H+KgmGIeP4ggllWnpPwAAtsvR03uyeH7gPOnln3iaA9bUG8ZeMuIThpigl6a77AbFtvJ1TRu8kufYzq3USHWO7dQzmN/+PynWmGp+ms/4bKU+Cn7ey21w+aBfbb7PacwX0Zoc=;20:HqKpRoN+zZoyXNcvIymJ2BUpnAEYhh2KSpX8EU4mEF37gomLIfH30JjzdyA3Ej+WmKWzPH7pCigiTnAtiU8SEFst81Z0rfOi7R490MSbtkZaDV6siHGwX0aCVpaPrU9v9YvPDfwXJGZmoKMbROqRYenPzPiQZTbmJcZ8gOq2DOzBemoUJ1pn7GJk3AD7MXqk9VopLvzKVomgVJvaK11Z5hhTWAg6aY9AYqYxK95uCFTcJT3JPn+6uRTxf8Y0StgTNpW4ymDJnIvElw2c8rpWT83ZI/Ctm98uXB4UUNScC98ZP6m2xrZG4+tdTRJIKdOAw3++AsPo/kIdj9i8lCt7bR6OeiT2OOhxg5mur8JIw+6rE8lU1m2lRXARs/mIxOvgSaqxtKRM+rE6UjAm4bisrxT8e2H0HnARDOTc2sqpkLn48Nr4+LK54FQGqXmVfyGeACZ9Vwm6DsOR+5XBpqJEWUwxtd4BO9i5YCAiio15puEmZr6lQXZuokeUzYTnTAd/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB149456E00F103CD3D7EFEF0BAF650@BY2PR0201MB1494.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR0201MB1494;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1494;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1494;4:wINzSG/O5IDjZjx/SCH9WSfDf1gwyxTNc3P+6C3UFRXvCIgvNzMzjUpttu1O+CxRFU9dVtNePhCGLU4dtiwmjj3Yw8J+LU8VHFy6Idzk8mWipBZlnkI9MRpb0XwBc9n4uXM4LitZ8pPayg8cQpuR7k8jUpPHZPOOa3yW2L2YINSX+Asosz/G649VCC+/0R6vjpIJ3G75aT9RHXwIRdR7XPnMZJjrwT7w6ddLlq8MiStQebURvqQ9KXItPUGWRBXrlifPepWceER+wQnfR5JXAfgqjgy2qqoZtap0jvmMG+4NFOfeHv9WiVonS9UdjVXYOq+D94VJ1zKzTr+fZtCdu71LmS+gQnyNIsibTbpfpORtW9NB7gfIGFrHr3ZhBmCO
X-Forefront-PRVS: 06952FC175
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1494;23:c9lMH4OazE9MjtEvSYeVNlTL4ap+FGZDfVsKDS1?=
 =?us-ascii?Q?dIEXWKzhFrqO5BWhrpD1ouxqNiLNRL7Y3e9uzP+d+U2ymuLeKKqQH2lzYPdH?=
 =?us-ascii?Q?Rk76C++srt1ab8eNnELmYzkY3/5/oLykI0Ur/bjXYc3L2EevYvcdKZPq8sDe?=
 =?us-ascii?Q?Xpb7lhEs+hdF5CazhSZkJmevm9QRqth9Cdas2OjRjzT+JUxFh0Js9wrWfzSb?=
 =?us-ascii?Q?UfHQbzZyuRCGEbgOIU8piFM6hWBOT4jsPsyNSxAkMHHewWX5/m4opvhs59s8?=
 =?us-ascii?Q?ZNMCh3GVTfcweNAH0jgoKuxdNclnH6BUv7R9aLxkJz/i56w3iSsmB/GN8EwU?=
 =?us-ascii?Q?HcsWnybOHo6l7IbRwZtXxmbE7x6A2keu6AU9xafQ5pflO/oMzv+Vqc/UAl/P?=
 =?us-ascii?Q?YasYSsIq0VKC09aFjvnkdDDRBmm8L90ubLodolDnX48H9oK+g1tnC+7HBX0y?=
 =?us-ascii?Q?39G16oHBuwswTOv4wIGf5kJrPT7ylQkC/Yb5hxAcCn7mxlGAHrBWnY2taw44?=
 =?us-ascii?Q?FPf/Z00HMuA3nIx8XaV1Xhuv0Y/jW5IKGsvxcUolLu63osd6mpoEEmWcEtKl?=
 =?us-ascii?Q?d8u/+1a+3NcMRCbcwf7fNxeRD5dC8540tU0b88gEdkYSPce4x93qV4Jx7JNt?=
 =?us-ascii?Q?8oFtNtgKEH29yF9aGGsUE/JOyw2rXwMbhruCzIuLEq6G8DtjypciYEhJv++y?=
 =?us-ascii?Q?kfuQoRa9CE+IBdm95WJtWmKfLJmNYBSGobIuvT3KHOh5yUvlfrGo8MQvptr3?=
 =?us-ascii?Q?tJXDEvUhXis3D4X/3qTvaKp3zkHKsLoMnJArqqdoOs61+6FqgOQcBxDcsSoA?=
 =?us-ascii?Q?VPqIoO6tICypT2uaKtH3EIQULd+b4qs6RuQ7Pl2xxq3/j8JAp+sBmuYdpaIe?=
 =?us-ascii?Q?38RVAECUyZRD4Wuqvs82egeeLmZtd2XzybjGT9ESP/plXJpl72YjyqNXIq2S?=
 =?us-ascii?Q?ytageffqnEnUhVZGtQ0rCkHyaFCW+gdLEaZriwzBoGxnrlBLMlSKhVdXyEwK?=
 =?us-ascii?Q?KE6meJmeg0BKGuuiylncz5eUj1M37Gj1JuHoqg1c4Lyf9T3ERcUAULEaiRdO?=
 =?us-ascii?Q?M0Dj/DTkFLF+TpCS1tt5qztfWMnhhL+fPDVmM1Co7KDyg2fVoHs24xj8BdPg?=
 =?us-ascii?Q?sinjms0djsyTS3Bx7p6D+rbe7vnTJYstukq3Fjs5C7swNKr4NOOjid+Qm1XS?=
 =?us-ascii?Q?iN8vzEoNfWnvI8pSqJSYBY/ow7+3+IYc1eUs22LWDfiEx4RklWfcZWjQre1A?=
 =?us-ascii?Q?O05K6+GxZtAH3vQejUp8=3D?=
X-Microsoft-Antispam-Message-Info: rp7xVHA34KYutBtUjd4PRw9+E8AKMxY6NQKgHUjyZ907mFs4/o6TGFfpkCx1JpVSUCUygHeIgiRg4e0RkCOxSTnePz06SY3QK5Dp1Tu6sDT9xbg4AxSbT2Exso87rlP8UaAugXh5fKb5/PchoXKxnHoM62osKLD+3Q0Gr4+BtMqP17PA0bUrGuoxuz5uOCbR
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1494;6:SfV2OCwkvoHkl9HTIJivwx4osENM5YJTIX/wP6eX+T4DlIww3ncnSOXLeg8GKsxhR8gIYAGDbaqtjTtOebUV6Y0Te2JCQO75tTVsaGKn9r69ok0Mi8QkGsCfzo/x4pgt9UD/b6zsEetwNy3hjk7l4ZsthNCAtZ9iNxwz3a4CI0eXWc2z7IJFi2SSqKDB+UW5DBC/6b9aVj8abNceusm/Spm87wcBIoN/VInvp+9cQnJjSg4fprTn/3Wztl/yAMBuowJNYGNfu+mRqiI+DMxkEpaxvC2KRcRnZbNvfPps3JgxsMYib90SowpEkf2HtmiPsep8fKBs08IRMVSPG9TGXxQJDzlKmPgy6Da824/HQ11gfihgQYletl8cY2L86GNZfWoD4vDpOhBuIZsDJjEIPFBlkCqGXlehPYwvMSHiHIBJZJXUxN1Yvpim6FP9UfDIcuYAxry1QTwEiFODKPvw2Q==;5:JBlaTXXp7TP9InLDOr3X7uQ+J2BKtOst2mTO+42QTv7/S6LMHmJzmGZCpgNoPNjwGJGWlXbDwAim3XUlxdd7M5XGfel4cAVFbBtI8mEDoRbE9gYDxoLLJ1Daz+bS1KrUbB5P6RRWiIyx6komYKKwA8s4LNIwN+laItBgyWoD/1o=;24:XFFs9D8yjBCazDOIpTUwDMVCSCXTudM/J6jNCTFW1pdq+2A2xwPa+i7QbU76RrqNssbTgEm+jS19vVrF2fEN+EYR4HOn7UUsBmpgrQj8H5M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1494;7:eARQZqNWdapJ68/2fE/tDihQ7U5FxXy1lnxCgX9zNmJIKNX4UAmdtmY94r6JisuPNpEWqi9gD/JE6FXEv9sh7JOgvwlCbzZ/QVI6E4UJHM4rMdyfkDLcLgBIdOrFUNERJpadHXngISnq9B5ayFxHgWiqNFQG+XekT2bQEuaUBVCVwNnTYtCeWWL6H5OdBS4OM6TJQbsmpQXkvstweDoL8MYUF00qh2qi7Uw9rRIte4DYHrTUUvchpzKSix0/Xg0L
X-MS-Office365-Filtering-Correlation-Id: dadce305-6924-4f99-20b5-08d5cb82482c
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 07:51:15.0144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dadce305-6924-4f99-20b5-08d5cb82482c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1494
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add arm pl353 static memory controller driver and nand driver
for xilinx zynq soc. The arm pl353 smc supports two interfaces i.e nand and nor/sram
memory interfaces. The current implementation supports only a single SMC
instance and nand specific configuration.

xilinx zynq TRM link:
http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf

ARM pl353 smc TRM link:
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_pl350_series_r2p1_trm.pdf

Tested Micron MT29F2G08ABAEAWP (On-die capable) and AMD/Spansion S34ML01G1.
This latest series make use of ->exec_op() . Referenced the marvel driver
as pointed by Miquel.

Naga Sureshkumar Relli (4):
  Devicetree: Add pl353 smc controller devicetree binding information
  memory: pl353: Add driver for arm pl353 static memory controller
  Documentation: nand: pl353: Add documentation for controller and
    driver
  mtd: rawnand: pl353: Add basic driver for arm pl353 smc nand interface

 .../bindings/memory-controllers/pl353-smc.txt      |   53 +
 Documentation/mtd/nand/pl353-nand.txt              |   99 ++
 drivers/memory/Kconfig                             |    8 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/pl353-smc.c                         |  523 +++++++++
 drivers/mtd/nand/raw/Kconfig                       |    7 +
 drivers/mtd/nand/raw/Makefile                      |    3 +
 drivers/mtd/nand/raw/pl353_nand.c                  | 1236 ++++++++++++++++++++
 include/linux/platform_data/pl353-smc.h            |   29 +
 9 files changed, 1959 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
 create mode 100644 Documentation/mtd/nand/pl353-nand.txt
 create mode 100644 drivers/memory/pl353-smc.c
 create mode 100644 drivers/mtd/nand/raw/pl353_nand.c
 create mode 100644 include/linux/platform_data/pl353-smc.h

-- 
2.7.4
