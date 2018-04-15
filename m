Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeDOPYL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 11:24:11 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57879 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbeDOPYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 11:24:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
        <20180412172051.GK16141@n2100.armlinux.org.uk>
        <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
        <20180413094211.GN16141@n2100.armlinux.org.uk>
        <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
        <20180413170827.GB16308@e103592.cambridge.arm.com>
        <20180413175407.GO16141@n2100.armlinux.org.uk>
        <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
        <20180413184522.GD16308@e103592.cambridge.arm.com>
        <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
        <20180415131206.GR16141@n2100.armlinux.org.uk>
Date: Sun, 15 Apr 2018 10:22:31 -0500
In-Reply-To: <20180415131206.GR16141@n2100.armlinux.org.uk> (Russell King's
        message of "Sun, 15 Apr 2018 14:12:06 +0100")
Message-ID: <87lgdocx54.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f7jVO-0005xv-04;;;mid=<87lgdocx54.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/VTAJbRwlCW74C9ibuZZxclP1az65fiGY=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Russell King - ARM Linux <linux@armlinux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15029 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.4 (0.0%), b_tie_ro: 2.3 (0.0%), parse: 1.14 (0.0%),
        extract_message_metadata: 14 (0.1%), get_uri_detail_list: 1.84 (0.0%),
        tests_pri_-1000: 3.0 (0.0%), tests_pri_-950: 1.19 (0.0%), tests_pri_-900:
        0.99 (0.0%), tests_pri_-400: 22 (0.1%), check_bayes: 21 (0.1%), b_tokenize: 7
        (0.0%), b_tok_get_all: 8 (0.1%), b_comp_prob: 2.4 (0.0%), b_tok_touch_all:
        2.5 (0.0%), b_finish: 0.67 (0.0%), tests_pri_0: 168 (1.1%),
        check_dkim_signature: 0.54 (0.0%), check_dkim_adsp: 3.7 (0.0%),
        tests_pri_500: 14812 (98.6%), poll_dns_idle: 14800 (98.5%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via kill() returns wrong values in si_pid and si_uid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Fri, Apr 13, 2018 at 12:53:49PM -0700, Linus Torvalds wrote:
>> On Fri, Apr 13, 2018 at 11:45 AM, Dave Martin <Dave.Martin@arm.com> wrote:
>> >
>> > Most uses I've seen do nothing more than use the FPE_xyz value to
>> > format diagnostic messages while dying.  I struggled to find code that
>> > made a meaningful functional decision based on the value, though that's
>> > not proof...
>> 
>> Yeah. I've seen code that cares about SIGFPE deeply, but it's almost
>> invariably about some emulated environment (eg Java VM, or CPU
>> emulation).
>> 
>> And the siginfo data is basically never good enough for those
>> environments anyway on its own, so they will go and look at the actual
>> instruction that caused the fault and the register state instead,
>> because they need *all* the information.
>> 
>> The cases that use si_code are the ones that just trapped signals in
>> order to give a more helpful abort message.
>> 
>> So I could certainly imagine that si_code is actually used by somebody
>> who then decides to actuall act differently on it, but aside from
>> perhaps printing out a different message, it sounds far-fetched.
>
> Okay, in that case let's just use FPE_FLTINV.  That makes the patch
> easily back-portable for stable kernels.

If we want to I don't think  backporting 266da65e9156 ("signal: Add
FPE_FLTUNK si_code for undiagnosable fp exceptions") would be at
all difficult.

What it is changing has been stable for quite a while.  The surroundings
might change and so it might require some trivial manual fixup but I
don't expect any problems.

Not that I want to derail the consensus but if we want to backport
similar fixes for arm64 or the other architectures that wind up using
FPE_FLTUNK for their fix we would need to backport 266da65e9156 anyway.

Eric
