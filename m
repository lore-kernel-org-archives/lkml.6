Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753546AbeDYNIS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:08:18 -0400
Received: from mail-cys01nam02on0072.outbound.protection.outlook.com ([104.47.37.72]:17856
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752349AbeDYNIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:08:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: "Eric W. Biederman" <ebiederm@xmission.com>, David.Panariti@amd.com,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        oleg@redhat.com, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, akpm@linux-foundation.org,
        Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
 <20180424194418.GE25142@phenom.ffwll.local>
 <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com> <87tvs05mik.fsf@xmission.com>
 <27d7d15b-f7c3-2a0a-af85-eb243526ac88@amd.com>
 <20180425071444.GM25142@phenom.ffwll.local>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <94828a42-02dd-29ad-a3d0-dc4c0cc82ddb@amd.com>
Date: Wed, 25 Apr 2018 09:08:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180425071444.GM25142@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::27) To BN6PR1201MB0115.namprd12.prod.outlook.com
 (2603:10b6:405:55::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:BN6PR1201MB0115;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0115;3:Y+VYwAjTO2ZkWXfsQuvAczoyjFaHR9uQ9yTFyD5NztjQlSXU06bnGhvGCvUSugyBoOVohIF4OkR0lgphcG6J8pBjsl+sCuw+W/lICPXeryy0PndHhkJgkRX0EkE8YhpqxX8GkCjEf7vk/WgkwJ8izjNcoS0gyLT9WpJF3DsT6CXyG+voUETF+JjHHHwmJPKlZOkcbcI7q+xOj1H0vIa498vd/ikgYsKRCdbV20kdCvvHB+uO0gcyDC6p0JmNjB6Z;25:ohRuxF5XhEjDs0vftdP+G+h9DGawjVKOZaenbS0ogU1ZV8Qphm3TVeFcEObIrLExh6I8WsXECJc1Q+tFKQ8yGhX+9jj1inDhK07BkEbk/guf+UAbBWP0dW9fz0lngGteAQE8SlnkjZASjEnF8s+a3/nq8mbYLBq3gXIcUqiOGNqlE7KLWpgjpZ/Kec7VLIO6jairX1Cgp91br72Dcen/Ty/xWx/IVf2OwKkzPdz79sXBKIRIHnCf2I7vZo9Gqnmqek6GPlUxRkDu+AxFlozRFne9LU4WaG1sIrWKmbUIWM7x0JMAust9FgtwmtDsiSbqJe+46ouegLsPtLbhsZOWFQ==;31:MACxLjkwUQxICJ9zp1aFhDcrBR9qeS2BcD/zR/AeLKMEEHpqrdrDJhyJcXx8LtJYnwY5M3L0gOFEZDILX8f22V+4AizvLYUSfYDBxKRJBcbMvWGHeX3IZX6yUk+NAbaVuEG8zgjbf04ALydTy3fRfw+mIkjBx0YQGf4qAw/Q0PJhotXE/8Eezvm30RVF0c6Kq1wXxMauMW/cGlnrgFpE+CH02AfPjtFJAOv1ArDHvsg=
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0115:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0115;20:o7SyAHZuUKrh9ga9gT9lhPSVI39LUGBkEYq/fWiethyJfCz84KWXV3VeQCEQpovdzjmXM8eg2eRG6tz9k7v5r0J8bFKt/px7KuzKG8iUyP60n2Kjl6Uv7wB3gL5LhbTsW817IK9+i4krkKTC8HWNql8QRD+gNQObiv0UsdZQ8MRyYBy0pj0Y26u9U1bNYY8iXtBh5KqB8XRp2RyMwEvPaXLgVDeYoqnBOYEDoEJ7zFhIY03sGeirMxIGn6OlmpbLvFUVAGoxJEvFlEstnthyxuPzeZ5TBmtcrBtNiInCymaWTxWBDL2gK7Z8UqiP62LbHQoxXlPOJcBaPIj2rys6o9ZeBtVog1Z8FeXzTVCTr7OXha5/Gc4fehaEW4UjFqlJpf3zn/ICbKJRXj2yyMoZMCc93vlKvXfOaLnMVWz/ArEtN5giaRGTziLHs3qiskkervPV5VBs4Jgx6o1zdYSU2b0oNE9XjPZToH6sEdiubpbcn36bDWm8oEY2MLWQYRTi;4:LnBxVE0o0yJhAvIYnJN5Qf88OVGKBWDM/l42YWDsMW8j5JdtOYmqrE430voGyJosiWX1wzv4LnQ3tQOKNMfabQrH6f+ra7ojz1KfOro5TimhH+vZ/K8+sNf/tkuW54xNzOHwXOYazv8g9l4E3FYC3CU2gb14+malomaEFjWzR7ZcIBIv1g/Riu+LTbfbpIPedGz+OSM4pESJveUA6MGSzNa30u6fMhS7HKVgCjOgQjSVjJ00Fy5VCBS6i6mj4/6wChHhHEynCke+T03sjRmNg7CUGJv6Y3haMHfZ04c3/jDxOu9hp/gPwPebGmOutj8BrZxURepsVbL6hujuE7xWrQ==
X-Microsoft-Antispam-PRVS: <BN6PR1201MB011558BB7462ACE42EC7D55EEA8F0@BN6PR1201MB0115.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR1201MB0115;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1201MB0115;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(346002)(39380400002)(39860400002)(366004)(199004)(377424004)(189003)(97736004)(966005)(52116002)(476003)(8936002)(72206003)(478600001)(2486003)(305945005)(316002)(23676004)(7736002)(25786009)(52146003)(59450400001)(229853002)(65956001)(65806001)(93886005)(386003)(77096007)(16526019)(50466002)(53546011)(956004)(446003)(11346002)(2616005)(81166006)(8676002)(47776003)(81156014)(486006)(6486002)(5660300001)(16576012)(76176011)(66066001)(36756003)(58126008)(2870700001)(6306002)(65826007)(86362001)(31686004)(106356001)(105586002)(110136005)(2906002)(67846002)(26005)(6666003)(6116002)(64126003)(6246003)(53936002)(3846002)(31696002)(6636002)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1201MB0115;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyMDFNQjAxMTU7MjM6NjJKdjlIemkwUVg2QVA4T2x2a0lQWXNi?=
 =?utf-8?B?TXV2V1Q5OVVlY285WmtzSEc0WlppMVQramZ4ck9CR1czajJCWjlSVGpqMnUv?=
 =?utf-8?B?dXNvQnoxdElNR295bDhkOWtyeExCWnlvTWx3azNWazVUTHJQaUlpWG1BVkc4?=
 =?utf-8?B?VHczM3Nhb0Z5cGNVRjVVSmd2WjdhOU4ydVR5ckVVbTYvSW9xcENyUEdpZU5M?=
 =?utf-8?B?ZVY1ZWVLK2NQMUlEYWhYMWJ6U2VEc0JLc1lleXBPSXA1TVFuNGc3cHJrSTFs?=
 =?utf-8?B?ckNMbWRQSEVHQ0c1eWFxekNPYzNxQ0FlUE1hWU83cmVrTXpqUkszRlJzM3FM?=
 =?utf-8?B?N240cHl5bDJMN0c2ZmVSNFIvSHdzNXBJMFlabFFHWkI2UjBhMHR2MHhCU3hp?=
 =?utf-8?B?UWJRSFNsVThFZjZ2Q3BwemlXbEloelVjWGlmeVhzSGRMTjZlenJqNEtuVFdt?=
 =?utf-8?B?WWZYa3AyUHJoVmJaUzdIemNXMVBmVEZBY0NWckRkRHczZUNFTVZrUnNQME91?=
 =?utf-8?B?b2k5K0hqRXZpTzVvT3lsYmxUS1ptZk1zeGlqM3hTSnRoREJORWdrY1BpSXU1?=
 =?utf-8?B?bmZac0NUaWQwajBmQmlOOEpYNHcyUENwS0tteGpDT0hwcEd6Z3lSNGlOQ0sz?=
 =?utf-8?B?WEsyaDBzNHVjRE81TmhQa1F4Qm9HTVFJcDVlaXVSNDFQMGNJNGFsMTREYmo1?=
 =?utf-8?B?WkFnZnVKcEo4Q0RheEJyOThsS0w4Z0xqa0RKYTJIbnFSTGlhN0dZa0FQL09N?=
 =?utf-8?B?Y01MT3pDLzEvQW5GczhEWHhGK2NnNm1SR040STVsRFk0RUJBc2l3aHVnK0g0?=
 =?utf-8?B?c0MvdGRYRVdLMUhlanpoYjlTOHJFOTk0dnM1WmFQNHFVNVhyeW1yT0RZbEdu?=
 =?utf-8?B?T2VmSUJ4NWZmeERoNjlNcnVuZGtPQUdTbkRZU2RNQm8wTDlPSk1zNlNYaXhu?=
 =?utf-8?B?VHV5b0JPaGpvTTRCRkJqSG84OE5sSjdLeFlXR2xKRURUZ2cxaU5yOUxqd3hT?=
 =?utf-8?B?NVpwaVp5SlQ0UDZRWmJBcHFmT05RNklXL1pNdGpScjNhY2krTUY3M0IrNy9N?=
 =?utf-8?B?ejU5OUFCMzFYWThSVVB4VGVxenNkNVF5UWRtY1J2OEptcDBUNW5saERqL3B6?=
 =?utf-8?B?YUNQdU5obE9UanA2TlBCRDZpc1o4ak85WS9TRzd2emNPWXVEV2RuZ2Mvbnlq?=
 =?utf-8?B?cXBDQkd3VHVlRzMvcytyZzM0cVJPU2g5VHlkY2xSdzQrcXNEeWxWMDlBN01k?=
 =?utf-8?B?eW9jSmQ0SDYzVmtCdmJTWTZhWmFxSERnd3pnRHNuMGc1WjQ5cFNKTy9Fbktu?=
 =?utf-8?B?N2g0ek9yWWVoSG94aEp2Ry8vOVlUSHhOS1NEM295VVczU3IrYlE2MHZPajh1?=
 =?utf-8?B?YXBQUVZNMTZPYjlhVVIwR0ZZalFxZ3djbHROK3pUbU5QakgwaTZvcWk4N0w4?=
 =?utf-8?B?eG42eU5LWS9oNXBoMFVoRG5iMWJwL1ErY1Zob2lTKzl2Mm1YN2RxNzhXK05F?=
 =?utf-8?B?MEpobkllR2VWNkNYUi9Rb1FnSDA3Q3FEM05Ha1VwcUJMVzdYckFsQnAyRllx?=
 =?utf-8?B?NFE3REtHamNiZEVMZ1RtQ09xTDBXNzY0OVVnVVlMOG5xeVZEWE0yUWZrNkRF?=
 =?utf-8?B?ZGUreXdRd0xsYngwMFVMbHV1TWhxNHhjRmtlTFlTdStGd0xrNDNQVy90S2Z1?=
 =?utf-8?B?QU9ONFdsTGZ5T2NLNUwrSFdCSmpZK2N6ZzNSZ2o3VVVyK1hiZjdFSnJxaXhk?=
 =?utf-8?B?MHZzY0RmcTg3MTNRUlNlb0ZqbTZpUXg1ZEN3SVAxNmpoL3VqUnZ1biszVzZt?=
 =?utf-8?B?c3JnSklUSXNEbjkvQlIvV01zU1pWTEx6ZWQ4dk5wamdjRDViODRkSjY3MTdi?=
 =?utf-8?B?WUxRQ3EvcHBGY2E5aEZ3Nk5odWl1ZWtaUnVIank0QWhBL3ZISmV0OFZPMURS?=
 =?utf-8?B?WWprbWV6Ym8ySG54MVZoK2lmTUplWVM4SUMyWUsvK0FFdTVkaksxUCtVamdS?=
 =?utf-8?B?Q1VZVmhXOGg4aFFLL0xFTUFrajBKM2hZQ1NRdXQ1M2tQMm51bnJmZW0rVCtm?=
 =?utf-8?B?ZDlRYUJYOStYekhPUnJuMzJvUzJMVlowY1lkRW10VXljS2ViT0R5cXBEbFd5?=
 =?utf-8?Q?J0B5uyEiG/YcKqf5LYlX6IHsuxPvugxuER23Sgm493/wLA?=
X-Microsoft-Antispam-Message-Info: Aua0nXdsIAPAjFd6zCDp5rM7mj9zj96K+eTZL1MTdNYw5xxt1VBCCHmAlUL6DmTacpzy4AMZZj4bS+7qOb7cmVYR3IYvT47W1OoxBUvVPsv2t4HOQ1pMZA6Tg3K7ofvECPh+m+Zr46SwBLWQ33Bwgh7GkMdyzSERp8fyGPaJzHeHEAFwSbZ21C0W9l77ot5F
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0115;6:yw1E8BiFkn2sNxePmMzwTLQYJaB9xB/NGdnxirP6n7LdSUqnbBFoiBhb+wveOGSWEMbGhOt3a6qZ8YOcZUvw6mvdNOAKT39YaPB+f5R4jgb/l2G44MM9lHFu3r/6UO01fCcxa5gdFtfxixY64pEFf0y0yje2Iu3bIJ9c+nkHejqjg/e/XoSxrIUF5Hr8Q9I0XHODvF94ZxXXX82E4sIwky+h/+6quFd7c9Aq6/iPRiNZcDPsrE7N/CmmA1dpwlYP1ZNmyVarJWvLrkL5unollC4MQrXhv1Zt1WEKmM4UimE8fWShwhNICN8FRwXISn8kluan5QLJ6MFk/wDYjEf2DKyUsj5ZhqSHta6DJpOsSx/S1O3/8W7T8CsN4WYEbVVZ/M+H64PPDjhrTJFCBWRUKtffY857zqYlGQcaG1lE0CNJffK3YQF40dCXgYGaOxax96qOIe52XXzsSMwtx9aN1A==;5:UjUSJV6rO8D6dQ4rMw3rGaxotbq553+0QZx4iSrZSSKG7FgscMM2zKXxJ5DT2aHRB5hvBAutgy+u5+TYNgHGPuG9/OnVpsQsoGuMn4CQK7Y4hzQgQT/ROEDp+aLPeq+Sfsu5/MlIsvmIaseHOAHTMhl9BaoGzU5juKeZL3YIdHA=;24:1CQ9eQsWU3BZokdhC8cjkSCunr9H8fz4KbEd1tOr2lbqNzasYvnGDsVqZ6fJgFVZPFIh9qQnKZPoAoH7uJLkr0/pmTqZMkWfacZxFHgyebg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0115;7:qKQNqA/N+RgJHMwtuwoTho2pQ7KXHAc+d5kW+iZiDhs78CqVElz9aT+VNvBuTCys0xkE1WCkbEm6wZipt5F2M32nzi5VJQHe7HhIPzigIByFUbrpc9nUpIy7ZJ10pAnaDsr9Ex9HI31UUS/UDoP619cFcc3nK/FwndD4m47QGZfrddWcNeQhqQKzkHE/wMgNW15p/LlW2CzDK2ZfBz3wzknYqvI6EvwQA6kP4wD5cDYKLDSbyXPfZBZhVJfX8XTN;20:WkxmrpayUK8fZN9F2N6OOsbGVIWBN4sy2S04pzht9Y6HRFnfqrCzO/TLWVffAw5BjfZ/VQa/sJUz+X4Z5tdziBLLb7Gj6n0o8OAVTUWdEeEJPG8mvFS6qAsEkqN5XSXAYOJvazLS41rhEyoxY7cQ/S6kaEd8CWcUFxwyobA+6Pu6YEAbmyJ0Avai/rVn8jFJKQoJudiHcI5QVNFgoGdkRQQVMYfV8pNXHe0SL3x7Pip4pdn0GkKNA8a9paXQ0qPd
X-MS-Office365-Filtering-Correlation-Id: 891900f6-a859-4a92-62f6-08d5aaad9a0b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 13:08:12.8451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 891900f6-a859-4a92-62f6-08d5aaad9a0b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0115
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 03:14 AM, Daniel Vetter wrote:
> On Tue, Apr 24, 2018 at 05:37:08PM -0400, Andrey Grodzovsky wrote:
>>
>> On 04/24/2018 05:21 PM, Eric W. Biederman wrote:
>>> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>>>
>>>> On 04/24/2018 03:44 PM, Daniel Vetter wrote:
>>>>> On Tue, Apr 24, 2018 at 05:46:52PM +0200, Michel Dänzer wrote:
>>>>>> Adding the dri-devel list, since this is driver independent code.
>>>>>>
>>>>>>
>>>>>> On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
>>>>>>> Avoid calling wait_event_killable when you are possibly being called
>>>>>>> from get_signal routine since in that case you end up in a deadlock
>>>>>>> where you are alreay blocked in singla processing any trying to wait
>>>>>> Multiple typos here, "[...] already blocked in signal processing and [...]"?
>>>>>>
>>>>>>
>>>>>>> on a new signal.
>>>>>>>
>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>>>>>>>     1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>>>> index 088ff2b..09fd258 100644
>>>>>>> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>>>> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>>>> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>>>>>>>     		return;
>>>>>>>     	/**
>>>>>>>     	 * The client will not queue more IBs during this fini, consume existing
>>>>>>> -	 * queued IBs or discard them on SIGKILL
>>>>>>> +	 * queued IBs or discard them when in death signal state since
>>>>>>> +	 * wait_event_killable can't receive signals in that state.
>>>>>>>     	*/
>>>>>>> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>>>>>>> +	if (current->flags & PF_SIGNALED)
>>>>> You want fatal_signal_pending() here, instead of inventing your own broken
>>>>> version.
>>>> I rely on current->flags & PF_SIGNALED because this being set from
>>>> within get_signal,
>>> It doesn't mean that.  Unless you are called by do_coredump (you
>>> aren't).
>> Looking in latest code here
>> https://elixir.bootlin.com/linux/v4.17-rc2/source/kernel/signal.c#L2449
>> i see that current->flags |= PF_SIGNALED; is out side of
>> if (sig_kernel_coredump(signr)) {...} scope
> Ok I read some more about this, and I guess you go through process exit
> and then eventually close. But I'm not sure.
>
> The code in drm_sched_entity_fini also looks strange: You unpark the
> scheduler thread before you remove all the IBs. At least from the comment
> that doesn't sound like what you want to do.

I think it should be safe for the dying scheduler entity since before 
that (in drm_sched_entity_do_release) we set it's runqueue to NULL
so no new jobs will be dequeued form it by the scheduler thread.

>
> But in general, PF_SIGNALED is really something deeply internal to the
> core (used for some book-keeping and accounting). The drm scheduler is the
> only thing looking at it, so smells like a layering violation. I suspect
> (but without knowing what you're actually trying to achive here can't be
> sure) you want to look at something else.
>
> E.g. PF_EXITING seems to be used in a lot more places to cancel stuff
> that's no longer relevant when a task exits, not PF_SIGNALED. There's the
> TIF_MEMDIE flag if you're hacking around issues with the oom-killer.
>
> This here on the other hand looks really fragile, and probably only does
> what you want to do by accident.
> -Daniel

Yes , that what Eric also said and in the V2 patches i will try  to 
change PF_EXITING

Another issue is changing wait_event_killable to wait_event_timeout 
where I need to understand
what TO value is acceptable for all the drivers using the scheduler, or 
maybe it should come as a property
of drm_sched_entity.

Andrey
>
>> Andrey
>>
>>> The closing of files does not happen in do_coredump.
>>> Which means you are being called from do_exit.
>>> In fact you are being called after exit_files which closes
>>> the files.  The actual __fput processing happens in task_work_run.
>>>
>>>> meaning I am within signal processing  in which case I want to avoid
>>>> any signal based wait for that task,
>>>>   From what i see in the code, task_struct.pending.signal is being set
>>>> for other threads in same
>>>> group (zap_other_threads) or for other scenarios, those task are still
>>>> able to receive signals
>>>> so calling wait_event_killable there will not have problem.
>>> Excpet that you are geing called after from do_exit and after exit_files
>>> which is after exit_signal.  Which means that PF_EXITING has been set.
>>> Which implies that the kernel signal handling machinery has already
>>> started being torn down.
>>>
>>> Not as much as I would like to happen at that point as we are still
>>> left with some old CLONE_PTHREAD messes in the code that need to be
>>> cleaned up.
>>>
>>> Still given the fact you are task_work_run it is quite possible even
>>> release_task has been run on that task before the f_op->release method
>>> is called.  So you simply can not count on signals working.
>>>
>>> Which in practice leaves a timeout for ending your wait.  That code can
>>> legitimately be in a context that is neither interruptible nor killable.
>>>
>>>>>>>     		entity->fini_status = -ERESTARTSYS;
>>>>>>>     	else
>>>>>>>     		entity->fini_status = wait_event_killable(sched->job_scheduled,
>>>>> But really this smells like a bug in wait_event_killable, since
>>>>> wait_event_interruptible does not suffer from the same bug. It will return
>>>>> immediately when there's a signal pending.
>>>> Even when wait_event_interruptible is called as following -
>>>> ...->do_signal->get_signal->....->wait_event_interruptible ?
>>>> I haven't tried it but wait_event_interruptible is very much alike to
>>>> wait_event_killable so I would assume it will also
>>>> not be interrupted if called like that. (Will give it a try just out
>>>> of curiosity anyway)
>>> As PF_EXITING is set want_signal should fail and the signal state of the
>>> task should not be updatable by signals.
>>>
>>> Eric
>>>
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
