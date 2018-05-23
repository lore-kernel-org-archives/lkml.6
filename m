Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933487AbeEWPIU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:08:20 -0400
Received: from mail-by2nam03on0054.outbound.protection.outlook.com ([104.47.42.54]:28928
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933151AbeEWPIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:08:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: Oleg Nesterov <oleg@redhat.com>
Cc: christian.koenig@amd.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        David.Panariti@amd.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org
References: <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> <874ljyu98e.fsf@xmission.com>
 <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
 <bceb1a1b-c453-782d-5a7d-40fa2f22c813@amd.com>
 <20180430160006.GB10583@redhat.com>
 <e5b0221d-84ba-10ff-4a58-4fa27c99650f@amd.com>
 <20180501143524.GA13017@redhat.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <8b940816-69d1-eb7a-325d-c28ad11a1b4c@amd.com>
Date: Wed, 23 May 2018 11:08:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180501143524.GA13017@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::30) To CY4PR12MB1447.namprd12.prod.outlook.com
 (2603:10b6:910:f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1447;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1447;3:Wq2jkbHBeFxZxCobS6FVlQyhWYkOgcZfBMT7HqjV9v0dcm3GLEh/UqY4heev6dV8bvlJez0y13FvaZ9S2IKbxLaotimWSwDtMOEGhX8ZR/se6gO34wQgUYFqrfJKfsYJ9df/6Q8Zy2HI8rdiw1TW/3YuU4WjtHl3oYlFEwyHOE5DsugBMCdwn6hIn0jCfHF8OMBhd+cZ7hAeP4g8e1RoZRa9nMhy9izgaIbrFOwg2zuqI7BgbrgAPvdH2pJ6imjx;25:diZmmeXsLwGWmvjprXF1OfFn7hIVbYhr/fqO8vCQnqF0VyBlNJ/0T9iY7x/bjEGgMo3vm9UgUMdsNDRElE4J3yK1Mb8O/dXBzO9Nnr2KT+h+IH/hOgbqsa2n8H8KLHeG2e6a8X6i/rDkCoWCr1+2H48O+GrcqStxyuRb+p1V93YQ1L85MxMpCKS9TWqISACgmTBVntqieIMz4SLpvMsNt1SGk0sNHgd9MlDOWZIQvaWTea6ap6F5VSUim6aaFyRFwDa9R/6OPvyt2tCNW4zXe5z/t1WxyBxwbbyl1wIWfgyHdKpeU9DcBoXcYjTrcUKOmLd7Buh2R/zBdqJviFVmvg==;31:NNbMDlxEBYvnjHWRQQ0HlliONpcP7TVW5K0ukcfGazM5AqyqMjSIGb0HeIY8gYf3Vj6/YfqfkimTrmeoqpRAxzpNdGDFNs9Q8ro7utXyGRp7Fp80jga5uwPnYlQmZtPSTcbf83TIBYe3IaFumO4PqGgj3sFdJTplpc0mdv0fqUbZ0XFr+dYRRvgs7ylu+9Gzd5dkVnXwgxaAkRCGDeIqaY8IuBLAdTPE8yjwDq+ZCMc=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1447:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1447;20:wS7+UgQ5wwB0F6TxK8gDfqXCgpGSwU0sDs2U5pfuiBltGL99TSpDjzRCOF36axZamX5QCJjciU9J5lvsVr5zoPQD3A5MQDPy4Ue5rkCYlXmEZ+skraF5hDyhjZWg9wOtwtkVvETYii33/cNIlw5k+rCH2IjrC2wqPwKT5+akpGVnIrxlnWsHI0rvz3ut7qs+5/fHAa0CMbC85LQemi8Fzq6stxPiWzAh5S2An3AiGdOZ4/S/T0lsq8g3Fn7ysXpYKnLrZULYggyMC1EJ4xIfjZOnDHATIkv8aysqoeoaacK2gcprY6cH0aGNqvRyaaFeZ/JuEx+hlXW9nXb99YjMyywxKbm7RTmkjjwjUs2QHJVIDJFVhjRsm3ZPVB57yUy58CsQWj0CDP5tlhfqCq9s8u4otBMKdeu6RSlP+RxmlCKD6WSW5VNh/M2bqIbrEi41zwNY8V3eTgxhPKMbFsg/Rbbcjc0iGuYPQAhPqzHLseKZbwcTa0q9DetMNIpdFvl8;4:fafuRZsWhYhFw5oDQCcDGOfOeA7NvVkSUnCLAWYeJB7SJhj+UdbBAfRCGW1Jl5SOfp2g0lDCMMdg0fU4+ydgoiYPDqC+5GTYJf6JbZHaFn4rbBLzMJI9pRINoIpcyAwvW6AVlr8ZsTtX6mTf300EGbDJLTzdXppet6OiknFctKKSQkZIce/zaC8sne6eZBfiq162MFMp6HJuSJzlyYir00HN3KYmzQXhcTjInIJGC2tyoI5AL7bdJhUQ5aPTzwjTPSI9PkjgNrsfVsDmEi7DHg==
X-Microsoft-Antispam-PRVS: <CY4PR12MB14476ACBA85EA0AB83B078C0EA6B0@CY4PR12MB1447.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1447;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1447;
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(189003)(199004)(59450400001)(386003)(97736004)(7736002)(31686004)(229853002)(4326008)(76176011)(476003)(26005)(11346002)(68736007)(6486002)(186003)(67846002)(956004)(446003)(16576012)(2616005)(316002)(305945005)(77096007)(50466002)(36756003)(16526019)(66066001)(65956001)(31696002)(105586002)(52116002)(58126008)(65806001)(486006)(86362001)(53936002)(2906002)(2486003)(23676004)(53546011)(6916009)(64126003)(52146003)(81166006)(25786009)(3846002)(106356001)(6116002)(6246003)(81156014)(2870700001)(478600001)(93886005)(6666003)(72206003)(8936002)(47776003)(65826007)(8676002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1447;H:[172.27.224.177];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNDQ3OzIzOnFZcElhOEw3T3JPaGY4bWhValN5aUtPUjFj?=
 =?utf-8?B?RkZXNDR1aS92ZWdGZG95cXp2RUxYano0cDJFdldkWUpzTGxQZUV6UXVIbkww?=
 =?utf-8?B?azh6eTN4dUdYdXgxajlLYmlRTG1JeWtCUHJ3Vkc3c3QvNkdwZmxFWXRCTjVo?=
 =?utf-8?B?amRBV3ZwWDkycEluL2NLN1hRdndSTGFXQ0wrL1E1WHYwbXMzdDcwMDRDRTVO?=
 =?utf-8?B?Vkh4SktKWTNid2k4NllnYWx1VUx5S29IVTdmcXBQdzl2T0VNdFpGcldDTkth?=
 =?utf-8?B?UzkzajNESkk3RnRUWmRaN3V0djgzSnFqZGx6dDhGZGxUQ2hSVXVtQXRnMWNk?=
 =?utf-8?B?NnNOZFlaZkNUZFd3LzJMYWZSdHBpUVFsd2VJTitMRnJHRkNxSUJmYW4vNDRZ?=
 =?utf-8?B?UXY1WHArSzdPOGhLaGdLZE9OeFNUVWM4ZzhOV0VoUU9hdnQzR0wwUHg0UWVp?=
 =?utf-8?B?WWtBVUdQSC8vKytkTjFNeHFlbDl4Qk9SeDY1anZHNzhqa1ZXL05ZZzRzei8y?=
 =?utf-8?B?RWZzbGJkRkNyMUxUeWxDekRIbGptQkZJR052MUNFMHloaUZVYXlsZXpjb3pG?=
 =?utf-8?B?ZGVhbWMrQkI0RjcxTjQvUXFMR1NyTnM5c0Q3UHBIUUFzRGFNTUk2N2xoRGhQ?=
 =?utf-8?B?aFA1dXl2WjVRWE96K21SZFR3QUJ0SDBSczRkRGxVSHhWWU51Nzg1WXJEcUxL?=
 =?utf-8?B?V1J4Q3V3TTU3T1hEVm45REFtNXdxdlpCZFovUFROSWR6b3JPU3lnTDdjV3dy?=
 =?utf-8?B?T2tvZWM1OTlud0Q2WXBIUlhVWC9ZVDUyVTZmdXJrVkh2UlhjbE1UTWVtbmNT?=
 =?utf-8?B?RWRFNEMweXpycHJBM0VMUUJQWUlKNURYNnJETUcvalZEdFN4aEVnamxoZ2g5?=
 =?utf-8?B?Ky81M0FqRC9JUVhlWGpmTHpQUmpGV0EzQjZxMVp1SWRFR1NhNCtDZVBSUkRR?=
 =?utf-8?B?K3A2Z25TQUx2NFBMWmlYai9hTFZGNDF1MUhTNlErR0RPYkNraGtBVWt4cVpr?=
 =?utf-8?B?UjFmV01QaUJtV0cyZVo1V0pRb2lFNGpoRE1xUjZUMzdaTmVUTlAwZ0xKdmdC?=
 =?utf-8?B?N1VjeEk3L0JSWlBIQytsT2hiQnA3ck8vb2Q5UVc2ZXdHUzgySWw3UWt0YTE4?=
 =?utf-8?B?L3VHU0FEOVVxK1N0MGNLbEtlTkVaUHArdHhSVFZpdlVGVXc2Tk9PSlV0VlJv?=
 =?utf-8?B?UFRkNGJ6dWsyclNQN2JwaVRMY2o0RVV4RkJDcmJGOVZwdFhLTWxpZXhINjl3?=
 =?utf-8?B?U0xQUzVOQkRJZm5vMm5RYmVyRU9IYTQrUDJxYW9nN1NJaEVqNWhqRWd1K1Az?=
 =?utf-8?B?dGVrVDE1NXRJV0RueVNNNHlHRSswVno3N1I2UHdJQVZCRHc3SEMxNEs3b2cy?=
 =?utf-8?B?TTlxZjhsREpzeUR0SDhDL3ZTek9jbmtSa1VKMlA1U0Y3VXdycjJEZXhWWlJz?=
 =?utf-8?B?bTFxd0ZlVlBaYXo5WUFHc0NzT1kvYWF5bGlDb0FWTGhzTzhPZVNWM2FSckhk?=
 =?utf-8?B?bXE5Y2VwL1FuaUNseXdRaDYvd282WnBTRVl2UlVZcTJIeVhxaHpHTXQxWlFH?=
 =?utf-8?B?RUsvRFdadkcxTWFXaFFUM243TkhoSmVzeXFwVEVkeTB2QnVnWnpWMjcxOG52?=
 =?utf-8?B?ZC8vVzhvMDFDbWp0UXpjTEdyeWw4MVNEeEl4UUhpakVZUDdGY0JoUWx1bUZm?=
 =?utf-8?B?Q2xON0NPNDl5Zndhd2xoQ2R0Y2lpTDgxYkVORklBM0VZakZtWUNUd0JuUDVz?=
 =?utf-8?B?TnVCNDQ0YTJuSlJEQjhKYk5RVktkNDkyenl2RklLSGV1WDlaWDNFRllMWlo0?=
 =?utf-8?B?TFVNcFJvTDhaaTk1L1kzVG80bXcyRi9DMWhvTTFnZGtCeXl2dWhMdFZJbGJT?=
 =?utf-8?B?SEFDNWJiaUIrS1dhMWl3RUE5cXQ1b25NaTVnd1pzam9TT1NSclFOS3hhVXdh?=
 =?utf-8?B?WEh4RGNZZC9SWEhXL0ZGWUs2alhjdjM1SFZ4TmhlUExqREUzS1FuZE1TanJZ?=
 =?utf-8?B?MVorRGpiVWZDTlNxc3laQkQ5MlIyaHB1RHhQVW02dGYwL29vaGpDL3JMc2tr?=
 =?utf-8?Q?htMM=3D?=
X-Microsoft-Antispam-Message-Info: zpty+JKFRLlIInBA6So3XOX1WE8KQ4+7igMAkNin2A22iOWMG/fct4uv8nrBAxxSeram8442SUK+fK3RRfuF++vkvOTUx0qCDGcBCduVdGAV830E+Ko6snVjm7jzVu+GugMCSEMIdrhObrOxKvB0yzZV4okq9FxMTBVGoQpbGxQ+6TKHC7mAGJdakuOmrUYG
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1447;6:BHhZXhhbh7mAIzDqvrCmVKuG244HOMOQZBHBec3eNUy/SVc9Ar3TZG0diCxFQIohuD0JhQHmfCjLiWL5WU6Re/rCKB4RiyyiArUBmGaKnC1TzcbSPwmp2aYWtGrp9ukjXa1KEkanrKighninT58oU7UAeNS4Uh/p2k2m5B4BZO+pNHJDN9gHDk1bBYQjAKcyqeHArTJVEV/DZzmp2xLIUYmKYQyzIBjhDuHFJL79xq9p/UnfcJmbXDHdWAH6gSUDaRKDiZdAP/zxoTtONErXI6+j9QXQULKDqtm1vsVlOktKEC5NNJQzoFSvjXZJbeqE4qUUk0nnTsxLuFkXpM8+n3+i63fbIcQBGsLjCaNZL83MOMDVydlIBil8fNCjAng+OrOBFmLw3d1xG0RntCNcoRnK7IwnTRrsMEKgLihA7QwSiciwYYs1BzSNp0kqsMg9xVmebNdoZdBczfFo2zcqFg==;5:tEq6FCKAEy1jmFSHeHMmSLpsLkJYKeX5LqhDW5acHgM8cfZm3+jQ2ZWo8w9S8PIJHgdnVbm4kDCNVmwC3k9PpTFu27LMqLI1OspAbUwZIrUavY2kvUFI8bjG5vDhtIn/thawlVWuS3se8rxtikgkOknBsyXq/yk6ZceHbGVVrO0=;24:TFkk8j3bRsrMwAfJg6lpvHm6VoIIb0fB/tUKvauyGNXkeh3lllFndxyTDJeenB9GIWMWuc53wlqcU8ShuCWwNcKcQNhOZSDGcNR3iGho6o8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1447;7:fc6dEtdt+3Rak7yl7q5AKfvu2mxQW9AOFa1RdGp0vd9fki8csjaUDQiUfrFRaIt0OJ/BDxyc33Ug5uyMRChopsreavvBux1Z4zLyFxJpUJSgakfiBNB8ps9FGdRGbsLl34NMGIMnNBctYDLgOZaFbIhT2EECE+yOKLNVYgZ9lrE3uiDKim0nigkamLAmyUEZWVvfH7PZKInBgS2V22yypqLj65lXecaSZ8dncZY0Wlfj+8HpxoqKEL7ox9QO3c8N;20:ViN1lEmiRFCFKjTCyZnTndFTrpucC0utfk1ROb8PhX/w+/0ql6OPVXdBQb8z72ZI3U3KEsin12/bgFBV8IB3HI4GVOnLnfLAFAsLNYy8NiQJEESAGnGW0mTJWOptka77LYY2gtys7/b5SJKsemlF0w08VoPBcO7/gY/2IvaAfjwMo4Kue59pgff3FwSaq6HqTrtEP8NqcCvIgJwGVT7cc3/RoRCjLhjSz2ir/Pe3VHQTPFO3HaC5MPng0dN0t6lh
X-MS-Office365-Filtering-Correlation-Id: 557e68c8-4daa-49a1-ce1f-08d5c0bf020c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 15:08:13.0816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557e68c8-4daa-49a1-ce1f-08d5c0bf020c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1447
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/01/2018 10:35 AM, Oleg Nesterov wrote:
> On 04/30, Andrey Grodzovsky wrote:
>> On 04/30/2018 12:00 PM, Oleg Nesterov wrote:
>>> On 04/30, Andrey Grodzovsky wrote:
>>>> What about changing PF_SIGNALED to  PF_EXITING in
>>>> drm_sched_entity_do_release
>>>>
>>>> -       if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>>>> +      if ((current->flags & PF_EXITING) && current->exit_code == SIGKILL)
>>> let me repeat, please don't use task->exit_code. And in fact this check is racy
>>>
>>> But this doesn't matter. Say, we can trivially add SIGNAL_GROUP_KILLED_BY_SIGKILL,
>>> or do something else,
>> Can you explain where is the race and what is a possible alternative then ?
> Oh. I mentioned this race automatically, because I am pedant ;) Let me repeat
> that this doesn't really matter, and let me remind that the caller of fop->release
> can be completely unrelated process, say $cat /proc/pid/fdinfo. And in any case
> ->exit_code should not be used outside of ptrace/exit paths.
>
> OK, the race. Consider a process P with a main thread M and a sub-thread T.
>
> T does pthread_exit(), enters do_exit() and gets a preemption before exit_files().
>
> The process is killed by SIGKILL. M calls do_group_exit(), do_exit() and passes
> exit_files(). However, it doesn't call close_files() because T has another reference.
>
> T resumes, calls close_files(), fput(), etc, and then exit_task_work(), so
> it can finally call ->release() with current->exit_code == 0 desptite the fact
> the process was killed.
>
> Again, again, this doesn't matter. We can distinguish killed-or-not, by SIGKILL-
> or-not. But I still do not think we actually need this. At least in ->release()
> paths, ->flush() may differ.

Hi Oleg, reworked the code to use .flush hook and eliminated 
wait_event_killable.
So in case of .flush is this OK to look at task->exit_code == SIGKILL to 
distinguish
exit by signal ?

Andrey

>
> Oleg.
>
