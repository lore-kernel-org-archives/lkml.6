Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeDYNn6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:43:58 -0400
Received: from mail-by2nam03on0074.outbound.protection.outlook.com ([104.47.42.74]:35528
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753282AbeDYNny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:43:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David.Panariti@amd.com,
        oleg@redhat.com, ebiederm@xmission.com, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org, Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
 <20180424194418.GE25142@phenom.ffwll.local>
 <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
 <20180424214027.GG25142@phenom.ffwll.local>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <615cd01e-8c8e-910d-8f04-5576ab986ac0@amd.com>
Date: Wed, 25 Apr 2018 09:43:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180424214027.GG25142@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::14) To DM5PR1201MB0122.namprd12.prod.outlook.com
 (2603:10b6:4:55::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR1201MB0122;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0122;3:9I23kcxqW64scglutv8JHqympfqnwWivwj4uKa/m1OwrRX+GSmsLgkPyXktkzH7dLPWH1YJfQ+AaVs2QReIi2lt+GQaTKRafTQnXlCT9j3xVC2vCIpFfvXyKlAw415O/UP+ATMd5OlfrBp0Ew4TT18kXYEHwJ9uGWU3df3XIswk8uWtX74QETa0DfYyXHoArVCYxDqC5XFLY5Fe5/aiEBJ99wq359sHgfB6a0IA5npo/YLEEJgZSiHzSiuvNaiGi;25:o9n7wpIZFdj1RnpaTk9hZVaaOtK6hRRHKkX41s3ZKL6xRetFhnK/Mn926nErnOqEj+ERn+xtWHXFVXB8++gXs78sIIPJcPpsCgLHSr/zWzBkZctLOnBoms0LhEE0b8Y4l8dsnKtX2lZhAI20VRZsni9mZTmvlcA5ujtR2Ql1PF5W2rLCDUFfKO6RnKtd/UyDNE3LQNyPyac/dZgjQ//9z7BSM6+Wa5TM5nwjaANpaJmTsPb3bUf+bVQnBHFaedWYlAOsKtbPLuLBJ2HLb7opCWxnGb16XtbKsE+7E8/ikP2B6mWooQ2f7UWEl8yMGbqI5mHb2PfBoL+S68iIcFUVqw==;31:nSgcT1UCnITkIkOBzs4oLCKJFOXu/7uV+VOwqPk8Ce1eeilo2R3kWUwgZJnrtf2IQPHF4GzX0EeGjybM+ZLRtoJpj7SLN+7QbBA63XYwxTTSG4fZOcz4hCNoyhmENzLkssOeAfyQaTQMrudzN7+PFWK7NisE+O/vNnGGvPe2e1cM4TYWvnd1ZKVcdLgTC+TuCIAHGbYgxKQiW4vAwykY3rWxXl8oqD5QbMTb9sqVZo8=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0122:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0122;20:VG/hdhE3vTfwR1NODy2wUCPXIegqNPl5oCAA4sKdrf0y2dj75SM3wQQnfF/FDkRs9CspZoBTtRGB6Mrrrw/PYbgCjbJ8m8vTJXGELrFxtIgWzWco2URdApgwPu8yCXibSF86Ozzr8aOwM7V6LJRIfbty3GzDXYfzExfKKde4SMz2p53cxQEEc6hfwZIw9m6KNP2WOrfNNgsC3M3lNeH4I9VEtQY4+T6s1MuulhfkhKRz15Ia5y0/nVotFY4PFwnx/hdrw1arsX1dEkKAhWEsu9CZOoFn/WiEMf7Zk/qHSJcP7lZxme9CjzQergI892CSzfFqoYG+0i5bZMEO7l0TRLlUnimcDtc6qQkuUznPr9cZN/tRNI8j2ulLfx1UptNiwIpRgKe/wY6aabjTGkfIqi9Nqd62XUI1bRAoCj/78rGPsOgWrkBbqO/vnk0I/fB1eXc0MpW0YU+3QQ6gkHHgU9yq90SLT4rJm8yvUQeXRVKURNtgHmSEAWhQu1j40xaY;4:3iOhGWpwPDp5fp/D8Bst2q+VVpIx5uuq0ntcMaLzDynJHi/o6jX2ScL/Nsi68TfLkF33bBiBkiA88Ql/776imGSgzVTr1Dv0Du2ElaTiqtsqX6jtUsIjBYzhgITzBuvYxKn3pAvky+RHqpgQ0OcgyN6CbB7uTiAAptqgvT8vaTyCsC4I/hucigaq+ma+H8oC1On9ir08CwSaRA7v1qtcEgMN1xNm1M6abU7LfsnReA2f1RdEsAeO0/xbYAVQcq/WLa2ahIa3/B7Bsav0ioRxXpJrP9CO+yBD16e235ykOwrZlKSgsU9qsH0hJiAlVTXv/YMG08LUIL4lCPu+/Y0PFeRHWsQtGBWDrDILxSZsbkaf/8xKFjVGIVwvTJiaZxzn
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01222DAF6C6C31CF7A4EFFC6EA8F0@DM5PR1201MB0122.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(95223839027130)(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR1201MB0122;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB0122;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(377424004)(189003)(72206003)(31696002)(66066001)(16576012)(58126008)(956004)(76176011)(106356001)(11346002)(65826007)(966005)(478600001)(52116002)(316002)(59450400001)(68736007)(64126003)(97736004)(2486003)(16526019)(2616005)(67846002)(23676004)(2906002)(105586002)(77096007)(446003)(50466002)(5660300001)(65956001)(386003)(31686004)(476003)(25786009)(3846002)(53546011)(36756003)(8676002)(486006)(26005)(52146003)(6306002)(93886005)(53386004)(86362001)(229853002)(6666003)(6116002)(6636002)(81166006)(305945005)(65806001)(6486002)(6246003)(47776003)(2870700001)(7736002)(53936002)(8936002)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB0122;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjAxMjI7MjM6eU9WS1F4bGlJNWx5VlVsRTY1YW40L0VX?=
 =?utf-8?B?SnhPeFMzNm9USW5CUnpydzNMdnJ6bURjQ3BhYkNiTVB4WUVPbzhVUzRQOGpM?=
 =?utf-8?B?Lzh3a1NRalpiT2NtVHVyendCQ3NHMGR6K3BlQUhoL2pJOHUzUldobi9UVm5w?=
 =?utf-8?B?REZOK01DYXhZS01qQ3liTGRmVTlqekZ2TEtYNmZ1a0JSdjRzMkV1c3J0UjZ6?=
 =?utf-8?B?UHhHejZnTE5pUjUxenBWQmVsQUdnS2JFMWx6aVBKcWJnaGxRb3dQRWZKMzFX?=
 =?utf-8?B?bDU0YWNLRWpDblhsUmFUbWFOb21SY1g0ZzNBZG9ucG1qcFBxMGtOczhNOGNT?=
 =?utf-8?B?VVRQZzczR2xhdWZ3Wm5BdmxhdHdIeWEzS3lqWGFFRTVWSWJzcFdtYmlXT204?=
 =?utf-8?B?aWpEZ3RoWGtVeGZWbEQ3MTk2d1RtVTMzaVBnZk9XTjBrbkNUYTJDL3RnYWxZ?=
 =?utf-8?B?ZHFPbWliMFNOWk52djdCZndib0tRc3hpaWptTmVZeGFyN0pxeGRMemNXcmxt?=
 =?utf-8?B?c0ZLQ0RsU3djWFlEektFYmp3NEVySGt2TmJNSmFmcWZTb01VWnFmUHhPRDh2?=
 =?utf-8?B?aThmQ3JONWVZTForellWaUtTaVh4UXVwMnJsQXpaaTRGT0wvUDUyUFYvZ1hp?=
 =?utf-8?B?Q0hwSlVUYkF2VmpKRVRsWksxaWZab3dSKzh4L3E5cnBjek9KMVdKekZnckZU?=
 =?utf-8?B?TWhhYnl2SHIvSTlMTTdsVzhkaGRjaDdYRk43enBRaEQ2VHMxMU40d3lWdENi?=
 =?utf-8?B?SzhJa0l6WDgvRmVJbEoyZ0xRYkxWZHRSWG9Wbk5QYU5hRlZuT2hNRURqUXhy?=
 =?utf-8?B?aXNXVGVaWjc2S2wrNmc1Y0lEeXJtQ3VyR2FQLzlFa0s3ejNPWXMwN3IxQkxS?=
 =?utf-8?B?dnR5enVSRHB0ZHZMZVlNQlVwYVJDVzRJdm5qQ29VMk1qUVQwWVFpblY3eEhB?=
 =?utf-8?B?dC9YTklhbFZ5dGYwYXdZcEhaY2lzSFRaTUNzRHJvL2NxTEJVN0gvVUxBMkhC?=
 =?utf-8?B?c1lKRkhWdnVMY0w1czZCeVk0Q3p1QkR3TlhlOG80bVlzU1IvUU4vWW8rcG5S?=
 =?utf-8?B?dktMd1J3QkVuSTZxaFlaZ0FSd2prYmlnNTAxSHhEVFZBWkxCaXp0WGQ1YmVs?=
 =?utf-8?B?eFM3TWtLYkFjWE1xNk4zMzRjNmFQY2p6TXBtU0lmTGNrQzU4dVNpM2FpK29X?=
 =?utf-8?B?MHFLS0M3YzZMRGtMT0tTYWYwTXlqcmJycmw0VjNONkpxWGdZSFdZV0dKMmpz?=
 =?utf-8?B?RzZLTXFSd3hVRlpGeC9sNWdQZ3pQZzZTbHd0N3ZqckJVWXMwUjAxQjVPZ2Z5?=
 =?utf-8?B?c00rYTRLN1VJazE5T09QY0dndTZqQnJpeE9kZ2FOQlZneVBwQ0s0SEUxMitO?=
 =?utf-8?B?TVZxZkwwNTlabTNYOUJVV1JBaFRVeG1qeVc5M3l3bmZ6WUI4bUcxc09WOE5D?=
 =?utf-8?B?eWtpbEQza2NtWjNqS3RPQlB4L1pJWWFFODRnZVBIK0FxcGl5MDRZY0Y2bDl3?=
 =?utf-8?B?emF1UTMvNEw1azFMOHBMeXRSbDlsTnI5VVc0YzJCRmRFMldHTGljSmg0ZmdD?=
 =?utf-8?B?eDNpdVY0TXU0Z3JQK0NIZzF1a2dnUjVmVHpsTHNacmUxajhNN3k0R2Q3WTR5?=
 =?utf-8?B?b2NxWlc5L21DQ1c3SDgxcnhxcUtwVFNOanI0dUlpNmg5b2lrMTMxWUJrQ2Vx?=
 =?utf-8?B?K0JpNXE4djJRdzA5dzJuVkRzczlBdkVqTDlXNFhHaWhVbHhSRG04N0VmQ2Zl?=
 =?utf-8?B?OVl2TEtDNXBnV0JXdDhtNk52OUNHaTRKeENEZFNueWJ1czdLSWY2K0VYdzdZ?=
 =?utf-8?B?RmNiZmxtQXd6UkVuTEtTa3lKSzBIUzBEdXI4SXB2VFNDdWRVQWNKNXR4WmZP?=
 =?utf-8?B?ZHJ3RjVCUHE0b1dOaFVzZkxkVHkwblc0S1lNcDRtamJNRjRjZVJOWWIzd3F4?=
 =?utf-8?B?SHh3U1Z5eTRYb0VhWDdSbmt1RE1rdlFSMzBzUGhVUVhBMnZKTjY4bmx2YnNV?=
 =?utf-8?B?azlVVEN4VW1Oc3FYQkt2V3JEQlpCMEdKa1h0am4zNlJxNDhuMGRzN0NXeXZ5?=
 =?utf-8?B?b0xianBTa3dOVWhWZGVHQ2JGT0J4d1Q1RWhiVnFVOURoY2F3ZEVzTE5JL2ZK?=
 =?utf-8?Q?pBZo2O/RZzFGixxre8FSjlHuZmEalF7pO55cXmm0GfKQKL?=
X-Microsoft-Antispam-Message-Info: y7Cf1E3bSkGrWLpTjaicep5JVvtNbAskv+zkXCTbbzTHfIttBObRFDIzMdW5n4DM3Iu+eKcs/q6GJsF5z3tZilACniwYMKb8v9OiS6GfkTJc4LArWtuTmGSuQJ7QN02XHhsnyMudfBwcexB/NVs0Tzh5bl3IHWIEHXyUXR7XYvcjPL2XZHAeuXgCYqmE2kRF
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0122;6:HH1FXI9xYRxd66YApI/sMldVE3WafpIO8ITEfIQ+SYwY5opKyTs4KIu2v3PceBvK6GqdD4Q63STjinSReheZ8v3w4swwkzI8SuaxBHxr7xMkTwqxJjbNP25LCTA5xMSliCeaQ1etB5Qmwmt1M8ZGqLqaS0MMQx8nQhrAbFq9+w7Be9iSzKggIp+UBGmaW0cWIcFGT1mcw3qedLUCvGOw4kkod+JStRKuQwgKGn8O49YB75EIIPkwYum0SzFRxJrxsnj8Px/fqH5G/+dHEODPGrKezRliH/ctzbyABIYOkWtcLh9vcwV5u56mLeLl+ubg47FBDROzwEC4ntV2ppC1BCXsDC5VeCbV3zrI0ImsA2+UNCAwFdoaQ12rgexrukWR9a3sWquCKGSjtrKCSvaMRhxN6e9xvlKQv6p9F9kfBqpAztckCQUZTlxe31UKMcnDwQuR+AAcUP83ska3Qxn+JQ==;5:CU0riCsty2w8Ew0bWRHfnffFUOqOUIR6aOq1i/ARn3PFXGCk9bB4MwQF0eldLRRIBKaiP2fRORTR2JmU+zTsPfthwwJo6071sfwg4/PVqtMx/VjkN74i4qH8BFLo9IC92HaWJR5PfXcY+DKN5+iC/+lo0YxKSZADo6OA+GZC5vI=;24:i8tqmUvbVJT2TWzbjFkE8U6fBQ7qLu+hCfYmPGrF2CmEnNV345zAIR/o+yXVR09cM8dEf16xeI9270117VmG6E1609QC1Rv0GmeV6/58Fg4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0122;7:YoW3W0jebSHtqlxrM0tK3h1ZXZ4n0KJl+h2Cc5Ji7M3YyKfIS/R3ZNqDEIO/lSyYHjoKk8P0+QThyyvcMh2z637n5jPl5VpOz+NwhhWDco1kegYtaWd78VqAkrjGdJiuXS+RCnbTP4Fgy7osJ1RnyvzeO8KLd9+e6eAaCBMJNevSQMu9i17ydJdhKS6PRQGja6cK2WUxpgugcyLKQcHNsaqt3fxBHWTswC/ioK7Hp9hw+K9vJmIKcUB4wN1dtrnS;20:9MsNCJBu+RWUEkMpZTRTeCeNt0N2jBTBTkNeCWnj3GcXpmghsDFHi9eWp3f6mW6CviN6kr1wb/kuTjvGNUvxQRsKjLc66wBa6S/APwXKs3Yz09uMh2WR66Cm8yZHyl+CHKFYkwHVSw8l2MdjuKCS7PcSdK0yX91IWaZV6vhsNXAx59TJh4jAWgKJHKngcekwdTpwzQM3Yfxt8a1axEg6my8SU/Fbr9SMzXl51rqD7gxl5IPYao0NSI589d5TMval
X-MS-Office365-Filtering-Correlation-Id: 85afdbcf-4811-4f8b-86c4-08d5aab294f7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 13:43:51.6224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85afdbcf-4811-4f8b-86c4-08d5aab294f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0122
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 05:40 PM, Daniel Vetter wrote:
> On Tue, Apr 24, 2018 at 05:02:40PM -0400, Andrey Grodzovsky wrote:
>>
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
>> I rely on current->flags & PF_SIGNALED because this being set from within
>> get_signal,
>> meaning I am within signal processing  in which case I want to avoid any
>> signal based wait for that task,
>>  From what i see in the code, task_struct.pending.signal is being set for
>> other threads in same
>> group (zap_other_threads) or for other scenarios, those task are still able
>> to receive signals
>> so calling wait_event_killable there will not have problem.
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
>> not be interrupted if called like that. (Will give it a try just out of
>> curiosity anyway)
> wait_event_killabel doesn't check for fatal_signal_pending before calling
> schedule, so definitely has a nice race there.
>
> But if you're sure that you really need to check PF_SIGNALED, then I'm
> honestly not clear on what you're trying to pull off here. Your sparse
> explanation of what happens isn't enough, since I have no idea how you can
> get from get_signal() to the above wait_event_killable callsite.

Fatal signal will trigger process termination during which all FDs are 
released, including DRM's.

See here -

[<0>] drm_sched_entity_fini+0x10a/0x3a0 [gpu_sched]
[<0>] amdgpu_ctx_do_release+0x129/0x170 [amdgpu]
[<0>] amdgpu_ctx_mgr_fini+0xd5/0xe0 [amdgpu]
[<0>] amdgpu_driver_postclose_kms+0xcd/0x440 [amdgpu]
[<0>] drm_release+0x414/0x5b0 [drm]
[<0>] __fput+0x176/0x350
[<0>] task_work_run+0xa1/0xc0

(From Eric's explanation above is triggered by do_exit->exit_files)
...
[<0>] do_exit+0x48f/0x1280
[<0>] do_group_exit+0x89/0x140
[<0>] get_signal+0x375/0x8f0
[<0>] do_signal+0x79/0xaa0
[<0>] exit_to_usermode_loop+0x83/0xd0
[<0>] do_syscall_64+0x244/0x270
[<0>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Andrey

> -Daniel
>
>> Andrey
>>
>>> I think this should be fixed in core code, not papered over in some
>>> subsystem.
>>> -Daniel
>>>
>>>> -- 
>>>> Earthling Michel Dänzer               |               http://www.amd.com
>>>> Libre software enthusiast             |             Mesa and X developer
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
