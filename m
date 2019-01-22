Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C12EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D405520861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TVgzi0RG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfAVDc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:32:28 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40017 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfAVDc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 22:32:27 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so13872597vsf.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 19:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZXtK0D/D/V4zPfgD1wzS94Y6e0ERrrXG66Ta+cSdSjA=;
        b=TVgzi0RGePha2X9BObF8wRcoCdnmVmYm09Pkw5G1g18pILoZV9SsSCaJj6eCdoHIYu
         zpvOiEcnqujeArXRFKu3DPBdDKyk6/UWtOM3fgbPAjj9mmIarlq2aHRBB7R027iOFXX1
         6e0ojbXInpgLTHuTYjc/tDJAKIrOo6kL0uoV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXtK0D/D/V4zPfgD1wzS94Y6e0ERrrXG66Ta+cSdSjA=;
        b=JjCgkNIo73i5RNajpm1hTzn2wMhMcrLLfDs3dxm5CpCThaDRG5lEZ3rieRkaM81fwQ
         uEr0Cw4Sv2FOZFKezjud5fLxcHVNk41ShKSoW1GCb2qJ6LSpDGOcewwfN7rDU+X1R/xu
         q/7FlCixWp1WFvB2B7siedKSCRfn6WrHxRSIhwrasgLvioflPftW3AprkN6aX73dlD7m
         /PEY6wcVXUx8HpVEAHDtzL39oIPz0ITjmxyNJVgT4fqq1PnnbetLzk7TPfjAP60UMby4
         RRWAMJ5XjQIs/qxsfQIfoYQeDIJJtozS62nlF7E72v5lEqKCrOesTM1nVMTrZIvWk6ZI
         FnZA==
X-Gm-Message-State: AJcUukeVx23QbiYM9qYQHEMQwtW5CNYRpib4zhJblO4gIn3GliL4Zgy+
        m1rtFHtX3YCJt0Ya1wlqGAZ81Fpk4fI=
X-Google-Smtp-Source: ALg8bN5p9bQWwZ5Lq0OhMU1zNGiWtWSLltRD016YehKnxNiB0CxPwhugjWYXFScxGdJASj35IYGKcA==
X-Received: by 2002:a67:fa59:: with SMTP id j25mr1368641vsq.18.1548127946038;
        Mon, 21 Jan 2019 19:32:26 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id u136sm22167013vku.10.2019.01.21.19.32.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 19:32:25 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id d19so7590571uaq.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 19:32:24 -0800 (PST)
X-Received: by 2002:ab0:6151:: with SMTP id w17mr13025410uan.114.1548127944471;
 Mon, 21 Jan 2019 19:32:24 -0800 (PST)
MIME-Version: 1.0
References: <5c4673dd.1c69fb81.b0b12.0b35SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5c4673dd.1c69fb81.b0b12.0b35SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 22 Jan 2019 16:32:11 +1300
X-Gmail-Original-Message-ID: <CAGXu5j+rT9jgEW0KQmJ1ZOR8KQeJsW+xwuoAkUp-M50BiOr=9Q@mail.gmail.com>
Message-ID: <CAGXu5j+rT9jgEW0KQmJ1ZOR8KQeJsW+xwuoAkUp-M50BiOr=9Q@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Replace dummy_data heap memory with stack memory
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

On Tue, Jan 22, 2019 at 2:37 PM Yue Hu <huyue2@yulong.com> wrote:
>
> From e37cbd4d22eae55c034536817b22d429ba0ae27a Mon Sep 17 00:00:00 2001

Can you check your MUA? It turns out this email was damaged in a few ways:
- something broke enough that it never appeared on patchwork (maybe
not on lkml either?)
- lines are wrapped in the body

> From: Yue Hu <huyue2@yulong.com>
> Date: Mon, 21 Jan 2019 18:20:41 +0800
> Subject: [PATCH] pstore/ram: Replace dummy_data heap memory with stack
> memory

like here

>
> In ramoops_register_dummy() dummy_data is allocated via kzalloc()
> then it will always occupy the heap space after register platform
> device via platform_device_register_data(), but it will not be
> used any more. So let's free it for system usage, replace it with
> stack memory is better due to small size.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/pstore/ram.c | 34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 96f7d32..8db1f7f 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -110,7 +110,6 @@ struct ramoops_context {
>  };
>
>  static struct platform_device *dummy;
> -static struct ramoops_platform_data *dummy_data;
>
>  static int ramoops_pstore_open(struct pstore_info *psi)
>  {
> @@ -896,13 +895,12 @@ static inline void ramoops_unregister_dummy(void)
>  {
>         platform_device_unregister(dummy);
>         dummy = NULL;
> -
> -       kfree(dummy_data);
> -       dummy_data = NULL;
>  }
>
>  static void __init ramoops_register_dummy(void)
>  {
> +       struct ramoops_platform_data pdata;
> +
>         /*
>          * Prepare a dummy platform data structure to carry the module
>          * parameters. If mem_size isn't set, then there are no module
> @@ -913,30 +911,24 @@ static void __init ramoops_register_dummy(void)
>
>         pr_info("using module parameters\n");
>
> -       dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);

The zeroing here is required.

> -       if (!dummy_data) {
> -               pr_info("could not allocate pdata\n");
> -               return;
> -       }
> -
> -       dummy_data->mem_size = mem_size;
> -       dummy_data->mem_address = mem_address;
> -       dummy_data->mem_type = mem_type;
> -       dummy_data->record_size = record_size;
> -       dummy_data->console_size = ramoops_console_size;
> -       dummy_data->ftrace_size = ramoops_ftrace_size;
> -       dummy_data->pmsg_size = ramoops_pmsg_size;
> -       dummy_data->dump_oops = dump_oops;
> -       dummy_data->flags = RAMOOPS_FLAG_FTRACE_PER_CPU;

I added a memset() to zero here to compensate.

> +       pdata.mem_size = mem_size;
> +       pdata.mem_address = mem_address;
> +       pdata.mem_type = mem_type;
> +       pdata.record_size = record_size;
> +       pdata.console_size = ramoops_console_size;
> +       pdata.ftrace_size = ramoops_ftrace_size;
> +       pdata.pmsg_size = ramoops_pmsg_size;
> +       pdata.dump_oops = dump_oops;
> +       pdata.flags = RAMOOPS_FLAG_FTRACE_PER_CPU;
>
>         /*
>          * For backwards compatibility ramoops.ecc=1 means 16 bytes ECC
>          * (using 1 byte for ECC isn't much of use anyway).
>          */
> -       dummy_data->ecc_info.ecc_size = ramoops_ecc == 1 ? 16 :
> ramoops_ecc;
> +       pdata.ecc_info.ecc_size = ramoops_ecc == 1 ? 16 : ramoops_ecc;
>
>         dummy = platform_device_register_data(NULL, "ramoops", -1,
> -                       dummy_data, sizeof(struct
> ramoops_platform_data));
> +                       &pdata, sizeof(struct ramoops_platform_data));

I made this more robust by using sizeof(pdata) instead of an explicit struct.

>         if (IS_ERR(dummy)) {
>                 pr_info("could not create platform device: %ld\n",
>                         PTR_ERR(dummy));
> --
> 1.9.1

The result should be visible in linux-next soon.

-- 
Kees Cook
