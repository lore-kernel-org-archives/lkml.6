Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754895AbeD3QZ4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:25:56 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55723 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754567AbeD3QZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:25:54 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian =?utf-8?Q?K=C3=B6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        christian.koenig@amd.com, David.Panariti@amd.com,
        Oleg Nesterov <oleg@redhat.com>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <87muxsbmkp.fsf@xmission.com>
        <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
        <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
        <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
        <20180425171757.GA10441@redhat.com>
        <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com>
        <874ljyu98e.fsf@xmission.com>
        <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
Date: Mon, 30 Apr 2018 11:25:47 -0500
In-Reply-To: <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com> ("Christian
        \=\?utf-8\?Q\?K\=C3\=B6nig\=22's\?\= message of "Mon, 30 Apr 2018 14:08:44 +0200")
Message-ID: <87k1so8xv8.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fDBcd-0003Q6-In;;;mid=<87k1so8xv8.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+3BheJ6dslz9zIyf2JrHqg8aNAx0wZUSo=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?**;Christian K=c3=b6nig <ckoenig.leichtzumerken@gmail.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 618 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.4%), b_tie_ro: 1.74 (0.3%), parse: 0.92 (0.1%),
        extract_message_metadata: 11 (1.8%), get_uri_detail_list: 2.3 (0.4%),
        tests_pri_-1000: 4.6 (0.8%), tests_pri_-950: 1.16 (0.2%), tests_pri_-900:
        1.00 (0.2%), tests_pri_-400: 27 (4.3%), check_bayes: 26 (4.2%), b_tokenize: 9
        (1.4%), b_tok_get_all: 9 (1.5%), b_comp_prob: 3.0 (0.5%), b_tok_touch_all:
        2.9 (0.5%), b_finish: 0.55 (0.1%), tests_pri_0: 256 (41.3%),
        check_dkim_signature: 0.52 (0.1%), check_dkim_adsp: 2.5 (0.4%),
        tests_pri_500: 312 (50.4%), poll_dns_idle: 305 (49.2%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian König <ckoenig.leichtzumerken@gmail.com> writes:

> Hi Eric,
>
> sorry for the late response, was on vacation last week.
>
> Am 26.04.2018 um 02:01 schrieb Eric W. Biederman:
>> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>>
>>> On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
>>>> On 04/25, Andrey Grodzovsky wrote:
>>>>> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
>>>>> able to exit immediately
>>>>> and not wait for GPU jobs completion when the reason for reaching this code
>>>>> is because of KILL
>>>>> signal to the user process who opened the device file.
>>>> Can you hook f_op->flush method?
>
> THANKS! That sounds like a really good idea to me and we haven't investigated
> into that direction yet.

For the backwards compatibility concerns you cite below the flush method
seems a much better place to introduce the wait.  You at least really
will be in a process context for that.  Still might be in exit but at
least you will be legitimately be in a process.

>>> But this one is called for each task releasing a reference to the the file, so
>>> not sure I see how this solves the problem.
>> The big question is why do you need to wait during the final closing a
>> file?
>
> As always it's because of historical reasons. Initially user space pushed
> commands directly to a hardware queue and when a processes finished we didn't
> need to wait for anything.
>
> Then the GPU scheduler was introduced which delayed pushing the jobs to the
> hardware queue to a later point in time.
>
> This wait was then added to maintain backward compability and not break
> userspace (but see below).

That make sense.

>> The wait can be terminated so the wait does not appear to be simply a
>> matter of correctness.
>
> Well when the process is killed we don't care about correctness any more, we
> just want to get rid of it as quickly as possible (OOM situation etc...).
>
> But it is perfectly possible that a process submits some render commands and
> then calls exit() or terminates because of a SIGTERM, SIGINT etc.. In this case
> we need to wait here to make sure that all rendering is pushed to the hardware
> because the scheduler might need resources/settings from the file
> descriptor.
>
> For example if you just remove that wait you could close firefox and get garbage
> on the screen for a millisecond because the remaining rendering commands where
> not executed.
>
> So what we essentially need is to distinct between a SIGKILL (which means stop
> processing as soon as possible) and any other reason because then we don't want
> to annoy the user with garbage on the screen (even if it's just for a few
> milliseconds).

I see a couple of issues.

- Running the code in release rather than in flush.

Using flush will catch every close so it should be more backwards
compatible.  f_op->flush always runs in process context so looking at
current makes sense.

- Distinguishing between death by SIGKILL and other process exit deaths.

In f_op->flush the code can test "((tsk->flags & PF_EXITING) &&
(tsk->code == SIGKILL))" to see if it was SIGKILL that terminated
the process.

- Dealing with stuck queues (where this patchset came in).

For stuck queues you are going to need a timeout instead of the current
indefinite wait after PF_EXITING is set.  From what you have described a
few milliseconds should be enough.  If PF_EXITING is not set you can
still just make the wait killable and skip the timeout if that will give
a better backwards compatible user experience.

What can't be done is try and catch SIGKILL after a process has called
do_exit.  A dead process is a dead process.

Eric
