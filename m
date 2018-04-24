Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeDXQBS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:01:18 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56746 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeDXQBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:01:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        "user-mode-linux-devel\@lists.sourceforge.net"
        <user-mode-linux-devel@lists.sourceforge.net>,
        Martin =?utf-8?Q?P=C3=A4rt?= =?utf-8?Q?el?=
        <martin.partel@gmail.com>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-19-ebiederm@xmission.com>
        <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
        <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
        <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk>
Date: Tue, 24 Apr 2018 10:59:46 -0500
In-Reply-To: <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk> (Anton
        Ivanov's message of "Tue, 24 Apr 2018 09:44:22 +0100")
Message-ID: <87zi1sd28d.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fB0NS-0000Bv-O6;;;mid=<87zi1sd28d.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18VamTEaFU8HzLG2p9SQADmzQojk8/yrCU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4918]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 492 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 4.3 (0.9%), b_tie_ro: 3.1 (0.6%), parse: 1.82 (0.4%),
        extract_message_metadata: 23 (4.7%), get_uri_detail_list: 2.9 (0.6%),
        tests_pri_-1000: 9 (1.9%), tests_pri_-950: 1.95 (0.4%), tests_pri_-900: 1.60
        (0.3%), tests_pri_-400: 29 (5.9%), check_bayes: 28 (5.6%), b_tokenize: 10
        (2.1%), b_tok_get_all: 9 (1.8%), b_comp_prob: 3.4 (0.7%), b_tok_touch_all:
        2.8 (0.6%), b_finish: 0.78 (0.2%), tests_pri_0: 410 (83.3%),
        check_dkim_signature: 0.70 (0.1%), check_dkim_adsp: 4.1 (0.8%),
        tests_pri_500: 6 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault in relay_signal.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh I should have Cc'd Martin Partel as well as this bit is his
original code.

Anton Ivanov <anton.ivanov@kot-begemot.co.uk> writes:

> Hi Richard,
>
> There was a post to uml-devel during the days when the sourceforge mailing list
> was working in random drop mode which claimed that "this fixes the arm build".
>
> I have not kept it locally and I do not see it the archive (I do not see a few
> other posts there either - including some of mine).
>
> The joys of having a broken list :(
>
> Whoever posted it, if you are reading it, please re-post again so we can have a
> look.
>
> In the meantime we are as you said - x86 only.

The only case I can see my changed relay_signal affecting on arm is the
nasty hach where errno is set in conjunction with trap_trace.

Having a second look I really don't understand what relay_signal is
trying to do.

The function relay_signal does not pass siginfo through unchanged.
The function relay_signal does not handle cases where si_code is
not SI_USER or SI_KERNEL, or any of the other signal independent
si_codes.

In my change I believe I have preserved the character of relay_signal of
just passing through the fault.

Still even after reading the commit that upgraded relay_signal to
preserve si_code and si_addr I really don't understand the intended
logic.

Am I missing something subtle or have the subtle details of siginfo just
always been ignored?

commit d3c1cfcdb43e023ab1b1c7a555cd9e929026500a
Author: Martin Pärtel <martin.partel@gmail.com>
Date:   Thu Aug 2 00:49:17 2012 +0200

    um: pass siginfo to guest process
    
    UML guest processes now get correct siginfo_t for SIGTRAP, SIGFPE,
    SIGILL and SIGBUS. Specifically, si_addr and si_code are now correct
    where previously they were si_addr = NULL and si_code = 128.
    
    Signed-off-by: Martin Pärtel <martin.partel@gmail.com>
    Signed-off-by: Richard Weinberger <richard@nod.at>

Eric
