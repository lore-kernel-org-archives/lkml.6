Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A264C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0397208A6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NKioqYkj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UDwkqaRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0397208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932184AbeFTEoc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:44:32 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46283 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeFTEo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:44:28 -0400
Received: by mail-yb0-f196.google.com with SMTP id s14-v6so750306ybp.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 21:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bOm52RBV+3jRukipRzN20uhnWac1lJVmbPeAtmCvXfk=;
        b=NKioqYkjXL19kaWDc7k4BqkLmxCeRBYtLHvHSaDRfl1YA/o6rTsecSqz3XnQE5Xsv8
         ONyZAnypJgz+MNQPmsD+CWp6WX88kuqrnnqTH84EOFTMvJqqxQAXDb02fzeMr6IxDOTv
         Gp7+9D5yQkqejm5Wy+yW0mgcqjSmAlFuEv6qt57eQYAcDNGVgJQzibCznYGhVYF2oklj
         OnLjR2YasjppUd/a07Wge6IouZ+vMcMYmdoamcmQakxqyK8DAg9LbgY0Pr+eQ5X6dQW2
         winSyixaXuSq4EDNn5N5wmvm5wKk7YFjwm47Loxq16pXNKVWpd6ZBdztm98z/Ze0s25j
         Fp2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bOm52RBV+3jRukipRzN20uhnWac1lJVmbPeAtmCvXfk=;
        b=UDwkqaRn6MCff7ybaD8ISwFL5yyDXUCfq7350zUQt6/lxNRVZIwlPAGH7yNnVN6xV+
         kp9h4S0rNeQeduPN1t9+b0IHtWax3bLSuMZBrmiDfpyi9wAqbrDvj2hwA1vv2RdRPOgL
         p9KZ2Pa4IFXw+11AdCoF1SgxzLQmPaOv+vUX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bOm52RBV+3jRukipRzN20uhnWac1lJVmbPeAtmCvXfk=;
        b=ZsCOZWcGF+KUuaq1ELFQuz3Eb2wg1kqXoHd/vcU6jbtVZa/DZKSIcS2k6hk9UskcHB
         RTXMg1/EVuLP6mumaG2gjAwn0OwgG+AcW9odRYsPbgh2l0xiC7QXCKZcm/a3z1G7DZtV
         mBQfr+B0RU73tNP9rS+D4WCz7QAIgWEFUyFoGBLxSJj5iHLZjqupy92H4tSG9PuUo4CJ
         hxIFYSlUkq33RyQftDBng+VsK6nnDTYapscsLsq0z0ziuGN7LkIgoUw5EUNeLUqsCyrX
         LvSovAJH0hchLLpF3g5/PFgNZZXuY3yxtsN/0rwxSAEixLnz5VcOvcBXBkSE7r7VHVgU
         v2mA==
X-Gm-Message-State: APt69E2EZ0K27PkdHssupvFV+Sn1wNLpWPON5JZv1VLP0f1NZ+PQai/u
        Md/cGxTgRnyhFRK6mBva82QBs5jttiZwpV3JTJpG4Q==
X-Google-Smtp-Source: ADUXVKJtkapH0/HFKD11HrAQ4lSnuH+n72UiXurRRXzmGVQCd83h2R71+xH0UgNOuebl9MGw6ohQRww68miSlag7q7A=
X-Received: by 2002:a25:8b05:: with SMTP id i5-v6mr10094404ybl.484.1529469867825;
 Tue, 19 Jun 2018 21:44:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 21:44:27
 -0700 (PDT)
In-Reply-To: <20180530205712.GB16286@lunn.ch>
References: <20180530204830.GA24884@beast> <20180530205712.GB16286@lunn.ch>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 19 Jun 2018 21:44:27 -0700
X-Google-Sender-Auth: 1stkckEj8PXB8GYCDZ8s0Peu_UY
Message-ID: <CAGXu5j+sh-gSXvGg25oN9Xsyw1W=i177=52ZXPV3OvEym6nr7g@mail.gmail.com>
Subject: Re: [PATCH v2] mdio-mux-gpio: Remove VLA usage
To:     Andrew Lunn <andrew@lunn.ch>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Pramod Kumar <pramod.kumar@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 1:57 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, May 30, 2018 at 01:48:30PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> moves the allocation into struct mdio_mux_gpio_state during probe.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> v2: allocate array as part of structure (Andrew Lunn)
>
> Hi Kees
>
> This looks much better, thanks.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks! Who can take this patch? Linus?

-Kees

-- 
Kees Cook
Pixel Security
