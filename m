Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeD1OCP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 10:02:15 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:60805 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933484AbeD1OCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 10:02:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linux-Arch <linux-arch@vger.kernel.org>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Richard Weinberger <richard.weinberger@gmail.com>,
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
        <87zi1sd28d.fsf@xmission.com>
        <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
        <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com>
        <87lgdc1bvr.fsf@xmission.com>
        <CAMD8JhxzzCCjo_OLs8wS7ggOh4NqdxeRAGhcvuEJSUZZLO6NDA@mail.gmail.com>
Date: Sat, 28 Apr 2018 09:02:02 -0500
In-Reply-To: <CAMD8JhxzzCCjo_OLs8wS7ggOh4NqdxeRAGhcvuEJSUZZLO6NDA@mail.gmail.com>
        ("Martin \=\?utf-8\?Q\?P\=C3\=A4rtel\=22's\?\= message of "Thu, 26 Apr 2018 02:05:44
 +0300")
Message-ID: <87zi1nctut.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fCQQR-0002AX-5s;;;mid=<87zi1nctut.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.116.237.29;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+nYzD4wqpEwslL7dvQN3NSke5FIcbiUoU=
X-SA-Exim-Connect-IP: 68.116.237.29
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linux-Arch <linux-arch@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 222 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (5.5%), b_tie_ro: 8 (3.8%), parse: 0.95 (0.4%),
        extract_message_metadata: 2.8 (1.3%), get_uri_detail_list: 1.17 (0.5%),
        tests_pri_-1000: 4.1 (1.9%), tests_pri_-950: 1.22 (0.6%), tests_pri_-900:
        0.95 (0.4%), tests_pri_-400: 20 (9.2%), check_bayes: 19 (8.7%), b_tokenize: 6
        (2.8%), b_tok_get_all: 7 (3.0%), b_comp_prob: 2.00 (0.9%), b_tok_touch_all:
        2.5 (1.1%), b_finish: 0.59 (0.3%), tests_pri_0: 166 (75.1%),
        check_dkim_signature: 0.52 (0.2%), check_dkim_adsp: 3.1 (1.4%),
        tests_pri_500: 5 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 0/5] Improving siginfo_layout and fixing uml's relay_signal
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset is a respin of my latest patch to relay_signal for uml.

As I understand relay_signal it very carefully scrubs the signal
information it gets from the host kernel before passing it on.
Basically making certain it recognizes what it is dealing with.

This patchset updates siginfo_layout so that relay_signal and arm64's
force_signal_inject can reliably use it to verify the kind of signal
being processed, by recognizing the specializations of SIL_FAULT as
separate cases.

To make the siginfo_layout changes clean.  signalfd is first brought
into the modern world of using a single copy_to_user, no default case
statement (so gcc will flag missing cases), and handling SIGSYS for
seccomp.

The net is a simpler relay_signal is also more careful about which
signals it relays.

Eric

The changes are also available at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-review3

Eric W. Biederman (5):
      signal/signalfd: Remove __put_user from signalfd_copyinfo
      signal/signalfd: Add support for SIGSYS
      signal: Remove unncessary #ifdef SEGV_PKUERR in 32bit compat code
      signal: Extend siginfo_layout with SIL_FAULT_{MCEERR|BNDERR|PKUERR}
      signal/um: More carefully relay signals in relay_signal.

 arch/um/kernel/trap.c         | 38 ++++++++------------
 fs/signalfd.c                 | 84 +++++++++++++++++++++++++------------------
 include/linux/signal.h        |  3 ++
 include/uapi/linux/signalfd.h |  6 +++-
 kernel/signal.c               | 82 +++++++++++++++++++++++++++---------------
 5 files changed, 125 insertions(+), 88 deletions(-)
