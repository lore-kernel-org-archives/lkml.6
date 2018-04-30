Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeD3RSo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 13:18:44 -0400
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:37106
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751452AbeD3RSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 13:18:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: christian.koenig@amd.com, David.Panariti@amd.com,
        Oleg Nesterov <oleg@redhat.com>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com> <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> <874ljyu98e.fsf@xmission.com>
 <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
 <87k1so8xv8.fsf@xmission.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <6baaeedb-285e-00ed-fd6a-e020415ec777@amd.com>
Date: Mon, 30 Apr 2018 13:18:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <87k1so8xv8.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::24) To CY1PR12MB0310.namprd12.prod.outlook.com
 (2a01:111:e400:50f8::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0310;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0310;3:ZPXCCkQ6lQNDGG3D5oX76uC+/QggsBc0HDDgnKeJyPG3EA7Fu1kpZ0EvjiPmqsgIBaIPrQg9rNy0pOPQDUqywVdrWum/ASx3s3YacS2MdzTH8bUscBWGxbT/uxBERNodq7Z/AL4U/4JD56jBnh+YyYJD0vF0PJOuy/5h3ZIXqzsG4eDrYOZI29ZYmx70JIEcvIQJqyzumWANGwBRvMQlMDyVSL0agMfddXNmUbmJZSWnvO+IMs2cS++oBH/9bt2r;25:opogxPJtQs+z6dzVxnFE3F82hlshDWJDR5MYC7+Pu6m8LFkdC4IGcDBv5fka3CsD/jigQZaQ9FozR30XjZJjpIR5zVyjOEfkSXIgGXopgUrRTqxEI2IyYrneVgUegTjQXEPKRbbGMEsuLatG96dyYm0XS4UkIhPqT7cn8m6p4hpvB+fi97oY1ReLsVNivvmHNIoJxsHAH1AnvVN7FrTDX4cAw9yVok/I6z9WEp/cw4wZbytf2uV06P0dAqJCM0Pwel7/9bzNUaf4+zgggV4We8tO4AE1PMriCm+PpZgUCPJ4oIwA4/Qiet1OoIRtUApAnUsdNmsubw8o9H5uxVVR5A==;31:zzFZhg2IKZmpktTsK4FpovS2r1x4IMEoPzZnRFikSSlHKj24QlpcTBTIDlwpTtz0U4ObCsz0CoukHftOKxJuv+3vsycsOIzFZpe/AESDPrFCUZsXPTInH16YYeVY0KdsFoG2t4AmfX3dAfirit0FvNA9K65WyUfHv/cYmd1E0Jdx2GMGifMRyPbhHICEEyTGNZXckbdAgRl17SyUddkxddG4VI7pqdl8Zsoonn/RIAI=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0310:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0310;20:lveHvWYDjdzv7iEzbuqq6v18fvDSKDMoMB/P69B1c7TWqtKV9+lpx88AwSDQPJ17gN41qPyNQpID7dIBQa6J0iHT23tImtKln8+zNUl5ZKlEjdl/CiZGF5sjvvgwfeD/TAVWTQ+l/RVBoOhBAiUny9u4JeggMmcZpQOh6D65puPlKlI1TF123/sHdPgSXxk3wfwgpm1Q8qJpN6lbgeVpEPU5hQnKf0lCjJmKTsP2IQ7MQjs0FCOcWfAckZX+ZTiCYK/SQ0RjtkBHBxGkBpFuuPrc/bX+uz/r4u1lnjIM5kMwF+RuQT9HCl/JcDKcztKUx/xCuusOP0/fME796Bu0+YPSEqeB65WYFMuELCkswZN4WSnqkeMkpUQICzC/59qfM+W2Zbxks+H5m8vn5sNsH0IaquMZEcBirIWWLGDT5wkxQX3ALpUYxyC4GPXXpwqIpJwlChS9vVxjw0RL5gdH1CieSrYxiM0mjpOgbfMgE2ccbs0nJAH+KkEEUs4bnUZv;4:lYSdejPHlxWH7jlyBf36jBEHJJxptce9XhWXry2zEVBQiu5trtpYBzwXHh1oWopnjcWsyrRZfewIyuQdp6zstKc4OwsxN+8RUbyDDrix1KNeBFtOitwbjfnCtR7DoE56VI6GvEHmO6jTABvIO96PbpPl0Pi5GgX8dbSCKxoFmIqm8eILQesK7MTbOPyRSeBeG5CEtQlVWlbQgGV7Ys83uiXINMfhC9xlOERVtyuD0IBjAJ3hUEnfqkG71psAOxlcwz1un8KcEtDx1wGdwp5rjzHAzU1Xg/sxxFnLJoe5BW/Qy84ehygS+xuMeS95WGE8XLWNI8d+aKNlCnf/8AL2JQ==
X-Microsoft-Antispam-PRVS: <CY1PR12MB0310E76D2D4F0BB10E571C9CEA820@CY1PR12MB0310.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0310;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0310;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(39380400002)(396003)(346002)(39860400002)(199004)(189003)(6116002)(3846002)(446003)(72206003)(386003)(16526019)(186003)(478600001)(6486002)(77096007)(486006)(67846002)(7736002)(305945005)(64126003)(26005)(97736004)(110136005)(58126008)(93886005)(59450400001)(16576012)(53546011)(36756003)(50466002)(86362001)(316002)(229853002)(31696002)(23676004)(2906002)(31686004)(2870700001)(8676002)(53936002)(81156014)(81166006)(6666003)(11346002)(52116002)(47776003)(5660300001)(4326008)(6246003)(25786009)(39060400002)(52146003)(476003)(2486003)(8936002)(65806001)(66066001)(2616005)(956004)(106356001)(68736007)(76176011)(105586002)(65826007)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0310;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMzEwOzIzOnlQWmJpR25YendQbm14dkhBWThVU1NSL0N5?=
 =?utf-8?B?M3lQbzJlK2Q2b1lTOXcrcHZnRTdiazBLUlVLMnVwb3VSdmo4VHhjWVRYd01R?=
 =?utf-8?B?ZEtjeGpWbGk1Um9pOEFuQUNXTHF6Qy9uRll6TzRPdEJ5ZXQvUTlVMjdLRWNX?=
 =?utf-8?B?UExQVVRFcTF5dUs3WkFDWitsM2N3S0ZZOUQ3R1cyZW4vbE9VdjBiNXJJOWp6?=
 =?utf-8?B?VWpPdHNodTJ3Y0hjQ1NudkV4YUdLaGxMeXM1NVZDcG40ZCtJT1UxWENPTy9j?=
 =?utf-8?B?RFFINmpYaDJ0TUdmbTBHS3Z4dGw4L2Z5UnRtNEgxRzJBOEVhSllRSXZDTDU3?=
 =?utf-8?B?amxhMUxpVnBMK3hvaHpnK0NUbWpKbjRkNkVzNUpqOERraGpPKytYajhPZk9H?=
 =?utf-8?B?M1F5aGU3OXVmanQ2T2x0d3JkejBTcmxhckJud2o1NlRSSklCSHIwaWhJZ0pV?=
 =?utf-8?B?ZTlpeE9GbHVuMWdNckRCbEh5cTd6SUdEbEE1d1ZrUjN5K2JYYVpLKzRRUEZ1?=
 =?utf-8?B?T2dZQ0xqQWF1WlhTc0sxbHFCV0hva0haenIxMEYvbk4renl2enpsYkNhT0p1?=
 =?utf-8?B?RC9RWjlLMVVSNGduRFFQenhqMUdOdEI5RVdoeVFGOHlEZENNRnVuNGNoUGtQ?=
 =?utf-8?B?SXVJWDdUaTdnWGZWUFBrVlNlUWxGQXhXbWlNOUxwRnpaZE9mZ0V0RGZYTVll?=
 =?utf-8?B?M2RwcVlrWml3dE9BTE83WjRvcXhEWGVKbVhDeEhabVJrUFFWbHdZa0F0VGRv?=
 =?utf-8?B?d3dqK3ZGNDZINlJJZjdkbkU5MnlkblNRNGc1OWxES1ZSU0tiblJSSFNlaU9k?=
 =?utf-8?B?czQ5RXdrMzJ0OUtwN3lZc2RlekFZQUdEcGU4ZUNueFpxNGdLQTQxM3dPVFhl?=
 =?utf-8?B?QzNEc3ozOC9pSkxKSzVocURSY1l5bXI5TllPUEMzRmdBUXJqbnhDdHFDUUxp?=
 =?utf-8?B?MlJ5TDM4dFFveEE1V2x5QmJad3l1aytlajJON3RETjZaWW1yakFSaWptWXNp?=
 =?utf-8?B?bTVHZGJTeU04VUpuZThiKzR4dnlBUHI5TlJ3UnluMlFqV3pQSjBjSWg3dUpF?=
 =?utf-8?B?OGtlUzMzY2E1VlVJb0ptVUpRZUE3YW5Dd2EyUVZwNU5QN1RjMXVreS9hVlE4?=
 =?utf-8?B?TS9QL080OHJqSnpiMml3cFhIeWsvdmd2WU4ybjdJQ2FGTWJua3lPL2hKcUli?=
 =?utf-8?B?M1pBaGJiU0VsdEswR0c2Mkdpa2VCbTRBNFBxU0EwT1NuNzFvYkEzUVJyZ2t1?=
 =?utf-8?B?Z2gwbkVURmRwL0FtVVBJVFBRRUlYdENlV29NZTJEc2k3RnJMMkJQWFBtakF2?=
 =?utf-8?B?QmlrU1V5dzQyandJcnhYcmM0RnB2UWp6MTh3TWlQR0RJSWloQ1lqTUY3OWZs?=
 =?utf-8?B?TXl1a1d1YXg5VC9NSDZpSTVLUlVKNS9FeXFQM1pBK2lWdmMxUDh0bWJOWWdU?=
 =?utf-8?B?QXRiRVlJSXArdUp1L2Z4eFpqNjJSRGpTNE9MK0NjWFpHWHJGVUEvcXFDQjdI?=
 =?utf-8?B?US9obGM4SVlyMzNRMThQUCtmWmlMUW9uMFhuSVhYMElsZDhaM0loU2ZGMlFV?=
 =?utf-8?B?TGVUajFBM01lVXpWOE02bW1ZaXJXU2dMaUFlTzlFM0ZzQm5HYWtWcktBZU5w?=
 =?utf-8?B?VEtuSGlSNzlkSFhOdituMkd5cy9kcWhUYTFnMUsyUDNzSkFGWmNkM293SWRk?=
 =?utf-8?B?N3RXcThzM1N2VjlWNm1xNkpoaml0TUdhYndWWXpFWWRNMGhGWkNUWjlzWVRh?=
 =?utf-8?B?WmVKd3RFOTMrZVFpbXJJdlN6b1l5bmhFYnU0TllWbVZqd3Y5WE9aMFJwZXNR?=
 =?utf-8?B?YWZmRWp0S1pabFNmeXNmbit3S0RsZStkem16dGRQK0VmaHJkVWZjNllvTUVj?=
 =?utf-8?B?WmQ5bmRnTUlGQ0doTjc4WFV0Z25acy9VL0ZoQWhKRzZkOEFhYjM1bmZVdDNp?=
 =?utf-8?B?dXRyWU44N3pJd3hDV0xRaEJoMXZibFk2VU9uVlJaYlQ2VzRXUmorNUM1dEta?=
 =?utf-8?B?QkhCTVY5c0RRMUExVkZhNlVkZElLUXdBVU5IV0U4eTNGTEgvMk50WjFzL3No?=
 =?utf-8?Q?elXKJcJGoo3kcBVDaa/WyA6Dp?=
X-Microsoft-Antispam-Message-Info: I0GREbCV5fzNjKRX35iuO3nbwifv1COjKF2ZqdEun6GsWoWkZHIszhsNKmTc6oNMnUizFf4TclM9uovGsZ/7xsuTheEte2i06ytdvOADsuRccdw9EfERufTszZydlc4WmBBtplMSjOJN4Rjj1cw4vAtMAMLuznjPgs3fPWl7IQEU9O5xJNDKwYSxU/DS8srT
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0310;6:naUqwlY3KB5IhrV0qjrnV9H5OaWKJMIKsUEOqzG4wRdtTDArXExN6QjUicTb1HHa92rgMItdDu6PQ4DzMoseDI1i7aDmAernWNyMsuOft1JC+Yx0MSyh49XuRH1ZuWYyWG92qurysTRxLfV9O2zPFm9TdiQkOTduOBV/NJDZ3Ge5q62A4NlYHbMc70c7ttOUC8R1fjY4xbIhwL9eTdmM2d40koS4lAxRiMfzWgQAr+R+PICAELRPivRrayRMz0xY+2k9ArNtJoYi7epWGL12Qk1Wwc6leBzOTeCo7EdZVp279fiJ/EKMEvsyelhIcP6tB8wZLUwEjYlBux2O7wusaP7cUUZm1DdbvOP5cYfbdcdYLgRGyG6eLcqGl2W6xP6VARP1UMbH44vx1sHYFG8jgTWeKCs6hM2q/Z4+hX3z3HFAKZAGVD5MNnrgdNDHHgd94SbA5H7PC3qBaxFS0kYNzA==;5://h2+OQ7YBMle1EZuj5VNEoY6PjF9yPfyyGY+2sXintLzn9SOpXnENGXq5GolVlAZgINw8cSoECuaNRjVvnrhDKsljT4+Fjs7Hn3ubngihtOnFVCkUEEA24igX+7iwlfg/fa+UXwNEzUphz4YXHpR9BG4t/FzP/CCou61T79DYQ=;24:AhoSXz4WzF3FzhhqPXQiYjFDaPcMcTl0/uKr+4gb/cuMB5PNBDsdGXL+s21KqZs1kAeCrpqu1p+GMu8TwmjqXG+59yF7h5Ax54zZ94WvNuM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0310;7:0fd6fdsF/HCNJdTPc42ZRooMYcAUzaJmSvgy/XVWhYeSxbiiDJjSdo9q/D6XZnTLFgGAz6G7ULPqrmepyuJm+r8S+pJ8q2u7vausRSB3zkITxp+lL+p6RGfo961Uxfn6wgT4M+/PURPOobLMRBJ2cpV9yvqT/26DbND4dtUHtdA7CzaKzPvbldJnWh3vSZPFqR6k99RumlV7ZQlkb4TW868bRfXYplXROigmeby4t+v4aDTKMSYAlvbdAwUTanL7;20:2hHQldJkF9n3+oddME0PTDFwI2EY/s0wTVE+evmb70I84Nb8ktAKSPdkqhqwHVcLByQbDLTpomFYGhIZmx85ODqAQZZ76GA4Hs77jF03xnLepx/6Hh9CruGpHSS1RbWTqvLW0FGc4avqSp2U4EW950MbZ2XCqSx5TkL3m0dAfYFCqoG+WBUkGWgxXojAY5+cuK/MKWBZvZCztiATeIRgVEXqk+Hhkq6LX21CEp7wxuawZo4EHv9C9ogAHYsIJBVl
X-MS-Office365-Filtering-Correlation-Id: 8f8c8710-9b82-492f-36c1-08d5aebe6a43
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 17:18:38.1039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8c8710-9b82-492f-36c1-08d5aebe6a43
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0310
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/30/2018 12:25 PM, Eric W. Biederman wrote:
> Christian König <ckoenig.leichtzumerken@gmail.com> writes:
>
>> Hi Eric,
>>
>> sorry for the late response, was on vacation last week.
>>
>> Am 26.04.2018 um 02:01 schrieb Eric W. Biederman:
>>> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>>>
>>>> On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
>>>>> On 04/25, Andrey Grodzovsky wrote:
>>>>>> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
>>>>>> able to exit immediately
>>>>>> and not wait for GPU jobs completion when the reason for reaching this code
>>>>>> is because of KILL
>>>>>> signal to the user process who opened the device file.
>>>>> Can you hook f_op->flush method?
>> THANKS! That sounds like a really good idea to me and we haven't investigated
>> into that direction yet.
> For the backwards compatibility concerns you cite below the flush method
> seems a much better place to introduce the wait.  You at least really
> will be in a process context for that.  Still might be in exit but at
> least you will be legitimately be in a process.
>
>>>> But this one is called for each task releasing a reference to the the file, so
>>>> not sure I see how this solves the problem.
>>> The big question is why do you need to wait during the final closing a
>>> file?
>> As always it's because of historical reasons. Initially user space pushed
>> commands directly to a hardware queue and when a processes finished we didn't
>> need to wait for anything.
>>
>> Then the GPU scheduler was introduced which delayed pushing the jobs to the
>> hardware queue to a later point in time.
>>
>> This wait was then added to maintain backward compability and not break
>> userspace (but see below).
> That make sense.
>
>>> The wait can be terminated so the wait does not appear to be simply a
>>> matter of correctness.
>> Well when the process is killed we don't care about correctness any more, we
>> just want to get rid of it as quickly as possible (OOM situation etc...).
>>
>> But it is perfectly possible that a process submits some render commands and
>> then calls exit() or terminates because of a SIGTERM, SIGINT etc.. In this case
>> we need to wait here to make sure that all rendering is pushed to the hardware
>> because the scheduler might need resources/settings from the file
>> descriptor.
>>
>> For example if you just remove that wait you could close firefox and get garbage
>> on the screen for a millisecond because the remaining rendering commands where
>> not executed.
>>
>> So what we essentially need is to distinct between a SIGKILL (which means stop
>> processing as soon as possible) and any other reason because then we don't want
>> to annoy the user with garbage on the screen (even if it's just for a few
>> milliseconds).
> I see a couple of issues.
>
> - Running the code in release rather than in flush.
>
> Using flush will catch every close so it should be more backwards
> compatible.  f_op->flush always runs in process context so looking at
> current makes sense.
>
> - Distinguishing between death by SIGKILL and other process exit deaths.
>
> In f_op->flush the code can test "((tsk->flags & PF_EXITING) &&
> (tsk->code == SIGKILL))" to see if it was SIGKILL that terminated
> the process.

What about Oleg's note not to rely on tsk->code == SIGKILL (still not 
clear why ?)
and that this entire check is racy (against what ?) ? Or is it relevant 
to .release hook
only ?

Andrey

>
> - Dealing with stuck queues (where this patchset came in).
>
> For stuck queues you are going to need a timeout instead of the current
> indefinite wait after PF_EXITING is set.  From what you have described a
> few milliseconds should be enough.  If PF_EXITING is not set you can
> still just make the wait killable and skip the timeout if that will give
> a better backwards compatible user experience.
>
> What can't be done is try and catch SIGKILL after a process has called
> do_exit.  A dead process is a dead process.
>
> Eric
