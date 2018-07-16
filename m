Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99020ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2CB20871
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XcphlLL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2CB20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeGPNny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:43:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36400 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbeGPNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:43:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GDDUZb172535;
        Mon, 16 Jul 2018 13:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=HwvmoxJc90L5ORuaIMFg3/pIzzrVSj3wwF3/WubEUuk=;
 b=XcphlLL7KsJdTYDO6G2FmZliVcdFUt/FGHov8R8Mk0ojPzufTbiu8vsltUEujajyRjCm
 Gu1GqVNsla5dvQS/zpZOVkMe6iBfpmZ5xrEjXdhfDZ9FsVuOzs017hW40wxEedyGSk23
 01iXKTJAWDlwpBIRndEIJaDAa3s6zlbFQ5yVZ6cx5sSCRNCCc5zcZyt7cJf8gGuRrMdI
 i00BMr8RUQC22uFO+QQ3xq2hvzLaY+bKL/3FWrhlLPEUebrwW7rip7fD6vlvuJPfQmoq
 rfUWMnpdmm1m/1/nZLlpgpGKcta9j4pT3MuUJP9EFzLNLY9BB7brOWri5dbVAorzr5s+ Ew== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k7a3svbx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 13:16:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6GDGQNj029378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 13:16:27 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6GDGQIV022933;
        Mon, 16 Jul 2018 13:16:26 GMT
