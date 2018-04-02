Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbeDBKji (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:39:38 -0400
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com ([104.47.32.47]:62928
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754272AbeDBKj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:39:27 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <radheys@xilinx.com>, <lars@metafoo.de>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC 0/6] Xilinx DMA enhancements and optimization
Date: Mon, 2 Apr 2018 16:09:00 +0530
Message-ID: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
X-Mailer: git-send-email 2.4.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(346002)(396003)(2980300002)(438002)(199004)(189003)(186003)(305945005)(106466001)(26005)(48376002)(5660300001)(110136005)(106002)(54906003)(478600001)(336012)(551934003)(50466002)(356003)(103686004)(2906002)(4326008)(6666003)(81156014)(90966002)(6266002)(42186006)(36386004)(50226002)(8676002)(52956003)(47776003)(81166006)(8936002)(316002)(426003)(126002)(2616005)(476003)(36756003)(16586007)(486005)(486005)(2201001)(63266004)(51416003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2260;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT015;1:vZUUp2J3jCVk9ryg0WdFWZOeQKJUpFg7HbJa6MxtSFnk7TuQIlc9GmcKB76i03hzLfhU8gGA2qnR4FiKbz/XdmachTXy2RcyECISDbmleJvG369zt7q4qFkRuLIP7ujT
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3f274ff-737e-4dd5-2cf9-08d5988600e5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR02MB2260;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2260;3:bltI02VrKejMzmEjh0I6p5wDe36reML1OHBl9WGGdQ/+Uh2wzTDtA5b0ggKmXycF0tgHYoDd8eFmP3ehHHf3HjVbXhMH1HwkQEYUu8NqEHKqNCz6vOCcVifAmhIDijekBZ5RAiW5UMbGQBwXOfTyTwey+81KiY/CbrbKMweEQ7DKK4uxnvEaGVWK7Vxjf4YDNyYAnRKCbHZ/nlkIrTZSO7mocKYOCFZBmkRocTe0HVNYZ4ZX1gX9hl4vIi/41JmqdPmQaQPJnyQaLm9oDyx6C1DKANKBNxFFq8WkaEPE+0YRuGUB2YTOtG+oClJc5e9ZDUSVNZ6bWYBeB30cOouVr0/jQQcZX4QO7+7CXyiAqsQ=;25:8SijlRkMeYsmNn2ISFJKNUpDx8ULLn2AL+O9fsQfw97STff1iCDU+o6/mWb9BIVvw1tpDUnjFhCgWaruzym0kFVruJakOLik83GzoxcRGAEbCbS73QNIbm47nk+Xfvr5DgaG5jg0/fJPmegFFRjRXi8FjOh0WyqxgJ5iFQfugIMzv8d5SpjZ6PlgY4ESyudhkhnLET8o96hjnh6eGo5U8HcN0xFhO9EdqSv3nwAIBKOGgDmNJT5jor4KpqBe7l5/Yj2bD6E3s5Xq9kEaRHPvMpo4IZpwqlSfHMYk5wZkkYMXTkJQ44qOrMj8oSQ/dwQIjjZUG4+RsllAE11jtoXU9g==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2260:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2260;31:QrWDRr5Pr/JfybIz0Zmg2y3MMdRVmcPeawPPZRklQ2cL0OyOzz1ramxAIY6yFi5E8lFaYdLsU7GA03/LeK65YRQG8q2JQTR32xSuRuIJQoHKrOVaEznM55I7btJM4yjmHT/fwYGv837w/aRnne9h0zSs34UQSVG6lbmDU5oIpKXAmBJFxF1/VnBfD3lamPTe7uGicC+w09wmBUPLcXqgQpBmCqX+0NpdcXnvjSvMNn8=;20:LCXvnxvbFrDrELW2/pxiIHgaJPo0Upd4Tkge+aSIjmXDJM01UrTyYFn29+WO5/u6uIQ7BRQYjlnWx1vQAkF5arHW4aDettSGC5hpWNinvg2thiLQeU/+gNuL/tKu20dR5sMTJUTfCADj/8eeML1RH2QZfX59dFLorqSQaIhhAT6E2CIUqcqQHvQYfuaNvZjgTX4ne/5urs9xt+cuWMFgLX/kuNbgi+7kOEfTedCRLVcV1713/VReU0TPCz4fgsq3Nyn4TZUxBJNHsmcQKY6+rrEB9TgXL7NUDjdkp4PUcu1Nbkk+qBCppdz7R/eHKq3rtzGWYdZDMQS8p52Qxy3+qe97yPpjuSLGHD8wc+PigYlKie7XTi9ymXkLs7UGH73D6rW5X5m8PlkdJqtp1O+OfipVf+5kuv/RXmktdTvX2GOmZDc36ngrb4vdGzLlNJ6h6rKBz1ZN9/tRbAMJul0oc9rL0OK1PutPIchWA6C/KRiGq/+nEX0rGjNgJdX1MyL1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB226060389F238277DB0EFDECC7A60@BN6PR02MB2260.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR02MB2260;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2260;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2260;4:kWuP0eM48sVfg3Yr2xkmQHe+M6Q248iEkCj0EfgTYDbe8nXA4n07ae1IrDGK/gYba0jY/GJktK33TbfnX5h6JVIzYJZKVtYXi2vw3tVYQ60W3ndv3FC0Sv/MYD/18RthNg3SgGYNWdxiM4Pr/Pn1MbluCJVhON7onJ5dPZ6buxNBJv/TEj5kMVoDB6UuIafrc9AywXksEVbFU7+r9TjJIy4Os/s7/Q9YlkMalYel2zEaGfxdzDhPbrjkog4WrTXkgf3rgvLJTavff4UUiZ+V9NqzpmbAfeHq0XG9R5yC/7bW+J3j7nZNh0YZG9qFHxZp
X-Forefront-PRVS: 0630013541
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2260;23:GnK6wLUQPg6BSgRy1jyoz4OwqJPCO1KDFkMf1E6PH?=
 =?us-ascii?Q?f5k8Q5hK6PCLm1tZHNwFiByxpeEsdoxNZ6yMiXZIXu4vcaWFEzv4MNbfq6fJ?=
 =?us-ascii?Q?WumcAYqpDhxtqaC0eRNx1O+3L8DBZG020lxWizAVXdRyt3C4DghzHsqH6oN6?=
 =?us-ascii?Q?kcw3ShRkju1TFD8s+rcuVAS4g3V0TX1dKm6iS/uQaRaxGKQkNYqJXHxzN+a6?=
 =?us-ascii?Q?mfTeTjslxqhguPh22UVcxZxUSd4dfU0Ot6ZMvES+CjuIk7t8iJDEEFyd7iiy?=
 =?us-ascii?Q?oJcobY4o9dEs78E9Xgj6/DgLEc/1d4AcJgCmD8H/fNAa9ieQ8Y7ytRAwDP4k?=
 =?us-ascii?Q?zyaiKd3WOIHXZ0QvjRmu9Lem7dWkbVE9s9SQC6F8nxlMXIpkj0hBgEUHlhbr?=
 =?us-ascii?Q?iHSNf+5FcK1BzvA82i9E43yl4JiDcDObA50hAO+ymf4Tpu4e0hmcaCRzCcce?=
 =?us-ascii?Q?w/DjNLuUEVpfTfOSeL2r9mKP5DkheE2WIZOcDOxrbwiE5KDLR1FWjDY+uJaE?=
 =?us-ascii?Q?X8l0ldiLPvfsVkOVpUjrCH2EiF5RpXTi6M0J7vULf6OiTBAiDSE0OnKHqtGC?=
 =?us-ascii?Q?fcVfQNzymZHClVMX5lPfOradAmuHHWJD/F8KuRAOcEZPxMhdMiy3FrhqPp//?=
 =?us-ascii?Q?pQMNORQnuYWfjjPSvf43PKOlKMnfozyDvrWoVr/AzQ9WgZq1Fds4L9m+GtGA?=
 =?us-ascii?Q?RImqF5c+zhhQiQknsI87wrU3wAGFpRzA5jmCdRUk1AtEjCuuVEydCxli8k//?=
 =?us-ascii?Q?RPPu+wd1Nt+LktpQxErWt0BHY1cy1+YhQOWHVPYK90wdcQVxokfYwI2UlIjy?=
 =?us-ascii?Q?NFJQjKEJtL7hcwxA+FDNnW+3qJLho9zV0xHWMrIcgDwDGIeguOuNfBoVxzxM?=
 =?us-ascii?Q?BP1f3ThbmrsZlqYkzz2HVX/O3UVtxJVPf/0s/b4/5uCFoaS6U/AvOZVRuZOS?=
 =?us-ascii?Q?3qnTduYaUJgxCyaL/oqy7gbOfd5YAtVXnnwVzy9i0OnaIOuyYZjVoJTOVtEa?=
 =?us-ascii?Q?31g3QN6HBwxmttdkWpe9prgAJc7agh7UBgOcv9KPpxd0IuUpSSntOA3qBEtC?=
 =?us-ascii?Q?hbH4m5zL1BZQ7sIQuyK7aCD+m02sCZvMdkUzu9GEBof0jdYJyfBF2N5nJgNK?=
 =?us-ascii?Q?k3xu/Mw3l9qigXgndaE+AwR/ZQhyfg7LrEx98VNTEC4P78+Grf4/ca3s3KRr?=
 =?us-ascii?Q?GIjLwiwaNMitXQ=3D?=
X-Microsoft-Antispam-Message-Info: CxWSE3WsoiM5C8GjyxQcXQPA/nQKS85x8+K40lxbbvCJwzaZIAZwpAIx+lJ5nNQ/tK4CN4Rfde1Diy+P2Vbs4wrvZjmHrz+CiufomgXmg6wtbz3F1KG3R9r5Gwg+ERvafRhzcgTsk5tRCwI5hcHLQMRKgxo/Ox8HNOgK+EBv2J3jQxfAjuVcg6PJkQAlT+7o
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2260;6:HZAtwckcykujO3s6qEBRFQvVjflans3HcxZnf5h8JncNfZxCZCvfhS/hKBBTM+je5anmuWj9bPKUHUhfjYAzuiJ7qLck1ILKUDUdC3Tyd1iOtNcU1fQt1WPnaUxfftJDWMjTQ6RSm8zGQP6NsP5s1xkv6NqWfS5q9/98n/MkNT9B9NRcZMnOEHUMpvVtCRszXJJyT/PqNk4Ib1GQZDnXQebD/MesVKIGPkDbQIaWoXndHuT6y8JxcgIYyYhqwPCX6c6R4E/Y9elT1BIKwDpbS5rVjOSClVFmCRFz/ooUQ9RKdN2bSMvOWLGvbESPTn6SPotWF6GFDx/OnYlwhdVYRGny/B1lrUXMmmvDNwWILdQJPx66NNnnza/NNCS+yVSmhC49iLNt1Ls3GGTwH9e92evUYGQP5MOPEC+ZcRHGoF0BT/2mYao5pvUu5/YI/1JPiCjY8HKXisT9QtkI2no3EA==;5:J/lbJCKrpQqnPLUsjCulA+7vT60FC1k2iBuEkvfnAGj6MMvzD4EZxv6Nf/NBmwCYodU6eXbwF0W1Sm9nLf4Uh8fHVDZMEkrgiIDtcOW9DkiNqPPofJD38WvOdXjjXrtWUeGdqu5CDIVNBCVVgS1LqRQlVZNCiC5VcPJ8VeQ2mEA=;24:DAlaV8QHyJordBWOHsCd8jMd8cMMPUtqrp3UAMLutKG87ABN6rgixYUVEUZ60/fWdy511LbxQnDKjlAq2bqRqIcIa7ndFMKfp0RDciMB72c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2260;7:IPvxe2WV1H0TmXoJhFJefFecWzr+U6iNixWvP83JdYbdMlw504deZGpMaAiX4eP9dacH+h9EBHBgfbh5a6i8+VRZksUiqXLsgWLWNr/lKw91CzlgMAYRfzwOrll680+unzvZRAdeZ7evBDERrBXLbWqRMEvGVj5gSmoo2FbWjnG6pMCxJoM1KDjZZnB++qIRC7aETRWmaTlCtwEn9OGi65Od1mmoNO433e30W6+JfmMOTxDlyH+ANg8ub8hNpGem
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 10:39:24.7102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f274ff-737e-4dd5-2cf9-08d5988600e5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2260
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some background about the patch series: Xilinx Axi Ethernet device driver
(xilinx_axienet_main.c) currently has axi-dma code inside it. The goal
is to refactor axiethernet driver and use existing AXI DMA driver using 
DMAEngine API.

This patchset does feature addition and optimization to support
integration with axiethernet network driver. Once this patchset
is reviewed I will send separate patchset for axiethernet driver.

Radhey Shyam Pandey (6):
  dt-bindings: dma: xilinx_dma: Add optional property
    has_axieth_connected
  dmaengine: xilinx_dma: Pass AXI4-Stream control words to netdev dma
    client
  dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
  dmaengine: xilinx_dma: Freeup active list based on descriptor
    completion bit
  dmaengine: xilinx_dma: Program interrupt delay timeout
  dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical
    usecase

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    1 +
 drivers/dma/xilinx/xilinx_dma.c                    |   73 +++++++++++++++----
 2 files changed, 58 insertions(+), 16 deletions(-)
