Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeCNKtG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:49:06 -0400
Received: from mail-bl2nam02on0071.outbound.protection.outlook.com ([104.47.38.71]:64048
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751131AbeCNKtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:49:03 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <nagasureshkumarrelli@gmail.com>
To: <boris.brezillon@bootlin.com>, <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <cyrille.pitchen@wedev4u.fr>, <miquel.raynal@bootlin.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <punnaia@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: [LINUX PATCH v8 0/2] Add arm pl353 smc nand driver for xilinx zynq soc
Date: Wed, 14 Mar 2018 16:18:00 +0530
Message-ID: <1521024480-30588-1-git-send-email-nagasureshkumarrelli@gmail.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.387-7.0-31-1
X-imss-scan-details: No--5.387-7.0-31-1;No--5.387-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131654981406434221;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(39380400002)(2980300002)(199004)(189003)(966005)(8936002)(316002)(2876002)(55446002)(356003)(86152003)(498600001)(8676002)(16586007)(110136005)(47776003)(54906003)(4326008)(6306002)(61266001)(81156014)(26005)(77096007)(73392003)(105596002)(63266004)(305945005)(81166006)(50226002)(83322999)(9786002)(106466001)(6666003)(87572001)(86362001)(336012)(50466002)(36756003)(107886003)(76482006)(48376002)(51416003)(2201001)(5660300001)(73972006)(2906002)(82202002)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2631;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT057;1:fZO+q44WOnb2LXiUoUj9S0WSrxsiAP1YxI2b22o4K6BmlJvtMKvpC1DNHJnenZwRFqLUvSbzigT6XTQGmaqjoHx0W2UBtwEKChWnvIf4IbpMN3R/wJwXpb8Fo4mmuYHv
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc2d7738-eeb7-4c4c-9a36-08d589993211
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CY4PR02MB2631;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2631;3:CtjtcvCLkePmIp1+G68+ztPhfwxuRxkUGuuDsQeTy2XpzEX858kFLKJRS3mEmux8VwMtpKGkwFtEDWc36DKP5B8VKaFmbwaEmiQgeV+jRtsSgSQ/vAMxkjKTifzoc2HY2DOb6ag2cLCKuF/aR6UqpbWIP16UVmQ5uhbdpJX7r+AHfXklubS5ac4xIFCid6R1MSEGnSrtphws8g1ANt3Qe50ZRZSnUA0n7mfFjRhKsO2JZyuGnE0dBRIn6dLtFH1/+3Ydgu66KsSM5fEPM4PKvSQxmYyQ/DaA26JBHljqkW6zJ2L/UAbtxjxcb2LTpUB/88Xl8ZCQxyiwk0Vp0vqXtr3wZdA0P/mK6aDWXZDnMr4=;25:jWnU/BUiuE5SPP6h7KM6ql9a/Omkx6vSHW+Xef5eLYxeeP4hYRg3eJhP1lQ/uHhT2Wa1KDVj3wD5u0o84qbGDlOV3mFgmufEIO/ljYoRUw6eUFshTKU3vj9B+Nk04NCtPuE9v5Q5S4E5/liKLFKVcTnf7TFmpEkq7wgAmVL5MamVywUg8ryA8/yHO08tbzwbEw17Dc9WjhuUrBZFBbpjrCHjmC4U55YPZxTd40NMilqKxK2SUNXnUBxovc0TKBGJQb7hU/wXEycaKp8yO2KipFr00XSGnzbDOJWLmnHqdRzTnCYdwi3Fu2RaMu6m9YVHD/HomjRIO74Fnv30lv1awQ==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2631:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2631;31:4kkb8Et3KY5XWD3iahgHGFnkKgLQZoFbqyWSoXKOUpV1mB/REW4Yq4COXBUtzJNpnJDk+Ol/a58vGhbyMPilU0P14xzpYOSjHNomiSqpHiPaKN0nx8ZUGYXOcApkSpq2FsduRLjjLEUeuciW+XHkRWGm9ADWtxK5F1SCmDT7ePzsgu3gcpeBH6I6WSbDpsn/Ss3Qo5EVqWHk+T0vP391hfYKgYiBFOSVodSpmrEU31Y=;4:tlfpOMy1O8TYil1wYRpUd4xMxoJ04rqsAy2Jjo4B5MimfOlYk/9d4kRXfxz0J550Au1ZB+Pn32a8MucGCN4Pwgg6aDJP/fQ8wutvDgRYpB4+TG6pcJN1mcTEIwU+dlfZu+rh8Z1f2TD64sSu7Yugc7MKJlYHpyvlu9n/8zDhKCggF6bmTDa7Por6DZCeaG8JKG62YxeN0gQr4P8sn5UXkT9QQdycuQ++A05CcoM5hs2gGwYcv53iAfAUbzsTgz4SUu5WPL3fP1cpGe6M+YySmsDpOFf4kbx6aEZyyupwrLs1t3vNNh75s2ZtzCmvDoXLQbOpoWYmgcTODfgf4bIN/J7E64yeYQVmXBe7gfpbPyUwxJvaOc+9cfO+4x0wIjvH
X-Microsoft-Antispam-PRVS: <CY4PR02MB26314E819BC3E375E74E16C9C6D10@CY4PR02MB2631.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(192813158149592)(189271028609987);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(6096035)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123563025)(20161123556025)(20161123561025)(20161123565025)(201708071742011);SRVR:CY4PR02MB2631;BCL:0;PCL:0;RULEID:(400006);SRVR:CY4PR02MB2631;
X-Forefront-PRVS: 0611A21987
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2631;23:zMNIlDykOU0a3F2mLpP9V55RcQMxx+L9YhBf5HTjV?=
 =?us-ascii?Q?/FReQfB57Cw5XOVGV32CEdBcPhTnvy//2FQ67rnXPqzAlfTOnDyl+RjurC1J?=
 =?us-ascii?Q?iX7xBdiszriNC5Qky6lPjWJxTj/3BJWXgnafYM3pk9ydJ98I4gQSe78Mu9Rd?=
 =?us-ascii?Q?IMtBe2ZADvUtgc8bGbCLoLFsJmLDdXlMpCnTTyfncfKa0XkYpgsgutYfRxs9?=
 =?us-ascii?Q?68EUud3mQbRr2yDqRQwywNFteTfz8m5Ful073dnnRSrKg9GsL7iYn9GXRhCi?=
 =?us-ascii?Q?snqm0BA1yhPhhTtqUKu2zSvmit4rEpySo+1si0MhCQ8YzXj344UFpKki7D7w?=
 =?us-ascii?Q?dREvHEQjTRc+UolJUlJW9ERvPNca7/3adNeo8OL6iAtq8funeT8Qf564CBWs?=
 =?us-ascii?Q?Xr4yxyMbJt1c0zjpbDOL57aj75tgTbk5vHBMsYkBn91f7mzFdYhs6BAhEqY1?=
 =?us-ascii?Q?xd10BYE5fH4hcyZmXGcCzacPB30SCJZ5rol18zTXOtcdWs1/ri+LDxrl3gE8?=
 =?us-ascii?Q?jlQCXo9VOXH1bIGCY/z13yUM3909xyhzRsW+LKbx5bMmhtt2DeS55aD2FeIr?=
 =?us-ascii?Q?dGFnp0AjMl0SK3lQucXBwPr3mUG+J3bcvoUoIFMJkw2/KAymI1YfQd2yTsd7?=
 =?us-ascii?Q?8f70PQ85i5ODbMZJq/MNGeUoiQQkKTkpBJGxstp46vu0oh/pjHzutM2WM1XN?=
 =?us-ascii?Q?7EbwZRR9eVakE1GKO/099Vu7HWrT7bFyNsDbJmjoXOMjB0uZPEkua0V1JFFF?=
 =?us-ascii?Q?IOvb9X80PfGih2Dn/KZ1riCBHjd4e+vN17harGz7sTSCJ5tqTwentQGvX0Dx?=
 =?us-ascii?Q?K3oKlq/S9hNi4s/GS8ZyTFRGJ15dFVmkzTYWP8dcM2MK9sfOcahQ0c7txpq7?=
 =?us-ascii?Q?BVx/i5Ch5VMYXZr/dphSl7/LKfa/qUb4DW6iv8c124xtokLKSRpW8f3MNUzt?=
 =?us-ascii?Q?3UPAFbI5vdtLoDs2lIUf+XT/Sn0Uti3fr5UUnKaXdEvg+IKo0+uHt3JqspEx?=
 =?us-ascii?Q?dmC5h8m9QBgPCa3GiQ8Yt9OW3HK57IUhNQX5bEMASUiLivkpa7+SgdSZfFlb?=
 =?us-ascii?Q?kg5t8k+pWjuwrMlJjKGDHLlUyf1vpMAHnqJ3GLnjLPFf9DkA2Gv4kW5V3GJp?=
 =?us-ascii?Q?k2MAKWDb7VA8Do6UK7IMQYwT7oFsdIGWO2wifPf9C2BlhDORpbzYNSQuxK/T?=
 =?us-ascii?Q?o9eCHcNYnHxfvgSCzHo0+LFRnMk5ff1WuvYzhhTGs8M/JkGi8hCdpiGgg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: COgn/2dED9gwQlr0ZJXa0Vu1xSIA0gImLfhAJc4Iyct2kQ8aFiL2kDOPdFkN6pM+Qtnap3I8JEhRyv4phY8F13PlmZgMTcgym95bF8a5Kjzy5EzFK3cBhoKYlVBQjeJwk7pCH30TG+pIG3ovdoPGuhWRknPOWmXO18/z2NUrtwJr0Z7+nHLtUVUhbg2M3NL9
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2631;6:wyKV9xEnyBS7aPgaxq7ZEHm30sYTm3sxPe7a/eNPqUHYaVNWSR3k1JDOyO+qPSrgFQSDwOlW9qYUdcd9cfP1qYe+thYv5xjDjYGzbFJvs2XKqoRVIuu7KUaFv+UNf19HR4vhXlafKPECIYrb2f2r4Ka/Lwa2P5axKmR6rReK1LDtW3MEQ1Jo4WMITVoLV+VFzl/h/IfpnKKpB6iqqKA6xUxs14SSlBnfHalhZSL/UI1bresH4jQDI3Zqc3X/okKTfi+7wOyqBwM3YIawU2M/PSLI9WY94Tfn6SHr7mCCBEqBttQz+LEhep/ZG0x0qQPvq2B18qD/ePG/qTybIKwMHixv6PnLqUkljv7JxTGid8Q=;5:dx8+px45dlWqBXOS9kDuo5BCzo09dmHEEGDmt+8dJ4m5SYDxorwRjLWS8c7hELFUhOSd+Zkr/ftelXeeq/atMYdNZy6uxIUkfW1xRINppfsv7xE4aZ00TKc54oZVVLKSfYjFI7FJY3wtctj5OF1Xbyqk50iOQqfOwMj2ac0HBO4=;24:qD7+q3PGm1N3wNju3F66q+KJHeWHMgFYxIbfWNAdvQRZe74RpF1Z58OcrLLO8XkEgqV8B/r9ccFzLGQSuf+9UUUI3cIHCdrYjFZgZLGn2Vo=;7:Lz/iJ8keP+nGPmhD35RFY/1jxCHaS7k+P6/1q+RIi+yoLMve6fBR5xN98CD6+h9DXM2EpFX17kIuihd11bNDYQCmvziTGzyzjSz9VjP3oi8nHZThKr5PTpasOabR+WdYm5yhkfCtkdRxR8N5RDcp8xQie/C70VceE2oJac6dSR5j+nucBpCi1xoZ3EidFcHDxFc8kIogFErzXggtrUyD68CdOx9osjrj3a0F03toRZ2jybUu+Ra1IreUn2USOTv9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 10:49:00.1277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2d7738-eeb7-4c4c-9a36-08d589993211
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2631
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naga Sureshkumar Relli <nagasure@xilinx.com>

