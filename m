Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933394AbeBVRKy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:10:54 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36834 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933148AbeBVRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:10:52 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Luck\, Tony" <tony.luck@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi\@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, "Andy Lutomirski" <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
References: <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
        <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
        <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com>
        <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
        <CA+55aFx4Q7AzCM5mDwga6_LteNUBWQsT6nKJMjn8JcriS3ExuQ@mail.gmail.com>
        <20180221182104.GI3231@tassilo.jf.intel.com>
        <20180221194731.t7jowrmicvaggu3x@agluck-desk>
        <CA+55aFzy89V13rSxGQy77Bb08qpUpH+J=trcjooKQhsAFbgrVw@mail.gmail.com>
        <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
        <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com>
        <20180222014505.2l76ccrrs36y3b26@agluck-desk>
        <CA+55aFzJXsPcsJ5MtsxTp2n+43xC0yGzANLNcDm1mFbZKR75FQ@mail.gmail.com>
        <3908561D78D1C84285E8C5FCA982C28F7B37FE28@ORSMSX110.amr.corp.intel.com>
Date: Thu, 22 Feb 2018 11:10:22 -0600
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7B37FE28@ORSMSX110.amr.corp.intel.com>
        (Tony Luck's message of "Thu, 22 Feb 2018 05:34:01 +0000")
Message-ID: <87efld9cht.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eouOQ-0002ZY-8o;;;mid=<87efld9cht.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+SH4lVWd+sdbEzi/x8Cr0Pa0VcasA5iVs=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4950]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Luck\, Tony" <tony.luck@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 188 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (1.5%), b_tie_ro: 1.89 (1.0%), parse: 0.76 (0.4%),
        extract_message_metadata: 9 (5.1%), get_uri_detail_list: 0.79 (0.4%),
        tests_pri_-1000: 5.0 (2.6%), tests_pri_-950: 1.17 (0.6%), tests_pri_-900:
        0.99 (0.5%), tests_pri_-400: 31 (16.5%), check_bayes: 30 (15.9%), b_tokenize:
        6 (2.9%), b_tok_get_all: 14 (7.4%), b_comp_prob: 1.70 (0.9%),
        b_tok_touch_all: 7 (3.8%), b_finish: 0.52 (0.3%), tests_pri_0: 129 (68.7%),
        check_dkim_signature: 0.46 (0.2%), check_dkim_adsp: 2.7 (1.5%),
        tests_pri_500: 5 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] efivarfs: Limit the rate for non-root to read files
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:

>>  - add a per-user mutex, and do the usleep inside of it, so that
>> anybody who tries to do a thousand threads will just be serialized by
>> the mutex.
>>
>> Note that the mutex needs to be per-user, because otherwise it will be
>> a DoS for the other users.
>
> I can try that tomorrow (adding the per-user mutex to struct user_struct
> right next to the ratelimit I added.

Another possibility is to cache the files in the page cache.  That will
reduce re-reads of the same data to the maximum extent.

If efi has a chance of changing variables behind our back we might want
something that would have a timeout on how long the data is cached,
and we probably want to make the caching policy write-trough not
write-back.

I just suggest this as it seems like a much more tried and true solution.

Eric
