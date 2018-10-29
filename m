Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8689B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX5k3o4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8689B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJ2Win (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:38:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39384 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeJ2Wim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:38:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id e4so4918474qkh.6;
        Mon, 29 Oct 2018 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjssz8wWghB7h6EoPFUNnmXMlmaziLD7lvgugxwkXGc=;
        b=dX5k3o4vGtP2wXWU+uFyNgx9X7dHPJGsudoXHlzrAN44i5LYHdrLtgjtzH4lXaiYQr
         bHJtwrdt48TU9rQsacGE4Wg3LgFzrpHD+y9GS8DwqYXTTAGucKxB4ZdrTIV4KF6SZ2Da
         r9X2IQFhKe9ArvlJUKvKX/F6amaV6Z6ED6rq/muilPsFCzNhn3EVRBUWPUIXcTyM6Qu8
         SnsOA5LcMxKFudeOkB/Gc9yoKZ9wml9aFibWk9MK4PWZaVOzaWBWcdsVjw7CAyCoiYI1
         FsWr/KA89y5X70qbnHvLXQUcim2F1fw0yttt3w71//ren3EK59Yte6MvmgRFb/TTzSwz
         m0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjssz8wWghB7h6EoPFUNnmXMlmaziLD7lvgugxwkXGc=;
        b=tSQ0L33qxdlUjiYG1QS+peGkszdXvRulPo4Wy3BVadJdr9mv8hd4VOXmLYXuh50gPy
         QsEtbI1Dh+3V7JqofTZdwGqif+WXxD8y2uvE7AJ/w9/cr1EFA5RiwFZgpzp3mBqBGLNo
         6nZbVqQ9RrwcbIQEapFaCJJmbAh4fgYHSH+/GZbN72B97zaE2qTnAsmqtdErCMlfsrvj
         vQ4SFkyoV8hCzh6uSHv0g9w1MUzhsf4ZO4P+lNqMysBSn16hRL8vPZ9iV0iawdt0M41a
         cxn1LXc4VquUx64FFUu/SHKV6pIEPCC+A2k8FxH+bsz/3SO6ypeeW4LnAi++F7yhuHnO
         RAZw==
X-Gm-Message-State: AGRZ1gLgQ90qifXHS03QxqHfFm2P7fI/J6Xk79LD9PGqGh4q8b/uQ96P
        iouQa7eXNXM5WiJSZMg0iuKxJtfpArIPGaAG2Sw=
X-Google-Smtp-Source: AJdET5dIu9HSdrRUb3yRTYFgko0m1OV5sOiFqvF7JY8ISTJvy7OFercuUHONpUWWCWErhjNYiSXA0IdyaAWshgpFj/0=
X-Received: by 2002:a37:7983:: with SMTP id u125-v6mr11522925qkc.219.1540820996945;
 Mon, 29 Oct 2018 06:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181028060700.22110-1-bhumirks@gmail.com>
In-Reply-To: <20181028060700.22110-1-bhumirks@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 15:49:45 +0200
Message-ID: <CAHp75Ve0ps=MmyZMA0z6ExOrsk8x3D-rw2JtYwWZ+FqmZ7SLKQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: wmi: declare device_type structure as constant
To:     Bhumika Goyal <bhumirks@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 8:07 AM Bhumika Goyal <bhumirks@gmail.com> wrote:
>
> The only usage of device_type structure is getting stored as
> a reference in the type field of device structure. This type
> field is declared const. Therefore, the device_type structure
> can never be modified and can be declared as const.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/platform/x86/wmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 04791ea5d97b..bea35be68706 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -987,19 +987,19 @@ static struct bus_type wmi_bus_type = {
>         .remove = wmi_dev_remove,
>  };
>
> -static struct device_type wmi_type_event = {
> +static const struct device_type wmi_type_event = {
>         .name = "event",
>         .groups = wmi_event_groups,
>         .release = wmi_dev_release,
>  };
>
> -static struct device_type wmi_type_method = {
> +static const struct device_type wmi_type_method = {
>         .name = "method",
>         .groups = wmi_method_groups,
>         .release = wmi_dev_release,
>  };
>
> -static struct device_type wmi_type_data = {
> +static const struct device_type wmi_type_data = {
>         .name = "data",
>         .groups = wmi_data_groups,
>         .release = wmi_dev_release,
> --
> 2.14.5
>


-- 
With Best Regards,
Andy Shevchenko
