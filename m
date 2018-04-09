Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeDIS7v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:59:51 -0400
Received: from mail-co1nam03on0056.outbound.protection.outlook.com ([104.47.40.56]:41146
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751610AbeDIS7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:59:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 00/11] [v5] Use global pages with PTI
To: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, aarcange@redhat.com, luto@kernel.org,
        torvalds@linux-foundation.org, keescook@google.com, hughd@google.com,
        jgross@suse.com, x86@kernel.org, namit@vmware.com
References: <20180406205501.24A1A4E7@viggo.jf.intel.com>
 <c96373d0-c16a-4463-147c-8624ad90af61@amd.com>
 <b9802f89-93b3-b535-742c-f84e9f5be832@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <1b45ffd1-99bb-4ac1-fb65-0de3e42c1c0a@amd.com>
Date: Mon, 9 Apr 2018 13:59:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b9802f89-93b3-b535-742c-f84e9f5be832@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:405:39::29) To CY1PR12MB0168.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 019366dc-4c45-4213-475b-08d59e4c0f7d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0168;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;3:uzbitpGhZ625SzR2p1MgEit8DHcUFyyhXCt7stgovRa6wGmJEibyGmS+gJGaUzulk3sOhsiM+t9YVuHlj4Z0n5iX77yL7dH5z3XeCft0Yot4xx9j8ad/L4ES81eHDMJ9FY5yWxDNX1e9dCXycOXxmrfxK/7BSw0tBtKwabaAzZL7y6dYC+KEPk3KQ0/lAxkR31f3eQITK5upvUUaUd5eVgMPqj+9fDiOLdbHaXICtz3anEmr5KdeOEcpslUHTQDU;25:lBZOBiJuuGi9FEdcnWRh8FMOxg8HaYS+eBTXlehgHg98TbfL1ZawRMplbtvlcNH6V/F9/64Q9mkUtFWwmVIcWXr7LBsO5kwiKFOdx7pwWAKQHqOksup+khOavJhUbfhM18Hx8yYUFDG9iyfA74xv9IIzESMRw8C0oBWVaMZDeIKnQ2yLUL512zOSN9s/EaG98b10A1WWfTjVIcHDHw7MlMnSkjpvJafPYhpemed69/6i4/ol140/DgMzDx47E/SicszDJ+9D/DJHyMH7NAe96XWlPOQFWOIQDaQSBWM0u2AEc15Jl5lxfS9QHvtPUmyEyYMZr0n9VnOrWyxpazn3BA==;31:6LJYZAiRLLzunxQSZPojsxLDEaRv7dkQeWS88eVkOhhA09mR7IvZesUCuyJi+CavO+yGjCNIDTgu/CJ8KFAEElpcYX0hEchGjhyJGR0qAZVJ9yMmjwKjXVkptv9oLdrfmP5ln0ONP6NFFTn8VwrAArJ0kkmlzA3Q35GYHBSpHg7Nl1Ku3N6S+URekQSjg57jtX5tUv2zkwKmQ/f25G2+0kJg4KMGaJB/OBHYFSyY1Fc=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0168:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;20:wHmFO3MZ6qVZs5lRAiR735A9CKuL20DDNuSHLNqdo3mn5Vn2jYLhiuFhAng8Vzm/9du7+enOLFcQXXNmH3mcUFFkHAc9Z1lfw+DBJcdSk30Vn+G94gzoP+OZpSlcuVNveLvO/7k+E6xl4sdMNPKDgIPfoB0yPpRG9M5zoHJA8vhsq0e8rVONWfCZG95StG1tSfePcys3SiKHH1dDHOMTxj0bMgxkD5PS4FToBBTbXaQ0F3jnJDtACmrdWKi2+0LzZAY2fR3mcj0IneHWwgGfPB8vKQDzbfxi8iRcwbn/urZVrd1poWN8GG9NWZQvFqKsVjyiHkbbI66yCB1YFH8OJ9eE1iuMNoKaEklLuCPS4fhNJxgoDxu5Aq13HUQy4s7AlhcdXSMAL5hEWWV8zqfmYkEOudUhahoQq49iqJ/kvl+6nbedimfS1V10ZfuKCMpF1uuE/xqBxPD8k+YJjmN7PvxgF+DxJy5QwWmu4upAaxAIGov61ADxbyngIHCboohs;4:4aiJLSXYrBFVUxtZGh+ImpFH5TJK+w6PntGGEgeK3O9qSjuP/H/K1XfSYW8QKV7gIAEYKRxP3Agf11h5i9ZlggGzxWAYt1mVRMrZbkHSzadA8ErwzbNGM/kNT0Mk1EWSW9XXIJYpnmrg9T2QEYmyGP7c3OAjHChRQvdqb1aSdfiI9Wp1Kzo5OBUQInGd63tdEFIIBkMyJ3ykuSssjyVU/Ylt6AnEo66Xi5tm5Rt64ZGqlmnWmAi47Df4jXx/dtLhuTKwZ9Rb3n6UTDpc082KtQ==
X-Microsoft-Antispam-PRVS: <CY1PR12MB01688A454666ADB09ACC9596ECBF0@CY1PR12MB0168.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY1PR12MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0168;
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(396003)(346002)(39380400002)(376002)(189003)(199004)(105586002)(76176011)(68736007)(64126003)(2906002)(316002)(97736004)(8676002)(31686004)(53546011)(6116002)(386003)(8936002)(50466002)(25786009)(16576012)(36756003)(4326008)(16526019)(229853002)(47776003)(81156014)(81166006)(186003)(5660300001)(65826007)(6666003)(3846002)(486006)(58126008)(26005)(77096007)(7416002)(53936002)(305945005)(7736002)(6246003)(106356001)(3260700006)(86362001)(478600001)(230700001)(476003)(52116002)(23676004)(52146003)(65806001)(446003)(66066001)(6486002)(65956001)(31696002)(11346002)(2486003)(2616005)(956004)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0168;H:[10.236.65.235];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY4OzIzOkFEQW1GeXArczlPcVIvUks1Z0pwTXhEdnJR?=
 =?utf-8?B?Y1VqNFoyeDlFR2NyaUhiNmlFYWMzbk1oU0FVVzJwb1FLVlJQaGJZR0hlaENi?=
 =?utf-8?B?U0FJVGRXczFsUGV6bk5IVHdESDBRNWNFWUppbXJTK0FNa1lSWFp4cE9RUFdM?=
 =?utf-8?B?SXdyaGp3VzhGckhwbk1GUXg4cWViZHI2WVV2VHZpcEplVktYUzl1RSt0Mzdx?=
 =?utf-8?B?eXhaUTRRSnhXd1Rkc0VKK0dJZTdGNitEK3FCeEtpR3NLcnJSM3RzZ2w2WXYx?=
 =?utf-8?B?eGgvM0c1R1IyTk5zTThlZmpqYStxcFlSQ3NMTk8vUS9vNFh0QXRSQ1MvOGNU?=
 =?utf-8?B?S0VWM2Fiek1UMy9Vb2hscXNTMjN5UTB3cVhGaDRTeEJ5ZFJIcWpFRDBqTGYr?=
 =?utf-8?B?OVBvbmFVR1ozY2t0bkFncHVjQ0VVWUhDQzFPcUJrcnZVeEpaSFRkT0NETU45?=
 =?utf-8?B?aDlGOTgva3NtcVZPSlM4UGdtRXlyRmkzcUxKcnp3eHhCZTRtM25Iem5MOFFT?=
 =?utf-8?B?ZkpvWjBkZTYrVXlabms4eDExM25NTVp4cVJqWVUwQ0l3Tkk3RXRYeDg5WWNU?=
 =?utf-8?B?bnNNNUF6cWR1cGFvVVd2UTVicTZvWWRzZWJpSHd5YW5yNEZiWHJnQllQa0Rq?=
 =?utf-8?B?UGNPZHNZeTQyNGQvK1FxWitYbkRlbjcyUmF6cUEzQjYramQySjJwejMzSzRZ?=
 =?utf-8?B?aCszS210OXVEUUo0M1RHS2NEYXpmYnA4cU5WQWJVVVcxMG8rNHVUeFQ4TCtN?=
 =?utf-8?B?blorWmhlMjlqWG52R1NlTGI5SFB0ZXA4QzlYR25kQWJJRjU0M0Q0djc4a1pC?=
 =?utf-8?B?T2hoelZMamRMdmE4dVFhNTJqV29VZjdBNElHekh5YVNYWTdsSGZ1Y1VFN1RB?=
 =?utf-8?B?THN0blZTbzQ1b25mV0RudWFPRk9uL3pwcWpFSHd1aEJpUTZ4Y2E3YkRJTG1T?=
 =?utf-8?B?dUhtbzk2emJRbi9zNjVmRmhHWEJNejlZcXl4TzQ2a3FQSlArT2txYndiVjJU?=
 =?utf-8?B?QXJ6VkVwbU5EOVZQNkdad1MxSTAwMjJaSDlrSlhCc0lhRDdFNjVsU3dZc2tV?=
 =?utf-8?B?ZWNQNWpxTTRBMUVtWEQ1NnN6c3drbEJGNXZUd2RnWU12Q3lidWQ5dno4TnZz?=
 =?utf-8?B?ZUNZWGFZR2VLdXJGOFlUVVluR3VaeXYxWTl5cTUvc3g5SnplRkc4WDFYdjZC?=
 =?utf-8?B?V3ZsekJaTnI2alhBYW9vZ29yam9VUzRudjhjaGZBN1FQZytMT2NFMy9jVmVJ?=
 =?utf-8?B?ZkhINkI4NFBwZ3Q1WXNLc25xeHdZNVZyRmxFT2dKWGRmRlpmVmZrNUQzY25m?=
 =?utf-8?B?UFQzdU5IbWExZUtHMnVBb3J4aUgxcDF3N2xBL1hhRGZCM0FxaW0zbEEzT0lx?=
 =?utf-8?B?ZmcwVjJSeWluNVZySlNBcE5RYmZiRTVhUnlHQm81ZWhjWERsamVwTXV2c0hW?=
 =?utf-8?B?d3F5dkRsaWUrR1g0OEZsQXV2c3pJYktBdmlIT2YrMjBGbE5IZEE4N0IvaVdC?=
 =?utf-8?B?TnB1VzlRei95eVBZcmVrbmlzK0xEUFFwcWRJVjdwUXdXMFFEeXhkQ090L0hy?=
 =?utf-8?B?djQwc1EyK3A0UUppRitCRlNINEJtbWk1aUdDcTdQc1N6SWg5YUF3TDRHRHJH?=
 =?utf-8?B?eGQ0UktVdlg1WXdvTUE5UGQ4OHIyelVNbFZDNnFDQ1JaazRiQkVrQTFwZE9K?=
 =?utf-8?B?VExzaG9PMnhoeSsyTFFaR0dJYVFway9WOERhT1diMTU2NktMUExwV01Oc0VS?=
 =?utf-8?B?YXV1QVhkUW4ybTJCMEV3Z1k5ck80dEVncGZlV0cxb1ZoOFZmZmJZd3VFL2RP?=
 =?utf-8?B?NE5kNWRNTG5XTTVMbzlwUXgvd2JiQjFDaDhlaTM2VE15ZUt0ZGpFeU41d0ky?=
 =?utf-8?B?SUVZaGlFR0d3OWFUQ0xKRGJSQlNqM2IrNFBWb2xvdjE2K0FPUHFKUlIrb1hl?=
 =?utf-8?B?V3pEVUtKV1pua01ISytTcnhESEk5Y1lRVUViMHRRRFV0dCttbmkwd3puS1NQ?=
 =?utf-8?Q?v80Kh4?=
