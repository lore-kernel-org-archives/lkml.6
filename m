Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932443AbeCOSIu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:08:50 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41659 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbeCOSIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:08:48 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314144614.1632190-1-arnd@arndb.de>
        <20180314144614.1632190-2-arnd@arndb.de> <87po45hcuy.fsf@xmission.com>
        <CAK8P3a1GL2N=emTbSgNGHxOrXtG6BxqRGMg00-tZqKg6-0O5=w@mail.gmail.com>
        <87o9jpbmcy.fsf@xmission.com>
        <CAK8P3a2ii0aQ6sSB_B_KeMWw51Y8mbX0eL6EPj5fQ8b8bJqmUQ@mail.gmail.com>
Date: Thu, 15 Mar 2018 13:07:59 -0500
In-Reply-To: <CAK8P3a2ii0aQ6sSB_B_KeMWw51Y8mbX0eL6EPj5fQ8b8bJqmUQ@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 15 Mar 2018 13:50:36 +0100")
Message-ID: <87fu51b4ao.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ewXJ1-0006jq-5F;;;mid=<87fu51b4ao.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19hfrlNNPRlbDORUUX5RylIzV4CfdUX42k=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 238 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 5 (2.2%), b_tie_ro: 3.6 (1.5%), parse: 0.77 (0.3%),
        extract_message_metadata: 13 (5.3%), get_uri_detail_list: 1.69 (0.7%),
        tests_pri_-1000: 7 (3.1%), tests_pri_-950: 1.25 (0.5%), tests_pri_-900: 0.94
        (0.4%), tests_pri_-400: 21 (8.8%), check_bayes: 20 (8.4%), b_tokenize: 7
        (2.7%), b_tok_get_all: 7 (3.0%), b_comp_prob: 2.2 (0.9%), b_tok_touch_all:
        2.1 (0.9%), b_finish: 0.57 (0.2%), tests_pri_0: 183 (76.7%),
        check_dkim_signature: 0.48 (0.2%), check_dkim_adsp: 2.6 (1.1%),
        tests_pri_500: 3.9 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thu, Mar 15, 2018 at 12:37 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>> On Thu, Mar 15, 2018 at 11:06 AM, Eric W. Biederman
>
>>> That seems reasonable. If you send me a patch with a proper
>>> changelog (I don't think I could explain this well enough), I'll
>>> add it to the series.
>>
>> I just realized you can also remove the #ifdefs for BUS_MCEERR_AR,
>> BUS_MCEERR_AO, and SEGV_BNDERR.  As those si_codes are now always
>> defined.  That description I expect you can handle.
>
> My existing patch already does this, and I've added a note to the changelog
> as well now.

I did not see the changes to kernel/signal.c and fs/signalfd.c that
remove the #ifdef BUS_MCERR_AR etc.  Did I miss that patch.

>> For a description of the above change how does this sound?
>>
>> Unlike system call numbers the assignment of si_codes has never had a
>> reason to be made per architecture.  Some architectures have had unique
>> conditions to report and reporting those conditions needed new si_codes.
>> Nothing has ever needed si_codes to have different values on different
>> architectures.  The si_code space is vast so even with defining all
>> si_codes on all architectures there is no danger in running out of
>> si_code values.
>>
>> The history of the si_codes BUS_MCEERR_AR, BUS_MCEER_AO, SEGV_BNDERR,
>> and SEGV_PKUERR show that a need of one architecture frequently becomes
>> a need of another architecture which makes sharing si_codes between
>> architectures a positive benefit and something to be encouraged.
>>
>> Where there are no conflicts with the historical ia64 arch specific
>> si_codes and any other si_codes make them generic si_codes.  We might
>> need them on another architecture someday.
>>
>> This leaves only the good example of arch generic si_codes in the kernel
>> for future architectures and architecture enhancments to follow.
>> Without bad examples to follow it should be easy to avoid the mistakes
>> of the past.
>
> Ok, done. I've listed you as 'Suggested-by' for that patch. Since the
> changelog is way more work than the actual change, I would have
> made you the author of that patch, but I don't have a Signed-off-by
> from you for it.

For however much it helps.

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric
