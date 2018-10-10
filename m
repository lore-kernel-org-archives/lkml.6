Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347B1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28862054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNYSXDFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28862054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeJJIVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:21:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34555 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbeJJIVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:21:40 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12-v6so3693690otl.1;
        Tue, 09 Oct 2018 18:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2EZPhvngUO5S1nk+0jkQ/A5iTdmqdn3ctiJa31CT5k=;
        b=eNYSXDFY/arDb/NUg9EJqXxPbG9oFmdTyRmI4YRoPZYFA/47m6AUrBPPLdwkIwwB25
         vzowguZUNJH4VKLwyp9Gm/ndAXLMj1znotOoxVAGWimyjZJbcJj4UiIjKtrYeKlv0uwS
         MzYw1etWN006eyazcwShUpxFpHG1MsusLQb3ZqXt9qsXraYw1E+Sg19fazjDBbfncGHi
         75fk92WE6rglklvuxkAOMtoTrQII+C6XtQzpeUVoNOonmDRFGzvcN6d/zcGPdupx/Gpw
         q/MG28ev46fBoHHsWUphYDx0tG+5V1GTRGE6KN1ILTwWQGwDpZsP1yuUve6YTaW2y6al
         etfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2EZPhvngUO5S1nk+0jkQ/A5iTdmqdn3ctiJa31CT5k=;
        b=twiXpEEeFyDcIG7AYFc+R1A+6zDzSGZy3jLkenIH7IvA6faifQd6ndIMlXZvZl0DUm
         VXOjPx1eGbwQyt48PcjKvhJALc1gITZb5LzFnvPwNGvszbFyr+qvfxHQBXXVYSw2+yb2
         Rk0LhYVknZfsBiAPpJ2Sa52yrW5vsZLypRS6iFfjQjBDicLc3uf4c03x//8aVKyFmrVs
         LxqY+U4L3SR03vKL+iBZVRmUQy2CU8wIhBm9EuBcJpayAU2UmvaTtVMBoiqNdo7MpNtl
         e9X3J9vpNKayRdy+ZQKNNb1Q9BQo3G2hEwIh930ob7+mDZg+zTTgbjqoox6rutRclLHc
         q3pQ==
X-Gm-Message-State: ABuFfoiq73yCtsyNJU97VneEUOFNa7LggmPBTGDMKqwZHT6IaFlfvBlo
        RrRVLKvPnQuogBfRYjNEgFyu9QTEZ7C3CuhEfKA=
X-Google-Smtp-Source: ACcGV61yblPs/HS7OkyOSrx6Boit8YWSGpgeTZPLMI0kLIw1cg+vfQm88DSvV4BA1ua/rD/YjXvs1LAjBBe6X6dWL4k=
X-Received: by 2002:a9d:38d4:: with SMTP id k20mr3219082ote.289.1539133321511;
 Tue, 09 Oct 2018 18:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180928020816.11251-1-leobras.c@gmail.com> <20180928020816.11251-4-leobras.c@gmail.com>
 <1538118915.3593.4.camel@HansenPartnership.com> <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com>
 <1538628062.18776.5.camel@HansenPartnership.com> <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
 <765df6c3-0339-ebf3-6446-cef4fc1eb1cc@gmail.com>
In-Reply-To: <765df6c3-0339-ebf3-6446-cef4fc1eb1cc@gmail.com>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Tue, 9 Oct 2018 22:01:50 -0300
Message-ID: <CADvQ+rG0wn5_msc5Z_QgqV0+Qvr4kueF32T69qS0UjvHRz+Y+g@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
To:     schmitzmic@gmail.com
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

> That already works, doesn't it? So all that you'd need is an offline
> tool to precompute what drivers to actually build with a given config.
>
> 'make -n' with some suitable output mangling might do the job.
>
> There may well be other ways to achieve your stated goal, without any
> need to make changes to the kernel build process (which is the result of
> many years of evolution and tuning, BTW).

Thanks for the info, I will try to use it.

> > This change is not supposed to bother the usual way of building the kernel, and
>
> Enough people have voiced their concern to warrant that you should back
> up that claim, IMO. Have you verified that your patchset does not change
> current behaviour when building the entire set of default configurations
> for each supported architecture? Does it reduce or increase overall
> complexity of the build process?
>
I have tried in some ARCHs and it worked fine. Out of curiosity, I
will try on all
of them.

> > it is not even supposed to add overhead to kernel compilation. And it would,
> > at least, solve my problem with the 3h limit, and enable the tool
> > I am building on GiltabCI to help other developers.
>
> (Apropos of nothing: Am I the only one who thinks gitlab might take a
> rather dim view of your creativity in dealing with their limit?)
>

They make available 50k minutes a month for OSS projects. I don't believe they
care how it's spent if its used to build/deploy the project. They even
allow using
several 'jobs' in parallel in order to speed up the process.

Thanks for your help,

Leonardo Bras