X-Microsoft-Antispam-Message-Info: UoNCxi5B57+IZEwbgmc5rofZjyin4AdQns/gBWk+SCKYezxmOC7DzdREquLwQ+rMfXtjNe04I2nINy0u42dttIZ5Zllc3eG9KDyh9tbH+40YOOsw/POQLNHUw6RTTsOWHS4ZZ7dPxUHHCPigC45KQbdzWcS7rhe4hzSkQlaximMVHaEMdfqbSFQjCcrsEf9g
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;6:3Q0FMpTwC5yD9iMHpvvvbkYjNm46yu1OjhQKKm9KtoEAdtWIyzrmK0MOzAwYWWArSTPG3H+uKqI4M5uuZJVNIgbepjaRBt6DYorMxN5mPFVAA4Vp2QZ+K2C894HP7GdbqgFc6i5HnwERN5h8EsKr5J+LlqKfNmOA5oGDJpJGNa3rZFlj3rShENua3pDBpcfE4yK467LtzujsuPBfgvCfgg1Hc+r5uXIkSARoVVIhG7LDEswI78Fx9w/98DvhvaGKiQ+kJLScj1aFH1rlKB5+WsmpDQeiFT8+SnKLOPAEno0BUvRegxOdkH1E+mM/RmfBwYFzISs8WqASIdxj2rBf5s13TDQNhmd4vTTNc+skCOc3KQZ5kCuxejyMb7aHTA6EwTbTEgkljwve1L6+s0TviPARJ01oGVj/Wb898id1ZeFNvn83KvJlCXybgppNU0ErPk4ITTGD2qdSz3pa4EDeUQ==;5:9szzfWOl0lV0xmOec788gPwpc1sUE1EHtB9P1sG4oI8+/z6MwsqK2tS8FsmpgMW5hTIRxvRPXvdCfZjkssNAlqYj4JDrRgQdEdEYnmUGk05wFVXj9p/I9yCIkXTJxqs/Vvp/dyj7piU+Vw5G2XqUnnLn9pUl1iVC0YVYXBvPaCs=;24:PIX5Xh7LCSI+WMa5K7VP2GOD0lxebv0FfkiS+1i2lGvG+EVFoar4jSVTkygOn25ikdD2W8rXbfVnBC7NbirzrpuhQvFQlvvby/27deSsRhc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;7:qbA9gzoCxdYVsf39xdOkVSXjaoUNKVdCxRQA+IFO35x7lnCcuFmjrh1+gLt5Ygc9xPT5gDqW5Z6JArdeTaPQlpQwXSb4AEhk2m+QeUdmjzuALVFI/bLYk5IY0OZ88pFo5/G6LEDiOXkLcrMu/vYrr4sPrhYKF5s54gCZY3grP4MaR71UBleLeG9pR3e5Kpe0Mj3j4hI99lP2w5PK1AbAz/V/CfL/+IUoydhyIvQ4IEJ6IM3RW1r8AhuOyME9Xo2y;20:2wxKCas5IBg8cEXHz9hNiHYWUaY6FKmxQe66r7fpo8/6YrrlBUjBHVFWrRswGXDDFw71qCNJ8xrLEzV/EH0b7m5C4MPicZ+s1mVkA37jyiDNRsJ0iK0cNGip4YlMgsaWnHxFuaNYy4MrwIBPoFCaLCAiYgBRbAIKynbJv64GX2e/msS88TSibEBrPck6MLGwCyoWI094cjJ5X7ujxQMKtnLN6jub1V5ZQBmnVXFJEp2q3z1vFFVNAMYcAgt6huqx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 18:59:44.4552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 019366dc-4c45-4213-475b-08d59e4c0f7d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/2018 1:17 PM, Dave Hansen wrote:
> On 04/09/2018 11:04 AM, Tom Lendacky wrote:
>> On 4/6/2018 3:55 PM, Dave Hansen wrote:
>>> Changes from v4
>>>  * Fix compile error reported by Tom Lendacky
>> This built with CONFIG_RANDOMIZE_BASE=y, but failed to boot successfully.
>> I think you're missing the initialization of __default_kernel_pte_mask in
>> kaslr.c.
> 
> This should be simple to fix (just add a -1 instead of 0), but let me
> double-check and actually boot the fix.

Yup, added an "= ~0" and everything is good.

Thanks,
Tom

> 
