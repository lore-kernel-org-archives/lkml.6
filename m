Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeCONXR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:23:17 -0400
Received: from mail-he1eur01on0128.outbound.protection.outlook.com ([104.47.0.128]:53792
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751449AbeCONXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:23:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] Improve mutex documentation
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
References: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
 <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
 <20180315115812.GA9949@bombadil.infradead.org>
 <2397831d-71b5-3cc8-9dc4-ce06e2eddfde@virtuozzo.com>
 <20180315131832.GC9949@bombadil.infradead.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <053b66a4-ce68-fe00-ef06-e09a3b14d524@virtuozzo.com>
Date: Thu, 15 Mar 2018 16:23:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315131832.GC9949@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0038.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::24) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 261d6efc-ca4d-412d-2004-08d58a77e6df
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:pilI8yW8spk0dou0pbLkbcFouYejFrF8E8LQy0FJwrKSsr/zj2CbHD6zncCjDf3MaHIUVWedJBmHHS+RR2eKibF87dMYfCSI+4wCOGZcku7RPg8H8cwI6N98o0tPz4aN13vUSdjTr053wv5k60JdVkSjE2nRl6xU81TvLo/VhxOQWU7B1hcD827BenX17fDrTOImcHX8cLejr1THGTKzt2MQogx31SgthdFbWSRJQ+2C0y1X/drrCYuDFHi1nBRN;25:8FyTkOX6BOz+/KClB5wsYSKHzxcY5+I1KhcqXwbRDKw37+5SeH+lXdZ2cd1/+0UgZCxnVGzPzaVWYVpr+bN9D01eQNQP//J7dZEQe0ffuCO9DqaN92tALzy9gvxtxWEfjaD2gAPBpX1hCwZgL65aZhDo7IlG9seYu/UkzKbjgY+mAaeq0hY8CaxH58Sf7LBYS9NGMrJlXi/Th9E1bD9HH2Tw3ccRPvAuQRc+mDLiAcfpRznICq+0sAgeVj3e/9y0khH1mVr6QkcZ0TbEB2cNQvvOL5LQYYD2ndcQt667RVwnG0vh4H2Vl9qCaUS+3pqURZ16Uw0PzX5p2s4hBjaMuA==;31:EnUz9oWEZBgK+Gums8rq0V3odBVWF9cAqrjWVPHfSjAXqf8LM8lZsEQusnXkuaSvIiWTFTmhj8Ex9dPdkWQHbVUDV0fqDqzKtDOY+JiG0kA6oTICMkibmcKNTArpBVoQ05KWZFLF3qHTwqTdy4GSgAnqR71jLRrU1bYqaPwNFc/dxKkI+5djpy1U+Th8AoYyujSv62qEtfizDDs3+SQiZf2fXP+Jw3UZECfHcXIOwZQ=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:9sUCMQ6Onr94uuMo/faOLOOIIp6rHS++iPJmVaV1leCJRIixEdpqcbhze5L7d74p5L1qSXqPUybbF6JHVNT4Ixl2yRiNKpd27h7EwfdiqKQiysE9zwqy/KLAfsYfjrwN3QphJFdIF4CLXZFTOxm1hz1CCpbmCQLGwvT4PWuH3/yyPV5FSwJzIoX8s/9cdf1o/byMP6qI8Z43fpUlqD3Tecbs1vut/5wi0ceuVn/dZ/cBI4mwVAzymALk0tA5h6LNOtiCvwxH9J5p/PsOPfKkEHrg+C1sgP4NMxH/U4BIHCYRGEXpbRiO958EAt3Aup77/AO5Xrh/SZQgk0rZHqkN/GSB4QILOAfVogFqqxdUvrzJSuUEHm85RIhcbbTpJ0ARHThKqbgiEGALYQ35odNuVIBuiZYq+eOebLNYyFSTVdwUwGpgXpKuym3jCDF1I0SRIxy8KY52570rJg2ZbmmAyUSWgCrUIxahB74sgd/+lHGtj0OMqXRJYNis804mXGeq;4:3q7bjkenQzhJcTI3lpMq8Rfj6hZTM/lkMaVcSXTZLkEdKpXJ5kBDeJ3EFbpSqxlvSUtH/225wr3qkSl8nVCmepZnqn9kkxeYnq6Ad17kPmesO1L3+De06vs3pBL5jHOy+5JOcURGIVkwYl+e+pa+tMCkwittv1Jqh2nlp83X6c5n3ZeAppaHB6NRc95ftGyi4PpfTt8LO0gG7lvdlM0bcHgd04CL4JkMhFBvAyc0MwH4smYbE8nsnngZfJjvh1bzqLLwR5b6pQdQpl79DMZvvg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13382E4B761541FF685FCDDBCDD00@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(366004)(39850400004)(39380400002)(396003)(51914003)(199004)(189003)(97736004)(25786009)(106356001)(47776003)(31696002)(52116002)(105586002)(5660300001)(3846002)(64126003)(6116002)(65806001)(65956001)(31686004)(66066001)(68736007)(230700001)(65826007)(2486003)(52146003)(23676004)(478600001)(76176011)(36756003)(59450400001)(93886005)(386003)(305945005)(186003)(16526019)(53546011)(316002)(7736002)(53936002)(16576012)(6916009)(2950100002)(55236004)(229853002)(81166006)(77096007)(81156014)(86362001)(26005)(8676002)(8936002)(2906002)(50466002)(58126008)(6246003)(54906003)(7416002)(4326008)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6QkVkOEVVbkZZS0pUbmFxRjBTaFdJTWtK?=
 =?utf-8?B?ZTVkVXBpRlE4V3hhM1NoZEwrdm84UDNJbGNmcTNOVkVMU0VnNCtnN296eW5l?=
 =?utf-8?B?NlVWUWxRTWgyakk1MzFKdkltUk4wbXhzR1BTdXhIZlQwS2t1SS9DTitETFNW?=
 =?utf-8?B?SElncDFaQmxPNEU5R1pTc3RPd09sMnRwVnJtWUREQXp4eGI1dXVLODNIazBO?=
 =?utf-8?B?UVVmZm5QNzRSWTBpTXNNUmpMcGUwanNJdGFmanRoVmdTV1lHMGtTMFBlSDhx?=
 =?utf-8?B?MkRVUnVoOHV6MENCMXJReFdoY21yTERsckRjQTkxYVlLNC9ITmJHV25yV2Iv?=
 =?utf-8?B?V3ZreFUvdjgvdGRpUWNvczdFdW83WEliUGZ4RzA0MkV3ejhPQlFNU01ySzNJ?=
 =?utf-8?B?NkM2SGo2WWZzVDVyRnNXVmhvVE8wL3IxUlJQNjd6TXBOSEwyQm1QQTMvTFNI?=
 =?utf-8?B?T0dIUkRiWUxzRno4RnJWcWRyNmp3UmN5eVRMS3pIYlZyQy9DSElVMHFrRC8w?=
 =?utf-8?B?cy9UZi9VQlFDdHFlb0hEb3pVN1lCblVTMDVGSDdLODkxTUtOT0R0Z2dLTnUw?=
 =?utf-8?B?OGc3SGtZL2FqcEZMa25TNDVFQUl4NXVvTzFRQXFoTkZiL1g3THo2M2gydUYz?=
 =?utf-8?B?NDROQ2hTUERNRExDYXlnR1ZRd3VLek4yVmdNaGNxdzdraGNSQUdGaTNqTWtj?=
 =?utf-8?B?cDNFTWxnVk5RQ2pnRXN5cmo5VGFiRHUrZXZFSTZtcnN0VmhiL2xjSTV2OWJO?=
 =?utf-8?B?OENNRDMvWHYvQ1poZXBHVXVGRGhEZERxbDFYTzhubFdyellZbTdkVGlWWG5l?=
 =?utf-8?B?anZXYWorQ2U4TUg3ajBCbXZNbVkwT0M5clhNT1kvaXVlQkQ1VHBlOGpMVnQw?=
 =?utf-8?B?aVByYUE1anJhWGU2dU9CZzN6VVVDTERCaGZWVmJ1RVNMb01MUndUM0FVTjg3?=
 =?utf-8?B?ekRvSmxkSldTb3czRGVoU2V2aEF6Ni9leGVYRWRCODNCU3hZL1VHU3JxdURC?=
 =?utf-8?B?blFVck1EcVhaOGkrWWxNdXVvUWxGQTNuaTIrczdZSHkrSk9VSkp4aHJXSUFo?=
 =?utf-8?B?OTFMakJkZElsVkdGdklLNlVpbnJSaDdVVHZXcnY5S09ZQTF2eFJZOWhaWFpD?=
 =?utf-8?B?bXdCYm9qQnBUQTZlM2VyTy9nZWRnSmR6UGd2S3NiL2JqQnZxemR5OUwzQ1ZK?=
 =?utf-8?B?aFVpU25uNGQ3WFlVaDdTVno0SDRsWjRJMVBraE9wU1lVNW4xcUxqRkxGVlRv?=
 =?utf-8?B?aThzV1NiRGJLaUdYTm9MZ1FqZk0rWTZLUWFDK3UzYUZiMnphZGd4aXlsaXRt?=
 =?utf-8?B?NWQ3RzE0ZElBU2xKaGxKdmFLTlRpaDdwWHZXRlRKRFhxSVdxd0RwcndDOFB3?=
 =?utf-8?B?bUlXOURsRHpuTlJxSVpUc1AzOCtaS3pGcWFLU3VLcG83MVpaM0xuUGpMM0dD?=
 =?utf-8?B?YzN2K1NzQVpGNWYyS1RYdC9EdHROSWkrOFlFMHFRaGo0bkNJNzRrMXZzZkI4?=
 =?utf-8?B?ejdVK01oYm9Bc0JFMXplUVZGcE5PZ1kxbEN4WmVoci9pTUEyalI2TzFQWEpn?=
 =?utf-8?B?VXYwcEREbEV0a1dRRTNxTGQ2SkdGdnYwM0NIQWJZWEpZRjBlRE9QTnQzRmp6?=
 =?utf-8?B?ZzlaQWUrcm9rdlVIQnRxQzlOZ3pJd2JiUUhnV3ZYZjBjSm45N09PRC9PaHlF?=
 =?utf-8?B?WGdEOWM0cEdPL04xOTQ5RWNrZmY1d3VOZ2ZkdGV4YnozcWlIUFZaNE45T0Rp?=
 =?utf-8?B?Wm04cDJRRkZ4Wk9KSGcwQTZqbWtjOVgyZjZIRFRuNHJmV2xxRUZmK2ZQSkdq?=
 =?utf-8?B?Wk9kdXdiNzJJVTNDb1g1QlBOeHN6WE9OTU8raWxoemptbUh6U1FoS3hmK2Qw?=
 =?utf-8?B?eU5ML1hFc3BsaEw2UzY2MGZDVFZoSEMxWXM1dms4bWFaQU8zNFBtZklLYmJJ?=
 =?utf-8?Q?V3Q7wfkbHFkoQzHh7ChLJFU8UTc+qC5Y=3D?=
