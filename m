Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89E4ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C9D20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OW3AvPR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C9D20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeIRJdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 05:33:15 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:18889 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbeIRJdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 05:33:14 -0400
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w8I42T2S006728
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:02:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w8I42T2S006728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537243350;
        bh=/wO0g/OVEB9tQ9FcyI6hXPVr2ORszN12wlJr9qhS/Rw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=OW3AvPR5+zCm4NVL0mZwzUuPfDu5O8BkWeWZt5XDz1gi+4ztiU+kBW81/RV3Z8t2g
         jEdoE0OpICVvxtO4/4hqpUwEXDQRrRillSHdeNYAUPwubqScLnneEbFt05zAQO1+Kv
         5R45ExhglAF8Bu09v2CPi2wPb9y1XcqMTHP1kqthtobP3W9L0VKNFtwW2EoBYqO7Cz
         qChoNOaoJeUnAwFcxU6HXFDlzRFA9/DiLDMkZ5Tb0qgdbJo9HbcOiX4eYqhIKgEHSo
         cMxQ+6BHemgENcqbC1dakvtucMZbYhnlKqX/aHE45a6Pr6MX9PvrzzK8osh47AhvC2
         3FXIpzkNGQUkQ==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id h200-v6so112001vke.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 21:02:29 -0700 (PDT)
X-Gm-Message-State: APzg51AE9ZCE/2wOIBib31OYjy+eMJ3F928FhBZDV0/PDfgLca25Xg/W
        nkgPHAZvByAXcFCxYjTvENqXoMEtuPZ5ibtBME4=
X-Google-Smtp-Source: ANB0VdbCZ89Zm6XzvZhsbMN8+M2n7N6+2kYX9mNPRDsXgY02UVv7GdBcTgT/czpKrWe9V5u5sWxiZvSjye5RrhHsAe0=
X-Received: by 2002:a1f:8f06:: with SMTP id r6-v6mr8279869vkd.0.1537243348800;
 Mon, 17 Sep 2018 21:02:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 21:01:48
 -0700 (PDT)
In-Reply-To: <CAGXu5jK4aNuZ+RR4eC80yUQ2zxSoU9=ioaJBtt=VaX=_oZC=ew@mail.gmail.com>
References: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
 <1533358023-5801-2-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jK4aNuZ+RR4eC80yUQ2zxSoU9=ioaJBtt=VaX=_oZC=ew@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 18 Sep 2018 13:01:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASW+cKjoUGpTvBwf-4J38VhF0AMpNBX1Tny_2mguLBmaw@mail.gmail.com>
Message-ID: <CAK7LNASW+cKjoUGpTvBwf-4J38VhF0AMpNBX1Tny_2mguLBmaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] um: fix parallel building with O= option
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,


2018-09-16 3:47 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Fri, Aug 3, 2018 at 9:47 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Randy Dunlap reports UML occasionally fails to build with -j<N> and
>> O=<builddir> options.
>
> With v4.19-rc2 I'm still seeing a failure (for any parallelism) under ARCH=um
>
> $ make -j8 ARCH=um O=/tmp/foo
> ...
> /home/kees/src/linux-build/um/Makefile:1185: *** Headers not
> exportable for the um architecture.  Stop.
>
> Am I missing something?


This is a different problem.

I sent a patch:
https://patchwork.kernel.org/patch/10603707/



-- 
Best Regards
Masahiro Yamada
