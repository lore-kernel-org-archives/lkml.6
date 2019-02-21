Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDCFC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EB720838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="1W/lKVgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfBUO2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:28:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38687 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUO2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:28:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id m2so11506761pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pA9wgCQyEUyTHkAq+rVlPzlBQCV50nMzrf+ehGsqY3Q=;
        b=1W/lKVgGsUokYt6qJwL+oFd6wI/8KbnaSxB0ry6zobjbzzt8lwy3rDM0GPrPbtSzWc
         XG5+mzm8TvRZAvS9RAH1TXfpQzPMGUQl6oFNDC4cI7CFGbnXzzQkKLtKcRg+9PQgPMg0
         pXOIaFUcQmh98dypu8uNF3Y2c/xfQLSZaDJV0dnCRB+kT6gfZqY/nbPnUJ9KfNdArqh7
         gaOhtVDM5gTEAmClFOieev9ao8Ctx/Fy8y8/MqglYraqRqt5rGZzTWciBFhzAHeoA13O
         FAi/fYvXvQljBV62TkgyfrGmaviIfnN2K+pcsmzHfWyWorMknnuXuMfFrqSEyT2WFs7R
         kzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pA9wgCQyEUyTHkAq+rVlPzlBQCV50nMzrf+ehGsqY3Q=;
        b=L69xXPMBh96vg5LgP9cwOOlhDCr75rNDf3I1fvfKTAqO3dsW4nwKeMx6Xlw+TjVYBI
         ziiISG8dq0nnnHP+kttdhBnqOV8Rt090bT41RaI29ZuSF6cfEHeQxP2oedQ7TTzdP9Az
         AVs/LQaiHyEKkahYiRJsPOAzyBCa8xDLKvxL8clDFUYR0DWMn2EgbSvczjqrawS5iEw3
         1zvxXuoAizcAV+y+Ve+MQEkHySJyBBLa7aCp1OQ9QakS50tM6C+jeEr2yT9rv5kutwDS
         LA0fWwHeFCVQaZMeTs+P/VYaRy3vXUmNNt55+YGGCSuOIM9VzaYefVNWV0M6WD6MKBMJ
         5VqA==
X-Gm-Message-State: AHQUAuZE6PSUu4RzgBB+oXp32+DzNFPhB+A6B+XZAaNmLCL4W2NfGXKT
        Zf8caIObPyo8DpT/TDH8pFNPcw==
X-Google-Smtp-Source: AHgI3IbfbbYkruivN5aBVqRxR1ViZUHLVAQoi1hsZAsMbsY8Xl1Xpgutyz7rtk/D8d3+HA9SOuSXiw==
X-Received: by 2002:a62:3a01:: with SMTP id h1mr39568542pfa.169.1550759297907;
        Thu, 21 Feb 2019 06:28:17 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id y5sm41244867pge.49.2019.02.21.06.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 06:28:16 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 0B424301708; Thu, 21 Feb 2019 17:28:13 +0300 (+03)
Date:   Thu, 21 Feb 2019 17:28:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2 03/13] mm: Add generic p?d_large() macros
Message-ID: <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-4-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221113502.54153-4-steven.price@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:34:52AM +0000, Steven Price wrote:
> From: James Morse <james.morse@arm.com>
> 
> Exposing the pud/pgd levels of the page tables to walk_page_range() means
> we may come across the exotic large mappings that come with large areas
> of contiguous memory (such as the kernel's linear map).
> 
> For architectures that don't provide p?d_large() macros, provided a
> does nothing default.

Nak, sorry.

Power will get broken by the patch. It has pmd_large() inline function,
that will be overwritten by the define from this patch.

I believe it requires more ground work on arch side in general.
All architectures that has huge page support has to provide these helpers
(and matching defines) before you can use it in a generic code.

-- 
 Kirill A. Shutemov
