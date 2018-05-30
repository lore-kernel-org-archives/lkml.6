Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932272AbeE3UcY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:32:24 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58509 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeE3UcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:32:21 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@kernel.org, james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com
References: <20180528215355.16119-1-christian@brauner.io>
        <20180528215355.16119-6-christian@brauner.io>
        <87fu2asl1w.fsf@xmission.com> <20180529123804.GA11221@mailbox.org>
Date: Wed, 30 May 2018 15:31:59 -0500
In-Reply-To: <20180529123804.GA11221@mailbox.org> (Christian Brauner's message
        of "Tue, 29 May 2018 14:38:04 +0200")
Message-ID: <87r2lsga0w.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fO7lL-0003jv-Px;;;mid=<87r2lsga0w.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19dJcr6AqmCwtWbuVlrtspdDiVOCbLidl0=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian@brauner.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15023 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.6 (0.0%), b_tie_ro: 2.8 (0.0%), parse: 0.81 (0.0%),
        extract_message_metadata: 10 (0.1%), get_uri_detail_list: 0.85 (0.0%),
        tests_pri_-1000: 3.0 (0.0%), tests_pri_-950: 1.21 (0.0%), tests_pri_-900:
        1.02 (0.0%), tests_pri_-400: 19 (0.1%), check_bayes: 18 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.90 (0.0%), b_tok_touch_all:
        2.9 (0.0%), b_finish: 0.61 (0.0%), tests_pri_0: 135 (0.9%),
        check_dkim_signature: 0.45 (0.0%), check_dkim_adsp: 2.5 (0.0%),
        tests_pri_500: 14847 (98.8%), poll_dns_idle: 14837 (98.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v1 05/20] signal: flatten do_send_sig_info()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

2> On Tue, May 29, 2018 at 07:28:27AM -0500, Eric W. Biederman wrote:
>> Christian Brauner <christian@brauner.io> writes:
>> 
>> > Let's return early when lock_task_sighand() fails and move send_signal()
>> > and unlock_task_sighand() out of the if block.
>> 
>> Introducing multiple exits into a function.  Ick.
>> You do know that is what Dijkstra was arguing against in his paper
>> "Goto Considered Harmful"
>> 
>> That introduces mutiple exits and makes the function harder to analyze.
>> It is especially a pain as I have something in my queue that will
>> shuffle things around and remove the possibility of lock_task_sighand
>> failing.
>
> I'm happy to drop this one if you have a fix for this in your tree
> anyway.
>
> Aside from that, I think it might make sense to route this patch series
> through your tree though since you're doing the siginfo rework
> currently.(?)

If you will purely code style changes such as this one I will be happy
to pick up the rest as they are pretty much obviously correct changes.

Eric
