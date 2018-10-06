Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB88ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D94621473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqBeBF/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D94621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeJGEEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:04:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33921 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeJGEEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:04:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id y10-v6so11559053lfj.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XrZ1rIoRX0Je0zpt4Bba1OkPqbXAIooGRdn7vUd28SI=;
        b=lqBeBF/Dhxw6RqjrUMqCsdSiRYAySdUu7HsPCVWDUbMaq3xMbPV0kqW0AIjnjmMtSv
         HjjQS6kSEXXLykQ7d3lmDJ38/CrQy2ZHZz85HdPqxTIelQJFS0s0JAbltaYa5YbiC9H3
         UQGUOkF9Vg/y+TrI1HHlvK+4j8kWc0LyAyv+gB/2CDp7aBh8qk+lSLfUowHGUbSjknCX
         8G6aZJxFTc4kye2CCz8KZrH+N0Q87ED/v7QSs8A6uCCNQVOou+21wE80mU/qp96U3ZJ0
         cTI9sN/+SGyyoJhK4adSDgRqUwOnf8oBUBDgippcyb7vVMEHQEMcjMGJpLu2M9NoEkrU
         lPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrZ1rIoRX0Je0zpt4Bba1OkPqbXAIooGRdn7vUd28SI=;
        b=XkFeuUAC+iRTOFqpUQ/vWMbg082xbp+9Wd4wsCvtMNTw1zR1bSAgh0Hv2XWRx0Dx3g
         eKyEBsF4bRnlwxANX9AGnOvbUUi0mXsxuy4ekMsI4V8KTxCFXreLd1BA51ryLFWK0A56
         RTdrvNDjqX+HswV7eq2Ou6Wb3z1VOUEoe7kquYbGATluohAmuzyPTPcIoWaMiC5PRGpF
         ZjwqJiKbp3HbqlI6+Yy63rqwQ+rCvFhm4m0YYNyhND8VZAILD8/WOsuyJq2Da6cxWaDu
         hPtdixrb7SXAgtjdOFhiNwKXpWaKBWoOusWR8dLGVYPI6FohCzItAghNhHaBbyWQ9cTB
         mfCg==
X-Gm-Message-State: ABuFfohql+9D20PPjwq2Rdu39RSLXKaiwA2a/IIUPF1F6IhBWTpZj+b7
        bEQHUSpoFvKkeFPDnPR8GTIgWtk/Xn1zDXHQT0Y=
X-Google-Smtp-Source: ACcGV60uRZzl7LqeLxalytUmmd1U8SbJqxsNYeD96MKMll5M0nBnwXL9gLzj3JSg3jkyLI402AxElBHKhdsOSvdb9IY=
X-Received: by 2002:a19:ea57:: with SMTP id i84-v6mr9167383lfh.91.1538859573227;
 Sat, 06 Oct 2018 13:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180923172543.5391-1-benmoore422@gmail.com>
In-Reply-To: <20180923172543.5391-1-benmoore422@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 6 Oct 2018 22:59:22 +0200
Message-ID: <CANiq72=9o+=4prkUNCogmz7D9vqNJj0fUZ93aBRfJzZs_Ni38w@mail.gmail.com>
Subject: Re: [PATCH] [PATCHv2 TRIVIAL] auxdisplay: remove unnecessary braces
To:     Ben Moore <benmoore422@gmail.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Sun, Sep 23, 2018 at 7:26 PM <benmoore422@gmail.com> wrote:
> I have removed some unnecessary braces from if statements.
> As well as inspecting the other driverfiles for similar
> style issues.

Thanks for the new version!

> -       if (err) {
> +       if (err)
>                 dft_brightness = MAX_BRIGHTNESS;
> -       } else if (dft_brightness > MAX_BRIGHTNESS) {
> +       else if (dft_brightness > MAX_BRIGHTNESS) {

This one breaks the braces-if-the-other-branch-has-them that Geert
told you about:

  https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces

> -               if (byte & 1) {
> +               if (byte & 1)
>                         set_bit(LCD_BIT_DA, bits);
> -               } else {
> +               else
>                         clear_bit(LCD_BIT_DA, bits);
> -               }

This one seems fine.

Cheers,
Miguel
