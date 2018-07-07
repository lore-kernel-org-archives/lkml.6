Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35B7C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9112E2154D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2pLGimD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9112E2154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeGGQTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 12:19:08 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40742 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeGGQTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 12:19:05 -0400
Received: by mail-ua0-f193.google.com with SMTP id j17-v6so9369122uap.7;
        Sat, 07 Jul 2018 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RC1Pst6hxClvYer0mbDvFmNaBNBzLwR0pc+0eedKmig=;
        b=k2pLGimD5ufTPGi+44PkRabJ9T3g0669Odg2j7BELzBRvygv8IiMMUSJejnbEDiS83
         gjvegkSObxol3Ysu3t2+Olyqv7lxowLFHxsUFzXu6VRfkRGyu+A1NhthOfY7tfmtDoqI
         sKYuAQ8qN8vn1T+qriqaNTLqva2AuLfloqPvEHG4A5kCZIrnEhdr7kU0tUUJtzlQY8/s
         78yNsruBcwj9h+CBcwsSvDD1ny8Ic4KhZFYZzjcUaQ9C3iEpezF4/Jq2GwiNxb2IBid/
         W55jmWgYB+HhJ59NhPfzSHjL8duwhD+OOb62FL1xWsUNjC5Xd41hFrzrqsKKVgFuqe3G
         jwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RC1Pst6hxClvYer0mbDvFmNaBNBzLwR0pc+0eedKmig=;
        b=JnXufWnhn94cQ3y1/1phUiMVOGd+kT7Rn9lJVy45D+CAPH+IZOrJ88qWy87EaVBKvw
         3TAtMlRWzdhrrE9KNMqoDoPQUzCUYV00x6UZPkdykA5hX3r/7KyP122E1MU/j8DZ6rYP
         Mvdo+MiSzfFooDbyPdrENgQYFfS4k5HYKRwhgMLtpqHLFf79nQKF0zJHp6SElzw338wJ
         iRWTFssgi08vtEUQjXCBDWCmrkVResPYCfHJGEHTOK+lxetU5U0KvpV6I2mRQ+zdHkPx
         8MiKt01m2FktBeT6CG8x6nUCiuHX+3qlok4Z/45dNDFNm/JmMzP9BzsM8UcYSxuVP8pm
         1Pgg==
X-Gm-Message-State: APt69E2oMCTJxs44n9NfhWoJy38cdkBn6Jn3q95kzLJik0Saanjnpx5w
        zIzX0NseH8wW8fD7F0cxgIYk4/Cd511t/h7pdTczFw==
X-Google-Smtp-Source: AAOMgpdpWyiLiU/4kTKT/s3lDF5LZYFiMRFaCJrUcT/xNzp+mV5GGIM/heLNzsMif0e7QgQ7yP/pjTW61Pr0q3WuHyc=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr8776681uaf.199.1530980344942;
 Sat, 07 Jul 2018 09:19:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 09:19:04 -0700 (PDT)
In-Reply-To: <20180706232427.GC3041@fury>
References: <20180705204703.GA12352@embeddedor.com> <20180706232427.GC3041@fury>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Jul 2018 19:19:04 +0300
Message-ID: <CAHp75VcZ96tU5aKfNuSn5emJzavC1W3C2ovdwgWE-66kF0xWGA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: sony-laptop: Mark expected switch fall-through
To:     Darren Hart <dvhart@infradead.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mattia Dongili <malattia@linux.it>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 2:24 AM, Darren Hart <dvhart@infradead.org> wrote:

>         return AE_CTRL_TERMINATE;
>
> Is unreachable as there are no "break" statements in the switch, and the default
> falls through to return AE_OK. Something doesn't seem right here.

Darren, I didn't look at the code in question, though just to clarify
such error codes.
If the function used in acpi_walk_namespace() or alike, AE_OK means
"To continue", while AE_CTRL_TERMINATE to "stop, whatever we looked
for is found right now".

-- 
With Best Regards,
Andy Shevchenko
