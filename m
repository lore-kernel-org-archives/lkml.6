Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B27C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1AE20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gKOoATMF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K1t+6S3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1AE20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbeHAUe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:34:56 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:41927 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeHAUez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:34:55 -0400
Received: by mail-yb0-f194.google.com with SMTP id s8-v6so7940657ybe.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=l8hLZL8NdtfJMN8z9J4kFr4FGtr+tH0fRo06r4vH2XA=;
        b=gKOoATMFZqZULzjBidG2rGFateL1EqhZsgdf196YarsH+VeuZUZjklTSXwr2SpD9U2
         krO0WSPZouzUJV4He7ruFraxBaDtNTy076FINDKAv0YBhQJFm1QNt8JFoUHKp/7rc5F6
         PScgi2EIzclMGq0vYQapIoQ6gvAJV8G6eGv8MujQBbfvzaGhgAPE2/QENmreDt+tb1Zf
         H5xgO2euzcWDUYpUvAfzoAK7x32IUEm96XiXCCpphxrgeqNZTWWv4STjEzZ/9+E/rD4a
         AIh8cm6a44Tm9Nt56Z1zN+l8l83ikoCI1cPPg7kbxCpu96sKkiqie+tjOs+0+CcMPFTM
         uYUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=l8hLZL8NdtfJMN8z9J4kFr4FGtr+tH0fRo06r4vH2XA=;
        b=K1t+6S3den10kNihHf8xWYSpk3PvPzwokiHPTU22PkdlWOD1dXIdvFfqoo29nedvoj
         6Y2p29lCglQQ072hHuIdWNF2FLgpIrPR7oXhUDXRdflnqcutHj2U+3JwN05MMkEeslcg
         iGwo9XZTFJFvrTNoZCYlOvHMww2halpr6orOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=l8hLZL8NdtfJMN8z9J4kFr4FGtr+tH0fRo06r4vH2XA=;
        b=t6JlaGOjq5YM6AOU9F9P6fRlJLHS07YKzo/ZIOFTKrqvsxQcG2L3IGmDwoYnfwCXeL
         jIaNGOHmbLKJdtFp2uHpTVDiUuw9RorkjdTJvFplD/8Fe+wJF/+jrtxuQbVJcX2gKg0F
         kLf/IGCdJdVRG7KnHFtkZw1HBznTcgUrTZaWkqI1nr2eydfwl5dIZqYsS3g19agKbTRA
         M+aUNqrHVFb/Wdoxubyuxc0Gt67rMoPxOipzqbwKfl7jcugvgwoql1tZjsR0tk8JMdhM
         CB0s13ElZntNMbKOQKuZm7gxoPDVx5QGBMBdupSK4nU69/+RezzF227DSFdelNzFlIq2
         UYQw==
X-Gm-Message-State: AOUpUlEcC8YOvpDMHPpoSzoxgkB9vTdep052IICeMlsQP/tLYfEl1IJo
        24L8aUo2LUi3NrQ3yCAooy92Unl5IpFLmtL7BWmjOw==
X-Google-Smtp-Source: AAOMgpffQQFHAtHm6nb/FTunWoCyHJFEOV7a79ZMwuqbQSCxS20XYL2IoqglUGL/87LYw7znR+9PLBKdL0u21kBC8wI=
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr13866019ybj.343.1533149268125;
 Wed, 01 Aug 2018 11:47:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 11:47:47 -0700 (PDT)
In-Reply-To: <20180801175815.GA25489@gmail.com>
References: <20180801175815.GA25489@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 1 Aug 2018 11:47:47 -0700
X-Google-Sender-Auth: JYDeBZUc78KPcokV8ZP4Sjm34RI
Message-ID: <CAGXu5jJUa36N+Q0K9dbc9xX_LoN=4AZ+CxrDiem==8LEXrdF=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] auxdisplay: panel: avoid gcc 8's
 Wstringop-truncation warning
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Martin Sebor <msebor@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 10:58 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> Let gcc know it is not meant to be NUL-terminated by annotating with
> the new __nonstring variable attribute; and remove the comment since it
> conveys the same information.
>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Martin Sebor <msebor@gmail.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  drivers/auxdisplay/panel.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
> index 3b25a643058c..21b9b2f2470a 100644
> --- a/drivers/auxdisplay/panel.c
> +++ b/drivers/auxdisplay/panel.c
> @@ -155,10 +155,9 @@ struct logical_input {
>                         int release_data;
>                 } std;
>                 struct {        /* valid when type == INPUT_TYPE_KBD */
> -                       /* strings can be non null-terminated */
> -                       char press_str[sizeof(void *) + sizeof(int)];
> -                       char repeat_str[sizeof(void *) + sizeof(int)];
> -                       char release_str[sizeof(void *) + sizeof(int)];
> +                       char press_str[sizeof(void *) + sizeof(int)] __nonstring;
> +                       char repeat_str[sizeof(void *) + sizeof(int)] __nonstring;
> +                       char release_str[sizeof(void *) + sizeof(int)] __nonstring;
>                 } kbd;
>         } u;
>  };

If it's not a string, why not use "u8" instead of "char"? Does the
warning persist?

-Kees

-- 
Kees Cook
Pixel Security
