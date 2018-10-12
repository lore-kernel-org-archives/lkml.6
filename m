Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A60C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8655D2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GN3vBNv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8655D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeJLNFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:05:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38170 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJLNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:05:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id u197-v6so8971103oif.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 22:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3DEy2LhGTMU9lfPm4HI6S/P1WXfxtGZCDnRboWhqW0=;
        b=GN3vBNv3QnOlijn1AH3C7KvP+imDJFP2OuRAzc8q6aeMzhMidHc+x5fznzsQvxMd9b
         LYN/If6IrPONWAzhDxJR4/k051gGVHGO8Ciib19RjRvVNlqqafohYtz9A3+VM5M7zWxO
         6SOSTmfqZHP5fWWINbWnvrRIuoAAn3Pta43gbWOatBiFdya/TYijGQENCdqnDpa0pUTg
         0NCjgpy590mDS9HOt0cBIf2A1hDI6tkit3aTP3DnozuftegOLa0FAzt4RRLGADttx4lm
         aBZox6Wfj1r5ro5unOZi+ANwxwwJQoGSrYUHGQ1TE0EUsQLl4PHoArIzdGb6dfdVWKxs
         jOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3DEy2LhGTMU9lfPm4HI6S/P1WXfxtGZCDnRboWhqW0=;
        b=ezS1exxfXTOXDPei8TJVQtSjHWS50WiAR7iVvzHba1Di/s9Na185CRtwXKaU6qJs2N
         udgYjA4Xn327fICgaNApaxKlSZptU+jp1+caK56FcizL3rbAZPxd67B7BPKyhu87OfWq
         ekDS039d2HFkK20AffEkk597VvdjmsWRz/tq9a7aAVCugDFjPBPwaXw7QpVERkpmn7DU
         d0Klx9VS8UO6uoeJ7SOwLwGUbtl2Z1KFgPyttTH0ubql9uFU2n6XqTDTiI0SKFS1SxY8
         zw/annWvv8SuXP5cskSg0fPWd+RmyYrXcOk4mTjrwYxx0K7x6XxT8nhdeOGLIasFVQXs
         sDOQ==
X-Gm-Message-State: ABuFfogaQfeMPOOvcWcrtI5IHnOEJ76MpTTw+zP4jZAIeGUXSsjyWSMJ
        PbpfYemvbQFCE0Y3AAlO77gB/mMCm+dmLZa2FOubYw==
X-Google-Smtp-Source: ACcGV60562D/Ktt+ElJYhpFuuh/Le+pI2DXNxjscTFo2lKiNlpqhNlIcgwiFd778cmdS0ONIVxagnbbB+gOMklRiA/g=
X-Received: by 2002:aca:490b:: with SMTP id w11-v6mr2428226oia.126.1539322472858;
 Thu, 11 Oct 2018 22:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181009201400.168705-1-joel@joelfernandes.org>
 <CAG48ez3yLkMcyaTXFt_+w8_-HtmrjW=XB51DDQSGdjPj43XWmA@mail.gmail.com> <42b81ac4-35de-754e-545b-d57b3bab3b7a@suse.com>
In-Reply-To: <42b81ac4-35de-754e-545b-d57b3bab3b7a@suse.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 07:34:05 +0200
Message-ID: <CAG48ez1=RAvrTyWyWcxANBM+Sf7qDoScaA_hvebxp1qh0WzcYg@mail.gmail.com>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
To:     Juergen Gross <jgross@suse.com>
Cc:     joel@joelfernandes.org, kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kernel-team@android.com,
        Minchan Kim <minchan@google.com>,
        Hugh Dickins <hughd@google.com>, lokeshgidra@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        pombredanne@nexb.com, Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 7:29 AM Juergen Gross <jgross@suse.com> wrote:
> On 12/10/2018 05:21, Jann Horn wrote:
> > +cc xen maintainers and kvm folks
> >
> > On Fri, Oct 12, 2018 at 4:40 AM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> >> Android needs to mremap large regions of memory during memory management
> >> related operations. The mremap system call can be really slow if THP is
> >> not enabled. The bottleneck is move_page_tables, which is copying each
> >> pte at a time, and can be really slow across a large map. Turning on THP
> >> may not be a viable option, and is not for us. This patch speeds up the
> >> performance for non-THP system by copying at the PMD level when possible.
> > [...]
> >> +bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> >> +                 unsigned long new_addr, unsigned long old_end,
> >> +                 pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> >> +{
> > [...]
> >> +       /*
> >> +        * We don't have to worry about the ordering of src and dst
> >> +        * ptlocks because exclusive mmap_sem prevents deadlock.
> >> +        */
> >> +       old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> >> +       if (old_ptl) {
> >> +               pmd_t pmd;
> >> +
> >> +               new_ptl = pmd_lockptr(mm, new_pmd);
> >> +               if (new_ptl != old_ptl)
> >> +                       spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> >> +
> >> +               /* Clear the pmd */
> >> +               pmd = *old_pmd;
> >> +               pmd_clear(old_pmd);
> >> +
> >> +               VM_BUG_ON(!pmd_none(*new_pmd));
> >> +
> >> +               /* Set the new pmd */
> >> +               set_pmd_at(mm, new_addr, new_pmd, pmd);
> >> +               if (new_ptl != old_ptl)
> >> +                       spin_unlock(new_ptl);
> >> +               spin_unlock(old_ptl);
> >
> > How does this interact with Xen PV? From a quick look at the Xen PV
> > integration code in xen_alloc_ptpage(), it looks to me as if, in a
> > config that doesn't use split ptlocks, this is going to temporarily
> > drop Xen's type count for the page to zero, causing Xen to de-validate
> > and then re-validate the L1 pagetable; if you first set the new pmd
> > before clearing the old one, that wouldn't happen. I don't know how
> > this interacts with shadow paging implementations.
>
> No, this isn't an issue. As the L1 pagetable isn't being released it
> will stay pinned, so there will be no need to revalidate it.

Where exactly is the L1 pagetable pinned? xen_alloc_ptpage() does:

        if (static_branch_likely(&xen_struct_pages_ready))
            SetPagePinned(page);

        if (!PageHighMem(page)) {
            xen_mc_batch();

            __set_pfn_prot(pfn, PAGE_KERNEL_RO);

            if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS)
                __pin_pagetable_pfn(MMUEXT_PIN_L1_TABLE, pfn);

            xen_mc_issue(PARAVIRT_LAZY_MMU);
        } else {
            /* make sure there are no stray mappings of
               this page */
            kmap_flush_unused();
        }

which means that if USE_SPLIT_PTE_PTLOCKS is false, the table doesn't
get pinned and only stays typed as long as it is referenced by an L2
table, right?
