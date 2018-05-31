Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753947AbeEaGdy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:33:54 -0400
Received: from mail-co1nam03on0082.outbound.protection.outlook.com ([104.47.40.82]:34528
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753760AbeEaGdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:33:50 -0400
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
 <0959a657-5a98-1d4c-ed9d-ed057e3bd9ad@caviumnetworks.com>
 <955aeba5-bd5e-6051-b283-ad544327ce64@codeaurora.org>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <8ed43688-4c92-13a2-b864-e26c22853d1a@caviumnetworks.com>
Date: Thu, 31 May 2018 12:03:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <955aeba5-bd5e-6051-b283-ad544327ce64@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::18) To SN6PR07MB4928.namprd07.prod.outlook.com
 (2603:10b6:805:a5::29)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4928;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4928;3:TftQeshOCjBguJqy9vR/S+er5tiel2NLQQWJ0ozXVv4goknCZllIUgb5EFOKkFQ1zcHvVv/c/dV0XK0LspPJo91fTj8dfw4G6FZN3j36TWbDk21HwakbWxCIFg0R08VU9A1vpnph/7S0Ty5lvsOhg3snj5IB+jZzyky/3ONag6bj+R+5frOgwh2TzHAc2NP+4SIqSphd2hndM5UQ1RlJ9QOAzoVCU4A4wx94KpJxtszIxUhxcUI4CfwT0Qft7ww3;25:CmJ2BKb2HV6BJFlnbbWcDHJuzW95Q9sRviQscw+6MGep3lrFzpDdd2lHVu/tMhW8jxTJ8EnvO0UB7gdmWH1Jw+Xei4WlUjNgkRkKjQH1YNuGPJ9vHumuaVFGu7t4meAv5yM+dzp5ZblCQfxPDjMhB2HpZXxfgINTtHBufLhusBVbjJTJTAg+TtmI6ircrGtMI7hpJCcdChbmC1f3ueJ9WDKyjTAR2jsfop+MeYDX6QbN8u92DYNoo/7DIWmqVu4rCsjP2qDsjhF+VhEUDIOaQXihidOHTKP1/EzmvIP96V4oKuQQ8ixAEKxnfwjJhE5BctwK6aT3ivZjrQu25fShOg==;31:3t/qHl7V2RWTlzgkUrDOyJcXd3u6lBk5au6hB+Bjyb9zYRQ2RU31cC70YSwAkrBhiyscPVvcATAUbOcU4OqU70nXHym4Ie3YEVYP/gcZDTyUHUs4cWvoy7VqtzkfXAlI5CEqXiBwAv7QzqelSU5wEo2TkISqjdpXzIVYOzi4aH0xUfCq1M12XjuppMBm54iB0nPhWctfP6yI4ZOD8UsJFSpmVXTdw5jwIX29LONrXPQ=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4928:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4928;20:gLry6+ptCA1Lm+jsefcv+xdAHsiFmMBf4YiXW8fqBzkH1mAmMLjIqxLOmLe35bbeNPxD731u14gnM7Q1eB+9HLNfwLwMKTVV/mPEcGJiKy1kCZEb6ZqcjxTHNTLu5CjQBi+HuMRdYWiTmnnHJoqDapRZN2YwNdNLc0C4ufWYUCETL83ljjkAW2bqZIcFmL0EaLQLThCNUNn44C5/yEzG1Y5mdBa4rb6RnVZgkTT9QfEe9oduu7oOibxGFuDD4YSt/QPX60niH/CUGppqaRcz9x/B9O/URBVTcklybMweEgd/b01QRDyeHNJH9hmu7VHloWRd5+tc7jp8YVFXiFik/dmAf5AB1DxBMlRnZxbXzsseTb0caEYYRomYGd803DqZeVGfh1CjMkVjhOl7iNg1puOhkep0vZ8MyyM/lezyszA6Ru/3YyCwAhyN6OBu1QAV6JytBr0Ct6iOtvPn/XXhkLXPJ6rdHF7PuzpAW41piU/yzpXLkmfdK/kn4TdjXxnM84IzuRGvH0RcH+bMHT2dSfWIohb3QTuIC60auTNlLtDfZ+LZ/clmtj0B3wIyl3zw0vmHEZVrGWnk0EjYOp52gEJn/hYP/2ugz7TxJR62EcE=;4:3p2NoLjfVA6LFYMMO2bUqKIL+ReFwmngMpge9jawXX5XEXXXJaD/LF2oePp0iuc/YjggpSasMp5hz3iLoPREv3v+NErqRIS3q6FG8a+Oyumm0Nlg7VX4Z41z+cDUb2xpfbPodXyG3eE5rQbSiE1tBwBCNDgzdxqERd2cLBNRfrGOpMiGzaOuwFmhl2RtHSeBsJi/M/7Y7envh57rEDbAbTFR6/rbdRIWarXRMQB7RCCz9WDJCf5LhOTqRPFd1Q2+0Qxwud8o+xwT+KAgBkNE9g==
