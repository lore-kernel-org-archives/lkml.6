Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B981C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD962081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpNSzciR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD962081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbeK2Ehy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:37:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38143 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeK2Ehy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:37:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so24208481lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/QuhxiVq/xxyT4idFm0A4A0PmbM8weVG/FM8Lm7YGUQ=;
        b=SpNSzciRmXPQikMvb/KMmsJ9Kkukvlrhw6IvvgXypHOFxl4aXsk8VNpt8vn1EPMQ4O
         8MTuCA/0CfVKX7oiv2+OcetGjKoJMnEyUmJyBuULBCcDnwS8eFiCrffWs0OsVV2qyUnX
         eI20RlTpjE/IiPgubPqIjH+DXDrvs06wGG9wH2CudZ4G3CoayitYJpGzN3kNr1DbPhcG
         F2rTEOxqGd1c1dEVmdaAR7SPrt3F1TY9lxfvw0CyALHTJAdAH2xbROe0yWYnnUy+3yxt
         YwXYfoe0r6uTezUNRMkNpEkOFOmTHpE2qm53MsDDFfdZ/Z3w1z+5HaOxq2E3Sd5x/VmT
         evog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/QuhxiVq/xxyT4idFm0A4A0PmbM8weVG/FM8Lm7YGUQ=;
        b=ULc7PESC/xdhAfO2rLuKLbpVlYeYxJALf5fqWItELI6LDMe3TjwF9AN9mt1C0CmiFy
         Q66uyUJk39n937LA7lfHx4Zvc7gz7mqdj+shBXKL0X/es4+ZnZMHBPgrJWQSyeBZOw94
         D1Y6yNizy8BwmJVgJvp2vVeojLj7ecwbLhFP74GIaA5yhbHB17UzWfkyLWcm0hGheSfo
         aqGMLNt12RWVy/+j61SkD6hLbey8wPJNj7VB+DqO7AUuEuQVDM+bcyCt+Bd/xuG2ToLA
         iCx2QLpf+PQJ+UtcvkcjANizRJqphIQgeQFwAYjegtxnHf61hkxqd35yRgZSSGlxLDKI
         OUYw==
X-Gm-Message-State: AA+aEWYH3w9Mz8oAqlNsjMe7Xh5nl+Sa0/GqXS2pQ0rJW3U2XQNVZEvy
        06OAsAQz9n4OrHUWP8czAJgvKYig0M5+tWcbA3A=
X-Google-Smtp-Source: AJdET5eo9c3wYqeOyeoWRCmdO8/GzOre3em6kYnV4wQrfJ/JUqfpf7H9WmNNSqhjZFJsmzo5WxJZ4+gZQj9Q7pw00eA=
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr26285522ljj.61.1543426529224;
 Wed, 28 Nov 2018 09:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20181128140852.178260-1-liuxiaozhou@bytedance.com>
In-Reply-To: <20181128140852.178260-1-liuxiaozhou@bytedance.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 28 Nov 2018 18:35:18 +0100
Message-ID: <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: move kernel-only attributes into __KERNEL__
To:     liuxiaozhou@bytedance.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaozhou,

On Wed, Nov 28, 2018 at 3:09 PM Xiaozhou Liu <liuxiaozhou@bytedance.com> wr=
ote:
>
> Attributes such as `__gnu_inline' are meant to be used within the
> kernel. When userspace somehow includes <linux/compiler.h>
> (eg. tools/bpf), compilation errors would be shown:
>
>         "error: unknown type name =E2=80=98__gnu_inline=E2=80=99"
>
> So just move these things into __KERNEL__ and the behavior is kept
> as before.

That is not exactly correct -- a3f8a30f3f00 moved some attributes to
another file, moving them into __KERNEL__ (in particular,__gnu_inline
is).

The problem is, instead, that __gnu_inline is not anymore defined
outside __KERNEL__, but something else that uses it is (the inline
macro definition, if I had to guess).

If your problem is fixed by putting __gnu_inline into __KERNEL__
again, it means we can simply move the inline definition inside
__KERNEL__ too. That way, we don't pollute userspace users with macro
definitions.

Having said that, does someone know whether userspace should have
access to those attributes (or rather, other code that uses in turn
those attributes)?

Cheers,
Miguel
