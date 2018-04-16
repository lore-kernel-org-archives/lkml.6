Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDPCE6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 22:04:58 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:58706 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeDPCE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 22:04:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Martin <Dave.Martin@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>
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
        <87604sa2fu.fsf_-_@xmission.com>
        <CA+55aFw1gmfFH1o+oWMo4TnU5hEczAOiY1g=eMxqYZmy9JqDYw@mail.gmail.com>
Date: Sun, 15 Apr 2018 21:03:32 -0500
In-Reply-To: <CA+55aFw1gmfFH1o+oWMo4TnU5hEczAOiY1g=eMxqYZmy9JqDYw@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 15 Apr 2018 11:16:04 -0700")
Message-ID: <87tvsb29hn.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f7tVj-0004MV-BU;;;mid=<87tvsb29hn.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+uaGOegFSuCVxCTY932rKhox54BqYRiSo=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 296 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.1 (1.0%), b_tie_ro: 2.1 (0.7%), parse: 1.15 (0.4%),
        extract_message_metadata: 16 (5.3%), get_uri_detail_list: 3.4 (1.2%),
        tests_pri_-1000: 7 (2.3%), tests_pri_-950: 1.17 (0.4%), tests_pri_-900: 0.96
        (0.3%), tests_pri_-400: 25 (8.6%), check_bayes: 24 (8.2%), b_tokenize: 8
        (2.8%), b_tok_get_all: 9 (3.0%), b_comp_prob: 2.5 (0.9%), b_tok_touch_all:
        2.6 (0.9%), b_finish: 0.64 (0.2%), tests_pri_0: 229 (77.2%),
        check_dkim_signature: 0.48 (0.2%), check_dkim_adsp: 2.5 (0.8%),
        tests_pri_500: 11 (3.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/3] Dealing with the aliases of SI_USER
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> (
>
> On Sun, Apr 15, 2018 at 8:56 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Would you consider the patchset below for -rc2?
>
> Ugh.

The point of this series is to squash the potential for regressions even
from the weird broken code that fills in fields for si_code 0 that do
not match SI_USER.

The copy_siginfo_to_user32 never handled that so we don't need to worry
about that.  All of the signals that abuse si_code 0 go through
force_sig_info so signalfd can not catch them.  Which means that only
copy_siginfo_to_user needs to be worried about.

Last time I was benchmarking I could not see a difference between
copying the entire siginfo and only a small part so I don't see
the point of optimizing now.

For an actual cleanup I intend to go farther than you are proposing and
convert everthing to the set of helper functions I have added to
kernel/signal.c force_sig_fault, force_sig_mceerr, force_sig_bnderr,
force_sig_pkuerr.

When I am done there will be maybe 5 instances of clear_siginfo outside
of those helper functions.  At which point I won't care if we remove
clear_siginfo and just use memset.  That is a real improvement
that looks something like: "105 files changed, 933 insertions(+), 1698 deletions(-)"
That is my end goal with all of this.

You complained to me about regressions and you are right with the
current handling of FPE_FIXME TRAP_FIXME the code is not bug compatible
with old versions of linux, and people have noticed.

What this patchset represents is the bare minimum needed to convert
copy_siginfo_to_user to a copy_to_user, and remove the possibility
of regressions.

To that end I need to ensure every struct siginfo in the entire
kernel is memset to 0.  A structure initializer is absolutely
not enough.  So I don't mind people thinking clear_siginfo is necessary.


To that end clear_siginfo where it does not take the size of
struct siginfo as a parameter is much less suceptible to typos,
and allows me to ensure every instance of struct siginfo is fully
initialized.

I fully intend to remove practically every instance of struct siginfo
from the architecture specific code, and use the aforementioned helpers.
The trouble is that some of the architecture code need refactoring
for that to happen.  Even your proposed init_siginfo can't be widely
used as a common pattern is to fill in siginfo partially in the
code with si_code and si_signo being filled in almost last.

So in short.  I intend to remove most of these clear_siginfo calls when
I remove the siginfos later.  This series is focused on making
copy_siginfo_to_user simple enough we don't need to use siginfo_layout,
and thus can be fully backwards compatibile with ourselves and we won't
need to worry about regressions.  I have aimed to keep this simple
enough we can merge this after -rc1 because we don't want regressions.

Eric

ps.  I intend to place this change first in my series wether or not it makes
it into -rc2 so that I can be certain we remove any possible regressions
in behavior on the buggy architectures.  Then I can take my time and
ensure the non-trivial changes of refactoring etc are done carefully so
I don't introduce other bugs.  I need that so I can sleep at night.

pps.  I can look at some of your other suggestions but cleverness leads
to regressions, and if you are going to complain at me harshly when I
have been being careful and taking things seriously I am not
particularly willing to take unnecessary chances.
