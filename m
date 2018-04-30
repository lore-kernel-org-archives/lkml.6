Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754725AbeD3QKv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:10:51 -0400
Received: from mail-cys01nam02on0044.outbound.protection.outlook.com ([104.47.37.44]:25760
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754474AbeD3QKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:10:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: Oleg Nesterov <oleg@redhat.com>
Cc: christian.koenig@amd.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        David.Panariti@amd.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org
References: <87muxsbmkp.fsf@xmission.com>
 <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com> <877eowa5qh.fsf@xmission.com>
 <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> <874ljyu98e.fsf@xmission.com>
 <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
 <bceb1a1b-c453-782d-5a7d-40fa2f22c813@amd.com>
 <20180430160006.GB10583@redhat.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <e5b0221d-84ba-10ff-4a58-4fa27c99650f@amd.com>
Date: Mon, 30 Apr 2018 12:10:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180430160006.GB10583@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::17) To SN1PR12MB0319.namprd12.prod.outlook.com
 (2a01:111:e400:5145::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0319;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0319;3:tb877CZmYiwdQqkSJ/tuPb/gMDMTfDI787Rb4DBsC7jtwrN3PJr/YzSmWRhpTr0VifXI9LOzm5+kmQmxzXiPnjFOg5/kdIR7bK0FgSBBBY+eXfSZg3MKqWF0LIlUTwmCaJejrwhlFppuCq4hxuKZb7ik2sIjC4ofEAzvu2PHy1kSPZoNX6pJVPp+K5AH00npJssWtmM0PM7iCIar3DSPdW1TM4LqsUMGXy7C/J5lxnTL9c0JWymXlSloy5ZqR6Vw;25:CewdX6kIYbQXmlNl5ii3D7qtyzef3iiUAwPw0nKtUUxvaMAxn3uRKbLfDirck9wK9Oa2uIHESaiiMGOhx9KDMo6oNOKfsfvmsKEfaqrBaYvM+OxsbMtq264wivMRkmqoLOpy75U5InOlLLvxkZV5K71o/JaT6U8kRzQrtLY5bf5Zzgk4gqt321Ta/871TjXTtbU1t4XoZDecxkYMIc0TX8QJXcPdQASp7vp787jzCMyiDAFEKo2UX+3Rf1b9nNFjnwbIMTgVyvK/ItCTRAV1NjQbCbdG4/w14N7nimZbmxX8eGDGti3Ei8+0StU/xRDB1iQyUSNwsLUbS90B+wMbuA==;31:PPBwuN155fuFOccC2nJTjYYcxqTAWCQhhEnT/vRkn95PlFxXbrxmppOrQagHMSoI6mYOSVKZ3OB/0L/nGwXJFC7LS0ALIy3dRzTUZ+M7HPQ6+jfmd0tYYzRS2FxjkKzwbyLeku3xM9lIL6/1hT/ZYB101S+CouY0vfbxtZMXVoeUSJ7MjhIABPFCA8qE2TeJjyqCsnsW+mOSVU/sWOU1hWlwR0P4hFrGvX6z6eayBkg=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0319:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0319;20:xAkg4IbOrP+H9ITKGzDFnZBMAAKbsgvxXT5jw+UjgjWTTwDNRrTKWQr56m/J9FX0RroC9hN2aJUJ0rkY9KS8mX9lO9HCvn60PaCJjHoT7CvmxuYQg5khYHMFXLfLsxlIWHwalkG9erqXSzy43SsS3IPnMI6Pq6nyFP7HQ9kvHQRRV9djBeOhTgRMza/VUYzVdYktoHiZKS7VSut3pDqeIg8upuq1DwPr2dUAuQE2uje5QMMIJRr/KY8J3GJAfu0ojtzl9Rtbs6E4lSKgP2l+3CT02pPCaQbsgte8CQFBtWl75nBe2cNj4mXpeAMq1F9Se5pZDS0xNs3GAuTNGqtCZYnIqkR/gjZgM/VBCQRnMeg3Rbxpjer3/qVvW6ahL8PpRZyQIOVP8mB2ChmcGmc8lrg7NA6wDHPCLZJFsdsl006wR9yZhPkSqopXU5qVCinmPYT2iFK/EiwdtSA6jkkp16Mg7QNWiwNodvvgck7/URgTN8abR8T+hMyU4u17HXEd;4:y1Zn1Jlbi0c3eh+x4JoswABAN9nB8E8L7Fj2m5PwmRMwTliZ1Mb73mWD3Vm1iSnJR+jjYi1YNh3/yy8oQ1H5Y/9cPrqts4JEvYrCmoxTv4aG+sSDSPO80DNWv84Q4HG6MqFQf/48nWogVK/ynmLezkCmIdqpRIxL9zqL0AY60BGZ7mO358BQ+lAZZ1UZlbBxdygrHRj7HHIRRoxSblwDKZfiR92P/80RfgvWJ62t14YZutvVV+adYQw9AneJxPQaMXx0eK80r3K9PptIKcKdZA==
X-Microsoft-Antispam-PRVS: <SN1PR12MB0319C40BB7480D46F6C94332EA820@SN1PR12MB0319.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:SN1PR12MB0319;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0319;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(376002)(396003)(366004)(39380400002)(189003)(199004)(53546011)(31686004)(72206003)(58126008)(6246003)(93886005)(106356001)(478600001)(97736004)(105586002)(68736007)(53936002)(956004)(476003)(26005)(77096007)(316002)(16576012)(11346002)(2616005)(25786009)(186003)(64126003)(16526019)(81166006)(5660300001)(4326008)(8936002)(50466002)(65826007)(65806001)(36756003)(47776003)(65956001)(6666003)(66066001)(6116002)(3846002)(6486002)(81156014)(446003)(305945005)(7736002)(52146003)(52116002)(6916009)(67846002)(229853002)(76176011)(386003)(486006)(31696002)(2870700001)(59450400001)(2906002)(2486003)(86362001)(8676002)(23676004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0319;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMzE5OzIzOjRwb28xNjlSRjNKWERwWGpBWUh5c0RQOFNl?=
 =?utf-8?B?R2JCdWI0b3lneWRIT0JZRVBqNURFQXcralc0SG1QS2MrNjQ2Z1YxclpFYjJY?=
 =?utf-8?B?T1hVSlBqVUhWa0h5VkhHWGdLVm9kUVI5UDM5bWQyazFBV3VYaDdlMHlFSzRH?=
 =?utf-8?B?TW1jdUZkOWZjSmFpY2Y4ZU9jZWpvcTUrb0ROK3pwUE4xT21rVDhmYlg1elM5?=
 =?utf-8?B?TzFzR0RJMHkvS0VVN29neGtpOFFnNjRvYzhGY3lIVTdBZlh6QW03Rllpcm80?=
 =?utf-8?B?MG9oVFRCelc1Q3YxaDlpblJoaGptcEZqV3BiMU91TGkyNTZERUpIU1k4MU5k?=
 =?utf-8?B?Y2pVUnBwc2gvdTUrTm9FL2xzWlJpeU5ySlJLaU84TEloSmsyVlJ0eEwzS1Zz?=
 =?utf-8?B?YmJEbmtyTnEyWHl5K2JXVHZaYmI5Wkg2b3RQeVp6bkJmYzYvY2I5SWlObUlm?=
 =?utf-8?B?bWFFZm5GVGhpbnhXWDBvSFNqV3JTenUxdjBCMDNlRjJRd3Q3Q20ralA3RUZJ?=
 =?utf-8?B?TGRvQkpxVkRPc010RjV6TWthZ0lCUmsreFdvWDA4R0lmSXYwUHp4SXQyVGtU?=
 =?utf-8?B?TWNyZ1ZvY2tvNHlTZzI3aElzbGluYkJPdGppQm8vcFVQelRQTStVSmNMSjRL?=
 =?utf-8?B?TXJCUUwrV3pDWXc3bFBLNzRwZzNPV2Rkc2dIOVlha2NUK0IxQ2x6UXNFVGJW?=
 =?utf-8?B?dXI5c3JnV3BNdjBZZEY3SWVoQzV2WHIwUGtuaTlKbnJ5eXF4SVpXcW5JMlVG?=
 =?utf-8?B?Zk85czd3WFE3b1pXU01XNGlmbGJoYldOVmM2cGhadHQ3Z0hLbHV4UkNybXNC?=
 =?utf-8?B?ZXF3dHp5d2ZodEJMYVV5a2dIaGduZnQwWTRYSG5mNHNlWnRQQ0tMNk9mTHov?=
 =?utf-8?B?eG9HVS9XYiszUmRMZll3L08yYjhXay9uQnRRWkFLaENFbFZaTTZDLzYrRkhm?=
 =?utf-8?B?Unc2bXpMOUdldHVXSFc5ZTdZc29TbnlJM2dNTUZNRHlZY2V6aGlqS2JBeUZT?=
 =?utf-8?B?Z2RjNURYSkVOTW00UUgyMkJoT0U2VlVNbmp2NVBFQkNQaG9TZ2FIeVpha3RL?=
 =?utf-8?B?Vk05T0dBOVo0RU9Rb2ZDWkJCbmJnbEZSNjFXTHJxeEpRaW1abm1QTm5hUFZs?=
 =?utf-8?B?VExEdXBJUFZxUU5STDhvaVlFbFpsaVc2MXJxN0RKcmU3ckFOdVZ6UFl0Rlp2?=
 =?utf-8?B?WTFwMlhpRnFaZkhiMnFEd3BqVjBRTzRmOTY5ZVNkeFlwZDRRMWtWUXhSd1Rt?=
 =?utf-8?B?cGlpTit3b0FudkVTOENocnpNdkgvWnR1c1pQVWUxdFJVSTBDNVBZWVladVZD?=
 =?utf-8?B?KytsKzhPb2ZmOUUrYi9yRTFVc3VscGIwTnk0MlB3UlBtTkxBNWJ1bTZoNnkz?=
 =?utf-8?B?RS8wTWE0V284bkpwQ1piemJpdWVzeU9XSUNveDcyc0pWN0p3Q0NGZFM1MVkv?=
 =?utf-8?B?YlFkZTlFNXFxL0xZempxYXVvbE9IYklBTi9VQVZjRVY3eHFvM0NmRnZRT2tG?=
 =?utf-8?B?dTArZmNqMUNKQnYrWjI3MDJoaDhsVGJOeUNXUCt0QVVPNmttT0VjYTNFRXc0?=
 =?utf-8?B?b01ScjhObCtZZ05UQlZPY3FoclZpWkJxSFFTKzZKdnpDUUtoNTZZLzRWWjZw?=
 =?utf-8?B?RmNRbTVoVkVITjRURW5RQzJnWmJDMjdad3ZaMURDNU96SmV1VmFtdDlQRFpQ?=
 =?utf-8?B?UWpHK0ZCMENETThCN0Y1SytJbXE5a3Jib2ZMcVlOYndvTDhMMEFNZFJlK1Q2?=
 =?utf-8?B?cjlxMkk0WmwwTmplTDlQeExDai9hNStKQVlKVEVLbTU0OHRFbzRIVnpoUFVy?=
 =?utf-8?B?bDVOWThjN05PRjBTYkIzZXZ3ZWE5cm4rZUgvQmVIWFNFWHhBeHYvVHRxeVN1?=
 =?utf-8?B?KzhtVHJrWE1VTVRFOXpZbW1GbEFYaXZWNDNES0Q3eEVlZzIycyttck9oQ3hX?=
 =?utf-8?B?cVl0U0tVQTZONXJFV3Q4MGhBTEI3eWg3ZEhKTU1TTVRRUFEvaCtSc3FkRDJ3?=
 =?utf-8?B?NGFjYi9tN1NkT2NyRDh6dVBUSE11dUVXak9MMFRpK3ZsZldwanByM1VodUJq?=
 =?utf-8?Q?JYXk=3D?=
X-Microsoft-Antispam-Message-Info: 8fpjydNJhE97OCoPG/yhoNPo/47cNA76bDS81rAKAxf8TCGpWVc4mCDNaKURn+BtXiJmeaWFaKQGp3kyOGCx7upNJyyhSEDsAfx81upsAvRS3rpOrm4bklKmU/gqUTrcwMWais5Brkpv8xCALAF0HYmjxet9VTf+DiTM5A2p1+hbRTvJqWEZ5qDJYBrHh8RR
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0319;6:/VruG66BMmJLzBByVb4ISauCcCFi6/+lWJqVBqNN8JGJhI97Fqxjh1nxvdi8uG32t4aYVFvKSnK4S4Ze99p4l6W/YxWIJvEXnF60RvoVZzF5zeRwipnbJRhsloTozFAgLUT40BGKMO7GMrHD7C0oMYxz5pmaW+/K1sBHWYTQF1RTqTrCjbSRl1kNE7BgrB2rczum9S8MZLnQVx1AjwjVzBC93vwm0HPjUZzAzWrRM2m0EukFxU7Sw2MN51H53gDZhm20EWKnmdDDvAlvezYmi3dTuOWtwXrgG5OaJbvPLKqPsDIu05NvtJLQ4NuN0FnKVofmzkZdGryBlSjwvHhtPmbXMG4dij404aJiTV5Vf+6iKBHNmOfFdkUslCDo0QXmTWhNf2j6DEk2KnIrsnjH9eS+XwpRBu+RzG2uGnZdJBGtgS0dKFsCQFH+cuQBEI4ycAIlR4PJxD/5RR5b8OK2kw==;5:X7L32HifntCLkrRbEkHPj2bNwdFYZ4iC9Ityxn+e2ZfaWwBLVJ/ZzVEFLH0y+hr6BZFh2ihxKxlE6HM71KSIQhwbn9u4rL3Tseq3ynWvrP1Wh/L/Y0YaVIf0G6VMkigPfJytBMi8y25JoYQIvzu+vARzXYfdvYskzNuSrhm2cE4=;24:+yebKeY7fLfYAl/guGs0uEPfY0v6Lnhi2jasBgrIrVayuT52i4vtbhrgH9I+Zg4sMewt/TZfkje068a7kC8FAAZcWopvrTK7Q34+eCsZuBE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0319;7:Vkagk2Y1TuTTzJq9oBYZr/TS2B/iTth03NUZPwRJtotAb6QMgZLAJevi9TquINhjcO0BXS2lBAmmUHO4bmb0q8pjBqbEVlqDzD2ezP9IudVfy4rClcyxtzDLacAyQU+rDwIH3sbl5hz0FXVO9TW80LAAmFAVk8DxTdlLolG0MeQhqFm499GvPOvWwpVVcJTAQGs6bcasUSXiaZlRRuTuw+jpNakyCkjsmgnW9amPVJYaS0qdwCpClBqRTYI9U8x4;20:XqF11L3Uj4X0DvdzHVD4X7eUeIxxd/qfZjiq+ReaADUhX3sGqZzkkuBD+jqEZXBHG0g/0A1ZwnFWluGFjjlsNvNlNWqtzkDCtGDvUIyoRRGajhAsHvCla3zmjj1GRTCiYXAh3n0ddKNvZAOMVDQdiXedI5vzqzOQyExKiC220FiiBK+vT8P2ZuKDOy4/lOajUIghi6qeZVekrB8A5uLuiexG1eISbJ9MtLKmTTIx7qkKf2ArgRfKh4TGjfbWGyUp
X-MS-Office365-Filtering-Correlation-Id: a28e10b5-e2c3-47ba-6be7-08d5aeb4edb0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 16:10:43.0245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a28e10b5-e2c3-47ba-6be7-08d5aeb4edb0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0319
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/30/2018 12:00 PM, Oleg Nesterov wrote:
> On 04/30, Andrey Grodzovsky wrote:
>> What about changing PF_SIGNALED to  PF_EXITING in
>> drm_sched_entity_do_release
>>
>> -       if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>> +      if ((current->flags & PF_EXITING) && current->exit_code == SIGKILL)
> let me repeat, please don't use task->exit_code. And in fact this check is racy
>
> But this doesn't matter. Say, we can trivially add SIGNAL_GROUP_KILLED_BY_SIGKILL,
> or do something else,


Can you explain where is the race and what is a possible alternative then ?

>   but I fail to understand what are you trying to do. Suppose
> that the check above is correct in that it is true iff the task is exiting and
> it was killed by SIGKILL. What about the "else" branch which does
>
> 	r = wait_event_killable(sched->job_scheduled, ...)
>
> ?
>
> Once again, fatal_signal_pending() (or even signal_pending()) is not well defined
> after the exiting task passes exit_signals().
>
> So wait_event_killable() can fail because fatal_signal_pending() is true; and this
> can happen even if it was not killed.
>
> Or it can block and SIGKILL won't be able to wake it up.
>
>> If SIGINT was sent then it's SIGINT,
> Yes, but see above. in this case fatal_signal_pending() will be likely true so
> wait_event_killable() will fail unless condition is already true.

My bad, I didn't show the full intended fix, it was just a snippet to 
address the differentiation between exiting
do to SIGKILL and any other exit, I also intended to change 
wait_event_killable to wait_event_timeout.

Andrey

>
> Oleg.
>
