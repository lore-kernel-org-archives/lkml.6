Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF19C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF502082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF502082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbeJ2T0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:26:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35996 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbeJ2T0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:26:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id h192so5614341lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oz0bOBzo1adPomk6/E84+d+HjR2QeJSmj4cQcIa3p1o=;
        b=TB2OGCP5sEHYTqVbQF6K0NygqVhUpF/HFHI1r7RWIMI49ZTKxHWlgVt0IGIqCJhqGy
         lv513oYYTI8DsWhm43JkKdbe8Ft77WU5O/CNOgfOeoRwGbItDQlJ/0SHUFkWnK6Etnts
         eHP2xhZWH5e7rtIishiEIdcv5HeNtLpabGTWzfjPMR/IsRfEEGhVIXnbpsaAfihgylhj
         SVZY+yl9OpLjsgxHfU8SshM3jfXdgbjX8VjNyz+t8e3mspr+lGREOsfBGommguuWCxor
         8vjaG6DKeq1inHwdDwJBGuZFbPtbUKZ8cZGxTa1Hhn7T/HAsXhqLVLUuX/NXw+ZVuwzY
         s4Lg==
X-Gm-Message-State: AGRZ1gJgN57FhypDOTR4cR5a837n+spEUx/QddYcIkgZM3bciHDSVip4
        V8RiFZPkIVzfkyQ7S/AIrEC6Gha8TT1ZJfGyIFeajA==
X-Google-Smtp-Source: AJdET5ePhZ8ZQjsHAqyHXtjjPDOOxaI6kSBOwWijc+89tGzXDd/f2WC9NYwtv6gD821oHfTEddRFX3dITjn3/80ix70=
X-Received: by 2002:a19:750a:: with SMTP id y10mr7642955lfe.43.1540809489269;
 Mon, 29 Oct 2018 03:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <1540593788-28181-1-git-send-email-bhsharma@redhat.com> <20181027100241.GB1884@MiWiFi-R3L-srv>
In-Reply-To: <20181027100241.GB1884@MiWiFi-R3L-srv>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Mon, 29 Oct 2018 16:07:53 +0530
Message-ID: <CACi5LpPf9Zr1beowRNGmLZY7DtS3JDt8D=FONjqas9yo7TyCjg@mail.gmail.com>
Subject: Re: [PATCH] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>, x86@kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

Thanks a lot for your review.
Please see my comments in-line:

On Sat, Oct 27, 2018 at 3:32 PM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Bhupesh,
>
> Sorry for top posting. Because I don't know which line at below I should
> add comment into.
>
> So could you plese tell what problem you have met in user space tools?
> Which user space tool is broken so that we need export 'page_offset_base'
> to vmcoreinfo?

I am sorry, I understand that the commit log is a bit long and
probably this part
is not easy to infer. Currently, I see that the 'makedumpfile' utility
is broken with newer kernels
(I tested on 4.19-rc8+) as we KCORE_REMAP  was added to recent kernels
thus leading to an additional section in kcore.
[see <http://lists.infradead.org/pipermail/kexec/2018-October/021769.html>
for details].

The details of the makedumpfile utility can be seen via the man page
[MAKEDUMPFILE(8)],
but in short it tries to make a small DUMPFILE by compressing dump
data or by excluding
unnecessary pages for analysis, or both.

However the bigger problem is how we export machine specific details
from kernel-space
to user-land in a standardized way. As I mentioned in brief in the git
log, I was seeing
issues when I upgrade kernels or try to bring up user-space utilities
on newer hardware,
as currently we use different (and often flaky approaches) to
calculate machine specific details in
user-space code as there used to be lack of a clear ABI between the
kernel and user-space on how
machine specific details would be shared.

Later on, kernel commit 23c85094fe1895caefdd came, which adds
vmcoreinfo to 'kcore',
as an arch agnostic approach to unify the differences existing in
exporting kernel space information
to the user-space code and James suggested that I use the same for
user-space purposes to fix
the issues I was observing.

> Sorry I didn't get what problem this patch is trying to fix from the
> patch log.

So, here since the 'page_offset_base' variable (which holds the start
of direct mapping of all physical
memory) is not exported by the x86_64 kernel to the user-space via a
standard interface, we resort
to calculating the same via reading PT_LOADs in user-space (as an
example from the makedumpfile
implementation ). Now this implementation is usually different across
user-space utilities.

Also, if the PT_LOAD ordering changes (as we saw with the newer
kernels), this approach will need
fixing to calculate the addresses. In addition, we normally need
'page_offset_base' value in user-space (and retrieve it via
vmlinux file in another user case from the same makedumpfile code) for
calculating the start of direct mapping of all physical
memory specifically for KASLR boot cases.

Instead, if we can export 'page_offset_base' via vmcoreinfo, we can
easily use the same
for live-debugging a running kernel via user-space utilities, which
can benefit by reading this value
from the vmcoreinfo note inside kcore directly without relying on other methods.

The x86_64 kernel code ('arch/x86/kernel/head64.c'), already sets the same as:
unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;

