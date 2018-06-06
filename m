Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HXiwTPAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76024605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932502AbeFFHwk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:52:40 -0400
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:1376
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932401AbeFFHv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:51:29 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
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
Subject: [LINUX PATCH v9 3/4] Documentation: nand: pl353: Add documentation for controller and driver
Date: Wed, 6 Jun 2018 13:19:41 +0530
Message-ID: <1528271382-21690-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39840400004)(346002)(396003)(2980300002)(438002)(189003)(199004)(7416002)(2616005)(36386004)(39060400002)(110136005)(76176011)(107886003)(2906002)(106002)(316002)(59450400001)(478600001)(54906003)(51416003)(7696005)(16586007)(77096007)(186003)(426003)(4326008)(47776003)(446003)(11346002)(126002)(486006)(476003)(9786002)(336012)(63266004)(106466001)(6306002)(8936002)(50466002)(81156014)(26005)(48376002)(356003)(305945005)(36756003)(5660300001)(6666003)(2201001)(50226002)(81166006)(8676002)(107986001)(921003)(217873001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1454;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT009;1:PuI+YRwnRX/MkXAlA4xEP1dAoz4F5Nulu4j54QOF0foRSib57k4QfO8auZCUY1Zbv1EwPZkgW/ONKJGfttZjNP9s4iLtdryspHsKq8mkTuzIEgoDLn1RRBj3QR+IiARx
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR0201MB1454;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1454;3:pzdipyp4PASSe3jee1jkzqng3IxAR0A39S+NxkQRi/9TLMoYQhZyGCPO+Y9fcsKBO9/+xLmWGYhtl8MDYQJ2z+o8na4+aLl6PWXM+lNs8l3O+XdTn1mYsYt2u8VIE0RnI/f2di8pRN6yudFeUNcXeF7odLhbG2WFhmh1ZgyYLfpruYrjtbTWOrQiOViXm29ehGsJmeNaJDbMArDYVilD6b8cqM3cnw6Uwjrs2PiPcPhNMsKUtMCdhjgde8GHbIe0fP2w+wwww27h+tWnrGsDZGafhMnHv2JxYvoY6DTCnTY7+mtR9Ll8Mzupb7fBMWnAyojizf/M1sNnTX0559cDVjWnzUxtnjFfrsyNiElRabc=;25:g2tCmYwXRPSC+R3TozO5oP2OR1VfeWJ9/6tl0XQNS+HcQTqhfhpHONh8noagg9tYa+j2R/CuMTDp+/kaAJ4goxF+YlLg9n5YU3W1XqJ4aUYRIo84RqheXswtSwonRN7sjKpiEroi+M93e6STs9yAmh90fIqgII6Jk3bnSdd6ogpMcxGMl4G+udHOv4XQLKqGtuIGk94qlSzbcLhgtTQME9C38CDOIYa4Xn4V9NTtSiU5Drh5vVzAXaSyZpV4pfx89J7zdvmz0+p+lmDRhWeZQoj++ns2/+J40b3Na/is6O1psJgE8uh2hFYWeL02UMARaoJex/YPvOZuUymqyjKQWg==
X-MS-TrafficTypeDiagnostic: SN1PR0201MB1454:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1454;31:A4rcXXBEHwAT40p0U4F+UOyKBzv/DKgauEVc6dO/NrGPpa+GRoPRDB/QBCcbyFwczWdLI5MCzkQRAkejD7BRNRDxTyIV8ps/OFse82Kfm+bRYlcmpdCaHEww7/LLiHjO8oICnhheulgJpFgvuXZUBiSA1QC8YsizbIPX/iChjtW2wZbui/a8NR1kN6+Dx6JzcbufpoexRSkjd8BiHhpao4+43m+mHASQDYKmkYvtx8k=;20:1og+eQJ4tWBRdYnNM6BfFZdHVwImfuxuJAVw5vyDx0VJYobo0AY9CQGXYdcn6Z6Za4bhl77IpJKqNB/XQ2aqdgigTTcn05XaBhLh/mWLEx/vrxf5z1S9wQ0Od27oGwJP0sEJDpc2jETQVLoh06MTylR1ML616RsLDheJXJeDp2lcMhY+B40jjmflFwJ6kZxgEcqv/+rh4VVOyshvu//zCFUjHHMwfFACwhOGvMRCTiuTD0NtJjvy/ahqy0yYzIi8A25vCgoPw5CkSXvxO4UGUvEq3G3RZLrVZDbB6XGOpvx2WZQsjKGcvJUThMFdxdgjiaa371FhPB9Eis520CjVl9hnIoSeC4654dbHnON8jHEKlkC/HmeBBANS1iLU0ozdjU1BPLgUQ012Ghz1SulujgiUMStFBdshiedA9g8/UlZ1x8eUCsmvTLoNC8plImHCJIDyltVKf1AWpg2jWtfUj7O/wPUEvkcfdxhZT3ff2gk5jfgdtX9lpjbOWTeoMLAX
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR0201MB1454819AF53683275A3A8D84AF650@SN1PR0201MB1454.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR0201MB1454;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1454;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1454;4:deXbzxmMHSHTbWDKPsO8oRZEqEUL1QSk2L7ONRFViYQMJuEQ1Tf3mNqCMMndOcfppd9jcr91iKALdO6exHEVoPeN5bgxh4Rna9L/bChPR/ytFvr0BqtpA+Ym+M84KVa2ltwkLThxdMA3sQe2/CM6SDJcTnKJGUEgeGUb6SSemgsXbiER75D183/uR97Lxdmu3Sb5RTRqGHJr6puhjkz2vPik6xc/ZlRBgwEvdpYv7BiJKRuKJ8vDg4+sNBuL3SPzLe8tUabARDoRJVVlnDMpS7U27K17FwowMR/OS+AS1+ZgS50dNnhAhBkaABX4vhWweyzqXx1/taPBvr070/HMG3LhuuV0PzRLu2UagM/A0IQ=
X-Forefront-PRVS: 06952FC175
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0201MB1454;23:9uuZq/N8GUVWd9bpaiI0GKU4f1Dfp+RtIMe0Id5?=
 =?us-ascii?Q?zUS3J64x9QxZWz/nohutw/EM1FIfzTQts+bvYvXJkHCRMToHh/gdZDohLbU0?=
 =?us-ascii?Q?lTXmm6s+olfJh7V4UkxgoZxutMLMd/wd6/VMDwqjo0ynJlryZC/9cgPcZpvQ?=
 =?us-ascii?Q?wgIx1Q/d8WdMw/qyJkOPZytxMmsBdswTEEe8RldIW9GR7MIHKsAkK3aIyCdD?=
 =?us-ascii?Q?A77gXpkXy7q+vH3Pb6h624gMFD0IVlwFsdmtPiuBnYr6w8Gix8l8U1eUxFze?=
 =?us-ascii?Q?heLACDU/qrTeJshbBBSX1EZBYNCi4+W4FSMOIIxvCHPBkcLC6L3reXZO55Ai?=
 =?us-ascii?Q?1ORkHLnNWFVkd1S1vjLVaURMkZOQVDsSVsXgsSDcR0YgaDzQjTgxGXrj/RGK?=
 =?us-ascii?Q?xTr18f/VpwzckAskwrgODYpHvQB1jJIEM6uIoLOeeLvSntmwxOwW4HlC58Ea?=
 =?us-ascii?Q?KD4UC1PBGTFbd5qBahoFEMk0q7pf0mTKsiUc+DtqyDy2k6mSXjJa7IT8ftr4?=
 =?us-ascii?Q?o8thG9Cjekq48ATjtqb8jH2XauoVnhJXR00PhE75trfhbmc3wlv0FDtsQrDM?=
 =?us-ascii?Q?h39SwBytvQc+zNDdAwe9tas/5ydcn4EoDBSsd5Mgxxn7z8B7lly9p62hiloW?=
 =?us-ascii?Q?ta5u9DwJWK8gH4Cryvhh9WsQVOk9w8aLOL00lgVi6aAsSfcFoVV+lDGmcv1Z?=
 =?us-ascii?Q?Y1Vd5tgb0ohNPHfeIy1UeCIFiWUQlshyInxWtwhFM3ZZvkr+plVLKlMHRjgd?=
 =?us-ascii?Q?5XCmHcdwnxtsdb93xOaT52Dy5D6bQ45xeGBw9d/nvqfLTiGhhFKNi+b8+yJG?=
 =?us-ascii?Q?KEtr+VBj8vvn9fRtmA2B+f+lyK/GGxf2BgdfQGyMTiZP62ObxM4CI+jSmSyv?=
 =?us-ascii?Q?ivJyVaqKqpwQTprpR7psDWJ81zl5cAfjAm5LVPdHM2SeA5Nsm/Na8cezKW0q?=
 =?us-ascii?Q?5JwecL+rkH/HgyhLrGIg+Idn8gNYNe3XTm3aci08Ww+XlocupRDHRpvMK6n5?=
 =?us-ascii?Q?ddXdzWBT/LGSugd6W17Mstb6QwKNgXKBlo8TqZduigFL7jxJ87cvoDVdt14X?=
 =?us-ascii?Q?nY9TENnZfzGvq1FKzt1w/ED65kBxtGgZy7b/X4Ty+Vki34L2bERL2Mid0ASL?=
 =?us-ascii?Q?NgSid6UFTizLv201MTA7IUQr+ZbEJSK8T0A2HftKYWVxy8XJ2+xf/el7Yck0?=
 =?us-ascii?Q?r2HFHzFpxuDLw5xILG0jEuIhDVKcZ4nk6rpQgUNSDGpX+ngCN8KvCpj2BEiO?=
 =?us-ascii?Q?vO9sphFxfU53glzoNRz1Ipqx+6Pwa+s5j/Q/nm7QtZVEcWPzqby5+El26X8w?=
 =?us-ascii?Q?ezw=3D=3D?=
X-Microsoft-Antispam-Message-Info: YoqXXeir/r2cp218l3m/SjwM2x9gUv8Afet0gYkLdEXaBhY/10st951qQfHXLd+c8PTF5lWSh1YUjloTb2G0L3T3PfuBmWckNUC4LukyPSZvlsMdW2z8iOhfgShXmxvERtNeRADWm7A4GVZys/SkPjmi1a32S+o1/VvpS/5vPDaW+DE2ACLv/L87IC5rni6G
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1454;6:TDVoNJ3wFtw2RkuaKKMd5VJ1iqGky5TUspVI1o51QLq4f/Flsz3XKVXxrSe1RRGoNUwTYXApAckLcc5iqG9z90PyUvJbEBk1txN4H2gvZX3W+mdukBfSehLCP7/WIe/JSPYpHnqpu+HWw38JT6udljs9kq5IYeNDJvH4Kwg6HNRK0C/Bby0TUSRpFDJqzkUV9Fz5K9yHt4bb+BtkOQt6006BgYr7CPaTbMK1hPIOv14Bznc0pFB9eqGI+FbzBMVwIDPiuG7Oym7nljFlM9MfSC3W0LJts/vEVy4t9z9NJUTkqYW4M1yKikc0KTCnDQycpuTYS04NXc9eAnQ7wHYDL63ySwvvhEdFEgUTIXQPxxfLczVxoXfkHMNwwe3ywa7qswp2p219Ja9FsrTTFTWgqeQFpkhFSMTsCLOj0dwt+O+I9WmXAd5Jh4JnGrkyBR8fViN5Y+s335xrSBU3ZCdbzA==;5:2p92KYJeloJUD0TkWlkR5QtXT0A09rLNP/GWwHFG0WXP+3RTWjnYqhNxE7PbhcZG242dXhdABd4aPfYUBwsKZwuggCi24rE0mpnSHxCJyTyrkU2se/tnsYXiVdniEmxqZktkxZIQV6hdZaKJWMxAmsM7GL87L/4na5xlP/wAHRc=;24:kVU7Ow72Rih99JHV9/nQc4YBLMdkgrqdOx+sc7WPLVG86HT+8VduLbsFkICZJ229NaA93xWa3AnwV2AhArld2ZY436pPkWG3Zv614tgCzIQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1454;7:iOIMl7XrG2Z/9KyRCZxavALkVmonnrqCAvUY1UEshE5JB8TCM9lW3F0yoNIsqJ6drOFuqe+fRGRa9hIJGoSXnWarhcgnkRmwtB40ckQDgVvKoTqId4oTbVbhjmC01Ny8OPVBzB26Wq+4MmTnqNnqhtI2oN01QCRCR8G74hlZUVisvRMyDeh2GPR7jUwUZTBWGz93cME5kNoeieKc9ib3ldIclxF57dyRkd600lvCbfX84TV1E4qKdNpz3roZAFaQ
X-MS-Office365-Filtering-Correlation-Id: 64900479-d2e7-4e0f-17e6-08d5cb824dfa
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 07:51:25.4715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64900479-d2e7-4e0f-17e6-08d5cb824dfa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1454
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added notes about the controller and driver

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v9:
 - Addressed the comments given by Miquel and Randy
Changes in v8
 - None
Changes in v7:
- None
Changes in v6:
- None
Changes in v5:
- Fixed the review comments
Changes in v4:
- None
---
 Documentation/mtd/nand/pl353-nand.txt | 99 +++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/mtd/nand/pl353-nand.txt

diff --git a/Documentation/mtd/nand/pl353-nand.txt b/Documentation/mtd/nand/pl353-nand.txt
new file mode 100644
index 0000000..c352c87
--- /dev/null
+++ b/Documentation/mtd/nand/pl353-nand.txt
@@ -0,0 +1,99 @@
+This document provides some notes about the ARM pl353 SMC controller used in
+Zynq SOC and confined to NAND specific details.
+
+Overview of the controller
+==========================
+	The SMC (PL353) supports two memory interfaces:
+	Interface 0 type SRAM.
+	Interface 1 type NAND.
+	This configuration supports the following configurable options:
+	   . 32-bit or 64-bit AXI data width
+	   . 8-bit, 16-bit, or 32-bit memory data width for interface 0
+	   . 8-bit, or 16-bit memory data width for interface 1
+	   . 1-4 chip selects on each interface
+	   . SLC ECC block for interface 1
+
+For more information, refer the below link for TRM
+http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_pl350_series_r2p1_trm.pdf
+
+NAND memory accesses
+====================
+	. Two phase NAND accesses
+	. NAND command phase transfers
+	. NAND data phase transfers
+
+Two phase NAND accesses
+	The SMC defines two phases of commands when transferring data to or from
+NAND flash.
+
+Command phase
+	Commands and optional address information are written to the NAND flash.
+The command and address can be associated with either a data phase operation to
+write to or read from the array, or a status/ID register transfer.
+
+Data phase
+ Data is either written to or read from the NAND flash. This data can be either
+data transferred to or from the array, or status/ID register information.
+
+NAND AXI address setup
+       AXI address      Command phase      Data phase
+	[31:24]         Chip address       Chip address
+	[23]            NoOfAddCycles_2    Reserved
+	[22]            NoOfAddCycles_1    Reserved
+	[21]            NoOfAddCycles_0    ClearCS
+	[20]            End command valid  End command valid
+	[19]            0                  1
+	[18:11]         End command        End command
+	[10:3]          Start command      [10] ECC Last
+					   [9:3] Reserved
+	[2:0]           Reserved           Reserved
+
+ECC
+===
+    It operates on a number of 512 byte blocks of NAND memory and can be
+programmed to store the ECC codes after the data in memory. For writes,
+the ECC is written to the spare area of the page. For reads, the result of
+a block ECC check are made available to the device driver.
+
+------------------------------------------------------------------------
+|               n * 512 blocks                  | extra  | ecc    |     |
+|                                               | block  | codes  |     |
+------------------------------------------------------------------------
+
+The ECC calculation uses a simple Hamming code, using 1-bit correction 2-bit
+detection. It starts when a valid read or write command with a 512 byte aligned
+address is detected on the memory interface.
+
+Driver details
+==============
+	The NAND driver has dependency with the pl353_smc memory controller
+driver for initializing the NAND timing parameters, bus width, ECC modes,
+control and status information.
+
+Since the controller expects that the chip select bit would be cleared for the
+last data transfer i.e last 4 data bytes, the existing nand page
+read/write routines for soft ECC and ECC none modes will not work. So, in order
+to make this driver work, it always updates the ECC mode as HW ECC and
+implements the page read/write functions for supporting the SW ECC.
+i.e. There is a limitation in SMC controller, that we must set ECC LAST on
+last data phase access, to tell ECC block not to expect any data further.
+Ex:  When number of ECC STEPS are 4, then till 3 we will write to flash
+using SMC with HW ECC enabled. And for the last ECC STEP, we will subtract
+4bytes from page size, and will initiate a transfer. And the remaining 4 as
+one more transfer with ECC_LAST bit set in NAND data phase register to notify
+ECC block not to expect any more data. The last block should be align with end
+of 512 byte block. Because of this limitation, we are not using core routines.
+
+HW ECC mode:
+	Up to 2K page size is supported and beyond that it returns
+-ENOTSUPPORT error. If the flash has on-die ECC controller then the
+priority is given to the on-die ECC controller. Also the current
+implementation has support for up to 64 bytes of OOB data.
+
+SW ECC mode:
+	It supports all the page sizes. But since, Zynq SOC bootrom uses
+HW ECC for the devices that have page <= 2K. so, When the kernel is not
+aware of the ECC mode, it uses HW ECC by default.
+
+For devicetree binding information please refer to the below dt binding file
+Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt.
-- 
2.7.4
