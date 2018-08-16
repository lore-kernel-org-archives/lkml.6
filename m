Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B76C04AB9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDF920C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KsE+56mS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDF920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeHPWWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:22:25 -0400
Received: from mail-sn1nam02on0075.outbound.protection.outlook.com ([104.47.36.75]:63125
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbeHPWWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdkDTUJ2fOvXm1vHC8BYLeDzDRKIfXqQ1N++WAWbcWs=;
 b=KsE+56mSW97selHWyKN1VvslQoR1siwePNQX52wPRCOUHBfMpTwPtzOM+i7AsHV+eGAvthK/GNQrw8KgR1ftTbGomD9iV/ekDRaCFK5vbCtWIumUyjchpHm8NkczanCfWbRjhiz6FHc+FvOKJaeHoy/jqMSoxxHZfq7ZrhT8JEI=
Received: from BL0PR02CA0044.namprd02.prod.outlook.com (2603:10b6:207:3d::21)
 by CY4PR0201MB3508.namprd02.prod.outlook.com (2603:10b6:910:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Thu, 16 Aug
 2018 19:21:59 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BL0PR02CA0044.outlook.office365.com
 (2603:10b6:207:3d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Thu, 16 Aug 2018 19:21:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 19:21:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNqI-0005js-Or; Thu, 16 Aug 2018 12:21:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNqD-0007wo-Jg; Thu, 16 Aug 2018 12:21:53 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7GJLoQw021518;
        Thu, 16 Aug 2018 12:21:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fqNq9-0007vv-Vc; Thu, 16 Aug 2018 12:21:49 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 0/3] drivers: soc: xilinx: Add support for ZynqMP power domain driver
Date:   Thu, 16 Aug 2018 12:21:41 -0700
Message-ID: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(438002)(199004)(189003)(126002)(77096007)(2616005)(26005)(426003)(2201001)(44832011)(476003)(336012)(106466001)(186003)(316002)(50226002)(486006)(16586007)(51416003)(47776003)(6306002)(7696005)(63266004)(8936002)(9786002)(5660300001)(106002)(39060400002)(72206003)(478600001)(36386004)(50466002)(48376002)(4326008)(107886003)(6666003)(2906002)(81156014)(110136005)(7416002)(36756003)(305945005)(54906003)(14444005)(356003)(8676002)(966005)(81166006)(107986001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3508;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT027;1:yoIaf6d76diEpRJoIao1mgbI/1xtCc1xPBv3IUIwVKSOghClGAAkHekSNE62EI3HO/fNOhlQhMAFuRz7AFuZ079SVsX18ehv+wV4kNIXCiLdJ4XYPeF004S7bmUhmLad
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a1e3e25-4723-4029-8524-08d603ad89ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR0201MB3508;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;3:9X/vgqJ77mk+KsyqAhvb0fbfqm1/zt/Z+pt6B6lTAwP13/tEKJTCza1JHLy56iBHbNhKChuiOTS7N2/T3xts187M9ZxYIv7JWMNLUufrOKhwnlaYKcuG3rPZbCIjznGdV0+iawzeGyrhPKi6JizFjrwcP72Wuyw6qnW1u+J3baY8hmDLbwgTNlXmAhkQkKxnsFmaSKMKLhGFxGoG3OCL22Vm0iO2bBYS11MJ6DoBN+ot2oZPtANDCEUGKDyJ/8q2vgnQzFSoiYzUr45fXqo0paoSB0EE7+ONlOlELncarasfG+CXL1PrDVDElR2EVEwvpfzA/UWMt670W4KUkh/jcKstBDaw2rJJmbwoEQzDTFQ=;25:G27wkRlbqqB5ist7Vlu/s+61RKW+hZ6XuDiPMRrGc7CXVenZqtuVhi0b85OWQNTiMJgbUQcUv41gf/MPEt0KX9YiHI5lFA//78SCwgp6cvkD2km6tlhBCytYwQS7CRFUUWDH7U29ip55fZNvY2O1ijFuFGyHgSHb/zKXAuFRRzepfRyKbt29L9XNKW4fsieugsj/JnbWktIBScQStfFZrrViXgW8Yy4WFHK3oUPfFiaosSm/bhrCTYIsKS8Yoc3MKa+6dEe43MnYXC+cfXC1UxBMR6vRwNnVzAy+S0OPmi/BUtR5OZu+jcpS3hFo94nF89IjGtzbSQm2ozzBf8YxUQ==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3508:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;31:fURfatBormWZw9rQ9l9RVI3zfszR3TxMWCK8NtFZpiLuzf+wRyGK3QJ9nO6Sa1q6GCtFDpNXvhdTbBYqQwigxq76qJVCKdfQubVDknga4axqwavYZ+xAmjm2XqH31/nw12cqotoqK5YKInTxWtVmqYqEBrYIUgedHZhgYbkY3dZONHqM1aA8OiZ6m+gnSoYVYtc0I9s+eYuvsrHWSPc3pThdvSyFMM/HZ50chc3Iq+I=;20:Hk8aZO7N8oIvDRG7GSUkvdNQ/gR4t34QW9Y2ksdYHadobK+2FIRyG1a/+GuiAQDX7icbL3sUut7b9g2hkyrn2NriojXT+tdv4ejcs9pvHp/7XIUY7QIAbg7r8U8SHqn73mEtlzrDt/tAhEPktWdrdUwt4KjYgTaaKJ4usTlvkRwJyWGI+hmUYKFS4apEEJUH8wR7ftRK/QX2V06jy+kmioiKKJwwuSNVtCkvEiWuAit/dNj8I5nukWmBwLv3dDFi9PsQk+VEHW/9HHbjqV80dIyP5QOz/iDovSgV8zlym+7ES9v+hLZ1zUCR+p9ek/MJKcFWP+jk5QTuOQg/K3frVYqi39ogdhTLdKutpWehzGs11RzKAcFETOjwxOVhvbZLJharc7tFBYy93vmxnagh4r6HrQKS80cwz+alW9EQlhdxLos/xqBZKbp9Ep1/cj7iovktx5CJhj0NoSnywawiK8/DRzqc9XCCAoyRF02SbJBfgWirSElwD9h4Y0ns9rLZ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3508B262B7526FE750EB71F9B83E0@CY4PR0201MB3508.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:CY4PR0201MB3508;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3508;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;4:lAC4lvwrwyxMo51DDFBwtzwsQj51T3dbwwUS/qyHr0YCsJmkF2ESyXem7b7RGbfJzCKQFFj7+TgP2oJdkFlrcPhRxp18usm0rerzAV3FUnBm2mbdM/vReCxhD1hnCbJ5hBwqaiO64zuwS8cVg00+Vcjlmc0JzRuNDkiDmbyeN/O7T5hZjmh2tOKuPnm66tjW7Pk5ol62Dcbj+EIGnNhq62CTtHaQW6z91t4cqvxvj/UetEE+ZQ5WHvT+KDREYZaWImO09IwDjPG3c280hujcew==
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3508;23:Z1VZwawG9bfeBlxizw2OL9Qy5x9sXql+f8VxpJ6?=
 =?us-ascii?Q?uURdan5vtsjovl2NV/sYUcBB77xNuy/CwIRskhiJx7hOncjV2+bWIZuWvxo+?=
 =?us-ascii?Q?8R55oN+N3i5QyFOqQjmzOoppFVzNtoXuHqb1qM5H1gqWVbh5PtnEP41E0jsQ?=
 =?us-ascii?Q?NsGDTaJ7ykM3YVJ7lsxkVPcmF9dkKgpx3nawdILmZIiICBlK/s+lUYxbwBOc?=
 =?us-ascii?Q?xjv9AmuNzxmuN7gGkt6Cv8l4xrxjjN/1bdRute8WOHwQxECWCKbie8AyJbOL?=
 =?us-ascii?Q?RMWSku2dhcFOjOuOO4FXtlPd5q55Zz2ntJpQNWfKluTEy7Dn6Pz5GnZufvmH?=
 =?us-ascii?Q?49dwY3qpS8IerVdjItIPESEr3Y0w4rG/7oRgPrYbUHwEm6sZn0ppLT6ICPyV?=
 =?us-ascii?Q?WzFtRKA+TaFqCeYsQD1Gm0/VCKEQPqkHb9xiGJxgOJFughXFcZaYxwUam/MV?=
 =?us-ascii?Q?TT+h9b0S5ZIlBvLFiyZeEptKuqTCWhyOXohVj6phCVDuefxRtc9nUVzn4/1+?=
 =?us-ascii?Q?DCtjES2LauKzniyp9nuBgW53hmK/z0ELOcPKxNTmTuBBfSYdTm+jYh2QSUUX?=
 =?us-ascii?Q?BhZ0d5RZsu8TlZxCXvRL7TyZdomELI+cDgd5KkmO1rsJSKS+kPoa51366YET?=
 =?us-ascii?Q?DLUp/hwrzWiXY8C90SxF+6Z3txjF2CcwOebMhrzTaAOuwdZx/4dOCZo65A1N?=
 =?us-ascii?Q?+g+Y29D16MRd0WksG7+pxRnZIaYEWPmdRGJBtOJSlTahDSa+4FBo3KRW99xA?=
 =?us-ascii?Q?wqMX5y4t29y133UnMC/KU4o6+J+YtpNhh/C5nPyHXGpflXR6BJyqUgeC3mwI?=
 =?us-ascii?Q?hIIfj2Y7/AAlr+uZnyasWiXcsJDR1+7CMsJ0AWb1LGcRzTlxQX3zC/iDaZJQ?=
 =?us-ascii?Q?9y4c1IYvN2eZmc33Szyz4ea0t08jywaFSJORGiaDErK9CMHQHIjoC5v3we6o?=
 =?us-ascii?Q?qOqVMPdpMYhpOp3mQ+tTF5tFFR6Kt5g2OF4/+xsuZ3SfGmKWk6KudVn0gthu?=
 =?us-ascii?Q?29d8LR7rbFyiFf9lgXmA6cOLeo8XCY/rWV3VZSXnybBQ3jjhIrkO1mGVxZpA?=
 =?us-ascii?Q?qXe/tQcoJREM7BbbZCgKBxPG/Brmlf/aGDaaAN2qbOO28WlfsctTkN/iD98L?=
 =?us-ascii?Q?oFWI3oWfhjrDlPI9hyZk0laOOOEUFPJXp2Sd8EgpoVO8XdM6DcKH2ZIpWjB4?=
 =?us-ascii?Q?lccZ9ydHajel3q7zH2o8HnQT4pkMcwT9u8EyyT23/59tWPUMDEG3U6jtMVpM?=
 =?us-ascii?Q?4OrkSf1NE9F6jMtAWF0hJDwQ1MfVIuBw1J7IpgZLpQ9fWNtkPqj8/XPvp4jS?=
 =?us-ascii?Q?2mQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: dJFripJ+1QjZEPx3BGQAN84bV95dl0ZKewwmgYKO185YJZMVK2acGuhfnbe43vG9aHQpQVeXm8XkIj0+stWUZxDIIeBOmoZ6OHmdjUKIMbromMCN8HSjsY6M9y+Innh3sZoZe5eYL4gEvKEQRupmqhpr72gcSJrn5mBlMSFYuEqIqDhsBSvdxSIVRtpGBYg3/X2OYrIps9FthGqiwyQ2qIgPTbSYdsF53bYnn/FT9xIv+/ea9e202KbONjLse6zh0e67mrBKzsMM1kmJmOeRWa5KIuQnXwNtI1OsEPkhDsTYOCvZvIK9+dEG7LkwH5zg4xovkaGWhlMYhKIGBtVU/n/DBnCtqQHdicM4JZJJVAg=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;6:yyKvya/y9BBQpyc647vBFbFUFrW+AjuiDKuxCEDBKI/jzZ5FoD0uobdg+T8JXqjD/Q6G5KwR4dp/JtpVwOo6Kv76cwDxcXdE6DYhC9uBcH66uuAuJD5SyiR7ZWOJaEOqA2jBzy/xjzNyp59m/mbXS2YnbEWtrd+WXRBJmNZgWeD2liKyVsCFtQrQ3AYkiqYfOxKzQq3K9OyqlUOAzwT181sEH17iTpMfHNbN3NsxARGp5OYH448O91AxMYYrPOMTB+oX3Ld+/Pn6wTDhX+BgJdwd2b8yAxh1lg52vMpxSTqTAI6oqyBgU4TBumoxrVJJ5nBoF78IJvUh3EbnS1yp2nmVS+p4u4E2PCF9CeaGw7dEGlyk+MFVK0YH1Dt0Jltj7GKjp/bENeXnVWJROdh2kFZlL+bE9OQYENlaXcIi+Odo3ougZT/kWO2i6my1lfdywPXOjmJEJYq3pPwBRf+0WA==;5:jy53uDC3VT8XUvAIDcDKcfShOiH5AG4WtG2hLYQ/QEqu7k9tW6HJRTW1QLljNl0LEqCYHxotxQ0MA5kdVaSdcpFvzjksCzExNoFYy3EbG5xLz5fM1YKhfSJp4IFso9kV+qjQYluwEczmfQSxMPHv/rxYlMPfUGkFMHIZzVCHBXo=;7:u/QVg5GS4FCsD143jq6IPZfQZJ+4WtNzy/qeAlBd16HOkpGV+hyiqGXABfgeDMIo2Yzuc+/PyT73lpgoXFkAwruFok0mXy6rg9dZGjh+oegXHEe19r8cDBCATN/TkDr6l1BRxElVRIyv3LpO8mtBznLKz60/tMF2iZQDVziYXuZbr1HPFZAyaFI3WHfLWOhxKIKFkMYGNT4cArIQajuUdb7ETC/mTFnF7WY9cykpwTfkasITzQ/oBIJLhUHoHaMw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 19:21:59.3761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1e3e25-4723-4029-8524-08d603ad89ca
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zynqmp power domain driver communicates the usage requirements
for logical power domains / devices to the platform FW.
FW is responsible for choosing appropriate power states,
taking Linux' usage information into account.

This patch series is based on top of Xilinx firmware patch set:
https://patchwork.kernel.org/cover/10555405/

v2:
 - Rebased on top of latest firmware driver patch series
 - Updated driver name from zynqmp-genpd to zynqmp-power-controller
 - Updated device tree bindings to move power controller node under firmware node

Jolly Shah (1):
  drivers: soc: xilinx: Add ZynqMP power domain driver

Rajan Vaja (2):
  dt-bindings: power: Add ZynqMP power domain bindings
  firmware: xilinx: Add APIs to control node status/power

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  47 +++
 drivers/firmware/xilinx/zynqmp.c                   |  58 ++++
 drivers/soc/xilinx/Kconfig                         |   9 +
 drivers/soc/xilinx/Makefile                        |   2 +
 drivers/soc/xilinx/zynqmp_pm_domains.c             | 352 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  26 ++
 6 files changed, 494 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c

-- 
2.7.4

