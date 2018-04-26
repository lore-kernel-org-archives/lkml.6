Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756802AbeDZP7R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:59:17 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42111 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756519AbeDZP7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:59:15 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
        Christian.Koenig@amd.com, David.Panariti@amd.com,
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
        <611911a3-2858-200c-d5f8-679c5f41ee3a@amd.com>
        <d6754c66-afe8-db2a-5633-d33701e22f3c@amd.com>
Date: Thu, 26 Apr 2018 10:57:46 -0500
In-Reply-To: <d6754c66-afe8-db2a-5633-d33701e22f3c@amd.com> (Andrey
        Grodzovsky's message of "Thu, 26 Apr 2018 08:52:34 -0400")
Message-ID: <87zi1qq7t1.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fBjIf-0006SN-A8;;;mid=<87zi1qq7t1.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/tqEcKO+U22HXnkHcZ+UaJA4lqVV28qfQ=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 281 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (3.4%), b_tie_ro: 7 (2.6%), parse: 1.20 (0.4%),
        extract_message_metadata: 14 (4.9%), get_uri_detail_list: 2.3 (0.8%),
        tests_pri_-1000: 6 (2.1%), tests_pri_-950: 1.45 (0.5%), tests_pri_-900: 1.15
        (0.4%), tests_pri_-400: 24 (8.6%), check_bayes: 23 (8.2%), b_tokenize: 8
        (3.0%), b_tok_get_all: 7 (2.6%), b_comp_prob: 2.6 (0.9%), b_tok_touch_all:
        2.4 (0.8%), b_finish: 0.61 (0.2%), tests_pri_0: 185 (65.8%),
        check_dkim_signature: 0.53 (0.2%), check_dkim_adsp: 2.9 (1.0%),
        tests_pri_500: 35 (12.5%), poll_dns_idle: 29 (10.3%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/26/2018 08:34 AM, Andrey Grodzovsky wrote:
>>
>>
>> On 04/25/2018 08:01 PM, Eric W. Biederman wrote:
>>> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>>>
>>>> On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
>>>>> On 04/25, Andrey Grodzovsky wrote:
>>>>>> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
>>>>>> able to exit immediately
>>>>>> and not wait for GPU jobs completion when the reason for reaching this
>>>>>> code
>>>>>> is because of KILL
>>>>>> signal to the user process who opened the device file.
>>>>> Can you hook f_op->flush method?
>>>> But this one is called for each task releasing a reference to the the file,
>>>> so
>>>> not sure I see how this solves the problem.
>>> The big question is why do you need to wait during the final closing a
>>> file?
>>>
>>> The wait can be terminated so the wait does not appear to be simply a
>>> matter of correctness.
>>
>> Well, as I understand it, it just means that you don't want to abruptly
>> terminate GPU work in progress without a good
>> reason (such as KILL signal). When we exit we are going to release various
>> resources GPU is still using so we either
>> wait for it to complete or terminate the remaining jobs.

At the point of do_exit you might as well be a KILL signal however you
got there.

> Looked more into code, some correction, drm_sched_entity_fini means the SW job
> queue itself is about to die, so we must
> either wait for completion or terminate any outstanding jobs that are still in
> the SW queue. Anything which already in flight in HW
> will still complete.

It sounds like we don't care if we block the process that had the file
descriptor open, this is just book keeping.  Which allows having a piece
of code that cleans up resources when the GPU is done with the queue but
does not make userspace wait.  (option 1)

For it to make sense that we let the process run there has to be
something that cares about the results being completed.  If all of the
file descriptors are closed and the process is killed I can't see who
will care that the software queue will continue to be processed.  So it
may be reasonable to simply kill the queue (option 2).

If userspace really needs the wait it is probably better done in
f_op->flush so that every close of the file descriptor blocks
until the queue is flushed (option 3).

Do you know if userspace cares about the gpu operations completing?

My skim of the code suggests that nothing actually cares about those
operations, but I really don't know the gpu well.

Eric
