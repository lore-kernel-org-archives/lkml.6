Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2925C5CFC1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A78208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M46j2VMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A78208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754482AbeFRCDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:03:50 -0400
Received: from mail-eopbgr690074.outbound.protection.outlook.com ([40.107.69.74]:3200
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754053AbeFRCDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z45MjLZtiDxZPKfmTBW9f8kq+dXWI5qryFqwS7YcL7s=;
 b=M46j2VMPvJXq9Ht19tV+jzjwRQv9xU8WmaamtqalLMxH/isVmPtY5syT+9wWaZdltOwHLWNUOYp3kRkCfxvOCYwRA4/zAJlG5sbsBqo7UyX9MYDb66ZygrMA5mpkFIKhTNtARVZNtzxb4qSU8tGNpWKbRVciSaKMILbPvBS2Ciw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from [172.27.226.62] (165.204.55.251) by
 DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Mon, 18 Jun 2018 02:03:44 +0000
Subject: Re: [PATCH] drm/amdgpu: use first uvd instance to avoid clang build
 error
To:     Stefan Agner <stefan@agner.ch>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     James Zhu <James.Zhu@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180617085218.7753-1-stefan@agner.ch>
From:   James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <625b2c05-c923-cd5c-cc48-cbc51ba3d3ee@amd.com>
Date:   Sun, 17 Jun 2018 22:03:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617085218.7753-1-stefan@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::28) To DM5PR1201MB0107.namprd12.prod.outlook.com
 (2603:10b6:4:55::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fad608ab-7d62-482a-677b-08d5d4bfb917
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR1201MB0107;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0107;3:dgbExJ48m2qPROmM7nVxbO1/BD/mHgHdyYTQLaKr0R+gheY/cg3KCdP2SO4zL8TSlvQlf8wty1mdQ3flFWD9Bx4stTTmHqJIN7kSw1yfHQ+Zo8Q5nOnLnezPlel7Q04ok0FirPrJBZo907RQ+/rRPfpw1xRe7PLaSSQIw6j1A9aS7MKDXvoYbJUBf/bHtXqKnQ59wQ7pp4Y4BAtlCz083YEH9KY1Eave1MRb4ndSdnhVQ4fpD17h6Wh71twNfprA;25:vHBT5s8S1z7GNtfdwnJgEYF39XQuNeeQjnCE29VM4drnh0JKfpuwmzpi1Q45w3yTJd2p4QMOIC7a75/V58K0hTOtSxKM3w3mxysRtHwAMeeXmnaTcAO4f+JKTFt8rcxEPKlGMd+XRgqqqpLMJIzrvsTmBKTmFB3w1vMXVBdBAFtNSqGx1T5ordn5Gi3GegBZR0ohKjMDxkDRVxj+s+N28O7Ud87wCEkaoDaQt/QW5MlohX8LFSIdXUuOciGCXrEWO3jfmeKOE0NS/TdkAEAmWjlj6qT2E9PmzuX6oEyYGqA474Ko3iGWrQgVVzCbBlhUJpiOckzFDibDkOmoTPRlDg==;31:zQHClC5EEJUXZ5x0Dnh8I+5mVYZcYr7HHA0Qjul9o1LFeCU8abeEn5jmfEwLDaO1AWN8bbqeG+TAS8qHZZYNRgub2Jr4gCBUK2SGH+2FFhYaUEhyPR99pY+DY9qO/DqEGaOckrkE6pXB5gdSBKUxrUV0FP3bwNqmLVpFMTYumuZxl46dVaoAkOGybReGpR+1d7mznaLck5+8j8G+0lwUHdYZM4VYIArDV2J0QZWtXGQ=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0107;20:KUQ4EHxjWwvmcVqebj/YMXSJyxXTT61yRQ/gfoT7hfZW+gdN5LaVeqS0O+B2UhHQJz3cGGDQLKLNrvJSvlUeuWqUK8gSLWzC9etVNYrjcC6+OAsi/+5fA1BD1uKnSKqdWQ8RjPFfpVoG0HFAA0NwL2aZ8lwHxp0JfTrvI1NAxm2IFvG1SZ6kASNp0prDsI6MnZzvXkcGRUjOFgZ69T9z3RI95ZQw8E32E6Velr0T67vv3UCcDy+CJ21vCSxZQ/pkJN6CReZT51qGc8Np3JcEznYY/9MMlaGnBUCF+zLCmWzGeeC+t+/wo9+yiw0Q/2Lf2w8jwzJ7gWXa+dv+QwoWLN7VQq0Pb08ILuiBxF9kp5bk53d2vAYDEfW1Ucd8GWBW2SXtH7MIGikOceGIrblwii7po1+7Kr56L4VBwXb/UqXEx92QwwsU5Xnk58Wt5c/nhMG53ay7zs66pi/NdwhJR+o7HeIMj4VdusCjfT8cyxFweLXtUSmd9zk3c7BW1Ibg;4:Kl3na2nx0dD6sbschqNAyUEVRFyrRb35eiOq+zx+sNrHurqp3X88vxqXU2JFXL0xeTyC+aBd1oK2chrQ9l0g6hKUkYAiF+xYFqWTLoww+kP8QxgFSt2ouvdB+wM9tJPWdASN/Dl4Y9b2YKB60/LvSHXZC/mGwUnUH2L+rAIM3qGm/at/NsbzFdULdUp2C7inSsu/ww4nLXHQM5oZCjV7LOhxi0C8rp6qoPM0GzCrSp3P1y37XYeJVB/Wdo4mhtRuLi2q+P3x+cYTOyoQhUxEMVJo32y8g5MiRmj/N/us32oxbxfkZGEplSXbTPerZ+Eg
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0107F04B9910944EB81BE1B0E4710@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR1201MB0107;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB0107;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(39860400002)(346002)(39380400002)(396003)(189003)(199004)(25786009)(186003)(16526019)(6486002)(106356001)(65826007)(5660300001)(68736007)(53936002)(6246003)(36916002)(7736002)(478600001)(59450400001)(52116002)(2486003)(4326008)(23676004)(52146003)(386003)(230700001)(229853002)(305945005)(50466002)(31696002)(26005)(486006)(53546011)(76176011)(105586002)(77096007)(3846002)(72206003)(8676002)(81166006)(65806001)(47776003)(31686004)(97736004)(54906003)(110136005)(446003)(11346002)(64126003)(66066001)(65956001)(36756003)(956004)(67846002)(6666003)(6636002)(58126008)(6116002)(316002)(16576012)(2906002)(81156014)(8936002)(2616005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB0107;H:[172.27.226.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjAxMDc7MjM6YWUrU2pDVkE2R3lFK2VCTVZLcFpuVW9R?=
 =?utf-8?B?dXJyUUpGTHdmK1J1WUs2bkM1ak8xNUNKRHppWXhFd1hxUER3aURkSk1JTStk?=
 =?utf-8?B?RHQxSXl0US8wNjA0aDFzamhHVDF3NGxlVy9KTFM1Wm9tb2Y0Ukpzd0dKcElM?=
 =?utf-8?B?V0lLcWNXZ1VxelpTbG5OK2FqZzBHbzhXb3JLR2paTytyMHVJT1VPelhWN21P?=
 =?utf-8?B?ejZTdTJHaUFLbEhPZWZ3UEZtbGpHTUFpVE1QL2tzUVByODJNcWkzVEdiNjR1?=
 =?utf-8?B?b1FLU1I4aUhMVGNGMFl2TlNJMzBGeXFHZzc1aTE1QzI2dVJyNXpoRnhrNzR0?=
 =?utf-8?B?RDIzTXB3Q2JnZUQvRGJMWTcwU013ZnkwOVZmWEc4V2tPQitPbVdjbWRBZnM2?=
 =?utf-8?B?YmFJTWRTUVUrWm1hZjc2dXlkejJaZ2JqTUp1WW5GZGJWVzVmS25VSFVLZm1v?=
 =?utf-8?B?VjFXVmtHL0hjVUJtMTA5WGpPYUJscDcvaXFnZkhSbkVFbC9UK1c0MGdBaWp3?=
 =?utf-8?B?M09HRmxOcmh5N1BoK0sxejBWbllhc1lTbWR4QmQ4ckNkdGhnOS8xS3gwbnB1?=
 =?utf-8?B?MlVUbHQ3M1VxU2dNWStjZTluZmo0RU1hYkpJRkVGWi9zR2V0ZTVDUjc0eFh6?=
 =?utf-8?B?Zk44YWRWbVM4Q2ZseWFzWTNVcmJxaEZQQXNDN0N5UjkvZWlTVDV4T2F5VjUw?=
 =?utf-8?B?VlNSZFVrVW9tOEN4NnJWY3RLSjhTNEt5WnJiLzhzVXdzOGVGYnNDc3lSVWRB?=
 =?utf-8?B?NldmYXppZk1oZGVKbi9BdzVPVWxCTEVuM2ZjK202a0dqK2ZLd2lVYVQzZnJF?=
 =?utf-8?B?bHhlRUsrWEtpczgwWG5HWlpjaWovNG9iU3BISEthZ3RBZ2I4eXF4bzR1S0I1?=
 =?utf-8?B?TkZHbmRCVmVwdXRKYzhXOEUrKzlSNGpSQVpqTkh6c3dNTC9yTml0aE1FaFN0?=
 =?utf-8?B?TEZlaDNFOXZnZHA1SUVXM0t5Rlc0M1Y2aHNES2lSU29RalJRVU9SQ1pVYkFr?=
 =?utf-8?B?MEhlWmdybzlXNEJmQklWQ1VaVlFYSnliY091eWRQMFhUTS9QM3ZSaDJvYnpL?=
 =?utf-8?B?eFdBaEFNNTFFTUp5NUFvZFhKUDlvZFU5UGRiVXlTNFdxL3Z3M0xmVmtWbTZI?=
 =?utf-8?B?MmNQNEt2Y0RNOTJaSmJiajNXMTZDMkdMZkk4NXNFUXYva1NyWGF5SnNRS3o3?=
 =?utf-8?B?S1p1RzNKbStiQjVEdzZJTHNsd2RRa2NRTk5ibXZjbDdEcHFSeWJZdERMR2dp?=
 =?utf-8?B?ZHBraVhKR3ZQeEtPaUwwY3RrYjVxR2d6VjVNcUd5OEpTaFNmS2J5aTZpTjVh?=
 =?utf-8?B?WDJicS8zaWRMWHhmNHJYOGVtbitGVWZFSGVTYjlXK1V4d1MydWJ6YzV3dnZs?=
 =?utf-8?B?cW8wMU4xb1VVekROUjhIQXFLeTdMOE16Qm5YaWlZcW5ZZnA2K0JnWG44TGE0?=
 =?utf-8?B?MyttdG16bmdYc1JQc2RnMWpDUkdWTkRPdERkbURBeXRLcGFCankvOVdvQlM1?=
 =?utf-8?B?bWdNVE1GYUtUTVdRL3pBV3YyNXEwN25aOCtMSmFmV2s4TXhUQUZ1ZHVQSmJ6?=
 =?utf-8?B?bzNlY09uU1VWazFML2FxcVNjVE52RVR5QVFlNDlib3IyNGN1RUFsOElLVDZN?=
 =?utf-8?B?elhva0pEckJPV0hOTHVJTzJlOTExNjBMdUd4NmRhbG5IZlQyMVRlRHB0TWxS?=
 =?utf-8?B?Y01DTkFXbEdJMjJMekVLK2xpZmlKZStLY2c1N24zSmppQW0xS05FWnJ0WTV2?=
 =?utf-8?B?Z1RVRmZ3M1hieUhFcktZRWo4dWdPRWJSd1liZDIrQ3FXOXFaS0g3cGdrSzBW?=
 =?utf-8?B?M3VCZ1NNa0pxNkJNYnlvS3N2a3hrSjhRWGZ1aGxxUkphTEpveG5NcDJCeVBI?=
 =?utf-8?B?VHNvMDc1S2s0U0wyV05jaFRYYTVWZXJGQXorOTVJOFpqZmk3TXhkNmRsQ0x2?=
 =?utf-8?B?NHJzemJNU3ZVYnBmS0JRa0RGK0M5azhtekFkTWVZTEE1MU9FZEZzRWlxbW43?=
 =?utf-8?B?eU5OM3J1MHF6SEV5ZGZNSTVpT0dQNXg1K2hLSkcybncrUUdFbFErV0lqMzQz?=
 =?utf-8?Q?9Ft57uoFihClkT6MLjixVE/oia/?=
X-Microsoft-Antispam-Message-Info: r6to8rGYmihxX0knRWMdLhirGLGJKwZKj7D1lMKXPQZe2MnQgci9d/o1glxRJH/SOdrJeGREAd7BYj208XUriBH1OFDN8mkcwjnL8muD+C0mhC4iz5o4MoEaDuGLY+YBQ1BCCER//uz1qmTmHA6IlugXGoRUnbejwKchxPH5GnoxaYfkzE89mGvnspbwq16oYgC0Ahbxzqs8cvK1Tz3XcfhD813MJ0nojkytSzgpbygsBXeuai6ho+F1w1RkWbEKp9ZDQAhJG4yDxk7S1LusfKR5LEdqxnoYX/7Yf7idkedCJjMJdEJi4+cTj09OoLzaZuhNcDCnC9AZZ093DP+wNQ==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0107;6:t/46wUsG/O8N+LgQ0o5WEOyb1hNG0aCOyAlZ+JwnDrXbc8XnOqxvuYpt9skcyRUJde59v1X2iTDAaZGNeeFw6vc8wAYTVKUvo/iO3Or99Ndg9ffgqE+q4EEtkfDPtHiUILH+ztE+hSTUQBCXmqXBrs7oRjMtshtc3nb4zdk31etCOlW/KfdSDWv1qB9aqrkDA9GJtgmB1Gblasy2eqA0fi0RXpkWQVRzmLiURF+S135+vDi/J8tehEvT6OL39JgSahJz6vlO/Wm8fmdx027dahJdZfJJtfNRY2mo3kc0UzxtK/SE6dOKmC11k3cVwxxwd4NhJJiu8zS3sjDau+1+4T3/LP1fNCCu6F62/LbOr0s4pAXBdWEe0G23JAiGaZfHbgDOTPIUMp6hJXAHGGMj0UCL3d1QI9FUDj2YJd5xb26bULu+mlchR7NYuZalWWWoN8t4uCISpVj3junSmOI5uQ==;5:P4khyzYYZZC3BQ3zQAuDl0cVhyyhyk+jkMk9AEnQV6ebFa/u2/Hp2IIpF0V5EOz06+vFC0gl2yJ9FrSRtflGyCrGNx1SjhU1+56XxloFiQ+fDJwsqvkTYvnvFf9CJqIh604G6I4N9sgq+YRfhtBc5t2pzm0oZrXVA2NUEwKDXJk=;24:rAXMwuAT3fe44otHmGuloUDnB7qjpBuNDwy6zaLi+KSHOulqvxnU2S6pJChdCUIH/qI0DqlRsv3y+/HyXF4eKNNrKt4WjKuK27GlMJE5Ng8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0107;7:vFPH0p/WOlbknHSICTq6aBwiOF2fhMbHGMrHwEZwqR2kRdMzXonqt0jqhIlZH+gk2ZB/Y1jkyOw8huqWGxFzG8UVpFmnOrFDflvdu5v1SLpdlG5PTnVcdaPXrCjdOfAV9LnQjEaAXVFwQ1RMq/HrfjxpEm0ipZhTFe/NyOejmFQsL3lTXftYDrNcIylzn8XhDViEuPIfEea/1DTEBtg0HkXfpjdScclYBn5mm3paQztpVQqdRKql/k0K+d2lBEzV;20:qhlhYmJN1btI4TTeBRyl/sKbbNS24zqWlEGTmd7dQ7yc4lmSrGmDbKaTXkDC0tN4j8aaDyIlhp6DBu4xEAJHFSfQ6BN/Q6qGKDSIjIXX0y/bKLj2SAJPgqjYieyB7eHtW8bb5EUs5QNoE3qIzXHuZQZ65lfisZNBT+HhTphwle4zHqzsI79+7sTdDreGvnNVe5kriJrlwwOra2aRzEjcZsia1apb7TVgbE3qmf0C6Vv2W/k44ywqWa/vv4kJMRxX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 02:03:44.8341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fad608ab-7d62-482a-677b-08d5d4bfb917
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-06-17 04:52 AM, Stefan Agner wrote:
> Explicitly use the first uvd instance to avoid a build error when
> using clang 6:
> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1148:52: error: expected ')'
>                  container_of(work, struct amdgpu_device, uvd.inst->idle_work.work);
>                                                                   ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1148:3: note: to match this '('
>                  container_of(work, struct amdgpu_device, uvd.inst->idle_work.work);
>                  ^
> ./include/linux/kernel.h:967:21: note: expanded from macro 'container_of'
>          ((type *)(__mptr - offsetof(type, member))); })
>                             ^
> ./include/linux/stddef.h:17:32: note: expanded from macro 'offsetof'
>                                  ^
> ./include/linux/compiler-gcc.h:170:20: note: expanded from macro
>        '__compiler_offsetof'
>          __builtin_offsetof(a, b)
>                            ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1147:24: error: initializing
>        'struct amdgpu_device *' with an expression of incompatible type 'void'
>          struct amdgpu_device *adev =
>                                ^
> 2 errors generated.
>
> Fixes: 10dd74eac4db ("drm/amdgpu/vg20:Restruct uvd.inst to support multiple instances")
> Cc: James Zhu <James.Zhu@amd.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index bcf68f80bbf0..6666a5888c44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1145,7 +1145,7 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
>   {
>   	struct amdgpu_device *adev =
> -		container_of(work, struct amdgpu_device, uvd.inst->idle_work.work);
> +		container_of(work, struct amdgpu_device, uvd.inst[0].idle_work.work);
Hi Alex,
If all instances share one idle work from hardware view currently and in 
the future ,
should we move struct delayed_work idle_work from struct amdgpu_uvd_inst 
to struct amdgpu_uvd?
James
>   	unsigned fences = 0, i, j;
>   
>   	for (i = 0; i < adev->uvd.num_uvd_inst; ++i) {

