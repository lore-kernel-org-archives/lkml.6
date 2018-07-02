Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB891C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E712502D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="inrxj1bY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="icPLluNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E712502D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbeGBVsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:48:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37354 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753544AbeGBVsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:48:01 -0400
Received: by mail-yw0-f194.google.com with SMTP id w76-v6so4802180ywg.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Mq7OHsLeJXUZLKXk6MuObjljSbncgrrH+OA07Ysu5I0=;
        b=inrxj1bYbtMtg+rPipb9I3Xe8Yk+JZuV/EpejOo6QHqlHDBTFZoAVscOh01wGto49U
         F9kNrhJdwoG2rV/8CjRT0eaE6j/xidDBaBc21Y9YdZ/FDGdBAmyxxhsYaXrOR7s+0T6c
         lNGjEvGCoWRmnPBW+9GlAJZ+/+lYNMeO0LzYEdz1P/OWzGXYc+gQsi+xC/00ck+GpQtK
         Wx05VEgumczdTtvY1G3rS62YHUmzoYxOf1HJrhReJcljOCsc+za1CitNvfEff97/Vj+P
         TROZbydoYE2+mKFHhkXWgPNnx1MtbgFOhk+S2n050Jd6Pk/ziwDYAZD9wn/uvFeyoI70
         OhAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Mq7OHsLeJXUZLKXk6MuObjljSbncgrrH+OA07Ysu5I0=;
        b=icPLluNlcslA/6ow9nf72LW06jC8oKOfdlNW52Wf8Tgh5kSa8zhPAOQ+Hur3M3abgd
         W99fIWTdGJ0HcMoOowrRWR0MIoh2Tsnn0jL5zNzsLT/IbTyHu7abVtfdTHfXBgRgQ7Lm
         9XMLbY6HTcDNcman5pzSrVzrx/bquAB527kW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Mq7OHsLeJXUZLKXk6MuObjljSbncgrrH+OA07Ysu5I0=;
        b=DDrDKEBw8OHDQVAqT+QOGx2Oy0WTCFQbhzrwagD4GbIYpWnuxSpROizs5FQ1PX60Hr
         1Se71PXRfKiNKBF6HIXeE+bU5V18hztUqOtJ7bqjsQzQheNGy74L72n5BTxS9hypL4l8
         ireZfozYuVwrO+3FvcsI96JRcaLditvFGKN7C7AbjJbXsyCXik9hB0p6fUNpjIHWjsp0
         kqFamrCkwXWXVfvkLI3dFZ4zRsHtTPux/TtRz5YEcZy096eF7GYrlzJIu3ODCR+f+fyY
         rT72fVc6ilnM/keSpw7LPGG2yNQRmzJ/7T/A0m4hDfUF1myC4gvxkj2AamiJg+7ziKOC
         XwfA==
X-Gm-Message-State: APt69E2P5HOnT10ZZVrv/qpTfFZ75RpDJXEFixhJczsaLBSz4Bfpk8IG
        J1K59Ve2qhrSfHTI+n6Q+5TPgmZKk/rve6PamtX0LvyM
X-Google-Smtp-Source: AAOMgpdW0DskDcO8NkbiGXTxmEX/j4XlN3o6JgQDxMSpxVL1JKjXM7gfK+96lKf7nJFY8XeUPkPMfTBIZnRBUgPTHJM=
X-Received: by 2002:a0d:d105:: with SMTP id t5-v6mr13855232ywd.53.1530568080970;
 Mon, 02 Jul 2018 14:48:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 14:48:00 -0700 (PDT)
In-Reply-To: <20180702214713.2769-1-richard@nod.at>
References: <20180702214713.2769-1-richard@nod.at>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 14:48:00 -0700
X-Google-Sender-Auth: Xea4-ZJR5k07J8IAMFo3Dqp2_EQ
Message-ID: <CAGXu5j+mJzhzXMg8F+stScfSqcquVofB_D8DHgpbUww8OOs05w@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Use kmalloc_array()
To:     Richard Weinberger <richard@nod.at>
Cc:     Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 2:47 PM, Richard Weinberger <richard@nod.at> wrote:
> Since commit 6da2ec56059c ("treewide: kmalloc() -> kmalloc_array()")
> we use kmalloc_array() for kmalloc() that computes the length with
> a multiplication.
>
> Cc: Kees Cook <keescook@chromium.org>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> ---
>  fs/ubifs/journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index eea12d25a58b..95acc0c04bca 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -1285,7 +1285,7 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
>         int err, dlen, compr_type, out_len, old_dlen;
>
>         out_len = le32_to_cpu(dn->size);
> -       buf = kmalloc(out_len * WORST_COMPR_FACTOR, GFP_NOFS);
> +       buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
>         if (!buf)
>                 return -ENOMEM;
>
> --
> 2.18.0
>



-- 
Kees Cook
Pixel Security