and also uses the same to indicate the base of KASLR regions on x86_64:
static __initdata struct kaslr_memory_region {
    unsigned long *base;
    unsigned long size_tb;
} kaslr_regions[] = {
    { &page_offset_base, 0 },

so it can be used for both the above purposes across user-space utilities.

Hope this explains the intention behind this patch.

Thanks,
Bhupesh

> About this, I have replied to you in
> lkml.kernel.org/r/20181025063446.GD2120@MiWiFi-R3L-srv
> You might miss it.
>
> About this exporting, I ever posted patch to upstream and we have had
> discussion, please check
> https://lore.kernel.org/patchwork/patch/723472/
>
> In makedumpfile and crash, we have had a clear method to analyze and
> deduce it from kcore or vmcore.
>
> Thanks
> Baoquan
>
> On 10/27/18 at 04:13am, Bhupesh Sharma wrote:
> > Since commit 23c85094fe1895caefdd
> > ["proc/kcore: add vmcoreinfo note to /proc/kcore"]), '/proc/kcore'
> > contains a new PT_NOTE which carries the VMCOREINFO information.
> >
> > If the same is available, one can use it in user-land to
> > retrieve machine specific symbols or strings being appended to the
> > vmcoreinfo even for live-debugging of the primary kernel as a
> > standard interface exposed by kernel for sharing machine specific
> > details with the user-land.
> >
> > In the past I had a discussion with James, where he suggested this
> > approach (please see [0]) and I really liked the idea. Since then I
> > have been working on unifying the implementations of
> > (atleast) the commonly used user-space utilities that provide
> > live-debugging capabilities (tools like 'makedumpfile' and
> > 'crash-utility', see [1] for details of these tools).
> >
> > For the same, when live debugging on x86_64 machines, user-space
> > tools currently rely on different mechanisms to determine
> > the 'page_offset_base' value (i.e. start of direct mapping of all
> > physical memory). One of the approach used by 'makedumpfile'
> > user-space tool for e.g. is to calculate the same from the last
> > PT_LOAD available in '/proc/kcore', which can be flaky as and when
> > new sections (for e.g. KCORE_REMAP which was added
> > to recent kernels) are added to kcore.
> >
> > For other architectures like arm64, I have already proposed using
> > the vmcoreinfo note (in '/proc/kcore') in the user-space utilities to
> > determine machine specific details like VA_BITS, PAGE_OFFSET,
> > kasrl_offset() (see [2] for details), for which different user-space
> > tools earlier used different (and at times flaky) approaches like:
> >
> > - Reading kernel CONFIGs from user-space and determining CONFIG values
> >    like VA_BITS from there.
> >  - Reading symbols from '/proc/kallsyms' and determining their values
> >    via '/dev/mem' interface.
> >  - Reading symbols from 'vmlinux' and determing their values from
> >    reading memory.
> >
> > This patch allows appending 'page_offset_base' for x86_64 platforms
> > to vmcoreinfo, so that user-space tools can use the same as a standard
> > interface to determine the start of direct mapping of all physical
> > memory.
> >
> > Testing:
> > -------
> >  - I tested this patch (rebased on 'linux-next') on a x86_64 machine
> >    using the modified 'makedumpfile' user-space code (see [3] for my
> >    github tree which contains the same) for determining how many pages
> >    are dumpable when different dump_level is specified (which is
> >    one use-case of live-debugging via 'makedumpfile').
> >  - I tested both the KASLR and non-KASLR boot cases with this patch.
> >  - Here is one sample log (for KASLR boot case) on my x86_64 machine:
> >
> >    < snip..>
> >    The kernel doesn't support mmap(),read() will be used instead.
> >
> >    TYPE               PAGES                   EXCLUDABLE      DESCRIPTION
> >    ----------------------------------------------------------------------
> >    ZERO               21299                   yes             Pages filled
> >    with zero
> >    NON_PRI_CACHE      91785                   yes             Cache
> >    pages without private flag
> >    PRI_CACHE  1                       yes             Cache pages with
> >    private flag
> >    USER               14057                   yes             User process
> >    pages
> >    FREE               740346                  yes             Free pages
> >    KERN_DATA  58152                   no              Dumpable kernel
> >    data
> >
> >    page size:         4096
> >    Total pages on system:     925640
> >    Total size on system:      3791421440       Byte
> >
> > I understand that there might be some reservations about exporting
> > such machine-specific details in the vmcoreinfo, but to unify
> > the implementations across user-land and archs, perhaps this would be
> > good starting point to start a discussion.
> >
> > [0]. https://www.mail-archive.com/kexec@lists.infradead.org/msg20300.html
> > [1]. MAN pages -> MAKEDUMPFILE(8) and CRASH(8)
> > [2]. https://www.spinics.net/lists/kexec/msg21608.html
> >      http://lists.infradead.org/pipermail/kexec/2018-October/021725.html
> > [3]. https://github.com/bhupesh-sharma/makedumpfile/tree/add-page-offset-base-to-vmcore-v1
> >
> > Cc: Boris Petkov <bp@alien8.de>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> > Cc: Dave Anderson <anderson@redhat.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: x86@kernel.org
> > Cc: kexec@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  arch/x86/kernel/machine_kexec_64.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > index 4c8acdfdc5a7..834ccefef867 100644
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -356,6 +356,7 @@ void arch_crash_save_vmcoreinfo(void)
> >       VMCOREINFO_SYMBOL(init_top_pgt);
> >       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> >                       pgtable_l5_enabled());
> > +     VMCOREINFO_NUMBER(page_offset_base);
> >
> >  #ifdef CONFIG_NUMA
> >       VMCOREINFO_SYMBOL(node_data);
> > --
> > 2.7.4
> >
