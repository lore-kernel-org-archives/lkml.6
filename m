Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4089CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBD52073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Uuh/r1DU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBD52073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeIELKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:10:43 -0400
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:43533
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbeIELKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phpVjkiLe/cQCZXPsdpDPbEOvomq/eqG+DtOEM5sjuQ=;
 b=Uuh/r1DUj4VzWq+qI9pD6waJzUMwdRpqTm0UY2o1zpCv+hyspMJxwV1Z9pzOZ8CmzS5ZiyhaSbE3qut7RBtLFcQgyg5gQrXW1bGvsosNFxVZYDzcJXClJve3z6XvecU1ilLFp/dVAb7o8y7sMzYbhs+hCxo9tP6T8Os9h21/v+Y=
Received: from MWHPR02CA0041.namprd02.prod.outlook.com (2603:10b6:301:60::30)
 by BN6PR02MB2673.namprd02.prod.outlook.com (2603:10b6:404:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 06:41:07 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR02CA0041.outlook.office365.com
 (2603:10b6:301:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.16 via Frontend
 Transport; Wed, 5 Sep 2018 06:41:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 5 Sep 2018 06:41:00 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:37432 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRUp-0001Xh-Rw; Tue, 04 Sep 2018 23:40:59 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRUk-0000kn-OU; Tue, 04 Sep 2018 23:40:54 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w856emU6015638;
        Tue, 4 Sep 2018 23:40:48 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRUd-0000hO-Gd; Tue, 04 Sep 2018 23:40:48 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <p.zabel@pengutronix.de>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 0/3] Add reset driver support for ZynqMP
Date:   Wed, 5 Sep 2018 12:10:39 +0530
Message-ID: <1536129642-7049-1-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(438002)(199004)(189003)(50226002)(305945005)(7696005)(51416003)(356003)(2201001)(47776003)(217873002)(126002)(8676002)(6306002)(2616005)(476003)(26005)(2906002)(9786002)(186003)(8936002)(966005)(36756003)(77096007)(48376002)(5660300001)(81156014)(6666003)(81166006)(63266004)(106466001)(426003)(336012)(486006)(316002)(36386004)(50466002)(16586007)(478600001)(110136005)(106002)(107986001)(921003)(83996005)(2101003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2673;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT006;1:XVLTHdWXYRR6DAOJ/VDpJ84aaG/mwBsXdKMpS4RRmkFGH6GTLZWpM5jTRLt/p805lmGouiRgomZrUGIH9qsEKck4BDXGMZX426Dh+5D9Ebo0sYGmZ7dxvKhXLhpvRLaa
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a135ace-6154-4455-540c-08d612fa8b22
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN6PR02MB2673;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2673;3:qglgfXPRPzhgZH55jZJkhcCD/d8rMa60C+zg6AFuehbVMXswk/addmESbno6lniFXdBpSwrhW7HfZ/F1U2/NdVK6xaH9xbL/0yxFyfge/raLxhp++fsU5xcXWDHuWlOGxXelAmLTmdOPI8SWRSPaoGRkXAHx85L81GruERLJ9knGH6ezgWGQEnYMST6LLpPloo01Ky5HAjLwxqJpdryb3rVpaU689uWRPcnyMfMRVsF1skUbkssYqVWp4ZHLF0NM+xCo2PDNLUmQpgO0V93C2e/uuM8X4mZiSF9NX2GXEWiLEJ5jr60clLKvXMYB/8SUn3EI+iXxKc71Vvx0wUbZ+GiUnGAvhKg9zH6y9g0sW3c=;25:2HC1BB/RM9KazsChRVV/eTvPlkTOTSUZbVHHlIWCnwgllr6S/H9KB46QKLCnKTPjujJazwB3Oc5r/wh5KSuzzsKYyzdlNzBXjIrZi0H9tvuCINdWK4nZHzR7/a7T7+IPPlJn1prqy/VuAgT1f+UplfWX96iu2zQ63e27tSaGo/Nd2tdeiY7omcC3I3uMH+3yd/5Jmd/gsprrSmMA9MfYx2yidRCZf5O1MZxLINvmaStAwaOs73/NZuNl3UD/WJH5EixknzCEZDLCFqovk2h2yZpp+NMc/270WbuTqu42dcnqsm3Oc5lTE5niO44UYQhiw6eEaNMLSqbHxArOuuL+JQ==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2673:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2673;31:LHWqOVuAPdB6PsER9y/t2u1EVp2F95W8fDnjgPt6qjZPabLCPO8yLP57wJV7GVvXTs/kn/IS0L5RVLhiiRG0201022DFRJXHASeiBVR0AV7M7g9b5wASPoqz8Pxjw7twE5TUd+XBVVAJUA6bF/VGNN1EeVddHp0x+mp0M1bnrUHfRvgnEzzoVmhXDNSHNJvko8x2TPz9PxUSl1dJeF36RrahW2LUkrbMx8B6w5C0KQY=;20:jmVHmanzBTXowlj9DYD9YcVMg1XriEQAxFynWWIJdlhoeAyvFm+GM1Exn0C3NhUIXPSta1A0Z3G72Zc6pypG/VxsvOT4xuhxsSy0MY8ZZfUSgQN3lCYLWyvFDXtoVjOBQMqkFxr4pvcmPBf4ypcfuGMauc+JHEDUDio2Axj73JO+3FiDT5hXYtgr6bYGc2Q9JK36/3d09stcHrNmr625dnAxHdxmzQ0Op6EFVyVaP/fmXyJa3Eel5SGityn2iaHChMpm4b1REi8hEdSGucJIqcJn5Oac1TA/UQzzZcQNWA/oa2ckIrBJEtbKHqFKhnrwsO8um0q9LOvO7bK01Vf0f5bgjUYqzNyQBJbBCy5VbWxUrfaP4CV3H6V0DK1E3s/xInTQBoSJwq9dsY1iDIRM2bj3nmL4xTUZ7yh5i50j7y3s2zEGi15XhbIoPcEUndqqX+0D1/TY3PPmugynMBO/NXe3tAdlTKXJ0gukcQAzeDYe3eDr48rBf0efdN1lxqdJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2673BE0D25DFD1AC0EDBE295C2020@BN6PR02MB2673.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BN6PR02MB2673;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2673;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2673;4:hTaVNWOwDd4iYqrXqeXwBoEs6YaIzkD7PoLqOtOvc5j2ItXJWXLTIBi/YXAsfFnFjm1xaTzMpp8Bu6lAq9OubS5mgr4maEJevEuXPfOQ/OWiOJxvsqk1te7pL6cF4wQ24CcA8x0CV6Aqb4oGlzg8CnlmlgmwnG6KrAhpD0tspbpAbOtshYlZdQApoh8RAqazaW3AT9SvvTC54/t8xko2Y+WQ+jmwOE8V4a+U2jgvNKbYLtiKalig9y51PcO010Gj3B73728PEpUAPAfPr67eIA==
X-Forefront-PRVS: 078693968A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2673;23:rHbueN1YzB/maNijoFHE92honrxGmOXJHV67SVIXg?=
 =?us-ascii?Q?wt2GlfV0Ki90zGeQDMCjE7C2LgWCJGrfPTr3CVyaGR/91hajXtAoYPqJVRMp?=
 =?us-ascii?Q?J5ztdAh6mNjUVjIi18GCHSEE35ABUWnU0qcdcHLOFkOHV1nYt3XY+m+BRbb9?=
 =?us-ascii?Q?dHXu7jyvig0v7CNfiNl/GO7dt1REgT+xMD66B7jEuuOSKFeUQCeMuNnA/ZCx?=
 =?us-ascii?Q?aJ/nmOXgwRZyiHud25mWt88LGdMlkpdHAvJgmDORbNy066m22n3nhcZhgUwf?=
 =?us-ascii?Q?feXLtC1/LFICEckq1slYlRqWFMI6KvE7uZvfnBVRTY2u+aU0KbqhT9+DB+tV?=
 =?us-ascii?Q?M9MBrVpZmJo6AYztbfvdhlJwulyMuCtsLYYF2QY5OfNZ9zFWAccfheztmZ4l?=
 =?us-ascii?Q?FQhmvlSKn8TJ5rcm+Ca4KC0e/X3bxf/EybT4+ueAT2ZxJ7yXVN9K6v9oqHY9?=
 =?us-ascii?Q?+zpLTrF0ahdwJmZChjFevrbXKgBivLnttW4OKAJ4qIePI6OPHcrNzzAHiMqV?=
 =?us-ascii?Q?47hcAd/gzKnnjDnhR0U968hokx0CeXexVzPv63XFcC8XqIufY3FQd9L9QUAZ?=
 =?us-ascii?Q?hY24wC8SEE4I4fenemU70mG9GQ8XjPChbCyO+UO04emYM1chqc6vxoSZUe1h?=
 =?us-ascii?Q?lLb3RBKv5IatrlFjgE7s+rtviXl6B+4nuP+07PQcJ8vBHy8yDqnaytDo49kX?=
 =?us-ascii?Q?Da8/s4bL1YVSnFtDJbCTmd6VMY0C9eM0WDNuaMS4QcopQdGp1xFUnk6Calvt?=
 =?us-ascii?Q?gadFPbvlRJ9jP4DO0hoeGuSYhdX1AzRGwF/fWCRA45G7SAz9+AhvXitr7zHP?=
 =?us-ascii?Q?uovHGWnREzl4dfYa4rctEOU3b5ePPOUiylbx7c3XZ0nuzk8KW2T0s+llZA1D?=
 =?us-ascii?Q?Qm7+67PkzIeLdBAtnJK8oc+Pd6p0McSQsEWbWdyzidmay8RNcHk+r6KAEPfV?=
 =?us-ascii?Q?8FzsjHgcZCZWAX5saxJBAw3D5maY906M6G4Eji5zK8DHcEuRX5qJwd7lqmtC?=
 =?us-ascii?Q?IQsQtg0ohlete8gay3i91mCigVl9+Zimx8Tn62VBxqDb7zsfHPIry5IIT6jE?=
 =?us-ascii?Q?sC2UFeb4T5f7+e77qsdIFSUNj+qWpzEI3QK3IAj59tNoFs4hW6eVPBhWx0gy?=
 =?us-ascii?Q?h0z39PFFq/cirs6pBewQ36CRJ9CmaJo14loh/5B24AOcAf1EGJJGA=3D=3D?=
X-Microsoft-Antispam-Message-Info: as6H5kLTUtzIhzpKAP3IMcS9lIfDqKydIEfmr4tlxAZ1vRhCGGuMsilT/V2rXiDEKzlczbFy65/9+4uuOqttmd/jljLj5dWvV4uF0rXG7I38nxsrfsRc1g34J8le7BVgBiPUHeVGs4PfC/sJbIQXnc3btKCgMxAWINGruYMUbJZ25lg+wEyk5YaIpHb2DKaT9uBBNqyx+vrNOxqZcBsCug+iaHCDRwqiEbSSTSDNvcBWlSUBIuhFJnrxJSmqt6LG8iKJoAfk9UxG8TSy4Eh3FE4qVMehSnoNKu3Tf9irG5p2LhKePhGekp/449gqOA0I9wVnm79+5D/bItqX4XSnKtWCDaw1tk9WAX3AZm1Y83I=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2673;6:w0VDNnxRcbRglzfTWUaJZ+NrNwvPgiFXJFzwslIKUcCaiA5RF26+skkvfrnVXJgfLfPYh4qgc7BEv6e1sC3QparT6gWRTVsNSYkhM2jxSpkgOC1rh66e4bbHHd91MIaN5ZhjgC+D3+xNNY4buIaFJmsTjttkxzoDAUs64nTCSyexo3lwFaShhGBw2gmLnEbwfHvutZmAB8bmei77o0cbAf/b7hU4vrRN6bkDdyVP9Pr4waRozTIjyMni9e80C8x207n2jRtLfzvEpc27vADx6K+B9JRZxovuX3Rc9peJSeHQcfHc+4sEGLcR2u8FVZgPKMUivo4z5lfBGs+IBGq2gkL+A2PndmY0Dyxo1WPvfsjIZFFOjT+eAoBvFvDiAXIlmj7Mw5l4vUrn/7PFiMSumS4obKr8jv+Fw9OIP2jeDwLdEtrMBBEiXlzvMv53PVXeOrsikFmhc2yI8zOcI2AIWQ==;5:cwm7h5rjcQ61uKBT6hqjA1TrLUzJGWaaxItL4zyMZx8zTRfTbwMWI2XC0xMRp301UjyRJk/Hk3t3H0H14AOQcEGbREvH3MqaeotF2OcG8Z1wV0J+iBr/Fg0iG1VZ4GF+To+Z0prEyh1rb88O4KupqoSUjhviFJKH2zvMjk2BsQI=;7:VcxI0dsirlXZJ8qhpagNlzKpz54Fk1x8SVLOj//2UR+HnOKw6osgWj0yWLMsRHFHD1D6CKuXTROs5g+ipNIPQ6LOUEUSiOB1p19dkrjqC1HnfJTY3MqpExeb47ikAUbjMYQY8JuLMj5nd+tUqm9HuR+R1NHm56KzIA3e3BncPicl9qK/qEcTGIJLRruDbKmScENBOD7oBgKiNShzbKmdtUZhFmgTi27ppoVJi8zPfPLiGm7arbAkiCGbN7qjR3Gw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 06:41:00.2098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a135ace-6154-4455-540c-08d612fa8b22
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below series of patches.
https://lkml.org/lkml/2018/8/3/687 

Nava kishore Manne (3):
  firmware: xilinx: Add reset API's
  dt-bindings: fpga: Add bindings for ZynqMP reset driver
  reset: reset-zynqmp: Adding support for Xilinx zynqmp reset
    controller.

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 142 +++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  40 ++++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-zynqmp.c                       | 115 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               | 136 ++++++++++++++++++++
 5 files changed, 434 insertions(+)
 create mode 100644 drivers/reset/reset-zynqmp.c

-- 
2.7.4

