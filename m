Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A29C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A5F20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A5F20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbeIYVas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:48 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:26287 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbeIYVar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:47 -0400
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id C29D0619B6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 15:22:47 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id C07EDCC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 15:22:46 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id A1A484C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 15:22:46 +0000 (UTC)
Received: from TU4SPR00MB08.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:805:1::18) by
 TU4PR8401MB0334.NAMPRD84.PROD.OUTLOOK.COM with HTTPS via
 SN6PR0102CA0005.PROD.EXCHANGELABS.COM; Tue, 25 Sep 2018 14:32:49 +0000
Received: from TU4PR8401CA0007.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7704::17) by TU4SPR00MB08.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7717::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Tue, 25 Sep
 2018 14:32:48 +0000
Received: from CO1NAM03FT026.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by TU4PR8401CA0007.outlook.office365.com
 (2a01:111:e400:7704::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Tue, 25 Sep 2018 14:32:48 +0000
Authentication-Results: spf=none (sender IP is 15.211.195.16)
 smtp.mailfrom=sgi.com; hpenterprise.mail.onmicrosoft.com; dkim=none (message
 not signed) header.d=none;hpenterprise.mail.onmicrosoft.com; dmarc=none
 action=none header.from=hpe.com;
Received-SPF: None (protection.outlook.com: sgi.com does not designate
 permitted sender hosts)
Received: from G9W9209.americas.hpqcorp.net (15.211.195.16) by
 CO1NAM03FT026.mail.protection.outlook.com (10.152.80.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1164.19 via Frontend Transport; Tue, 25 Sep 2018 14:32:47 +0000
Received: from G9W8669.americas.hpqcorp.net (2002:10dc:311c::10dc:311c) by
 G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 25 Sep 2018 14:32:32 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G9W8669.americas.hpqcorp.net (2002:10dc:311c::10dc:311c) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 25 Sep 2018 14:32:32 +0000
Received: from g9t5005.houston.hpe.com (15.241.48.75) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 25 Sep 2018 14:32:32 +0000
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5005.houston.hpe.com (Postfix) with ESMTPS id 00B1341;
        Tue, 25 Sep 2018 14:32:31 +0000 (UTC)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PEQ6dG026100;
        Tue, 25 Sep 2018 14:32:31 GMT
Authentication-Results-Original: ppops.net;     spf=none
 smtp.mailfrom=ernstj@sgi.com;  dmarc=none
Received: from relay.sgi.com (relay1.sgi.com [192.48.180.66])
        by mx0b-002e3701.pphosted.com with ESMTP id 2mqkge9tpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Sep 2018 14:32:31 +0000
Received: from stormcage.americas.sgi.com (stormcage.americas.sgi.com [128.162.236.70])
        by relay1.corp.sgi.com (Postfix) with ESMTP id 3B93B8F8059;
        Tue, 25 Sep 2018 07:32:30 -0700 (PDT)
Received: by stormcage.americas.sgi.com (Postfix, from userid 605001)
        id 37CDB200FB79C; Tue, 25 Sep 2018 09:35:04 -0500 (CDT)
From:   Justin Ernst <justin.ernst@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <russ.anderson@hpe.com>, Justin Ernst <justin.ernst@hpe.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Raise maximum number of memory controllers
Date:   Tue, 25 Sep 2018 09:34:49 -0500
Message-ID: <20180925143449.284634-1-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.12.3
X-CLX-Shades: MLX
X-CLX-Response: 1TFkXGxIaEQpMehcaEQpZTRdnZnIRCllJFxpxGhAadwYbHBpxGRMQGncGGBo GGhEKWV4XY2NmEQpJRhdCWk91QkVZXk9OEQpDThdfUm5lZxtdYWBnQR5BckBnc2lEe1tpS396Tl JLe31GZBEKWFwXHwQaBBseEgcbGRxJGx5MGAUbGgQbGxoEHhIEGxAbHhofGhEKXlkXeRkBX0sRC
 k1cFxwaHhEKTFoXaWhtaE1dEQpNThdoEQpDWhcbExgEHhIEGxIaBBwcEQpCXhcbEQpEWBcYEQpE SRcfEQpCRhdnE21gG1tlQh9+fREKQlwXGhEKQkUXbE4af3NbX19BfF0RCkJOF2xsfU0ZSGtnZVp pEQpCTBdnbRxbGUBac0RyZREKQmwXa1x4bFJTR20TaF0RCkJAF2wTRl58Hh1sGksYEQpaWBcbEQ
 pwZxdvUxlsBX5ZGExMUBAaEQpwaBdsSGthTlIcTUBhHRAaEQpwaBdnEm9eYXJOXxtYUhAaEQpwa BdvYBwYG1BLSxsZHRAaEQpwaBd6bVgcTk9lBVtrARAaEQpwaBdnfnNIaWFyZWEcQRAaEQpwZxdk HAFNSRhtc29zQBAaEQpwZxdjXEYdRW5sZUdEaRAbGxIRCnBsF2laXmJuaUZGEwF5EBoRCnBMF2l
 ITRlcWVNceB1gEBoRCnBDF29IWUVFbhlTRX5CEBoRCm1+FxoRClhNF0sRIA==
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_notspam policy=inbound score=0 priorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=180
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=819 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809250145
X-HPE-EXTERNAL: 1
Content-Type: text/plain
X-OrganizationHeadersPreserved: G9W9209.americas.hpqcorp.net
X-MS-Exchange-Organization-ExpirationStartTime: 25 Sep 2018 14:32:47.8266
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: Original Submit
X-MS-Exchange-Organization-ExpirationInterval: 2:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: Original Submit
X-MS-Exchange-Organization-Network-Message-Id: 5fd3cbc9-dcb5-4454-f4f1-08d622f3c3e1
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-MS-Exchange-Organization-AuthSource: G9W9210.americas.hpqcorp.net
X-MS-Exchange-Organization-AuthAs: External
X-MS-Exchange-Organization-AuthMechanism: 10
X-CrossPremisesHeadersPromoted: CO1NAM03FT026.eop-NAM03.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: CO1NAM03FT026.eop-NAM03.prod.protection.outlook.com
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:15.211.195.16;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(366004)(2980300002)(428003)(3190300001)(189003)(199004)(42186006)(107886003)(356003)(97736004)(5660300001)(4326008)(6666003)(6862004)(450100002)(305945005)(48376002)(51416003)(34290500001)(53936002)(50466002)(1076002)(6266002)(68736007)(1857600001)(2616005)(486006)(52956003)(42882007)(336012)(106466001)(105586002)(81156014)(8676002)(126002)(103686004)(476003)(36756003)(44832011)(1096003)(8936002)(16586007)(47776003)(116002)(26005)(54906003)(14444005)(156004)(50226002)(81166006);DIR:INB;SFP:;SCL:1;SRVR:TU4SPR00MB08;H:G9W9209.americas.hpqcorp.net;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT026;1:iF7sHXSw9pZSQHh/+Yf+qTRElJ1DjbUv6X7ttaVZobNmROYq9j0Tdx8RSWrbZLyEOpoHjNLs1JuQ+/x0A7qwfgBZi/VbWQj0Szc0hqdLl0ZoiowtIyWAQ2yNUA6uIgT+
X-OriginatorOrg: hpe.onmicrosoft.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fd3cbc9-dcb5-4454-f4f1-08d622f3c3e1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7153060);SRVR:TU4SPR00MB08;
X-Microsoft-Exchange-Diagnostics: 1;TU4SPR00MB08;3:o+2lDyezdYPWPu4CF7s1GlASAKU8D2HXqEYc1agT26AIbthfVnxNRUQjO5KcHWcpasMYjp5KtuwCTcsvfKLk0ZY22D9KF/T5l+0Wrm+oGHUIn2719mq+wQZ30/xaL3/X1i63BI0tmMiBrnZjveg9AA3/xTroGzr0LPopSYoPnxAjZYjnFUXW+ZAfkD4RK0+1icP+ohtmoX+w3a7kXoklSFaJ+u8wbEM+QxiHaK/CE+R8747Q5iw3jg/uRK77xIfEzQw86Dh+/Itl/bpLD09adGXi9v/VdIIai9RDnKUYu7HPOY6LFFc8LFh8kzWksanX8FjYriIqrL7jH8GZwqAvp5XffTpzvafTcwzJXiIMMNE=;25:1HmPlVuxPC3zvNvZ0yH47IfPz31a9kG3YZaa9PELRTKK30GyZm7JxIZ6H6cqys8yTw9YuGeEa2BUTirBrxW1rqYuCn5I0/kPde4JbS2RVRgTCPeFu6U06NIbYjoWPpMwf1sgvbh+ndbKGYDb3L04krNaww9II+rZJpqB3K+yGk3zEy8mw9pQu0/ruuY5FZoLRPGMMoPSvf6PSPv1iTIVEDLsL8jw/VrQgym6ByN7ehc6Tzfr8akKf1fm1Mpe2HHbOkfqZB+TofqGswxKwlFn1ntDoUirLXY5AJUQ7KJj8UVvxXqH1zLJNcAhnvFUEVdUI5/frSAX80TFp17IVmWJ+g==
X-MS-TrafficTypeDiagnostic: TU4SPR00MB08:
X-Microsoft-Exchange-Diagnostics: 1;TU4SPR00MB08;31:wM+S5sK+tYh0PBRgHpATYFzyNE1JdtiHVExNK7cUFgpYlqW0v5UBCLfGYynA544/dHlE6/SZcbbq67w7GkWyTBCPn/vl5aLI+bC/BdHQly3bV8ITW80tLFrAJGYApKq9SpR02lB1/dpbvcpXz0p5itkxTaAkcMrh5yB8YD7knj+wUp8zP88BNHucgi09WEnYs3OG6Vp9S7ALEnup4F31bYTmEp4v6KqAfM2bEK/RMVc=;20:YHNHinjTBPf5KiW5Sf5f48am2c9mxq4iCog2xj6CAYeQCVifTNzDBpc4DLwDD7+AMqpoIVlWBy7oYGjlWUGoXdQ4fOc7NAYFeV0VvVpcw7/kkPxDZnOyF+qoPNOkdOjdo+cgRQUPHmcQ2Sg2sUgYLSMyusrZ3xDfaKFqrrjTpgW4CzDqQTyyyMEaEDwlouqn5PGLNCoQie3bWYzZNAo0E2dw2+gLSCIrPCcz5ZHYvx1IkqYjPkWIfm4TvkVoChx0JN63hEqVVRqT77O7aOaI9+z0GQzhBgcC8cNxNwQE5pSXJn4MQDOFAt2eYFQJDYsGyBferBmAVRdxpEla9XIVh561RHHSONLqqbnfgTjRpb3itCYiRqyF6WGffHSRl3nwHMVh//+sqmXtWGIrNy8tp09Ue+d3ABs7bwIJpP/lqiS+F5dIhRf4XaWoKCZlp666xVGRBw5vQ9q5bz0OBtaoeVjuqb0XuIs1ds9mHom2EqDWkKv+HG5rrFQwAjumenIB
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443)(9452136761055)(227479698468861)(222181515654134);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(2018062399030)(2018011200283)(2401047)(8121501046)(52410047)(2018011210174)(2018011211064)(2018011212028)(2018011213028)(2018011214028)(2018011215028)(2018011216028)(2018011217028)(2018011218028)(2018011219092)(2018011220252)(2018011221063)(2018011222027)(2018011223027)(2018011224027)(2018011225035)(2018011229035)(2018011232269)(2018011233052)(2018021202149)(98810176)(2018021203149)(98815176)(823300264)(823350442)(823411253)(3231355)(901025)(902075)(913088)(7045084)(944501410)(9300000166)(9301004277)(52103095)(52105095)(52106170)(52408095)(98821027)(98822027)(52401380)(52601095)(52505095)(52406095)(52305095)(52206095)(88862231)(88860193)(12181506113)(10201501046)(3002001)(12181509095)(93006095)(93003095)(1610001)(8301001075)(8301003183)(201708071742011)(7699051);SRVR:TU4SPR00MB08;BCL:0;PCL:0;RULEID:;SRVR:TU4SPR00MB08;
X-Microsoft-Exchange-Diagnostics: 1;TU4SPR00MB08;4:mQTdpw4KdZntl0vtGF3cImABO7YnvKaQRgineolDdIVU6FTyLvsOYGj3QjNiFPf9RPGaVOCZxnT1UYB4JOCAE31aXpIZGqO9IpsW5q6+8GOYK9dia6Wzm0s+xMzxmNd4nP+J3LXENELbF6Kw4DMTQcM2kuXg4YBJy00I9M6MUXYmU5fZ1wXdigPqV494Jc3u9WDbrOZgfVyvvbIjvoa4SNRRBKg391O/2ynMTh4t7+Rz9XdKnyoLvF3nDN1XOvyFI/KgeivUaaaK8Oe1PJKXAxJocKLN2GJoBiCCxBZMvspbPiCjPj/uOG/bSddqImEeRe2a6iOGjI9x3OAVwLXlvhkI96CqEQqprWQKaQSqDohCY9aYNZqwmyWnOqGI3aDzg3ux/Q4gDEsBFPxURzWb9zzDjVo5nD/eitWv+TnhCDM=
X-MS-Exchange-Organization-SCL: 1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;TU4SPR00MB08;23:69eAlBOAGRDLZLkGs+n1+WOVxe2mQmgD3EDEI6fVGE?=
 =?us-ascii?Q?brOI7VK02jn8eUBiUq5nP6fKowN6mUem1tWeIB8qPuaO3mHm6i8za0TpgK/+?=
 =?us-ascii?Q?aLvDSmltoShPF0umJls1IUf4siM1HUlIsw/S2IDzIQ1+3hXEluoE+JfMSttS?=
 =?us-ascii?Q?uL8+zGsuTZJVWjQXr0g3q93dhcLW0F9O9elm0FdvG8hN+N7OkVFYl6XjnJnl?=
 =?us-ascii?Q?DA9jTrzTLQlynAniIW/nMANAgUHfWE0ZjeusyC/4wEEjoZkI3Jt1y2UTuVmm?=
 =?us-ascii?Q?IBCph9Dwr7lXfogSphczzFkm8BXydBb8Fc2COvYCyFZrEeEMhJJaPh4ZjCGS?=
 =?us-ascii?Q?FdQx593Xb5PjX90+CvANhMO9MNNY+rDNWty0Co6NJP/uboyXCLQe2rjwg1j+?=
 =?us-ascii?Q?hSysacNp4KzgfFUTZ+YMTJ8Ewj2PV+GIsXjInP/3rYhj+piAx780uJDck9g9?=
 =?us-ascii?Q?7xK5ikBaJ4R/cExIIsLVPQTTrYHz05EMUzEWJbka22PQezrtUygHOsndhlhl?=
 =?us-ascii?Q?REypy9n0GAUlG52o/55Iq7INul3dYBD65CXxVfTaygzBLUocjtH2MISNJKeE?=
 =?us-ascii?Q?YBHwlDw2pLUfUsSPJskzAqjlSjGAQegVu9tqZKtjwZLfZi3V5vxRR6+rS4TD?=
 =?us-ascii?Q?Tw7PZxAMDJLYEO3jh1YogruvUMgjzEYZGJdB9RIVo/Sf0sE4G0YlxLfBt+Dn?=
 =?us-ascii?Q?yiIHKgPr2w70BGtjaXKA/PTz/Zg0QYfwX8b1CZMdRzJTRWODC+boXF9NYe7j?=
 =?us-ascii?Q?lRTztZBbmdZ6Ay4v1NrHNOxlN2FxgzTBh82mfE6WBKdoZu0MdlfJpWyh5nLs?=
 =?us-ascii?Q?TJ2rqJh+5mD76Y9tBr01Xk8nfRb98fx+foptcrub5IGelXL/Sb6rHTL4nIfj?=
 =?us-ascii?Q?yYno10hWuOSRmzH4+m0cF9nnCd/aZhN3u5+4lc2JC2UAMLN5MP9drPSmmYCr?=
 =?us-ascii?Q?+SduPS8SAeguFp2UbopqLpzDeE25eN8Hp4pLG3oj0zjPnNFN+B4aQlY2UeDv?=
 =?us-ascii?Q?RyG521cweTMt7SNW9TZOkejNlh8R3iB7wIc4dhQImAs/THB06IU5hmQ3ri/k?=
 =?us-ascii?Q?XDupadHlVrLWBXF+Xtq43JcsKar+wfd5eg4yA7q9yWjrdA+QkCBHkmAxhZJo?=
 =?us-ascii?Q?EU3FG3sxI0DwjkOR9bL+Z2HT5IqxX3?=
