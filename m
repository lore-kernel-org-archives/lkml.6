Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E51C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447D921776
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RfHHpIcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447D921776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeHHSuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:50:52 -0400
Received: from mail-eopbgr40120.outbound.protection.outlook.com ([40.107.4.120]:45343
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbeHHSuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUeFc97WJXgCc+1Fp2+BgBrpLVHxfUXTxrI3don+JBc=;
 b=RfHHpIcFEF4WrU0gLk58J2HbsoK934Zit6M0EAh00ChMpOysh2NBz4DuDwMt8CWxdc5P0UpTaK36ya8YBFLoXzZyYJdeh6e3qg2HKNqLWRmQvHOksFZJxOEzIPLGivseii4pzeIR2c2XmrJUGOIkLuvemkaKXKJV994aYCyNfxw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 AM5PR0801MB2018.eurprd08.prod.outlook.com (2603:10a6:203:4b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Wed, 8 Aug
 2018 16:30:16 +0000
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com,
        paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
 <20180808072040.GC27972@dhcp22.suse.cz>
 <d17e65bb-c114-55de-fb4e-e2f538779b92@virtuozzo.com>
 <20180808161330.GA22863@localhost>
 <f32ab99a-de28-b140-a7d0-027073055728@virtuozzo.com>
Message-ID: <b4b58edd-b317-6319-1306-7345aa0062b8@virtuozzo.com>
Date:   Wed, 8 Aug 2018 19:30:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f32ab99a-de28-b140-a7d0-027073055728@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::37) To AM5PR0801MB2018.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d59750a-1555-44c7-265c-08d5fd4c3b25
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2018;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;3:WYQnwQBiWlvh0VbDVY+SyiBBxJvVDURn1PaY/aqn62XfEB0vj2wsCp6TCaDeAOK8GQm987mSbJWZXNwxbYua0m+0i/CVMTR6yv64b4FVj3X5wufq6E9P98lqCyuaAV77Hozs7a/t6bjMA8dJi27osVQ5ylQifbCImVJD1dMjMHajSZOnZrJoBYCIIYngjPEB+OJ9CR+e2TNG9jcdBz29Q1mht+7zxqirEqjOhGhNsC2H3wg5rIrIbmq50gCtiZG/;25:moXS1b4YFIJCVHGfcyPbYSvr/+oMqVSOt0Dh/qmPbEtQUEsuhrch1JLG6tufWN9WKslCs8M1uQD9AE31QZkhtO9ZP/ti4Oit2UayqMf1O00XEg08+JR/ddvbs/CTx7+W6Ma0U+uZ+6uqdZfhxcrEMEwbBFY8EGqwgG6Tu/mAui5CgcFGBAicuYgMS8qMAHFkS+d5+Wh4UZAvML5VewSIDxC+khnBcrMU/hly7fTySxfjz+/ti24t5PGO6Z+jerqnmb605M+jP9ASRPjB0IilmohlLIYnChhKaSGLDeD5chu5Mqmny7KKoUx4+3Qeeagma4FyJKEQBvThzMBmrrX4uA==;31:a/Pv8a1wudPAPI60OEKCBKTZui+cnZ11s+ZDIhj2HbilZadxBvY6nw8mV5jchqwhip16yYRHbL3IcIM96sbZj5wjwH/OtHvQoYTqRBuk6pw06GsymSYicZfdG+2+1HEPslwjJ45mXog4655B3JPx1Gifhd2VUek7UH/8WyQ6TgYWwI0ZKwjytM+asKpjAQB+kYDhtNMIjUsjpl3UI8ME0CcAX2hVCKgBQ1UaSmybU2Y=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2018:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;20:Els9+xahhknH5BmTPaA8CCXztnMtxJ7q+lzFYuegAs1UyvvsluaGzLFCEmpYkOY5amnCi0oYf1DZmvdkPuhrB+qJmmukyM+JpUM/dNaUBQv6MYeijfFhgTZ0Y0DVHTu7HASDD5JGOVPJ13kwF0kRq32nBALdWWyvEeExT7TCjMlJ2hj2AZ/GvNATYYITgVLCYMEwy+F3f34REggcUppQVEvr/VDlFtg2pgTP42y8hbpj63JrJIv2ygPVXIdA6m1q/R2eVPQdrC52JdSlZd3appP6O2wo1LUWQJ2Pk/S8i5SCNt9Y870lvnzkUcl7zJFrlyd8yrtrSFKVJvHCRbGN3w9bck1wE9I1mPyZ02RzLYug6JRc2XriHT9o7B1ypXoSBv+8lRi3OSo80sUV5/EFcle3ALjmSSSjBypfjBQUaRqudhPXypn2VVlH64oUnFyaEoZ9H9uDoLH8X0wJVKSNSeJZFI7tKDPSWlT4BI343ApCFbIKDg9yK85Qq7G2Pi+H;4:oKVa2GRrHSFTdlpav3K4tgz6rPhRxcPgbQZaYaIGMY80R5PFSBZxqVvssNdcrhh+Ow+RparDyLxyzfv9PDkED+5tjiH7xt7KrTzsxV5IgZA+du5kV+W/lPYEu+QeSIKXSR8HJ6y64m7KFOPQ0aiGA6BtXC+Sc5RCzRwr2+TV7FY5kMSu67hTntdSMG+uTuGj+BlpdkcHLuMDMdxmHUyJ8gFI8XvARlnbrDt8cEZV4AichGuc3zePvKhc4GQ1N8mz/KwBrg95bOfthcMDTo2YBQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2018EA51737F330E7D05015ACD260@AM5PR0801MB2018.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB2018;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2018;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(346002)(376002)(39850400004)(366004)(396003)(199004)(189003)(476003)(47776003)(229853002)(8936002)(7406005)(217873002)(7416002)(65826007)(66066001)(6916009)(6486002)(53546011)(65956001)(65806001)(11346002)(5660300001)(76176011)(50466002)(956004)(2616005)(26005)(77096007)(186003)(6666003)(36756003)(31696002)(6246003)(86362001)(305945005)(52116002)(486006)(81156014)(23676004)(14444005)(52146003)(2486003)(16526019)(7736002)(64126003)(446003)(8676002)(386003)(81166006)(478600001)(316002)(31686004)(93886005)(105586002)(3846002)(6116002)(68736007)(230700001)(106356001)(39060400002)(16576012)(4326008)(53936002)(97736004)(58126008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2018;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTg7MjM6TnZKWW5nSTRXTExTVkZKL2l1dVh5S3R2?=
 =?utf-8?B?czBUWXBIeTEvMEs5aURSSTBMb3VqQW42UGFuOWVNTWxoV01LTGc2WkxNZ3la?=
 =?utf-8?B?WjhoYVJrVG5FLyt3eVFueE9talBCaGprbXRsTDc5b3dEdnA2UGFPR2thZCtu?=
 =?utf-8?B?K1VZODFsa1M0UFRXU0svT0l4NlBBcnVpaWN6cDQ3US9jMG5hMlB1eUpHdENV?=
 =?utf-8?B?aUNxcndGWXRac3dIMmVZckR1dTFGaWFPTWtZak05YWpjeG15a3BUK25uOUJa?=
 =?utf-8?B?MnJ1ZVZhTCtIa1pGZWxrNnBHb0FGN21hQ3dOam8rdCs2aVJibFJveS9kQ1Yr?=
 =?utf-8?B?WU1CcGQwNmJwMjJ3WjN5NWI2SC9xZWkzLzdYSk9DQ05USDlHV08rKzErR2dz?=
 =?utf-8?B?ZFBJSGl1cTlTQkU1a2RDRkhzd3VGS3JIWHZoeHFMVXhpLys3RmhkSUFVazhM?=
 =?utf-8?B?a1M2NXBCdThpVzhSY0c4WFJBeUt2emdqMkkyTkFpK2ZDM0RMVHpwYnBOMGFS?=
 =?utf-8?B?MTNOeUtCVFNOVCtYeEVlRTNWeXlYbmpMUFFHK0I1MFNzVEV3NTRmcDFHejYy?=
 =?utf-8?B?UXRRaUtnOE1HRXpYMTBqdy9Ud1o0T1paUXFoSytTQ0ozMmlmWW96SzBqZ1l2?=
 =?utf-8?B?b2U3M25vQU52L2pQNWd6Y3dtSlZ3cEd1d2V2RVhEdWdFZTZmUlBpUmVnMjVs?=
 =?utf-8?B?YVlTcE5Gank1Zml4NmxVcHByTUJJQXJHYVIvWmdyZkVzWXNibnl0TCtpMWNn?=
 =?utf-8?B?dUtGckQ0cVhXZXNxdjNxV0hwb05zOVJkam9YTFNLYWdabHV0UGEzdmlxUzNu?=
 =?utf-8?B?NDJUcDdQZHI4bzdDZkJBN214WitCc2dzbHBWb0Nad1hEWElwR093L2E0akNO?=
 =?utf-8?B?TSswdElTYm9veTZtVGt1Q2V2VVQ1ZmJwVzhDZG15Yk9Tamk4b0Vob0pRVDZt?=
 =?utf-8?B?R2RKWm9hL0dPM3BvelhrRmRHZFFWc2xDc3JxdWJsSmhsaFE2cTN3UUJkWk9H?=
 =?utf-8?B?VUR6TlJMR1k1eG1qbzNodmxtaGVUYkh0L2h0UVMvc3liYnJFT0ZZeTVobFNB?=
 =?utf-8?B?YkVycEJZaXZUUHhXdW1sam5GK3QxSHhENDJ4N1g3VUIzUkNTTFdoTzZTbDRT?=
 =?utf-8?B?Nnh3VzkyWUc0bzFRN25BTjBaaGkyRThodml6ZCsvbjJNQ1hrS09iS1FYNGEw?=
 =?utf-8?B?cmhyZGpHbGJPeFZ5aElmRHVSZFJjUlFnZzJaSHp5N2lyMjdPYmxDQXdrWmhs?=
 =?utf-8?B?WWJnK2t6a1EvRXpORXFSMzdLSjUwV3F6amNoRWdHWnRlTS9yMUhvOE1Fb1pK?=
 =?utf-8?B?U003Qy80K2lBMENSRTk2eUFJNWFRRXFhYk9sQy9xZWt5emFjSU1FSDkvaXlJ?=
 =?utf-8?B?RTd2YS9sNFVMaUJZNktXSzJUSEd1VjJ6a1Fqc1NZajdyNmh3Sk1oYTYya01O?=
 =?utf-8?B?OVVvUWJkdCtTUEhCNE9oSWVZbkVnOFY2ZmVod2ErdXpvV3U3UTFLcE53K1Rx?=
 =?utf-8?B?N3dXSjBKZ1RMQ3lscDJCQkVQQnpvM1c0UEhJd2NYamoraG5vZXBYVXhiNFZo?=
 =?utf-8?B?cTdNMk1iMlhJUzZjekRidlFhNGRHUmlrcDFSb3Q2MnJKaC9uT2QwdFAwRFE5?=
 =?utf-8?B?cDduanU0ak9KWGc3MVI4MmhCeVB1Vk05RnZXckJsazBjaFFURmc2NTVRaGgv?=
 =?utf-8?B?QzVYU2g2N3dKNzFTSFB1SmpVR1ZEamowU1M2U2FueE5VbXUwSVo3Y1Y2S0tV?=
 =?utf-8?B?b0g0cXE2U3I4SkhKUDE5RXZsZEpEVzVHQ3YvVk5KdUdSUzd0bGh4Nk5IVGpq?=
 =?utf-8?B?ZnR0ajJobjBQY3Y2MnFpaVQ0SFQrSk43TU9lNWtpMCtIWnRZMXV1Z1JmWGFQ?=
 =?utf-8?B?TkgyMWV5S2w5MmR2VUpFdVF3OWo4cGlsUEc1K0dPN2xhRUkySDNTdE5hTFl3?=
 =?utf-8?B?Vmt4NDNIVGY3Uk5rYTA4Z1dHcDAwR3BXZW9sUEw5R1N6WkJlRnN0cUsvYXk5?=
 =?utf-8?B?dlhVZk5zcFdmTi9pT0tLWWlRN25XN05VTWE4N3c5QWdLOTNnazBxOTBEY0Y3?=
 =?utf-8?Q?GUW2artmuJD6ZnBCtzeSdRN/FOS?=
X-Microsoft-Antispam-Message-Info: 0/Cd3wfRRqsYrBG6Rkhhvzz7U8uHZZIybs5ozWQwoXauovEHypb9EhVZFb+Vj2g2K5+8gYZHzDSNXifXTMPjXO4RUIecz+86R5MxCVlr1ITf2CKGipwJP1rR6Qc2NCXADYsR4cWLujet0RuwuL18jYpaEPnZoYonE2Ox6EBpsFo/mbDEg4P+goRJWKexp7sXGu6iQSOQJchA2dNY+WpokG6tVPEIUjZi0J+ulG0g25eWw00L2y5cj5oGOQGrebkQO4EycGwdl6rQC8QSBKLuY7W1tpIq7fppRUXxPkXrPurty88epN4lCg/7/3PKHR/sPqsBOQcDZ1FK3523hG4vU/g27wHV/6vsz27KgTA9PXo=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;6:5kByldUqBrEun4VFb3ZcbNeFDTz3zoixmKcJgKVg/v3trfz6tjc0ndnrEEXu9l42X70MiCAe/8EbtQ3xVFRRkgBIIbOM/5FT9AskjalPu5ceZb4xffLDLtrnOyMihKhCUcLrtKva/3C6X0I6Pf3GG5PYZnp+2SrM7I5T35beWFMpKA5Vyd47j4sUqBngh87E7DjfE5cxPKCAUwXrOXcs6VJRUAaZ6cAIg72K6du3vmh1rl8wam/5sPYwuqi4L6dU0zkcztypQuoWfdkkQlidzZ0HM/Rzij+Y+KAu5EpXcb2P9CtI0bUI7f/OVn9x6bUTwm2eBgIjU9eUAr+noClml3IolakN7w08xCMYPq3sFBaWpHJ7qnkf9+RnrC7scC2q0ILQn2Prc7+Oud/12b94rSK1rcOXONiNq195vWLu+TPH4rQzXtkXuUI/hJMZyOJRGpEXmoUrtUemZn4LMHVmMQ==;5:RINFnLzNxr4Cs0qhnz4S/sn3mmr+jsebXkO+r7q3dPYaHeL2zLW29tNQHoQWA10Xcaouh47o70gQKbsN7EybMWeGITFn20DVe+ti+qqBoOBSFIsDns1YuWXE6qzHcYKVOoRztqsFdIO/LrJ7ZhGY7ANF5expwm0/+96ppc+jJgM=;7:P6pGh0zLWI2+9WL4TnsC8PmwVe6Ga6i0Kz5uEuR5Qp5VHEWfhn7V5+xdACb+n/tyT3JEr/+yXdn3y/KU9gzxkCJGIGkwvrh982xS5FzzPgHESa9TsNYqwet0GHiMPMfS6T1UCVpjdHZ3dARgqFVYIIDSm4oRM2I9tpn0pJiVo2Tm3MKv5CmbRm5bgILn2dcyg6MEO6lKVSYgCnBpwJ9RuWAXpuBVnZWVM1nFTWtSX9I6eWHnox5GBJoMdE5bpPEq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;20:PbQVgU2BCCF7gRqd81EP8NuveVI7/+rcMgS6Gvk2OK2X/on1iBjtPWjNNVnTRqdUw8I5kaqfyRij9uDbeGkEpdeQTQYoOVL9ZV4R6XXD8HckhvX+VzUwTC30TAL3m2hVkub7KW3stTQSd3OqKH386sCWOQZ7wCM359E+UW04Xh8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 16:30:16.5731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d59750a-1555-44c7-265c-08d5fd4c3b25
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.2018 19:23, Kirill Tkhai wrote:
> On 08.08.2018 19:13, Josh Triplett wrote:
>> On Wed, Aug 08, 2018 at 01:17:44PM +0300, Kirill Tkhai wrote:
>>> On 08.08.2018 10:20, Michal Hocko wrote:
>>>> On Tue 07-08-18 18:37:36, Kirill Tkhai wrote:
>>>>> This patch kills all CONFIG_SRCU defines and
>>>>> the code under !CONFIG_SRCU.
>>>>
>>>> The last time somebody tried to do this there was a pushback due to
>>>> kernel tinyfication. So this should really give some numbers about the
>>>> code size increase. Also why can't we make this depend on MMU. Is
>>>> anybody else than the reclaim asking for unconditional SRCU usage?
>>>
>>> I don't know one. The size numbers (sparc64) are:
>>>
>>> $ size image.srcu.disabled 
>>>    text	   data	    bss	    dec	    hex	filename
>>> 5117546	8030506	1968104	15116156	 e6a77c	image.srcu.disabled
>>> $ size image.srcu.enabled
>>>    text	   data	    bss	    dec	    hex	filename
>>> 5126175	8064346	1968104	15158625	 e74d61	image.srcu.enabled
>>> The difference is: 15158625-15116156 = 42469 ~41Kb
>>
>> 41k is a *substantial* size increase. However, can you compare
>> tinyconfig with and without this patch? That may have a smaller change.
> 
> $ size image.srcu.disabled
>    text	   data	    bss	    dec	    hex	filename
> 1105900	 195456	  63232	1364588	 14d26c	image.srcu.disabled
> 
> $ size image.srcu.enabled
>    text	   data	    bss	    dec	    hex	filename
> 1106960	 195528	  63232	1365720	 14d6d8	image.srcu.enabled
> 
> 1365720-1364588 = 1132 ~ 1Kb
 
1Kb is not huge size. It looks as not a big price for writing generic code
for only case (now some places have CONFIG_SRCU and !CONFIG_SRCU variants,
e.g. drivers/base/core.c). What do you think?
