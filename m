Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC24FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718C720875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qqqnERSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718C720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbeGLF6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:58:52 -0400
Received: from mail-eopbgr700052.outbound.protection.outlook.com ([40.107.70.52]:15360
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbeGLFz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXW+Yqy7MNmDuQbhZtinzm4QfetHz+/RM+4ivx8og88=;
 b=qqqnERSSqrPawEq8zEuafGqK8+3uemOq0JvCVg7FMUqbyvaCoWQhQYyLenBCMMRzjxnBFL0Pijkgf2Bqbd4HXdrBw+3XDMJonlc0uNP/u33j/aAEV46tA38qqO85PqOIyDcYErzrVGhsLRSHVeYvgMxUYFD2D5zip6viJUmgTiQ=
Received: from SN1PR0701CA0070.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::38) by SN6PR07MB4720.namprd07.prod.outlook.com
 (2603:10b6:805:3b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.22; Thu, 12 Jul
 2018 05:47:58 +0000
Received: from BY2NAM05FT039.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::204) by SN1PR0701CA0070.outlook.office365.com
 (2a01:111:e400:52fd::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:52 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT039.mail.protection.outlook.com (10.152.100.176) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.973.9 via
 Frontend Transport; Thu, 12 Jul 2018 05:47:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkvw032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:51 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:02 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:02 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkcm029515;
        Thu, 12 Jul 2018 06:47:46 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lkCK029502;
        Thu, 12 Jul 2018 06:47:46 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 04/31] usb: usbssp: Added USBSSP platform driver
