Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeCPVJq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 17:09:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44039 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbeCPVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 17:09:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Ram Pai <linuxram@us.ibm.com>
References: <87k1wimybi.fsf_-_@xmission.com>
        <20180116004009.31036-13-ebiederm@xmission.com>
        <29eb3438-0891-36ee-e5f6-36e26ccf2b89@intel.com>
        <818f8945-f990-a770-476e-f82bdc77dbda@intel.com>
        <87efkjeqe8.fsf@xmission.com>
        <ccd9afa6-15d1-3e41-c1a4-3352d09c37a4@intel.com>
Date: Fri, 16 Mar 2018 16:08:49 -0500
In-Reply-To: <ccd9afa6-15d1-3e41-c1a4-3352d09c37a4@intel.com> (Dave Hansen's
        message of "Fri, 16 Mar 2018 13:33:16 -0700")
Message-ID: <87k1ubbue6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ewwbb-0004L8-AG;;;mid=<87k1ubbue6.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+gIuJFDcN8ZDXqyA+b80MdmTR4JoY5fcY=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4993]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Dave Hansen <dave.hansen@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 168 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.0 (1.8%), b_tie_ro: 2.1 (1.3%), parse: 0.75 (0.4%),
        extract_message_metadata: 10 (5.7%), get_uri_detail_list: 0.92 (0.5%),
        tests_pri_-1000: 4.8 (2.9%), tests_pri_-950: 1.21 (0.7%), tests_pri_-900:
        0.98 (0.6%), tests_pri_-400: 20 (11.8%), check_bayes: 19 (11.1%), b_tokenize:
        5 (3.0%), b_tok_get_all: 6 (3.5%), b_comp_prob: 2.7 (1.6%), b_tok_touch_all:
        2.8 (1.7%), b_finish: 0.70 (0.4%), tests_pri_0: 121 (72.0%),
        check_dkim_signature: 0.44 (0.3%), check_dkim_adsp: 2.6 (1.5%),
        tests_pri_500: 4.0 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 13/22] signal: Move addr_lsb into the _sigfault union for clarity
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 03/16/2018 01:06 PM, Eric W. Biederman wrote:
>>> It does not revert cleanly so I reverted it manually.  Patch doing that
>>> is attached.  Should we do this, or is there a better option?
>> Please see:
>> 859d880cf544 ("signal: Correct the offset of si_pkey in struct siginfo")
>
> It would be really nice to actually cc the folks that wrote and maintain
> the code when you both break their stuff and fix it.  I don't see myself
> or the x86 maintainers cc'd on any of this: the patch that caused the
> breakage *or* the fix.

What I touched was in no way x86 or pkey specific code. The email alias
for all of the arch maintainers in the kernel is called linux-arch.  It
is hard to find who cares bits of essentially unmaintained code in the
kernel.

The fix was merged via the usual process and is available to everyone,
and is not hard to find.  It was labeled with an appropriate fixes tag.

I was also very careful to ensure that I fixed the regression I
accidentally introduced and did not introduce another ABI regression
with any other field:
 f6a015498dca ("signal/x86: Include the field offsets in the build time checks")

Eric
