Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD6CC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CA82080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="NKPNMRo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBUVGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:06:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33118 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfBUVGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:06:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id q12so40493lfm.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VaJWYAuyQeiGU3BWEwsARtgeEZnMSVA9riqh9x2CWpM=;
        b=NKPNMRo3ErcDG4ky/fPBEzQnksX3jp49gQoP5BNMEml3Xa4+q8OBDs7eAYPRL6qIaa
         YnxzxJBtMWzo0qktAuwG5l6TasJiZlpxVYcujUQeC9ZyBOy31eoJP2BEWav5d6MVOWFT
         ih1drWY0aq4VUyqJizrEh6aOe04fRSqfb/3/vv8pOVYQ7XigqKstevSLa4l2aF42wYPT
         KkNfHtJMkZH4omVe/xjOwvs0Oo/DxPn8TwLXZrI3EbTeppnTN0jFJG0j/9bVHyOeAA6v
         LYgZf4FpipElkeU0YNCJqUuOwJL3/b6ZeZT+gWOK+CkI4MM2RS0pxYuSWRnBJkwbSBGq
         etsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VaJWYAuyQeiGU3BWEwsARtgeEZnMSVA9riqh9x2CWpM=;
        b=D8g9EfKAK2f5W9D550+5NkxK2U8muVQS2JmKSB5aGgva37sLg6mSNUX2wbyrcIb2Wn
         VWY3s8gjTpYx3P2Sia4N6eZ641OHr9SiunNi8gL+uwbq7W1DXY5+dES+wrfe2WXQ/ybi
         FioDjs++cRm9Iqq1/Q2BsqLomtTX+rNCYfPeddG5cNuxWqF5h/1KuasGTOrJLqNdovhR
         zkdxzTXhRaVYeAoZOLEo2zwJSJS793VQfAnlX7lbMoYHWapPAbrBj43QtneTceIesGxD
         CJsPWWwpCen4JqC/QBWDoDUXaED0jMPnGs2xkO94m08oLGUkOZlXJ6dUshZV2G6AE3Ll
         9JnA==
X-Gm-Message-State: AHQUAuZ/J5d/hx/RlNCQ6jHonytQ7xonFS4xXIUcAy3usKqy8lUuxvP5
        VH9E9kGjMfCoT85AGWlq2C21zg==
X-Google-Smtp-Source: AHgI3IZPyEOrLA7QJzleHCFDOD1gvwBgGn5TGNiVcau/7k1voltB6KSCgJi+MGXiUxUSeuln6x/iYw==
X-Received: by 2002:a19:6001:: with SMTP id u1mr317237lfb.56.1550783181385;
        Thu, 21 Feb 2019 13:06:21 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (mm-23-232-121-178.mgts.dynamic.pppoe.byfly.by. [178.121.232.23])
        by smtp.gmail.com with ESMTPSA id z85sm6143768lff.80.2019.02.21.13.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 13:06:20 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E14B7301708; Fri, 22 Feb 2019 00:06:18 +0300 (+03)
Date:   Fri, 22 Feb 2019 00:06:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steven Price <steven.price@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
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
Message-ID: <20190221210618.voyfs5cnafpvgedh@kshutemo-mobl1>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-4-steven.price@arm.com>
 <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
 <a3076d01-41b3-d59b-e98c-a0fd9ba5d3f5@arm.com>
 <20190221145706.zqwfdoyiirn3lc7y@kshutemo-mobl1>
 <e0c7fc0c-7924-1106-a7a3-fc12136b7b82@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0c7fc0c-7924-1106-a7a3-fc12136b7b82@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 05:16:46PM +0000, Steven Price wrote:
> >> Note that in terms of the new page walking code, these new defines are
> >> only used when walking a page table without a VMA (which isn't currently
> >> done), so architectures which don't use p?d_large currently will work
> >> fine with the generic versions. They only need to provide meaningful
> >> definitions when switching to use the walk-without-a-VMA functionality.
> > 
> > How other architectures would know that they need to provide the helpers
> > to get walk-without-a-VMA functionality? This looks very fragile to me.
> 
> Yes, you've got a good point there. This would apply to the p?d_large
> macros as well - any arch which (inadvertently) uses the generic version
> is likely to be fragile/broken.
> 
> I think probably the best option here is to scrap the generic versions
> altogether and simply introduce a ARCH_HAS_PXD_LARGE config option which
> would enable the new functionality to those arches that opt-in. Do you
> think this would be less fragile?

These helpers are useful beyond pagewalker.

Can we actually do some grinding and make *all* archs to provide correct
helpers? Yes, it's tedious, but not that bad.

I think we could provide generic helpers for folded levels in
<asm-generic/pgtable-nop?d.h> and rest has to be provided by the arch.
Architectures that support only 2 level paging would need to provide
pgd_large(), with 3 -- pmd_large() and so on.

-- 
 Kirill A. Shutemov
