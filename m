Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07D2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D9220825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="b3g3LxmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D9220825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeKHRLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:11:04 -0500
Received: from mail-co1nam03on0048.outbound.protection.outlook.com ([104.47.40.48]:15328
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725724AbeKHRLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3JBwxEi/fWwtbfOJSFBxc0TxOWq+wLIBo4QbcKAhkA=;
 b=b3g3LxmCwpX0E99lgE1sZVLHUrt5W5rwAne7sJAA59uA77B4HOc7P/aOAZGQy0Hy0JYZjnkl3zybCWSotJrKpb1N8jz2NMUd5MhO28rCJYk7RpajMXcdVuS0fM1Ho8qVwx3qtXcvk3Z+7hRaBDvzY7STHq1ZcfsfBAPtJ7N4SvA=
Received: from BN3PR03CA0101.namprd03.prod.outlook.com (2603:10b6:400:4::19)
 by BY2PR03MB556.namprd03.prod.outlook.com (2a01:111:e400:2c3a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.20; Thu, 8 Nov
 2018 07:36:44 +0000
Received: from BN1AFFO11FD020.protection.gbl (2a01:111:f400:7c10::156) by
 BN3PR03CA0101.outlook.office365.com (2603:10b6:400:4::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.21 via Frontend Transport; Thu, 8 Nov 2018 07:36:43 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD020.mail.protection.outlook.com (10.58.52.80) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Thu, 8 Nov 2018 07:36:43 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id wA87agIV012787
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 7 Nov 2018 23:36:43 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0301.000; Thu, 8 Nov 2018 02:36:42 -0500
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH 1/3] staging: iio: ad7780: Add is_ad778x flag chip info
Thread-Topic: [PATCH 1/3] staging: iio: ad7780: Add is_ad778x flag chip info
Thread-Index: AQHUdsqpO/rMS9lAH0yRk2aMzzBNX6VF0c8A
Date:   Thu, 8 Nov 2018 07:36:42 +0000
Message-ID: <178aa1c7d2b94bb26560788b2400faef33d222de.camel@analog.com>
References: <cover.1541615978.git.giuliano.belinassi@usp.br>
         <e7f1b071157abbb92d5cb42f310fb471ea43ff01.1541615978.git.giuliano.belinassi@usp.br>
In-Reply-To: <e7f1b071157abbb92d5cb42f310fb471ea43ff01.1541615978.git.giuliano.belinassi@usp.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <62E02B72F673C14497EC9EE902E6B43F@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(7636002)(2501003)(7736002)(8936002)(336012)(6346003)(102836004)(26005)(436003)(476003)(11346002)(126002)(76176011)(2616005)(23676004)(2486003)(305945005)(426003)(486006)(446003)(7696005)(8676002)(356004)(14444005)(106466001)(4326008)(2906002)(7416002)(6116002)(246002)(478600001)(3846002)(14454004)(118296001)(6246003)(36756003)(50466002)(86362001)(2201001)(2900100001)(47776003)(54906003)(5660300001)(39060400002)(186003)(316002)(110136005)(229853002)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB556;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD020;1:ReJesdaWNCx6pLxqAamT1E66qyHZ/cdrHVgtF/uWu6tL9cXb6pJMRTQhH0tHu4RDH9MPXHxvfscWl6Gs2ytXxqDoB+yAZudQm2SUSfdBhbq1UoVk8DcvXc8dzn+kLmoq
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4848557-d921-4c2d-6f13-08d6454cee72
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BY2PR03MB556;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;3:T+Rka66drlMNsqFeKmoRDnafwpxSB/k3NJFMR7tt7PengH7G9hw2GRMnEvenwVVCbWunIBSjk2XNYfpWfV181J1ZnN9GWqJOPx4YTn9/S9hNTgB8MG/I+m4f2JLjW5hVNioR6Jb7MRWBR1527wxY4+uD5sm+M+sCheI2herGbaTTkXR8OPPG5LaaEhj7vAK0OMYIoCbYBuPxLh9eiGSkeJueB04vOY7u/m2Zw/qtisFDOiqHpCY0eN/T6fF33VbDeM1tTu6kZu7Jivj4A5vy+x2GLBLkKHmNxjcs014qfRMY9aIlhEtHfTo+O42+Zt8/H2T1xO9g+gL0nPwYUriumAzM/uH1o5TBxen5IgD+PSg=;25:hfeDRHeelGREFNxDx67NlLAsSHop4GxdyzdMzPNulRtPgkyjYvx/XOrhf15h7Cdz087hQSRj0zD/68CLTkf95N7oC1VSxL7GYzlrNQSZHQUG+4NLWYQLA/JxF2wRXX6biPrSUNm76a3BwVsByupOuMfMMTPh2RrBu813AKxrT4kwvALvTuWUY8a1h3ppCLYu0lCU8k/1fMVFJdQnliaXESUQOScfW+pwS7mAzKLI+Dql/HXvTlaLWVLSE4egf4ALXDIVc41xrX1ys4bPCPzX6VhC4HhYtfmWy1y3kpaH5u1VVmTOcotSGyfZsDBzCptP7seSVoW8ucP9073BLZx0xw==
X-MS-TrafficTypeDiagnostic: BY2PR03MB556:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;31:ijbui4hfJsykUwNjtJnZZQlQQJ39ZFi680eY5JyjVR/cmGcvYCOHPxWH6zSjNypbi+7zPqXQx0NDfBi9g0mtdX9LXA47UZumSaZ6mKIwb/ZcagMpzqN0xtZJ2EFBljCIbz6NE6VhknKsKkAnO/GX4Tcs23qVmoKbARxLNZqYnn3jYD9g0f00cLPQe1hV68eAb1eu07PgVinYtwTV89vI0ijY2aiLi+uU/M0BJny7pV8=;20:UlBwsLKUrV8GFsX+vtWmdnSoBUH4QU0DM8YWTReHni8W/NCPxqs/UK1B+eq4s6lZ463YPEPnlZO9Nik5B+cV4xhx+G/fm97N5VeI1obI6cHQse0funWWTGPYJIanMhYvMSYBie7aBeE/ku4oNcmVnT8rEjNMYPrlnEBQ5yWF5uWJC5ArQa2L0JzyfVp8UDqGLoOXM2d1qW3/YbTvHi3gvgWGb2NLKhxsRbx/DDwkC9CLpeYrG3lR3uQeVbezc0Xk4oDzjc3rAtKPAu+cw0KAu8oN/PVDyo2ghJJk+PjQirKSHyF/CzM/b13cbppLb/U51f79vPGxaOY33Eyx1LAcFahBCr9AKfEgUvtekspOJZmFeViu62Pl5FL8WkVYLMjTLlnFd0Wq1I/5ylFHuGJOLBjLSasLfXfYLXLRpfgoaB5TBjZnH7soHjwZ/sWgAfzWtdZzNThW+OkhX/lEP7X93ovXHs3UpvV3tG/zLQ6FX68VO0mZVvtDRiviZ4/yb8qP
X-Microsoft-Antispam-PRVS: <BY2PR03MB556AF71D96B1D6896DDBA68F9C50@BY2PR03MB556.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231382)(944501410)(52105095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR03MB556;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB556;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;4:pFpKbRos6fGVtGOwUKXdcIK97AAv8xKKS4ZBAvb8CSlQKfmiAgpFTJ2eEXrkMsdW2jVlv2YFYsf+T+ey+weMOrBRbUw+rTtm39AF73Zs0aXDnbO2Lzr3LQNO6AH1b5uVGRXJI6pj1eWWhXyaf1qaiq3qU82/RyjdYzhp4KuvdayoDDhP7NZb5G9RDvv07CPylWA3qMFf91gjBczw1+S9DlTj6FCfIiMe9EJXx27DefoolUxFFzNtUUrUnpo3Bi9bPN00/WT//rAPfaPNbW2kzw==
X-Forefront-PRVS: 0850800A29
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzTUI1NTY7MjM6TWI5NDh0aDUydW5Ua2xubysrUUs5RHhwMjhi?=
 =?utf-8?B?dHdWTG9XTDhTcmk0cDJic0lHdC9qYzlVNTB5cVdjTi9qNGQ1VXVYVjhzaUVn?=
 =?utf-8?B?Y0FvTXNPa2FuaDFVVlhsQWgrUVNVM2xDd1B1b0dMWTdPUXJqWGc4djEwc1dG?=
 =?utf-8?B?MlRUTDNWeTJvOXdCNGpoNDltMVpxZkxGYXZRMlkzU1NXOVJHT1B3TGVOSGNy?=
 =?utf-8?B?VDNUaTNEbjd0ajJjRjdxQUVOd2w1YUROc05vTnRoUGR2ODA0WU9lcHVDOXNu?=
 =?utf-8?B?eWFYbzN6eExQL2hoeXJSQURNd2N1SmdISDlPUlpFMzk4enlkbFZaeDVwTUdi?=
 =?utf-8?B?ME1MMTJCeVQrRFNqV3lnTXVjUmJOdFFVTk1selE0WGc0OE9sSlZLTUZCM2No?=
 =?utf-8?B?TFl3M3REL1hhWDRVR1ZTbXZLUTRHZHJiZTNLbDBFV2ZzWlJLbEhVR0FuejBn?=
 =?utf-8?B?WnNJYy81MWtMdFMvdVFtQ1FNbVVRenlWWEY4bnhUeTdiUTRwZll5Yi9QYW1n?=
 =?utf-8?B?UzhkYVo1TmtSZTIyQXoyNGtHTzJRUDhHd3VjU2txUDhyZ1RxTTd1VXBoR3Bs?=
 =?utf-8?B?Z0lFMXFzSURxN21ud0NFTERBaVZkSCtHYU13ZVBSTmQ1a3pQOGtWSVBNcXZl?=
 =?utf-8?B?bW9qc2R0RTNlRThiQTQxMU4xT0pWUGwyQTBkamkzWXlzYWx2YkUweHBFaHMw?=
 =?utf-8?B?Qm8yOEYvTjJBbHoxcTdvbHMvVHlHNDFvWmxxaXZURnZKenhqM2hZSWxvVjRi?=
 =?utf-8?B?UDZlWkRTT2ZyL3lKV05QdHl3cCtuTnU4SHhJNWExLzl1d2VNYWV0VWkrRDFn?=
 =?utf-8?B?bGdybjVqeFIrTDJwZTFRa2R5S21LdWVIb05mUGlBeFp3aVltYlJSRHJkTE95?=
 =?utf-8?B?amdoRTU1emxXYkJ5V2xXZXo5TGNUV0F4Y21DYTlReSsvWjdHUTZFZGZKeFZ2?=
 =?utf-8?B?RGZBUVFUY3ZqYlFPQjFsZFJmbklQdU44Wk0vNkdSOTByTjJ5ZDJhbG1SODg5?=
 =?utf-8?B?WXMvUHRuY3dMTE1CNUN4Z0tNMTVWbmpTcUhWRk1uWExQM0ZTYSt0bzlhZTJi?=
 =?utf-8?B?ajVXbmVLeUYySWFYeVdYemNCVWRhQ2Z3Vk5GUGo4ODZPcHl2cnlDSEVSckRD?=
 =?utf-8?B?YkQ4bXUydldvZFJaLytJSmk5ZTg5bXF6cXpzRnFmQ20yNVVHOWxMdGU0a3Na?=
 =?utf-8?B?OE9aQVRrV1ZVVWtBS2pxYmhoclhOVFUxOXBYclgzN014eVF5cXpkRklpUXVi?=
 =?utf-8?B?T2VzeHNPSm81Vm8vaGV0ZmFYMXNqS2J2U2crbjZJdHhYNFJzUVZlOGhHSGpT?=
 =?utf-8?B?SzRzU0FGQkFUSmc3eXZKcXEvMElGY1BsdTAvcjFmZWQ4M2pKdzdGWU9oV0ZG?=
 =?utf-8?B?SktleGtFV1E3ckhkTzlMVmx1bitrYkdsK3FDcVpqdmtoR2Z1N2l5LzhKMEZB?=
 =?utf-8?B?T3l0TVVrcEpGVTduaC9FQzF4bTF1dTJJSWZ3SVExTmRQUTFjdnhMOGJaUDVD?=
 =?utf-8?B?SDJVMnd3TzhadDZTNjlaa3VhdkErWVJxM1gwMThSc2x2UDd4bDhuWXB0bXgr?=
 =?utf-8?B?ZkFYK25lWUJySjRFb2J4QW9TZERhREU0YkF1NStyVENybUdiSUJ6T3pBek5H?=
 =?utf-8?B?Q2VyQWkwNnloanhDMUorYlkvY0syT1lXNGlXQTBwNFR6a3ZKaktjS3NmZjUx?=
 =?utf-8?Q?HvPjJTTAVShJtNGb0=3D?=
X-Microsoft-Antispam-Message-Info: Vn+S0qI4v33G1L3ZeT5K5XZgBMYTo0y2rY/tzGLU/a5EZs6IiMO3csORisu+gSA6NgxPEptOX40Dlessp+P9QAhk4aPFixaRXwXC4MaGpgAlb1d4/LXa7ewaV4FtJonMPKRQBYcvJNAKjON+aAtEE0hVR3aHKpYk4jgu+GzV88hxO8QGFSgYx2GxU4hUsg3md1EgRL7JvNe6W5TTpQaCtzo98lf2YnuMUikC1Cm52PitKOi/ISY4iSx4aS1AJftFNKc+7ExLniLGRj9Ib/PX7GSqng+7bza2Jmm+Q+k+M0KPwO8VrOLKqclCacl++YdhD4uN++r4QTrVdZIJQ9pFUseGhBAzY58z1a1WgIDAwYE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;6:c2Oz94uEdmZh4DWrQXYrB40rbCPbqkjwszO5ZyB8yQBBN9Sg6HLWBcw+bDekGayDHp3d5tlL6lfi9BiTx19cIAen0g0WvzBicWyyb1HbKD1pcIcjlW+aF/MaCjRPtbbiD6y2PwicecEHv84yCJPwL6HPO3q8wU6y32JH0r8xRd2k1aSCCnR6PpI8L8Ld83dI5mBda0JbFckFAZZ3FyZlNuDqe/NKL3CJWja0LFcl/u5m04Vjg2qae3Ooa8WnemhfmxZw5vdoX8sXAOQFhfDDCdKA5O04tL8C0/suRItHLblIlJnVbl1T5F6lOjv6Vnbesv/Pbtr1ugass5XII1A8aMJWeqiTw8hk/Fl/HCnmra9PUKA9ZTUyWWE4/T/BsRmLodWDNgxu1Fkly3kTD3oopJLeLs4qZJ/OUTsYu18hxR48mSBLEja7gD2h1HMhut9qDw6AxhPl8yklrluqJ0gnog==;5:5Mtvn98FeLUcn7VEoshPfp6VZtrPiP2odH27W+4Odz8NjADOH+EheZzgXFqDPYjXtBEWzo6yR4ZRZv668Y7zQyGEzh6QK2OiSSLUTGFl0415fCEX3SLkL0ykw9vfOztM/egf/LngghlpyhJguehJlhuvuxglTrNtYoIWhqveHOo=;7:CxYfoYS3Fw/Mx32TZXSkyxr7OOl7vxGbD2fxdbGUorGnW+s3yfx03faHDvdajFkm84Fl4MYzx3liFXYgrf8BC7v9fI2KNsXqXOhvbF7R1ar+MErPXO8uKaH8le2W+YTPX0zNA6iTSRTC4skpIRrtzw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2018 07:36:43.8561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4848557-d921-4c2d-6f13-08d6454cee72
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB556
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTA3IGF0IDE2OjQ5IC0wMjAwLCBHaXVsaWFubyBCZWxpbmFzc2kgd3Jv
dGU6DQo+IFRoaXMgcGF0Y2ggYWxsb3dzIGZ1cnRoZXIgY2hlY2tpbmcgb2Ygd2hhdGV2ZXIgdGhl
IGNoaXAgaXMgKGFkNzc4eCBvcg0KPiBhZDcxN3gpLg0KDQpIZXksDQoNClRoZSBwYXRjaCBsb29r
cyBnb29kIG92ZXJhbGwuDQpJIG9ubHkgaGF2ZSBvbmUgbml0cGljayBmb3IgdGhpcyBwYXRjaC4g
U2VlIGlubGluZS4NCg0KQW5kIHlvdSBjYW4gc3F1YXNoIHRoaXMgcGF0Y2ggd2l0aCBwYXRjaCBg
W1BBVENIIDIvM10gc3RhZ2luZzogaWlvOiBhZDc3ODA6DQpjaGVjayBpZiBhZDc3OHggYmVmb3Jl
IGdhaW4gdXBkYXRlYC4NCkluIGZhY3QsIHRoZSB0aXRsZSBvZiB0aGUgc3F1YXNoZWQgcGF0Y2gg
Y2FuIGp1c3QgYmUgYHN0YWdpbmc6IGlpbzogYWQ3NzgwOg0KY2hlY2sgaWYgYWQ3Nzh4IGJlZm9y
ZSBnYWluIHVwZGF0ZWAgOyBiZWNhdXNlIHRoZSBjb2RlIGluIHRoaXMgcGF0Y2gNCmltcGxpZXMg
dGhhdCBpdCdzIHVzZWQgdG8gY2hlY2sgaWYgdGhlIGRldmljZSBpcyBhbiBhZDc3OHggY2hpcC4N
Cg0KVGhpcyBwYXRjaCBkb2Vzbid0IGhhdmUgbXVjaCB2YWx1ZSBvbiBpdCdzIG93biB3aXRob3V0
IHRoZSAybmQgcGF0Y2gsIGFuZA0KeW91IGNhbiBkbyB0aGVtIGluIGEgc2luZ2xlIGdvLg0KDQov
Kg0KICogTm90ZTogeWVzLCBJIGtub3cgdGhhdCB0aGVzZSBzdWJ0bGUgc2VtYW50aWNzIGJldHdl
ZW4gcGF0Y2ggDQogKiBzcGxpdHRpbmcgJiBzcXVhc2hpbmcgY2FuIGJlIGEgYml0IGFubm95aW5n
IDsgSSBkb24ndCBoYXZlIGEgZ2VuZXJhbA0KICogcmVjb21tZW5kYXRpb24gZm9yIHRoZW0sIG90
aGVyIHRoYW4ganVzdCB0byBrZWVwIHNlbmRpbmcgcGF0Y2hlcw0KICovDQoNClRoYW5rcw0KQWxl
eA0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHaXVsaWFubyBCZWxpbmFzc2kgPGdpdWxpYW5vLmJl
bGluYXNzaUB1c3AuYnI+DQo+IC0tLQ0KPiAgZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3Nzgw
LmMgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gYi9kcml2ZXJz
L3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBpbmRleCA5MWUwMTZkNTM0ZWQuLjZlNTFiZmRi
MDc2YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4g
KysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gQEAgLTM1LDYgKzM1LDcg
QEAgc3RydWN0IGFkNzc4MF9jaGlwX2luZm8gew0KPiAgCXN0cnVjdCBpaW9fY2hhbl9zcGVjCWNo
YW5uZWw7DQo+ICAJdW5zaWduZWQgaW50CQlwYXR0ZXJuX21hc2s7DQo+ICAJdW5zaWduZWQgaW50
CQlwYXR0ZXJuOw0KPiArCXU4CQkJaXNfYWQ3Nzh4Ow0KWW91IGNvdWxkIG1ha2UgdGhpcyBgYm9v
bGAgdHlwZSBzaW5jZSB5b3UgYXJlIGFzc2lnbmluZyBgdHJ1ZS9mYWxzZWAgdmFsdWVzDQp0byB0
aGlzIGZpZWxkLiBJdCdzIGdlbmVyYWxseSBnb29kIHRvIGJlIGNvbnNpc3RlbnQgYmV0d2VlbiB0
eXBlIG5hbWVzICYNCnR5cGUgdmFsdWVzIHdoZW4gdXNpbmcgdGhlbSBbZXZlbiB0aG91Z2ggaW4g
QywgdGhlc2UgYXJlIHByZXR0eSBtdWNoIHRoZQ0Kc2FtZV0uDQoNCj4gIH07DQo+ICANCj4gIHN0
cnVjdCBhZDc3ODBfc3RhdGUgew0KPiBAQCAtMTM1LDIxICsxMzYsMjUgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBhZDc3ODBfY2hpcF9pbmZvDQo+IGFkNzc4MF9jaGlwX2luZm9fdGJsW10gPSB7DQo+
ICAJCS5jaGFubmVsID0gQUQ3NzgwX0NIQU5ORUwoMTIsIDI0KSwNCj4gIAkJLnBhdHRlcm4gPSAw
eDUsDQo+ICAJCS5wYXR0ZXJuX21hc2sgPSAweDcsDQo+ICsJCS5pc19hZDc3OHggPSBmYWxzZSwN
Cj4gIAl9LA0KPiAgCVtJRF9BRDcxNzFdID0gew0KPiAgCQkuY2hhbm5lbCA9IEFENzc4MF9DSEFO
TkVMKDE2LCAyNCksDQo+ICAJCS5wYXR0ZXJuID0gMHg1LA0KPiAgCQkucGF0dGVybl9tYXNrID0g
MHg3LA0KPiArCQkuaXNfYWQ3Nzh4ID0gZmFsc2UsDQo+ICAJfSwNCj4gIAlbSURfQUQ3NzgwXSA9
IHsNCj4gIAkJLmNoYW5uZWwgPSBBRDc3ODBfQ0hBTk5FTCgyNCwgMzIpLA0KPiAgCQkucGF0dGVy
biA9IDB4MSwNCj4gIAkJLnBhdHRlcm5fbWFzayA9IDB4MywNCj4gKwkJLmlzX2FkNzc4eCA9IHRy
dWUsDQo+ICAJfSwNCj4gIAlbSURfQUQ3NzgxXSA9IHsNCj4gIAkJLmNoYW5uZWwgPSBBRDc3ODBf
Q0hBTk5FTCgyMCwgMzIpLA0KPiAgCQkucGF0dGVybiA9IDB4MSwNCj4gIAkJLnBhdHRlcm5fbWFz
ayA9IDB4MywNCj4gKwkJLmlzX2FkNzc4eCA9IHRydWUsDQo+ICAJfSwNCj4gIH07DQo+ICANCg==
