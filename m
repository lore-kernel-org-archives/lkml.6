Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F31C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 08:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCED2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 08:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Syen7fyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCED2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbeKQSQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 13:16:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35626 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeKQSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 13:16:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so22304565ljb.2;
        Sat, 17 Nov 2018 00:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPmVE6Z//7mdbjzZgiWeE1qLH0fiwOI7p2Z/iAYJijE=;
        b=Syen7fyiequm7d8bQcmQPVz3JWVGqMMEXGPflRrAFD9ZmkkIkFhvE254qWtGkMxUx4
         2VKUEvsKza2J7VjAI8SdkSYAuhSUMXIA1UgfFAN9gyNn87qOVFL196vERQR1fVhmyMxT
         7V2LQATzn2aO9gMoY7NCfn1781wY4sQrip1XKlwgaYnMCQw88GhE5newQtWMewl6aeG8
         K+CPtHqptc1Yg8O4vUhFina/4CUZCCs7sqzWq2ZzoTw4IWY8djL21szLfxtzYxdl3VJo
         dLhccgR/BzrcasCK5Chvk/CqK6QmeN2uSitgZw7WPg9TQpfs8wACHNfN0WswN4F0PyoK
         J1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPmVE6Z//7mdbjzZgiWeE1qLH0fiwOI7p2Z/iAYJijE=;
        b=tTHgjrsNxhmivOFAPSFmWlR8FXP9EfZO9jd8oypTDIakuSSZheM9J4FB1V8tnB1BdB
         lDkXbBDBJIaKtudFjWMn+Dbq46zVr2BXWNmCTFZCGeo9no95ZMwzZCDY1OED0w+MfFpn
         ofpXKh2vI6z0dbeU9XIFzBnVDyUpTTHfubCeDQVcyPOvyICL+/IU4XbcQ+9bCgsq/3Hs
         ZSnFbTaWjy8hFFJ18RW4sxlfUeGyG58pw8N6nH6w9yqrscqkkkGE9t9+k23+GYealPnI
         vzhPn+SI6Ne1MGpzkPl88VxlIuHS7NRwoC8T5KBOqkOWjJlgXvsGZ0187a+7wR+DNArl
         33eA==
X-Gm-Message-State: AGRZ1gJp4x82pMCz+rWE94Fw1cAb4/2r+CDVzmyahkzIQJ64gIwOlJUq
        KJbJfZvgRcCWu0z2LhY3dROy3uyo4DBFCm/2zBc=
X-Google-Smtp-Source: AFSGD/XssBmWLLbPiHcyqcnseW87gPuZGDVCIcUFNENgfL3/pFMO4SFW4iO5T4p4jZlZ9ZPnc5PFecJjNB7QstH4YcI=
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr3436353ljh.139.1542441640429;
 Sat, 17 Nov 2018 00:00:40 -0800 (PST)
MIME-Version: 1.0
References: <20181031111444.3472-1-malat@debian.org> <CANiq72mj_iHvxqAEqhGoLT61Tc04-zN6f7Gv1jyNeb6d0R2LGw@mail.gmail.com>
 <CAK7LNARyykVuHT1YQ_UWVMFRG-K3VQwEXtjGQxQE4Fgu4wQtDg@mail.gmail.com>
In-Reply-To: <CAK7LNARyykVuHT1YQ_UWVMFRG-K3VQwEXtjGQxQE4Fgu4wQtDg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 17 Nov 2018 09:00:29 +0100
Message-ID: <CANiq72=UbXHZNDzqOJe7MQ5vZ1tiSD_YJNESG9g6-dcQ409BdQ@mail.gmail.com>
Subject: Re: [PATCH] remove old GCC version implementation
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     malat@debian.org, Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 5:14 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Wed, Oct 31, 2018 at 8:28 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > By the way, is it possible that scripts/ and similar stuff uses
> > directly include/linux/compiler_attributes.h (whenever it hits
> > mainline, see https://github.com/ojeda/linux/blob/compiler-attributes/include/linux/compiler_attributes.h
> > )? It is a header that does not depend on anything, so it could easily
> > be shared; and would avoid having to maintain two sets of attributes.
> > Let me know, I can take a look at it if you think it is a good idea.

Landed a couple of weeks ago.

> No.
> I want to share a header file between kernel and host-tools
> only when we need to do so.
>
> In this case, it is wrong to use the linker magic for the host tool
> if you look at the so ugly #if defined(__MACH__) part.

Do you mean this line?

  #define SECTION(name)   __attribute__((section("__TEXT, " #name)))

I would say having exceptions is fine, i.e. the idea was to reduce
"duplicated" definitions. In this case, the #define has a different
name and style, so I would say it is clear.

Anyway, if the policy is not sharing headers at all, that is fine!

Cheers,
Miguel
