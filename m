Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0293DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF342087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofc6gJhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfAGXBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:01:50 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37880 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGXBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:01:49 -0500
Received: by mail-qt1-f193.google.com with SMTP id t33so2439445qtt.4;
        Mon, 07 Jan 2019 15:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mD1TmTtwyG8a8cTF1/VuItJe+I735EUTgbzvfWuazFo=;
        b=ofc6gJhmwD2LmMDl1z3bIV6lUEMh56k1kr3YCaiahz27hjZn69TRE92dKkGmcjRnFa
         1OFhY+hMFuDUeO9i3q/zJIQsREc6kc7p5wVqHRSrUXHfms8G8LkpSpaxc9HGMTbQuBFD
         32lSjdvFg/nVDPtXVSV8danwTVKMqP31cGbr03FrUexmHXW0vQ0UIeXAUV8OQUs5Zon8
         cGSS2DOqy0jQO90+U78MVPUbLlqdXuRGHMcgkg6E8cSz230wpQzheGAyF+Eab2jCLlM1
         5GEeNrCzkkTIH4jziY0z1S4vghkj9OJICroq6cMfigRW3gq7KeEroQo6fygzNzXXQ9kh
         qWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mD1TmTtwyG8a8cTF1/VuItJe+I735EUTgbzvfWuazFo=;
        b=hdhHvAotIcS14Dl9gk8h/Uw12Wvyd9XdDmXb3tZIPe2RVPMJpG5ppNvVB+RLZzloUi
         eEcLuZUimCeDpx/R0bsx5bGczhQnXlmEke7AS6075XPy/C5dZwd1pM79fIAtFXIxrJde
         gBjDJgrJQgx+AyLQa/aDfs61n678k6pLK116As+GOF9WVmfUf2V8riMtSbb4e/VZhEJu
         vdj4XC7qDJLNxvVJh/S7pZ7dQBomPDc/ZFnB3PhpldY2XchNzTTakJSjUaXXYCrf0RUg
         9Wr2b0MB76SvUPp3s7cGNvcgCOe/4eMKkmsMwtfflcT7jz3K53F4KjW7Z1avfbgud/Ao
         0Bsw==
X-Gm-Message-State: AJcUukc596G9PMgvNj3uPCcP+3MbaPCu+W9jOp9jHyF6hIRKD01zuwYi
        FgBOw9mXjr87l8I7yc94TnGLSb5MM5WN4sD0wWg=
X-Google-Smtp-Source: ALg8bN7+L8bE1LyhHcEwcQyXv9lKEOAmizdDTkqu20gS4GaHdKfjQr3hUmjRV3lN2V44IgFLdAV92JjXRoW8sn0Ykis=
X-Received: by 2002:a0c:fd8a:: with SMTP id p10mr62148182qvr.48.1546902109149;
 Mon, 07 Jan 2019 15:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20190104211128.GA13343@embeddedor>
In-Reply-To: <20190104211128.GA13343@embeddedor>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 7 Jan 2019 15:01:37 -0800
Message-ID: <CAPhsuW5CmfTm4Eu6AXgA669Obf3Sefj51v18-w=wL7d1bTz5tA@mail.gmail.com>
Subject: Re: [PATCH] md/raid10: Use struct_size() in kmalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 1:14 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     void *entry[];
> };
>
> instance = kmalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  drivers/md/raid10.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index abb5d382f64d..320cb430cca6 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4788,8 +4788,7 @@ static int handle_reshape_read_error(struct mddev *mddev,
>         int idx = 0;
>         struct page **pages;
>
> -       r10b = kmalloc(sizeof(*r10b) +
> -              sizeof(struct r10dev) * conf->copies, GFP_NOIO);
> +       r10b = kmalloc(struct_size(r10b, devs, conf->copies), GFP_NOIO);
>         if (!r10b) {
>                 set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>                 return -ENOMEM;
> --
> 2.20.1
>
