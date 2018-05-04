Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeEDRRc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:17:32 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41814 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeEDRRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:17:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
References: <20180504144014.5378-1-bigeasy@linutronix.de>
        <87fu37e4rn.fsf@xmission.com>
        <20180504170459.624e7vkro5fn2bgw@linutronix.de>
Date: Fri, 04 May 2018 12:17:20 -0500
In-Reply-To: <20180504170459.624e7vkro5fn2bgw@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Fri, 4 May 2018 19:04:59 +0200")
Message-ID: <876043e3xb.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fEeKl-0000Tk-Ls;;;mid=<876043e3xb.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Hjuk68r2ezMLUBkfqV18GwM640o37nGQ=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4808]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 137 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.4 (1.8%), b_tie_ro: 1.67 (1.2%), parse: 0.74 (0.5%),
        extract_message_metadata: 9 (6.5%), get_uri_detail_list: 0.78 (0.6%),
        tests_pri_-1000: 5 (3.9%), tests_pri_-950: 1.08 (0.8%), tests_pri_-900: 0.91
        (0.7%), tests_pri_-400: 17 (12.2%), check_bayes: 16 (11.5%), b_tokenize: 4.3
        (3.1%), b_tok_get_all: 4.9 (3.6%), b_comp_prob: 1.38 (1.0%), b_tok_touch_all:
        3.7 (2.7%), b_finish: 0.52 (0.4%), tests_pri_0: 95 (69.3%),
        check_dkim_signature: 0.43 (0.3%), check_dkim_adsp: 3.7 (2.7%),
        tests_pri_500: 3.4 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kernel/signal: Remove no longer required irqsave/restore
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2018-05-04 11:59:08 [-0500], Eric W. Biederman wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> > From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> …
>> > This long-term fix has been made in commit 4abf91047cf ("rtmutex: Make >
>> > wait_lock irq safe") for different reason.
>> 
>> Which tree has this change been made in?  I am not finding the commit
>> you mention above in Linus's tree.
>
> I'm sorry, it should have been commit b4abf91047cf ("rtmutex: Make
> wait_lock irq safe").

Can you fix that in your patch description and can you also up the
description of rcu_read_unlock?

If we don't need to jump through hoops it looks very reasonable to
remove this unnecessary logic.  But we should fix the description
in rcu_read_unlock that still says we need these hoops.

Eric