Received: from mail-oi0-f52.google.com (/209.85.218.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 06:16:26 -0700
Received: by mail-oi0-f52.google.com with SMTP id y207-v6so74662348oie.13;
        Mon, 16 Jul 2018 06:16:26 -0700 (PDT)
X-Gm-Message-State: AOUpUlHVEnsaJXyXlnNk1uqF3zYUlk1tCK8+VrApitRWQp0WXYNm8cnJ
        A7TRsA1AwLfzQ+J1w5QAlsER8SQ1ZHzNBb8uEpg=
X-Google-Smtp-Source: AAOMgpdMr0IOaEkg3ElXSc+Mp67Qf1BiVxtzjUyzKMh8WDqW5jvDB4DXaDGc7dspxDzbNIYA4KWB80bH/WjXfFBrRwQ=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr19496973oia.156.1531746985986;
 Mon, 16 Jul 2018 06:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <5b4a9633.1c69fb81.17984.f7b3@mx.google.com> <0ab16066-5498-374b-5391-3dd7979044aa@collabora.com>
 <20180716105451.GA20734@sirena.org.uk> <20180716110208.GA25227@kroah.com> <CAGM2reY7RDLKR3vyr9bne3kVo58qn_F58oYHtUZaA0BChzsQGw@mail.gmail.com>
In-Reply-To: <CAGM2reY7RDLKR3vyr9bne3kVo58qn_F58oYHtUZaA0BChzsQGw@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 16 Jul 2018 09:15:50 -0400
X-Gmail-Original-Message-ID: <CAGM2reaZaJU1WQTyzGiT1zOpjHLv6=hxNfA75JLM4AdbiajrtQ@mail.gmail.com>
Message-ID: <CAGM2reaZaJU1WQTyzGiT1zOpjHLv6=hxNfA75JLM4AdbiajrtQ@mail.gmail.com>
Subject: Re: mainline/master boot: 177 boots: 2 failed, 174 passed with 1
 conflict (v4.18-rc4-160-gf353078f028f)
To:     gregkh@linuxfoundation.org
Cc:     broonie@kernel.org, guillaume.tucker@collabora.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel@collabora.com, LKML <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8955 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have figured out what is going with x86-32.  Since it has FLATMEM
memory layout, the memmap is now allocated after zero_resv_unavail():

Now, we have something like this:

zero_resv_unavail()
free_area_init_node()
 #ifdef CONFIG_FLAT_NODE_MEM_MAP
  alloc_node_mem_map()
#endif

At the time when zero_resv_unavail() is called, memmap for
FLAT_NODE_MEM_MAP is not yet allocated. On the other hand,
alloc_node_mem_map() calls memblock_virt_alloc_node_nopanic() which
calls memset(0), so zero_resv_unavail()
 is not needed for this layout.

The fix is:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5d800d61ddb7..9ec34218713b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6847,7 +6847,9 @@ void __init free_area_init_nodes(unsigned long
*max_zone_pfn)
        /* Initialise every node */
        mminit_verify_pageflags_layout();
        setup_nr_node_ids();
+#ifndef CONFIG_FLAT_NODE_MEM_MAP
        zero_resv_unavail();
+#endif
        for_each_online_node(nid) {
                pg_data_t *pgdat = NODE_DATA(nid);
                free_area_init_node(nid, NULL,

This is just a temporary fix, I will do a proper fix later, when I
will get rid of zero_resv_unavail(), but that will require more
thinking, on how to ensure that no section in memmap is skipped while
we go through memmap_init_zone().

Should I submit an updated patch for "mm: zero unavailable pages
before memmap init", or just this incremental fix?

Thank  you,
Pavel

On Mon, Jul 16, 2018 at 7:56 AM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> I have reproduced the problem on mainline. Use x86_32 defcontig +
> qemu, and problem is reproduced immediately.  I will send an update
> once I figure out what is going on.
>
> Pavel
> On Mon, Jul 16, 2018 at 7:02 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 16, 2018 at 11:54:51AM +0100, Mark Brown wrote:
> > > On Mon, Jul 16, 2018 at 11:40:06AM +0100, Guillaume Tucker wrote:
> > > > On 15/07/18 01:32, kernelci.org bot wrote:
> > > > > mainline/master boot: 177 boots: 2 failed, 174 passed with 1 conflict (v4.18-rc4-160-gf353078f028f)
> > > > >
> > > > > Full Boot Summary: https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v4.18-rc4-160-gf353078f028f/
> > > > > Full Build Summary: https://kernelci.org/build/mainline/branch/master/kernel/v4.18-rc4-160-gf353078f028f/
> > > > >
> > > > > Tree: mainline
> > > > > Branch: master
> > > > > Git Describe: v4.18-rc4-160-gf353078f028f
> > > > > Git Commit: f353078f028fbfe9acd4b747b4a19c69ef6846cd
> > > > > Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > > Tested: 67 unique boards, 25 SoC families, 21 builds out of 199
> > > > >
> > > > > Boot Regressions Detected:
> > > > [...]
> > > > > x86:
> > > > >
> > > > >      i386_defconfig:
> > > > >          x86-celeron:
> > > > >              lab-mhart: new failure (last pass: v4.18-rc4-147-g2db39a2f491a)
> > > > >          x86-pentium4:
> > > > >              lab-mhart: new failure (last pass: v4.18-rc4-147-g2db39a2f491a)
> > > >
> > > > Please see below an automated bisection report for this
> > > > regression.  Several bisections were run on other x86 platforms
> > > > with i386_defconfig on a few revisions up to v4.18-rc5, they all
> > > > reached the same "bad" commit.
> > > >
> > > >
> > > > Unfortunately there isn't much to learn from the kernelci.org
> > > > boot logs as the kernel seems to crash very early on:
> > > >
> > > >     https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v4.18-rc5/
> > > >     https://storage.kernelci.org/mainline/master/v4.18-rc4-160-gf353078f028f/x86/i386_defconfig/lab-mhart/lava-x86-celeron.html
> > > >
> > > >
> > > > It looks like stable-rc/linux-4.17.y is also broken with
> > > > i386_defconfig, which tends to confirm the "bad" commit found by
> > > > the automated bisection which was applied there as well:
> > > >
> > > >     https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.17.y/kernel/v4.17.6-68-gbc0bd9e05fa1/
> > >
> > > Adding Greg directly to the CCs due to the stable impact, not deleting
> > > context for his benefit.
> >
> > Hey, I read all stable emails, who else would?  :)
> >
> > > > The automated bisection on kernelci.org is still quite new, so
> > > > please take the results with a pinch of salt as the "bad" commit
> > > > found may not be the actual root cause of the boot failure.
> > > >
> > > > Hope this helps!
> > > >
> > > > Best wishes,
> > > > Guillaume
> > > >
> > > >
> > > > --------------------------------------8<--------------------------------------
> > > >
> > > >
> > > >
> > > > Bisection result for mainline/master (v4.18-rc4-160-gf353078f028f) on x86-celeron
> > > >
> > > >   Good:       2db39a2f491a Merge branch 'i2c/for-current' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> > > >   Bad:        f353078f028f Merge branch 'akpm' (patches from Andrew)
> > > >   Found:      e181ae0c5db9 mm: zero unavailable pages before memmap init
> > > >
> > > > Checks:
> > > >   revert:     PASS
> > > >   verify:     PASS
> > > >
> > > > Parameters:
> > > >   Tree:       mainline
> > > >   URL:        http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > >   Branch:     master
> > > >   Target:     x86-celeron
> > > >   Lab:        lab-mhart
> > > >   Config:     i386_defconfig
> > > >   Plan:       boot
> > > >
> > > > Breaking commit found:
> > > >
> > > > -------------------------------------------------------------------------------
> > > > commit e181ae0c5db9544de9c53239eb22bc012ce75033
> > > > Author: Pavel Tatashin <pasha.tatashin@oracle.com>
> > > > Date:   Sat Jul 14 09:15:07 2018 -0400
> > > >
> > > >     mm: zero unavailable pages before memmap init
> > > >     We must zero struct pages for memory that is not backed by physical
> > > >     memory, or kernel does not have access to.
> > > >     Recently, there was a change which zeroed all memmap for all holes in
> > > >     e820.  Unfortunately, it introduced a bug that is discussed here:
> > > >       https://www.spinics.net/lists/linux-mm/msg156764.html
> > > >     Linus, also saw this bug on his machine, and confirmed that reverting
> > > >     commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
> > > >     memblock.reserved") fixes the issue.
> > > >     The problem is that we incorrectly zero some struct pages after they
> > > >     were setup.
> > > >     The fix is to zero unavailable struct pages prior to initializing of
> > > >     struct pages.
> > > >     A more detailed fix should come later that would avoid double zeroing
> > > >     cases: one in __init_single_page(), the other one in
> > > >     zero_resv_unavail().
> > > >     Fixes: 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into memblock.reserved")
> > > >     Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > > >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > >
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 1521100f1e63..5d800d61ddb7 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -6847,6 +6847,7 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
> > > >     /* Initialise every node */
> > > >     mminit_verify_pageflags_layout();
> > > >     setup_nr_node_ids();
> > > > +   zero_resv_unavail();
> > > >     for_each_online_node(nid) {
> > > >             pg_data_t *pgdat = NODE_DATA(nid);
> > > >             free_area_init_node(nid, NULL,
> > > > @@ -6857,7 +6858,6 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
> > > >                     node_set_state(nid, N_MEMORY);
> > > >             check_for_memory(pgdat, nid);
> > > >     }
> > > > -   zero_resv_unavail();
> > > >  }
> > > >  static int __init cmdline_parse_core(char *p, unsigned long *core,
> > > > @@ -7033,9 +7033,9 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
> > > >  void __init free_area_init(unsigned long *zones_size)
> > > >  {
> > > > +   zero_resv_unavail();
> > > >     free_area_init_node(0, zones_size,
> > > >                     __pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
> > > > -   zero_resv_unavail();
> > > >  }
> > > >  static int page_alloc_cpu_dead(unsigned int cpu)
> > > > -------------------------------------------------------------------------------
> >
> > So this patch breaks i386, ick.  I'll wait for the fix to hit Linus's
> > tree as that's a bit more important to have the large majority of the
> > x86-64 boxes fixed with this patch for now.
> >
> > thanks,
> >
> > greg k-h
> >
