Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2815FC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFCF2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="SE/rvHrC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="o6TnuWIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfAHMXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:23:21 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54996 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727295AbfAHMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:23:20 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x08CJKBd015462;
        Tue, 8 Jan 2019 04:23:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=ws2VFaCq3dXthYPHPpjVp/ilEmQZTsE7iMmOtYMwKiU=;
 b=SE/rvHrCtLaoxazEl+VMr0f5Fvk3+jYZ+9TdwPRCWZU9DPIDDaO7HPx/u+y/wUH1/VnX
 bzYXh8u0C2YChQlLcWxLmQMRDLTk4bbRBoCEAIlEoeAgV9su8iXwgLAiWD9DsM69JVOI
 Ym/FUaGkbDX5owOGunSWeE9p+LLJAP7yrYA6/ZO78Aaub+qUeHZwcHFQuCQGbBF63Ixr
 wE8Zqi+6QaLMenmGOcxJhzuRfFVo0JpwoA2CCHNvcbNb1pEwTBUFWUHmbklfaBQrP0Qb
 R7hA6ORYfZVw4uQXPHvPB/20AYSy0Mvout6/lfovQsoPrfiTcWyrtHNdkyg4CXdbnBKV DA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2057.outbound.protection.outlook.com [104.47.50.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pts21xk1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Jan 2019 04:22:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws2VFaCq3dXthYPHPpjVp/ilEmQZTsE7iMmOtYMwKiU=;
 b=o6TnuWIpnDcd6ftzW/8M6uspmHFCw2C1BExWcA+kMDgg5Vj0+wcv79OTqgFQ+rPDM+LU+7Y4rCr5vkXKjog3epgd4CbuQTxBcPrOmTt4asFLzYfsTRnC14YvUS4BIWoi7JX4ys01DEEgYV8mcqAU5eRFJOCMTiq/V49nf/EKSlI=
Received: from DM5PR07CA0101.namprd07.prod.outlook.com (2603:10b6:4:ae::30) by
 SN1PR07MB2174.namprd07.prod.outlook.com (2a01:111:e400:c455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.6; Tue, 8 Jan
 2019 12:22:57 +0000
Received: from BY2NAM05FT038.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::207) by DM5PR07CA0101.outlook.office365.com
 (2603:10b6:4:ae::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Tue, 8 Jan 2019 12:22:57 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 BY2NAM05FT038.mail.protection.outlook.com (10.152.100.175) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.7 via Frontend Transport; Tue, 8 Jan 2019 12:22:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x08CMpDM022959
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 8 Jan 2019 07:22:55 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 8 Jan 2019 13:22:51 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 8 Jan 2019 13:22:51 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x08CMo0Q012668;
        Tue, 8 Jan 2019 12:22:50 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x08CMmLu012588;
        Tue, 8 Jan 2019 12:22:48 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH 0/2] rtc: Add a driver for Cadence RTC
Date:   Tue, 8 Jan 2019 12:22:40 +0000
Message-ID: <20190108122242.12411-1-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(189003)(199004)(36092001)(305945005)(47776003)(2906002)(26005)(53936002)(486006)(1076003)(476003)(478600001)(126002)(2616005)(36756003)(87636003)(5660300001)(8936002)(51416003)(81166006)(8676002)(81156014)(336012)(186003)(97736004)(48376002)(86362001)(54906003)(110136005)(69596002)(107886003)(106466001)(316002)(356004)(6666004)(16586007)(50466002)(50226002)(42186006)(68736007)(426003)(105596002)(4326008)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2174;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT038;1:vDBhtTnxlsUI/rNIs/l5HkY8jnAtJ1CB/u3sa14BljQZIhXslkbq3EOGYlwr5O3y+Nv61BxINV4jP9sRclrFaPnLu/YlG2I6r/5WG1PmfIo+F1EdHKw4W++sdIJJiPxY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ee6d47-8729-4a22-99d4-08d67564059a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060);SRVR:SN1PR07MB2174;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2174;3:5sLU/1pODgxjnH5Ouk1WpXO644YWS3AVc7kRBxKq0QVbcnr7swULAsbeJ3YvbLYjZXdcyUCc/ewhphjS3e3gUuoV1e39uyo0d+oDV6mCORNR3E0gTFNyMa+/0eSJh7Bw8GdF3MkEwmQQxCcv+vd4ep8PxwzVT5GTTLFSNgjMKGs+itMsLWAWM7YOXWEWOZl2sUF13oiS2oIB+P8wOffQqR2xc2Hukq1J4X4PmtIuDdGZGv7e4cG9pvtXc1JiFT+MwnD8laDcKRfuJiLUTiUaWk6nTlMi1K1fvkRXEBPxNlsOXt0aEK9bYKUMfJhSaG0fnRqrQabcFq6eHq2PgAR3u1mzCBqtJSXg+RQOt91wb/p199CG2mgpdBv0b0TK0j3E;25:14IOpGGVYd9oYLyXRJheySsn9tB1S1NLyEPYmEsoQrli/xPbNFi43VvIvpKBsSf+i0mEvqQzJ+n9MwQ8umuC7Z6IY2hg7Jjr+ifVYnMU10AQvXXt8sN4XYtIDwDkPRv/R5MCyT/Y58Sress7gclQ/mywV2/nQk6mpAVVwqrCKu5hUbqWOc1KXaOh2XNbUshvav5frPdcX58Ct7IXO/+3F6/MXWdBZcQex/87PSDT9R6qxi17k1VjOMvLQRpBNRHIXNkJef+8oGUGoXuDcuZKa6iUxOhS5HCaqJDmjMMMm6GKMv2e3i7v8K/ouusSnl4ziYlU0vfkyGHMIKMPDTmQxw==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2174:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2174;31:Wq6coV1PgowcY5rZr4sxb1IRRgd2zlYGDIHmQ/notjtJpKk8xbO2z2QN72iD2QHmnO7DvgK92lhkdh1hQmNg0I4rx3WODZw87JG9u95DPvBDrlcOC562//U5YE4cH3CCXRftuBSlzMe+Wl78htmWbmUIZUpOWgf13Hwi2hSIjtiUUXMSAAItZ6D5nrI6tvQiaCpw+jg7q4z2eDruBvqjshSrhduzzCyRIKCKVi1lr8Y=;20:fE8h6cnyVoNb7CSqQHU4X+gOUBkwVs4ARUo7sfq7wEXXjW1A+aq/vHsc29tWdj/LcLmRklq3eAuFUEiCirLvlEr9PUQcVqi97QfHkW+KemQx1D2k/fO6622nk0eG9Fu/pr7ugbtLFMp28DW87VHTJHnW4EtqV28ydsV8el0hQzWIWZQElU+JlvTsN9HlZZl14jguCtxYLIjYm4ztVmT9/XRTfT3C4FKrOlNVaxZVKRrIfupIIMUkONypzjNO2wPtLe8blxx5CWJtccHUFnpBSkqzMBGjuBVzbut7vU30vxHTCtSUVsR4LhQkTQjc7SeH6FIBsuvPbGFt6W3Z+pc/FMvbvZbxJqUE8WgXC9FoaBJ1II5778PrBtozNTNqkQvGuGFk1LY5Kwfu7O5V9Xy/QYWO0hjyfHnVpjr6Mmn9ccEETE/mzYooi4iYMPpnprNf+jMM7SzoXtsg+FC9tPxuWGWpEuzlJN+b62MJDyD8J8WADZlzKW6mUPow1Wb62WaS
X-Microsoft-Antispam-PRVS: <SN1PR07MB21740EB9CFB79B280CF3CCA2D08A0@SN1PR07MB2174.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2174;4:BrW/82nU9aAm40UDjHXb2ysRq3ZSFUXpZzptrge0F5Z6slrD4UIQ2Hnq5YeCSXCnUk/16ufmUX/RO1QK6w6nVwmYMT7oNl47H4S+h67aj+SaI/SejOpw2HmBpzZWoqwgBy3kwg1wB4fMZ8n73/lz8JBC9f5BR98qP2Xbm8cBljpTsIYS3U++LmZyy3rJIwT0+LduXJRBOX39pka9XnobxEyNXSLBVuD02irjx5RWwUvN9aYVozRLaMde3ZsYVGlwUpDuvZmnbTAYOggVEiXDs4sbfUJZPOFItuSCEAsIHdYGmIizOCp9Hwf4VYSJaCOM
X-Forefront-PRVS: 0911D5CE78
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2174;23:TLchYR+rqXavG1qAFC/qRdNL8yD3KaEV5Jo46etmn?=
 =?us-ascii?Q?h1ci0D+csMyzKWTAuDlCXKbDekQCkwOX38aUTKg7VpgrtaIzjMWHRIZ5xZhf?=
 =?us-ascii?Q?o6J8jwlLqnPuqC4dG8NeL665oIrfD0isjXm8VcJtamH2LTTcYe5NQS1PLlPi?=
 =?us-ascii?Q?w/EEYc8IVkdyNWRb3GoVlWvI5rVWOgt99Nshr9kVLxJKfjJaRgZiDyVriiSb?=
 =?us-ascii?Q?aLdKNFxm1eEDOnQqnQ3udtAp70tvMdj4e9yeu3lC8vG6VvbgUqGH+CVMCU3/?=
 =?us-ascii?Q?d8h0wfyhOYbcfnqi48gExeQu2nfibXTuXSH9EvfqVEGw6L9cZpRB3CENmgah?=
 =?us-ascii?Q?Q835LCpyMjLHv0rXRYxkYr2NAAeV09Xy3yWuObwXdK8D7A4t46AMdNVfM09J?=
 =?us-ascii?Q?XwXEvLf6c0bFwRGovmGdBKDpqhhT5SWAWuAKXXQGbXDjyB/K/7NIxexap5eu?=
 =?us-ascii?Q?OVq1Zl9Ts+YP2mqqff3ikHZhx8h+WldZbmNXl1Df7I0G1yfg2+BuOsGow7RI?=
 =?us-ascii?Q?t9cRq6G5C9RKfuE48UwHZllg5hOPeXR/TIihrLFa3kTBGBTt5ifN8ihSrJRl?=
 =?us-ascii?Q?A0V4Doy2PR/0T+KEPdNAORlZBkbtodz32xjV0j8ZEviVrTrCd4HJlO90ODFA?=
 =?us-ascii?Q?SUPOU260mjh5JCQP2cD7lEqwpcIVLDOYP4n2r4nN+bkYgxwAx6ADszz+izG3?=
 =?us-ascii?Q?YRg6aCgJNUWJ/Qmo+Zx9tuSZv28ZTXq4gCAdeMN8+DHM52nGOximdV4DmNyT?=
 =?us-ascii?Q?G1pVHuCWVKo90+Ij/bO2bXn+gSJVc1qr1TpnRYCA3uY1gDz1KTf6h44pCfUU?=
 =?us-ascii?Q?a3S7PH0vRZLq8VfhyiLgIU71cH3dqfVo3zer/83BAbIgmmj9uQO9tb1gI5Zw?=
 =?us-ascii?Q?8E6xXj/qoKz3VaHqFuntsxENQzLrkZgj6WJoCT3eobz1vowkmUUYwtu+rtuq?=
 =?us-ascii?Q?I7bGU1b1wivBvLx1Bt9T/I+gg2dnl5DDB2Eiaie2tjCEtz5vQmlcyJ9tj9U6?=
 =?us-ascii?Q?LxHMwg3MzJUztuhvyZ8VRkyQUEyyaoZIQuRxGYF/DuwFIZPubddlPad+zzJM?=
 =?us-ascii?Q?/M8MrMsqVOfDagAeYwcpNLb/xI6SMN0bxbggIK86DU0ag/Oc6yt3x3Wpvpm1?=
 =?us-ascii?Q?4WU3f2X28k=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ld0R/vliYJN7Tm0Pi4Nxvafy8LbaRuaIDaXNfLSUhaBLe/H/AHwPZIF1HOBMIRdVwLz4OhZE7bxju/jO3wzT2TOCVR3cxhgmrWbEhh9RtaQHzsQwBAhq33vdCcFb9a8To5oTvuOnT8gMmmCwSqU4PtvhwsmrDegRRqDPYUYRyL6mTucrpbShA0jNAzpgIL899qaVOslskLvJDO6tAWuFoVCy/DXWpi1kz4ZukbYeKgrIRnVfYZPTHVATyErkLUHsEZGcEiZeENsHzFsEuRocI+jz7sMx0GrSYdn9iENs8Cv4YqZ9rWXOv0NGu1aWteMk
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2174;6:A24sRHyQL/6BDW4XscXJUNN0cgzE5n7cCnND+HQVs3f8Ed3JtsQMlAXli1NSUk3BhLb/Cza1tdBD8nBflq7Y8nRZIJzgfnKL3QS+RI/v3vcsxwFukqIRzKB9XI0z7CfwIoYwHoDGfDgNehTkjd5EMh4uhjWRH2ZL6+RhcO+L6HcBaV3tf46s4rvV+HXOImKfUZiMMuRWSehrES6x2a0/imNK312rxhP/wHcanaN464/oh93asW1zqCdO5GRprV57Wo9AzMCU6FlpN62LRTkYSMCWBpUa5SCw8IiKEppROC+BOFFx66h82cRB7p6RLzbl7WP9LJ2tvPUAbYag0GhD/lVVGTOoH0tWyScxdHE6PzU+8dPRu1WHix+Bb8tE8g422y7sN0U33qItPkeWSKFNxoEYkrMxt3pT0yHADQLs3ultoLKGGOTkGwfqH+nDwwhXxUlUV8vL6WhyXGQiw+A/DA==;5:H+j43+FPynsqCb1ICzZ0RScSoJ77OVi2zRr0/NRCNLtd9h8C4fL0J82GCivhbPVbj7jXyEmIw5LGpk7jT7XHdsn2+6qGVCzWWLZCz/ZgCEqJDXCPEbnivw4Z5wdjw50kDN8Jq9mwji57T0w/JVXoHYRkv8elbIeHDa0WlnX85dvjJmT4jrcXgreIs2v/gJksY5Qin8kt6zqy97SzR2QCkA==;7:qv43DO4DCRfLcxu++CcGQLkW/5EbJBuy5qmV4g0wiagBw6xoFAVRiSxJmUnGQaV917lPaYM9NpvQd0IzNJFvRxyhNgsFWMzmJRsvsXaZFo1nX8jh5gcHWDFg7LVEeSZ3ndZWAG20FSZSRXbwn5yZzg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2174;20:9ouBdNCaVcr1HilnuePB/XU5Bgj6LDYoCPVbCngkhRPS4MOlYS+16zIW5nLJBebMo/cymO/ADGWruJOBNGkj7oaBzN8LLYaxLr0RvHrE9rOMDa/SHYlGi3XTU9k4qeMMdyjpgk47DL4ax73fzou8W55f8DteWLF/Hr8Fa6d7f1AjlhStyzyx2ZuLDAJFFNKLNaNgfb1pbfzg0fKzeEdpRZrSj+Aa6Lnon1wWtoWJGo/iDBsX8y8Urq3KuEhrzlLV
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2019 12:22:56.8201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ee6d47-8729-4a22-99d4-08d67564059a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2174
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=695 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a driver support for Cadence RTC IP.
It supports time, date and wakeups from sleep.

Jan Kotas (2):
  dt-bindings: rtc: Add bindings for Cadence RTC
  rtc: Add Cadence RTC driver

 Documentation/devicetree/bindings/rtc/cdns,rtc.txt |  25 ++
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-cadence.c                          | 404 +++++++++++++++++++++
 4 files changed, 440 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/cdns,rtc.txt
 create mode 100644 drivers/rtc/rtc-cadence.c

-- 
2.15.0

