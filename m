Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F03C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C285C20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQPS8q3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C285C20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeIMUFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:05:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40200 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeIMUFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:05:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id x26-v6so5063596lfi.7;
        Thu, 13 Sep 2018 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZNGI3bxgnHi2twseODwZwYAj6vZMnio6OiOnqsl0y8=;
        b=gQPS8q3AQcsc/oVSVASp7B/hJrf5/hYCbrK/Ntkc5d9kPS3H5qaNuG2Gkx/8HPCyAn
         YeUTvjMPOTw/euqtpoqYAWnCDBcWpqotv6AxB6PVIu41OczIAMejnDRRzGozDSl+Pq1A
         aVEXX3PHqkwIqUIws5gAwYL7idDd4q3rt6zWyThuJGQROhpAj8Ew4+1zQQ1GdD5We9we
         /C/oqS6J+P3sa4kSj7EVa8/6GQ7nSVyJU9bZ/8TmJWzmLaxU0hNWV1OOzbjUvGryrRDS
         HfsfI0vgjARhaM5BjLv4201mIdUFzO3g2JimSRWcPBc8FAfYf9895miXLR0DyGX4nmbH
         pM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZNGI3bxgnHi2twseODwZwYAj6vZMnio6OiOnqsl0y8=;
        b=sONFUPLa6FdXb43smWEIqeMyfVCim7+K/7M/L72FntjOC+OlVPxRlY0o0HlGNVWqRG
         CxJLhggc8c3YOim0+xWlU5uVdCo5Vr6H2xPRuiC5fXvJnSakRmcyobwFAto6THGSWvHi
         +V3NsqyR3HrkVoyWTjYkvO4GlA4PQDFOJLlgabtS80p6X8r3kZyhniPJbeCV8Loo2KJr
         /kxL46SPzNszoWbiIQO22qG4zhiFvpabZtJl2Htqq+AG9/14irKUF0yYPjiTlLNVTs5E
         gUizJi0zoWXqi6eVoh3ROoSgNYM+SEuSqSneXsn/+sZaAR34UEL5tPGmq9gqTMnbCX+y
         +FvQ==
X-Gm-Message-State: APzg51CJHb/VpcTnJCC02qvQ5DGd4QlFNvfAWnWuMYCBP2Jm2zhzTbDs
        EvI/K2sH3Mgpp1tP6zQYSsP+sxJkUkOuJUXpbik=
X-Google-Smtp-Source: ANB0VdbBTNOydnEFnylAbFb3eucbChORpPIwmw8PVHaS1mkDzR7ILg8dtb1KUlIUS0vlN/IvNpSJh80P8dhzR0NoN8g=
X-Received: by 2002:a19:9153:: with SMTP id y19-v6mr5011546lfj.98.1536850520626;
 Thu, 13 Sep 2018 07:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180913131823.327472833@linuxfoundation.org> <20180913131829.659361485@linuxfoundation.org>
In-Reply-To: <20180913131829.659361485@linuxfoundation.org>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 13 Sep 2018 10:55:08 -0400
Message-ID: <CAKf6xpvseyNJtbr3fp=qH4kMeJReBd=fm5Kn-DpqoZL25moVqg@mail.gmail.com>
Subject: Re: [PATCH 4.14 102/115] x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear
To:     gregkh@linuxfoundation.org
Cc:     open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 9:48 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Juergen Gross <jgross@suse.com>
>
> commit b2d7a075a1ccef2fb321d595802190c8e9b39004 upstream.
>
> Using only 32-bit writes for the pte will result in an intermediate
> L1TF vulnerable PTE. When running as a Xen PV guest this will at once
> switch the guest to shadow mode resulting in a loss of performance.
>
> Use arch_atomic64_xchg() instead which will perform the requested
> operation atomically with all 64 bits.
>
> Some performance considerations according to:
>
> https://software.intel.com/sites/default/files/managed/ad/dc/Intel-Xeon-Scalable-Processor-throughput-latency.pdf
>
> The main number should be the latency, as there is no tight loop around
> native_ptep_get_and_clear().
>
> "lock cmpxchg8b" has a latency of 20 cycles, while "lock xchg" (with a
> memory operand) isn't mentioned in that document. "lock xadd" (with xadd
> having 3 cycles less latency than xchg) has a latency of 11, so we can
> assume a latency of 14 for "lock xchg".
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Jan Beulich <jbeulich@suse.com>
> Tested-by: Jason Andryuk <jandryuk@gmail.com>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  arch/x86/include/asm/pgtable-3level.h |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> --- a/arch/x86/include/asm/pgtable-3level.h
> +++ b/arch/x86/include/asm/pgtable-3level.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_X86_PGTABLE_3LEVEL_H
>  #define _ASM_X86_PGTABLE_3LEVEL_H
>
> +#include <asm/atomic64_32.h>
> +
>  /*
>   * Intel Physical Address Extension (PAE) Mode - three-level page
>   * tables on PPro+ CPUs.
> @@ -147,10 +149,7 @@ static inline pte_t native_ptep_get_and_
>  {
>         pte_t res;
>
> -       /* xchg acts as a barrier before the setting of the high bits */
> -       res.pte_low = xchg(&ptep->pte_low, 0);
> -       res.pte_high = ptep->pte_high;
> -       ptep->pte_high = 0;
> +       res.pte = (pteval_t)arch_atomic64_xchg((atomic64_t *)ptep, 0);

For 4.14, I had to change this to atomic64_xchg since
arch_atomic64_xchg doesn't exist.

kernel-source/arch/x86/include/asm/pgtable-3level.h:152:22: error:
implicit declaration of function 'arch_atomic64_xchg'
[-Werror=implicit-function-declaration]

The same is probably needed for earlier versions as well.

Regards,
Jason

>
>         return res;
>  }
>
>
