Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB7EC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 12:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0B520BF3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 12:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgvDtK9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0B520BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeHSPun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 11:50:43 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40305 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeHSPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 11:50:43 -0400
Received: by mail-qk0-f194.google.com with SMTP id c126-v6so9163453qkd.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U3/oEBIxi3HeTu12thnL/2kwqwPm/kiUzSMp2rXuYT0=;
        b=CgvDtK9/lUTcUJjP+bKIwxecu6VZ2if2I5TNC61GlLRqsO+X3Dqyv3HrHenvSkxsgA
         +bu7/+lmf0NYet8vlzka0wyCJ0bthffCbjj6S0wlAcfWMvhewCSLs/IMO+KER/DrRFS+
         TCaxb1ZczYxyUWUAk0tnaIHt/7tqBiVTVTYch4U7tWnik4JlzYUKTDHJXgJ7uMMy9GAr
         GauC0OabTdt1zZ4B66RmaensDDgZtWnFCtM0B9Zg8o/B5yG+ac8LezmjAqdyl7r1wzGV
         TxRUinAfgnmb2/m5SkV64c9VS4dOs6P7s3OMn+auZsFFrvE+AJ6Wsfv4/oOfXdBvRGnK
         LA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3/oEBIxi3HeTu12thnL/2kwqwPm/kiUzSMp2rXuYT0=;
        b=cILQ49SvMqRkszyzrLQ80gOdduAuiAsrEBEnIBJz3dQ4dWlpZX45fG1JwxIJFTQLW7
         WykQVHl7MPXo0FDZTD03cDwmyWAaf6RpmypJPvZt15Z4435VRV87u2nLVkspyGhNu7pm
         ZctmD1pWY1/UDa0MGwydvEb8uDoYbT1JSKJ69ef29fb8cThFZtZ8/TvdUMGY1dWkerjJ
         2TsnIMRGT6ZYsnlTmxOGz4sVtzkqGjjFORAjIuCCcExSOKkmmQ5dzT0+ydPUKMjNo/GJ
         HoMg5fxJw/QEg2XILwb9nZeDCSlP+4i79Sdxhgshe1VyhptNKfLrP4mVYv6wL8Z+PrPW
         qA+w==
X-Gm-Message-State: AOUpUlE9slnZHzJSAUz4c+6wU4eGQ+kfBgERYNOxStCzDzGwuzq58LGA
        pLwTcGbr6bU9nc/x0g9xoiv7LpnSkLWuY5HyYjE=
X-Google-Smtp-Source: AA+uWPxmmhfqzl8Oz8o8AMmdJrNY/nguG5OccUbmO9pz7FW5LXNl40hGg4jZ8h5vgz52DrVTii2XpTnJpD6fqpMbmGg=
X-Received: by 2002:a37:7004:: with SMTP id l4-v6mr36256964qkc.83.1534682362276;
 Sun, 19 Aug 2018 05:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Aug 2018 15:39:11 +0300
Message-ID: <CAHp75Vct9s4GwEk7pORy1gss3Acq61dG-F_C1M-DCka+YPtoSQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] assorted minor bitmap patches
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 4:17 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> A recent LKML thread had me look into bitmap.{h,c} again, and I
> stumbled on/rediscovered a few things.
>

Good fixes, thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. Perhaps needs addressing my comment to patch 6.
> Rasmus Villemoes (7):
>   lib/bitmap.c: remove wrong documentation
>   linux/bitmap.h: handle constant zero-size bitmaps correctly
>   linux/bitmap.h: remove redundant uses of small_const_nbits()
>   linux/bitmap.h: fix type of nbits in bitmap_shift_right()
>   linux/bitmap.h: relax comment on compile-time constant nbits
>   lib/bitmap.c: fix remaining space computation in
>     bitmap_print_to_pagebuf
>   lib/bitmap.c: simplify bitmap_print_to_pagebuf
>
>  include/linux/bitmap.h | 37 +++++++++++++++----------------------
>  lib/bitmap.c           | 21 +++++++--------------
>  2 files changed, 22 insertions(+), 36 deletions(-)
>
> --
> 2.16.4
>


--
With Best Regards,
Andy Shevchenko