X-Microsoft-Antispam-PRVS: <SN6PR07MB49289B2821C1E2EFC3C5F0A3F9630@SN6PR07MB4928.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4928;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4928;
X-Forefront-PRVS: 06891E23FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(366004)(346002)(396003)(376002)(189003)(199004)(7736002)(4326008)(6666003)(65956001)(106356001)(305945005)(65806001)(105586002)(476003)(11346002)(31686004)(31696002)(66066001)(53936002)(6246003)(97736004)(42882007)(6486002)(64126003)(229853002)(47776003)(53546011)(65826007)(58126008)(386003)(50466002)(93886005)(956004)(6116002)(3846002)(2616005)(5660300001)(16526019)(186003)(81156014)(67846002)(110136005)(478600001)(486006)(16576012)(59450400001)(72206003)(25786009)(8936002)(68736007)(2486003)(316002)(23676004)(81166006)(52116002)(52146003)(8676002)(5009440100003)(2870700001)(2906002)(36756003)(446003)(77096007)(26005)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4928;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA3TUI0OTI4OzIzOnFvVkxuOEk4NElzMjJIcjZQTGNqZW1jSmVn?=
 =?utf-8?B?WmhJREd4R2VIaDlCWnF1ZExCVVB5MGRBOHZ3V3h1alhjNTEyckdCOVlLMXla?=
 =?utf-8?B?ejI4aE1IQTRTdm9TZEl2czh5Qjc3a3BHQmd1Qk4wNFp4UEJsa3hJWkNPRFky?=
 =?utf-8?B?RkdRSEx5WG5qMm82cWtjak1MOUpXUnlmbmdTNVdzbnIzUmNUbHlVT1VaaFBT?=
 =?utf-8?B?SE5xcGVERXFTdjBJOFNDWWxxeks3UlNuN3RMQjVEcjdKSFgwZFIvMjVZNDh5?=
 =?utf-8?B?Y1EwQjk1M0JqYjU2NXlQN2xFaGIwdDVXbU90TlpSK2hXRzBvWk1tYjU3QUN3?=
 =?utf-8?B?QkRtKzA1M2V6R1FiMFVOTFMzRDVOUWtRZlpjRDJpUHdqZmxoYStPeGo3bGM1?=
 =?utf-8?B?Y0FSMGJGZ2V0cVdnaEt4eWJzMUdCOXM2dHhTQmN4ckFnbjBJei80WUVpd2tm?=
 =?utf-8?B?aFNGenk1cTVuMjMvSFlWTHo0SytoNktxeE1lSEEwaWh4aCtjR0V5VzY5SVlZ?=
 =?utf-8?B?VEYyb1l3M1NiZzhZcU5LTkRQZjF6Mnd0bmlqV0srTGF3OVhTY0h4dE16c20y?=
 =?utf-8?B?dmxmUnAyQ044WmFqVy8vNDNON3pOS2pGb0NpTjRCcXg3SDdOVnlmdVpVaHpw?=
 =?utf-8?B?TktLWThkMFdBZ2FaOTJOQXo2R2lXN2dISG5QSHlWNlhTY2ZNcEZwaS94WjF0?=
 =?utf-8?B?TzBvRTdjamp5UUxQNjRFY20rcWkxa3MyckF5akJra2JnMTFFUXhYcTQvem12?=
 =?utf-8?B?S0dMSHI2d05UbUpnTnZKWkRrQjVkYm5qaDhqNVBFNk5UdWNMZ3RGWjQ3TEpK?=
 =?utf-8?B?NW5RWHhrZFZSSFZuYU02U1ZrYjAwdWFNM0lIWi9SQ0pWWjNrVVloSGw0TEtO?=
 =?utf-8?B?OVF5ZnB1c0p6cFFBV3FVL0RHak82a29od0NiaFRZb3VHbzRQMmFDS2VHWWhF?=
 =?utf-8?B?SmJ0YzMvbklyNGxDa3VuYjRQbkRNVUMyU1RweDVQS3VreTBMTVFBT0VwbDNE?=
 =?utf-8?B?NG1iRnpoNmU0NHFmdzhFVDVrQi93UXAwTWVyMitScWdNYldCSkFTYjFIWG9h?=
 =?utf-8?B?RnA0MENWZ0IxUUkvTkZteXU2eFNFajltbXB1czB6a1V3Tjh6WWxGakhOQXFr?=
 =?utf-8?B?SmsrT0xvZnVkOXREWlE4OXJzWU9nRkJGN1lOSWQyN1VEbUJJakplTEQyYUh1?=
 =?utf-8?B?SEI1S2pPZXo1R09Iblk4alRKcE9HTGp3RVYySjE5SDdiWlQ1N2xoOFQvVHhx?=
 =?utf-8?B?dUl5YXg2T1luUjZjZDNqZXEzWHpBd3lPU1d0SkpvTURNdG5FV1k5WFMxdXlH?=
 =?utf-8?B?YmpLTHVzZDU2NjBXVWltSXphVE53ZVZnZ2FyT0o3ZUdMQkp6clJ1a3h3NjJm?=
 =?utf-8?B?empvTVo0ejhkSVBud0QxRGx3WW5UTGFySkhOODhNZk1ueWlXUVJPOTBrN1U4?=
 =?utf-8?B?aUgvdmlzalJBa2Y1Zm5FeTJRK243MzdRN1A1T25mU2NYTmlONFdTQnpDTG1K?=
 =?utf-8?B?WWszS0w2RVFZZWFMSk9nRHgvRTZhcHpOb2ZwdzNySm43cVlSSm40Q0MvZU1q?=
 =?utf-8?B?VWFsRjg3ZkVrRWlIcGR2cXNrU0tGeERFS1lIM1FEaDZ5eHV3TjJmbElxZSts?=
 =?utf-8?B?RExjbXNHWEFRcUg1RzhKQzRCOGVub3F6T2M4V1haaENaL09ad1dzRlNWU2ZH?=
 =?utf-8?B?cFJGdysvT2JETWQrSHJjT2I4ME9NZ2MyTENRQm9Gb09lL0lqcjhmUlNSNGow?=
 =?utf-8?B?ejdidW5QbDJTalF5bkhmR3NqcWN2M05zVS9yUDBxNzJFWXcxc0lGU1RuUXNF?=
 =?utf-8?B?SFVzZ0dkVVFTbGI4MlNJTVU0cHQwZzhDaHVSU1JhVXB5RWh0TEtsalNKL0xZ?=
 =?utf-8?B?U2lDU1gxRVpTYWxQME1aRVBQellrejRsZWJxejdya0R4U3QvN3VCNlU0ZkRS?=
 =?utf-8?B?dmdJYlZhUHFQUER2YytqclJPWXdHb29RYjhjVURGUTdySGRrV3pjUUxaazdD?=
 =?utf-8?B?NFEyeVNnWW5GZWh2MUlJamJHaStkNjREV1hMdGc4QnptTU5jNkhvWm1ZV3dZ?=
 =?utf-8?B?ZDZvK1B1M1dPWnNQWlc5NXRlQUloNGxoVkZjQjA0dTVIRjhYQmtmY1dRdktT?=
 =?utf-8?B?Z2c9PQ==?=
