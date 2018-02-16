Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753284AbeBPTRR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:17:17 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:37897 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeBPTRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:17:13 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, x86@kernel.org, douly.fnst@cn.fujitsu.com,
        joro@8bytes.org, uobergfe@redhat.com, prarit@redhat.com
References: <20180214054656.3780-1-bhe@redhat.com>
        <20180216093836.v6iq32jycy7sxwln@gmail.com>
Date: Fri, 16 Feb 2018 13:16:50 -0600
In-Reply-To: <20180216093836.v6iq32jycy7sxwln@gmail.com> (Ingo Molnar's
        message of "Fri, 16 Feb 2018 10:38:36 +0100")
Message-ID: <87a7w8wxr1.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1emlVP-0005Gy-JH;;;mid=<87a7w8wxr1.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/oVQEypiLHsEG2r7fDfNhqi/HL4yOrjGw=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ingo Molnar <mingo@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 162 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.7 (2.3%), b_tie_ro: 2.7 (1.7%), parse: 1.05 (0.6%),
        extract_message_metadata: 10 (5.8%), get_uri_detail_list: 1.18 (0.7%),
        tests_pri_-1000: 4.8 (2.9%), tests_pri_-950: 1.01 (0.6%), tests_pri_-900:
        0.88 (0.5%), tests_pri_-400: 19 (11.9%), check_bayes: 18 (11.2%), b_tokenize:
        4.3 (2.6%), b_tok_get_all: 6 (3.9%), b_comp_prob: 1.82 (1.1%),
        b_tok_touch_all: 3.7 (2.3%), b_finish: 0.75 (0.5%), tests_pri_0: 116 (71.7%),
        check_dkim_signature: 0.39 (0.2%), check_dkim_adsp: 2.7 (1.7%),
        tests_pri_500: 3.2 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5 0/6] x86/apic: Fix restoring boot irq mode in reboot and kexec/kdump
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> * Baoquan He <bhe@redhat.com> wrote:
>
>> This is v5 post. Newly added patch 0002 includes the change
>> related to KEXEC_JUMP path. Patch 0003 only includes the
>> regression fix.
>> 
>> A regression bug was introduced in below commit.
>> commit 522e66464467 ("x86/apic: Disable I/O APIC before shutdown of the local APIC")
>> 
>> It caused the action to fail that we try to restore boot irq mode
>> in reboot and kexec/kdump. Details can be seen in patch 0003.
>> 
>> Warning can always be seen during kdump kernel boot on qemu/kvm
>> platform. Our customer even saw casual kdump kernel hang once in
>> ~30 attempts during stress testing of kdump on KVM machine.
>> 
>> v4->v5:
>>   Take out the change related to KEXEC_JUMP to a new patch 0002
>>   according to Eric's suggestion.
>>   Patch 0003 in this series only includes the regression fix.
>> 
>> v3->v4:
>>   Eric pointed out that in patch 0002 the change related to
>>   KEXEC_JUMP is not right.
>>   Correct it.
>> 
>>   Add Fixes tag and Cc to stable.
>
> Eric, are these patches looking good to you now?

The result of applying the patches looks good.
Barring whatever fix to header files that kbuild seems to find necessary.

I wish patches 1 2 and 4 were all the same patch.  That I think would
make reading the patches a bit easier, and make the backports clearer.
But at this point that is just me bike-shedding.

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric
