Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968293AbeEYUCx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:02:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55895 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967698AbeEYUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:02:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, paulmck@linux.vnet.ibm.com
References: <20180525090507.22248-1-anna-maria@linutronix.de>
Date: Fri, 25 May 2018 15:02:41 -0500
In-Reply-To: <20180525090507.22248-1-anna-maria@linutronix.de> (Anna-Maria
        Gleixner's message of "Fri, 25 May 2018 11:05:05 +0200")
Message-ID: <877enrwljy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fMIvK-0007J5-P1;;;mid=<877enrwljy.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19n9PEhn79gKNrwAKXlc7L3RYqVwufFEJc=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Anna-Maria Gleixner <anna-maria@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 139 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.3 (3.1%), b_tie_ro: 1.73 (1.2%), parse: 0.79 (0.6%),
        extract_message_metadata: 12 (8.7%), get_uri_detail_list: 0.91 (0.7%),
        tests_pri_-1000: 7 (5.2%), tests_pri_-950: 1.16 (0.8%), tests_pri_-900: 0.92
        (0.7%), tests_pri_-400: 15 (11.1%), check_bayes: 14 (10.4%), b_tokenize: 4.6
        (3.3%), b_tok_get_all: 4.5 (3.2%), b_comp_prob: 1.54 (1.1%), b_tok_touch_all:
        2.1 (1.5%), b_finish: 0.51 (0.4%), tests_pri_0: 91 (65.7%),
        check_dkim_signature: 0.48 (0.3%), check_dkim_adsp: 2.6 (1.9%),
        tests_pri_500: 3.2 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 0/2] rtmutex wait_lock is irq safe
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anna-Maria Gleixner <anna-maria@linutronix.de> writes:

> Since commit b4abf91047cf ("rtmutex: Make wait_lock irq safe") the rtmutex
> wait_lock is irq safe. Therefore the irqsave/restore in kernel/signal is no
> longer required (see Patch 2/2). During discussions about v1 of this patch,
> Eric Biederman noticed, that there is a no longer valid rcu_read_unlock()
> documentation.
>
> Therefore sending a short queue: fixing first the documentation of
> rcu_read_unlock() and afterwards removing irqsave/restore in
> kernel/signal.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> v1..v2:
>
>  - Add new patch updating rcu documentation as suggested by Eric Biederman
>  - Udpate commit message of kernel/signal patch
>
> Thanks,
>
> 	Anna-Maria
>
>
> Anna-Maria Gleixner (2):
>   rcu: Update documentation of rcu_read_unlock()
>   signal: Remove no longer required irqsave/restore
>
>  include/linux/rcupdate.h |  4 +---
>  kernel/signal.c          | 24 +++++++-----------------
>  2 files changed, 8 insertions(+), 20 deletions(-)
