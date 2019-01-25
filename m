Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DATE_IN_FUTURE_24_48,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13ABC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962AB218A3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="15m1bTs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfAXHq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:46:27 -0500
Received: from mail-eopbgr690077.outbound.protection.outlook.com ([40.107.69.77]:5728
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbfAXHq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKUsUA9BTsA28e3jId3rpePazpRuuGXqT+JTRXulp9A=;
 b=15m1bTs8QtrdrBboiS4aQuV2tntKOuS7qGhBazlajNsP4ayi6tBCApf9qWxF2ecFc3dcN2860VCs20ASDNdS5USk1h1hA9qKg4LcRWBWelx5zxwcFudzVvIqyRj5r6ndfupvWIu8BzurVGgiMLoqVE2iVAUZJn3Kyoalni3h/nk=
Received: from BN6PR02CA0081.namprd02.prod.outlook.com (2603:10b6:405:60::22)
 by BL0PR02MB4323.namprd02.prod.outlook.com (2603:10b6:208:40::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.29; Thu, 24 Jan
 2019 07:46:21 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN6PR02CA0081.outlook.office365.com
 (2603:10b6:405:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.16 via Frontend
 Transport; Thu, 24 Jan 2019 07:46:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Thu, 24 Jan 2019 07:46:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:48945 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZiL-0007er-8s; Wed, 23 Jan 2019 23:46:17 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZiG-00070q-4N; Wed, 23 Jan 2019 23:46:12 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0O7k6Mt028309;
        Wed, 23 Jan 2019 23:46:06 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZi9-0006yr-J2; Wed, 23 Jan 2019 23:46:06 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 0/3] Add reset driver support for ZynqMP 
Date:   Fri, 25 Jan 2019 13:16:51 +0530
Message-ID: <20190125074654.10950-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(199004)(189003)(50226002)(186003)(486006)(316002)(4743002)(50466002)(6666004)(356004)(110136005)(47776003)(16586007)(336012)(7696005)(51416003)(2201001)(9786002)(36756003)(39060400002)(48376002)(478600001)(305945005)(36386004)(106466001)(2906002)(4744005)(2616005)(1076003)(426003)(26005)(81166006)(81156014)(8936002)(77096007)(8676002)(106002)(126002)(63266004)(476003)(921003)(107986001)(1121003)(2101003)(83996005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4323;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT011;1:zonyk9aXJLmHLpKm+R37GOU5aIhO9WjdFKZZyzZw31EeR0fJ/OxF8XISZ8rSzvPF5IXflCfmxlQpxrpF3lrgPtJqb0XTspt2k0eTBUVyJuRiPAyg8lxvViX8ubGID+ZIRCiGpln9DfmlVOBFC7O+QuK9FnGg96nCGQXOsMqeRNw=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b7fb035-bf06-4e87-086c-08d681d007f7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BL0PR02MB4323;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;3:KmF6RLApqU80P9ZXMiwWfpsOhF/aF4YmEChB0VMACRn1wN0U0cBXihVUwcVYm+SBGrvAUwCy0HQBoENSe/dxL1nYFIIt7aDbwKXcQVlzKeMuMB19yVkLTiLlFN+atv2h9JMKwbT809eQXh57zFD4LDUh9SJJO2ppVPcdV9Uz4nhXS0MKVwN9+dhyfb0Ci7nJu/8NQcYsjRdI8YvztdvMurVxRa1l9aIQtPjIem6J2IvJr2pM76rzCmMTBk6KnrBsFzeaWIO1c/0dd9WwWsxuNqvTkfhB6paGnjx+vC6WlWm5vQj+8YByS+i/enTmLxKHhUqi8Bkptqmu1s+D4KFZ/bbltBXUct8DVdeEQOsmvRB8GWLHriBOZ9GTqeY9eJhE;25:YtNdhVecoyZaCOQfB7Q2DW9c27I79uKSLnXXlfvLv8D6NQMuYSPPryMgWomucy3IhlVrGOLJYF+VY4+Zv1hutf5HyGAC5VAb8EAVgVzgoEUuBU2Jb+a5Q5WuzndmNKMCqhdLIUWTpTJ8fbvrXuqBjzOXifQ2EGgg0KioovRzzbgwl/HrysNE1+L/H+/U9rkTPX4hL/eXqvuWjzJiUQEs3qUmx+AFIVse3uJ3EKKpi2YCirpL22QYYcVCejP4u7zICrflnhrpLEa/jLgm1tUVqxR5hvIus8JzrLrDmYs+KchWPC1ypNdHUgat6QDaQnEGf/s62pB88MM3jxqSeVQUFA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4323:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;31:v8myLd/AZ1FcHX9oYkshi2wxDmfpd55d7UePZOt22+LteaelVQa+lvvd/+sAG7zUvY9yC5SF83jEa+HF3LxX5sdYG29cMfX4aUZqDRYWrTlyGlHj0PAz2pqyUYc7Iuv1jNU5VLkO4ULyKGloz76Njz7vBll/qVMUvM/I7rRZWkZcNFOiMVdgEbaydPWV2r0CHGesVh93ZtMHv9//UrL3Qlq1DxAFmWWvD2zqPtE9ncs=;20:2oo/5wOMHB1IU5JmEHHGdcHBxqYAcJlX7TC9Ls3wCPuFtYwROlI/QA2+Gb5d7Yi3bVAi9IrTvLKOzJPtGdCoGtU2Y1BkAREQ3r+GCSs+37gaWypf69aCM97EvzpI7a3RELFHhFMjd2y/OEzY1K2uHV6JEETC+9BaJzfmDDg+Q1hsq07tv463q1wk+QT+F7I9xrGEZshSwdJVHWTMiHa1uclpiEpvJaUbMxk4gajZRA2/3G94BCLbh3AeX80g9c9Sn5h0ocgkC751XT18vHbM4Ac7UEgWVu/oHH83OAOK7tjNy5zlyiFzlBI0wXR6F4cshgXwaaG8eRTr8QpgP30rpuExi1y0aLmaByVSg8w0+ooTYmXYp33H/BHfNkGvqp7nBT08jGgQimEooIczdmAtl+HjfSqfQqUf1nHIQlYQuF+RKVaKJD+BBmveg4ZZkIUoe9doyfq2jwQuLkNJkt0iFfXDIERGYxkzd43CURqmK+L01/3NRDZUFS+yCNBp+rz/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4323D90FAEF6A7CFA32C5CF9C29A0@BL0PR02MB4323.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;4:PasI8nOmAcRx/GsIM7g7TSt9VROowoz0meFenFYhJlcfms2Rj44euvnsex3ohP88aNUPZxDXSWK0hEibfx9uNOjf7ga12qqkhNB3om+qbZ5Tdxw4D/nAc0ZDmfi7GCLzpCeioKf0YomNUjiVXi/UXveclO0Tqma7UifrwTQ1Wa2DieaH+hSdCq50P4s67rnhgoG9T/6gYWhRBbH7CmEJHsd3dd5xAFYjaGxrBqW68R5FydJL3HFJdO/VIjyrH+YhsnQJ05lmB4SxX6UGGKE/FL4V92L15LvS3LwPTHJWi7xClRForP94aYrv+69GmkCH
X-Forefront-PRVS: 0927AA37C7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4323;23:TXSzDpW96RSlikRbVwxpAwMQzvB3JwOM84+8fpAdu?=
 =?us-ascii?Q?+4duNrLV35qVVRQvt/A/cbYjXa9c1V/Gs9PJ1GTu9aZf1xPuZ7SHV8T0+Vob?=
 =?us-ascii?Q?nkEdICNyVVaVwMb+9HPPYCyiWFS0tvt7uIps1I7KUeDrRBRuODcionkXiGXS?=
 =?us-ascii?Q?JPT4PAKbzP1BBaylXV0v0YHy3DwWnlNcow5MCt8nNhCCD123r9p01uowYoP4?=
 =?us-ascii?Q?iedU+OwF4haBsV2LicQwqCV7X/Soi+DJmMNGgD//1TuupZsSurF7Ak9+480N?=
 =?us-ascii?Q?nIeJXPBy4mTZ/NS9+nNmqy8mZG0JFuT2JCVADUrS3k7dPiPD2DBpbQew59Eu?=
 =?us-ascii?Q?rzIjvkZemCy+8adHMEHIOqr61cW9uA+JMKgcCJkqACR+pyzxNnCTNp3plByd?=
 =?us-ascii?Q?RdJfoHMchCuZTvobgGUOY8OootNF9P6MKyzT6zHO4Xu8mm3CH1I7O6zLMlbE?=
 =?us-ascii?Q?7kyHneWSV3lchLmytmiu36t/K5S+BaPeJxrloVpl4/ZmkbMss+6npZiYa/KQ?=
 =?us-ascii?Q?Yonf0Zh3NaT/6GaYSilmpZ7OTB0J0cPaAti8XewEiQ3DFQ1TqsOsPip4m5B+?=
 =?us-ascii?Q?zdJZtxXw7+Mjz12AlACtXRfVdGLNFYeOHIYYplVzn0cpRPRutBk1s0++KUXN?=
 =?us-ascii?Q?sUzSJQdKiZjLsOh/+qbNXI8hUhfLRoQjUtwcKbSX5aDR/mCZes1bRbcP1aI4?=
 =?us-ascii?Q?U1AvEXKG4flzSWhI5JYtIT9/g49iTNmoig+jhNPJ02oj3oTApFHSOwAlnkWn?=
 =?us-ascii?Q?xc0afFZXFG45qDUssfDoAK91j/6DLdYENvBUAkPjPyBwZSy/dEperNd6OZDy?=
 =?us-ascii?Q?Gi7Ud+9ta5Cuj+YdENZDHv5cyHHEv41hCbV0Xsi1l26gmlkavusZzXLUFkFD?=
 =?us-ascii?Q?oyw5XZNrRCPv01jXeVHL4slGoFmBbYo5OXDLiJfwFvFhoNUlBBjVPNhTxz3E?=
 =?us-ascii?Q?hvmdkdq5GjciD1vpIudC8lAG89u1nBf4gkmS3sUJyPnmBZ3wmAlBJYCdjBi+?=
 =?us-ascii?Q?zIDBmZfcEnqbDk/GK56uElETzSf7lIggYiW+b1UNFcDR/WFdDUX41XxZX3a5?=
 =?us-ascii?Q?wNvfxXOU9a2wpx3xixRiO8ixwcyRCk7cCu0527dneu1SQ0wGMITkFEDSVaPy?=
 =?us-ascii?Q?kcT9kbPhZdUwx/ng4yW9G0t4LgA1q0E/Qt4t0Pl4akmlZYaAzVOyg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZEllK1dHmCD+PfzoEjXbsYY38OGrXaGWOw7m/9+a0gEBXdQ/j6EBF1h43j6nK55jp9ci9JEoeMhPV7/mVXtrn9g5rCJ6bt3kNhXXIkZ8eOQcBU1LCoD/2JZ0w2IQCpCoBWMKQVC+U7Acda8ah/MVtoUx0B/BdUfguGfvC5tkTjQT3XOtmae4KFAmlgc8kx/c/YAWj1hzxoqOvnR+YsFuKM3aKrAPWqoXxoUM3WkYfMY8vi7BIwuRItCFrhvuw6R/Yyc4D/a643+OYzIrL70SqXcQJOa/LBhJxFkgK86XYdEhmzkXSBcJqdqr9joqWgGVZqyLNlbjM21jSY7EFV77c43zVTP5W+3kw7e/rq4vFL/jgCG0PnPVukMyLLsPLD2Tde9JkWQH/WaEB4YR1slAp8MeoPh31Rfo/RQ09iYTW4A=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;6:G+81AcX06pTmd0T8r3jO5eRvc1zfX5iV/dlKhyBKPqUh0b5TPpt2g3O6V/K7jqvgcQJQCVmAqqTOp/AcVE8+/TlvyRPzpcwM/GIwqAX41hu1BnDCVZpeGIw0olx/RVZY8C3jmfe2vzGbtXhY+IgfgdoPw4iX4ETn6Tc8tYyJA6BovwKtCu4/87NBCElg7GyrfpF1sU5yWub+OcF/8GXtoWReJogrEzVSCu4GCMNYu3bMzDgsSIxLETZOdrduWuBsXXLgFU0QKcFsMshq3a1r+XJ8NxuXPHHL5AQR1J08QKNazoWsjWiAsyxsePKU/eGxnPEnAvgM93M4WKFqa4AlpcvhzPXJaYMGmE0aNlPbVXjdAFtOeCPg1STqux09q2Os3T6rFM91dz2UJmYuP1HFKWflYQ5Trp4WOjhNg3S7nEYIIY4hoL+IKVyvvijVr5NIIczZ6IKg/dUD48ky5VFhSw==;5:ud2fpR9sx4sN0aeLtC9rcet8Lr5KvcBQ7c/XKJyABQva/AERCahKK8icMdhUkDYgu3qzpRRhgJyLi566sYKXq1/SXUd+4ax43oHZgKblWZWxOSDJqRGO21pNkVQFTqV6GkPoZHcqvDSjWipqPHCGr61+CmAJlvZAk4pAZ4Pc/VuGmgUjzi3gJplcCpHM9H9cjI2KLsWtIO4rFjVl9tyUnw==;7:cYMUV5Tr+NpHrD5XW7lIpaKQmDNQBL312qe68ZIXilehHfCWY+Ho7D5MYC7SoE2uJLYiLrfpQA1Qmii4OkmOnW62Se/naZwpqQ2YgbnqfTFKGRtnYOw2xYBA4mP/zkeu8Gugdp4Ah3mnl69Ns8GrwQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2019 07:46:18.0376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7fb035-bf06-4e87-086c-08d681d007f7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nava kishore Manne (3):
  firmware: xilinx: Add reset API's
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  reset: reset-zynqmp: Adding support for Xilinx zynqmp reset
    controller.

 .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 +++++++
 drivers/firmware/xilinx/zynqmp.c              |  40 ++++++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-zynqmp.c                  | 114 +++++++++++++++
 .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          | 136 ++++++++++++++++++
 6 files changed, 473 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 drivers/reset/reset-zynqmp.c
 create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h

-- 
2.18.0

