Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E15C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4C52070D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="wwPRWoH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBUO5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:57:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45553 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBUO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:57:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id r14so14296030pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T6VBBJYyKGf9Yt7Yt1V87f/1+l66aJ7Oi3kjsALTg5U=;
        b=wwPRWoH7RscIRgKfRveK1NuIj23T/Lu9QLuQEw/AlQodiLk7Li6narB2OnDzzopxGh
         AIwxvNdAU3Dy8rZo6y55/MSqf91CVcBpEdUpQ/EdMhSETrfyce4iRd0DhiYWDR4Ogj9L
         52pXutYxgrmONKkaNVbCUN9nDGVt53Wnh10ONcI5kGw9RT1JNgIT7lUyRT3cPEXxyGpr
         fwxE93FUHAT4JpVECaIH8mY9FsDpLfbDacUHtRoRKGKVl89tqSIzfLKkbjIA1YKOtjPp
         S/am9lEOA3qmmUiZ8S3kpbmzDSGa7d2Atbak6PZMraWUy7dEFSny0KMOEmW9z5I66Kkk
         LYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T6VBBJYyKGf9Yt7Yt1V87f/1+l66aJ7Oi3kjsALTg5U=;
        b=t4k7MHyXGk23CQGK9UloxzJYporrtmwYxkBU483SjESmTB0j/vnrxmd9vV2p9g3x/N
         KHo5/YQsndTdFHiYpPoaZnb/VTLGoE1owuBZFiJOw6WCe9WdwVijiykdRcPKZFPzwlMe
         NqFn+yg3Q/VnREWROSCRQL5eleACuB437pjNxW0DQt/oJTgFLzVJ8vV4AJ0K+LhKEUeQ
         SJcICMW0D/al0nOlxLUPwPSDN4vEDtbGFMkLx8NPuZUITqXkJaTW0kye/AjpgO3Rf5GB
         /0VpUSTsvVNOLpqVOkLpdX2qjJYegXdu+OPiMZflbmcVz6WMr2aO/9BqclTs0Tc4YMq1
         lJMA==
X-Gm-Message-State: AHQUAuZLZ7QmKq0rfZoNtMIESL2S6KyN8UMz/H0cYiNzhCawFZFXWVDw
        vMbMJKd3mhNzEqM84QVv23EhZA==
X-Google-Smtp-Source: AHgI3Ib9Y14HOUHgb7hPC19Ds22hTsvdmOthEb6KPxlYMOxeEBURgY4/74WCmxUy5cW9dU9bAhaEZg==
X-Received: by 2002:a17:902:e90b:: with SMTP id cs11mr20788392plb.197.1550761030340;
        Thu, 21 Feb 2019 06:57:10 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.43])
        by smtp.gmail.com with ESMTPSA id f10sm27599894pfn.11.2019.02.21.06.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 06:57:09 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4C4EE301708; Thu, 21 Feb 2019 17:57:06 +0300 (+03)
Date:   Thu, 21 Feb 2019 17:57:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steven Price <steven.price@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2 03/13] mm: Add generic p?d_large() macros
Message-ID: <20190221145706.zqwfdoyiirn3lc7y@kshutemo-mobl1>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-4-steven.price@arm.com>
 <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
 <a3076d01-41b3-d59b-e98c-a0fd9ba5d3f5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3076d01-41b3-d59b-e98c-a0fd9ba5d3f5@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:46:18PM +0000, Steven Price wrote:
> On 21/02/2019 14:28, Kirill A. Shutemov wrote:
> > On Thu, Feb 21, 2019 at 11:34:52AM +0000, Steven Price wrote:
> >> From: James Morse <james.morse@arm.com>
> >>
> >> Exposing the pud/pgd levels of the page tables to walk_page_range() means
> >> we may come across the exotic large mappings that come with large areas
> >> of contiguous memory (such as the kernel's linear map).
> >>
> >> For architectures that don't provide p?d_large() macros, provided a
> >> does nothing default.
> > 
> > Nak, sorry.
> > 
> > Power will get broken by the patch. It has pmd_large() inline function,
> > that will be overwritten by the define from this patch.
> > 
> > I believe it requires more ground work on arch side in general.
> > All architectures that has huge page support has to provide these helpers
> > (and matching defines) before you can use it in a generic code.
> 
> Sorry about that, I had compile tested on power, but obviously not the
> right config to actually see the breakage.

I don't think you'll catch it at compile-time. It would silently override
the helper with always-false.

> I'll do some grepping - hopefully this is just a case of exposing the
> functions/defines that already exist for those architectures.

I see the same type of breakage on s390 and sparc.

> Note that in terms of the new page walking code, these new defines are
> only used when walking a page table without a VMA (which isn't currently
> done), so architectures which don't use p?d_large currently will work
> fine with the generic versions. They only need to provide meaningful
> definitions when switching to use the walk-without-a-VMA functionality.

How other architectures would know that they need to provide the helpers
to get walk-without-a-VMA functionality? This looks very fragile to me.

-- 
 Kirill A. Shutemov
