Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935710AbeEYG2T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 02:28:19 -0400
Received: from mail-by2nam01on0068.outbound.protection.outlook.com ([104.47.34.68]:12053
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751791AbeEYG2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 02:28:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To: "Prakash, Prashanth" <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org
References: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
 <ac2eb509-c1b0-521a-07e5-2bf8eaaa55c2@codeaurora.org>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <5ff2bebc-fc39-dc82-d7e6-0483e38f7d9c@caviumnetworks.com>
Date: Fri, 25 May 2018 11:57:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ac2eb509-c1b0-521a-07e5-2bf8eaaa55c2@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR0101CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::16) To BL0PR07MB4913.namprd07.prod.outlook.com
 (2603:10b6:208:43::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR07MB4913;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4913;3:k34AADcFKCvJgkaKG1aUaeYnJUlSkyFSgtwS8DdgthAT4MXF+60LWCj3Edi/DyfmJod6CTLMWKtHABPKwSbZOu1Wkr4vJpMqcWoiG3TFvFRHffcz6+JKrxyHNPexZdnRuNN4LPsJM/1yvErQYNfdCxvvA+RWyhe3BxBqXZEHt0dy18KinI12HJyMG3tU4FKduaw896slGdXYixTw58I4BRiCxpJOxokXF6yYkaLwZsKGtC1tNSyxhib3fNMjfVcG;25:c0Z1BVZbIbIxqF5wwQewVjYc663UYmbEp+1soEdV07oYVopLLKfO72SuxLc0CTU0dEArrEtjt7t53TSkuQiIFDwCH5KjifHXvcRehtuaZAkuxZiw7zzChqsTAUWYSE11iVOZ/TjkKMqnZ8P7KP3ByKFndp74YrVsdWjwH40A3tPZvs7V22fq+1JNmtLVjsk1QJBNqbTBY/Gr5iBvkA/xIJMq8sBmBOlR/d5bjhdCCu6ERAxI1Kzc4jkTswVLVbWhMZ/iFINIxaMogJLZyz31ZgL/lVFkchS1vMVC93LSNZvgsEiOpSdgf93eWu9kHddjz5DyX8+y+Wlqt5Vc1lEMnQ==;31:hVEcRYX8jgjQ6vRvzpDwQMttc0u9rTZQAAJPON0JXPJfv6P5J49Atzeqfba8r9Su1At9Fvjf3Y4C5zX57DhzQ7m2aax1XkygtLcB7kMYaBkGdENHOQT4j/rzv2s94TFMcmj1Cs+8mkMyv5agKYfk6muRxngmsKpXExotc/r21x/m9Tq4QIrfkyqmSOVzsw1IyNOjrWQcb+PcDClkjjDy73Wx83V4Jx6oV1Gj0vC5at8=
X-MS-TrafficTypeDiagnostic: BL0PR07MB4913:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4913;20:jzjSlkcMmIv3hexSc5ZyOjXnt6hHODJHZkSQTJs16Xst+69Hm1o2cIvRD7HZg/ldIm2l19AnxOxRTRMMvV4tbDsyz9foZ354K+PtZJ8s01qh5xxYYqAzP0pLrCB9z4mIw9kpc0IRhOGkhA+57IgIN9o31oWCnwTIm2yBL9Dn3OrexOxa8yI/8WXDw1v7dUAUBDCT5P3O9U7BrmmGd5nVZ9zhS7tath5AWGriexkOUD+DOMvYhjNH4JSY6cCnFOd4pqSRnqhxrPVxS4iKX5e25e2+WhoUYhLorZ+9LNPSt7NmcugrKcbxP6opVqcrZh2Bo7MVCgJgK1vK6DlPD2Pe3OI/mAVvrgeclSBOOJeO3nCBNfd1MecWChQdINUw/6wlw7iecAg4erd3DKr+BrfSf1VMeX+pkA4fjosPRzewMqGRzqpve7haKbWxUzAIqLyIsXg9gqJmbhJrT9UmLlJQ7xnuNCM306Aekcr7c5ddchi3RPuF+SqQgTWO9744Cxx+XS2O4oB8DAP7ps8k9drx0b9macJOH7Dc3Ts/OIUGX5RtwbVLbp7tG7m/VzbxN7bfoaiFxkG75MU2Y5hGkRZ8pGnN08yUwIcmpSIWXCZbxDY=;4:4a8wtQKtDu8YZ7c3oakaabrXho55fcUhLgDb2AuQ05zxKrryVqW713l+QNne4sVDcSZeySaMlHDTIN1D2/fQsDFDQnhDv2zW3mY/lPHhtkO3zOT/RSF5ttkfdNq1ay6QAr51wO78QY6+jCrZodXywpPN/HAtkjLAAW+oWp9oBEQj3+DB0pA2vjhhhhG/lNdRRulWUEta9Ty1zlww/B1UXvLOMbM73awHxyxONAKddk9EBizBUraHZepmN9zxNQRTxu1F27TF0Zq21DpTjxr42w==
X-Microsoft-Antispam-PRVS: <BL0PR07MB4913D3B72F550BA0F07EAE1CF9690@BL0PR07MB4913.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BL0PR07MB4913;BCL:0;PCL:0;RULEID:;SRVR:BL0PR07MB4913;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(65826007)(31696002)(76176011)(81156014)(77096007)(53546011)(476003)(2616005)(956004)(6666003)(68736007)(81166006)(2870700001)(386003)(110136005)(186003)(316002)(97736004)(16526019)(59450400001)(305945005)(446003)(58126008)(25786009)(11346002)(7736002)(16576012)(23676004)(486006)(229853002)(67846002)(8676002)(52116002)(52146003)(2486003)(5660300001)(6486002)(36756003)(8936002)(5009440100003)(6116002)(31686004)(4326008)(72206003)(64126003)(478600001)(50466002)(26005)(106356001)(2906002)(42882007)(47776003)(6246003)(105586002)(65806001)(53936002)(3846002)(65956001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB4913;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjA3TUI0OTEzOzIzOkRQQ2JlY3VJMHN0ek5SZWhhS29iMUora0Uv?=
 =?utf-8?B?UlRQRkM5SGw3RWxLVld2SnhBRW1ydHVGUUNYUnRzZFBpbVBLem1pSkFkbFY0?=
 =?utf-8?B?MkZPQzJZNDAwK3grNDZYQzZuTEpyZmZaSW8wb1ZCVHZlQ1RtekRlWGhGOGJ1?=
 =?utf-8?B?ek1IcDc1ekc4cU9PRjZiNjRCUURhTmJLcENqS0pEZzlYdVhPSE94L2xTcmVn?=
 =?utf-8?B?azR1T2FYMExUTW0rNVd1T3BVcFhiSjZ6c3VnUFJpOGNsN1VzNXE5N2xqRkZz?=
 =?utf-8?B?NlVLS29yUGVWUXZHZ0x2UEF6UGszcVZ6SEtFNnRSY2lFZk5wbEpzaSswbGd3?=
 =?utf-8?B?TmFxYUFRMEU1a0NlZEIxclJWQitqQ3BhNitpZzJ1enM4d2JMU2YvZ0JpVFpR?=
 =?utf-8?B?NlptU1BSZzlSZUx5bVNERzZRUUExc3NEaE92NTVNdEx2WktXdWIrZTNuQk4r?=
 =?utf-8?B?c1NoTEhkR25uMzkvNHZnTDUwRHM4cnlpRmZMUm5tS1BtUktTOTJ2MGc1VlZq?=
 =?utf-8?B?Qm8ySDA3Uk00L240YVdEdTMzbWFqTExRZkpYT2J4QUhISU00VSt6Y21vRkdB?=
 =?utf-8?B?TW4vSmtOK1NsbzR3REJ0MUxCSDVqaXdhME9rVHlzQ2x5NmZBcTB1UGtKRWkr?=
 =?utf-8?B?R01zQ1c3SlIzS2hVWTMxQklyeVJ4S1hmZE92WmFZcFdzbFByQXdVbThzTjNO?=
 =?utf-8?B?RHRZYi9WaGM3V2NDNGsvZ2xDRHkzTkxnWWQvSS9ZL0MyVVBNd1kvZXlZM1Ux?=
 =?utf-8?B?Qm1aZzRBbVlSbzlXUG8zVENJMi80TWdWRGRXZmNzc3pFM3hHMGV1aHlTR1ky?=
 =?utf-8?B?SHQ3cWYwVUw0Z2VaVTNJbDdaa3ZKa1JvK1ZjOWs3aVFRV3NkYlJFYnlveTVV?=
 =?utf-8?B?bThBU0VhaGxyWDFSYi8yTUkrWVZQNXhUZjN4OTdJNmx3Zkx4MW04dE02Q29x?=
 =?utf-8?B?VSt5VjQwTVJkL1A5UkFWb2pqNk5CYThnVDk4bnVWbmsySUUrc3Ayd2M2bDl2?=
 =?utf-8?B?cWRFaTBYdnh6dVdpL1hVMUM5cE9tckRKbWFyT1JXQWJrVTN6SytKVW9tQ2FZ?=
 =?utf-8?B?NTBqZTdrOFo1bjRNaWIzZ1lnVkNmQm9paklJMzE3N1B2VmpybFFYZUdRSkcr?=
 =?utf-8?B?L09QRWdneW5qTWZqWEhSMlBuQ2hyMFk1ZU1iQzhUY1VvTGFibzVEbXlDR2Iw?=
 =?utf-8?B?Z2g5dm9rcWJMT05jR01FRkZha3ZjeXFCeCs2WjBWK3J3Z1pqZTNBelJtUGcv?=
 =?utf-8?B?UmR1Mjk5aEt0YjFpVVFqbzV5cXNFbU14cDA3UnZNek83SDgrb1Rxbkk4K2ZL?=
 =?utf-8?B?OGlZcFB2V2NCWTEzM1M0UjlnM2w5M3I1L0Y0bmxlQTlEc1JvN05YUmNQbmF6?=
 =?utf-8?B?cjVKNVM4Q2w0WmxRb1o1bEI0NDdhY0xYaGxjL0tSa0c5bVNqZ3hDTlFkc0Jr?=
 =?utf-8?B?Y3oxVXFXQ29FL1phQVdHRHFHSUVsU1JQWGJYRXBKS0ROWFRJRHdKRG1VWmZv?=
 =?utf-8?B?TE5VWllQODRselpWMU9nTEk0OStjaDVodCtBVG91b1Q0UkU3YnQ0dzl6ZTZn?=
 =?utf-8?B?V094eDJtME1IcjZnbFhmVnhHVDVQajFVRFNUZGJIaHU3RUorTG5xQkpJclE2?=
 =?utf-8?B?NTJnUmZUaW0yK3pub1pPWUxrR3NoR215eERvZkpIdEpSdG4xdVdpbWxOSkRP?=
 =?utf-8?B?aXV1ejVjc1pzQnc3SU9OSTcvMnlubFh5SHBtUzlzMUdrSU4rcXZjK0dGTS9F?=
 =?utf-8?B?azdiM3N6bXh0ODF6T0kxUXE5MTNpZUo3M0xjREM0eEpEVFJYRndEQTV6SitX?=
 =?utf-8?B?d1Q5ZytjWnFTSkI1TzNDc0FiU0hUL3NISHM5NUx0a0x4RVJreCtIQTZ0L0d4?=
 =?utf-8?B?K0pwRGJGRUlmc3ZEUGY3T0lKZytHRWFWdGRQK2hmcFRMUi9PY1F3LzU3ZmdD?=
 =?utf-8?B?UHU2ODRTc2k1TUNIUWsvdnM0cUVUNTB2ZGhJVHp6ZHN2QXloSDVYc1NQSHA2?=
 =?utf-8?B?OC9YNmN1ZGdCQzRwa1R1YSsrRGJlRk1qRHAxSlF1WFFCcUZ2eEZnREJRcWRI?=
 =?utf-8?Q?nmIvO7YGPNqjDhywqy82kdGWQ?=
X-Microsoft-Antispam-Message-Info: CS3OMf5kSFmz/wwL6eHXNqbxg/rpv85K8KqxCivghluqPIyIna1u+/AR4tEs0ejR/aW5g5DoSOOECQbnB0087lLlNyqIfvczYWiG9vmoI1UZzWio/jU3KDftMlyifDBw0/yJ7Fo9DyMMI1+WWmux0MbdptsvwHIEdNEGvifH2GOnxSnLh8yFxQGvxURSseOm
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4913;6:igoEjmIs4PpovP/rcWJvDQ/7Ribccwl5Ldo4sb+4OZDnzS0G5JvY2W7VVitzZhwn/v6GGCUVs/TPWNiWbhSlGnfP9C/c5nAo+8olBB8D9gal1MMYTu4AlgUCMk9O3kQow/4IdPGOJnAFEEZTv2fYKv9Jn9DUXjsM+efa4vIW96553w3gkDp0v2Wj6dj1beH9dsiV6NFg0oJdzyCyRUUmsJGhw+2o34RNc0HGyFGioFM1CYuVfi7YWMSiIWAN0uH8xn4tz9e5nAfKjqQ4UK5B8e4urplixXaT0apqSXros8ya7DGT6Et5Uq8/6E1WyLbY48M+W+cX6tUJtNDITQqmENz4uEYq24bTL2zi+pYpurKBug4kNkMdkMIgAvc9W6SPwPiD25p7zgYt0wHrO9B2B0a7ZXHU5G3h6uafh+7Ttgy0cduJOL0FikD+y6JTz/qGqWZILFdGDb0zcsIpz7Kg2Q==;5:rxMHY8UePpGRmLkQlpnE7eS/EdWfW6Cw9ylG5UCd5AJZgIpfxZGruFXbTS59k/KQwWId/4GM2P0BtGIjpdqEyjtk3V2vzeFiv8vdOe3eUxPvbNZ1uRVbGKM9cxOrn0nfpyA+OOi8tqjRte9scyMtY9jPVmov8qBf9QMApEWZqRU=;24:clhXdGHkbcZCEP+mkoUpc8+kzJocA4BtRm4TH3yK7OtPfBFxz88kly9K3gmP4k/lhUL2sn7hWp+r0XOinmFkPrNKTKJKegzpj32rS8XPa7I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4913;7:t0+qT/caEJOJiTyTFXZxnmWKqXpSia8H65bupkqQBhU+7nTIWOexXJwGmgmkWyxp+LjhP17J//8PIFjOypa1RxUlL3fDiyDf3CttxAM9l3lzu+9IxyOsjOqVUGwf02jdkFV5LTD31w0XcCP9q7xpPY3gkJHol5Zrl/M/oPK2JqAqLqoqAvlOB9fUjHHBTo1iEXd/IMElFxz7NYvlxNEr2KxgDeDLJM48k8Yvjt//6sj4APYJOyJNg9i3GMe5hkQR
X-MS-Office365-Filtering-Correlation-Id: ae792f8f-9b24-4a8a-a5f4-08d5c208b1a1
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 06:28:12.0198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae792f8f-9b24-4a8a-a5f4-08d5c208b1a1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4913
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashanth,

On 05/25/2018 12:55 AM, Prakash, Prashanth wrote:
> Hi George,
> 
> On 5/22/2018 5:42 AM, George Cherian wrote:
>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>> feedback via set of performance counters. To determine the actual
>> performance level delivered over time, OSPM may read a set of
>> performance counters from the Reference Performance Counter Register
>> and the Delivered Performance Counter Register.
>>
>> OSPM calculates the delivered performance over a given time period by
>> taking a beginning and ending snapshot of both the reference and
>> delivered performance counters, and calculating:
>>
>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>
>> Implement the above and hook this to the cpufreq->get method.
>>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index b15115a..a046915 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -240,10 +240,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   	return ret;
>>   }
>>   
>> +static int cppc_get_rate_from_fbctrs(struct cppc_perf_fb_ctrs fb_ctrs_t0,
>> +				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
>> +{
>> +	u64 delta_reference, delta_delivered;
>> +	u64 reference_perf, ratio;
>> +
>> +	reference_perf = fb_ctrs_t0.reference_perf;
>> +	if (fb_ctrs_t1.reference > fb_ctrs_t0.reference)
>> +		delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
>> +	else /* Counters would have wrapped-around */
>> +		delta_reference  = ((u64)(~((u64)0)) - fb_ctrs_t0.reference) +
>> +					fb_ctrs_t1.reference;
>> +
>> +	if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered)
>> +		delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
>> +	else /* Counters would have wrapped-around */
>> +		delta_delivered  = ((u64)(~((u64)0)) - fb_ctrs_t0.delivered) +
>> +					fb_ctrs_t1.delivered;
> We need to check that the wraparound time is long enough to make sure that
> the counters cannot wrap around more than once. We can register a  get() api
> only after checking that wraparound time value is reasonably high.
> 
> I am not aware of any platforms where wraparound time is soo short, but
> wouldn't hurt to check once during init.
By design the wraparound time is a 64 bit counter, for that matter even
all the feedback counters too are 64 bit counters. I don't see any
chance in which the counters can wraparound twice in back to back reads.
The only situation is in which system itself is running at a really high
frequency. Even in that case today's spec is not sufficient to support 
the same.

>> +
>> +	if (delta_reference)  /* Check to avoid divide-by zero */
>> +		ratio = (delta_delivered * 1000) / delta_reference;
> Why not just return the computed value here instead of *1000 and later /1000?
> return (ref_per * delta_del) / delta_ref;
Yes.
>> +	else
>> +		return -EINVAL;
> Instead of EINVAL, i think we should return current frequency.
> 
Sorry, I didn't get you, How do you calculate the current frequency?
Did you mean reference performance?

> The counters can pause if CPUs are in idle state during our sampling interval, so
> If the counters did not progress, it is reasonable to assume the delivered perf was
> equal to desired perf.
No, that is wrong. Here the check is for reference performance delta.
This counter can never pause. In case of cpuidle only the delivered 
counters could pause. Delivered counters will pause only if the 
particular core enters power down mode, Otherwise we would be still 
clocking the core and we should be getting a delta across 2 sampling 
periods. In case if the reference counter is paused which by design is 
not correct then there is no point in returning reference performance 
numbers. That too is wrong. In case the low level FW is not updating the
counters properly then it should be evident till Linux, instead of 
returning a bogus frequency.
> 
> Even if platform wanted to limit, since the CPUs were asleep(idle) we could not have
> observed lower performance, so we will not throw off  any logic that could be driven
> using the returned value.
>> +
>> +	return (reference_perf * ratio) / 1000;
> This should be converted to KHz as cpufreq is not aware of CPPC abstract scale
In our platform all performance registers are implemented in KHz. 
Because of which we never had an issue with conversion. I am  not
aware whether ACPI mandates to use any particular unit. How is that
implemented in your platform? Just to avoid any extra conversion don't
you feel it is better to always report in KHz from firmware.

>> +}
>> +
>> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>> +{
>> +	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>> +	int ret;
>> +
>> +	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return cppc_get_rate_from_fbctrs(fb_ctrs_t0, fb_ctrs_t1);
>> +}
> We need to make sure that we get a reasonably sample so make sure the reported
> performance is accurate.
> The counters can capture short transient throttling/limiting, so by sampling a really
> short duration of time we could return quite inaccurate measure of performance.
> 
I would say it as a momentary thing only when the frequency is being 
ramped up/down.

> We need to include some reasonable delay between the two calls. What is reasonable
> is debatable - so this can be few(2-10) microseconds defined as default. If the same value
> doesn't work for all the platforms, we might need to add a platform specific value.
> 
cppc_get_perf_ctrs itself is a slow call, we have to format the CPC 
packet and ring a doorbell and then the response to be read from the 
shared registers. My initial implementation had a delay but in testing,
I found that it was unnecessary to have such a delay. Can you please
let me know whether it works without delay in your platform?

Or else let me know whether udelay(10) is sufficient in between the
calls.
>> +
>>   static struct cpufreq_driver cppc_cpufreq_driver = {
>>   	.flags = CPUFREQ_CONST_LOOPS,
>>   	.verify = cppc_verify_policy,
>>   	.target = cppc_cpufreq_set_target,
>> +	.get = cppc_cpufreq_get_rate,
>>   	.init = cppc_cpufreq_cpu_init,
>>   	.stop_cpu = cppc_cpufreq_stop_cpu,
>>   	.name = "cppc_cpufreq",
> 
