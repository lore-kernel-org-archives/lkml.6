Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756266AbeEARWR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 13:22:17 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53885 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754790AbeEARWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 13:22:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Michal Hocko <mhocko@kernel.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, oleg@redhat.com, viro@zeniv.linux.org.uk,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        riel@redhat.com, tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
        <20180426130700.GP17484@dhcp22.suse.cz> <87efj2q6sq.fsf@xmission.com>
        <20180426192818.GX17484@dhcp22.suse.cz>
        <20180427070848.GA17484@dhcp22.suse.cz> <87r2n01q58.fsf@xmission.com>
Date: Tue, 01 May 2018 12:22:04 -0500
In-Reply-To: <87r2n01q58.fsf@xmission.com> (Eric W. Biederman's message of
        "Fri, 27 Apr 2018 13:05:23 -0500")
Message-ID: <87o9hz2sw3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDYyf-00080K-Tx;;;mid=<87o9hz2sw3.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19wtSI5TP+DbFXdxhoTwi/6wvub8OboKtk=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 205 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.6 (2.2%), b_tie_ro: 3.7 (1.8%), parse: 0.75 (0.4%),
        extract_message_metadata: 12 (5.8%), get_uri_detail_list: 0.81 (0.4%),
        tests_pri_-1000: 7 (3.3%), tests_pri_-950: 1.21 (0.6%), tests_pri_-900: 1.01
        (0.5%), tests_pri_-400: 17 (8.5%), check_bayes: 16 (8.0%), b_tokenize: 5
        (2.6%), b_tok_get_all: 5 (2.6%), b_comp_prob: 1.59 (0.8%), b_tok_touch_all:
        2.5 (1.2%), b_finish: 0.57 (0.3%), tests_pri_0: 150 (73.2%),
        check_dkim_signature: 0.45 (0.2%), check_dkim_adsp: 2.6 (1.3%),
        tests_pri_500: 9 (4.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner() more scalable
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Kirill Tkhai do you think you would be able adapt Michal Hoko's old
> patch at https://marc.info/?l=linux-kernel&m=143635857131756&w=2
> that replaces mm->owner with mm->memcg?

Ouch.  At least compared to the current kernel your patch is wide
of the mark of what is needed to use mm->memcg correctly.

I have however written my own and if someone can review it I would
really appreciate it.  It looks like we can change mm->owner to
mm->memcg without too much trouble and reduce the amount of code
in the kernel at the same time.

Eric