X-Microsoft-Antispam-Message-Info: /Des2U/Lg2Armu3r4jSeEb0mAs2WKcZvmONvOhvahQf2/FCGgxXlXE0yy3r8xSnCsFPlJxoO++2u3rErTkKbKs8vCOSZC14OTYB3sI1lyAe3mx4hVJQQZkgymm12mtIQovwlav2Es6uD8ti11NID5iJn+trZmYJGRyUJ5YBZWKkk3Nie4GMs+FOyv0/4ZMEB
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:pmbg+pAU47eAA1b5486Hhl5NzJaFP2yZwFh1kebaH+3DkdbY/eCHUgWg8GNPeQO5vawwZTMY2uLxK6FzuxBrvRuf766TV04TRVB8n2cvlql2CbRgRdT2MDY3UYYGhWjSv8CDO8H7hI/9hJ6TRnTz83LX5cX3OesRM2VfOr1hY28p1v8XBch1BuujTfHIAMNGIEEszsSZGFUevAV1PmnnetldlXuLqNuNtp3FXfEprfu0sFxpzH1oo6+PPemvuSo8//yQzCQr6deKU+7wpIhWpgOuEvqsKGSXFXpQSKNTk4TlEJFDHL12wZlBMRLBvIG3RdF3tFbj163MrPxJmNy2SFGrXJBqmtUrs1IdbTX2+So=;5:JbgUnDVOF6kLctg9CVdVzNqsudp+VYj1f4opzA3TbnazhKP0wiAmJclw+vvSmUbz6tCqOAJm4G+NvJjnAHIsbyp3Y5fHubLhV7C1U4fMokUxg8ljsCrfMAPsm+0RPQvVrV0wmEGEFlW+sbwRfOfFl8WXHAMNteuLtpjIapuOPwA=;24:lbV+M0KQ9uku2ls2A89FF7tfJmCVJPy/Qnk7nuXXviHX9ZeWuYwzsW4AKYqZmL0nglOdEANzVwJjdhpqnow63SvsUISqzR6ukYp0kkQqWOI=;7:lcyPTbyrmXnzAwg9Jcup+AM8vTyL8NHj/fncor/nzBmyhbGVaaKcEwQXg1sd06tBMdTjuR8tkv8dD6fLBMNVoNeYqgZpku0Ua+Hm8lDUR8LGMjykuKenmBBglbykSXi4HWp6cklg91kVq1qxxcKWa9dB6Jy2n8PnpW5hkKvUX0TXDfouQrdeAILj6xEUji1YEYDfy2QuO5f5+67tY3WqFK7Ha03RKcO9NVnAO0sKUc6A6WWvvnFU5AjYoROmgU0z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:9KlHpjdvUVYI9Dvkd9f0FUZevCuX7Oe39ZPYbFYpTgcSeKKWx2EMqecr1c21lUNbZoojyEoHV3NM0LpWWIPA/R8iYw6x/imrxDwA4mmxn2Png3wMFM0qkbn10DiIlRvvrP42MD6aE7Mx8WEuVE32odSD2r6pbjHYbPWEu0qfz+A=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 13:23:11.7854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 261d6efc-ca4d-412d-2004-08d58a77e6df
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 16:18, Matthew Wilcox wrote:
> On Thu, Mar 15, 2018 at 03:12:30PM +0300, Kirill Tkhai wrote:
>>> +/**
>>> + * mutex_lock_killable() - Acquire the mutex, interruptible by fatal signals.
>>
>> Shouldn't we clarify that fatal signals are SIGKILL only?
> 
> It's more complicated than it might seem (... welcome to signal handling!)
> If you send SIGINT to a task that's waiting on a mutex_killable(), it will
> still die.  I *think* that's due to the code in complete_signal():
> 
>         if (sig_fatal(p, sig) &&
>             !(signal->flags & SIGNAL_GROUP_EXIT) &&
>             !sigismember(&t->real_blocked, sig) &&
>             (sig == SIGKILL || !p->ptrace)) {
> ...
>                                 sigaddset(&t->pending.signal, SIGKILL);
> 
> You're correct that this code only checks for SIGKILL, but any fatal
> signal will result in the signal group receiving SIGKILL.
> 
> Unless I've misunderstood, and it wouldn't be the first time I've
> misunderstood signal handling.

Sure, thanks for the explanation.

Kirill
