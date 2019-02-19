Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31561C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D1B2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="KgScEmvb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QmWJoDFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfBSQGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:06:19 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54572 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbfBSQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:06:18 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JG2StA006447;
        Tue, 19 Feb 2019 08:06:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=amAxK71xGvlbN2ODYKdMHfVkx9mr/KuPoP6csszdfEU=;
 b=KgScEmvbUrYkmQ24l6cix1/EwFI/BhMtjF3kspbQSGfzjeYvOBawC63d/0gFq+d4xeh4
 ZlpVA4DN3agshekLl4Rm+YjDNtNcLhkumWoLcIWON8pVgrz1PBwvPsld1zT7ULvmdmTb
 FbFYKXLU7KJdD5HOE8ZSXdduxBpFSp87VrPRc3RGil9IljuEZilr1E/8rtlzP9GOaEfN
 zqaqnUrqaSPFm3Rr0DE6BlYUPP1EUMBAWI6xJnxm1YhF1EP0IhClbjpzOYPHkRqsAMCG
 Bfq7qVKVr0jh6pl5qYNvNQdD4ja0ltiGF1q6EyeIIwYEUjyUeNh+CaRXc1wjp+4Mx9iF ag== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=tjoseph@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qqt6q5je5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Feb 2019 08:06:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amAxK71xGvlbN2ODYKdMHfVkx9mr/KuPoP6csszdfEU=;
 b=QmWJoDFAecuk3dq5N/Rex5gY8kQvD52QG58ycOgdvHBuA4WKveGQayggf+t898a6weBEj/MGxWFC3ruADyxaNTE+jRD/sOt6b99SwQwO0irxC1f8GI39DTg6xfnDJ7bfRoHcP3Tq8SnaGeAefEU6nJLxD1mBKWTk9GqJsvYmBGo=
