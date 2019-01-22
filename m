Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28093C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D048C21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="idLw4Xdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfAVBxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:53:16 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40591 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfAVBxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:53:16 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so13769770vsf.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 17:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3iZTzvSMKsWoPNy8nnLF8wFN432MVgBa9lakKj4tn8=;
        b=idLw4XdpJxqAQbwcG1pDEyBe+TV2gaO5gg7GIeN8FkioKCHgCTzA+stmpkpCThwCzZ
         odHq+7Y/ORqUB0tgJmG+RZQ9mRk5X+GVZn1Oh4hELgvFS7YRu1zZXB2ujNZchVxhI4Sm
         lm4l5hsD+6rxvxuseyDBt8aUbDhbm9UhOeNl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3iZTzvSMKsWoPNy8nnLF8wFN432MVgBa9lakKj4tn8=;
        b=YwuFyx2HyWbZxbwZVSUMeNfgXaM56fObYrLt08r2MDc/46/13IMbhGVyubIVOccOMD
         MAAcgoILIv20XYTX+GJdri5c+DnfyKhMu7kwbjwZU+Q/6pqKNA2XnM7O3KwG3sVTrIby
         fxQK87JyjVweIkrUaGWJ5cm8wUrh9/qTd6m/UXwk62U/dLVDulvT+eQJ0vlJrP+9JMBC
         TvYp3Jx8GSbzk2YtUIzrJ3XgXceEPvVutVWldtDdl40x1YVljmml+HO+2s9HZGnqxPPO
         BcXWCiDT6s93fL6v49yJiQdybidDXlCIr1n/WWLOi3TMU9Q1GH3VNg9q3xJW6dmBM5XZ
         ueGg==
X-Gm-Message-State: AJcUukek4l/63hA0lkkfxQbOgw+rDSMZ1PRi1wNNIjaNZ+ZSmO8Cbm+O
        3BRppRXuDSIazHMa7PCWBpPUs2EA8rY=
X-Google-Smtp-Source: ALg8bN6+zwjCIH0iMNmdCyuDJTr/0u9qXSp0DEXTTC1bsphUOl5Ius2tnEzmiLAQmbMBQ31Tnz7iAQ==
X-Received: by 2002:a67:7f47:: with SMTP id a68mr13476321vsd.204.1548121994525;
        Mon, 21 Jan 2019 17:53:14 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id o19sm21485302vkd.14.2019.01.21.17.53.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 17:53:13 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id u11so13749623vsp.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 17:53:13 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr13053939vss.172.1548121992878;
 Mon, 21 Jan 2019 17:53:12 -0800 (PST)
MIME-Version: 1.0
References: <5c4673dd.1c69fb81.b0b12.0b35SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5c4673dd.1c69fb81.b0b12.0b35SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 22 Jan 2019 14:53:01 +1300
X-Gmail-Original-Message-ID: <CAGXu5jKs5Hzfaho0Bg7rJCLa7XJPzBOnBXMUNHPj2jjgOBD=8Q@mail.gmail.com>
Message-ID: <CAGXu5jKs5Hzfaho0Bg7rJCLa7XJPzBOnBXMUNHPj2jjgOBD=8Q@mail.gmail.com>
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
> From: Yue Hu <huyue2@yulong.com>
> Date: Mon, 21 Jan 2019 18:20:41 +0800
> Subject: [PATCH] pstore/ram: Replace dummy_data heap memory with stack
> memory
>
> In ramoops_register_dummy() dummy_data is allocated via kzalloc()
> then it will always occupy the heap space after register platform
> device via platform_device_register_data(), but it will not be
> used any more. So let's free it for system usage, replace it with
> stack memory is better due to small size.

That's not true: dummy_data is registered with
platform_device_register_data() which stores the pointer. (And is used
in ramoops_probe().) When the probe runs, the stack frame will be
gone.

That said, it would be possible to move the stack allocation into
ramoops_init() instead, since the frame will still be available during
the call to platform_driver_register() which will call
ramoops_probe(). If you made that change, then we could drop the
ramoops_unregister_dummy() call, and rename ramoops_register_dummy()
into ramoops_populate_dummy() or something.

But even in this case, you'd need to remove the platform data after
the probe just to make sure the stack pointer didn't stick around.

-Kees

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
>         if (IS_ERR(dummy)) {
>                 pr_info("could not create platform device: %ld\n",
>                         PTR_ERR(dummy));
> --
> 1.9.1
>
>
>
>


-- 
Kees Cook
