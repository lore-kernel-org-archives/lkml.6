Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB5DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4F4208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bVS4c9s9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4F4208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbeGaLoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:44:18 -0400
Received: from mail-dm3nam03on0045.outbound.protection.outlook.com ([104.47.41.45]:45536
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbeGaLoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IauSNx8YPigYd369kNMSkktAe7wErmbdfh6bYLYitI=;
 b=bVS4c9s9hbNMPjmlZM1GR1H+DjtX+8pHEkW/9k6n3sqLwF9ECNhPqtwuNdXOYV4FTU8l3ExOs+KAj1kdBUQbe719NWJC7i0Mx6wXKfuMoHkj9AqwVgTbcxO9V1L/Oqjjx5QinCeZvmAZNjW0h8Zkj+SjjRmP/cN5k0hY+5qRdS0=
Received: from SN6PR02CA0030.namprd02.prod.outlook.com (2603:10b6:805:a2::43)
 by MWHPR0201MB3514.namprd02.prod.outlook.com (2603:10b6:301:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Tue, 31 Jul
 2018 10:04:40 +0000
Received: from CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by SN6PR02CA0030.outlook.office365.com
 (2603:10b6:805:a2::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Tue, 31 Jul 2018 10:04:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT034.mail.protection.outlook.com (10.152.75.190) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Tue, 31 Jul 2018 10:04:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40206 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fkRW7-0005eG-9I; Tue, 31 Jul 2018 03:04:35 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fkRW2-0005Ti-5B; Tue, 31 Jul 2018 03:04:30 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6VA4PUC001839;
        Tue, 31 Jul 2018 03:04:25 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fkRVw-0005Sf-Mf; Tue, 31 Jul 2018 03:04:25 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <soren.brinkmann@xilinx.com>,
        <atull@opensource.altera.com>, <moritz.fischer@ettus.com>,
        <nava.manne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <appanad@xilinx.com>,
        <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <navam@xilinx.com>
Subject: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx zynqmp FPGA manager
Date:   Wed, 1 Aug 2018 15:34:56 +0530
Message-ID: <20180801100457.25614-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(305945005)(486006)(126002)(478600001)(107886003)(476003)(2616005)(336012)(106466001)(48376002)(50226002)(426003)(50466002)(9786002)(52396003)(36756003)(2201001)(356003)(36386004)(26005)(2906002)(6666003)(77096007)(186003)(63266004)(4326008)(5660300001)(81156014)(81166006)(7696005)(51416003)(39060400002)(1076002)(47776003)(8936002)(106002)(16586007)(110136005)(316002)(8676002)(217873002)(921003)(107986001)(83996005)(2101003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3514;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT034;1:JUXgUAyH9pdyKFKa3ty5GAipP54fZHOG7Wz4z7QLusL5ZQZS4kea+9YySS8LVfnEBR3VwWjYl+xBwR7s2EoPVql9jrwuCvD4w7EPTG4S0DjBJ3dnwaKRuz5U/gkHtiOV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7dbe279-f9dd-4387-c5b2-08d5f6cd0735
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;3:tSOZQN5jeFGc4RvDHvFSwnDBsVV4aKLP3Q2Zyk/+NLs7xjfzRZyG05aCVSn3RY3K4kOTJYdZRxt8zdedIHvsvjutdoBydbP/sT225apkgtf+wOXeeQAN8lvCfnbxpZIuqvgptT7pg2NxGbDvpXzVUxCO+/+S1IlmfgGcCkrSxMetH104k7tD5xkAXL3eeRAbF+2jvh6DMlRiFP3kOZgblFHM0WFrrBZoA7fq62Xd/sndnocZ6D47tU7xwaRB4Z2Rzn4zGSzO1Pt2COvC0R9gWmoOlZRAM5/Z2yyEmCnI+6Y4tO3IsS9tyg4WA9fYgqURq/pc3Oo6ktpLVDIpw2U7/ytQzSkb822at0541I680s0=;25:0TtNM0feP8LRq68Tjh915AeNc0dbYJP4jGqxBE3zSea7506fGeLgfyXBmJ9oOYLTBTbP6ZRE2xkramX9xRnguafvAJhsPcuAgPF1oByizzLxFRgMSrGEDzgH40csBiwCYfBW4ITzDsI1G0eUnRrEuEl4pfASKK4gfaXBZif+pbdSrvzBGdmzpc4+Iv9E9Kay5w3ju779J3uDDTuXn+Slv8iB6zIXkv0dp54eFZdQKineaKrnIzAXkS4wh9Vtt4XAAX/PB17Y9ejYmVdXuNPvtauQv4fIK0LLxSDVyF51obgsawfqdlm4+xMrPp5EBvrulAMDo+xxxDCM4rOawc5YNQ==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3514:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;31:aP0ImvAkqRkDLiEOZqwOTAtRYVwjSc1ttRE+rjx9opwy1eN35jf6gdzOyD7B1k+j9+24OIfFApA8cSCa/WblKK7bP1Gz/UYA1q8veZwAvSxjBzpV2jczUYi3yar6eY4LfBLP6PQjE6TMgFS6bYKrg/5Dyjckx1PCaMiugf92B+iP9UehnVdm4QovAIuHa25HniLTWwLHodscGJ6ewF0VYF16K8Pa2sK/iu4Sei5XJT4=;20:l2OuSyTih0tS7pVoM1SC2IMtX33kg1X6MTaOQUsPHT/wtUd2GFbmXC6yijXVTb8kDvGvfo/RU2FRniL9HRhYwdS1BBAcrBqE7LKp3BkHHPwwpZif4ceazqnBvXTbY8Q9z8d2mBYySyltOLKn/LGz6vZWtQmzXUd5vcShq/owryaOSl0z62LXe0/2/RyUdKR564bb0yCbNQFXGhSwsuWgdKUzybNQrsPAu4XLjhRUff/+JCNs3yJQDDexS/W0wVM0Gh/5kcejYDrpe0HFZaW71BZPHnzjy2FpCNDbG5mcuvGVP5iEkL4jsjfZzRcH0WboITtCiHZipxp2CR9WwLCyA4zed7UN6RAcdPPnfUSAboRKzdNxpq1j44RGbHmlDbH+DiY4uLwCZZji8JblzJEWR1xLzpt6PTsq7Gyuj14G4z2UA2hBMWtODcwWIc562xoebLrujxDP3vldgfuOT9jz6d8qpIh9qpS6hGpYUmJs+inxtVhQyqVqw7NYkH/gfk2H
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3514C0080B5175F1EED26AB5C22E0@MWHPR0201MB3514.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR0201MB3514;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;4:9KI1CR3wjBK4vqBZVaYRaf3RhLrkwwtiY/CJyqYzYDLfXo0N79Il1mVPhB9IUaC+Q9lEJMnuzD/Jcmz6FF+aM7D+qzOq+PDjXjYoUZlTID4x/8apGoLCueTXXaCybCaIyeOwUZ+w9iPK3tmxybQ6FWaeNwhRgXuNYhZHpCeuGHF9XRbXS5jx2eVyZxJiIMZu9A3Y9ww6KITzfxP+9sw+WCh2eItXLdhy47rIzX1NWptWenneYVO9naXohrkEPyER9TVoTYx97S6xT4r9ota6NfEUuXnFM1qWMY8Vmg1pxkaU2WCfj1Gt1mQKpis7OQX4
X-Forefront-PRVS: 0750463DC9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3514;23:Hlmouwjb37xDAdVfYvB+TJpl8V987JvgxlttREh?=
 =?us-ascii?Q?NW40y7XfnXMzAm4yzRypU6EMHyZU2Rfb/xYFmvFHC6gR6CV0cWhUqJarjozZ?=
 =?us-ascii?Q?ULaFbKnqOvOqhuXbIVOkkXGvDRdOzbm7BwzV7RXLxbzBN6zAsEk3BF13WcbQ?=
 =?us-ascii?Q?i3YITxCAH6/J68LvtrxECPUeXj+V6utFqpSERxkbwIShqMnwRFI0HZ5KtAhS?=
 =?us-ascii?Q?TQfdhQl1QZHUdNCntx2RWqFO0/wRZSuNZECmKXQx++M1feNKhymD33ZEPwWD?=
 =?us-ascii?Q?Qzph+E8HE9EePoorb3OTIBpBcnOwWrXsdBwNotvmk9QGCZC22aVhK+U87i+C?=
 =?us-ascii?Q?/2+aUKzqIjMIoB0RYC+WnDxRV2VNZOZQshjq9ya37gNox6fdhLoz2Lhkqf6B?=
 =?us-ascii?Q?424gncKvqedTd7DjMlN/aedNNfAhtEzVyDNvuLdu77nlHg70HQfJDCmGnkF2?=
 =?us-ascii?Q?o7dqzdB8IWhbwSQvbtpPEEOGj4s0h+ytnPGPZlZ1BvUQSIneRQURLgfQUiyY?=
 =?us-ascii?Q?DYX7rv/rAVHuCXHASzLrZiXpNoYTNPukXPzztw6shh60RXA0obfuBh4XOgNT?=
 =?us-ascii?Q?WmPQZoVA4m7yzV9yQB1HcHNp2B7uB+3zJ8FSdiay7nBSsp+Bcb07acBJSXdB?=
 =?us-ascii?Q?lOzU1NBx9DF/qkgSL9+ajDI2QjNn4u09pkWkqtd6sGSoySLH7EE7t4wJb3vt?=
 =?us-ascii?Q?9Jn541YLOyUewRBwxEnN9OQXi3gPJ8J6ujpXzCuN1bcV9nbGLzw6U8dpakj7?=
 =?us-ascii?Q?IWegpRodT+637qGnq23ciqJw4Yf6i6osgEFevCndLV10nLE/yYIU4zKJxxsp?=
 =?us-ascii?Q?1sfw/oxY2mBaH5T/UXXyX0YvVk/KaNKYf7Oa8x533c/BtLnssi+brluWc4Wy?=
 =?us-ascii?Q?ekLryEJp6/QFTJ5ZMD07ON65ak4WVztZ2ZGDg67Rdu0yj+GLJ6+bHTpJRpxJ?=
 =?us-ascii?Q?zIFZzcdeHdURIktfQeEO9XW0hZ17N/BuavybbzNfiV+zFd5MSi0g+TpsTqAn?=
 =?us-ascii?Q?dVi7UdjoxYxZPkI1wa5zwxywbt2rW9MQB3WuO+wsbCtFCzT6o2GS+zVnYl7g?=
 =?us-ascii?Q?Ovt831uAOE4H7Ve1LntlsuSddxtIAiTOe5jX6G8fnLI123IoK1GdBd0toT/y?=
 =?us-ascii?Q?H26E3GvtIM8qPXvUSZcDgtXZPAmTrgQvWTqo9WXTSxIof/92hLjSm76sHJwl?=
 =?us-ascii?Q?MUFHUT8MGpGuY2XyQsqdvPn3asPSd+t23hRPYeeLdwm30OrCJnQz8ZXPl/U9?=
 =?us-ascii?Q?WPXIsh+ixBuyLjwWTXvg=3D?=
X-Microsoft-Antispam-Message-Info: jvniMdTq9DgVlPIK5FCxnrrx2ENWxUDB0pNTnJdpeVv7ZJwmfQu2Z1V8CX5kyNmIHL6m+ui6TL4sIdt+jFHKpthOTrdlGdA4P0jjUXS7kqjSmt3ZfKJTjbt4Iwz7MrbFM+wYr72PFCcQKuvs9rr+G4HC99nKASU5SEHvRSJ1CfFHG7AfAehY1D+sJrvJTlSLbJi83/vAGQpQUCXndncRwuS8CkqSAjjhC5cpPZiCynQFyTZF29nzxW1y2qH/o3ty0a0U18vugqA2vVwrR1ets/P2nOJNf1xW92sQAepueFNadd7fFKm5Vedfhn7Xo0rb92CKzv9trMrRyZz984q1VAZOj+614hUZtOq5MlPMSfE=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;6:QMt6mHPJv5xG1DkFrpXHmCACnIkD1TJAgOzIe/oPtTaWifjhlPeOQFyJS32kchhBHR4RuNpsXjr5Icwem/NriHnagyAcI67dzy9kceNL/04VjTBzAug+bak59enQYTxWzW41VBin+N3do1VAglv0yZWQ7iDq94JYxWLMiFq0ZQYvc3z2CbAZp4EpEGU65lVi8FgJCGF86f7nAiEUGgyr7V6e+Z/H1Z7cD7RgmOZHcaokDMiG9rjt9AID1b4j1UTgZ9ZvAJGpq/WvbCuC+BD7EJbeVW3ZmBYOQ9P/iq/t6u6RGJJPYRrlazIiM1KdEuVc+iDqEvE+bEUxPugLQ0IsHAp52uI2lfox2ZjTWfIQ56oI0Kt+0IXTHZg4Zm86yub7lsRFjifppJA1tt5vqkWIu8Sa4jb3+j0Pxo4kPR+94jeBYRTEE/4s/zqfU3NUmam+T4qtxMG1o6TaQv0dRLmkaQ==;5:e1ehZPQZgICc+pdtU5k0g4Q1N/DTZhEqmZRQQWr4d91bZz+RqRbG6MAOSwD/iVSJVGplik8FF7alnF7V68SUWsMlV9sl46QFSTPd7gREv2MNY8Egzv96YNE97Sd9nRSgS6KnPoGNAHq6AUi3vEjSN3X7zWEi840m+kFYGSRjHlg=;7:nXkPGW1HUTDELjO8b5n+8D/7N50H4iMaMADtkJzoufZodCZv1Y3QsgA+Cpg+6599afgDEfGj9JD7oPEOuxFEnGSiuprT67iIv4/9eYih2k3Jv8FRpK8o2lytIaAX4PeLVGw0ikpPXqCbVIVYNskCzYZniV2WdKzKpJ1ZTdMuehRjR+Zvu40/XkLumhozoU5SVEizWaCH1DU4eWj2qA34ob0sNJbzkZikeApf4N/2no63PpPfjQEU1oqL3bCwlzBj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 10:04:36.2797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dbe279-f9dd-4387-c5b2-08d5f6cd0735
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New bindings document for zynqmp fpga manager.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
 .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
new file mode 100644
index 000000000000..0eac747747f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
@@ -0,0 +1,9 @@
+Xilinx Zynqmp FPGA Manager
+
+Required properties:
+- compatible:		should contain "xlnx,zynqmp-pcap-fpga"
+
+Example:
+	pcap: pcap@00 {
+		compatible = "xlnx,zynqmp-pcap-fpga";
+	};
-- 
2.18.0

