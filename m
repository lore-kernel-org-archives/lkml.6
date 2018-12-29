Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA50C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8D72184E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cikA1iQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeL2JSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 04:18:11 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:40549 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeL2JSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 04:18:11 -0500
Received: by mail-it1-f177.google.com with SMTP id h193so29449826ita.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 01:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLkqG3nKcd0lTsqiWLlqAWjPHPJTG5QkaExKzZNJIQQ=;
        b=cikA1iQyu/ElwFNIcKp6x3njQ+21za/IdwN9/TWcy4YtWYsw3rtw2UlWHeEnzYIRVl
         uS03VYntlBat/fOJjfTEBUqYv4x6S/NawTSU99ox32X+4C+4HnlN/N5BOMxdBlimrBpe
         wgOKVtxnmbE35E90cv597ZE2ldQTfk0CjmxU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLkqG3nKcd0lTsqiWLlqAWjPHPJTG5QkaExKzZNJIQQ=;
        b=nC5Zx2QvfysfFXMJPBthb1nEEDYMYlO+HtFZxcTRUNiTK5DMCyq85A/QfaaHRk/JhK
         gF5ibl27oSQptnCkqXdk4WjhbEiYwxytPKxZqVUl63+0qYMdPx9FymVWe867QIifYSF/
         IrTzAdTB8rJufI1Zc+4i03Vh384A8PcOutYFtIP1fu0UzPsEGf16hCDRr+ZKQcm4+kvE
         oLOE7cgXSH9olMx0JmCzmh7mVA8WO5x2xu0sxSqDStosKNHzryPNfrYrowwAXXRSIw78
         d0Z2O0UmYWVRbfwRdbrdb1nH45KGbDQ+DK1sjRem1IBcH4m5QHKYLMPEYKU/ACIQmQMQ
         DJ9Q==
X-Gm-Message-State: AA+aEWbK+pZuBYnN5ZL8fPqLZFpS8RvbsPlyBgm1eY+WNXvDfGn92gwO
        /BhdCxLrEkvbT+e7IlY1IDNWV/Z76ho//K75uxmMQw==
X-Google-Smtp-Source: AFSGD/VdgZ6uJMg3u74ZS49D4rnRTJiBWbcr2UDALfLGoZf36WFiM3iMcGvFT0QnGY53/0hlliQ355LRfC/vU3Rb9v4=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr21614405ith.158.1546075090440;
 Sat, 29 Dec 2018 01:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20181226023534.64048-1-cai@lca.pw> <CAKv+Gu_fiEDffKq_fONBYTOdSk-L7__+LgNEyVaNF3FGzBfAow@mail.gmail.com>
 <403405f1-b702-2feb-4616-35fc3dc3133e@lca.pw> <CAKv+Gu_e=NkKZ5C+KzBmgg2VMXNKPqXcPON8heRd0F_iW+aaEQ@mail.gmail.com>
 <20181227190456.0f21d511ef71f1b455403f2a@linux-foundation.org>
In-Reply-To: <20181227190456.0f21d511ef71f1b455403f2a@linux-foundation.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 29 Dec 2018 10:17:58 +0100
Message-ID: <CAKv+Gu98AOB2LfQGMUHNc_B0MBvd3gATvtPypQaV1vgTcf87ww@mail.gmail.com>
Subject: Re: [PATCH -mmotm] efi: drop kmemleak_ignore() for page allocator
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 at 04:04, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 26 Dec 2018 16:31:59 +0100 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > Please stop sending EFI patches if you can't be bothered to
> > test/reproduce against the EFI tree.
>
> um, sorry, but that's a bit strong.  Finding (let alone fixing) a bug
> in EFI is a great contribution (thanks!) and the EFI maintainers are
> perfectly capable of reviewing and testing the proposed fix.  Or of
> fixing the bug by other means.
>

Qian did spot some issues recently, which was really helpful. But I
really think that reporting all issues you find against the -mmotm
tree because that happens to be your preferred tree for development is
not the correct approach.

> Let's not beat people up for helping us in a less-than-perfect way, no?

Fair enough. But asking people to ensure that an issue they found
actually exists on the subsystem tree in question is not that much to
ask, is it?
