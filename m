Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75EFC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A356D2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A356D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeLAHHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:07:45 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33462 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeLAHHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:07:45 -0500
Received: by mail-vs1-f66.google.com with SMTP id p74so4070096vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03UuEFJB86lo8oHTD/Pf4zbQwinUO7/WROpTjcy6qdM=;
        b=TTwZA93ftXNMoP9g++WdRVHyCwEAByCtAysjvPM6tXNigBPaRIehGgclGRkePflBZr
         y24dUi+AiUK1s84kpG7Oqmn62A2pVaHDgBTZ/nYZv+3Aw3WzIHZQBmcg9oz92d6kbMTg
         nAEqtG7f0ZUlzL+xfKjk2vYSbIqyYuvA0RX1pSfRp8DPtM3+tcWKyC95qgAzHlgDoxLD
         Sn012f1J5Vj5GhYRH9/1VJSvmF6/aqwZy7trDqsN2k8I9rpiYc/9oRoU0deVsgyA14GL
         6Q1rPVl8KXVYuYZk6QxsmyOfD/SWR+iLRePkvGyzEodp6f4k4OReueYk+rxp5dRvP8RG
         lIhA==
X-Gm-Message-State: AA+aEWZFWjM53xoOb1mKckq0b7XyPw6MQQiJWHiT411jncbEMtXTMqYM
        R5UP9AbLjoqwaI8FDI4Cv5P2yiu/ZH1LLq2jNcA=
X-Google-Smtp-Source: AFSGD/UwIt98Nrxk514z+0Y2hA/D5UExgJElikuldE1KNZSX8ZqJwXeZrnf+MUJc9TmFm+mQaBMqI8d2Pi4/pcXFUh0=
X-Received: by 2002:a67:c202:: with SMTP id i2mr2885642vsj.11.1543607841424;
 Fri, 30 Nov 2018 11:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com> <CAGXu5j+jBNBsD3pvUSfEh6Lc5T1YMpbM0HeG1c6BHiJe+cKVOQ@mail.gmail.com>
In-Reply-To: <CAGXu5j+jBNBsD3pvUSfEh6Lc5T1YMpbM0HeG1c6BHiJe+cKVOQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 30 Nov 2018 20:57:09 +0100
Message-ID: <CAMuHMdXWi2ARLCTPjwXD27KNHo1ghV9sdEuDzeLZ5ihZfbEB9Q@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3
To:     Kees Cook <keescook@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(reducing CC, as per later advice)

On Fri, Nov 30, 2018 at 8:40 PM Kees Cook <keescook@chromium.org> wrote:
> On Fri, Nov 30, 2018 at 11:27 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > In order to comply with the CoC, replace **** with a hug.
>
> Heh. I support the replacement of the stronger language, but I find
> "hug", "hugged", and "hugging" to be very weird replacements. Can we
> bikeshed this to "heck", "hecked", and "hecking" (or "heckin" to
> follow true Doggo meme style).
>
> "This API is hugged" doesn't make any sense to me. "This API is
> hecked" is better, or at least funnier (to me). "Hug this interface"
> similarly makes no sense, but "Heck this interface" seems better.
> "Don't touch my hecking code", "What the heck were they thinking?"
> etc... "hug" is odd.

As a non-native speaker, I find both replacements difficult to understand.
While many of the original comments are easy to grasp for +7 year olds
who were never taught English, but are exposed to modern global ways
of communication...

> Better yet, since it's only 17 files, how about doing context-specific
> changes? "This API is terrible", "Hateful interface", "Don't touch my
> freakin' code", "What in the world were they thinking?" etc?

The last one is not appropriate, as it's shooting at the person, not at the
code (cfr. "You did a bad thing" vs. "you're a bad kid").

If the comments no longer apply, it's better to remove them.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
