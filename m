Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C48C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3ADA2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OolCrvXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfAVApp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:45:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53540 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfAVApo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:45:44 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so19067020ita.3;
        Mon, 21 Jan 2019 16:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uW7IaTbbQ1tVB6RBe4tlctvq0g+5wtO3GEI3OGAV8Vw=;
        b=OolCrvXwD2TOPeY7enK4vlBY935V5xLj+FDNLn0gqLT/r5s441WDiJIJcdg6vOog2v
         qkhOFodm3paRTEi+9CswgUv6jvXYn8E4giO554u4usIYKzEZ9iZSOaiuZh5O8YhX4h3p
         7NMz5e+R6wNVZASm0pUbf0c5+1Kb0rWh2tj29gbq180QiCsHrg1+eEgTDiL1e1jqlbAP
         0U9z26/3F97xV/z98SiVw5C3KDmsyIrMTcCV/JBOytPGOKbhhpS0eK3DlG387BxXya/A
         XJsMKiF83hEHdKAbG66PKtoB4B7cvyO+aBuxZh8CZE2QqBz0HTTAe/9cD+IgHL92VDIc
         GOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uW7IaTbbQ1tVB6RBe4tlctvq0g+5wtO3GEI3OGAV8Vw=;
        b=LAyLMH5ZRlV66HDW/5MaoXhn8EKsCmhqxxH1aVXCugnCSeeFuzBwSHl2mpXeXqZePl
         kc2yi17RQownzVO9AyPOSuIZGgssm5BE0cJabhXEk/Nvw4leHGvJHcsN2f7sAhNK2JMU
         h9IOGdGzVlnYmR8gOuMhW7zNkesgJrAliHPOg+2Wa3oacYxJLllcUpNDf9zoeaNYyGf8
         5XqCPH3Cv6z77aq9YLUTxHGWeJ85PDR1BWgnh4cBbsLPaY0zAj80dY4OsxElR2QdKsjO
         VWfNc+2iycy8A3eSKfLuoYy66mfrRsfnfOzgSicOJu4ZjpsqRlO5JEiU5FSlk94F+lf2
         NwHg==
X-Gm-Message-State: AJcUukcJ1b2P7HWMNFrqp4Y5e1gHykTQyQyufksvK/4V+nsIe6I0Oq7J
        m2t2AhPhkAetTa2CZ4KLwi091cBkxhrmh8hbaEY=
X-Google-Smtp-Source: ALg8bN7ZU9FV0kz+vFacCpQjik05+mPTT0BvR2QNlm4IqOxZ5WVlu0GdgJrmuVBvsjEOERnGLo1/GbTwLxx9PNMLjLw=
X-Received: by 2002:a24:b34f:: with SMTP id z15mr978404iti.61.1548117943541;
 Mon, 21 Jan 2019 16:45:43 -0800 (PST)
MIME-Version: 1.0
References: <1545207363-7402-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1545207363-7402-1-git-send-email-chenhc@lemote.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 22 Jan 2019 08:51:55 +0800
Message-ID: <CAAhV-H61Muv7V358Mfe27C0tEedOQGncN1Dfq2wu1ddaVT1o0w@mail.gmail.com>
Subject: Re: [PATCH V3] cacheinfo: Keep the old value if of_property_read_u32 fails
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Wed, Dec 19, 2018 at 4:15 PM Huacai Chen <chenhc@lemote.com> wrote:
>
> Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
> property_read_u32 instead of get_property,read_number") makes cache
> size and number_of_sets be 0 if DT doesn't provide there values. I
> think this is unreasonable so make them keep the old values, which is
> the same as old kernels.
>
> Fixes: 448a5a552f33 ("drivers: base: cacheinfo: use OF property_read_u32 instead of get_property,read_number")
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> V2: Add Cc and Reviewed-by
> V3: Add ChangeLog
>
>  drivers/base/cacheinfo.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index cf78fa6..a735953 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -79,8 +79,7 @@ static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
>         ct_idx = get_cacheinfo_idx(this_leaf->type);
>         propname = cache_type_info[ct_idx].size_prop;
>
> -       if (of_property_read_u32(np, propname, &this_leaf->size))
> -               this_leaf->size = 0;
> +       of_property_read_u32(np, propname, &this_leaf->size);
>  }
>
>  /* not cache_line_size() because that's a macro in include/linux/cache.h */
> @@ -114,8 +113,7 @@ static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
>         ct_idx = get_cacheinfo_idx(this_leaf->type);
>         propname = cache_type_info[ct_idx].nr_sets_prop;
>
> -       if (of_property_read_u32(np, propname, &this_leaf->number_of_sets))
> -               this_leaf->number_of_sets = 0;
> +       of_property_read_u32(np, propname, &this_leaf->number_of_sets);
>  }
>
>  static void cache_associativity(struct cacheinfo *this_leaf)
> --
> 2.7.0
>
>
>
