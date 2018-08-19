Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5ACC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 12:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C77020BF3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 12:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxg4ecLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C77020BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeHSPtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 11:49:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37590 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbeHSPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 11:49:13 -0400
Received: by mail-qk0-f194.google.com with SMTP id f17-v6so1897251qkh.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jpuwE7438CL2SNEkAOfWIjFTB/AZa4CPofxdVeA1a8=;
        b=gxg4ecLfAosW4S/rPbbIU+5ol2GnnXRHcMnJLYnYczHjdFP8mszp65fCDnnFiD9AG5
         B4AXL06pZPsVX6kDWU+3IEXGn2wMgL44hPHojRJ0Po+YpweKDes9w5qeeCD0RthQhGxz
         4pU5K5xDl2S0KFc19BrbTSCjz0Xd7SWLyYVhaeV1HFQ6pKwiSoh8uC6gt7lh/+7kcnK1
         KULMLRTuf1cOAMgbZBWDnLZ1/u/a5KQyaW2eJQfSdfEPuCu8wuq9lHtgjs5wOZ2dHqRi
         3PcrBZv3QCJ4JoiYpOuG1fHoseVytq/1yuskQnd/i7/EbFryXJ6Ma69X7jLl+sFnkmp7
         LSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jpuwE7438CL2SNEkAOfWIjFTB/AZa4CPofxdVeA1a8=;
        b=OSoF/ph4OxlpfkAn6PfhnTHNw7zw8QIDwrwdGzAfB3bjSmGHCXxJ+26NFW5ZgzCFZs
         pfwUPxl+gcjndoyFDymLASrJdJhD2g0XB51pmpPXpkeh4FunguOsOdiDZEOVF/Vispjc
         psfTTvOx8Vjd7hj/Pt1hHJ8bN7pM1dwmTsDx10UHU9pskTajhW6Fl54ERoJN8l9Qzl5G
         fnaArQ6dAonNVbESYHAUwNaihOAHMEPDTwxwvnTBpifDUNWlsfaktLySOw/XzqEfcWGf
         BTscmBgfG/kZRMI91+zkc+NHxI4eEUSy3b8xsjbwdL3DWWaXzS9WDbxzCd3APobFY7Wb
         sv2Q==
X-Gm-Message-State: AOUpUlEgZp7CiAnaIlherhRnzlEZldOKVEZHBw4m1p18/GSJ3MIWKzft
        46o3mpbMwdGPdOiMAV6g4LupVzUaLzASEqwm+Q4=
X-Google-Smtp-Source: AA+uWPybSTGAUHBl/wgsXrC4vodh181HtTYeBJXgwnNcw9pFIoFJubBcO7mQVAJd+xX9blFfNvKS2mKP0S0R/XdJHEU=
X-Received: by 2002:a37:6c07:: with SMTP id h7-v6mr36565441qkc.185.1534682272534;
 Sun, 19 Aug 2018 05:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk> <20180818131623.8755-7-linux@rasmusvillemoes.dk>
In-Reply-To: <20180818131623.8755-7-linux@rasmusvillemoes.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Aug 2018 15:37:41 +0300
Message-ID: <CAHp75VcLbbyJ5ir=CPxMp1O_ULZx5WyWq4sbDL2OBO5kg843vw@mail.gmail.com>
Subject: Re: [PATCH 6/7] lib/bitmap.c: fix remaining space computation in bitmap_print_to_pagebuf
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 4:17 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> For various alignments of buf, the current expression computes
>
> 4096 ok
> 4095 ok
> 8190
> 8189
> ...
> 4097
>
> i.e., if the caller has already written two bytes into the page buffer,
> len is 8190 rather than 4094, because PTR_ALIGN aligns up to the next
> boundary. So if the printed version of the bitmap is huge, scnprintf()
> ends up writing beyond the page boundary.
>
> I don't think any current callers actually write anything before
> bitmap_print_to_pagebuf, but the API seems to be designed to allow it.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  lib/bitmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 1f73b2e52186..277c9a63a5ab 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -460,14 +460,15 @@ EXPORT_SYMBOL(bitmap_parse_user);
>   * ranges if list is specified or hex digits grouped into comma-separated
>   * sets of 8 digits/set. Returns the number of characters written to buf.
>   *
> - * It is assumed that @buf is a pointer into a PAGE_SIZE area and that
> - * sufficient storage remains at @buf to accommodate the
> - * bitmap_print_to_pagebuf() output.
> + * It is assumed that @buf is a pointer into a PAGE_SIZE, page-aligned
> + * area and that sufficient storage remains at @buf to accommodate the
> + * bitmap_print_to_pagebuf() output. Returns the number of characters
> + * actually printed to @buf, excluding terminating '\0'.
>   */
>  int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
>                             int nmaskbits)
>  {
> -       ptrdiff_t len = PTR_ALIGN(buf + PAGE_SIZE - 1, PAGE_SIZE) - buf;
> +       ptrdiff_t len = PAGE_SIZE - ((unsigned long)buf & (PAGE_SIZE-1));

Don't we have offset_in_page() helper macro?

-- 
With Best Regards,
Andy Shevchenko
