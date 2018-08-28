Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079AEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D73C20878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRgAQTK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D73C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeH1TVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:21:16 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:39773 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH1TVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:21:15 -0400
Received: by mail-qt0-f181.google.com with SMTP id o15-v6so2152066qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DgeHfDk6UafIJWa3eTTdX0ADsnLorcBjAbB4V84+orY=;
        b=TRgAQTK3a3LCIkMyOY8wtF2RT7ZYmL0zlt4C+jG0cBTpxmR+n/+4AZm+fxn9F1wUsg
         MH2+D6Fd2Fm0PIVAz7dE0djnKXAHdM365M8p2RclWTZNQorInfHP1VMUOmficNWHcyGQ
         rCEqwReLvR5f4DOg2+Edv7Jlk8nyvnPP14YEomj85+f7wkuPe+Ts7xdMVutvYOkMMgML
         jVvskUmCIVtIfSdcfC/6z0Q6h2z7wxNpx5ljL0HIx2B90ME8m950tCbPwSi0X0zKqJVV
         D6dwt/EvUtZwivsJyoIScuB6leNM1yZfZ3SjImu3esm48WdROQtCgLoCjIAWAs9sWRSY
         lIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DgeHfDk6UafIJWa3eTTdX0ADsnLorcBjAbB4V84+orY=;
        b=Aa5XAQasLJfhHsLvwwKEhtdG4v9K42zTm7cCNBCMyl8+PP5/Eu/L59AyKuyB/YTxKc
         XsI22TncfPN+9owPJF5SOlBgEfLVwM+U8IPbLAXyWoJtZLfhvgNz2GXOha+hpfZT+dPb
         r1xTXP+RusD2mNW+ePFSRvN3kmnvFmLgI9R/fvezEXUlYuXs1EzxJIbtBGbPKbP1+eAB
         l5aPMr8CRE6nK3rrmvpdJ6njM3hdedglI3dkgODlbK+uxmXUAiMVDV7ed0l+UVAQzz31
         svhOddjF1nqfHlaoz8Ft5heoawSiVT67vd1PpNn8JXjLErU/uzVzHAvMH2jBSaqis51z
         26ow==
X-Gm-Message-State: APzg51BW2WOPwRMjsyCRplnr6nx0BEt2yij24g+WGc/Soea47iSnP7SI
        f/Pt6n5Bqab4cXPAaTOlcXb6I9cD/KNCcRZG1ifrgxclppI=
X-Google-Smtp-Source: ANB0VdbyYILPlXyAqLpOWmsO+5MZUvnI6GMo/Y+X04NuEgudyE/j9skdnEjTn+R0ZECSznO7FWLgpaykkHFLvjNmKG0=
X-Received: by 2002:a0c:aac9:: with SMTP id g9-v6mr2169554qvb.78.1535470144784;
 Tue, 28 Aug 2018 08:29:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 08:28:44
 -0700 (PDT)
In-Reply-To: <57cafda5-d7f4-61a3-7169-38cc2d34abf6@opensource.cirrus.com>
References: <20180828133320.1831-1-geert+renesas@glider.be> <57cafda5-d7f4-61a3-7169-38cc2d34abf6@opensource.cirrus.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 28 Aug 2018 17:28:44 +0200
Message-ID: <CANiq72m-kvANJsrWHXHoEfRBRbFDt+0nWzma3HxBrBo9tP9Ouw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move entry for Cirrus Logic Madera codecs
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 28, 2018 at 3:57 PM, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
> Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>
> A maintainer for MAINTAINERS would help avoid these problems, which will
> tend to happen when changes to the file go through many trees.
>

A year ago Linus committed 7683e9e52 ("Properly alphabetize
MAINTAINERS file") which adds scripts/parse-maintainers.pl.

I guess it could just be run once in a while (e.g. before a kernel is
released, for instance).

Cheers,
Miguel
