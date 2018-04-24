Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeDXW0J convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:26:09 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:54171 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeDXW0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:26:07 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Martin =?utf-8?Q?P=C3=A4rtel?= <martin.partel@gmail.com>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        "user-mode-linux-devel\@lists.sourceforge.net"
        <user-mode-linux-devel@lists.sourceforge.net>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-19-ebiederm@xmission.com>
        <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
        <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
        <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk>
        <87zi1sd28d.fsf@xmission.com>
        <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
        <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com>
Date: Tue, 24 Apr 2018 17:24:24 -0500
In-Reply-To: <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com>
        ("Martin \=\?utf-8\?Q\?P\=C3\=A4rtel\=22's\?\= message of "Wed, 25 Apr 2018 01:03:39
 +0300")
Message-ID: <87lgdc1bvr.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fB6Nh-0001uW-Nf;;;mid=<87lgdc1bvr.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19uq1K7yJ3MRBvhQaRwx8jUfsVdQspXcvw=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4964]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?***;Martin P=c3=a4rtel <martin.partel@gmail.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 453 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.7%), b_tie_ro: 1.97 (0.4%), parse: 1.37 (0.3%),
        extract_message_metadata: 26 (5.7%), get_uri_detail_list: 2.2 (0.5%),
        tests_pri_-1000: 9 (2.0%), tests_pri_-950: 2.0 (0.5%), tests_pri_-900: 1.67
        (0.4%), tests_pri_-400: 32 (7.0%), check_bayes: 30 (6.6%), b_tokenize: 11
        (2.4%), b_tok_get_all: 10 (2.1%), b_comp_prob: 3.9 (0.9%), b_tok_touch_all:
        2.2 (0.5%), b_finish: 0.75 (0.2%), tests_pri_0: 365 (80.6%),
        check_dkim_signature: 0.87 (0.2%), check_dkim_adsp: 4.6 (1.0%),
        tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault in relay_signal.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Pärtel <martin.partel@gmail.com> writes:

> And once more in plain text..
>
> On 25 April 2018 at 01:00, Martin Pärtel <martin.partel@gmail.com> wrote:
>>
>> Hi all,
>>
>> This was ages ago, but from what I remember...
>>
>>>
>>> Having a second look I really don't understand what relay_signal is
>>> trying to do.
>>>
>>> The function relay_signal does not pass siginfo through unchanged.
>>
>>
>> Just copying the entire struct would do the wrong thing. It was discussed here:
>> https://marc.info/?l=user-mode-linux-devel&m=133910707911999&w=2

So you are regnerating siginfo to ensure you don't copy unintended
things such as the host pid and host uid.

Then my analysis is correct that you simply missed filtering out the
si codes that are not signal specific and do not use the fault layout
in struct siginfo.

Is si_addr safe to copy across?  I presume so since the kernel just
ptraces an ordinary process, but I figure I should ask and double
check.

I am going to respin my patch.  I would say that you really need a
white-list of si_codes that whose use of struct siginfo that you know.
Otherwise you could get into the same problem of under or over copying
data.

Eric
