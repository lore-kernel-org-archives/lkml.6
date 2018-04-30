Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbeD3OdC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:33:02 -0400
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:48032
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752355AbeD3OdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:33:00 -0400
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: christian.koenig@amd.com, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David.Panariti@amd.com, Oleg Nesterov <oleg@redhat.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alexander.Deucher@amd.com, akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com> <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> <874ljyu98e.fsf@xmission.com>
 <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <bceb1a1b-c453-782d-5a7d-40fa2f22c813@amd.com>
Date: Mon, 30 Apr 2018 10:32:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::19) To BY2PR12MB0308.namprd12.prod.outlook.com
 (2a01:111:e400:585c::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0308;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0308;3:3M9riRCHxzu/VLL7CTUb/8kR4kZG/MjXE9QptmDG/wPPWLsefHK3PlNav5cn22xOVg0gkTUj+8ezxOLFDM3N63bB1f5fB5xald6ydBSB+5IRe2ga7mEXrR6Hp1zUsx+R3yxxtP1y0YgkMlw+N1LmAyFtR0LrWbr8MfaJJjn/FyGEK4PKipDy4dq1hcGxea3nhEGIiM5KxIwj4MsAnEu7TwTMqGUcazw1OEMHdpT+KK08REETo9XpSvvSEtSeenCJ;25:kIdldxm6TiE1CVgLmJJalaCtQeeG5NDJKk5rq8ulYut87m0sBM90iFzX8uFmlCH6+HWOTJbLd37o+i+d5U0agwx9l3qQqW48QuVxkP42yw56etbP06blxk91Z14tWIoNnnxgjRiJOuEBwl5qOvxrsoK/iHmJbUOVq9ZbCn+vkTXLZB5LXTvS5g5y5Z7rqHrR+A+n1qk56OhlscDntZ4RDgW7nSq80Hm3PXgatF7mGc0kXotyTmi+S2Y9tj55WF3j6Td+07ViDjBrU4p3wQHcgzNko/n6++S+cGTMZ3oeGu+A31B8stvMn5E0iGtT2e2vWaxDoZgxbJYt7oEHUhatSA==;31:hA0ujpEfz80cgCh1bPdk9cj7vxDvOGXZrg+z+AhFQWioWRU0SBONb59Weoz5lXkzAdFOOkCJCQr/GF+eLoJ1ddFlEjqwT4ikPKgKR9sNzjGygnm6Hbh+qLYtEdn5eyQV8+zDrVJTrDud7mVLr+9j2NXMXXDg8tlTF2JC/vuMJABvi3Zjw0WICQFQCilA+z9Q9V064uE/7sOHV5Wr9Bm/irivH0rJs2uJyLEG/4oACFw=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0308:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0308;20:Bf6wp1+IbbQGeHJSCnvj7tgFfwtGaaDTU9EjkUtBAw6T1Wi3EZevTYg6Wdl4uKY/pcSF88oboaEemLDTrUG0Zgu/zvOYvfAMx4hT4dMFo2hR/httlHTJNBpK16iVRO4EBKkshtsGgQQuSbdlS2wpUhvYvnKBnAjr6hDrPdxirve5jTcZqcntM3xEUHlyZv7tRyeKtibITRPWzClh/o+4BFe3yCWvmI5LpemgBoPQ79U2pFvSdZTFkOF7NVcWex16tQOuvHwHr2GvyRdTOgV7o4c4k3+xPVM6TPj7X3ynAQmjAopfRPcQ+RUcqPqDnehGZCE3bK/ulB4L98rYIreaP0xVeoKTdhbP28IWN483FGpuBZl7sP79auItHZtYD09CjDRBUZzcKGlreuJM3CsIwfHAj7IgCbO3JMwjXCoFx93yRGJYLEagU3wt40+CkkHEF5Lm1yPTXHSz07X51Vdj12UZbKht+9yuHZnffaXa1mAFbT9psTSh+pHrPkYCNhbE;4:7sHehignpyLnoZpd58tfBQ6XrSgoalBJT7mk9kVmOS4u+2iLvO/ZlEX8sAVt9kAghY0BVpcL3Q9CducwBZ6gTB4AMs8O1zxxVNdyCOVchBZhnt/aYWnegUUTaa+69LGuMI0+Z1DuFB2L514LTq4dzmRk7oDVhtmTQIrFPQCkjB8iOJ38ZryDCEyN6ay1pgQqZRUIkqPQM6bfCCsC7L3hEkV80JVQLb6xsajZeBDMHj0/JCaRsd+AJkX3HkC9MFz4CKW4kMh9NLTYgDjWBEzNq3k9HS3i60632k9lDLuBaOz9+4dNMAaCqSIwUgZ+LqiVps+Ae6eqgBAUpE7q6V+nOA==
X-Microsoft-Antispam-PRVS: <BY2PR12MB03087955E2D7110890C17C23EA820@BY2PR12MB0308.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR12MB0308;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0308;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(189003)(199004)(52116002)(77096007)(93886005)(486006)(305945005)(97736004)(16526019)(106356001)(59450400001)(6486002)(52146003)(2486003)(11346002)(53546011)(47776003)(64126003)(386003)(31696002)(65956001)(23676004)(65806001)(476003)(25786009)(67846002)(2616005)(86362001)(6916009)(76176011)(68736007)(6666003)(4326008)(16576012)(53936002)(478600001)(81156014)(7736002)(105586002)(6116002)(50466002)(6246003)(316002)(2906002)(58126008)(66066001)(186003)(36756003)(6306002)(956004)(229853002)(65826007)(31686004)(8936002)(966005)(81166006)(2870700001)(5660300001)(8676002)(26005)(446003)(3846002)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0308;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwMzA4OzIzOkVvVnhuSHZGbVFKa0lYQ1ZUaFpoWWlEaFMz?=
 =?utf-8?B?alFXT0JBeXFKa2ZtMmRUQ1FPQ25CQUQ3YjNHOHNTcUk2empjbmNCK0s2Mk1k?=
 =?utf-8?B?MVBxUU85ZlJWaXNYRnBNc3dEdDFjbDlnRTQweGVMWXI2cVZvaldMaEh5NjJK?=
 =?utf-8?B?SG5lUkJCU2xqcmZpVTN0MUFzamFJWGdza1hOOFVUUHJNcFFiSGc4MWE0ZlI3?=
 =?utf-8?B?elFGWHhESlQ2ODQxWU55bGFOYlRhWEZ2UnUzZGRKNmF1cEU3MUM1V3RtYUVz?=
 =?utf-8?B?U0w0UnByOEU0K00yTThJcUxBSWtDbEJ1cWFYcUs1WGNPTUhIazEvMTVUWTRG?=
 =?utf-8?B?WWFaTW8wUjg0ZmFrRWpNSGVDaTV2MnVlaStEMngrL2lKY2ZyU2M1R1BaRHdG?=
 =?utf-8?B?TEpEdCtuRnp6YTVMN01UcWRnMUdOUjlEcG9pakVzK1ROMEZGU0x6V1hWV2dz?=
 =?utf-8?B?YUVXelN6dVRqVDBIRHRwUUFrNUY3WWpESXNJQW16NHRMS0ErazBHNlJCZVJQ?=
 =?utf-8?B?SjlKbDFMcFRoL01mVzRCWXlRMnZRcFcvN05seUdKMUxlZGRmUlN6WndVN0d5?=
 =?utf-8?B?T0kwKzdjOXZTYnBPaUR3bWp0RmUwUFV6M3JKZW1GeGRuTjNJUzRTZUdZZWRT?=
 =?utf-8?B?REVnTCtzR2NsWFhtTTBBanEvNnZoSFlIbXpGcTZOOEhseklQNjF2TGZFSGRq?=
 =?utf-8?B?V2k4MUFDZEVXeUkzc25lbmVTclJaWGdTQlJ6ZFZ0dkhUK0JXcmRsSGpwZDZv?=
 =?utf-8?B?NHFENmF3RlJnVU5tekp6bHJYb0NCK1BEc1JZSU1FOWs4UTVQVUZ3Ym1hSVd6?=
 =?utf-8?B?clF2cDdXdy9kT0w1TlBzOXhGYk9OSzdpU2pXM05hVnQxcVE5T1JrVm1FQzJm?=
 =?utf-8?B?UGVITU8vazZJWFpSdUE3KzRiMUJ2R2h6UHdWdjFxc1ZwZ3Y1RTJZalB4V0RD?=
 =?utf-8?B?NFk4aXIzTHJXK1JIdDVTTjVpK05Ic1ZHOHBUSldBcW9ZQWhZcnlQNkl2eGFD?=
 =?utf-8?B?TTdhQ2F5RkU4Sm1jWW04b1pQMkN0dndFNzE4aTNMT3hjaGgybVNKR3ZKVjJG?=
 =?utf-8?B?L09zMWcvSE1uS2FoU28xQzk3Wldhb21EeTJNcEM1RUo0cm96SFNMY0tGOFdT?=
 =?utf-8?B?NWhQZWZNbWZoNG11UFA5ZXpEMGYwN21Pc1hhU1RJYVRkSWxvdnptcVpvMkk3?=
 =?utf-8?B?SXVmNHBmYlVCWmpPMHlqNWZUS0tYZnMxK2xUbUFnL09tejdTUVZTU3RDNUFj?=
 =?utf-8?B?clJWejNQT0dTaVJFUW1yWHJ5bm5paVZwNlp0L0Y5S25WWll5SHFOa08vRzZY?=
 =?utf-8?B?V2hpMExFblZhRzAzSEVCTHNhZHk5Y1FrdWl1VGxVWnppMVh6MGlpQWFvdHZ0?=
 =?utf-8?B?Unkybjc4WWVEWWU2a2R1NXBNYXRBRkpqb2tjUG1QZFkxUzZWd1h2TWo2Z1ZN?=
 =?utf-8?B?VlZUUGs2MDNLYXBSNmYzMUNVOWd0Zk1sTTR6eFhGWnk4M25jMVh6UmpRTUZK?=
 =?utf-8?B?NVZRQUV6ZnpDa0RXNDE0c0JkZVJQbGpPUWhTaStUZ29tblRCbzhuMCtyZURa?=
 =?utf-8?B?bmRkOXc2YTFsU3hXR3FkUXhaN1NJSDFNRWRVMkZTM3pIK3czMDRMS2hXclFw?=
 =?utf-8?B?ZjNWd21LQ09WUkNFYndTcUQ4Y3Vpdi95RG80ZTlrYkZlelBJc1prNEtwTlNJ?=
 =?utf-8?B?ODRWYUkza05XU1ArU2U1RG1Vd2NuUHloMlhBV1h1NXhIaWIwOHJ5cmw5RytW?=
 =?utf-8?B?TU1Lb2dxOXlmREdRRWZLRmpXbFMzVzJ1d3Q3YWdENTlLRkxGMW5RV1l5OXRU?=
 =?utf-8?B?TWNhWXRQWkh5RlVrOU1mbElZYldnNUZUbDhBck1pVEVDSld5T1lGemFudWlE?=
 =?utf-8?B?ZDduYytVSFpBL0pRRGNiVXBKNUJvai91QS9oT0VmWlZNY1IxNzhncXcyRk5D?=
 =?utf-8?B?M3NScGRya3lFdCtzUXpqVlIwM3lBTDdTWmhteHplTENqazlCdmE0ZEtHUzV0?=
 =?utf-8?B?VlpDQmxPUUNac25PZnpZRUlnVlJQdmRvcGpaZ1V2ZlNvb3lIWUtxbWpNSi94?=
 =?utf-8?B?SmUxcjNzSTlTWDV5bnhIbWdFTUkzMDJaektWQnh1UllCeHUzTElnNklzWU82?=
 =?utf-8?B?U1E9PQ==?=
X-Microsoft-Antispam-Message-Info: oHUUIyINEEKFFNsuPi2t5JL/otVBGWr0v9ioqclcHj3wq97RSOHqjdKlDXUyXXI6DmrT/ymiydJC5SzD4nbOO//qk+pY+Io3LNFVlOHNZNwriXUa7EmPeBQfSxMu2N+KPjZ+vNPZOwlgC4rYC64+NXpJ1kLrYirrn1BSQ5+vK9gw4QL64I5CefVGgiK0U/B+
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0308;6:p9bbydSaER1gYOxeRDFQbLHBNRqnwm8oBeX69gl15u2rJIkDthfcYV5aiPAs0G5DHAeS2RwFbeSNwE5iHiHrglF5QjLa8p3/akb+ufKqR0jTHGiNkTS2cNMxcUNky5XFeBCLs5yFehTDufyItkwQhOlIxeHDnpneqSpr4tNuw+MFOoIEvOl4mjjorjnzn+7nm9z7UmeNUYkePSiAjOs7vjlhN36Tbxv39PUK74Cdxo5JyXgKdzsDOhIWCiecKlh6CP++IPGrpEwQss5FcIij1VFNjjfFHMNvZkepxrJVG8AGVjzHICzWYgvPHQiOSRNhzWWMba4aYYcYd2LfP1ZNLkQEXXy+xbGxoymaNzuYdFBmIM3gKD8+/D2fi8qxN5y/+K6/NXTt/nkrbuETb6bbFlKi/xyzJjRAoJ7AhUE+vJCxBTWbf4rEbvCkFgc4oQeDaCchOywYWzcyCBZrun/tAw==;5:bkXDBRT2rymfnCVkhCuTSRwpNbgDTKFwm1AzLr1aKTeU3QDPaakLwFgYCIZb2rnsQsR0GnHZef/qCY0O03cJaNMFdq0drsou+El5SZXrLGh84ckD5YHA2FAdkq9/En3nZaRwpHREMGyHVHiQEq70iqQso4qtX4+vqlU18vubcV4=;24:OMHG1bTbcP6DLRKU/bXks5Y5iLveYYQbC2oniU/tDFkSSTu9/QKEt0Nc9de9dfyYf/rqJmWTVo3HBICk7xDLi/EtT+gW0O9p1zvMz557DuQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0308;7:WrphFFnzXxyhPqCx2whIWXPyN0HbW9RdOErtMGgZfZgsuEs0HskMCXB8Ga2TruNABWDHV6DqPw2MXmB9ElwyHipha0t4fd9Hij1vDuULIfQYxvR/yVk1FjOYeW/WAmpMZvt5hhur8+D6hTf6bP+U0PKv3FDo/arlQkDE7OMQp2OgvoynygNSOodYkNQTRNlr01wHfgMaVtrKZD9TsxAn5FNEPb3rU+uCuNlnUz3pWZ5OjcuRIxYFugZKj819KeoG;20:cy+Wf5LTUUYohnpi/P93gbPjkSUr7kCn8PBV76C374hS1do9KoiuMDTMN4uOwTOQJn86QBB2uDvksZN+/oYY6AKxsLEIGK5yII2mu3a4giPfl3tZ6VTW/LlCWJI+cL8HKhHl4YX015ye+j/hN/6yZT5n8I1u+lDnyhB+MMZrMhh79ACZ6QpeyzOfQoqYz1QPEXbp/UgA0DAX+8lxtPf9pVjrrp0Rw9+6U49wLWSYd6VIRfoy7B/ktKpIKU2Tuujj
X-MS-Office365-Filtering-Correlation-Id: 94f2706e-19cc-4852-3a5a-08d5aea7457b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 14:32:57.7407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f2706e-19cc-4852-3a5a-08d5aea7457b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0308
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/30/2018 08:08 AM, Christian König wrote:
> Hi Eric,
>
> sorry for the late response, was on vacation last week.
>
> Am 26.04.2018 um 02:01 schrieb Eric W. Biederman:
>> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>>
>>> On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
>>>> On 04/25, Andrey Grodzovsky wrote:
>>>>> here (drm_sched_entity_fini) is also a bad idea, but we still want 
>>>>> to be
>>>>> able to exit immediately
>>>>> and not wait for GPU jobs completion when the reason for reaching 
>>>>> this code
>>>>> is because of KILL
>>>>> signal to the user process who opened the device file.
>>>> Can you hook f_op->flush method?
>
> THANKS! That sounds like a really good idea to me and we haven't 
> investigated into that direction yet.
>
>>> But this one is called for each task releasing a reference to the 
>>> the file, so
>>> not sure I see how this solves the problem.
>> The big question is why do you need to wait during the final closing a
>> file?
>
> As always it's because of historical reasons. Initially user space 
> pushed commands directly to a hardware queue and when a processes 
> finished we didn't need to wait for anything.
>
> Then the GPU scheduler was introduced which delayed pushing the jobs 
> to the hardware queue to a later point in time.
>
> This wait was then added to maintain backward compability and not 
> break userspace (but see below).
>
>> The wait can be terminated so the wait does not appear to be simply a
>> matter of correctness.
>
> Well when the process is killed we don't care about correctness any 
> more, we just want to get rid of it as quickly as possible (OOM 
> situation etc...).
>
> But it is perfectly possible that a process submits some render 
> commands and then calls exit() or terminates because of a SIGTERM, 
> SIGINT etc.. In this case we need to wait here to make sure that all 
> rendering is pushed to the hardware because the scheduler might need 
> resources/settings from the file descriptor.
>
> For example if you just remove that wait you could close firefox and 
> get garbage on the screen for a millisecond because the remaining 
> rendering commands where not executed.
>
> So what we essentially need is to distinct between a SIGKILL (which 
> means stop processing as soon as possible) and any other reason 
> because then we don't want to annoy the user with garbage on the 
> screen (even if it's just for a few milliseconds).
>
> Constructive ideas how to handle this would be very welcome, cause I 
> completely agree that what we have at the moment by checking PF_SIGNAL 
> is just a very very hacky workaround.

What about changing PF_SIGNALED to  PF_EXITING in 
drm_sched_entity_do_release

-       if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
+      if ((current->flags & PF_EXITING) && current->exit_code == SIGKILL)

 From looking into do_exit and it's callers , current->exit_code will 
get assign the signal which was delivered to the task. If SIGINT was 
sent then it's SIGINT, if SIGKILL then SIGKILL.

Andrey


>
> Thanks,
> Christian.


>
>>
>> Eric
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
