Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3188C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC822089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mYHg9wbA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MnPkkDbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC822089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeGJDUB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:20:01 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39006 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754558AbeGJDTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:19:53 -0400
Received: by mail-yb0-f195.google.com with SMTP id k127-v6so8058707ybk.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 20:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=W41uRWQC3AZjP9FzsT5u6cm6YCxNnEZgHb8fAZLqHRE=;
        b=mYHg9wbA8P5EA2X9RR57hMaLy9Njt941s4ats1opwaZnoJ6bQuZYeZLbzUiH4ntqEz
         IfHdeImVZ5s8AcJNpdr7Kh2z9d3hY/SGOvnyx82HipK0dzhuJc2qleCNXBh7/dOiaYBF
         xP48+YEmhhoy6gXi61wZGgPvGeg2fxrTUCIXrH3MSmwZMu4L6A2Cv46UojgYwat/S8er
         rmbo28SmdHJbIrFPH1X6TdHL+djGlrVi/AWv6Wr2GANpSfEPcfkOyo91z0O2L0LT4Nso
         6htqMfM+0ZY8VmwdM2j1aZY/Hf7A9xJYDevpmP+U6MQxMTBFJSskyUCDeu5p4eHxYHWf
         5HsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=W41uRWQC3AZjP9FzsT5u6cm6YCxNnEZgHb8fAZLqHRE=;
        b=MnPkkDbDpQS+We1cB6Djkut84Jg8uh+x8/S0rJVpzjXdnkS36rCMQL0dA4sRDCNgaX
         S23i++4zfMniIaNjMw65DMCRPoWnFQP21bEiXC3u3dMMUKU+rGiXhiXSzZKw8vhrlj3e
         xV/y4YlXh1cLrxSx7Jf7AYOwB1mCjZoCbPsBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=W41uRWQC3AZjP9FzsT5u6cm6YCxNnEZgHb8fAZLqHRE=;
        b=Crndy+2jRBqB/2irlJPlLWhoHso0MIHYyjqnccb08z8r9CA+NhUqNH12k/AOez/8LQ
         5oQqq1HrPOzWtxVmosGvwgXw7Ev5Smye+2XPNQxwaBeunIQ/q/wRVJeyeUHj/Tp+7s+q
         5OVGahJnkROpdIaEgthqlsJoyzDWDzlGkBOI6OxHyoPHCDMqImqkZdFC9TKeKASpwTtO
         ytdcOZbDIGGfkeJrsWKzaOLWO0PG4z7yP3MCeN9WKpwvBwGqe7IFZql3U8CbNOGIt7xQ
         +1pJ9PvsW7hyNc0N8QDGgPQbz8upSmrwpsoLh1a5+Jt7B2IrsLXUZ762oY17RCJ4/Gh3
         8oAw==
X-Gm-Message-State: APt69E2bAXhQQKs1gusH50p+JzjRGrvb5WWCwHhv+KXTtI455EloNY2P
        SpKkZL97o3Us+Nd2yofgYX1R/DFGoQIJKIZOWAwsyg==
X-Google-Smtp-Source: AAOMgpegqsZ80t2i59MwS76OqsjXpji2dTnzpooOmxyJq10WQlY85uAviUic+gIrle7m7CJFL4hrG++mr3H3yBIPjMM=
X-Received: by 2002:a25:a483:: with SMTP id g3-v6mr12051134ybi.309.1531192792491;
 Mon, 09 Jul 2018 20:19:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 20:19:50 -0700 (PDT)
In-Reply-To: <20180710020836.23571-1-mpe@ellerman.id.au>
References: <20180710020836.23571-1-mpe@ellerman.id.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 9 Jul 2018 20:19:50 -0700
X-Google-Sender-Auth: 1V8L5CVbOdR4WD8USJrv0syWH5M
Message-ID: <CAGXu5j+JvY34VRH17=2xgT0ah9Tmj=jchZsxjSV03B_0cN19eA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Add powerpc options for spec_store_bypass_disable
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 7:08 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Document the support for spec_store_bypass_disable that was added for
> powerpc in commit a048a07d7f45 ("powerpc/64s: Add support for a store
> forwarding barrier at kernel entry/exit").
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> I tried documenting the differences between the PPC options and X86 ones in one
> section, but it got quite messy, so I went with this instead. Happy to take
> advice on how better to structure it if anyone has opinions.
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index efc7aa7a0670..f320c7168b04 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4060,6 +4060,8 @@
>                         This parameter controls whether the Speculative Store
>                         Bypass optimization is used.
>
> +                       On x86 the options are:
> +
>                         on      - Unconditionally disable Speculative Store Bypass
>                         off     - Unconditionally enable Speculative Store Bypass
>                         auto    - Kernel detects whether the CPU model contains an
> @@ -4075,12 +4077,20 @@
>                         seccomp - Same as "prctl" above, but all seccomp threads
>                                   will disable SSB unless they explicitly opt out.
>
> -                       Not specifying this option is equivalent to
> -                       spec_store_bypass_disable=auto.
> -
>                         Default mitigations:
>                         X86:    If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
>
> +                       On powerpc the options are:
> +
> +                       on,auto - On Power8 and Power9 insert a store-forwarding
> +                                 barrier on kernel entry and exit. On Power7
> +                                 perform a software flush on kernel entry and
> +                                 exit.
> +                       off     - No action.
> +
> +                       Not specifying this option is equivalent to
> +                       spec_store_bypass_disable=auto.
> +
>         spia_io_base=   [HW,MTD]
>         spia_fio_base=
>         spia_pedr=
> --
> 2.14.1
>



-- 
Kees Cook
Pixel Security
