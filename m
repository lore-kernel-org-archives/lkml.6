Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbeDXWNU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:13:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52649 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXWNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:13:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David.Panariti@amd.com,
        oleg@redhat.com, Alexander.Deucher@amd.com, akpm@linux-foundation.org,
        Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
        <20180424194418.GE25142@phenom.ffwll.local>
        <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
        <87tvs05mik.fsf@xmission.com>
        <27d7d15b-f7c3-2a0a-af85-eb243526ac88@amd.com>
Date: Tue, 24 Apr 2018 17:11:44 -0500
In-Reply-To: <27d7d15b-f7c3-2a0a-af85-eb243526ac88@amd.com> (Andrey
        Grodzovsky's message of "Tue, 24 Apr 2018 17:37:08 -0400")
Message-ID: <87a7ts2r1b.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fB6BS-0000ri-6Z;;;mid=<87a7ts2r1b.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX196qoI4w0h/NKmTC+qu2j4I/SDdWUWRqWo=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 543 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (0.5%), b_tie_ro: 1.74 (0.3%), parse: 1.01 (0.2%),
        extract_message_metadata: 15 (2.7%), get_uri_detail_list: 2.4 (0.4%),
        tests_pri_-1000: 7 (1.3%), tests_pri_-950: 1.24 (0.2%), tests_pri_-900: 1.04
        (0.2%), tests_pri_-400: 28 (5.2%), check_bayes: 27 (5.0%), b_tokenize: 9
        (1.7%), b_tok_get_all: 9 (1.6%), b_comp_prob: 2.9 (0.5%), b_tok_touch_all:
        3.5 (0.6%), b_finish: 0.66 (0.1%), tests_pri_0: 230 (42.4%),
        check_dkim_signature: 0.54 (0.1%), check_dkim_adsp: 2.7 (0.5%),
        tests_pri_500: 254 (46.8%), poll_dns_idle: 247 (45.6%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/24/2018 05:21 PM, Eric W. Biederman wrote:
>> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>>
>>> On 04/24/2018 03:44 PM, Daniel Vetter wrote:
>>>> On Tue, Apr 24, 2018 at 05:46:52PM +0200, Michel Dänzer wrote:
>>>>> Adding the dri-devel list, since this is driver independent code.
>>>>>
>>>>>
>>>>> On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
>>>>>> Avoid calling wait_event_killable when you are possibly being called
>>>>>> from get_signal routine since in that case you end up in a deadlock
>>>>>> where you are alreay blocked in singla processing any trying to wait
>>>>> Multiple typos here, "[...] already blocked in signal processing and [...]"?
>>>>>
>>>>>
>>>>>> on a new signal.
>>>>>>
>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>>> index 088ff2b..09fd258 100644
>>>>>> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>>> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>>>> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>>>>>>    		return;
>>>>>>    	/**
>>>>>>    	 * The client will not queue more IBs during this fini, consume existing
>>>>>> -	 * queued IBs or discard them on SIGKILL
>>>>>> +	 * queued IBs or discard them when in death signal state since
>>>>>> +	 * wait_event_killable can't receive signals in that state.
>>>>>>    	*/
>>>>>> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>>>>>> +	if (current->flags & PF_SIGNALED)
>>>> You want fatal_signal_pending() here, instead of inventing your own broken
>>>> version.
>>> I rely on current->flags & PF_SIGNALED because this being set from
>>> within get_signal,
>> It doesn't mean that.  Unless you are called by do_coredump (you
>> aren't).
>
> Looking in latest code here
> https://elixir.bootlin.com/linux/v4.17-rc2/source/kernel/signal.c#L2449
> i see that current->flags |= PF_SIGNALED; is out side of
> if (sig_kernel_coredump(signr)) {...} scope

In small words.  You showed me the backtrace and I have read
the code.

PF_SIGNALED means you got killed by a signal.
get_signal
  do_coredump
  do_group_exit
    do_exit
       exit_signals
          sets PF_EXITING
       exit_mm
          calls fput on mmaps
             calls sched_task_work
       exit_files
          calls fput on open files
             calls sched_task_work
       exit_task_work
          task_work_run
             /* you are here */

So strictly speaking you are inside of get_signal it is not
meaningful to speak of yourself as within get_signal.

I am a little surprised to see task_work_run called so early.
I was mostly expecting it to happen when the dead task was
scheduling away, like normally happens.

Testing for PF_SIGNALED does not give you anything at all
that testing for PF_EXITING (the flag that signal handling
is shutdown) does not get you.

There is no point in distinguishing PF_SIGNALED from any other
path to do_exit.  do_exit never returns.

The task is dead.

Blocking indefinitely while shutting down a task is a bad idea.
Blocking indefinitely while closing a file descriptor is a bad idea.

The task has been killed it can't get more dead.  SIGKILL is meaningless
at this point.

So you need a timeout, or not to wait at all.


Eric