This latest series make use of ->exec_op() . Referenced the marvel driver as
pointed by Miquel. Sorry for the long delay to send v8.

The following patches add arm pl353 static memory controller driver for
xilinx zynq soc. The arm pl353 smc supports two interfaces i.e nand and
nor/sram memory interfaces. The current implementation supports only a
single SMC instance and nand specific configuration.

xilinx zynq TRM link:
http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf

ARM pl353 smc TRM link:
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/
DDI0380G_smc_pl350_series_r2p1_trm.pdf

Tested Micron MT29F2G08ABAEAWP (On-die capable) and AMD/Spansion S34ML01G1.
The v7 patch series can be found here (https://lkml.org/lkml/2015/6/8/499)

Naga Sureshkumar Relli (2):
  Documentation: nand: pl353: Add documentation for controller and
    driver
  mtd: rawnand: pl353: Add basic driver for arm pl353 smc nand interface

 Documentation/mtd/nand/pl353-nand.txt |   92 +++
 drivers/mtd/nand/raw/Kconfig          |    8 +
 drivers/mtd/nand/raw/Makefile         |    1 +
 drivers/mtd/nand/raw/pl353_nand.c     | 1363 +++++++++++++++++++++++++++++++++
 4 files changed, 1464 insertions(+)
 create mode 100644 Documentation/mtd/nand/pl353-nand.txt
 create mode 100644 drivers/mtd/nand/raw/pl353_nand.c

-- 
2.7.4
