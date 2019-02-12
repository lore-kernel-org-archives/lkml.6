Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B61C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1C521904
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oh6ANWpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfBLU1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:27:25 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38622 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfBLU1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:27:21 -0500
Received: by mail-vs1-f66.google.com with SMTP id t7so5843vsq.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shDox4bOH6ln3SCPqqzMLpRwOthhfyBRC3TX5b89eyQ=;
        b=Oh6ANWpDZBNAPBEpt8Va4Gq0VC7TCYDqjMwnv6eIEvxhqgZH7Hsfw3D8Ft0LfShhIf
         uVfPV3LhQicuJKzzIDz6rx8VMuUwy9eKUvgnGRe5vROD9utT6UZeZ/QswjyTH+bEMepA
         +GmHWYIJDx4njCXnDWG81Luc6r/iexM5LGKYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shDox4bOH6ln3SCPqqzMLpRwOthhfyBRC3TX5b89eyQ=;
        b=FSYhMLzG6/2l26lp6sqd/hlMn0YE85bvL8/0ehmfLhpOurGqlKC2pnQihUX7A5AcY9
         8j253kdlpUUMK7UFTBEmyp02b21CE15uB3xAoJqGcZ6MjLTOTwoutt12MSGpoY49k/3S
         j+7DQH2Hx57NsvILDomRlv0Q7y50V285fuOJpgbpvjdF7kI9vnKbJ/CwawOQQtidu64Y
         6PGxhNwGW3zjSb/7S9XAVHtilvzFlnL0Qjc9R1OxipIl/L1fvDuqDw5gWV8KK9NPd5Wz
         EC/rmBsqUanJNWyJIRj3NG7ajAqC/GgcZ6HBp/NI5NTgVI/iVr557VB9H7+768MTM2L4
         1Gcg==
X-Gm-Message-State: AHQUAuYFPm5A/ejWfw5qkGzYyAj7QkiYYlnwWyjhlncW2NoWoZIy2jgm
        1zwf2bdX8K4AKcjpn+OYxMFFLdzu2oU=
X-Google-Smtp-Source: AHgI3IZhJt3/o67bE3zcoHI2uShYuwrdEhvzqbYelS3E2SCexlgWE2YWkIVfOt5qtDzgf0Z19wXVMw==
X-Received: by 2002:a67:f592:: with SMTP id i18mr2250150vso.102.1550003239774;
        Tue, 12 Feb 2019 12:27:19 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id b1sm2313766vkf.9.2019.02.12.12.27.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:27:18 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id t7so5783vsq.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:27:18 -0800 (PST)
X-Received: by 2002:a67:c00a:: with SMTP id v10mr2453272vsi.66.1550003238172;
 Tue, 12 Feb 2019 12:27:18 -0800 (PST)
MIME-Version: 1.0
References: <5c53f6d3.1c69fb81.a1e8c.eb7aSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5c53f6d3.1c69fb81.a1e8c.eb7aSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 12:27:06 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+PjfQ9dm6PbfL=K+0wa2pUSqPB2J=GoGBD60XX7-ywJA@mail.gmail.com>
Message-ID: <CAGXu5j+PjfQ9dm6PbfL=K+0wa2pUSqPB2J=GoGBD60XX7-ywJA@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Add kmsg hlen null check to ramoops_pstore_write
To:     Yue Hu <huyue2@yulong.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:35 PM Yue Hu <huyue2@yulong.com> wrote:
>
> From 9385613f546a4d0b2497dc2ed22cb9475eb3621c Mon Sep 17 00:00:00 2001
> From: Yue Hu <huyue2@yulong.com>
> Date: Fri, 1 Feb 2019 11:27:32 +0800
> Subject: [PATCH] pstore/ram: Add kmsg hlen null check to ramoops_pstore_write
>
> If null hdr happened in ramoops_write_kmsg_hdr(), that means
> we cannot get the dmesg record since it will be treated as
> invalid header in ramoops_pstore_read(). So we should not
> execute the following code but return the error.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/pstore/ram.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 7e188f6..4a06675 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -467,6 +467,9 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
>
>         /* Build header and append record contents. */
>         hlen = ramoops_write_kmsg_hdr(prz, record);
> +       if (!hlen)
> +               return -EINVAL;
> +
>         size = record->size;
>         if (size + hlen > prz->buffer_size)
>                 size = prz->buffer_size - hlen;

Yeah, this seems right. If we don't generate a header, then
ramoops_pstore_read() will ignore anything written there. This
probably means we need to refactor this to avoid memory allocation
during the write. I'll apply this and do some follow-up changes.

Thanks!

-- 
Kees Cook
