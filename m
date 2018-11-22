Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B9EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BD120824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpSgqmQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BD120824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407098AbeKWHhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:37:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39681 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbeKWHhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:37:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so2471343wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 12:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Boe6MgU0Q46ptZD5vVau8knST8PlLhqMZVCYWNdMBE0=;
        b=DpSgqmQ2DN6q88C5Y+BGy/EO71PTiHmM45dqch9Zt+bWR686S4LRiE/OenPPtUqmtb
         Q6v0sPU92DJT5ZPb4SpFTnS6WMZBRfcD8Gltn6K5RrYDo/S82KIc4djKi1WAerpF0J/9
         ovLEs7T+mhDWC8L7vHvYEim+lpY7ClWBmpZeRORzMxvIPTWtypc/P2wdPwPoL9kwWgy1
         QShL8NQdzi9y+qNYTBdtP8LO36it+eBhvJ9EQ5F36k6oQLc+AvqvpDyI7nyZB0xrKKtQ
         gdgizKUINbXZ/0yO0tLAJwnNW7Nz3/jYchhUomDf6HtHmI5RhDxFePkKPsWCCOK9hNh7
         K6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Boe6MgU0Q46ptZD5vVau8knST8PlLhqMZVCYWNdMBE0=;
        b=o1u3FZkJEcC+Vkad0Hcga64AGIr22pIm5Oy96GE770Omnh+pcSQLzE1X8mEThBOdeQ
         /FA9+bhnjzWZjTuVe3bBtP8R2uOmzLALsxAWRJQLWKmDIgijhMKzy0Fn/gbAVGEYBB2f
         bBulRN8B2x81CBZ0k17vNTHaD3OkvqRv5uINl95XRnD9dab89PQq41+8UAFYe0EJQ5qH
         z+pIVHxL0r2s7LFQimfiKgU1Dc4oVGGrTnFK9CoB/lnTFKgA6fyGUzl+bN4ZVqin5XxJ
         PGomuKP+24Tf32lOtKSYXjckm6jLdN/h2VsIrWwdkkgjETUMYteJRycCplD3K39LQtAo
         XzTA==
X-Gm-Message-State: AA+aEWbQ9s0/mW2IvV/99ex8CZKFFGDqhFfr2mIrPvEEB+TuucxADJpf
        sqFwaDEHUPsS0t2tzzHYiezCUQG8
X-Google-Smtp-Source: AFSGD/UgUyU+1U+wlznFv5xCI91mvqkF/4Aj8M1shPApNEZ3w9aPsV0UmJ2Vx1+n2RZrpO3zK730sg==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr11145137wrq.172.1542920208251;
        Thu, 22 Nov 2018 12:56:48 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f192sm5021347wmd.12.2018.11.22.12.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 12:56:47 -0800 (PST)
Date:   Thu, 22 Nov 2018 21:56:45 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] x86/fsgsbase/64: Fix the base write helper functions
Message-ID: <20181122205645.GA36550@gmail.com>
References: <20181116232728.23538-1-chang.seok.bae@intel.com>
 <CALCETrVtnkrr+t7-oXXrGDsei1Q0nudh8JstkuaE+dka4FHPEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVtnkrr+t7-oXXrGDsei1Q0nudh8JstkuaE+dka4FHPEA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> On Fri, Nov 16, 2018 at 3:27 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >
> > The helper functions that purport to write the base should just write it
> > only. It shouldn't have magic optimizations to change the index.
> >
> > Make the index explicitly changed from the caller, instead of including
> > the code in the helpers.
> >
> > Subsequently, the task write helpers do not handle for the current task
> > anymore. The range check for a base value is also factored out, to
> > minimize code redundancy from the caller.
> >
> > v2: Fix further on the task write functions. Revert the changes on the
> > task read helpers.
> >
> > v3: Fix putreg(). Edit the changelog.
> >
> > v4: Update the task write helper functions and do_arch_prctl_64(). Fix
> > the comment in putreg().
> >
> > v5: Fix preempt_disable() calls in do_arch_prctl_64()
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> 
> Ingo, Thomas: can we get this in x86/urgent, please?

Sadly this commit introduced a boot failure on both an Intel and an AMD 
64-bit testbox.

Symptoms range from silent bootup hang in early userspace to segfaults 
like this:

[   21.885741] random: systemd: uninitialized urandom read (16 bytes read)
[   21.964778] systemd[1]: segfault at 28 ip 00005584d8d8247d sp 00007ffc7a05aed0 error 4 in systemd[5584d8d0d000+137000]
[   21.977664] Code: c3 4c 89 ff e8 94 78 fa ff eb bb 48 89 c3 eb f1 00 00 00 00 00 00 00 00 00 00 00 00 00 41 55 41 54 55 53 48 89 fd 48 83 ec 28 <64> 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 48 85 ff 74 6e 48
[   22.000004] systemd[1]: segfault at 28 ip 00005584d8db0a3d sp 00007ffc7a05a7e0 error 4 in systemd[5584d8d0d000+137000]
[   22.012869] Code: 49 89 e9 ba 67 01 00 00 bf 04 00 00 00 31 c0 e8 c9 1c 03 00 59 31 c0 5e e9 ff fa ff ff 41 54 55 53 89 fb 48 81 ec 40 01 00 00 <64> 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00 00 31 c0 e8 fb 92

I've zapped the commit from x86/urgent because it's clearly not ready 
yet.

I used a fairly regular distro .config and a fairly regular distro - 
nothing fancy.

Thanks,

	Ingo
