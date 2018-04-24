Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbeDXVhT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:37:19 -0400
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:57060
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750826AbeDXVhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:37:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David.Panariti@amd.com,
        oleg@redhat.com, Alexander.Deucher@amd.com, akpm@linux-foundation.org,
        Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
 <20180424194418.GE25142@phenom.ffwll.local>
 <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com> <87tvs05mik.fsf@xmission.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <27d7d15b-f7c3-2a0a-af85-eb243526ac88@amd.com>
Date: Tue, 24 Apr 2018 17:37:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <87tvs05mik.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3ce0:41b::4]
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR1201MB0123.namprd12.prod.outlook.com
 (2603:10b6:4:55::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR1201MB0123;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0123;3:c2EYa9tUavL4Owcm1DjWqp5MbrK9seZDofnSpy9KHgXAq48yLbmPcsF8k2CJu1qORlTPKdJ4l71EN6qrjX//jCoKcWEtJLWAHPxrTSwg+Xnf4GUOYHJRW88Is3vACosRHSBrff5MALQaPX04kSupqI/yln7cUQjFBdJjj4OIHBMu3ONGvetqyUJfHa3UhwUNwqTKiAADxpSI6Ql/8ZVeH0vMl0i7ROs/nuQTDgaw49/mA51PZ1kdRzjycweVcrl7;25:hx5FgYqqXqKczMmiNFWVyA5rdWLki9YNWVnPqhVyVf8Dm2mpSxpa3+CNJA3Xjpzh74Gc+JsTXdYFSwuc4zO65+wEwfrpT5qWjBuUvKrF6W/bNMTD3XgAqzBjNBjYFX/is0NMP+OfXahXWRdvb878N76NysSc7IxszNd29I53WjPL7aeYVBIRUihKNk6tY5aDG+fcspYAb8dL7slX2XWXfJIjO2GOJj5fqcaRTtEoW81I4jua6fakuSUhWdJkFT+91J3CH83CkNl16sK1ORSUPrH7sjeCIdr93Av2wryUHAccv7HYtEraMjxaccqCk00JMtjPz0Q9IRVlRB52NykyUA==;31:ce91ZJKSmmtQPXuNxiOBePqKXB11OnhV/y9++1WEdDg1q85pTp4lkySgmD6ccSR+c7obL/yInGouBO+vv8VT5M8TMB4L4iCrCUJ/qy90AG77ce8Y7pqQf7Po1sUrDA7LmBR40Tx+naavLdmLBl8RJ5i03FIcWdGGUH2Yb6FqT7jBf1Y06tSawXjOrda3xS1IebrjwOOrJs6d1RpVIcseSZSOvxoox8gPkrVz74erDwE=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0123;20:rAFonzx0M9Lwaz0iyQ4iPGq0B2r4L9s1atu2McVXhb5ACE5bmK5hmwkeoqTGL6L2KPksdLoMufvoZr9VA7D9KI3kvm2Gr2jvKs/9j7E2T88LVhtUuMpY1oP6mFJ5yOSjELjA+f3Q9/u0n0AxeaDXlXq+rdiId463chQgZCCsfFftR7e1PNCc2ksMtsR5RNw4NFLyqIbrPSLCwmUxvnTpoWKYSXE4rQDtxeeW6JkiepjWCo1KYOd05RL3DkxV1Xg1DoMm7jrDFKiecvC4voyUnmpWev7NLiCSz53qQVMrBKLZVlI6QucG7XfPrT7yVHH1GI03jx7UTea5jKpS2HvTep4c2R52cJQfynjNkLmyDoDzkB/x5zJkHvLEgGcCgBrz8yHYB9nicqg3BOLvuq6rk+BB0XXInethZcWZhkPnAxMftHJ8NJQRqL7N18VFnahyY44Y5fMk50o9oxG+pOWiBa8TgN9JzThEQK6H7e4u0M1rSvin5LuMaUqOBJmm8+CB;4:uq/GAtMw3OjoAHMrafEXgdfWkXCZQPWpJ5arEBq9iTOHjIY1ghGntPXjdFtBmK2b6dLP3IzcrIo/Iw5IoFJyUp4sDVZBXadhh1i3a5QkGNKLE881z14Xhk+xi7//v6nPIzb712gLw3Es0XYiX+SVfys882bZ7UYFy6eb1ohT29qBdIyvIYsD44SWLv0bsauGrv5hy/N2B2szk+dryMZRupwf7fbHEfQn9sLxZpWux6RDHKAtbCqb1jFJ/vULlnEGaN76nrReMv10HsEPKdW4Xl4NPmRgvV6BLdgGoMVzOMHxD62KrAAT9Rq4d7+wkvxb
X-Microsoft-Antispam-PRVS: <DM5PR1201MB012393B3AB8FD5CD3503D31BEA880@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR1201MB0123;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB0123;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(377424004)(81166006)(105586002)(36756003)(16526019)(6916009)(6666003)(7736002)(6246003)(31696002)(305945005)(5660300001)(65826007)(4326008)(6306002)(52146003)(23676004)(53936002)(65956001)(52396003)(65806001)(76176011)(67846002)(52116002)(386003)(59450400001)(47776003)(106356001)(53546011)(316002)(46003)(58126008)(2486003)(478600001)(93886005)(966005)(446003)(72206003)(25786009)(31686004)(2616005)(476003)(11346002)(50466002)(64126003)(486006)(81156014)(8936002)(86362001)(68736007)(6116002)(6486002)(1706002)(2870700001)(2906002)(8676002)(97736004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB0123;H:[IPv6:2607:fea8:3ce0:41b::4];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjAxMjM7MjM6UHdqTk4rcStKNmhnVXBDNGVXR1ZmOGxm?=
 =?utf-8?B?OEFmSUwxbmo2TURnNDFpM1ViNzJxcWxyaHVnbnl4V2s0SStiOUhLUStvQlpm?=
 =?utf-8?B?UGJxUVJDZ0RpZEN1bmlnKzh5UCtoMVRxa1kwMDUrcE9HK01ISWhMODltOGFS?=
 =?utf-8?B?SmtqbER6a01VZmo3d0xTb25YUHRRbUVmMjY5aDlyajlOaFUwcGlKS0E4cjh4?=
 =?utf-8?B?Nk1SUVdXaVV4Z0hLT0dlUGtKdDYyYjNzSEVBbDFnNXAvTTZ6bGVSM0ZNbnRh?=
 =?utf-8?B?QVN3RXpGRzVmRVJJdDVVWHlLVGMreTZDSFpmd1NMVGJ5TjdhOVl6M1YrRkxV?=
 =?utf-8?B?L3JhOWN0bndVUGxqa01qb1RHQlZZcWtWSzA4RmlxZDNCUThWQnRJcmNKT2hq?=
 =?utf-8?B?b0JHVEpycG94MTdLaWRQNEpBVXl2Y3ljNmE5YjAwZy8vL0UxTjVvQm9STUhw?=
 =?utf-8?B?bXZ2ZVRXUEg2eUhoUERZSEFhZ3QyME40cTFnN1RRSXNGcmx6Nml1dmF0Mzk0?=
 =?utf-8?B?akdrMEpiTThhdGk0SXhhSmw1WHF4cTExQjNXK1I1Nm5zclhzc1BZYlp4ZWdr?=
 =?utf-8?B?RGljRmcrbCtRcWN0NFBHRElaQ0U1cWdPOGpUdTFvZ0ZTQkdTVnh6MDNRZlAy?=
 =?utf-8?B?Y1JDTHpubGwzb0Z5aVI4QStvK2xLUWp6VjZYMytLbnVpWmoyMzA0ZjZhQWJh?=
 =?utf-8?B?TnBrekVPeUNFK29vclI5QzI1dkkyd0MvbXFyVVJvSkNwTUNOTzZoYXlieG5v?=
 =?utf-8?B?bXNjd3M1NndzU1FwYTM0bnErZ1dOdUZ2TExtWUhQSlVvK3hjTEd0NTZ2M2dQ?=
 =?utf-8?B?dmhkTnU2T3E1cTd5cHBJV3lCSHpBY2c0M3llM255OXd2UlZ5REROZVprNlhC?=
 =?utf-8?B?SU1DVW84MzZwNW9Cd3FES1c5bHdscHBxcThBSFh3YUNhbXpYTzByRldycEpx?=
 =?utf-8?B?ek40QnFMV3JzbTZRSXV4UFBnc0JFREIxNlZZWFozZnpxeEZqTGtFQlNXdEdk?=
 =?utf-8?B?cUoya0dOU2p4NlN6bER4MlY3SzZSVElDaEk1V1V1ZG5iZmd4UXZJalBKdW03?=
 =?utf-8?B?d2hNdVpDQk5tbHRBbDBGc3hvMkhxRzFBOHFDNS9nQXgwNUY1ZnJKdGFub0VS?=
 =?utf-8?B?NEd2c0VvVnFzZkNXc3p3VnJLRGZxODZ6RXdpMmpRamNqNk5icEhrV2IwMG02?=
 =?utf-8?B?WHRRemtTemN6WTdwZHNyVnd4VWxrM21wTkNxY1BJeTVvMDZJMmM3azJjNlgr?=
 =?utf-8?B?RDJZL2xtM09wVkQ5UzQ1RVp3ZWNwUXNyTkRwcm1COWlZVGFlaWJFbEFOV2J2?=
 =?utf-8?B?MzdaVnh2MDZVR2tkMTRtSU9HMXNjVHNLcjB6WmhVV1RRc09KY2tabjRSc1Rv?=
 =?utf-8?B?RGp3YWl5aHZZT1NZRUlWbWtqbERBYUxscTVVMEwxN0F6WExYVC9ZWFVjQ2w1?=
 =?utf-8?B?TGJuT3RaN0wvYWhMMXNnUXQ0NldRTkFYUExGTm9HVUtDOE1VRFlYYU4yUFJX?=
 =?utf-8?B?SExQdVFQNTk1UkRBZlZNU2ZtMnh1cDN2ajEzbVVMUnRWUDlpQzk4dE9icnFk?=
 =?utf-8?B?bFE1N2hGOUdJbzZkdDBtSUtPbTA4RjJVdW5kWFFadjVwbmY5NjdTa3hmVDV5?=
 =?utf-8?B?Ui9Ka21YM2dYUTZZd1pxZ2l4dlVDNHJldkJYbjZJRVJ5WDlrL2JnaFEyVmZX?=
 =?utf-8?B?QTZDd1AwS0VRNm9aM3Q4QmtnZk1rL0ZjSXVuZ1JRR2VWVDMxNGhnSnpacndj?=
 =?utf-8?B?am1vV0k4M1NvWGpHMXJhUnNoOUtmczNENlVWcy9yYkdYYkZhS1JnblFYVHh2?=
 =?utf-8?B?cTY3ZmdVZFJwZWE0aGcvZHV6MWwvVGZtN01qQ21YKy9IOGZsWG42WVFoY05P?=
 =?utf-8?B?UlBNeXFHa01BYzhMSlF1Qkt6SzVoOW9yd09EYWlSOHY3SW5NdjZpbXowSzBz?=
 =?utf-8?B?U2EycmtrSlNnVjNwVkZlWS9CN3dsdW82emJHeUMrYUdOSWV0RXN4dlF5VnR5?=
 =?utf-8?B?UWFkWlhkbHJIQ0tKdjhBSkFrSnZMOW5XMkZ3dHZnPT0=?=
X-Microsoft-Antispam-Message-Info: yJYXaJYQnDSgy751zM38+BmyQnmr2/agOktJJKkQCVIUII/pMo655WkGc3qQZPZZfwVnaVT+HgBkE0cLXEvNsTitmST00tET3i8tuhGHInwaGmBspU3GmEAI9gQ3G2W4KsLDJuIHw3x4+/T3b1jOtuRg2/Ni9F4IMrMPTXLR8GPSMmUiie5FMXMZanPi/4er
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0123;6:yUv5edjhCMRVSV4bQ5W6CSsVPa+Gb1L6DCoCWVNBdcw+KJtHJdpOv6MQcnJFIbUVS9VOVhC5T7ZclFwfk5aHr11pSDI20mEDnOAdXusyyZDswSfWh7opbJWkOLy/ZvDORXRzFvEwFcocmty/K/V9i9OYmQwqng/GqViOoO4vdeZLygHTNUVAZ4OlkkJFng4rB5+BY3r/JhCw+0cIuDWZ//qmyfl7yGYuQPLP7J+kDG6ubhOt4uXbO+rc4+uBWRXKhfRKlNLOe2vjhhqzwbl7bHtQLL/3hU5ufXQ5ylVZ/3AKiDHcBk60pQsDzgdliMFVUamG4BlSnPKc0zNuTdTl7KoUkbQ0uO6CdKakhYf28GTJY0fhyqBzGw+ltTUc3UCnBuZYyqFyLJb55ofitYQk/n/jM4knozCJmsPEVQgOvy4vOYCO8gF+zLfYiT35kCTucxKTYLN4qVkZE46xWwGzGQ==;5:Rel2BGDpHR0hpWrnKkl5/bH4HtQf/CmXxxZs0AUfvezftqsE1C2SPEcDJz3LwtgaN7OOjf5DVJxDSouUOjJnrdYolNfDDGTJ15MHa24d7s5PLck9ckNyBgyYodp1djIXLiTwWeYoc63e+wmmLDmt+a+b0XBeJa5D3ItWvIZddvc=;24:DZ+pYNz3OL2UOYafGR/OnwFhIlD4MWskRVTNVWnA03m0jjnknCeglKzOhEHWJ1bXx3/jmJhZF6+r30jokD3vtM0v9mEC7D4yplgEIjjELJM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0123;7:r2NLxJ44jKT+is+29zzGXymj9YBtaqq0EpIk3BjY1hRpdqrmRPGqCyj8dZ4fN3Z9+1ktLfzZdkNFryenK3/3ui3BGz6LZsO6gv92jbUyy9eQ6KEZIamgLSPf6RqXSJffIFNjwQAwROUjJFtLKWZ1hyKQFX9HMMebSnr/RB090pM0XGEfkxWvRiZVE7RBaXWJnjqjT0Y4aNChrbiPBSU+7Ip2jl/Fm24F/8k8Oe68jppXwTEoCm4EwFdYGK61d0FM;20:vlS3QV5PYP/Npe4S7Ggqy+0TPUJLDdvjgXwS8hglEiHHtxM+MOMaR9Fm3Aq3ptaGE3cA1MwchPuNvHVUlxxAldTlwOl5hr3DQIjNsoMYbr0uL8xuxiMUgU0BQDP7bhMDC5Ylr8W95JHTHOtU/AVvRqRfafn1tV7Kaz3F1LnHDcaYAo013F9uGT6KJBFVYvY5QD9mWc9IA02IEx+dR4MqBkBHrO8eDuIbHyOuVig2i8l4XOTG+cFWk5ZZf6Da0ur7
X-MS-Office365-Filtering-Correlation-Id: c9c8afb7-b430-44ba-f7eb-08d5aa2b8b37
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 21:37:13.3184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c8afb7-b430-44ba-f7eb-08d5aa2b8b37
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 05:21 PM, Eric W. Biederman wrote:
> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>
>> On 04/24/2018 03:44 PM, Daniel Vetter wrote:
>>> On Tue, Apr 24, 2018 at 05:46:52PM +0200, Michel Dänzer wrote:
>>>> Adding the dri-devel list, since this is driver independent code.
>>>>
>>>>
>>>> On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
>>>>> Avoid calling wait_event_killable when you are possibly being called
>>>>> from get_signal routine since in that case you end up in a deadlock
>>>>> where you are alreay blocked in singla processing any trying to wait
>>>> Multiple typos here, "[...] already blocked in signal processing and [...]"?
>>>>
>>>>
>>>>> on a new signal.
>>>>>
>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>> index 088ff2b..09fd258 100644
>>>>> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>>>>>    		return;
>>>>>    	/**
>>>>>    	 * The client will not queue more IBs during this fini, consume existing
>>>>> -	 * queued IBs or discard them on SIGKILL
>>>>> +	 * queued IBs or discard them when in death signal state since
>>>>> +	 * wait_event_killable can't receive signals in that state.
>>>>>    	*/
>>>>> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>>>>> +	if (current->flags & PF_SIGNALED)
>>> You want fatal_signal_pending() here, instead of inventing your own broken
>>> version.
>> I rely on current->flags & PF_SIGNALED because this being set from
>> within get_signal,
> It doesn't mean that.  Unless you are called by do_coredump (you
> aren't).

Looking in latest code here
https://elixir.bootlin.com/linux/v4.17-rc2/source/kernel/signal.c#L2449
i see that current->flags |= PF_SIGNALED; is out side of
if (sig_kernel_coredump(signr)) {...} scope

Andrey

> The closing of files does not happen in do_coredump.
> Which means you are being called from do_exit.
> In fact you are being called after exit_files which closes
> the files.  The actual __fput processing happens in task_work_run.
>
>> meaning I am within signal processing  in which case I want to avoid
>> any signal based wait for that task,
>>  From what i see in the code, task_struct.pending.signal is being set
>> for other threads in same
>> group (zap_other_threads) or for other scenarios, those task are still
>> able to receive signals
>> so calling wait_event_killable there will not have problem.
> Excpet that you are geing called after from do_exit and after exit_files
> which is after exit_signal.  Which means that PF_EXITING has been set.
> Which implies that the kernel signal handling machinery has already
> started being torn down.
>
> Not as much as I would like to happen at that point as we are still
> left with some old CLONE_PTHREAD messes in the code that need to be
> cleaned up.
>
> Still given the fact you are task_work_run it is quite possible even
> release_task has been run on that task before the f_op->release method
> is called.  So you simply can not count on signals working.
>
> Which in practice leaves a timeout for ending your wait.  That code can
> legitimately be in a context that is neither interruptible nor killable.
>
>>>>>    		entity->fini_status = -ERESTARTSYS;
>>>>>    	else
>>>>>    		entity->fini_status = wait_event_killable(sched->job_scheduled,
>>> But really this smells like a bug in wait_event_killable, since
>>> wait_event_interruptible does not suffer from the same bug. It will return
>>> immediately when there's a signal pending.
>> Even when wait_event_interruptible is called as following -
>> ...->do_signal->get_signal->....->wait_event_interruptible ?
>> I haven't tried it but wait_event_interruptible is very much alike to
>> wait_event_killable so I would assume it will also
>> not be interrupted if called like that. (Will give it a try just out
>> of curiosity anyway)
> As PF_EXITING is set want_signal should fail and the signal state of the
> task should not be updatable by signals.
>
> Eric
>
>
