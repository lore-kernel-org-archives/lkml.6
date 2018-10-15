Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB86C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCEE205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f35dG8on"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCEE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeJPFRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:17:12 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33971 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeJPFRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:17:11 -0400
Received: by mail-yb1-f194.google.com with SMTP id 184-v6so8090117ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JsjZ5+EUTucSseWbLie7tD8XT7FRlccU6oEfb0Tv8bM=;
        b=f35dG8on6KGZUopaDyANwaucCOVX2ZMKQ6Mmyi8Mab8QBc+1Z3cg3OQhAVZ1lGaWw2
         LTZ4G6/y93FeyMbnr8e/uURpU3rLANtSurt7OGLoyJNwzTONPqNsGVG+GKNs6G93A8/3
         gEP9DEnacS/HkYG98xPA5bCHeRq2CCsJlGXNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JsjZ5+EUTucSseWbLie7tD8XT7FRlccU6oEfb0Tv8bM=;
        b=GIzlaVcZeb3RDFWt1xpNuh4Eg0ehadEcLiPE82xOCslZXv2zmPZNMn675yX5chnrMj
         kwIFMwlY2Pc/3v17Av68C9D9N/9v+lSK05WrhxCz2F/ziNjwwTb6e25Lj2NFJ5Pos9aB
         BJ9kDsNc0G6aVOpPygaYi6qsrJ5iy4HF0iE7vINGdo2bH82jkAJflUj92ys06ehFzUap
         mYsvLFzV000b+6KMn4vp+y2r4MDskQobSZo/zsDdUXbtbXP90EcDZ2qhH4HSWhaxAc47
         /BSC6XlkAG1kV7nXOUssCZXFa6m7YHYFZzkfRRA57rjIAyRWJQKrjaRxniGDFjJ0uOvg
         KMbg==
X-Gm-Message-State: ABuFfog1gx1CY5IkQbLZfNPrE3goFu2e3RtCLkPme1wl109VauKr1xDW
        aUQH6inePAHlbbUcu9v/jPUrws4p8SI=
X-Google-Smtp-Source: ACcGV62djIHg2TOKXm2+iSwlE4FwFiYX430xufEjJ74uEjGajfkOC4fMJx1l1f5WtH3Ogk3iIBaqgw==
X-Received: by 2002:a25:8091:: with SMTP id n17-v6mr10267341ybk.209.1539639009152;
        Mon, 15 Oct 2018 14:30:09 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id q2-v6sm2912322ywg.87.2018.10.15.14.30.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 14:30:08 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id m127-v6so8114905ywb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:30:07 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr10692356yws.168.1539639007595;
 Mon, 15 Oct 2018 14:30:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 14:30:06
 -0700 (PDT)
In-Reply-To: <20181013115048.GA3262@embeddedor.com>
References: <20181013115048.GA3262@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 14:30:06 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+p-UivAA8_6Mu0s_uL5mOY0fhxskqnyPSY2+2PL8+i4Q@mail.gmail.com>
Message-ID: <CAGXu5j+p-UivAA8_6Mu0s_uL5mOY0fhxskqnyPSY2+2PL8+i4Q@mail.gmail.com>
Subject: Re: [PATCH] compat: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:50 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/compat.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index d30e4db..06e7747 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -488,8 +488,11 @@ put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set,
>         compat_sigset_t v;
>         switch (_NSIG_WORDS) {
>         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
> +               /* fall through */
>         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
> +               /* fall through */
>         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
> +               /* fall through */
>         case 1: v.sig[1] = (set->sig[0] >> 32); v.sig[0] = set->sig[0];
>         }
>         return copy_to_user(compat, &v, size) ? -EFAULT : 0;
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
