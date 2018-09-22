Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0ECC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D622086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wsHd7RwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D622086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390495AbeIUTbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:31:35 -0400
Received: from mail-by2nam01on0086.outbound.protection.outlook.com ([104.47.34.86]:12096
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389581AbeIUTbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et4DAxPGHfeNNXT7vXC/GxexWfqmEQxOdUcSIi4vP5Q=;
 b=wsHd7RwQ0PriW/wqnFKuHOKKb5oGKUSlFdn2+xfY3Jg0IqkTBkg0ioB0/BRiKm1VfYq+EUcMJfe10HzROcLdB65LGhNEF0Sr2YMQCFTlJShR8SdS5B0L9Rrp0WkALONgu59wxn0TceBdybOawzTxoD8jS++7IpJ96WrblA0Qrzk=
Received: from BN6PR02CA0097.namprd02.prod.outlook.com (2603:10b6:405:60::38)
 by DM6PR02MB4763.namprd02.prod.outlook.com (2603:10b6:5:18::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Fri, 21 Sep
 2018 13:42:35 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN6PR02CA0097.outlook.office365.com
 (2603:10b6:405:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Fri, 21 Sep 2018 13:42:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Fri, 21 Sep 2018 13:42:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:39868 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3Lha-00063K-2k; Fri, 21 Sep 2018 06:42:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3LhU-0008B4-VC; Fri, 21 Sep 2018 06:42:29 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8LDgNHG015627;
        Fri, 21 Sep 2018 06:42:23 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3LhO-0008AC-VT; Fri, 21 Sep 2018 06:42:23 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <srinivas.kandagatla@linaro.org>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <sboyd@kernel.org>,
        <nava.manne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 0/3] Add nvmem driver support for ZynqMP
Date:   Sat, 22 Sep 2018 19:11:46 +0530
Message-ID: <20180922134149.5693-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(316002)(356003)(2616005)(426003)(476003)(36756003)(126002)(486006)(106002)(1076002)(50226002)(48376002)(6666003)(336012)(305945005)(81166006)(7696005)(51416003)(50466002)(36386004)(47776003)(106466001)(110136005)(63266004)(8676002)(16586007)(2906002)(9786002)(6306002)(186003)(81156014)(478600001)(217873002)(5660300001)(77096007)(26005)(966005)(8936002)(2201001)(107986001)(921003)(5001870100001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4763;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT020;1:OZlL1nNA86bBXhf1CvbjHlNcbBSXX4mZqCs3LOAQ6dJ+EFtM5dOVt36Z4Tgk6zZcqfkTQnkutQgsLc3vP3SQlI0esXJx765B8uP8zpTGbssxm+dnb9+E3XvsJrS4wIjZ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff8cb168-1104-4443-ddb4-08d61fc81663
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4763;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;3:1Dp9hyOkvWa2nq2TjC6gL9fN4h4kYUqcMmx4Ba1ZjZiuirHzoRlM1JqnfksPLNzqTDOdpiGQHzv/08pO1hZc8sRkvzvRFMy2C9nSB/RNslimiIr8SkQWuwE02aiDRDF8UBhgsXux0FR2RE1PC1zKEOTKG8Le/wg+glbXLc+fQwk88K7PHsregnWShD2Xg1Fx5gTZBZR4NnEWj7qS3d9yq83XQAZ18vG5ZNR01XkmMQLrmmS/HiVzIZc4eZWAzP7nxbCHS/F75LDjP7KgEX9UT0tkOhCczyQLYU9de1Js5gvZNGV05yr4L3SPdYS8q3yVio6lsc+oWudLpJkHOX0iKZ4plUC/E2iIzE2JgE+LLxI=;25:iXU2BWOoC396lDPVj9fOBwUy5lZ8wyebQ71fL7OQWePoTSQIFPnVumqcUOHBqPHxyXa1qEOOndxYoUydgZHWgx7WJXGZKhSU6p3VbgIQ89uufPA6YSjuOcTT8oDw6j8GPp+OKQcZHLolWIwQ6H69pugB1AY5fPuBaoJavxBCr1MyUTvlKwRF12JibUCtE9+ea7LdyTATuyX61M7V6kMXTWcscCHY1ACD3q0bZfVcpUTqQemKC9Xl9vsrktMOxihWfEYPW1efD5wA4cDFQeFoqCZs9o6ZaNwqA6/e6Oyc5beb26+rVxTVmtBg0NpN6KXwQzRMvsB1p5J85F3x4uO3bQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4763:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;31:LGHzdwlyu0xL5zWVrXfywgCZF1IEONWu16B+j7Xep+3IIcp1cLVfF9bpk0uX1sRGlu487pSKG4jT2mIZEmsH2mwXJDkLFFmKTEBbu6q1NLOslrZqJO/9lpYwllTkRXH87clxIq25wjmhTi76bk07JgDq/Xad4EpuDEyjvqVlinU0ygOgGVBK0wR/FBzQ8jLl7//1nmBl1cHfjCEJWTYPubUF+eBLTZz8qs7c+53BJQU=;20:X2fKm94gzQDO/Jh1Kuva1SoVB3QpH31H+V9XQo4Etce9pTDKiDOVsjBRRGuOlOZTpJQ54f4bZMsin4MseCsoUhTG8h2d8hccJ0rSBLTXLnVPSLjth8nojd3Xo0GiXbdXzj03v+BcBWPbouDyn8dIHe5CREqUApen86rDPTzYKfuVuOgShLusOkaSlSJQacIApp6OR7s7FpyCAzrAtFNOAgNKNajdMSbQTE4dkoW/pM8pTpqT/cg1vzPXcwwbAmD+D3h5r904MfvGmWS56K4MuiZRp5NheA7eYZcE3DuHw5y2aFkvCYYTNWdKuerFddGzVtRuYRBq53i1esTXpiv7M79jHoB0DAqhyaplNGk53gRlPZsqXhcHaRtH/oj0GE3uGJpyXkyJyS4KqL8ka7CDHNOhoW8vOd6pvjSO6H4VhXfo4lfRtHG/aaN+PzJkOuUUDuIUiZWwVEcrg5pqxb575+0ysvH1MlGy4k8GrRvFwfLoNx+w6IGbAAL7thBbnBV6
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB47631E1C85F832195E32E039C2120@DM6PR02MB4763.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DM6PR02MB4763;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4763;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;4:WP3Gj6Zol1XtgsgC5IthhL0uRbvommzIkjhFzW0VBF1Xq+ApRKMKx1buyXDNqIS+6DNxvmCEg0QlC5P1SIqGU09w2LHK/6nwJHeA5sr1YlBaAUtYsD5ST7AHRzWmhkBou+W5NfBYwL4Vehjln15Dkh2B8dSwDkaHtUkoQNG0EY8YegYBlJBfRe0nwIYPrPZH1stZ0iOUh/RKgLf90YWS09a4bLwDff9ultmFQPKBeLNaXbM/ooqPuhGfJdBO/gk+ITMWPhk7eYrRpWV8yG+BmQ==
X-Forefront-PRVS: 0802ADD973
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4763;23:Agv7LhYPXeuH+dHJ31RSeUdhmPBZR8ediUSog9UJ7?=
 =?us-ascii?Q?H+Figy7tvITkZ9FgUS6g65SZAjeO2f+5x/6pl6uORYPBufyZgXkY+KWVYLx/?=
 =?us-ascii?Q?MX1oPrT4yEBuzhm9/YL3hk0EJInjc4W4W5kzxz0RbYmPdo2FmhwPO6EQDYUd?=
 =?us-ascii?Q?I7rFssNBXiQJAPKHqMChCjmyMJfSpCFXXK2O3itY/TMLoI9b28h6cEY1MR3D?=
 =?us-ascii?Q?ug3qumEpGZJtCfKZ7CYf53BezUZqhJ+DFaX4O1ot0HgEk6CN2UixIfAake4j?=
 =?us-ascii?Q?H4psOq+0ii/lrWmEEt/yjVxNMLkDCXqhBFtGZNUAzz20KODmoPZLmO9LF6rN?=
 =?us-ascii?Q?g+chcz/kD2QKVTvOgYGC0s2dwy0ylLPbLuUJd4FepSW7Pd/jh0P1Zcre92/w?=
 =?us-ascii?Q?oLoBnCbyvgFaYH5Ejl6izttiHWw5VMRiu2zPnVvfGkvo+QozKsck6VwErLdR?=
 =?us-ascii?Q?gEtYmYkzna8YZbZ76rX0VEwCwvT/vtXArYKae6lWTpKhFKlJgf5Zqy/aKVy9?=
 =?us-ascii?Q?J2aIsqWvhfPNq7lgZQepMS0K1gPF4gU5xUSkP3VVDLaIHwz6agO2WYp9KkKQ?=
 =?us-ascii?Q?C7k6kl9xuRcLWnprWYevEQbYs7i1BKBKLCO8xr6ssY4/+xlJoW54t9HJkEOT?=
 =?us-ascii?Q?J9mdQE/iur219ZelQo6BIdd+R9l8+08vu7fQN+YPRUfBZobY8NMYlBxWNFua?=
 =?us-ascii?Q?jHHE9rhpFlQ8Bb1Y6XZxctkCPWc3gNHjqJJCn4884lM0CIzanoEHch7Rp+Q/?=
 =?us-ascii?Q?YEQIWEv5i+AM27C1xP6RTDj5Uuuespb6PctVqCgu3tIelQnDRR45K7nDAVao?=
 =?us-ascii?Q?nK158MP0cYvF1pFos6z7obpZdraTMiOeq3YbJPCsLaVXYoNnYlT+mAiQhrdj?=
 =?us-ascii?Q?iQVjt7fS7DJoHCSXoN3YPfffAb08OdP5jiBxzmhig/aNS6UxOgEidTMi1Gny?=
 =?us-ascii?Q?+wHkay+Rsenfqq8sjxb4y3XvEdfKo4ltCTxuHoylmyTndtFEiUQ2qXLpWco4?=
 =?us-ascii?Q?lJR+k0+eDoEX2A8Kmge1Hcc/zlTdWHHPLAPTjj7uG5IcIONQFFxpRnlZOVhm?=
 =?us-ascii?Q?Zz8vnMhtGsZYv70DAEjckNcc9TcmjnEgpBY+Qj7dkEHM49ilT/q7AVjzM/yE?=
 =?us-ascii?Q?VQNMiEDjqtEMzFIt22N21gvOnkqBMSaL4Gmw0+JgW87X4A4Ld07RdpaS2qmg?=
 =?us-ascii?Q?5ExzVivxXJrpZQ=3D?=
X-Microsoft-Antispam-Message-Info: PlImypnpoOEzkX392JBVtg+RUJ3aeB6c1N95S/BWXXvvLwu5cNiRe9EbEG7S3Ze0xI6eS5rHEwUil6I+cemi+zWDTohTFKg4lgr7SGgNNrQufZNfYgSMrVriGEujHbpZ2LYK7ZaGiBGdKnzc/KYhkGmHB62WaL1ejO8uKtNF1gvgTVWOzHoC2NN7ZioQfvPKUBCl5QOE4q8fLMLmO+CMJP5ERsdzVjMrKs8IWRqaH9NjmqNYbA91XaWsvjOxhQNPy6Dm1Nf5VfsUXgXn/g1YgbrlS61aAhEAFwQy8OCfcALTM8UM5oNspownplJkdak/WhWeOovLirstypYwF9HKk22ocFsWgbO9+tDOIP7JeCQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;6:TqEu726o4vI/QZCX7afM7f2lEb3Y3oacDE80NTs8zYXyAPmbOvlkiwmS7/Y4bfY1aLgUoAaCkKcks/aToBzJ9GOnda/S/OoZRpVgPl6xrYJGR1tLmOR52cZrx8r7LsDhVtV4sW7GEO5LYoQpmXgTajb7mYLgJ2vhH7e+lF2j1MzOZ0e0zIvpZi+ZfANHnh7rZtexzEoIjp4A/AWVzqp9HyinDZorx98X1Hg+HiwNPoKSNjBj5kr8d+TZgMBuFjsjeJEHE77QAIhc21vR//c89as5Sh30otLC0hAwG5D0xo+BU3K5lZC7qcdrNZ/qfmIPsUssoXK6SHfv9ofjcfYFq1EMnw16yb51X/cE9Mv4AGCR/J2my/9WrgDxtZpBpmAMTetHZeRnxYPHGFEnxDYRtGD+w07zZ0VTTXGmZlI3XoLiH/4rsDgFcdwn2atrF+b+cbpLk9UMCVsizVDw8ekhWg==;5:kZ1jJaMN5MJfxxoST/enkSCYi8kETN5PBFgCNUFGoP7PQuVi+0FKO9P8TTsO1pgwNWc1Q+984yTTIcYJbbSuI4yF/LPb/85Pn4MEAM+L93AJ3PDWJwcvHadDFyiN4uyPRJL4cyRJkedzwCj5L0dPElmyk1I0Mw4IlNrioCcU+0g=;7:W6x8pEaLb7bkIE5mnS5L7uhbtTamS4V4ZAyyJw5AEffImEf+wi3bjqYH8m56Od9LwdQvFIH3yI42YYVoeuMYleLfgkHT9RyTHkzX3akVoUz0bVDQHku2o0U1p6mLMgZNdYUgsd22/n9foOlRCH8OBzbd/83kBdXJmIxIP2KxNSeyhwrg6eMMpl0nPjpCIbkPa/SPFk6RVTs3CPdgZZbS8MT4KWO9Bv5umPO3NSBWDT4QFoozuQcQjNIR7kjMhG8J
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 13:42:34.4536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8cb168-1104-4443-ddb4-08d61fc81663
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below series of patches.
https://lkml.org/lkml/2018/8/3/687 

Nava kishore Manne (3):
  firmware: xilinx: Add zynqmp_pm_get_chipid() API
  dt-bindings: fpga: Add bindings for ZynqMP nvmem driver
  nvmem: zynqmp: Added zynqmp nvmem firmware driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt  | 35 ++++++++
 drivers/firmware/xilinx/zynqmp.c              | 24 ++++++
 drivers/nvmem/Kconfig                         | 10 +++
 drivers/nvmem/Makefile                        |  2 +
 drivers/nvmem/zynqmp_nvmem.c                  | 86 +++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  2 +
 6 files changed, 159 insertions(+)
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

-- 
2.18.0

