Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A31C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF2D20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qQGF0ilj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF2D20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeIGLUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:20:47 -0400
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:18669
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726250AbeIGLUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eci+XudDJp+SyhvLWtKwuvu3KGuNZTRfJX9vTyU3Kxg=;
 b=qQGF0iljCa0/4JL9HXH2ED1+2kxOsT4kbOFXbFSCM7+6gdl5MNu874TOCxe6/xjUgP4ma4pjKu4EZZKKWu8+StgsbLI8VQ36DdemIvHMycB3DvGx0gNMpzOUfsDIiDI1hG01uhu9EezeiicHKJachBaD4vJn9BSgKejyyRcA2XY=
Received: from BN6PR02CA0027.namprd02.prod.outlook.com (2603:10b6:404:5f::13)
 by BYAPR02MB4935.namprd02.prod.outlook.com (2603:10b6:a03:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Fri, 7 Sep
 2018 06:41:13 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN6PR02CA0027.outlook.office365.com
 (2603:10b6:404:5f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Fri, 7 Sep 2018 06:41:13 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 06:41:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:33475 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1fyAS7-0004WN-UA; Thu, 06 Sep 2018 23:41:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1fyAS2-0005v1-Q2; Thu, 06 Sep 2018 23:41:06 -0700
Received: from [172.23.64.20] (helo=xhdvnc120.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1fyARs-0005sK-E6; Thu, 06 Sep 2018 23:40:56 -0700
Received: by xhdvnc120.xilinx.com (Postfix, from userid 23151)
        id 92C52102284; Fri,  7 Sep 2018 12:10:55 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>, <pombredanne@nexb.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <saratcha@xilinx.com>
CC:     Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [PATCH] crypto: Adds user space interface for ALG_SET_KEY_TYPE
Date:   Fri, 7 Sep 2018 12:10:43 +0530
Message-ID: <1536302443-18380-1-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(6636002)(305945005)(478600001)(107886003)(356003)(26005)(6266002)(50226002)(6346003)(186003)(106466001)(14444005)(5024004)(52956003)(47776003)(486006)(81166006)(81156014)(476003)(8676002)(44832011)(426003)(2906002)(2616005)(126002)(50466002)(48376002)(90966002)(8746002)(63266004)(1857600001)(36386004)(8936002)(336012)(51416003)(4326008)(106002)(2201001)(575784001)(42186006)(110136005)(6666003)(5660300001)(316002)(103686004)(36756003)(921003)(107986001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4935;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT030;1:00CqEbW7qQMpLq9mzaaQEN9YwYllPsbe+purcLzlX3kAbz+UBe4VUt+JRO4YBDWoCjT2M9R/59TowB7GS+D9h29ZprDPO4Kgy2aFqvdqCiWymL8jd3nT28mwXTHOhYi9
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1942ee5-7241-43db-3513-08d6148ce757
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4935;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4935;3:23Spk0M4MHKLt53Jc4PnqRSHpf6otZ35gzUfEH/KYQweH+toWj2X43TnHUtlGQKkVieE0XDH+xwixeKJA5oiLOJbhIiSHai8nbtQ6zCc6VAAzMzUHG9ZmkseNjFpNm3YFYQZrcr8WiP8T23La4U+EF3CoVNKyA6UWVwF5uV7DrasCl6Nsq3Y3e65ViSUn1tqM1ygmISCLTE8WY2lQUB8Pg3HosrPkSz0Rl4Tu6BPwNjmxrWzkYMKGMT4841LR6sbRM8ccDC6OQPMkQ+d1wZblKHYKBLem08y3JHr9j14Pcau90TpmQ9Ht96R6/mHhHoIqkMvawnu1Uyju+1DhdTfYNemqPOHyCGFwjX0DHT1PTA=;25:bCbD3nJwGEjwFkGl3R5G4AeTfvjwtiUTFtPIwvVd3VG7lxV2xAPzDo/j/tIzPytUoUaUrsDcnK+vZuj9W6FnKZPee/g87lyBK6jjGGbhwA5Lovqilxq0iLIqqvqhqwe7torxvABFSf5pw3NXN5vequiiQRqZ5chibSiZ4kiVyU34flsZow/h1TanlVFksIAZsWKJ4/0Wgi/DVX59gKiYUFSIK/P7K4a5qN3hEJTiQpaOpLMorC81G9MTapURc0QXrjAoN6fzLEW97ebjfqGDQhzDvCVqhltO9Off3AyxALM6bWTofpk6vElCTrR2G189spb1S/G8c+Aht1BB12DzEA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4935:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4935;31:Mz2pBhHXErYwxxM1U+lGkc7y3e3nK+BHqc0uKYIkP0kPn5byh+pVuuX49b0eXi+xwR4igINxzemKMa1K6qwsV6oCrLvYDJ0h/cMP6BlLiLMrSeN/NF+dh6bTa57Wed+5F5MpWvS9pwuJDNXNlakjcmoeVUDJahcFMkAVJJa+Xu3hIIxlOf7fDHvSviYcbRkt8IO3pj/EP1NcNnTfMyWYZl58Z1deNDKXsiV5mYJO77E=;20:PEYsxOqrKZIZgi1XLsD2WLYMyFfGhTgvtu/4J0uH4SaOWL560fqhwNCxwSg1R4PUXauGLd61NOD4cwEsVEBD/PYANa9ajLsVRqSDmBrMBX2z39GTVHQ1/NZSJq+WYXVhDTC7/di9HGwWGcU4CJmQWP+GCIU+AHFWC3bU16hfCuWhlTjAR3unDO1yZwXaiLD/OfHmlXHDet42N6nXX1tvtJq7CPkjwGViEtVzDWfK9cEnNGvG/zkkeshqbz86l3uSgYCaPeMvtZrK1KWBVhze3ar8SCG6MpoRM0VpafOvUylW7y22dG7ZWKPk1rMKehvoLCcgPKT457hNaNAhK0+/VBp01Mravph98FRlkLBtT7GZr40sxwDS7wjsERy3JR4oBFpjmgObcypRUnn9/UVPEdGLQiDCZMP8cfmCoEupewsnJzf+Ug4r9PHBAvgcEj5D/PLcfgXXyw7GXZFRYV8LMwdJwXQSwtZO55qbfYtGws8YJmVdzalB0Fc6V4wlyE94
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4935C50407335F38E41B91E4AF000@BYAPR02MB4935.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231344)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:BYAPR02MB4935;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4935;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4935;4:WCMu3FxqMbwZj6BPD2XNKCAjUFjN1cuoUSbSI/YsS0+PexJ449QF5vmT8N/KmyQxPxukTfKGjCSPEYRBteHA5kPe/rrBoPhvxEKFbTN3yQb8j3Gy9CJXU7CrhNr9PsgolXGuDqxAx+1aiNyoIMJFHXtw992Xw+DzkNkhW+bTqgPL7H7NfIp0owyiI/ImXPaCHxCJiEFNBjYIF6MD3gqF7cuz81SNXjbjtGnjO/vCHSLtDHY3HsBqVeJNmE5/USQSLy72AxkzTBovqwgU8eMpEmlt6THAhxbT9Mwz4IJg7ftUjgKobMYil31KKl3EygtR
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4935;23:zCjUHp2NaGE3gT+PxlZaUHwtoKvIuWzP2rV3wmafU?=
 =?us-ascii?Q?JHtGV5iy73vp9lPSVtl6B8x6aWjfSsvtrGknh7RMk062W6whtSIjvB6rFs4h?=
 =?us-ascii?Q?moNZUM6dWQTBh9aIBCMdiY1C3QKnA7yEPl+1waWAcAQar/gEEtLeZ3m2m89b?=
 =?us-ascii?Q?IqEylET8akwQgBf3zjN6171OepAbcCCf6v6NHtfYVE9swkOtkQJ6YCatAIQf?=
 =?us-ascii?Q?EGb/nGOdG4lCjtO9EBdylkebe1p0nyW7Beos7tHl4Kh3vMJrABieEQkQ5Pcm?=
 =?us-ascii?Q?VSGzVWuQMpFwvhGa2OZNshnLeJHOB+4rcEESvCspMQGUX+L+1hycBVWatBv7?=
 =?us-ascii?Q?GjX204gjYC3KAbdtwqtyG5cPTi6Uy11KWbAVmiN0FmhGWMhtJ+BvBTDm9Mel?=
 =?us-ascii?Q?FMWR0ZHNTULaArJ4b87pg+uOhYWIiF/xiqe7fNd2GO1a8KuqbMciXAA3GSof?=
 =?us-ascii?Q?e6mqGbA2UbDhWEBRvoy2hXj1pW8qrWbl0KwF92UnqKj4xhBV7z3+48eTQeqA?=
 =?us-ascii?Q?/2wNi1Eo2cbVxCWMSkqjf82jDus2G/IjxWfvDoPRMTuJZy6MsHQGYl3ozKVj?=
 =?us-ascii?Q?7ttydHG4dsYIy6ptd63tfMBZXmeyrRbm7hUbIDDLQRrT9K71nSFDxLJReXvd?=
 =?us-ascii?Q?NCZYEHYUsP9FqkADQgDbQ3HSYyjTZe4SI7+R4qyT4fGvLC5XdShHjXgZRccE?=
 =?us-ascii?Q?pFzT+rExTxBnCFElpZPFXXUKQ2bm0lC+pmUmdOTuJUiV+hxLfGNM2nB7npqk?=
 =?us-ascii?Q?lZ97hIhizsLCvCBIUAVP7ojtBA3lx8yjRdtAa9BzR8/d+VZPeWtJ2DWlGoj8?=
 =?us-ascii?Q?sHF8tK+0KbQWJbGSitGZAj77r/ViCInf/gvnrYi+o0lUgzjjORdP5elXrsll?=
 =?us-ascii?Q?U7UiePmErC3lkhKlfJVnklVfREZytgbViTvidB27DSajVF75xCWEG4KKmbER?=
 =?us-ascii?Q?pqZ4llbd8U5i6ij4FF1hOJKvdKfkm2PQKu4PjhG/7mELIDAE+R8SBYDoSFx/?=
 =?us-ascii?Q?Jg49lP1GMAkcLCAZxn6h2t8J92adaKkrOQLq/kLKiMNnwKAZ3QaIKBb9xuNl?=
 =?us-ascii?Q?+bV0EQbwOkxXl665izXtl5xnfvz5HZ5qFLm+d1Zo2lkJq/36O57z7BQz+Sf4?=
 =?us-ascii?Q?metLtPEaOGyKoQ52/zsnDpV7x/ZoIQHYZeVDKvTQOXtojk76ZLZPFTVm4KXD?=
 =?us-ascii?Q?a70hjdN+kIllldZJMd3ymhjTCDh7z/dxkMmviI78hoqxKOzkTKVpZ4Nwb5jm?=
 =?us-ascii?Q?Pn983FyN4k8HYCBF8kf0iCSCzUq5lpQjrNGHrKx6Thix7ris7TsUXCaIUxC8?=
 =?us-ascii?Q?GtRBrj+/RkNm5BzR6xBuy0=3D?=
X-Microsoft-Antispam-Message-Info: eus0RBJ9L6ttrPHE38yeyVQ+XayOMcgUD10RTUVC1Ix0j5zr+WSssUNSikWdYllBD5FyZfopOrQfqaNmj4UW2F3xeWyXSbfC3OJxOyGYmNe+8IdjLYl3Ool0PzG7KF/fda9s4O/O/wSRs5EWpt3efX74LVKPuAi+uzkNySx7OoJJ97eQg7INThsdcMMvLdt6xNV/fyhWwyLMwcj8bCNcwVqyw/H9LjILDnk01cgTnvRfMSaFlzG9keq80X29s50aT+d+BFUEmiKQ52Ty7OBx6ejpXPaR2e2uKx3kKitg3OHANIxoAKtZpcuE/TibUF9Ts2oCZQRggx1ppYI02O24EeLCC0cw8Q6rUgxoRs3edcI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4935;6:WqWR9MEVUPcC1Dzgwc57dIUpXnzW7YEj4wrTxxfZnIbtE12eb5GB7MpmncJhPbzxfnJgq9W7RRh1d4OVagVHbyUHgjbz8OTqvtyRmekC4xqB+9TlK9/VkVkCiCGZNdBYrVM9WQDc9Ggdi4k2HdNPCmwL50WoxJpF1QFwhAe+EBx5g81VGog6w/6ynyVQx8k7RzKLTvIYCyxEph9sKBNKkAUKRuzDRWkKdxtuLx/51oOnBKyPljZhFS0ilVaMUQ3H5v+BpynlPnvRuPTrEKSoBbj+VH0H1ixHAFSybvybA6iGCcHdTLBqPxF6tSd/htFQ477K0lWQKbDvKgBqkDzjCo8XlBf2Gx/b+nNaS3Rc8wVznULAXi3gfARifeJkJwIZoQDdijpg4aU/1SKYAQOPrYUrbXdDVZBieyXFmIiHJ1cIxTrY8fada4qyvk0BaMT5e14p5CojXiEQBtjUZ7zSMg==;5:tOCZ1m7yI+7Ierpo4xIaqLsi6PZUcxynOWjImMxoNzlXpTnSRHPllq4iHEZZDw5aX7DJb0Y1k4ck+5+dwN7dMl7+hXDD9LSiWeVRARE8+Arw1305+JiDkiF76gMSg/nVPXtcmLubvIOeBY82ZisI37IJ3hJe+uqlWu86gtaKhnk=;7:NlkuektwAifdH3ENpJGgly0u03mPMNco196m/kLtxoTLSfeDdAE9q8t9WFfEmwwybOt9Rpw61/iRb+zvcX6qux7kujt/Z7FH9h+xjFwx6FA1dGeyxbq+s5p4fTIpikrmL8lMyln8qLozlbJXYzjBLUCJeA420HTas0/D1aFbG+c+wJcPqga6WVQZdZtxXqn4kr5Na92e231auKVvfpNa5XJqKDOSLuXqFIteLWRbIgH9ILSziS1TA6ZbcKqQ3ZJa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 06:41:12.5764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1942ee5-7241-43db-3513-08d6148ce757
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALG_SET_KEY_TYPE requires caller to pass the key_type to be used
for AES encryption/decryption.

Sometimes the cipher key will be stored in the device's
hardware (eFuse, BBRAM etc).So,there is a need to specify the information
about the key-type to use it for Encrypt or Decrypt operations.

This patch implements the above requirement.


Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 crypto/af_alg.c             |  7 +++++++
 crypto/algif_skcipher.c     | 12 ++++++++++++
 crypto/blkcipher.c          |  9 +++++++++
 crypto/skcipher.c           | 18 ++++++++++++++++++
 include/crypto/if_alg.h     |  2 ++
 include/crypto/skcipher.h   | 12 +++++++++++-
 include/linux/crypto.h      | 12 ++++++++++++
 include/uapi/linux/if_alg.h |  1 +
 8 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index b053179..9ea6b86 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -261,6 +261,13 @@ static int alg_setsockopt(struct socket *sock, int lev=
el, int optname,
                if (!type->setauthsize)
                        goto unlock;
                err =3D type->setauthsize(ask->private, optlen);
+               break;
+       case ALG_SET_KEY_TYPE:
+               if (sock->state =3D=3D SS_CONNECTED)
+                       goto unlock;
+               if (!type->setkeytype)
+                       goto unlock;
+               err =3D type->setkeytype(ask->private, optval, optlen);
        }

 unlock:
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index cfdaab2..9164465 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -320,6 +320,17 @@ static int skcipher_setkey(void *private, const u8 *ke=
y, unsigned int keylen)
        return crypto_skcipher_setkey(private, key, keylen);
 }

+static int skcipher_setkeytype(void *private, const u8 *key,
+                              unsigned int keylen)
+{
+       struct skcipher_tfm *tfm =3D private;
+       int err;
+
+       err =3D crypto_skcipher_setkeytype(tfm->skcipher, key, keylen);
+
+       return err;
+}
+
 static void skcipher_sock_destruct(struct sock *sk)
 {
        struct alg_sock *ask =3D alg_sk(sk);
@@ -384,6 +395,7 @@ static int skcipher_accept_parent(void *private, struct=
 sock *sk)
        .bind           =3D       skcipher_bind,
        .release        =3D       skcipher_release,
        .setkey         =3D       skcipher_setkey,
+       .setkeytype     =3D       skcipher_setkeytype,
        .accept         =3D       skcipher_accept_parent,
        .accept_nokey   =3D       skcipher_accept_parent_nokey,
        .ops            =3D       &algif_skcipher_ops,
diff --git a/crypto/blkcipher.c b/crypto/blkcipher.c
index f93abf1..3ea0e7f 100644
--- a/crypto/blkcipher.c
+++ b/crypto/blkcipher.c
@@ -408,6 +408,14 @@ static int setkey(struct crypto_tfm *tfm, const u8 *ke=
y, unsigned int keylen)
        return cipher->setkey(tfm, key, keylen);
 }

+static int setkeytype(struct crypto_tfm *tfm, const u8 *key,
+                     unsigned int keylen)
+{
+       struct blkcipher_alg *cipher =3D &tfm->__crt_alg->cra_blkcipher;
+
+       return cipher->setkeytype(tfm, key, keylen);
+}
+
 static int async_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
                        unsigned int keylen)
 {
@@ -478,6 +486,7 @@ static int crypto_init_blkcipher_ops_sync(struct crypto=
_tfm *tfm)
        unsigned long addr;

        crt->setkey =3D setkey;
+       crt->setkeytype =3D setkeytype;
        crt->encrypt =3D alg->encrypt;
        crt->decrypt =3D alg->decrypt;

diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index 0bd8c6c..cb794dd 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -604,6 +604,23 @@ static int skcipher_setkey_blkcipher(struct crypto_skc=
ipher *tfm,
        return 0;
 }

+static int skcipher_setkeytype_blkcipher(struct crypto_skcipher *tfm,
+                                        const u8 *key, unsigned int keylen=
)
+{
+       struct crypto_blkcipher **ctx =3D crypto_skcipher_ctx(tfm);
+       struct crypto_blkcipher *blkcipher =3D *ctx;
+       int err;
+
+       crypto_blkcipher_clear_flags(blkcipher, ~0);
+       crypto_blkcipher_set_flags(blkcipher, crypto_skcipher_get_flags(tfm=
) &
+                       CRYPTO_TFM_REQ_MASK);
+       err =3D crypto_blkcipher_setkeytype(blkcipher, key, keylen);
+       crypto_skcipher_set_flags(tfm, crypto_blkcipher_get_flags(blkcipher=
) &
+                       CRYPTO_TFM_RES_MASK);
+
+       return err;
+}
+
 static int skcipher_crypt_blkcipher(struct skcipher_request *req,
                                    int (*crypt)(struct blkcipher_desc *,
                                                 struct scatterlist *,
@@ -670,6 +687,7 @@ static int crypto_init_skcipher_ops_blkcipher(struct cr=
ypto_tfm *tfm)
        tfm->exit =3D crypto_exit_skcipher_ops_blkcipher;

        skcipher->setkey =3D skcipher_setkey_blkcipher;
+       skcipher->setkeytype =3D skcipher_setkeytype_blkcipher;
        skcipher->encrypt =3D skcipher_encrypt_blkcipher;
        skcipher->decrypt =3D skcipher_decrypt_blkcipher;

diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 482461d..202298e 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -51,6 +51,8 @@ struct af_alg_type {
        void *(*bind)(const char *name, u32 type, u32 mask);
        void (*release)(void *private);
        int (*setkey)(void *private, const u8 *key, unsigned int keylen);
+       int (*setkeytype)(void *private, const u8 *keytype,
+                         unsigned int keylen);
        int (*accept)(void *private, struct sock *sk);
        int (*accept_nokey)(void *private, struct sock *sk);
        int (*setauthsize)(void *private, unsigned int authsize);
diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index 2f327f0..54f6752 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -54,7 +54,9 @@ struct skcipher_givcrypt_request {

 struct crypto_skcipher {
        int (*setkey)(struct crypto_skcipher *tfm, const u8 *key,
-                     unsigned int keylen);
+                       unsigned int keylen);
+       int (*setkeytype)(struct crypto_skcipher *tfm, const u8 *key,
+                         unsigned int keylen);
        int (*encrypt)(struct skcipher_request *req);
        int (*decrypt)(struct skcipher_request *req);

@@ -125,6 +127,8 @@ struct crypto_skcipher {
 struct skcipher_alg {
        int (*setkey)(struct crypto_skcipher *tfm, const u8 *key,
                      unsigned int keylen);
+       int (*setkeytype)(struct crypto_skcipher *tfm, const u8 *key,
+                         unsigned int keylen);
        int (*encrypt)(struct skcipher_request *req);
        int (*decrypt)(struct skcipher_request *req);
        int (*init)(struct crypto_skcipher *tfm);
@@ -401,6 +405,12 @@ static inline int crypto_skcipher_setkey(struct crypto=
_skcipher *tfm,
        return tfm->setkey(tfm, key, keylen);
 }

+static inline int crypto_skcipher_setkeytype(struct crypto_skcipher *tfm,
+                                            const u8 *key, unsigned int ke=
ylen)
+{
+       return tfm->setkeytype(tfm, key, keylen);
+}
+
 static inline unsigned int crypto_skcipher_default_keysize(
        struct crypto_skcipher *tfm)
 {
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index e8839d3..bda8380 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -292,6 +292,8 @@ struct ablkcipher_alg {
 struct blkcipher_alg {
        int (*setkey)(struct crypto_tfm *tfm, const u8 *key,
                      unsigned int keylen);
+       int (*setkeytype)(struct crypto_tfm *tfm, const u8 *keytype,
+                         unsigned int keylen);
        int (*encrypt)(struct blkcipher_desc *desc,
                       struct scatterlist *dst, struct scatterlist *src,
                       unsigned int nbytes);
@@ -563,6 +565,8 @@ struct blkcipher_tfm {
        void *iv;
        int (*setkey)(struct crypto_tfm *tfm, const u8 *key,
                      unsigned int keylen);
+       int (*setkeytype)(struct crypto_tfm *tfm, const u8 *key,
+                         unsigned int keylen);
        int (*encrypt)(struct blkcipher_desc *desc, struct scatterlist *dst=
,
                       struct scatterlist *src, unsigned int nbytes);
        int (*decrypt)(struct blkcipher_desc *desc, struct scatterlist *dst=
,
@@ -1281,6 +1285,14 @@ static inline int crypto_blkcipher_setkey(struct cry=
pto_blkcipher *tfm,
                                                 key, keylen);
 }

+static inline int crypto_blkcipher_setkeytype(struct crypto_blkcipher *tfm=
,
+                                             const u8 *key,
+                                             unsigned int keylen)
+{
+       return crypto_blkcipher_crt(tfm)->setkeytype(crypto_blkcipher_tfm(t=
fm),
+                                                    key, keylen);
+}
+
 /**
  * crypto_blkcipher_encrypt() - encrypt plaintext
  * @desc: reference to the block cipher handle with meta data
diff --git a/include/uapi/linux/if_alg.h b/include/uapi/linux/if_alg.h
index bc2bcde..aa31b18 100644
--- a/include/uapi/linux/if_alg.h
+++ b/include/uapi/linux/if_alg.h
@@ -35,6 +35,7 @@ struct af_alg_iv {
 #define ALG_SET_OP                     3
 #define ALG_SET_AEAD_ASSOCLEN          4
 #define ALG_SET_AEAD_AUTHSIZE          5
+#define ALG_SET_KEY_TYPE               6

 /* Operations */
 #define ALG_OP_DECRYPT                 0
--
1.9.5

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