X-Microsoft-Antispam-Message-Info: DbiV173BNjGJ41kVn51C8hxmIWVV2MTP1KkWClH76rnniT7by6mZFJUj3QCCHff/x6sz2nO8zmZK4uH3LaSxXvtfgUkVvN9YDBlHoSXRDYdTzQXyA4xZCOQC9rf6TcsX1/SiiNJoJD6gXX5QKdhit0egShdfQb7Z14GF/j53+2RoWns1PdYWPmuQDrHU6KJI
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4928;6:a290mJ9QvUPy/xfZ8uZZcvPRLV8PtJ0dOl2ZFDBrHKbyk8ley51C1E9KkBAz8RX4S/Q1pV10kLwOk+2xpowN8C95YI4piOgDpZbBrNItWfWIQ+XNqOIG7Bnsb4sQDwUFMHuN2h1fLExvSpJ5GZTts/e7a/7TB3feNT+wLnSEN00cjGW/FImg4CUtJFtgdY7kCWi/iURqIs1BHnNXqy+J0gn9qoPt+1chCnGk0L6PeZ7zjpgmfRrws5Dxpz7mLtOM70wys4w4qzfAKOST1FsQAC0MSN8le/alB6YNPJXPj4t1tPHI4Jq4eGmOmXh4WKh5UO/n+B8sq2uCgpOpx9qtsl7WjWViZottWos9d8fDQt14gFhFeNtBUSQ+z40b0p/vOjuS2xZUvOJbTDxrm64a8zhSoOmG4PmahQiIKno2e8fJPPGjPHq47tK8Tn0gJ32vj/uwok6tpYzaSNVQiavddA==;5:1mfq3b74LPlfTrg1YJHKI92T0sfokmvp3Sugy9E2mtvuH0ZBYLh6ZKXpnV8cKDmMV55zPhe+8JoNBtiDIQLm8vhoD7aZcAQ/Fte2PixtGjC6mkd7YrxMxXMiGN4kRzRGPJgksdCOAtI1/u78iZ/iBxP9yHPNL8KzVXIu4i5UFXg=;24:IiH8dnxFGzVOk9eTtkRFti4Q+BgNz0/YXbBUWeheMhVmYjI02uEUGF3nattgH9c/HYT9Qy+Ku1W0Vx+KsRNrgGNgf6nBIpzBMzqla1Ohenc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4928;7:eaQwdoTa5UdOba2F/KXgfziGePzvG6zPTxvwrwq/SSu5e3IlDZVDLEgN2Xjf32qIJVyREzaCSgxqfKNaev3A8APCn+wWpUUoUsHhv/V+qr3fnrf0APmoaiQhdi5usEyvdEQs+qQmc1jqzaRBC9Kv/rvEbBHjc+bxGe7OxI7VMwDHPXG4BbDVHkaknx16MtbuVV/Mpvu/ZUOvJesyccvHhM3ULh/mpqGIfF6Py/KLkO2g+50dRV6SdWLjqifihM/u
X-MS-Office365-Filtering-Correlation-Id: 3ec57a6f-9980-49b5-58f6-08d5c6c07728
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2018 06:33:45.4660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec57a6f-9980-49b5-58f6-08d5c6c07728
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4928
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Prashanth,
On 05/29/2018 09:14 PM, Prakash, Prashanth wrote:
> 
> On 5/28/2018 1:09 AM, George Cherian wrote:
>> Hi Prashanth,
>>
>> On 05/26/2018 02:30 AM, Prakash, Prashanth wrote:
>>>
>>> On 5/25/2018 12:27 AM, George Cherian wrote:
>>>> Hi Prashanth,
>>>>
>>>> On 05/25/2018 12:55 AM, Prakash, Prashanth wrote:
>>>>> Hi George,
>>>>>
>>>>> On 5/22/2018 5:42 AM, George Cherian wrote:
>>>>>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>>>>>> feedback via set of performance counters. To determine the actual
>>>>>> performance level delivered over time, OSPM may read a set of
>>>>>> performance counters from the Reference Performance Counter Register
>>>>>> and the Delivered Performance Counter Register.
>>>>>>
>>>>>> OSPM calculates the delivered performance over a given time period by
>>>>>> taking a beginning and ending snapshot of both the reference and
>>>>>> delivered performance counters, and calculating:
>>>>>>
>>>>>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>>>>>
>>>>>> Implement the above and hook this to the cpufreq->get method.
>>>>>>
>>>>>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>>>>>> ---
>>>>>>     drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 44 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>>>> index b15115a..a046915 100644
>>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>>> @@ -240,10 +240,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>>>         return ret;
>>>>>>     }
>>>>>>     +static int cppc_get_rate_from_fbctrs(struct cppc_perf_fb_ctrs fb_ctrs_t0,
>>>>>> +                     struct cppc_perf_fb_ctrs fb_ctrs_t1)
>>>>>> +{
>>>>>> +    u64 delta_reference, delta_delivered;
>>>>>> +    u64 reference_perf, ratio;
>>>>>> +
>>>>>> +    reference_perf = fb_ctrs_t0.reference_perf;
>>>>>> +    if (fb_ctrs_t1.reference > fb_ctrs_t0.reference)
>>>>>> +        delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
>>>>>> +    else /* Counters would have wrapped-around */
>>>>>> +        delta_reference  = ((u64)(~((u64)0)) - fb_ctrs_t0.reference) +
>>>>>> +                    fb_ctrs_t1.reference;
>>>>>> +
>>>>>> +    if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered)
>>>>>> +        delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
>>>>>> +    else /* Counters would have wrapped-around */
>>>>>> +        delta_delivered  = ((u64)(~((u64)0)) - fb_ctrs_t0.delivered) +
>>>>>> +                    fb_ctrs_t1.delivered;
>>>>> We need to check that the wraparound time is long enough to make sure that
>>>>> the counters cannot wrap around more than once. We can register a  get() api
>>>>> only after checking that wraparound time value is reasonably high.
>>>>>
>>>>> I am not aware of any platforms where wraparound time is soo short, but
>>>>> wouldn't hurt to check once during init.
>>>> By design the wraparound time is a 64 bit counter, for that matter even
>>>> all the feedback counters too are 64 bit counters. I don't see any
>>>> chance in which the counters can wraparound twice in back to back reads.
>>>> The only situation is in which system itself is running at a really high
>>>> frequency. Even in that case today's spec is not sufficient to support the same.
>>>
>>> The spec doesn't say these have to be 64bit registers.  The wraparound
>>> counter register is in spec to communicate the worst case(shortest)
>>> counter rollover time.
>>
>> Spec says these are 32 or 64 bit registers. Spec also defines counter
>> wraparound time in seconds. The minimum value possible is 1 as zero means the counters are never assumed to wrap around. Even in platforms with value set as 1 (1 sec) I dont really see a situation in which
>> the counter can wraparound twice if we are putting a delay of 2usec
>> between sampling.
> ok.
Thanks
>>
>>>
>>> As as mentioned before this is just a defensive check to make sure that
>>> the platform has not set it to some very low number (which is allowed
>>> by the spec).
>> It might be unnecessary to have a check like this.
>>>
>>>>
>>>>>> +
>>>>>> +    if (delta_reference)  /* Check to avoid divide-by zero */
>>>>>> +        ratio = (delta_delivered * 1000) / delta_reference;
>>>>> Why not just return the computed value here instead of *1000 and later /1000?
>>>>> return (ref_per * delta_del) / delta_ref;
>>>> Yes.
>>>>>> +    else
>>>>>> +        return -EINVAL;
>>>>> Instead of EINVAL, i think we should return current frequency.
>>>>>
>>>> Sorry, I didn't get you, How do you calculate the current frequency?
>>>> Did you mean reference performance?
>>> I mean the performance that OSPM/Linux had requested earlier.
>>> i.e the desired_perf
>> Okay, I will make necessary changes for this in v2.
>>
>>>>
>>>>> The counters can pause if CPUs are in idle state during our sampling interval, so
>>>>> If the counters did not progress, it is reasonable to assume the delivered perf was
>>>>> equal to desired perf.
>>>> No, that is wrong. Here the check is for reference performance delta.
>>>> This counter can never pause. In case of cpuidle only the delivered counters could pause. Delivered counters will pause only if the particular core enters power down mode, Otherwise we would be still clocking the core and we should be getting a delta across 2 sampling periods. In case if the reference counter is paused which by design is not correct then there is no point in returning reference performance numbers. That too is wrong. In case the low level FW is not updating the
>>>> counters properly then it should be evident till Linux, instead of returning a bogus frequency.
>>>
>>> Again you are describing how it works on a specific platform and not
>>> how it is described in spec. Section 8.4.7.1.3.1.1 of ACPI 6.2 states
>>> "The Reference Performance Counter Register counts at a fixed rate
>>> any time the processor is active."
>>>   > Implies the counters *may* pause in idle state -I can imagine an
>>> implementation where you can keep this counter running and
>>> account for it via delivered counter, but we cannot make any
>>> assumptions outside of what the spec describes.
>>>
>>>>>
>>>>> Even if platform wanted to limit, since the CPUs were asleep(idle) we could not have
>>>>> observed lower performance, so we will not throw off  any logic that could be driven
>>>>> using the returned value.
>>>>>> +
>>>>>> +    return (reference_perf * ratio) / 1000;
>>>>> This should be converted to KHz as cpufreq is not aware of CPPC abstract scale
>>>> In our platform all performance registers are implemented in KHz. Because of which we never had an issue with conversion. I am  not
>>>> aware whether ACPI mandates to use any particular unit. How is that
>>>> implemented in your platform? Just to avoid any extra conversion don't
>>>> you feel it is better to always report in KHz from firmware.
>>> Again think of spec not a specific platform :)
>>> - The CPPC spec works on abstract scale and cpufreq works in KHz.
>>> - The above computed value is in abstract scale
>>> - The abstarct scale may be in KHz on your platform, but we cannot assume the
>>> same about all the platforms
>> For now can I assume it to be in KHz only?
> 
> No, it will break platforms where abstract scale is not in KHz.
> 
>> I am not sure how to convert the abstract scale to Khz.
>> Can you please give me some pointers on the same?
> 
> Take a look at cppc_cpufreq_perf_to_khz and cppc_cpufreq_khz_to_perf
> in the same file (cppc_cpufreq.c). We use this in almost every function
> registered with core cpufreq.
> ||
>> In spec there is currently no interface which tells what is the abstract
>> scale!!
> 
> CPPC v3 adds some additional hooks for this. On CPPC v2, we try to use
> few DMI table entries to get the ratio between abstract scale and KHz.