Date:   Thu, 12 Jul 2018 06:47:01 +0100
Message-ID: <1531374448-26532-5-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(36092001)(199004)(189003)(8936002)(47776003)(26005)(26826003)(51416003)(76176011)(305945005)(14444005)(356003)(8676002)(476003)(486006)(246002)(11346002)(446003)(7636002)(126002)(2616005)(106466001)(105596002)(50226002)(4720700003)(478600001)(87636003)(5660300001)(6666003)(50466002)(86362001)(36756003)(2906002)(109986005)(107886003)(42186006)(54906003)(336012)(4326008)(48376002)(1671002)(316002)(16586007)(186003)(426003)(266003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4720;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT039;1:L7uFxU44K5zeoWFO492+hYJcZM6/9mFkIHTlaAFAnvAjMaYlA2/oEqsbtMX+1FNYrCFpskDXZVQ3xxuWbb1dj1bb5Opsi++xWeFMkiMj9nUkAhaoUmrNkQf28wdOGI5J
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94188419-9fdd-4397-d663-08d5e7bb01f1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN6PR07MB4720;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;3:XfYx/1M1g6UJwA3hOou0k42WmMtWsWJYmKlnCSp1CS4naNWdzhdPQsXOkwq4qT3nGPjzZgC0djQLLiTFBoP22eWJRz11vGftZigvl2JnK4d3XcBSo+NHV2UOt4iWRmc9e+qme3Xq1tyBaPmkSmbZcV6zjBrHbWP4oRQbcD0vVVgIJoqxIFK9lW35M40eiEVupJJWWNF9zR0i4GZi7Qn3LE51itQzEXcmkf8bwzbv/LV+5IS2mIBBWZy/MT9mxlIKDgpAp84X6VpQRTfXz0x8D3cpSzr4mQGI/dVUP8LqrSyToDhvkYtr+//Nxh3VWLKo0b69l4hPo/JKuX2LZCgBeM+elhQMoXD/j1CrIJqD9iQ=;25:wKwnVhLZeYUKHryO9CBAg9KZeRhhFK4w4Sdyle6qzGWLeS1dzex8YTlEhBXEcSDL16Bg9Li+5yAhqN/9lb1c5yqFK6eNia4T1oWxI2CGA8mOhmEgCl+iZ02Ksv8sPvW4j9kfiVhot8D2yPF0OMPMwiftZhWpq1LH9z0iNAhMKju0SAWWCr/F2/Oti5FPjmRFk09wqWd/xX03aS/iYZSNCL41tgg6SPy00I6avTKA7hiW6maLfChwLbfw1S+vGJKtS2n4mKbrMyYsegnKWy7mJf7b/pyUsKCsBvyj6x8at/D7LTxCZeyqpUNhaMZcq9Pt/mCF8rafKe4s4xISHVQQkQ==
X-MS-TrafficTypeDiagnostic: SN6PR07MB4720:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;31:Es9uCwnU9Yznu7TAF4jdNGHJfS/DSArzXRPA/ycDQVqNeJ8ItYbp7efPAIC4W/AFl50M7Yq4JlZdrrhQgHyesI2ENDDG5xhBM54ebhS2+cXjbCdKW+WQ3L8II36QXWmmtumz9b+PiVWy09oPI0gXnE7yFMMh1JCF89RJUfpTXb5byinntpKwtMXg/V3RsCla5AESVcUSNGhsO0xfv/oNjJKllI6f/fUwvFPlQ/1qRu4=;20:yiZ7dIo6udPDXs/4ihliC2xq9zWzgTxTFMOCK5+uvaKYvE9AeZ4i3RObjRoGGNSPOPDNJICEnaiKOZC4MAyMTV7q3Tef53HWi2wkqZ+AM5C6PWuyT1Xxo2M3cCuyeLj7lhX3ZsVRSUTpeOpRUUJeeHPONh8GVHSgPcGjYKcABTkN4E8RA1cwvneguMFe68KtL/il1i4cYIKgX/SjYr9D2Rh3sMIl1sf3qxg8gsW2sWUg3BFhWvYmHLE9cv2Vo5tKJPdBA/dlAduKL1KReNshb/UuC+/fB8K8nModtkepQLxeBWxLUK/h5mYGiDxl7oFE8y53sLvYIayoO+TwnA+yPTeE4U5X+xIxDcfVggY84vVngNTAwz9WAUrie4myd3KJLp95dWT1tqu+fmi+p8fsXe9SmX/CV5WGMYIM1ycDsfhy0sMzWkIPIdnAVEuUysIWK+vtcIWCWtDNfjKVxzZkvHmrGcekouG+FnQGzWv+K6E2pT6sVo97tYTaByI4ghmZ
X-Microsoft-Antispam-PRVS: <SN6PR07MB47209164A896FE16C2A9D712DD590@SN6PR07MB4720.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93003095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4720;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4720;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;4:Ma+it2rNTCjfMLRQtj/ULLZ6ttNpNfY8ooicKnFDLHnJZzRginjH5seBrX4/foQAXTIlyKsz9fa62e0bByzDfDjD54YgTL5dWEpn3eAttnf9tr5GvgHfMNDGU5jUZMSL/dt1zJjH8SrZpJZGe+fc4FzXYvxG6p33D+Th5YTJ2y++fy/f6y7HkCP+ph2K7BgxTuPcRcdd8tcfj28RGG4blGhZfnqaB4/k9v6Akf314HFgF1ZUnFzxPRLp1bxPVnOQRN8+k2DzMgboUuqBIVc1axSXlMKkrYxePhl/7GQlpPf40VPKUxQyr90suuoIs6Ej
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4720;23:+t58AntnuVFVjnMu9FKkUid7/ZZpsYNOoF6LMZbbX?=
 =?us-ascii?Q?HMhqU1xGNU9kdFJTcj3GiRx8Mx20jxaFjkNzugmT2DF1r+9n8SU0ZkKMjv6T?=
 =?us-ascii?Q?XKSY7ugIv31RlsRVAcHxbJccugDMzM/TSBecfw15ujODg5By4Its15lv5HuR?=
 =?us-ascii?Q?X9Kb/CG4ax+lJneZLTv1sXr+EB+kF3zTk+gaBEnZuc8noaFfHRY0GITA/m35?=
 =?us-ascii?Q?yNK1pa6jUHMhDexFkgJCmOzhOAsgp0NrsPK0LVF9nhsKxn0J493B2JBriiwU?=
 =?us-ascii?Q?n54bJPeUcmXPWq8EG4oE2LFfEzxTjQpkAPtDTYY5Axq3tin+DyRl/r1KkOBt?=
 =?us-ascii?Q?7qvtHxWylF4hPdj1iTdydVJ4lk6nUkyQypGv2G5lQt1+TQ5kuYeQDsWed5i6?=
 =?us-ascii?Q?Bb+/DwL+BuInZJdrUzZvvUk2IXS0g1eIEpJNZFeg/izjg+205N5teBP4QfKe?=
 =?us-ascii?Q?Iq1+tjzYV5Akf7/aSQrt6XrOb63cGpZyqsSX87LMif2svF1rrtEz2cZhF/Ug?=
 =?us-ascii?Q?vqpqEqHE6FnRw32Puxbjd3odwzICM+SIRt76/T3QRUpn4TPpAXbNkE2LH3Hk?=
 =?us-ascii?Q?v25neRYCMFEHu+x4x9B9WHjm9JOxqx/G/bmonzyJ7iZD8XE4Q+3Ahkh9kxTb?=
 =?us-ascii?Q?gq0dbvjhw8STgHM3o+xO9DIDa4KxZzA8eSsHn0W8KLr2NrkHOMlBPm3MB04N?=
 =?us-ascii?Q?22nFCb533TebUwQDNFfD7Dp/TmkKREpDPiJc7v83ALpH4NYzx5KV4ihrbU8t?=
 =?us-ascii?Q?SVLziPftoimyqMnGlLw1qz5edDCAlCVtTK9HxIuDQ6fF/42WxhaFakdrvnfv?=
 =?us-ascii?Q?SCIgNvsRa2V5D2DfnzfajR8a0C0G0g4/c46QezFsInPU//5jyhqwWXoF7Pbu?=
 =?us-ascii?Q?LEM9nQRQcdkG7mxundcI8FgvYSFRAUkk0Nvi68EsJ2vLdoMvU/twUEe9nKpA?=
 =?us-ascii?Q?xg0+a+8CdlQJTy/xupUtqch41HuTe7qPykYzle1xql032G8D8mfVfGsxKq2V?=
 =?us-ascii?Q?na+3aMrVlBTzjZ2Ep+BTRYcY9Kjv/1ASMUrZk1MDll6xBeSsrFJB+bxFtbtN?=
 =?us-ascii?Q?EvafPtNzw609ZZiEhpwUp6uEc+9yGPJ/hFPXswQpcPodmCB2jL8gUwhtI2nG?=
 =?us-ascii?Q?MpILC5CGyNCTljwVce9/GM+CknB9wuSN5DSPueBLbZp/kHmynkr+Mh9HOIVP?=
 =?us-ascii?Q?VqpX7eOcAnojNGQmLLNrKttwGSOGzpIOubuyh+dpSDfWYgNls4169kcMwb3R?=
 =?us-ascii?Q?terX1P8QmUHYjP1G98=3D?=
X-Microsoft-Antispam-Message-Info: xUlgRBNnkwhs9CPpFoNqhBKU/w200IJE/0l00H61iK938OiI3spMW5voN7wejY9BytXij3E4ZqvS+rWhtKZe0IR5FibKPHWA8DtjF0ilgC5p589qByinaEGP2Ic/XUqOqjIn2fNeigYB9hTW7dAmrEKScStI5GNa5cZntc3wJnH9ZGqahQk2w4MpCFHF2ibK4HXc/nDUw0rDDjeGo7iklzosBjYnESxjX4XHF6+90+ZaiFZ/cjUjM3116PG92JsIFHB4hbs3W5F4RYZ7xe7p8oUcsb8zVYFGs8m1cedcbGgVuKZ1mBKv/1wc92uFkMHb50ksHTkKqg9FnJ74VUKFPgBRhqhzZaJfJkYHiV9xJJpKu5eElya4OLFp6iyjoHVy5h3F5M6m2u9WJiS6fAix1A==
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;6:/DzUMrqK/hWUs9NISJQbhhSbjFmSvf8RndZceV7KRUz46cr0NL1P3aJDo4ODzQFzjNtSBnXYw20FmXEvz6L3PERteznLG0Zh8SFlpjFOV52YQSWxXMccd2datl7e/GBFQNPYA8TSe9ZskYNnNMabLby7404232+21vgH0YSygMz4HFlutvoudjT9IHExTVYqqLlTaNB41lB2tp2t4Z72xhdiDndoBk5X1mNn3pG7Vv2Tc76PqGVxgFYuHdMB3KSvr59e7ez8oza3CgxBasB4rWD6EFswQ6G1Lti10o6HYkn4Wdlh2/4U36EZQr8ArIiuGwVsiX8WnmK1ax59mUPulo+JThHgQJoPAx21yFofPE//YsLHGA3uHuX8zYcF4y3GlyT4d59s12Q5IBc/YmKSrnxEF78l8KGxU5HvIhz9LRJ9lrMtfmcGLqzK6TQkZENuAZOxQjgmAruxeDahii1p+w==;5:q5YjMeLjgaIPsVysoOBfvNA/mus6kY/rL91CjAFnBoj0LNAvfZb9H4pZfVZlY/o9yvfVjdzPqNsZwLRkPtRA5VDD/tH3QhWuBFvS4/LMOZRgp+DRCNokAMXNx6LOceA+7GQLBOzGA1dy8sktgqSSzAHg6PCijWkauPixHojA1LQ=;24:7FxGDTcYLd+PD5XBzx+14FD8Trbp3sc94FTtaDCDKEMuIc76zPUK8f+c/fiSLncaWojzyLivSPKNgnc0OjXHvU7QVRMN/nO4LX1PnBeCJLU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;7:gOzzIPGAt/mptkipKGrR6nQkomwJX3iQOOaQ+PcCnisqFZAAR61jxs0BdPi67Roe54C+e3RkJ4eT7MQwgqjgr5izngu3w/9sCsNU9j+q78LTXlmZ1cd7VLVTuggdDKDI2GXpjL6Z4+ceOCF31EAuquLE6Y01lQsnbUy9pSX2dgMkeeumedpVlRxi7lMk/4iDTSw9oV17LEaq66ghTmVnGL+XVan0zGn1kgIuootm5m0niakGyrkVNqUsS4sBpHhQ;20:UP1WB+v5OSxmIViX+eosTqiCUUfGp6tz2a8xyUt1FXCpMnrUZUqdaduphwWVFCn0cxxkx2teEzOg4G4FERpMkro5fJEo7aCQ7sYGKWnCICRQAMBfuGwT8E9wXM8l4/g4gxyikDWXlC8KIJW1RQGCNzG+fRhyI2uigubWXesDRr/CfxD3J+PChkxwKq5POna24XdK/pziNDyz5iukBhn8QrPZ2LpSm7iavTdZPEdXCz5SfOyWh7ko+C19xknqFRMC
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:51.9695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94188419-9fdd-4397-d663-08d5e7bb01f1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4720
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds platform driver that is entry point for loading and
unloading usbssp.ko modules.
It also adds information about this driver to drivers/usb/Kconfig
and drivers/usb/Makefile files and create Kconfig and Makefile
files in drivers/usb/usbssp directory.

Patch also adds template for some function ivokked from
usbssp_plat.c file. These function will be implemented in next patches.

This patch also introduce usbssp_trb_virt_to_dma that converts
virtual address of TRB's to DMA address. In this moment this
function is used only in gadget-trace.h.

From this moment the driver can be compiled.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/Kconfig              |   2 +
 drivers/usb/Makefile             |   2 +
 drivers/usb/usbssp/Kconfig       |  21 ++++
 drivers/usb/usbssp/Makefile      |  11 ++
 drivers/usb/usbssp/gadget-ring.c |  48 ++++++++
 drivers/usb/usbssp/gadget.c      |  64 +++++++++++
 drivers/usb/usbssp/gadget.h      |  16 ++-
 drivers/usb/usbssp/usbssp-plat.c | 186 +++++++++++++++++++++++++++++++
 8 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/usbssp/Kconfig
 create mode 100644 drivers/usb/usbssp/Makefile
 create mode 100644 drivers/usb/usbssp/gadget-ring.c
 create mode 100644 drivers/usb/usbssp/gadget.c
 create mode 100644 drivers/usb/usbssp/usbssp-plat.c

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index f699abab1787..dc05f384c34c 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -110,6 +110,8 @@ source "drivers/usb/mtu3/Kconfig"
 
 source "drivers/usb/musb/Kconfig"
 
+source "drivers/usb/usbssp/Kconfig"
+
 source "drivers/usb/dwc3/Kconfig"
 
 source "drivers/usb/dwc2/Kconfig"
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 060643a1b5c8..b1cd5f83d440 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -8,6 +8,8 @@
 obj-$(CONFIG_USB)		+= core/
 obj-$(CONFIG_USB_SUPPORT)	+= phy/
 
+obj-$(CONFIG_USB_USBSSP)	+= usbssp/
+
 obj-$(CONFIG_USB_DWC3)		+= dwc3/
 obj-$(CONFIG_USB_DWC2)		+= dwc2/
 obj-$(CONFIG_USB_ISP1760)	+= isp1760/
diff --git a/drivers/usb/usbssp/Kconfig b/drivers/usb/usbssp/Kconfig
new file mode 100644
index 000000000000..ee20b01753dc
--- /dev/null
+++ b/drivers/usb/usbssp/Kconfig
@@ -0,0 +1,21 @@
+config USB_USBSSP
+	tristate "Cadence USBSSP DRD Controller"
+	depends on (USB || USB_GADGET) && HAS_DMA
+	select USB_USBSSP_GADGET
+	help
+	  Say Y here if your system has a cadence USBSSP dual-role controller.
+	  It supports: dual-role switch Host-only, and Peripheral-only.
+
+	  If you choose to build this driver is a dynamically linked
+	  module, the module will be called usbssp.ko.
+
+if USB_USBSSP
+
+config USB_USBSSP_GADGET
+	tristate "Gadget only mode"
+	default USB_USBSSP
+	depends on USB_GADGET=y || USB_GADGET=USB_USBSSP
+	help
+	  Select this when you want to use USBSSP in gadget mode only,
+endif
+
diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
new file mode 100644
index 000000000000..1b6261068fd9
--- /dev/null
+++ b/drivers/usb/usbssp/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+# define_trace.h needs to know how to find our header
+CFLAGS_gadget-trace.o := -I$(src)
+
+obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
+usbssp-y 			:=  usbssp-plat.o gadget-ring.o \
+				    gadget.o
+
+ifneq ($(CONFIG_TRACING),)
+	usbssp-y		+= gadget-trace.o
+endif
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
new file mode 100644
index 000000000000..d1da59306d02
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp
+ */
+
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/irq.h>
+#include "gadget-trace.h"
+#include "gadget.h"
+
+/*
+ * Returns zero if the TRB isn't in this segment, otherwise it returns the DMA
+ * address of the TRB.
+ */
+dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
+				  union usbssp_trb *trb)
+{
+	unsigned long segment_offset;
+
+	if (!seg || !trb || trb < seg->trbs)
+		return 0;
+	/* offset in TRBs */
+	segment_offset = trb - seg->trbs;
+	if (segment_offset >= TRBS_PER_SEGMENT)
+		return 0;
+	return seg->dma + (segment_offset * sizeof(*trb));
+}
+
+irqreturn_t usbssp_irq(int irq, void *priv)
+{
+	struct usbssp_udc *usbssp_data = (struct usbssp_udc *)priv;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
+
+	spin_lock_irqsave(&usbssp_data->lock, flags);
+
+	spin_unlock_irqrestore(&usbssp_data->lock, flags);
+	return ret;
+}
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
new file mode 100644
index 000000000000..2f60d7dd1fe4
--- /dev/null
+++ b/drivers/usb/usbssp/gadget.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp
+ */
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/dmi.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+
+#include "gadget-trace.h"
+#include "gadget.h"
+
+#ifdef CONFIG_PM
+/*
+ * Stop DC (not bus-specific)
+ *
+ * This is called when the machine transition into S3/S4 mode.
+ *
+ */
+int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup)
+{
+	/*TODO*/
+	return -ENOSYS;
+}
+
+/*
+ * start DC (not bus-specific)
+ *
+ * This is called when the machine transition from S3/S4 mode.
+ *
+ */
+int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated)
+{
+	/*TODO*/
+	return -ENOSYS;
+}
+
+#endif	/* CONFIG_PM */
+
+int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
+{
+	int ret;
+	return ret;
+}
+
+int usbssp_gadget_exit(struct usbssp_udc *usbssp_data)
+{
+	int ret = 0;
+
+	return ret;
+}
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 6b634dc63d9e..2f9ee3543911 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -9,7 +9,6 @@
  * A lot of code based on Linux XHCI driver.
  * Origin: Copyright (C) 2008 Intel Corp.
  */
