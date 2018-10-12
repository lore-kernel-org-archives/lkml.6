Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E676C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C5E2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qslww6c5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C5E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeJLKwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 06:52:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44794 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeJLKwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 06:52:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id u74-v6so8793238oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 20:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWmcAcc5aI6rD0TxwHD+d05i18SLBiVhQijk1UyCPzQ=;
        b=Qslww6c5/x9a7evzAMIt+iD3NE9iEJBM+Xd7OHzJGvGR+cxNsSSLXGX6Vx//8MPnDA
         wzvB2wuseUFUzs96kEKrcxuJ/CERNzdsbJQI0I8fGZtHw3HDs0+UBpSO9H4c/tDNvJtP
         w5sGbbagF2MrL3jWWry2ecewAxnDIMqrg2tnpM5HUiZdVDdP14/DJfBPKc4PT4HYvzD2
         ZDaISZ323KwLo5BwCIwBlQIgyJLtnXij6vHtfmTpIDYsixiOP+PtaZK/UTyQRRgeNRLy
         CZDsq1d0fNt8V9kD83qDdt0X8XxRi8dpDV9JuukDs1iHvvllqmCi+Bn5EsuKyowqmOL2
         Gl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWmcAcc5aI6rD0TxwHD+d05i18SLBiVhQijk1UyCPzQ=;
        b=jQKicK1Ntzw0n8LQ5RN5LKONdI8CGSQG1Iidp4cfsD52eC9RrapxYaPu8hR9qk/AGn
         0Lx0DS6l1aVgGbee+X2QmhbtXjAvhjbuT/GdTraReJFGAhzk6H1BAIMsBzbF+APB02q+
         +dl5xwaIdfFvIfTuYe8hjek/yUj2si1ZxJ6c7cm+oOHq3rX8L7V9J6PUKOzbFMJQDxOx
         ZaGKiYLq/mCr0sHO1h0+JVXOwpWxJolZiupU5Vhp8GAz+lzzEFOLH3KGrm48rLGPP3wL
         2qmwIyWoU3gIs1nL5S5EdxWvovSCOWDcl8E0DdnkusrYwz98eSEnyegP/bhFBe9XBh5C
         j8Fw==
X-Gm-Message-State: ABuFfojRPfhsQp+c4qwqEhR2d4RNzB7XKd3B/VyT4HhBrRjXKUq3Bkdf
        tud5KeW6RlQuabvQJv9/t8R/i+Yoxhl1a8aBnTMVzA==
X-Google-Smtp-Source: ACcGV63ynNX53N9PHGNb65YeQ86/qYqgFchRxc/MpkvizWAYSGFmSu0Ejp/JMBxYgzkLEt2ys4cAl/qdZUcbC1tQDYo=
X-Received: by 2002:aca:efd6:: with SMTP id n205-v6mr2247908oih.3.1539314518950;
 Thu, 11 Oct 2018 20:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181009201400.168705-1-joel@joelfernandes.org>
In-Reply-To: <20181009201400.168705-1-joel@joelfernandes.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 05:21:32 +0200
Message-ID: <CAG48ez3yLkMcyaTXFt_+w8_-HtmrjW=XB51DDQSGdjPj43XWmA@mail.gmail.com>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
To:     joel@joelfernandes.org
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kernel-team@android.com,
        Minchan Kim <minchan@google.com>,
        Hugh Dickins <hughd@google.com>, lokeshgidra@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        pombredanne@nexb.com, Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc xen maintainers and kvm folks

On Fri, Oct 12, 2018 at 4:40 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
> Android needs to mremap large regions of memory during memory management
> related operations. The mremap system call can be really slow if THP is
> not enabled. The bottleneck is move_page_tables, which is copying each
> pte at a time, and can be really slow across a large map. Turning on THP
> may not be a viable option, and is not for us. This patch speeds up the
> performance for non-THP system by copying at the PMD level when possible.
[...]
> +bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> +                 unsigned long new_addr, unsigned long old_end,
> +                 pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> +{
[...]
> +       /*
> +        * We don't have to worry about the ordering of src and dst
> +        * ptlocks because exclusive mmap_sem prevents deadlock.
> +        */
> +       old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> +       if (old_ptl) {
> +               pmd_t pmd;
> +
> +               new_ptl = pmd_lockptr(mm, new_pmd);
> +               if (new_ptl != old_ptl)
> +                       spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +
> +               /* Clear the pmd */
> +               pmd = *old_pmd;
> +               pmd_clear(old_pmd);
> +
> +               VM_BUG_ON(!pmd_none(*new_pmd));
> +
> +               /* Set the new pmd */
> +               set_pmd_at(mm, new_addr, new_pmd, pmd);
> +               if (new_ptl != old_ptl)
> +                       spin_unlock(new_ptl);
> +               spin_unlock(old_ptl);

How does this interact with Xen PV? From a quick look at the Xen PV
integration code in xen_alloc_ptpage(), it looks to me as if, in a
config that doesn't use split ptlocks, this is going to temporarily
drop Xen's type count for the page to zero, causing Xen to de-validate
and then re-validate the L1 pagetable; if you first set the new pmd
before clearing the old one, that wouldn't happen. I don't know how
this interacts with shadow paging implementations.

> +               *need_flush = true;
> +               return true;
> +       }
> +       return false;
> +}
