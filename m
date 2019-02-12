Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B50C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC772083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FqT76Bi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfBLUHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:07:49 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:32849 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfBLUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:07:48 -0500
Received: by mail-vs1-f65.google.com with SMTP id k11so2430699vsm.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7tOwSOZe1VGambBBq7JWy4GRF5f9iihqaNnzuyCTJ4=;
        b=FqT76Bi/2HOq0Mpnqqc2YuvFh7z3XUyEUB4bzItzaq0AuQBm5fUj8G59V+F5xjyi7s
         x/sgndPhQBn5Gxcv73qurmMDJX0WQ7pYJX3uE5UOfsnHl3M7QQAIyMVoFXS8qDqVO+qo
         aBaB8mvPIrkyh5g3vhqeDnizBNqwhX4R4k2H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7tOwSOZe1VGambBBq7JWy4GRF5f9iihqaNnzuyCTJ4=;
        b=DeHSQ+fTc+jUpIHnC/tmaox9TmfM1OidsIilSA+0ko3t5NQVyw8mf7LhgOIkAyPiK8
         wzRY28qlwVfAt3YjeEhhBsR2/AhbR0MwEFZk1yX4MBeWGNuj9xUp7TN6OOaxifUEPZvc
         /wxsHdAN2SjwKSwhpoAdS4KR2xCAfWY6QeldYeoNvBOOklFtFWT1ghu78jUrUllG6hV1
         fpjlqZ0U1VdmwoXdgZcQwciwEJvf2j3bP5luEibF6cQByO+YSRrq2BH8Ik7QW/9paoU8
         z6AeBe8VFZo8LDt3xJEUBS9POsNrI/idItcPU5hWR4x/Pnpjo0Xf+/uTTWH15vPIHSw1
         RqWg==
X-Gm-Message-State: AHQUAubA3JvMCpz6yWwb0zROaCmLqsbqyboNutVCT/bePJfs24ARoh89
        c/nR+5/sRLBqMv02sAN8z0AlaPlC3mE=
X-Google-Smtp-Source: AHgI3IZVnBV5ZgOpwllPPNbZtF5gQYdV/MHKW/U6q7atwmezDMxBa2VEvboXsQkC2itxleP0d5Qn4g==
X-Received: by 2002:a67:8202:: with SMTP id e2mr2273214vsd.183.1550002067262;
        Tue, 12 Feb 2019 12:07:47 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id e190sm124660vkg.11.2019.02.12.12.07.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:07:46 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id n32so1319379uae.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:07:46 -0800 (PST)
X-Received: by 2002:a9f:2709:: with SMTP id a9mr2272112uaa.10.1550002065740;
 Tue, 12 Feb 2019 12:07:45 -0800 (PST)
MIME-Version: 1.0
References: <5c53ae3c.1c69fb81.5369d.9a51SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5c53ae3c.1c69fb81.5369d.9a51SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 12:07:34 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+Oro9nchbayNXCpnebqZJbf05Wf5W1OyuFc7D_R2MimQ@mail.gmail.com>
Message-ID: <CAGXu5j+Oro9nchbayNXCpnebqZJbf05Wf5W1OyuFc7D_R2MimQ@mail.gmail.com>
Subject: Re: [PATCH] pstore: Avoid to write records with null size
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

On Thu, Jan 31, 2019 at 6:26 PM Yue Hu <huyue2@yulong.com> wrote:
>
> From 57cb7141b227b7f75a6e4afb8319f803510cc07f Mon Sep 17 00:00:00 2001
> From: Yue Hu <huyue2@yulong.com>
> Date: Thu, 31 Jan 2019 18:12:46 +0800
> Subject: [PATCH] pstore: Avoid to write records with null size
>
> Sometimes pstore_console_write() will write record with null size
> to persistent ram zone, that is unnecessary. It will only increase
> resource consumtion. ramoops_write_kmsg_hdr() has same logic if
> null hdr happened. So let's avoid those cases.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/pstore/platform.c | 3 +++
>  fs/pstore/ram.c      | 6 ++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 7486e48..5e9b817 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -504,6 +504,9 @@ static void pstore_console_write(struct console *con, const char *s, unsigned c)
>  {
>         struct pstore_record record;
>
> +       if (!c)
> +               return;
> +
>         pstore_record_init(&record, psinfo);
>         record.type = PSTORE_TYPE_CONSOLE;
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 0bb086b..7e188f6 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -364,8 +364,10 @@ static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz,
>                 (time64_t)record->time.tv_sec,
>                 record->time.tv_nsec / 1000,
>                 record->compressed ? 'C' : 'D');
> -       WARN_ON_ONCE(!hdr);
> -       len = hdr ? strlen(hdr) : 0;
> +       if (WARN_ON_ONCE(!hdr))
> +               return 0;
> +
> +       len = strlen(hdr);
>         persistent_ram_write(prz, hdr, len);
>         kfree(hdr);

Applied, thanks!

-- 
Kees Cook