Okay I will address these in v2.
> 
>>>>
>>>>>> +}
>>>>>> +
>>>>>> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>>>>>> +{
>>>>>> +    struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    return cppc_get_rate_from_fbctrs(fb_ctrs_t0, fb_ctrs_t1);
>>>>>> +}
>>>>> We need to make sure that we get a reasonably sample so make sure the reported
>>>>> performance is accurate.
>>>>> The counters can capture short transient throttling/limiting, so by sampling a really
>>>>> short duration of time we could return quite inaccurate measure of performance.
>>>>>
>>>> I would say it as a momentary thing only when the frequency is being ramped up/down.
>>> This exact behavior would depend on how different limiting functions are implemented.
>>> So this would vary from one platform to another.
>>>>
>>>>> We need to include some reasonable delay between the two calls. What is reasonable
>>>>> is debatable - so this can be few(2-10) microseconds defined as default. If the same value
>>>>> doesn't work for all the platforms, we might need to add a platform specific value.
>>>>>
>>>> cppc_get_perf_ctrs itself is a slow call, we have to format the CPC packet and ring a doorbell and then the response to be read from the shared registers. My initial implementation had a delay but in testing,
>>>> I found that it was unnecessary to have such a delay. Can you please
>>>> let me know whether it works without delay in your platform?
>>>>
>>>> Or else let me know whether udelay(10) is sufficient in between the
>>>> calls.
>>> Feedback counters need not be in PCC .
>>> 2us should be sufficient.
>> Yes I will add this to v2.
>>>>>> +
>>>>>>     static struct cpufreq_driver cppc_cpufreq_driver = {
>>>>>>         .flags = CPUFREQ_CONST_LOOPS,
>>>>>>         .verify = cppc_verify_policy,
>>>>>>         .target = cppc_cpufreq_set_target,
>>>>>> +    .get = cppc_cpufreq_get_rate,
>>>>>>         .init = cppc_cpufreq_cpu_init,
>>>>>>         .stop_cpu = cppc_cpufreq_stop_cpu,
>>>>>>         .name = "cppc_cpufreq",
>>>>>
>>>
> 