X-Microsoft-Antispam-Message-Info: KDhjbsuw8sIfZbfMeLxU4m1qvuVXA4UiK/RjD5zlhhLPTsF7JkyjMyrMQRbnnLHJzwe6lq95UBmW5qJKflCKofGmDcbve5XFP2RBaAgqgBRWRD9WwVU3P5Nnoy+4pBjVegbJv8TfRbnIE7DnXzHYLiiDhg6jleB+qhgipvwobB1lqZYGbFrAiSlx3EkKh8uvzlBnyb8WwB5wymWcoF5tlwJ5yGDYU7suuZblcSVQGjxibyCt7+tMsy+VOVyY/RErF3K0ALXFqiyDjoxmI2FmX63I3z+VfwdJRgiG3+sdQxzsJ7IxXqR+S+6lBfVvUlPSv0zS4tvNWG4CQM/pH63c2U49ZNmxUyK04mpAvfnFrEbbHidusGowV/2aHJJ4zwr6jYdbrbtpDwt070UbQvRjRyLre+gzDkOn8pM/zhFFJYg3sCkJRXQjGiNNqM278yrn9bIBfIvYNveXS03KFjjYLnRiBSSJoaljWtOdB3ECd4mKU3GtPD/dz9iAezhKUMx3omYZ0X9HY/re+qdLHmCzqgiUI2aEugYAbWtZb4ZfAhmh71F0k375nRc/tFOSTbENK8DPrsseyZV3dnpPSllbP8K4KNM4CrYkT0Q87+wEiwyAxBn8bNdxUyGiKPdJNJ+voKjPyTxCfudL7+enOO68mbSkZ9w7iffAzo/gjuNJS9T8IyA/fZcx1awlpqNZOfjT
X-Microsoft-Exchange-Diagnostics: 1;TU4SPR00MB08;6:AKjVGSkgS0b6maDxRZFOfNb/ed2S/usFmcELO2on2y9MUffh2wMtCK/MR0krO3yNeBWlmWb5pQMJUxuZaOPF2o1+3yvTv9UfN7JIUfJBS6MemE/vfuSDOQvF/H9pxYBSwNM582/1YRnR7988yo5lyAAWOCdPzqdL/RRHv4IT9FNZrtl5GOu8FwLo35tShfAh7vWFV4rnq0PP9N5RdqTco7O0gpygZe+2SE5MsFKX6toswmAZZiE1fVQEsLHaia+uy/ozwsIZvyPVaZWAy0I5+GphAZ+Dugy0Re08R6+9lFuEKmFGxy0c7WWYGr09bUNY6a9kKIKBlaz/Qh0NUmeV1GkOyjc7/iXjY304oLgw5IJGzSVi5AeFL5xiTKE56VT+hIQIwiE5cVay9AKBLrdDjxLFWwyCBfkJrK1i7ExWhleTAvi1+dp9Gj/u/wph4Xy+Ohm6T2RD6XTXoxz4syGvOg==;5:NJPNjpAyO8+/Q743QxOP6xNOw5gdmXU4PwKiN40ziBG6OAhfW1vJ79k0pIrFrLD6TKp3le27z0CkilHULN/F7CZrQeFjlByzspEYEWIBgiboc6fFpT1kyC6q71Z/7/1oZm1Q/j5Lxma+yG84NI169ztOAQ1v495mcSR0nU6ufKc=;7:oG8Pjl6MMmX0b+UF8ng7ackTsDOS6iDw9Gxag2q8nK4eS0BN1Oox56epvVrNC+gcphZxWpUy3nE+BtXikKcZQd7uGKxVvW62dDwbzA1ZrPKyTGOz05lCIW1jg9AyWw9KwiQM+HwDrY3Ub8Aw5+/4iGE0TZwJYAuYUwx4UpO1/Yh/yuhD/FrE4VUN6hp/BrIoL7dKt/uEqVynkJtz10FqUXBlzgCqHkw6sqKV5+YnEgDyl9sypjkWqdUroFyYyXPm
X-MS-Exchange-ABP-GUID: 02950aeb-3c14-4da5-8c60-ccbcc3967284
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 14:32:47.6704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd3cbc9-dcb5-4454-f4f1-08d622f3c3e1
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=105b2061-b669-4b31-92ac-24d304d195dc;Ip=[15.211.195.16];Helo=[G9W9209.americas.hpqcorp.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4SPR00MB08
X-MS-Exchange-Transport-EndToEndLatency: 00:00:01.6352243
X-MS-Exchange-Processed-By-BccFoldering: 15.20.1164.016
X-Microsoft-Exchange-Diagnostics: 1;TU4PR8401MB0334;27:r36JuMupjTVHEO5aJBl94p39Il82dTUwBjqVX1TR9X3nYAA56SnL/YUaNS5hAO3Zhnq3AK0QxLkjA5SZVsGwM1byERiL4WcX2hoKXYmwcn3xaOSMqRSsfTQmPHlprLmtfZP+wdJd+gsqYUjt/NJnwrBUVq9Wa+yN/wBtoRpm3AdAI15bApvqmst+wBQFoODoKYqJOcbi/1WnZz5y5KZeUBCBXbdszX/losKcOBbfNYYmYrCxcoNNdyxhHC9wKtBlxD9cyZSEf9Ww/7MDhCnj42Iovs8YPDAY/jKU4fiw57qMtg3Z58m73Y+at0EJZelgo6yGygpHeRimSXxbsk/fa2ROargo25c5u+ubDUJwMVmqhpnoM59DivEGZkDeLY+DCLNKh1w3Cy246TIxumLgUg==
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;ex:0;auth:0;dest:I;ENG:(20160514016)(750119)(520011016)(944506303)(944626516);
X-Microsoft-Antispam-Message-Info: 5e4EoNS+e46XSgtLjTdHKd/ux4pxWy+tuMDwwXkJj1gsBB4m5rYlSAlCINKuyWLnu4gkAghV8crwTdWI1btMqree4OYZPL2kkdq0vmW+MyYS6Pbw9r/ZSmzSGC1K15+7npndgzqwedrtKN8fmmuQJoQL9FnZMjpf0ctLUS8B+bRCoLVJ0Pr1EfMwiOt6Y0ttYUd3/AlC0Ww+AtVNDDMppvFl+ehmAG7/s1Yec/HK28IB+DZpwyJJDakiaNf1nlMW57/vvBQTDM3XGPBQVqf9Vlb+HW8embPvK1Ly66OcBY1NqISpGLhJFK+zMfLMd2VaF/dsPilR2fY1RGLe2GIoYtCyG0b57nCXoYLmxat1q4eY1vBPurHB8dmasRNk7Rnf/aeyUOkdf1hov+tKSN6fWl2nlQw6tYKaGuTe2/QMEFL1Ska/9SYl+Gs9CXHl6HkYI/8gsD0UN3MnHu7cqfc8xfDq4cC7XSaHnRZPv3Q05TUPyrj712Oq7Ex3lTye4nE7N5bEjnkxSOW2BWvU+AwfRgxEUbCyqxy/PY6kvOwhjSp3hOWEMK+9T9Py4xIxK7tx2gLXT/8sRjNtFuJ43IKTqS5V4R/bGEsZv8Xv8gJTFFcom/1QqjpkLimko7DD18PuXQt1SM64izr8WveJkr1WRybDVBZrnktlOgEBO8nsqZTjtx+gR+hkKtsxf7XxDZKOBzrqDakn2+Fly5HL2WeJce8N2ZDYLPqKLGeJytXADjsJLgLapswphpDPUGt0D3kO
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We observe an oops in the skx_edac module during boot.
Examining /var/log/messages:
[ 3401.985757] EDAC MC0: Giving out device to module skx_edac controller Skylake Socket#0 IMC#0
[ 3401.985887] EDAC MC1: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1
[ 3401.986014] EDAC MC2: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0
...
[ 3401.987318] EDAC MC13: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1
[ 3401.987435] EDAC MC14: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0
[ 3401.987556] EDAC MC15: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1
[ 3401.987579] Too many memory controllers: 16
[ 3402.042614] EDAC MC: Removed device 0 for skx_edac Skylake Socket#0 IMC#0

We observe there are two memory controllers per socket, with a limit of 16.
Raise the maximum number of memory controllers from 16 to 2 * MAX_NUMNODES (1024).

Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Russ Anderson <russ.anderson@hpe.com>
Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
---
 include/linux/edac.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/edac.h b/include/linux/edac.h
index bffb97828ed6..958d69332c1d 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -17,6 +17,7 @@
 #include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
+#include <linux/numa.h>
 
 #define EDAC_DEVICE_NAME_LEN	31
 
@@ -670,6 +671,6 @@ struct mem_ctl_info {
 /*
  * Maximum number of memory controllers in the coherent fabric.
  */
-#define EDAC_MAX_MCS	16
+#define EDAC_MAX_MCS	2 * MAX_NUMNODES
 
 #endif
-- 
2.12.3

