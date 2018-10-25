Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C26BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5413D20838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pHrhMemX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5413D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeJYP5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:57:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39486 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJYP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:57:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so3741659pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6hlF8k1uv+241/Kh1blG0aK0TAXnW6aw8IdpndDKD1Q=;
        b=pHrhMemXrw5hl+arL43raL/gNhgyjpJPx4EE7SKkgRX/TKfdLX6x902ncQzH6HsXkC
         /5afeTEhVEpHp2G838i0ZKdmMR/9DbSrch37E5BONTPPZE/qpi+diJs6Fm6Hl89TCOhp
         eLLffi7SUefsEn86J5S96obmIgn8XhujAXKD+/oBdnyQVCb6qiSDzRHQea5mTNPLYHgK
         O+doMdWVRdXvdCfK0CoqXT0iq28y9gNVRDFzIstt9JidPWkDFCMzaoLUB3POUX84tCfE
         ycQhudTd/LUR1jUQ/6LXdbNQ9+qaNnSSaOf+UYwYex/cVH5LSem8WRQR2DpAdTgsLdhZ
         onpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6hlF8k1uv+241/Kh1blG0aK0TAXnW6aw8IdpndDKD1Q=;
        b=bIgX6Ozk3wwheFhNhWd/OvAoXF4w0PBubQlXzLiCulhl2IoKMxlfiiwQf5azTEAVGv
         kvYYHnf0dEdIbjsppTiyRh2C7mBvy2SQiKXHOc710JbzNwwgmX/iHtGQMmu0ATUEXbpd
         IVlJmwupT0AeqVhsdvqjLbP9ZivrBa0Mfsofq1lWeaP0VyHNSe9/x4GBSnsoDamxPVZz
         3hFyjH9FQ2VnHskDI21hm+fRR9AOIpwF3wxKO07ykTrPWpmGX7+MUUWUj5sLPwaXwfd3
         FQRhZ2LBRU8RVkdeSPzSxBHxg2SxnJvS8vqYHPpAWBQYVZt6CmZSW3lELJ6NMSYxPJ1H
         dR8w==
X-Gm-Message-State: AGRZ1gIiulP/6BaG/KQP64L3CCYN9mJN3wyyZePugBfqbZWPHcRogyP5
        +EOYqZnbNg604UeV1nXM3mG0yg==
X-Google-Smtp-Source: AJdET5co+s2Fx0MDoC5fa5/iE0RO+7wr3Zp+okau8yKm30+yLgYl4wbz+m7F1Y048jgdhNbg3k/8VA==
X-Received: by 2002:a63:fd09:: with SMTP id d9-v6mr445528pgh.164.1540452368266;
        Thu, 25 Oct 2018 00:26:08 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id k13-v6sm7677787pff.30.2018.10.25.00.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 00:26:07 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 5CF7D300225; Thu, 25 Oct 2018 10:26:03 +0300 (+03)
Date:   Thu, 25 Oct 2018 10:26:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/ldt: Unmap PTEs for the slow before freeing LDT
Message-ID: <20181025072602.cz3vy2zhzq2px7ik@kshutemo-mobl1>
References: <20181023163157.41441-1-kirill.shutemov@linux.intel.com>
 <20181023163157.41441-3-kirill.shutemov@linux.intel.com>
 <CALCETrUsqCzU6VO0h4EFpsdXOOn-kJY7ogwKQiQScNY9YJ6hWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUsqCzU6VO0h4EFpsdXOOn-kJY7ogwKQiQScNY9YJ6hWA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:49:17AM -0700, Andy Lutomirski wrote:
> On Tue, Oct 23, 2018 at 9:32 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > modify_ldt(2) leaves old LDT mapped after we switch over to the new one.
> > Memory for the old LDT gets freed and the pages can be re-used.
> >
> > Leaving the mapping in place can have security implications. The mapping
> > is present in userspace copy of page tables and Meltdown-like attack can
> > read these freed and possibly reused pages.
> 
> Code looks okay.  But:
> 
> > -       /*
> > -        * Did we already have the top level entry allocated?  We can't
> > -        * use pgd_none() for this because it doens't do anything on
> > -        * 4-level page table kernels.
> > -        */
> > -       pgd = pgd_offset(mm, LDT_BASE_ADDR);
> 
> This looks like an unrelated cleanup.  Can it be its own patch?

Okay, I'll move it into a separate patch in v3.

I'll some more time for comments on v2 before respin.

-- 
 Kirill A. Shutemov
