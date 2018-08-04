Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25203C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 02:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB7C21774
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 02:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Y65sKUpW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fTtBdbtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB7C21774
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbeHDEEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 00:04:22 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39706 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeHDEEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 00:04:22 -0400
Received: by mail-yb0-f193.google.com with SMTP id c4-v6so3359361ybl.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 19:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=M2qLk78DpmSoHWEmCrQPL0FMKHbPeLiRDI/fmZSDnQk=;
        b=Y65sKUpWpOsd2VXGyDXwpoB+NuOssYPExYmJjeBh9QpNLhNJL4WB/pKYeiRL35vL5Z
         xvUtV+IBXMNFUUXa5p3AHSKoQ2myRqeM/g3pIN9DGj7Gxvme4WU8tDjy5hqLzBL1Fmnz
         DRupV+dDwENzDUO4B8uf44z5o0BtJv8hi2f3gtOQk048U92qp6Jbi8RICqgKmw9YzFs8
         Gk0Ae9NckfhBHNF9B5CuADdqrdtRD0d5Sf3StN1EArbY5kcJk3blnemcbIKvCUsOXj+h
         yVeA/ksyd8KLP1cS9A+rvkie5Ic3sQ7QwJefI3Wai5VE5p/uFUrF8svKtLBIlSzyo0SH
         34jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=M2qLk78DpmSoHWEmCrQPL0FMKHbPeLiRDI/fmZSDnQk=;
        b=fTtBdbtTQYHshmWo7vHNS+F7iHo7ULxpZFVkFV1xyCC3m3jPRpxDUJdw+LZPzvGupE
         5ds3kS6rKEyu2/Ngi/S/I76BBJGWGgG9/uf+RXeT4/8gkssD/ya03gNQbIAhyyXlp9Ua
         kL3SK7qjd9wrYu7y0yGt3dgGepFJXWFXCG8uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=M2qLk78DpmSoHWEmCrQPL0FMKHbPeLiRDI/fmZSDnQk=;
        b=uSYVVkKTzNJFNmSEr22IJVNVsP75hspa/juyPqhqlnufafXAneyEwm+LDNJlmkxKju
         3wQHotNZsSp+w9q1yT3QJJHEENtuyoo6+mm+DNcJr4UFWxOMgTaGN957QeDUyQELftzX
         dwSS78ic5BhsYNoQUJcHjlHfuA/UNudZsc5aazSSa7k4/iLyCt1LvNqL2bCsR2SR9cyl
         fnUENL9pwgejIKb7pe1smV9e1I0BlwSjWltETAHRrHAGq0UXKm/3fU+rDto527Go2Cga
         Jr2JXTIL/9Y44KE+tMwbNdkkYv49eEXLtd+B8h84W+hVNqXZrx07SjIgA36qqUIO8BmI
         chOw==
X-Gm-Message-State: AOUpUlElRnH0BYB/4aA9dRj+4Y8MrHJBTuYtJqD1j4gAzOEsStVD0cH+
        EliJtcoGD9gW4j8dn7X10vrgly/9gKF3IxTVd9mTwg==
X-Google-Smtp-Source: AAOMgpdIa9iT7AcTwjomW24i2XsBeXrUvnn4rGRHtaYhPWmA0nN2VPwPi/3NAuiosElbGte81T9eRjr0fbrLQqFXqYM=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr3503817ybj.112.1533348331286;
 Fri, 03 Aug 2018 19:05:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7450:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 19:05:30 -0700 (PDT)
In-Reply-To: <834feb7bd03c803eddaf00568c7a8e5b2a4712f0.1533287504.git.geliangtang@gmail.com>
References: <CAGXu5jKr_M1zxirDJjbE5fzzhQyXeNWaAkGUK13RDKTBANTbPQ@mail.gmail.com>
 <834feb7bd03c803eddaf00568c7a8e5b2a4712f0.1533287504.git.geliangtang@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 3 Aug 2018 19:05:30 -0700
X-Google-Sender-Auth: A__rdyhbOiyFOUVSubnqoEabb5I
Message-ID: <CAGXu5jJazh2UG9PVnt7JFHcCbMm9mFy2r1_BULkqUhmr5t6Mvg@mail.gmail.com>
Subject: Re: [PATCH] pstore: set PSTORE_ZSTD_COMPRESS to bool
To:     Geliang Tang <geliangtang@gmail.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 2:16 AM, Geliang Tang <geliangtang@gmail.com> wrote:
> Fix build error:
>
>    fs/pstore/platform.o: In function `zbufsize_zstd':
>>> platform.c:(.text+0x172): undefined reference to `ZSTD_compressBound'
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thanks! I'll squash this into the original commit.

-Kees

> ---
>  fs/pstore/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 63cf4813559a..503086f7f7c1 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -51,7 +51,7 @@ config PSTORE_842_COMPRESS
>           This option enables 842 compression algorithm support.
>
>  config PSTORE_ZSTD_COMPRESS
> -       tristate "zstd compression"
> +       bool "zstd compression"
>         depends on PSTORE
>         select CRYPTO_ZSTD
>         help
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
