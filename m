Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7ABECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045352098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JofwV4XN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045352098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbeIYBVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:21:17 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:44759 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730681AbeIYBVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:21:17 -0400
Received: by mail-pf1-f172.google.com with SMTP id k21-v6so9457470pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Lnqm2ju+e2fjoxkQCGuRLd+t9H3PxYAZLcDiILLphMA=;
        b=JofwV4XNWbpaXzyW1EXAMaYyIrlAKVG5PhRcmeRDy3Sp/QR1RXBkQDkoz67rl/p0XZ
         0nebwz++m4zgvENlm8JtZipdZTva7pUKg969iFdADVsk9d26TnyGajaNDKifRkhlZ08+
         +sFxWiXX9CDQ+cuMXFmcqmcBfGwar8RlWI031vHZGbOom/rV6O/0a80o+DUUpPIw6R34
         UVDsAh/Ew5IqtJ+7W/csrG5ymGxZ5fqbSU+KEoEuS/rW5FqjMnadqsloxSgEns8pHBfE
         Jm5MNcF9vBgtsKa+a83cXDdHGogNJXLAkQybfaDkjZoc4VxIwnqvYJMPt36QsRx24xoE
         lXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Lnqm2ju+e2fjoxkQCGuRLd+t9H3PxYAZLcDiILLphMA=;
        b=TnKZHf0mcA5kqY0hdvaIJwo6kWHGuj2g0RMXHYphyeHh0OeJGfP4LHlNXGgWBkwNWI
         LpxR8qb11DZUsA279ckqz/TbRWqTTpWSBaGKLelDx0g+eOxuhppsCt6XU9YLpyB5OZ+V
         9VlKq5jt6li5l/SlHYEhp9RgpDCYyM2utWJEQV0r9W0PuKkBNXFAWN00AYEDqVy3gr+D
         ++M+CQK1KHpLPi7FhciR3vcnVhAs4KRi6rde78fU3PCxCNj3zpaHxs4/1xWTT4zAkhXv
         3+jFyUu8P+coOz0Yo/sJXAdlLjoiYy8xoIWYpjPxprTk0M9mQ1xolnRNru3PKvZAAJOI
         IMhw==
X-Gm-Message-State: ABuFfogxH0pdj1H24Vfw3j/qqs7nJUJ3r3GtxIreH0rGHaFDWrf2nzzM
        /g2L/xHZ0qCWPihj3lTI+0YbiA==
X-Google-Smtp-Source: ACcGV63Njx5S9hZa0umCgdbSw3Xvc896Ow8az2KfvDaEl15czCSEiuQnJZMeQzVMgVEJ77U4K/Ttow==
X-Received: by 2002:a63:d34f:: with SMTP id u15-v6mr170253pgi.325.1537816658583;
        Mon, 24 Sep 2018 12:17:38 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 71-v6sm84051pfx.182.2018.09.24.12.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 12:17:37 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:17:34 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Linux-MM layout <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [patch] mm, thp: always specify ineligible vmas as nh in smaps
In-Reply-To: <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz>
Message-ID: <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com> <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018, Vlastimil Babka wrote:

> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -653,13 +653,23 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >  #endif
> >  #endif /* CONFIG_ARCH_HAS_PKEYS */
> >  	};
> > +	unsigned long flags = vma->vm_flags;
> >  	size_t i;
> >  
> > +	/*
> > +	 * Disabling thp is possible through both MADV_NOHUGEPAGE and
> > +	 * PR_SET_THP_DISABLE.  Both historically used VM_NOHUGEPAGE.  Since
> > +	 * the introduction of MMF_DISABLE_THP, however, userspace needs the
> > +	 * ability to detect vmas where thp is not eligible in the same manner.
> > +	 */
> > +	if (vma->vm_mm && test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > +		flags |= VM_NOHUGEPAGE;
> 
> Should it also clear VM_HUGEPAGE? In case MMF_DISABLE_THP overrides a
> madvise(MADV_HUGEPAGE)'d vma? (I expect it does?)
> 

Good point, I think that is should because MMF_DISABLE_THP will override 
VM_HUGEPAGE.  It looks like the Documentation file is still referencing 
both as advise flags and doesn't address PR_SET_THP_DISABLE.  Let me send 
a v2 with a Documentation update and your suggested fix.  Thanks 
Vlastimil!

> > +
> >  	seq_puts(m, "VmFlags: ");
> >  	for (i = 0; i < BITS_PER_LONG; i++) {
> >  		if (!mnemonics[i][0])
> >  			continue;
> > -		if (vma->vm_flags & (1UL << i)) {
> > +		if (flags & (1UL << i)) {
> >  			seq_putc(m, mnemonics[i][0]);
> >  			seq_putc(m, mnemonics[i][1]);
> >  			seq_putc(m, ' ');
> > 