Received: from BYAPR07CA0006.namprd07.prod.outlook.com (2603:10b6:a02:bc::19)
 by BL0PR07MB3971.namprd07.prod.outlook.com (2603:10b6:207:4a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Tue, 19 Feb
 2019 16:06:04 +0000
Received: from DM3NAM05FT030.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::207) by BYAPR07CA0006.outlook.office365.com
 (2603:10b6:a02:bc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 19 Feb 2019 16:06:04 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT030.mail.protection.outlook.com (10.152.98.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11 via Frontend Transport; Tue, 19 Feb 2019 16:06:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1JG60Mn011536
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 08:06:02 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 19 Feb 2019 17:05:59 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 19 Feb 2019 17:05:59 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1JG5xw5005430;
        Tue, 19 Feb 2019 16:05:59 GMT
Received: (from tjoseph@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1JG5x53005413;
        Tue, 19 Feb 2019 16:05:59 GMT
From:   Tom Joseph <tjoseph@cadence.com>
To:     <mchehab+samsung@kernel.org>
CC:     <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <arnd@arndb.de>,
        <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH] MAINTAINERS: pci/cadence: Updating maintainer information.  Removing Alan and adding myself(tjoseph@cadence.com) as the maintainer.
Date:   Tue, 19 Feb 2019 16:04:54 +0000
Message-ID: <1550592294-1768-2-git-send-email-tjoseph@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1550592294-1768-1-git-send-email-tjoseph@cadence.com>
References: <1550592294-1768-1-git-send-email-tjoseph@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(36092001)(189003)(199004)(126002)(476003)(14444005)(486006)(2351001)(48376002)(50466002)(11346002)(446003)(426003)(36756003)(105596002)(106466001)(2616005)(222073003)(26005)(356004)(47776003)(186003)(51416003)(6346003)(6666004)(107886003)(305945005)(8936002)(316002)(50226002)(42186006)(16586007)(54906003)(246002)(7636002)(4326008)(4744005)(8676002)(76176011)(2906002)(87636003)(478600001)(86362001)(26826003)(5660300002)(336012)(94303002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB3971;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd09c58e-3f15-41ea-f37f-08d696842660
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060);SRVR:BL0PR07MB3971;
X-MS-TrafficTypeDiagnostic: BL0PR07MB3971:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3971;20:4mK+4VEx92oCX7du7R4lnEF0/HuIgw9LtM7RdeS2AbvzyrjcRSj7xzKvuezoX2ZEolzKk3f4I43613kvBVxBn/Qk2qaaBqCx9JwfwthyWhjPh3IlRISEx2jgYL5esaLmUH3DL/gju44cMOcjoFYaJq4TuDZvegqSO6RU0ZUCefXAb4ESV5HUKkB0D/c8vghU6PqZjtkJ8Rp9/H6LXIttWdB0tOQwQiJ6lKfoFRvUKxxc+Xe+Yx360zR9mEj9hZsJ8E+FieHmZ7qQ4jSwdtLe7OKLtwbi+IhUQr2XXpyQdPYPyduLy0qE6wVMlfZiobk3vwgxARrUtzUCBNVO7PqFM9ahCCMFrqgCA9Yc5jpQV/adfMaAJbW8+yz1GGfvCFwUpwGYLq9KVr/NdgAXB/HznLG+wxBFA0UeF0E6MfWhsmQ7NMdhS4PdVnGykHJ5H5jsf6F0oTH4tE/ddbmWjhC4ZXafd3wpHS+MvWZUJYFXGwmvkb8tB8IZXMiGGDq0Fhyw
X-Microsoft-Antispam-PRVS: <BL0PR07MB3971B6513523EAAC04995CF6A17C0@BL0PR07MB3971.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR07MB3971;23:Mz4zL5nWpPFmHB3iB2FhLVjZ1yUDpityeyx3Txobn?=
 =?us-ascii?Q?lVfppzJJrJIZqcYluJYiL1BKTjhf4PE1BIhZr+yuyyr/1R8JnTaKc1PYe63a?=
 =?us-ascii?Q?yloe7wMOOizAPNvakZ5EPCJJjUyovN+3ZUPEkO5Z8z1xS85a0uY4g0AUbz5N?=
 =?us-ascii?Q?DV+uL0CZhUjgq+tuOwm+ggp9zyxFp/P8+En5tBUHTM9b68pVDO8nbRod6s1f?=
 =?us-ascii?Q?OAa8kfgRvSI/smy412twcD0afliElb5dHJ0R9Ew7Ri4p899/SF4iRZeiqx4+?=
 =?us-ascii?Q?l2aJbILfw8CRC0wzwVyWohNkZXVlB8/RsG6DmyEjDTjUUQxAoBwyLswRDDH4?=
 =?us-ascii?Q?MXYSNOAWW/MH+wguyz4sBR8rl6auE35YpaA8A/ESWZRHgLrnAy6SUN4PMg+l?=
 =?us-ascii?Q?w6KfnQz7y5Gc0fKBACH5lXSysV3ibLbFtdDReKqMr8heuSuw59duJc3v0ApY?=
 =?us-ascii?Q?uEEsgcOOgw5iZ9IW+CnzqQR2x7lk3d/J20F+yRueQjZhqtVFUTfS3H4bAOpf?=
 =?us-ascii?Q?9ZkM+I8qB0WJekOK39rT1AJzyzSIjAUxuEjEY62O3rr6xiX/GZvOHsqoA/WS?=
 =?us-ascii?Q?+XGhzEiXvXK9fUCM4NQCw+01wyJ6nMvyu7bK9ZITnyyQHBGtFpb5HDxM3DEq?=
 =?us-ascii?Q?0g4YfV7LZ65P8nGuGSegKAMAER/Lc9rJMq9ws75kHilifAiH4iCjiFi0S/4T?=
 =?us-ascii?Q?wWkPk8Ok4JawI8TTLic8EUdxSFtwaM5CtooW2qi1C0WxHJEyCb1UsB8bd4b7?=
 =?us-ascii?Q?dRFxUjvBhFl8Az3ADMExIgzcxozF9L1+T3uKD3vr/J5nt1+GB/7pY5h05jP1?=
 =?us-ascii?Q?Zv3Gcfe6JV3m8NNF+YmMiwQJvzuj4NCIO9nwVnb2BsDdWNiYQjbjSrhGqqle?=
 =?us-ascii?Q?uXgSjhwpQ4qddbXe7I4Xlfc0lBmTca+MwfwQGkOdeRYqfTNy41BEYB6kfN+O?=
 =?us-ascii?Q?/LC1cXlqHwrp7OvjAjmyvLn0Wd+WjP7EFGRb80qZ6ZX7uEzCfKzXESCbwflc?=
 =?us-ascii?Q?oS/ZJHYBFbjfz36nQOzErhWxiboKV37FZ/jO3acalnijwmuVQrByhbHgq4UF?=
 =?us-ascii?Q?BBlYVCdvnvuoOE7p9r6I8+rDKIAt+zsVQ3KijRwxd5ZnhBffTJ3aA4qsUAEr?=
 =?us-ascii?Q?6Q58msJGDvzB4QVwzo/gVwz1z8Wk1Ujs+aV81y+4A6qLPeVcDWJAg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4JrfBUez4QVHugMEW1rc0dAcHFCnWYLeEIAC+itnmevkM+Di1bd2P1rkvcLT5+KdytcKcl8QisRW9BxK7wDV+841vI8P80xn8sypT4zF8zr8s+7UPuXp2+uUqd1FEKfP8ZhiGNc5cIvSrlbE4crA/vE5IsmvICD37J9KJE6ZlCvfb2xEv0Xu2x3QkzrkI2DYx8XBNhGZsCYGqSw7uBb3odChEvNitUfkqa/E4pwoZbYKrWjTZidYtLywkMIhySjVjeMd77XjGZCXW0kwcAR+VxNYOzdDfiVTeExpogWWZ/laWTxcjYuBv+g3Dv9pTtxMxsNZrMYEcq7ZdgBhBT6xoyKhBqcuNRphGjpcpe8l2VJ52DNVJ2kLj4aUiQNFJT13kWonbOHGMvXAfNWxQemo+j79to6RfraQVrWYr3KJbA0=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3971;20:kTQVjggp8W1zZ+xDccxtUnBKXjo9A0uDnilxmiiyqTxpVZt+Pe0vTddOVT3cMo878Kxu0yWWsr6DobyQ9zJUFkmEn2bho6ubx/+fwKCmB7mKaXWWZ3ueD53W4b3clN/FOqxey2R6EG74RcblqRCrkW12qWHUFzbGdLoBqOLYeaPg9lrobxkNIQTnOhNqO4/RfTJzQ4nATqC4RRPuntC0kKcGlA7/NCC9RA4jOcbpIRTgTvm4AyW6ZS/zJuHO+lMM
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 16:06:03.8607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd09c58e-3f15-41ea-f37f-08d696842660
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB3971
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tom Joseph <tjoseph@cadence.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41ce5f4..7938e3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11592,7 +11592,7 @@ F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
 F:	drivers/pci/controller/dwc/pcie-armada8k.c
 
 PCI DRIVER FOR CADENCE PCIE IP
-M:	Alan Douglas <adouglas@cadence.com>
+M:	Tom Joseph <tjoseph@cadence.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/cdns,*.txt
-- 
2.2.2

