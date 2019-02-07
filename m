Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A55C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D052190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTMHno2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfBGPz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:55:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35317 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:55:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so125180plo.2;
        Thu, 07 Feb 2019 07:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kei47JUaqGp9fxR3dXHBvQeIoZJwbGRLt9oqZ28V3xc=;
        b=LTMHno2BER++z3F1cnLKOc7AhtbUC1tvbL4NOYH0NXCXufoKsQf/qUZWONvqxl0l+N
         vB6aVwPzCkv5x9nHDgVSQNdBY/2Hx3FucuwI2PC/wLolj/fa6Gofc58ReDSz6C9AWXKF
         idkNnix4mW92uBz54MlAzVMxy+SKz7k+N+2B9tL4rKTqeDuVPxVXSoxHvLitSkjJBIgy
         nMwjv36bddLKNJ9d6fLJ2+E9ndYV3gW3/TCHgJPQq9t8gMVx/5usyRkVHq8SSHR5Ur+2
         FnGrdiogza9nxEaShtvJ7M/djD78IXCPQzfE7R9fff4WLf4BXM22HKisZSLGYkgu6yfJ
         RvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kei47JUaqGp9fxR3dXHBvQeIoZJwbGRLt9oqZ28V3xc=;
        b=pEHJ+j4Oq+Qgpf+13MB1j69g3P7/21E8ttK9u2PNLySODCuEkuU9r61glG0IeUk5DM
         iuaS54T5mSFrDsEB5DDyOwVHnVyL646Vn+lsr9yK3AcelnoL0KE1vOqt7/+eAd6A3sQQ
         glr+rXLw/B2rI4RmYepPrwwIJmPeNi2p1VUVvwcDc0tHIVtYGVXPau209zGoBwIaWdVI
         ZlhRzmmvRT0bdHHPVM3fRIU8bH2oGS/OGpHxUIHn2cktjqlRjF33crNb+qDm1AG4PDq3
         iTdNDa0fJKtNW3S9UdF09VcFKxiSfO1bCI92qhILJRjL2gD1OYWi5aEiH8XUBu3lu8GZ
         lcJA==
X-Gm-Message-State: AHQUAuYx3xmzDhe49Lm7Hs/cu6R/RB29ai2hO7oOEgIIf2SgB2kTNbS3
        mgbCwufVFCRmAmZ6zJN4oY5AMXUs0UeB+twA71r1mKOD
X-Google-Smtp-Source: AHgI3Ia8nQMFoQG0OIQXBflWM651fMQdz6/TxdXoCAOl5NhojcSgZZpiWZu9r2NJcx7tv11SWsuGdykBcsHRUQkXX0M=
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr17131082plg.314.1549554958197;
 Thu, 07 Feb 2019 07:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20190207095703.564e76b2@canb.auug.org.au> <38152c55-c2c1-c89f-2751-0ef0d40fcba9@linux.intel.com>
In-Reply-To: <38152c55-c2c1-c89f-2751-0ef0d40fcba9@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Feb 2019 17:55:46 +0200
Message-ID: <CAHp75Vf6gs1342N16MZHvPmiiv3+xJyMyyJQK677KPZbb_7Vrg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the drivers-x86 tree
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Darren Hart <dvhart@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 4:06 AM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
> On 07-Feb-19 4:27 AM, Stephen Rothwell wrote:
>
> Hi all,
>
> In commit
>
>   4284dc008f43 ("platform/x86: intel_pmc_core: Fix file permissions for ltr_show")
>
> Fixes tag
>
>   Fixes: 63cde0c16c67 ("platform/x86: intel_pmc_core: Show Latency Tolerance info")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Did you mean:
>
>   2eb150558bb7 ("platform/x86: intel_pmc_core: Show Latency Tolerance info")
>
> Yes, upstream commit is 2eb150558bb79ee01c39b64c2868216c0be2904f. For some reason when i do git show on my repo with both these SHA1 i see the same patch.
>
> I will fix this in next version.

Hmm... this came to our published branch, i.e. for-next, would it be
better to update it via rebasing?

Darren, what do you think?

-- 
With Best Regards,
Andy Shevchenko
