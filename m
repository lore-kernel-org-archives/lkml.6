Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EDEECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28452148D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FwH8PjB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28452148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJSQyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:54:49 -0400
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:58048
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbeJSQys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqoTb/Ioo9UVYVLxAyJUgVdmnwQjf6lVTjthkGNNaNU=;
 b=FwH8PjB5xOqptlOV+uahFbvdJk39E8xrZ4qPVqRiqZhOUT9Tad0XB9URA+gspxafww5npPK4b8Ts1KONww3E3VUd2Ivnjriti/uZfBDXtRTOED8IKaLjqyQbGRMnIFtDzqy/2Mxpt5WEZ1+br3vemNKzo1VGtWCINW19aaGaJ5k=
Received: from BN7PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:20::28)
 by BYAPR02MB4456.namprd02.prod.outlook.com (2603:10b6:a03:57::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.21; Fri, 19 Oct
 2018 08:49:36 +0000
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN7PR02CA0015.outlook.office365.com
 (2603:10b6:408:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.22 via Frontend
 Transport; Fri, 19 Oct 2018 08:49:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT029.mail.protection.outlook.com (10.152.75.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 19 Oct 2018 08:49:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34842 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQTO-0002fj-Ha; Fri, 19 Oct 2018 01:49:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQTJ-0003Un-Ds; Fri, 19 Oct 2018 01:49:29 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9J8nJ6G004102;
        Fri, 19 Oct 2018 01:49:20 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQT9-0003Tc-8g; Fri, 19 Oct 2018 01:49:19 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH 0/3] Add Bitstream configuration support for ZynqMP
Date:   Sat, 20 Oct 2018 14:18:02 +0530
Message-ID: <20181020084805.29103-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(438002)(199004)(189003)(77096007)(110136005)(6666004)(336012)(50226002)(2906002)(7696005)(316002)(478600001)(5660300001)(305945005)(36756003)(50466002)(106466001)(2201001)(8676002)(486006)(81156014)(63266004)(51416003)(106002)(9786002)(1076002)(26005)(39060400002)(356004)(48376002)(47776003)(476003)(8936002)(126002)(16586007)(186003)(36386004)(81166006)(426003)(2616005)(107986001)(921003)(1121003)(2101003)(5001870100001)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4456;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT029;1:X03QikXV3+KjPrtxfgMilp4KTDIDQ0x7lMmMNngNqkHERC8dx6yeEspiPv84Lpens94MK/42wNpMQdzgF7mwJTqhIPW4dN6yjp11X/7OosA+iS6YIU2nkZaziBwwd0z4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1aab89a-f77c-44b2-749c-08d6359fcbce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB4456;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;3:hHScRcitBUoObyaYM5nPm4F78l/6ITxJ1iiA+/RMeTlfdccwHCnnHQ7yQ9AT49K8RQJ5BKQQCQnc5hi8Wh4RHP2YK8WE77sDii7Kq63wbsebt9t2dMOW128OTQa1ybBdIH0MuzxpJfN41bgitPCqNRfmA/vCU98S+bYNHLau6vkhWlJDmWR6G4J3GPiZG9M28txukhdjOgA6MNg288TDH+VACKy6Mpu02WppN6Xmp9DlBoK28talu0NVHpwMc7kQCcsh2pC59WcWsmM54f9Wd1hZvTKweNBvx1y/43LuDhOV+YU0EG52X7K8RO+oVZzOCfF8yli/8drw8n+m6V5fLS72/sBKYntRNK9uTx26YQU=;25:ZnkYEzwmzdzrgT25ps+hf/TewYJxIUYrhenEjh7QFCKX7KjrkmBHUkl9jVD9hOhjnagWlPAMwC1FHqQqEfxvaIeEjcidzpbjSGhkJGWULhzoSKH8uIe+vhxWcyejVKgzfrGIhbbhYC1X6+UcdYMzdN+EQ/NjLqH9Qivv4+8LDeJuMkvPKmcL3WnCIRha78KVy3CFhJnLK3MnhSGBAmbegiaTsA1QJUV+EBxd9omVgkNNYbn6RS4uyLiKk0e3AJ7KsvfK06ZMWsOxFQAvTEGNcQvEmN+lOYn3KPkyd1kg7vJSI2QNbI53EbbFxzlT7TFKJpfKC/Sqs6oO8QnK6cLvaA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4456:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;31:aiqv0ECmy9u6HWZkfMBdAx6RjQGKyrwqGGBzXP3EWNSkxMKvmkUMq9snWajLMgKBtBnM0AbGUDegycEijpJ8bbCZV8xGNcziJ/7LWJHDP5Ta11K7LHGJeVERVb9C0Z/OS95InNFSnnDKs1jxQDNhltR4WNhpjfHgsolEGHZYPP+GhT8FGbkje22R7GLYF+hPHDEDhxatyOrznE1X4a98sbO/ifRS44+WwmY4981zaJ8=;20:VuiMPySRwfLcaLBpViscOwfcPOj0hd1QeIM6rWN280jCagordiW3sSpXNuJO+1jctAEJk8yQwGc7qQg9+Np273Gdoh9zRMvcf4OAIMM2zR37Epg/mbzlEocGrpBzqK6Cl2e173ZpvvehXs+43NfcGkmEfN0u1+I2AR7THhUiwxjmOzlGK1Hfu8BnInjS2w7tOJ+aTvHV4eCldDD3UNTOLu96fbSkJ/HHIRMiJz1HLql0hrcFDscYZgcnYH6+iW/swlvHKtAvwdEORv1xbEp9x56cH/7VQOPe3fWPpTfkp6wa/5fsglMAYloix7oA1htU+MdoHJJWgG9hOlX9DJYyaDSMyNzySW9GAULHXSGu9AQROjOnP6t1KjGcUbtgRPPWv3rbyaZidAPPiPQihIP09nYVpOW9evilWJsRofRDz/8oM9Imn72HZ/FdQCaYyFWruLQ+kYd4DenLpliIMn2YI7dsCaMUnk3JXR/+wIDycVirVF5XQ/rQlxr43JFSV2fK
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4456559C71427FF82637C151C2F90@BYAPR02MB4456.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4456;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4456;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;4:NNyro8K/Raz9B66BMcyhPE5VqnjhM4HIYlJ7lgO0HQNhu2Dg60aNH9DKq+zPU2kO8OdO6ssHJtW/10CnZi/Be1IXT4gUiWSREOIPU9JHwFbCpYajUltrXTdkR3Q7CVKrucTGWS+9q6Lanm2GSkPG6j/uslE6pjOE2F86MSZLMvky3h6jsdIv3BtArEQPaM1igNxReuaj1AerTvPOKesseJrFomlthMrmSPKsxcX44T3UrBWJz3voAYLi4W3V+1bUBZj+QGdiGm7owsSAPMg7sgtT+z8IGK+R3bSDMDlteRu7a2vXljIG1IqAAvnSEswB
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4456;23:y1Kgoh/1E8Lr0OcWMDWWgmVDC74k3CBYLtAbP3roi?=
 =?us-ascii?Q?b+tzydid28JG475NhkU5gkeiDiBBqe7nifTe4b226Xig9gMR695Os1dAh8l/?=
 =?us-ascii?Q?vGnkZHDfXDi1Hed7a+KS6H8RYN76nNZ5eptbil9TyJKmby8P/Oh1vNr5t+v8?=
 =?us-ascii?Q?PRm8d004B1scVk1dJexe9quvtge4vIixz6FYlq9wAji3b4Y3036tSwlxuR1m?=
 =?us-ascii?Q?hArU4L6ae4K2NVQb8wmbvzwuQHnJzbxgxSz5aJOOUZuhZMbW7dxoCfbtH2ha?=
 =?us-ascii?Q?vTaR1e1HljtzXnB1XzGJCq8DDPcYFgxiPhhdaZn3C3hIW9LytW5I0fOc7s2y?=
 =?us-ascii?Q?bWzW+3RJbfSrn9I2UimY03jCgaB6aaxlaLG01nzMsXRnMbc945LyS7h0OZIJ?=
 =?us-ascii?Q?CzjahjYyMVV32OuxP8nqeA8apsB6N80FhX/dQWBVo9YKKK2qwlzGlq//SQSF?=
 =?us-ascii?Q?tSGZZL8UmohwiZsmB1ucPq6YIr4sI7BjNcw1YWmEvYRA8F60tMeYB47/s2lF?=
 =?us-ascii?Q?a8lerv28DKhIA/9apBYN9XsqpkGnDLw++Yr5NTN5VT5yunBoE96XkRgEKwLZ?=
 =?us-ascii?Q?hTHBZ7lG1xWFqJOSvGVF9BzVMNhYCRJqFN8zlDPnTvcpqNW8jQBqZNXPuqPY?=
 =?us-ascii?Q?/AY3bXt8/9yEle15cTkbg+i4UlJEC1EnQoVJjxgWg8Cgxw6OZy9fB+GkKRWr?=
 =?us-ascii?Q?Xx+CCkGuoVmmcLjeYSTvizisaPWa+oOhpMiKWsToxfZFgUhXSX9RPPZ1vWb6?=
 =?us-ascii?Q?oHYg+WmQjIzgF2JDgNZukfVEiHB1PQrQ34xJa8JGV4422hXhIjp7sxVTB4TG?=
 =?us-ascii?Q?WyhhXptQnuOcrN7/IUoYUKonORZwKLInzML+TYVWVslIg9jqmE6YmTf7k5T+?=
 =?us-ascii?Q?gXHyeIBpmFycWI664+bcHm5Fu0UxySMwgEkqV/dIvAIfBPrdB7EvmVD7eGsB?=
 =?us-ascii?Q?6e0vSIEEt8qjGmU4Eu5jHntfVNdowfmhEUGWBjSkgKvoxkFtlTMnZ0v8VOvF?=
 =?us-ascii?Q?7p0v6yxAffdSZO9la1zoiUI5xvTXDtaouZCLlNxTbckIoyjv9SeTNA/g+XJi?=
 =?us-ascii?Q?c86SvgrvuAbnlM72KsLcCRJ0LtQns5YkyWQX4Qy+OvuPd+Xdp58EOxB/TWkM?=
 =?us-ascii?Q?8yp2Q9iY6/+2xnM56MKE09jyxQTC1hcu9P835zCUJSb4DJONCK05A=3D=3D?=
X-Microsoft-Antispam-Message-Info: KLXljlAD8he9S+AVeTeNM/I6F0SiZ5EX2aApXwwmjymifOTG+ILoEXw8dRC0Ip6rp87CL42aWcy0rcc2iQl6zj7QkG0Nbgr5QTL47i4oJRws4OtdpWRBEllEVikQP93M6dsjNZA/aMhaKIPadpg0Bfh9ObNH5DjV9KTMUaLqE2u9Pcr/gvYSDDvlYnYAbX78LDa4iDLA3F/dngrQIDn2PzdLvYdxVy4RJupVcunoFknOsWhm3lxd9Lm9jyowK6n6NNBecvKf8YklN4vsCz+aIpcLeh/MnS60OkTrPgdEdieNGZQSRRt2Q3nF7ggn3pw+8tFeCUmgqQFUe3jGCh3laOlv1Va7yyFTqelO2G8fvDk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;6:L9r3sgMO7pPLSSzTW2xvPXee4V60ObnWgdKOX7+OYBlfi2OZl8i0UtweqorLx2TNHSJG1cYQDF0MStZRHqi+3rIwGtp2rI20mYDsR7F7cnHZho+LLuAnzgcPHj4OgSirWl04DmPJ+K7bxT4fqRxfiwRtL6pNAsW7ADLKNfEEr5ITsVZHrk8XgFEB/M3cXSVtcrFQAH63zGpLMs0je2w1js8IhTYFcQdSSLIk83RAd0fZ5wB5eCMj3mw44lTXrnZhw4JcP4vabQse/HUWcohW+8MewR2kVgojiOoVwz0BlZ7MK5sZJNTDKsUfyOZ56EVRiFHfxU17JAQ7JBDelRd4UeUH8an83Otiw/On/NOqR99Hm4sGO6fzK0myNz6tfyxE4ikQRz6pIse3u2XLMlth9TXR6EeHUQK0EqXWXYJiuwnPo02Vo0WrLGu83FTIjeSN/Ah9dQzSmA6R9cB3y/5Giw==;5:/kG5DLIOxph0qIsUiJ4AjhP6oKNX3oxBGVBDOXzLKqgCUwJ9AD2U8/rPncQbti2D6qiyhs9DZW6QKxBRwY/sRB65P3SCv73TOMnvtvhDzu2Lq0/cLpg3qD7SKDggjbv/MpIq/1lQvE/kNgt5n+2Uv2LOh/XaZHnjRKIaQ+gM3fU=;7:sHPBGrr2GoLnVl290Bn9SIkBofiVEs7mjyMRftl+o6J90mJPqv0/JoHTk87E4429JjpIM4oN67APJX9Hw9BrfgZpugqlCJFzXLmPNVa35QSmjp0HxZ+FvMMkc0sPs43ejjU/B413MuILitGFNmrW5AwkGVWTvIY47roXtckrLVBs2b6p8hjUyzoYjuK77OFhddmgIPQiSp3dOz1TwpxGzqu+KJevi3mPafhF6fxpqQhaUuYFrfbbluUrGfyyOrip
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 08:49:34.9256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aab89a-f77c-44b2-749c-08d6359fcbce
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below repo.
//git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
BRANCH: next/drivers.  

Nava kishore Manne (3):
  firmware: xilinx: Add fpga API's
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver
  fpga manager: Adding FPGA Manager support for Xilinx zynqmp

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  17 ++
 drivers/firmware/xilinx/zynqmp.c              |  46 +++++
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/zynqmp-fpga.c                    | 159 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   4 +
 6 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 drivers/fpga/zynqmp-fpga.c

-- 
2.18.0