-
 #ifndef __LINUX_USBSSP_GADGET_H
 #define __LINUX_USBSSP_GADGET_H
 
@@ -1671,6 +1670,21 @@ static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
 {
 	lo_hi_writeq(val, regs);
 }
+
+/* USBSSP Device controller glue */
+int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
+int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated);
+
+irqreturn_t usbssp_irq(int irq, void *priv);
+
+/* USBSSP ring, segment, TRB, and TD functions */
+dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
+		union usbssp_trb *trb);
+
+/* USBSSP gadget interface*/
+int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
+int  usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
+
 static inline char *usbssp_slot_state_string(u32 state)
 {
 	switch (state) {
diff --git a/drivers/usb/usbssp/usbssp-plat.c b/drivers/usb/usbssp/usbssp-plat.c
new file mode 100644
index 000000000000..dfb3a2dc4e8c
--- /dev/null
+++ b/drivers/usb/usbssp/usbssp-plat.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/usb/phy.h>
+#include <linux/slab.h>
+#include <linux/acpi.h>
+
+#include "gadget.h"
+
+#define DRIVER_AUTHOR "Pawel Laszczak"
+#define DRIVER_DESC "USBSSP Device Controller (USBSSP) Driver"
+
+#ifdef CONFIG_OF
+
+static const struct of_device_id usbssp_dev_of_match[] = {
+	{
+		.compatible = "Cadence, usbssp-dev",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, usbssp_dev_of_match);
+#endif
+
+int usbssp_is_platform(void)
+{
+	return 1;
+}
+
+static int usbssp_plat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct usbssp_udc *usbssp_data;
+	int ret = 0;
+	int irq;
+	struct device *sysdev;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Incorrect IRQ number\n");
+		return -ENODEV;
+	}
+
+	usbssp_data = devm_kzalloc(dev, sizeof(*usbssp_data), GFP_KERNEL);
+	if (!usbssp_data)
+		return -ENOMEM;
+
+	for (sysdev = &pdev->dev; sysdev; sysdev = sysdev->parent) {
+		if (is_of_node(sysdev->fwnode) ||
+		    is_acpi_device_node(sysdev->fwnode))
+			break;
+#ifdef CONFIG_PCI
+		else if (sysdev->bus == &pci_bus_type)
+			break;
+#endif
+	}
+
+	if (!sysdev)
+		sysdev = &pdev->dev;
+
+	/* Try to set 64-bit DMA first */
+	if (WARN_ON(!dev->dma_mask))
+		/* Platform did not initialize dma_mask */
+		ret = dma_coerce_mask_and_coherent(dev,
+				DMA_BIT_MASK(64));
+	else
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
+	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
+	if (ret) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	usbssp_data->regs = devm_ioremap_resource(dev, res);
+
+	if (IS_ERR(usbssp_data->regs)) {
+		ret = PTR_ERR(usbssp_data->regs);
+		return ret;
+	}
+
+	usbssp_data->rsrc_start = res->start;
+	usbssp_data->rsrc_len = resource_size(res);
+
+	ret = devm_request_irq(dev, irq, usbssp_irq, IRQF_SHARED,
+			dev_name(dev), usbssp_data);
+
+	if (ret < 0)
+		return ret;
+
+	usbssp_data->irq = irq;
+	usbssp_data->dev = dev;
+	platform_set_drvdata(pdev, usbssp_data);
+	ret = usbssp_gadget_init(usbssp_data);
+
+	return ret;
+}
+
+static int usbssp_plat_remove(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct usbssp_udc *usbssp_data;
+
+	usbssp_data = (struct usbssp_udc *)platform_get_drvdata(pdev);
+	ret = usbssp_gadget_exit(usbssp_data);
+	return ret;
+
+}
+
+static int __maybe_unused usbssp_plat_suspend(struct device *dev)
+{
+	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
+
+	return usbssp_suspend(usbssp_data, device_may_wakeup(dev));
+}
+
+static int __maybe_unused usbssp_plat_resume(struct device *dev)
+{
+	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
+
+	return usbssp_resume(usbssp_data, 0);
+}
+
+static int __maybe_unused usbssp_plat_runtime_suspend(struct device *dev)
+{
+	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
+
+	return usbssp_suspend(usbssp_data, true);
+}
+
+static int __maybe_unused usbssp_plat_runtime_resume(struct device *dev)
+{
+	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
+
+	return usbssp_resume(usbssp_data, 0);
+}
+
+static const struct dev_pm_ops usbssp_plat_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(usbssp_plat_suspend, usbssp_plat_resume)
+
+	SET_RUNTIME_PM_OPS(usbssp_plat_runtime_suspend,
+			usbssp_plat_runtime_resume,
+			NULL)
+};
+
+static struct platform_driver usbssp_driver = {
+	.probe	= usbssp_plat_probe,
+	.remove	= usbssp_plat_remove,
+	.driver	= {
+		.name = "usbssp-dev",
+		.pm = &usbssp_plat_pm_ops,
+		.of_match_table = of_match_ptr(usbssp_dev_of_match),
+	},
+};
+
+static int __init usbssp_plat_init(void)
+{
+	return platform_driver_register(&usbssp_driver);
+}
+module_init(usbssp_plat_init);
+
+static void __exit usbssp_plat_exit(void)
+{
+	platform_driver_unregister(&usbssp_driver);
+}
+module_exit(usbssp_plat_exit);
+
+MODULE_ALIAS("platform:usbss-gadget");
+MODULE_DESCRIPTION("USBSSP' Device Controller (USBSSP) Driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

