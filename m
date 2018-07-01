Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1096C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B32F25B65
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPBxQAmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B32F25B65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932178AbeGASsO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:48:14 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46136 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932093AbeGASsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:48:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id s11-v6so4121483wra.13;
        Sun, 01 Jul 2018 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X8dhn6dNj1jyb6xmkUVr+jL+mGI6H9EgdPgJYxlWWYI=;
        b=bPBxQAmfdnsLmWGdHhZza0Y3ZIlCNituFqGcOW52mmTDfzG/OahZdwlPCkmR0QSj/U
         lYdOi1VnN5FogqTiOCpZY5lIW6Wm3Odp0Cll5cjfqSi+ib4oCDwFjv4d8wkzTkkenw+u
         PT/z6Jrm9KKH1EqkNLgWCzkuFMaYF69h4eDyokp/eV3/LLZ0ZXgtEtTwU6k0VKDKWX6m
         CpMbPNEHxt1GlrzKYC92kzPmQRCAYbRP7PbZ12f8KNtLureipP8U9NWZkFBb49/FlPGA
         ajUHp64QJcbW7rRuvdYVYepkIbpRNqPztGmWBO05AsLrIS9pT4k/5u5boERi2Y8452r0
         H+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X8dhn6dNj1jyb6xmkUVr+jL+mGI6H9EgdPgJYxlWWYI=;
        b=T1/W/nB0g9RqL4+mbk9rThu/R0CXVO4MgbTICizlLuRyB38tGP1y70Ded6/bdONFEy
         0pru5jx2ltO6PQ026Xy9kRkltOe1R846qMg2lvb9adEFzuTXlwsqjpUv5myepsXORvwC
         NsLng7B9PQaxdmyEMs31EhqSHRv6AgUxuc2/RwtpOhOg1LrPzveig9CwUTWLlX5KsAMV
         bqbf6VOSRJAdsCs7b3yavF8PsElqBavWX1GfvcVn3aIOWk7kJltenoPXqKe9UHHDpbSY
         duPS0BuSIaaeoVWpt5VFeHurMJbpjsd5+79RJ56IRyPhYeiznyZzOflka7zYZZtotF5/
         C1EA==
X-Gm-Message-State: APt69E1b2lD/ZpwJWl7tHI2pnDnZni6TlGiWnUx6tLu/q+bspeAKFPzV
        /8uQAzZcIkj3jYoqJHrobDDZSde2ZwZLYQgy+xk=
X-Google-Smtp-Source: AAOMgpf3sL9UeuW9o5ZJGlSsHfmrMqE+iJfPmUgO8hCZzsFX6SBnjM+KfV0O9iZpWUVGFvsPlQ0sBbGzCeMw1veQJbc=
X-Received: by 2002:adf:e0cc:: with SMTP id e12-v6mr9664681wri.199.1530470888313;
 Sun, 01 Jul 2018 11:48:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:480b:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 11:48:07 -0700 (PDT)
In-Reply-To: <20180701160914.723817814@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org> <20180701160914.723817814@linuxfoundation.org>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 1 Jul 2018 20:48:07 +0200
Message-ID: <CAFLxGvwxDRMUoJH-3NKefXS6YxL62DjxRDd-5e_ui5jjJAJiJQ@mail.gmail.com>
Subject: Re: [PATCH 4.17 154/220] UBIFS: Fix potential integer overflow in allocation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 6:22 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.17-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Silvio Cesare <silvio.cesare@gmail.com>
>
> commit 353748a359f1821ee934afc579cf04572406b420 upstream.
>
> There is potential for the size and len fields in ubifs_data_node to be
> too large causing either a negative value for the length fields or an
> integer overflow leading to an incorrect memory allocation. Likewise,
> when the len field is small, an integer underflow may occur.
>
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> Fixes: 1e51764a3c2ac ("UBIFS: add new flash file system")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Guys, this patch was never on linux-mtd nor was I CC'ed.
I don't see it so super security critical which argues to bypass the
whole community review process.

Anyway, I don't like this patch for two reasons.
1. Instead of doing the kmalloc_array() dance, just check whether size
is 0 > and <= UBIFS_BLOCK_SIZE, in the caller.
2. It will not apply to most stable kernels since it targets the code
path with UBIFS encryption available.

-- 
Thanks,
//richard
