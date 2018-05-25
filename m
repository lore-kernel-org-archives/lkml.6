Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968214AbeEYUA1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:00:27 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47114 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967858AbeEYUA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:00:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Dave Young <dyoung@redhat.com>, dzickus@redhat.com,
        Neil Horman <nhorman@redhat.com>, Tony Luck <tony.luck@intel.com>,
        bhe@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
        <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
        <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
        <877enucqr0.fsf@xmission.com>
        <20180523222236.5a96732e@ezekiel.suse.cz>
        <20180524014905.GB2031@dhcp-128-65.nay.redhat.com>
        <20180524085708.31aa311d@ezekiel.suse.cz>
        <87k1rt3tdu.fsf@xmission.com>
        <20180525065943.03bcb911@ezekiel.suse.cz>
Date: Fri, 25 May 2018 15:00:13 -0500
In-Reply-To: <20180525065943.03bcb911@ezekiel.suse.cz> (Petr Tesarik's message
        of "Fri, 25 May 2018 06:59:43 +0200")
Message-ID: <87d0xjwlo2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fMIsx-00062Z-96;;;mid=<87d0xjwlo2.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18bHhnQsqFjfCBp6MC/X/zQCyYv0kSf2AU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Petr Tesarik <ptesarik@suse.cz>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1043 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.4 (0.2%), b_tie_ro: 1.69 (0.2%), parse: 0.82 (0.1%),
        extract_message_metadata: 14 (1.4%), get_uri_detail_list: 2.6 (0.3%),
        tests_pri_-1000: 8 (0.8%), tests_pri_-950: 0.99 (0.1%), tests_pri_-900: 0.81
        (0.1%), tests_pri_-400: 30 (2.9%), check_bayes: 29 (2.8%), b_tokenize: 9
        (0.9%), b_tok_get_all: 11 (1.1%), b_comp_prob: 3.1 (0.3%), b_tok_touch_all:
        3.3 (0.3%), b_finish: 0.55 (0.1%), tests_pri_0: 293 (28.1%),
        check_dkim_signature: 0.49 (0.0%), check_dkim_adsp: 3.6 (0.3%),
        tests_pri_500: 691 (66.2%), poll_dns_idle: 686 (65.8%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config options
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Tesarik <ptesarik@suse.cz> writes:

> V Thu, 24 May 2018 11:34:05 -0500
> ebiederm@xmission.com (Eric W. Biederman) napsáno:
>
>> Petr Tesarik <ptesarik@suse.cz> writes:
>> 
>> 2> On Thu, 24 May 2018 09:49:05 +0800
>> > Dave Young <dyoung@redhat.com> wrote:
>> >  
>> >> Hi Petr,
>> >> 
>> >> On 05/23/18 at 10:22pm, Petr Tesarik wrote:
>> >>[...]  
>> >> > In short, if one size fits none, what good is it to hardcode that "one
>> >> > size" into the kernel image?    
>> >> 
>> >> I agreed with all the things that we can not know the exact memory
>> >> requirement for 100% use cases.  But that does not means this is useless
>> >> it is still useful for common use cases of no special and memory hog
>> >> requirements as I mentioned in another reply it can simplify the kdump
>> >> deployment for those people who do not need the special setup.  
>> >
>> > I still tend to disagree. This "common-case" reservation depends on
>> > things that are defined by user space. It surely does not make it
>> > easier to build a distribution kernel. Today, I get bug reports that
>> > the number calculated and added to the boot loader configuration by the
>> > installer is inaccurate. If I put a fixed number into a kernel config
>> > option, I will start getting bugs that this number is incorrect (for
>> > some systems).
>> >  
>> >> For example, if this is a workstation I just want to break into a shell
>> >> to collect some panic info, then I just need a very minimal initrd, then
>> >> the Kconfig will work just fine.  
>> >
>> > What is "a very minimal initrd"? Last time I had to make a significant
>> > adjustment to the estimation for openSUSE, this was caused by growing
>> > user-space requirements (systemd in this case, but I don't want to
>> > start flamewars on that topic, please).
>> >
>> > Anyway, if you want to improve the "common case", then look how IBM
>> > tries to solve it for firmware-assisted dump (fadump) on powerpc:
>> >
>> > https://patchwork.ozlabs.org/patch/905026/
>> >
>> > The main idea is:
>> >  
>> >> Instead of setting aside a significant chunk of memory nobody can use,
>> >> [...] reserve a significant chunk of memory that the kernel is prevented
>> >> from using [...], but applications are free to use it.  
>> >
>> > That works great, because user space pages are filtered out in the
>> > common case, so they can be used freely by the panic kernel.  
>> 
>> They absolutely can not be used in the kdump case.
>> 
>> The kdump requirement is that they are pages no-one initiates any I/O
>> to.  To avoid the problem of devices doing DMA as the new kernel starts
>> and runs.
>
> Good point. This means that memory reserved for this purpose would also
> have to be excluded from allocations that may be eventually used for
> DMA transfers.

Think of a network card.  The DMA's for incomming packets can be
indefinitely delayed into the future unless that network card is
reprogrammed.  If the dump kernel does not load the driver that won't
happen.

>>  Secondarily to avoid problems with cpus that refused to halt.
>
> Let's face it - if some CPUs refused to halt, all bets are off. The
> code running on such a CPU can break many other things besides memory,
> most importantly, it may meddle with the HW registers of crucial
> devices in the system. To be less abstract, I have seen a failure to
> stop a CPU in the crashed kernel a few times, and the panic kernel
> could never successfully save anything; it always crashed at boot or a
> little bit later.

Crashing at boot is comparatively good.  That is part of the design
criteria.  It is better to fail to startup the kernel than to start a
corrupted kernel and mangle a users data.

But I do see how it can be a crap shoot when dealing with another cpu.

The ultimate point is that the absolute best we can do is to run a
kernel in memory that we never use for anything else and then we have a
fighting chance of getting the system working and getting a report of
the failure out to somewhere.

> Anyway, of course we would still have to keep the current method,
> because user pages are not always filtered. For example, a major SUSE
> account runs a database in user space and also inspects its data
> structures in case of a system crash.

And I understand the memory pressures that will encourage people to use
user pages for extra memory to run the dump capture kernel in.  Short of
the presence of an IOMMU that all DMA transfers must go through I don't
see how those user pages could reliably be used.

Eric
