Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeDXQnk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:43:40 -0400
Received: from mail-by2nam01on0062.outbound.protection.outlook.com ([104.47.34.62]:14489
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750943AbeDXQng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:43:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        David.Panariti@amd.com, oleg@redhat.com, akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
Date: Tue, 24 Apr 2018 12:43:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <87muxsbmkp.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3ce0:41b::4]
X-ClientProxiedBy: YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::14) To MWHPR1201MB0126.namprd12.prod.outlook.com
 (2603:10b6:301:55::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0126;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;3:t1uasjlc/YfIEcKcnp4qA4TBrScmB4dnbhRnVUAVo0nLa3uBsz/xI6OghUifRXf++ZVuq6WnoGg6cfUWY6KMo48fXk938VX1urTbKhtogr0aF9AnBwK6M6VECOlyLwltCvuNmNfy9BA62hDyomwMeFaWqOZFC6Q54eIgLE++YNUxmCrmpg2IYAhimQTi9+ocZblsiQUcd+OLhEMcYD32U2XLdtsIHBr7wRV7JzSXsL7ahy0Snp0cpzDlF5Vme99R;25:HpQ4cQvudMjg0veeTtK8gVOC+QZjRidS4uDHOBtGBHPb6oBFgn7iaf7B45zOSC8ZTRve7JSN5/5gKjzFA8qoMlKGesWLIhJQOoM/UIHbCxE9XwXrUHL+T7iLGnMyNvZ0w7gdAZ6iEw6QG8fC3W7qXSNF1eCApnMLegtFxugQoxne1BZ+ZgeB4o+5dLHPuoEAhI75YhWUc1slycdJnjNqfDtzgs/TBvVKeS6rfJorHz3KWNF8FJ/nbrQzMYKTRP8Lfuc5eMwbGmiz9LsycHNdyNmVUv9R+/7m1W2yPvh43g5Kl5rBjCdFU50ASGd6OGD2yUdDPExcFpC7fZNQ11RRzg==;31:wSrilHxSpmj+kpO3dQunC35vMbDPc6dzdEF3qx8t8iFWVEpCjfI9cenCBvjZSBvPHRA6YimKK4iN3shCRVkla3eScpTOuU/1RTJuRxiwSXv64Thnj7gFtuw0bgRrP+hJsI+8eQmvkPTf5etLsTy6CftvibmF0T9IQL13aDRcfuw/7S46sAfGgi6Qsu1TnKkGmld1w9r8Ld8/PviuVHcN1A7rCL4DOKlqfwtAgfN1C5I=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0126:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;20:G7PC73NsYCiHdPrhvK89f6EcWd/83cXVf/iGvwAOuZkCjgM/1qUfLw/o4dpaFHL+TGqJPGwf8VBeFry1itrIRqlmWS4VkkWl7prue1wqzBBvKOzgyhkT/cJjHdaQq1OmEDgjKu6akTx1pykzna2nfqEqnAvovLFm1ZsAfx9zS1RKu7/0nabPYjWAxilsMY3f50WRc60qGhS0FMsuMFR2votlPXTqDa4MZcD6GQrCMAROEehZoBPjbzggJ0M8fNyiCY0PBOVfoH9TRypSuxGtfiqgZChNhA+h0YKDxb3e6pYKX/07T/SeiTDu4F6xzlwayGe+1Hll+h9KwbYEghAozN/4Q6FFyvnlGl+AdP9Gu4BtrVcvkt7XuwDbj4f1S5UeynRQMjgn6rDtB1WKlrXgi1IWHj4AQbR/phIoYTxkZfgHeiSNFG/Oosr1KDz4izSQh9fDaefnMFJ4P+dRLyYTnHxiilsNYJIzz3fvdf4QGxVMCoiXY1I8KeIxCLkk9Amt;4:iUeVJDDQE10At/F0jzPsaG2JbTCKbrWhXgUnq4qMbvwMw6yYzWcrTDF83Ki/3NbGpFxmmw+/fEag3fM//CtCagDWIXihSCWSu1K3swWlIILBAI0Tz8BftmNUCZqymicEGa4L4wVBJQsSpX/Is1gSnGO20mMdN2/l+oOdCNKBnPMj++xAoQ1XV+zhs667TSKDTwkY0AOdQSWj6EDHRZvAb0T/4q6yGPQfKRo2dgvXDkLukHik/8YZXK3GWXtQTMAnvAYWoPadM6UfwuD/v4PzniOo2Tgo3QvAvbcYzOVyxsXrfzKbbMqRBT8v0ElT856M
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0126EA2393B51DBA4B9A3E88EA880@MWHPR1201MB0126.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR1201MB0126;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0126;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(376002)(346002)(396003)(189003)(199004)(59450400001)(106356001)(105586002)(305945005)(31696002)(81166006)(81156014)(76176011)(386003)(52116002)(31686004)(53546011)(6486002)(1706002)(5660300001)(86362001)(229853002)(65826007)(36756003)(186003)(23676004)(2486003)(52146003)(8676002)(8936002)(52396003)(68736007)(230700001)(53936002)(16526019)(72206003)(2616005)(11346002)(446003)(476003)(25786009)(486006)(4326008)(478600001)(6246003)(64126003)(316002)(58126008)(50466002)(6916009)(47776003)(6116002)(65806001)(65956001)(46003)(97736004)(6666003)(67846002)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0126;H:[IPv6:2607:fea8:3ce0:41b::4];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyMDFNQjAxMjY7MjM6MkdpTGkyYysyUlhaK25YeHdSKzVRWHN3?=
 =?utf-8?B?cWxhdjFudjdWenhvT1BDZ3laZlJiWTVUYUdBL3QxaDJQWi9kZlZvTWswSUVi?=
 =?utf-8?B?bnpuZWN4Zmo2VGx3bStwOFZzazlib25ZclQvN1RHK05SUWVqb2xtMld2b3o3?=
 =?utf-8?B?NVZqVnFvR1lEbncycjVhWElUU1J2VUplNnkweHFjN01aOUZTeGU0aFQ0WW9L?=
 =?utf-8?B?aXdPNFNYLzFNK3d5cmRjK1pXMFpkU0Y0bngyL2hxSkhldWdBcGVBTUd2WG9G?=
 =?utf-8?B?YkJ3NmpYVE4yQnBhaDBLU3E2VUNlTFM1VWQwcGVlVFo4WUtVdlNWQUxONkIy?=
 =?utf-8?B?OHFwQUthbktzZXZZS1Fya3ozY1dnUTdWSW5TYm5OY3RhZ2I3bGRwS0xFMWJr?=
 =?utf-8?B?d09rNS96dmZsVlg1WFpqUnpHOTFiZlZ3TlpRWk5VZlViV3EveGpsUHNmait2?=
 =?utf-8?B?OUljZjJmdFo3a3o5d1NiZktBN0NseXhvMUVNSTZvOXptUjJNTzZFSzFZSjNs?=
 =?utf-8?B?Z0NXaHkzOXNBOGhYNC9sVU1TY2FFaG1oNFZmUU9BbHJYcXVsY0NxMmEraGZp?=
 =?utf-8?B?UTRVWUwwd24vQnk1R2lOTUwvTURZNXlMbjdhTng3K0RaTzZNQ1dLYXhnMEc1?=
 =?utf-8?B?djg5NFZXdFVmek15MjgvVFdlSFlYVWJ5NnV4UXRNMndMK0lna0dYSE9leitR?=
 =?utf-8?B?eHdJcDM5bEhKNWtKamxJZlMzaENjVzZPdktZQnU2OThrb1pkUGFuMmJSTWw3?=
 =?utf-8?B?SEt1a2VJcDB5enhBcm5Ra0p1ZmF0cnVrYUY1enJJUGFiay9DUXBYR2xtd2pC?=
 =?utf-8?B?RUo1bmFVeXRyanM0K0hKU1ZOSkprS3F0bXYwZGJ0S01GbmoxUWY0b04zK0c0?=
 =?utf-8?B?NW5yYzlLdmhNejlKZllJK1htNGkzQUR4RFFEUUZaR2ZJK1c2UG5qeWdEZWov?=
 =?utf-8?B?ZXhnKzlWQ09xd0VoT0FCT3FZU3V5ZjVydnlYV2pGVldxbmV4QXJLTjRDMzU4?=
 =?utf-8?B?OCtHSDNRRlJ1RzNDZUxvOGRIaElsd242R0w3ZkFZZHExdktnYnZHNXBpbWVs?=
 =?utf-8?B?Yk13cUVjRHlQZk91aHpQSnY1YzJtZ29VZ0lsWENtUG9ESERIK3lmL2FkZVFU?=
 =?utf-8?B?RTRpakk5NXBONEN5UU1kdkVuYnVIM20vK2RPcitaUkI3WllFRWhaY2ttVUVM?=
 =?utf-8?B?bVh5MlFUMG9tbmU2TVBmUSsxQXhKUytBdkNSMEt1dC9BTnprYmZrdkllcHRO?=
 =?utf-8?B?d1FSQUxqZVZ3bHdrSmt2YTFMZWFJMkY2dklYU2E4amJXbEFJRjYrdWROdXdx?=
 =?utf-8?B?amZoN0cyS201NHVyVlpzZVZ4aXo3RDZhY3E5SWlDdGFkNkUwbEVMZUJGVGxZ?=
 =?utf-8?B?TUJ2TWt3SllsNVlsNlFkaWlMcGh5cE1WMUtveFBROXlQckp4Q2llVGpaL0Ju?=
 =?utf-8?B?OHRrekdlMzRlMXBhdjZkVjJyN3QzVk9zTnRheHRLUEx0ZHpQWG0zNUM3c1A0?=
 =?utf-8?B?UFlEY05QZHJFNExXUE9yek8yUHZQbVllRzcvNUVGamlWaXBPdWZoNHZteUF5?=
 =?utf-8?B?OHRCU01CcGtjRkIzNnh0QjJIczdUdUwrZjZQRHprc3Bsa1JlNm50alZZVVpP?=
 =?utf-8?B?dEppMkQ0RGw4aEN3RDlLZy9DOXU5dUlaWXNUcXJQYW9pdDdwY2w0cktGYTVG?=
 =?utf-8?B?US9RUGVEY2ZpYzRtREF1WGk4L2RLTGNvSkFramJ0ZGRqRGYxOE94ZFFCbHBH?=
 =?utf-8?B?Um9mT1huVnVIMHl1Nk9RMWlBa1FBZGZjV3hFNDMvVlg5bzJET0lmS1ZCYnNx?=
 =?utf-8?B?M3g2a1cxZW42V1RCLzVmZXl5cEhyRE9RZzNjUTQzdzNvSEVFSzlNckNvN2cy?=
 =?utf-8?Q?szbf9kg4WGUL7PgO4HbAaQiNr4eC1QBf6O?=
X-Microsoft-Antispam-Message-Info: aOuub9q+kn4R78+1yeX/6KdWDRgld0P6A4G74/BN3a/Rqkd4ZnCvyuBBqavOzisOFkDVmLDbBCrQLjuHnxLK7FvOv4vl5HJFc7MgPiZT7hiVLZjbySVptisGq9kQxDzsMSOQCAHXjhCiyNTQKQR4rO6AywaciRaGhGGU1HdOG1SdedwRrDm4bNY7JlsZL5zc
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;6:SBauKqXY+pY+T8hE/HBOoEUzOo9e05ZmvbBb/bz9+O5uKpRXkMIUrJN/P0JCspsuUAy7GESILkyDhSiv1dfxPboRHy4P2j0YghIJx7maTMs2ygSJyhGzBaKUVxLw0ZO1jCSP6Y8j2PttILvg3vp85mk3nJzXSG1ZQO1nAYzhYd7TOmB4vJ4wzy2Y+KYg8HE+2s7BwJJtjjPHubp6/H3SXAMKQdAozC+wWlfLgpuAi//XBxK36iRQsqZZ+vzd0DgqmmBhS8MwfSCTLyFWdl1eiar1SBFqh3LI7OhFNBUltETXoEV9PLElTTMISWlrP87ose8sPy/cFHT6SPHx9VXlyhZ35oLzRfkqzIyfX3TqY2qHS4OfSRELjHpD6XO5w9Ufn4UbD174E9s1A8PuP/tIs6wAk+qqRn6j+dV/F5Cw6hJ+Lf0YQ5D2vAKOqSP+nAFdI5SDxNLm6Z6KfXP0giPc1Q==;5:NlLzlA478pYec4FIxQMPbmJIVFGr844ZOGQOAdZmfbwe6ur3Pf38SUAexHvpmbSIdfPBO9jGm8b5IKWl/P4XA4M3pWdEV4Jd60jgEkpAb8zcHJOnknyBaeTNjyAnfD4ybe60EqtohAPQv5A4hBnZ9W2BWwRTLwJsNoqhGj6HVX8=;24:unnOgEXrb+2Fyzh4P7wS734yXWqsABaNq3nBrfDGMy0cv67O0TMHO5zvBUngdLLTCJjgSHRlJRA52VwWspYuxqfPHXp/pVw4pJImmMG5/t0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;7:ysQuKZsx/ISNln8ql5SVf5J6Ysvh1sZajz15EFVmq7/noQ78wg04WdOnm2+2h++LDZSEqsFKL6P7oT8aQqD0e8M/rQlLI9Tb97GQhlqxfxrJGT889pC5DGFBk1F79enUTW2mdjUYVs1Fge/+ZsbRs5i6uwzGfnUYDN2dbF+tZRHgX/+OTnF+bAXNPekm0LoS/nWKC/ncdbstSUsKRcEr47kQ99ugowAKZ1SLow5iKOiuqOBIY/HE2MNMLI9oBx5p;20:u6d04JBhahyn6TLohrbkBRVMMKXW9Is7MG+VDOAIRkoFFr2UNQMZoq73bJZLg5RqO1i3Ie98twj/JPYrGbcmIsUSddXeSx5hRadc9rKpF87mDCgCEcss2dJrUQ7DGD79IqIGh/UJXWE+FaCuyQaZVGvFsCYtdVf6d/KE3XrUdINuQOw+8+01d6clHeBOvokSYr3DbXyFyeCpwfLwuqdH6HBEoJvjJoSdmho+FKl3NSwtWgclrQ8XHUddIV3gfUEE
X-MS-Office365-Filtering-Correlation-Id: 12b04487-0ab4-4272-7a2c-08d5aa028533
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 16:43:33.5755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b04487-0ab4-4272-7a2c-08d5aa028533
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0126
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 12:23 PM, Eric W. Biederman wrote:
> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>
>> Avoid calling wait_event_killable when you are possibly being called
>> from get_signal routine since in that case you end up in a deadlock
>> where you are alreay blocked in singla processing any trying to wait
>> on a new signal.
> I am curious what the call path that is problematic here.

Here is the problematic call stack

[<0>] drm_sched_entity_fini+0x10a/0x3a0 [gpu_sched]
[<0>] amdgpu_ctx_do_release+0x129/0x170 [amdgpu]
[<0>] amdgpu_ctx_mgr_fini+0xd5/0xe0 [amdgpu]
[<0>] amdgpu_driver_postclose_kms+0xcd/0x440 [amdgpu]
[<0>] drm_release+0x414/0x5b0 [drm]
[<0>] __fput+0x176/0x350
[<0>] task_work_run+0xa1/0xc0
[<0>] do_exit+0x48f/0x1280
[<0>] do_group_exit+0x89/0x140
[<0>] get_signal+0x375/0x8f0
[<0>] do_signal+0x79/0xaa0
[<0>] exit_to_usermode_loop+0x83/0xd0
[<0>] do_syscall_64+0x244/0x270
[<0>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[<0>] 0xffffffffffffffff

On exit from system call you process all the signals you received and 
encounter a fatal signal which triggers process termination.

>
> In general waiting seems wrong when the process has already been
> fatally killed as indicated by PF_SIGNALED.

So indeed this patch avoids wait in this case.

>
> Returning -ERESTARTSYS seems wrong as nothing should make it back even
> to the edge of userspace here.

Can you clarify please - what should be returned here instead ?

Andrey

>
> Given that this is the only use of PF_SIGNALED outside of bsd process
> accounting I find this code very suspicious.
>
> It looks the code path that gets called during exit is buggy and needs
> to be sorted out.
>
> Eric
>
>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> index 088ff2b..09fd258 100644
>> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>>   		return;
>>   	/**
>>   	 * The client will not queue more IBs during this fini, consume existing
>> -	 * queued IBs or discard them on SIGKILL
>> +	 * queued IBs or discard them when in death signal state since
>> +	 * wait_event_killable can't receive signals in that state.
>>   	*/
>> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>> +	if (current->flags & PF_SIGNALED)
>>   		entity->fini_status = -ERESTARTSYS;
>>   	else
>>   		entity->fini_status = wait_event_killable(sched->job_scheduled,
