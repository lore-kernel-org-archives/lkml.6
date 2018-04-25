Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbeDYPbZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:31:25 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44782 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754600AbeDYPbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:31:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: David.Panariti@amd.com,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        oleg@redhat.com, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, akpm@linux-foundation.org,
        Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
        <20180424194418.GE25142@phenom.ffwll.local>
        <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
        <87tvs05mik.fsf@xmission.com>
        <27d7d15b-f7c3-2a0a-af85-eb243526ac88@amd.com>
        <20180425071444.GM25142@phenom.ffwll.local>
        <94828a42-02dd-29ad-a3d0-dc4c0cc82ddb@amd.com>
Date: Wed, 25 Apr 2018 10:29:47 -0500
In-Reply-To: <94828a42-02dd-29ad-a3d0-dc4c0cc82ddb@amd.com> (Andrey
        Grodzovsky's message of "Wed, 25 Apr 2018 09:08:08 -0400")
Message-ID: <87a7trwbh0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fBMO1-0004pK-IV;;;mid=<87a7trwbh0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+yLdgpWhro2oV3W8E/op4lWx+9dQ/0k7w=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1228 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 3.5 (0.3%), b_tie_ro: 2.4 (0.2%), parse: 1.83 (0.1%),
        extract_message_metadata: 35 (2.9%), get_uri_detail_list: 6 (0.5%),
        tests_pri_-1000: 11 (0.9%), tests_pri_-950: 2.3 (0.2%), tests_pri_-900: 2.3
        (0.2%), tests_pri_-400: 47 (3.8%), check_bayes: 44 (3.6%), b_tokenize: 18
        (1.5%), b_tok_get_all: 11 (0.9%), b_comp_prob: 7 (0.5%), b_tok_touch_all: 3.7
        (0.3%), b_finish: 0.92 (0.1%), tests_pri_0: 813 (66.2%),
        check_dkim_signature: 1.15 (0.1%), check_dkim_adsp: 5 (0.4%), tests_pri_500:
        306 (24.9%), poll_dns_idle: 296 (24.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/25/2018 03:14 AM, Daniel Vetter wrote:
>> On Tue, Apr 24, 2018 at 05:37:08PM -0400, Andrey Grodzovsky wrote:
>>>
>>> On 04/24/2018 05:21 PM, Eric W. Biederman wrote:
>>>> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>>>>
>>>>> On 04/24/2018 03:44 PM, Daniel Vetter wrote:
>>>>>> On Tue, Apr 24, 2018 at 05:46:52PM +0200, Michel Dänzer wrote:
>>>>>>> Adding the dri-devel list, since this is driver independent code.
>>>>>>>
>>>>>>>
>>>>>>> On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
>>>>>>>> Avoid calling wait_event_killable when you are possibly being called
>>>>>>>> from get_signal routine since in that case you end up in a deadlock
>>>>>>>> where you are alreay blocked in singla processing any trying to wait
>>>>>>> Multiple typos here, "[...] already blocked in signal processing and [...]"?
>>>>>>>
>>>>>>>
>>>>>>>> on a new signal.
>>>>>>>>
>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>>>>>>>>     1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>>>>> index 088ff2b..09fd258 100644
>>>>>>>> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>>>>> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>>>>> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>>>>>>>>     		return;
>>>>>>>>     	/**
>>>>>>>>     	 * The client will not queue more IBs during this fini, consume existing
>>>>>>>> -	 * queued IBs or discard them on SIGKILL
>>>>>>>> +	 * queued IBs or discard them when in death signal state since
>>>>>>>> +	 * wait_event_killable can't receive signals in that state.
>>>>>>>>     	*/
>>>>>>>> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>>>>>>>> +	if (current->flags & PF_SIGNALED)
>>>>>> You want fatal_signal_pending() here, instead of inventing your own broken
>>>>>> version.
>>>>> I rely on current->flags & PF_SIGNALED because this being set from
>>>>> within get_signal,
>>>> It doesn't mean that.  Unless you are called by do_coredump (you
>>>> aren't).
>>> Looking in latest code here
>>> https://elixir.bootlin.com/linux/v4.17-rc2/source/kernel/signal.c#L2449
>>> i see that current->flags |= PF_SIGNALED; is out side of
>>> if (sig_kernel_coredump(signr)) {...} scope
>> Ok I read some more about this, and I guess you go through process exit
>> and then eventually close. But I'm not sure.
>>
>> The code in drm_sched_entity_fini also looks strange: You unpark the
>> scheduler thread before you remove all the IBs. At least from the comment
>> that doesn't sound like what you want to do.
>
> I think it should be safe for the dying scheduler entity since before that (in
> drm_sched_entity_do_release) we set it's runqueue to NULL
> so no new jobs will be dequeued form it by the scheduler thread.
>
>>
>> But in general, PF_SIGNALED is really something deeply internal to the
>> core (used for some book-keeping and accounting). The drm scheduler is the
>> only thing looking at it, so smells like a layering violation. I suspect
>> (but without knowing what you're actually trying to achive here can't be
>> sure) you want to look at something else.
>>
>> E.g. PF_EXITING seems to be used in a lot more places to cancel stuff
>> that's no longer relevant when a task exits, not PF_SIGNALED. There's the
>> TIF_MEMDIE flag if you're hacking around issues with the oom-killer.
>>
>> This here on the other hand looks really fragile, and probably only does
>> what you want to do by accident.
>> -Daniel
>
> Yes , that what Eric also said and in the V2 patches i will try  to change
> PF_EXITING
>
> Another issue is changing wait_event_killable to wait_event_timeout where I need
> to understand
> what TO value is acceptable for all the drivers using the scheduler, or maybe it
> should come as a property
> of drm_sched_entity.

It would not surprise me if you could pick a large value like 1 second
and issue a warning if that time outever triggers.  It sounds like the
condition where we wait indefinitely today is because something went
wrong in the driver.

Eric
