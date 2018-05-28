Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753940AbeE1HJ4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:09:56 -0400
Received: from mail-bn3nam01on0045.outbound.protection.outlook.com ([104.47.33.45]:36802
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753917AbeE1HJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:09:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To: "Prakash, Prashanth" <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org
References: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
 <ac2eb509-c1b0-521a-07e5-2bf8eaaa55c2@codeaurora.org>
 <5ff2bebc-fc39-dc82-d7e6-0483e38f7d9c@caviumnetworks.com>
 <37517652-9a74-83f8-1315-07fe79a78d73@codeaurora.org>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <0959a657-5a98-1d4c-ed9d-ed057e3bd9ad@caviumnetworks.com>
Date: Mon, 28 May 2018 12:39:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <37517652-9a74-83f8-1315-07fe79a78d73@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::15)
 To DM6PR07MB4922.namprd07.prod.outlook.com (2603:10b6:5:2b::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4922;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4922;3:94Ma0pgDdah3gRWd2j0nDdDaU1borX+AeorUnzsgIQ6+MDfD1ZwMc/yRMTYlHmyN3pAJYKyf/tvkvd2wNYhBP5JmywaqwoRYy5+UaGc0N09m0MaNZ9wJQfnjJUBra2u6duEYUW+AbmOwKPkEW1ZhczFD6crqupsecTdisTyluuHqHmKlLoWzDfXSYEMPL3zD/BdvzLe9dm6aFdX4Ku6fEvXNK9g2d9VX99BQk+SXJaDYun0eOL/tOOLGa8TbsTCP;25:zVse3OFW182KE6PBwLzAM4LIrnrYXpqT2GzA9qQxftdQec1yBTCBIlEfb/31LJDX1xD7cCWUZVwji8nkOaSe3MiT7UUNnBIzhw0KPD0vtBrKIvOBpZ6cGtzdc5Z6IfkFv99hVQfqUtEANKxomaQ+6yMZZYY7ms7j/rDpAPkyAL5Msq4ue7Gv9kaNnyju+MF3vnxRppAAnESI7cmeeuCfiGln4D3HX2gtOncJ/Zh9omMqycKC6U6J8JEdJPW13TYAQe42fJNR9OZkbvgbLZsNHSyn5pDoWRV3F6gS1v/vrZdRl5lOvkxwI3vD5ydVl0YX6ET1ZNzLqV2cG/oiF/b8bQ==;31:iKOkHHdlsfdnjvGHmBX77iDnq+QeR11OyGGkVLyKjYDgnc2JHUNzOz8o557mugf/5eZc+Pui69j2t0rk9y6ktERGvr2r5zkzMe8qyhRgeI9zLojnkNz0+aUWM1XcI9oEsjK+B9MKDiHGpcEg07zLvOD15yVXHQgXitc5cyLT35BDJihx0jdmDc/MazBwSy0sKXRAMoxvYEGdite16U9ZoRhJof/bCPsE0Jm2XlhsSQM=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4922:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4922;20:Yeh4MG401QkEVvIpjEbJZ7FjzT7qYjd8qqpRR4SLQdjlB7jSTi2I1/ON7P7JMsaMZ7n4ov6krLmcNJ0r3R9yd/J8m/wg1ArrVOZ6HjMbInDzLcIfVYORVUCH69NiDtZfWRTh89jB1f8Vybr5Ijo0/5SpYNLYivbHxO7NLD5J35CkngNFFGvUN2fwq2io573PkqPnwapEyCAQYrlD6b36Fc+SJTiCfcNh8mwT7uNsB5WFlb1f2wBWvoo0r4dWfWFUzWJhxNHf4BJCTZlUQ+Mx49dG15hi3vMdID+tiSlDWYOhWmptb3wHoDO1BbM6nM6HOWEpxjvaL8Ky2gICNa/PUhrb+9j8AMuoKFCCnuqO+zwV29XziHgHE5vL0fM52LQ23B79YTro3tlkTMdjpbwu92sYnPYtMkXknWxPRhSrcjhkhRnzvN/R2HuQaDZEsiKK27ncVDuB/ROtUm+1VxnVBPTpW1lVtYc+D5gZxrc0uwmt0cP6QvFqJwhc7tes9xGCtW6evs+SMUlkdiqYZQDb8mDsMraesJnqptOBumAYOtc5JpH5Zo/x7mbFjlgrz+pUzBG8RqEBGeCK73sg5Pd3GXgz8ZxiP6lh1tjx0MNM7dw=;4:GfwO+ruzGf/1sF3lGU5Q8aH5USmu6gpyjiVaq2OfvsoaLNT8uB5dpnHiEL9zENeuudG2OWyw9TuVc+PxtCid66Rs9dSkWVQgBlmaXJew1kkTtUL6ebrFAF8LkEWcgPAXqzBIuW7almGWCZ5U8Uvpyz7SiDG0qKaW+aLZzwvVbxA2QQnklVst/3yka0AElNtXt49VhDmTDzHhVOarpL6JZMqHjTu26qbwolnnrDhmy95wLvMB/KkgJSOF/8lhOcInDWaDmOlNsptnAAMhqovbWA==
X-Microsoft-Antispam-PRVS: <DM6PR07MB49224BF981E5B88D65147592F96E0@DM6PR07MB4922.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4922;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4922;
X-Forefront-PRVS: 06860EDC7B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(346002)(39850400004)(396003)(39380400002)(199004)(189003)(53936002)(52146003)(11346002)(186003)(77096007)(26005)(42882007)(305945005)(7736002)(16526019)(23676004)(2486003)(478600001)(67846002)(76176011)(8936002)(36756003)(8676002)(68736007)(81156014)(81166006)(486006)(6666003)(65956001)(66066001)(72206003)(65806001)(47776003)(2870700001)(52116002)(105586002)(106356001)(446003)(5660300001)(59450400001)(2906002)(31686004)(956004)(2616005)(53546011)(65826007)(476003)(50466002)(6116002)(64126003)(3846002)(229853002)(31696002)(25786009)(97736004)(386003)(93886005)(6246003)(16576012)(4326008)(58126008)(5009440100003)(6486002)(110136005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4922;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA3TUI0OTIyOzIzOlMzMlluNjBYNVhLaERXWXVDYXcxaXZOZHNW?=
 =?utf-8?B?Qit6QytJS05GcjA2N0NtZEdNZllSN0hyOGNXRTRZOU1UUzY3d09YVDVDT1dP?=
 =?utf-8?B?YXN2SEJVaWRiYVJxMjNHS0JMWXJqL1ZrYXlMQ1g0SW5Dbnk2eEJlaC9sVXlM?=
 =?utf-8?B?eC9tUUkyTjhTMmErbGJXTzF3K2NYQktIMXFBYk4wMk5CdGRJUi9wai9odDB6?=
 =?utf-8?B?MXAxK1YvcDdzQWVMNm5lR0VRVVJkYTdtWTE5ZHdwWEVDUFhWR2p3aVg1ZG1v?=
 =?utf-8?B?SWdEeXpzVkZhOUIvdXAwRHNxZGVBQzVXSXAyeUhFYUxLS3pKT0V1KzVmNWZh?=
 =?utf-8?B?ZG5tWmxWYVZkc01MQXF0aFNzN1lHck03VHlBL2YxWGRnODVNc2JRVTNqNys0?=
 =?utf-8?B?V1FhaXNxUDF2RlNqOWZyS1BLK2JlZE1hRS9aK00xdUI3NS85bDFyL3psNTNO?=
 =?utf-8?B?OStJcDU2ZFJUcFBMdVdUSG93UmFZakRuc2U0bS8vd2tFdnF0QlJENkkyUkx5?=
 =?utf-8?B?MC8wajNKWngrVTJMVUxaaDVYU1l6WWVkYS9yeFlNMnZDWDFVV0hJd2hobEJ2?=
 =?utf-8?B?YkwrSDBFTzBHSGJnMFYwTnB5QURJU20yR3JNWVEyaGlPOG9ZUHoxZHFvZ0Yy?=
 =?utf-8?B?TW11RDFLbTJ6Z3dlb2YxcjFIMFc1SjhUYkRldXc4em9NWEpqYUppQkpMRXRH?=
 =?utf-8?B?TTEycXU3UExOd2pRL0ZuU0xiSldZMUZkRHJGTE9kOXNiVWNYa2dTcFJqbEY4?=
 =?utf-8?B?bGVBbU1YWWE2WUVyK1ZIT2FaZGRPS3JJcFRlazM2aFVXWkFrQWNZWmFLR3Uv?=
 =?utf-8?B?eEJtVUtPYzN1MVE5aU4vSHJ0MmZYM0NnOVJYbnNxdlZLdkdQUWRyME9HL25V?=
 =?utf-8?B?VWI4L1ZZb20wYS91UzBWbVR1VjZJbTEvVmtTZXdJNGJsTzNMYWNJMmhoWk02?=
 =?utf-8?B?VmF2TzVRVmN0TVJqcFdCdEJhQkE4TzQ0b2lZREdhZktYaURRZUZ0WFlrUkFL?=
 =?utf-8?B?Y3hETFkvdGwvS0dQY0ZwL2tDbFBwYlMwb2trMUcvUEkzVi9yajZBQXFnZ3du?=
 =?utf-8?B?UU4vRFMrVk1aeWdFSTFYMC8yeUZITnZLTmhBRTN2aExHbklCWDlYTk9XS3JH?=
 =?utf-8?B?ZVIwbVlPZEJlVDJJRHdueld2NEtOMlJ0MU01a1lLaSsyWkc5NnFvZS9YV1Za?=
 =?utf-8?B?eFM1OVhsdUNoUHdET1cxNDhiZThTWkFUemZVcU5HODZJYlNDM1dRZlJFcSs5?=
 =?utf-8?B?SzlzdmFBMHVkNytXM25tbFZGSWd1dnZmZFlVZCtXTzM3WUZrdDZyK1pHc2hV?=
 =?utf-8?B?TjdWTHE2anFIK0pvSktHbFR5cm5jemtzL2hjVG9qWTVRRDlLU243Q3g0SVc0?=
 =?utf-8?B?Ungwc1pLZzUza1M0RXU3bkNXR0I2OHlTTk8xUDh0NHFSZ0RRY3JlWSt5eGQv?=
 =?utf-8?B?aVpnY3BrUkdrVGthV21lenNwYXBHVXREazZ6dzB2bStaNnNJNzZlYU5QQkVI?=
 =?utf-8?B?YmI1aDhpa1EyS01YVG51YmlJSGVaclVKaE5UV1RGRmZKc1kybkNqV3RpWWFF?=
 =?utf-8?B?R2pMbUdvcFBvRWF0eHhiNWRFRTdlTTZyWWpDa1drdDZZVGxNNFlpT3hrOGhi?=
 =?utf-8?B?Qmp4Q1RNcy84KzB1eGVRS1pkZDdDTmFCTm5aVEJXK0YwNnQydytoSU1JdzRM?=
 =?utf-8?B?czFzWTZvQWcyb2tGTTNWeW4rOVBIVlZVcjR5cjAxckthNnhraE54Z0JPOEhG?=
 =?utf-8?B?Si96aUdqUkJ2R1N2UTI1dWNRUkkyM1dPcElDaWlFUTJmMWgrUFR0YkVUUXFt?=
 =?utf-8?B?RXppS1pBMjRSaCsrR0prTWJ2aHd6T0h3SmI4YmZvRHNmWWcvS2JVbnI4WjZH?=
 =?utf-8?B?Y3hwaWkvRE80aXJFblY3U1NVbHNhVUJtZ1ZFL3FIYmhXM0NWWmRTcG4wUjlY?=
 =?utf-8?B?aSsybWk0anFsMzNOS0R3RjVQU1FkZHBKYmJNQ1hvZ1hKa0Y5SEhKcVNuMDBC?=
 =?utf-8?B?aTJnVzgxWHhITTR2WDFrUHdxT0VGZ2NsS2dJVGhjYTd2YytpQnVacWhnRXJH?=
 =?utf-8?B?THBEZGJjRzJFNHFmQW8xNXVFUWFVNGtnMzlHS1Fra2FCTVY4bFJLK2h6NVho?=
 =?utf-8?B?Qnc9PQ==?=
X-Microsoft-Antispam-Message-Info: VLb0wTK9xi4f3bgpxEx+SbSz9DoZYT7N0CIMzQw528vSWgj8icyUm/Ummwkp7PnY1eJ0F+uH5Kwb2fiu7IQHpTdJNHSzezm9W4DQz3TqvIn5Rr5TCnzTqE4T5vRg5gNlxh4HGEoUHD18lu8+HmvRa9GkUPmsJ5Ij7DTZWKi0uqkvsfduz2siN/+79N0/lVK3
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4922;6:/wwns4/MZ2CuoRD8Z47qiEb9xOXduU5OIRxuffSh2Fn2xKr7lS70XeUEggxpFKA5mTFEvb9foiKgAISJgkq5ykq9ZGeXb90BxBYfnNwhfkGxy7sTEsiVhbBXlXonxF4FXYbfwAURwaORZ8pqjqEb9zD1K9ZT6g4pY0ctSLS82z+iizLpnPpU9YCeRC96nkt9OudeMuJU7yMdpU3XdP+Gd33NjhuRyRqXMEm++mSfqWn9lbeUGz10Woho4QhYv6YjMhuRKJDOoGFcw4+hv8qzxCp4paZ+DJ0o7BUTX8ODj84LVlMf6yZEymTK58Y1ApVsMVIrpo4KWkD4VS+mK3hcN4uYLDtZnVDAQeiRxht6s84SRQh2SlDcceDWc12jxPov1FDENlLY7DK+CtcqiFNXCadyzpVIws5dtxI9talNQ0FbGNgdllYNH8dj1O3zrYXmCv1xfKzyvmfDcMmXc6d3Zw==;5:THSWGLIdZXs6vpWzyrV16SgCJJvfzQxwPJY7G4+63x8D5Qboe7iTjvY8z8HSWfaTG+tDL/leMmw3CxKFh+3eXRR38X/hgBfMGqxaNyJup51l1QHwqvZqIRfKsuKgB4VxM4w3PCYHIBYRXFuotdg8uoZsSn0bFhDbP+VFIauGcrc=;24:65O3MF/atNGFP35attsZgO26pK/DA5qhj9wAv9oNXb88zStxF16jKfYYw5DzduOiPcDsKpxeJ/FENVrmzqRoqiIOonHVhZrNym1YIWGGE1w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4922;7:7fN+dUlaRwwwqDtMBAmGLtU1llQONdf2HL99c8su/8UBs0pghyNJ9moJXdaQanh1bK+dSb0tc9rTVY0cPwBgxozXAtXqAN3EWesGIs/iubtMJPsoHvPs2hdS6puCfxzzLHCE4dAxXOva2uhG+c8d+/2Jbs5km6PKGG8vXNMYKf+0rDqyeLmjE163s6F4G3EuOCuOGlySJiUliIAL9w4TIoMIh8+eqZMTGZHQwQ3XBAJNsOCOCZZF7aRgsfj5oZCG
X-MS-Office365-Filtering-Correlation-Id: 569fa2c6-8cb1-4b5e-4c93-08d5c469f703
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2018 07:09:31.4325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 569fa2c6-8cb1-4b5e-4c93-08d5c469f703
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4922
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashanth,

On 05/26/2018 02:30 AM, Prakash, Prashanth wrote:
> 
> On 5/25/2018 12:27 AM, George Cherian wrote:
>> Hi Prashanth,
>>
>> On 05/25/2018 12:55 AM, Prakash, Prashanth wrote:
>>> Hi George,
>>>
>>> On 5/22/2018 5:42 AM, George Cherian wrote:
>>>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>>>> feedback via set of performance counters. To determine the actual
>>>> performance level delivered over time, OSPM may read a set of
>>>> performance counters from the Reference Performance Counter Register
>>>> and the Delivered Performance Counter Register.
>>>>
>>>> OSPM calculates the delivered performance over a given time period by
>>>> taking a beginning and ending snapshot of both the reference and
>>>> delivered performance counters, and calculating:
>>>>
>>>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>>>
>>>> Implement the above and hook this to the cpufreq->get method.
>>>>
>>>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>>>> ---
>>>>    drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 44 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index b15115a..a046915 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -240,10 +240,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>        return ret;
>>>>    }
>>>>    +static int cppc_get_rate_from_fbctrs(struct cppc_perf_fb_ctrs fb_ctrs_t0,
>>>> +                     struct cppc_perf_fb_ctrs fb_ctrs_t1)
>>>> +{
>>>> +    u64 delta_reference, delta_delivered;
>>>> +    u64 reference_perf, ratio;
>>>> +
>>>> +    reference_perf = fb_ctrs_t0.reference_perf;
>>>> +    if (fb_ctrs_t1.reference > fb_ctrs_t0.reference)
>>>> +        delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
>>>> +    else /* Counters would have wrapped-around */
>>>> +        delta_reference  = ((u64)(~((u64)0)) - fb_ctrs_t0.reference) +
>>>> +                    fb_ctrs_t1.reference;
>>>> +
>>>> +    if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered)
>>>> +        delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
>>>> +    else /* Counters would have wrapped-around */
>>>> +        delta_delivered  = ((u64)(~((u64)0)) - fb_ctrs_t0.delivered) +
>>>> +                    fb_ctrs_t1.delivered;
>>> We need to check that the wraparound time is long enough to make sure that
>>> the counters cannot wrap around more than once. We can register a  get() api
>>> only after checking that wraparound time value is reasonably high.
>>>
>>> I am not aware of any platforms where wraparound time is soo short, but
>>> wouldn't hurt to check once during init.
>> By design the wraparound time is a 64 bit counter, for that matter even
>> all the feedback counters too are 64 bit counters. I don't see any
>> chance in which the counters can wraparound twice in back to back reads.
>> The only situation is in which system itself is running at a really high
>> frequency. Even in that case today's spec is not sufficient to support the same.
> 
> The spec doesn't say these have to be 64bit registers.  The wraparound
> counter register is in spec to communicate the worst case(shortest)
> counter rollover time.

Spec says these are 32 or 64 bit registers. Spec also defines counter
wraparound time in seconds. The minimum value possible is 1 as zero 
means the counters are never assumed to wrap around. Even in platforms 
with value set as 1 (1 sec) I dont really see a situation in which
the counter can wraparound twice if we are putting a delay of 2usec
between sampling.

> 
> As as mentioned before this is just a defensive check to make sure that
> the platform has not set it to some very low number (which is allowed
> by the spec).
It might be unnecessary to have a check like this.
> 
>>
>>>> +
>>>> +    if (delta_reference)  /* Check to avoid divide-by zero */
>>>> +        ratio = (delta_delivered * 1000) / delta_reference;
>>> Why not just return the computed value here instead of *1000 and later /1000?
>>> return (ref_per * delta_del) / delta_ref;
>> Yes.
>>>> +    else
>>>> +        return -EINVAL;
>>> Instead of EINVAL, i think we should return current frequency.
>>>
>> Sorry, I didn't get you, How do you calculate the current frequency?
>> Did you mean reference performance?
> I mean the performance that OSPM/Linux had requested earlier.
> i.e the desired_perf
Okay, I will make necessary changes for this in v2.

>>
>>> The counters can pause if CPUs are in idle state during our sampling interval, so
>>> If the counters did not progress, it is reasonable to assume the delivered perf was
>>> equal to desired perf.
>> No, that is wrong. Here the check is for reference performance delta.
>> This counter can never pause. In case of cpuidle only the delivered counters could pause. Delivered counters will pause only if the particular core enters power down mode, Otherwise we would be still clocking the core and we should be getting a delta across 2 sampling periods. In case if the reference counter is paused which by design is not correct then there is no point in returning reference performance numbers. That too is wrong. In case the low level FW is not updating the
>> counters properly then it should be evident till Linux, instead of returning a bogus frequency.
> 
> Again you are describing how it works on a specific platform and not
> how it is described in spec. Section 8.4.7.1.3.1.1 of ACPI 6.2 states
> "The Reference Performance Counter Register counts at a fixed rate
> any time the processor is active."
>  > Implies the counters *may* pause in idle state -I can imagine an
> implementation where you can keep this counter running and
> account for it via delivered counter, but we cannot make any
> assumptions outside of what the spec describes.
> 
>>>
>>> Even if platform wanted to limit, since the CPUs were asleep(idle) we could not have
>>> observed lower performance, so we will not throw off  any logic that could be driven
>>> using the returned value.
>>>> +
>>>> +    return (reference_perf * ratio) / 1000;
>>> This should be converted to KHz as cpufreq is not aware of CPPC abstract scale
>> In our platform all performance registers are implemented in KHz. Because of which we never had an issue with conversion. I am  not
>> aware whether ACPI mandates to use any particular unit. How is that
>> implemented in your platform? Just to avoid any extra conversion don't
>> you feel it is better to always report in KHz from firmware.
> Again think of spec not a specific platform :)
> - The CPPC spec works on abstract scale and cpufreq works in KHz.
> - The above computed value is in abstract scale
> - The abstarct scale may be in KHz on your platform, but we cannot assume the
> same about all the platforms
For now can I assume it to be in KHz only?
I am not sure how to convert the abstract scale to Khz.
Can you please give me some pointers on the same?
In spec there is currently no interface which tells what is the abstract
scale!!
>>
>>>> +}
>>>> +
>>>> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>>>> +{
>>>> +    struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>>>> +    int ret;
>>>> +
>>>> +    ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return cppc_get_rate_from_fbctrs(fb_ctrs_t0, fb_ctrs_t1);
>>>> +}
>>> We need to make sure that we get a reasonably sample so make sure the reported
>>> performance is accurate.
>>> The counters can capture short transient throttling/limiting, so by sampling a really
>>> short duration of time we could return quite inaccurate measure of performance.
>>>
>> I would say it as a momentary thing only when the frequency is being ramped up/down.
> This exact behavior would depend on how different limiting functions are implemented.
> So this would vary from one platform to another.
>>
>>> We need to include some reasonable delay between the two calls. What is reasonable
>>> is debatable - so this can be few(2-10) microseconds defined as default. If the same value
>>> doesn't work for all the platforms, we might need to add a platform specific value.
>>>
>> cppc_get_perf_ctrs itself is a slow call, we have to format the CPC packet and ring a doorbell and then the response to be read from the shared registers. My initial implementation had a delay but in testing,
>> I found that it was unnecessary to have such a delay. Can you please
>> let me know whether it works without delay in your platform?
>>
>> Or else let me know whether udelay(10) is sufficient in between the
>> calls.
> Feedback counters need not be in PCC .
> 2us should be sufficient.
Yes I will add this to v2.
>>>> +
>>>>    static struct cpufreq_driver cppc_cpufreq_driver = {
>>>>        .flags = CPUFREQ_CONST_LOOPS,
>>>>        .verify = cppc_verify_policy,
>>>>        .target = cppc_cpufreq_set_target,
>>>> +    .get = cppc_cpufreq_get_rate,
>>>>        .init = cppc_cpufreq_cpu_init,
>>>>        .stop_cpu = cppc_cpufreq_stop_cpu,
>>>>        .name = "cppc_cpufreq",
>>>
> 
