Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F141EC282C0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A1E2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GuOxT22n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfAVC6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:58:44 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46812 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfAVC6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:58:42 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so13827932vso.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 18:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W219i2I5y58zAtgJhaqEJeizGX8EjqFydPJu1ke2UJ4=;
        b=GuOxT22nT5aykyGdEF0pVEilKawR3pRD0ggqgKUDAAFW9DccxAZzqIE+wc+wpbo/cp
         C26MBVhQ9yLMDUvgeP/pcpeOAWVgMTDygY8VVn+4PK/kpazg+74YQO6nG4HypkkYtZua
         UXewW83HwjzXzwt2K58DKxqkrfJ5RmKxS3Yo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W219i2I5y58zAtgJhaqEJeizGX8EjqFydPJu1ke2UJ4=;
        b=J2fNwHQICnAovW4MtQQBDm+f6OL2m33zHxNtXodK4rrhk0VA7UY4GGh4puwE+Y0836
         50bPUk2UH6ETj1omzVgx66+zEPyHnQRQO0EFByVHx6YIpXgz2v6yanOnMrtU+RbUCgoB
         hI/JrZQ4b3bZsZ+dxNFmBn1F6eWJezci+q/ubLubg8C6Cz7H7Ydv5+5KjlVTZU4GOAkl
         yTflvsbyWITlBDmus8NZbPvb4Idmy1AsPHr99FTpQhA86Ox5nN3sPlVTMLEfoj1etkvo
         vc9zWvwPEQSnsGe/4mYQYpKKz9g9xSV7FOopI41rf4/q+C0qG/w7EAr7pglbUNd0oheZ
         z6BA==
X-Gm-Message-State: AJcUukdoIqtKHpFy83V1PREkKkDxByd3lf4PWaWxWQRdYx+GiUoSI9un
        Nov58G2r2VPpe6t+dGKyTocoC8Mk01s=
X-Google-Smtp-Source: ALg8bN5XzfsXqbGQ15VPNUpgVswjP2TnOGJPJN8udCnML5cxp3BKh8yQcicPFmbKiKp5Cv7lx4L2/Q==
X-Received: by 2002:a67:cb9b:: with SMTP id h27mr12969008vsl.227.1548125920732;
        Mon, 21 Jan 2019 18:58:40 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id x132sm4046062vsc.34.2019.01.21.18.58.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 18:58:39 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id d2so7608342ual.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 18:58:39 -0800 (PST)
X-Received: by 2002:ab0:740a:: with SMTP id r10mr10219363uap.14.1548125918814;
 Mon, 21 Jan 2019 18:58:38 -0800 (PST)
MIME-Version: 1.0
References: <5c4673dd.1c69fb81.b0b12.0b35SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAGXu5jKs5Hzfaho0Bg7rJCLa7XJPzBOnBXMUNHPj2jjgOBD=8Q@mail.gmail.com> <5c468452.1c69fb81.7c308.b2aaSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5c468452.1c69fb81.7c308.b2aaSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 22 Jan 2019 15:58:27 +1300
X-Gmail-Original-Message-ID: <CAGXu5jL32Uh4bMh6Xxac3fV2nzGUyG7_ARcuT9+HBqraQhD03Q@mail.gmail.com>
Message-ID: <CAGXu5jL32Uh4bMh6Xxac3fV2nzGUyG7_ARcuT9+HBqraQhD03Q@mail.gmail.com>
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

On Tue, Jan 22, 2019 at 3:47 PM Yue Hu <huyue2@yulong.com> wrote:
>
> On Tue, 22 Jan 2019 14:53:01 +1300
> Kees Cook <keescook@chromium.org> wrote:
>
> > On Tue, Jan 22, 2019 at 2:37 PM Yue Hu <huyue2@yulong.com> wrote:
> > >
> > > From e37cbd4d22eae55c034536817b22d429ba0ae27a Mon Sep 17 00:00:00
> > > 2001 From: Yue Hu <huyue2@yulong.com>
> > > Date: Mon, 21 Jan 2019 18:20:41 +0800
> > > Subject: [PATCH] pstore/ram: Replace dummy_data heap memory with
> > > stack memory
> > >
> > > In ramoops_register_dummy() dummy_data is allocated via kzalloc()
> > > then it will always occupy the heap space after register platform
> > > device via platform_device_register_data(), but it will not be
> > > used any more. So let's free it for system usage, replace it with
> > > stack memory is better due to small size.
> >
> > That's not true: dummy_data is registered with
> > platform_device_register_data() which stores the pointer. (And is used
> > in ramoops_probe().) When the probe runs, the stack frame will be
> > gone.
>
> hi Kees,
>
> Yes, platform_device_register_data() will store the pointer to
> platform_data, however the store process is using memory copy(kmemdup)
> internelly as below:
>
> ```c
> int platform_device_add_data(struct platform_device *pdev, const void
> *data, size_t size)
> {
>         void *d = NULL;
>
>         if (data) {
>                 d = kmemdup(data, size, GFP_KERNEL);
>                 if (!d)
>                         return -ENOMEM;
>         }
>
>         kfree(pdev->dev.platform_data);
>         pdev->dev.platform_data = d;
>         return 0;
> }
> ```

Ah! Yes, you're totally right. I misread
platform_device_register_resndata() and didn't dig far enough. :)

I'll get this added to the series. Thanks!

-Kees

>
> so no need to keep the memory for the parameter of platform specific
> data passed in platform_device_register_data().
>
> When using the change, probe is successful and it's working fine by
> test.
>
> >
> > That said, it would be possible to move the stack allocation into
> > ramoops_init() instead, since the frame will still be available during
> > the call to platform_driver_register() which will call
> > ramoops_probe(). If you made that change, then we could drop the
> > ramoops_unregister_dummy() call, and rename ramoops_register_dummy()
> > into ramoops_populate_dummy() or something.
> >
> > But even in this case, you'd need to remove the platform data after
> > the probe just to make sure the stack pointer didn't stick around.
> >
> > -Kees
> >
> > >
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > ---
> > >  fs/pstore/ram.c | 34 +++++++++++++---------------------
> > >  1 file changed, 13 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> > > index 96f7d32..8db1f7f 100644
> > > --- a/fs/pstore/ram.c
> > > +++ b/fs/pstore/ram.c
> > > @@ -110,7 +110,6 @@ struct ramoops_context {
> > >  };
> > >
> > >  static struct platform_device *dummy;
> > > -static struct ramoops_platform_data *dummy_data;
> > >
> > >  static int ramoops_pstore_open(struct pstore_info *psi)
> > >  {
> > > @@ -896,13 +895,12 @@ static inline void
> > > ramoops_unregister_dummy(void) {
> > >         platform_device_unregister(dummy);
> > >         dummy = NULL;
> > > -
> > > -       kfree(dummy_data);
> > > -       dummy_data = NULL;
> > >  }
> > >
> > >  static void __init ramoops_register_dummy(void)
> > >  {
> > > +       struct ramoops_platform_data pdata;
> > > +
> > >         /*
> > >          * Prepare a dummy platform data structure to carry the
> > > module
> > >          * parameters. If mem_size isn't set, then there are no
> > > module @@ -913,30 +911,24 @@ static void __init
> > > ramoops_register_dummy(void)
> > >
> > >         pr_info("using module parameters\n");
> > >
> > > -       dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
> > > -       if (!dummy_data) {
> > > -               pr_info("could not allocate pdata\n");
> > > -               return;
> > > -       }
> > > -
> > > -       dummy_data->mem_size = mem_size;
> > > -       dummy_data->mem_address = mem_address;
> > > -       dummy_data->mem_type = mem_type;
> > > -       dummy_data->record_size = record_size;
> > > -       dummy_data->console_size = ramoops_console_size;
> > > -       dummy_data->ftrace_size = ramoops_ftrace_size;
> > > -       dummy_data->pmsg_size = ramoops_pmsg_size;
> > > -       dummy_data->dump_oops = dump_oops;
> > > -       dummy_data->flags = RAMOOPS_FLAG_FTRACE_PER_CPU;
> > > +       pdata.mem_size = mem_size;
> > > +       pdata.mem_address = mem_address;
> > > +       pdata.mem_type = mem_type;
> > > +       pdata.record_size = record_size;
> > > +       pdata.console_size = ramoops_console_size;
> > > +       pdata.ftrace_size = ramoops_ftrace_size;
> > > +       pdata.pmsg_size = ramoops_pmsg_size;
> > > +       pdata.dump_oops = dump_oops;
> > > +       pdata.flags = RAMOOPS_FLAG_FTRACE_PER_CPU;
> > >
> > >         /*
> > >          * For backwards compatibility ramoops.ecc=1 means 16 bytes
> > > ECC
> > >          * (using 1 byte for ECC isn't much of use anyway).
> > >          */
> > > -       dummy_data->ecc_info.ecc_size = ramoops_ecc == 1 ? 16 :
> > > ramoops_ecc;
> > > +       pdata.ecc_info.ecc_size = ramoops_ecc == 1 ? 16 :
> > > ramoops_ecc;
> > >
> > >         dummy = platform_device_register_data(NULL, "ramoops", -1,
> > > -                       dummy_data, sizeof(struct
> > > ramoops_platform_data));
> > > +                       &pdata, sizeof(struct
> > > ramoops_platform_data)); if (IS_ERR(dummy)) {
> > >                 pr_info("could not create platform device: %ld\n",
> > >                         PTR_ERR(dummy));
> > > --
> > > 1.9.1
> > >
> > >
> > >
> > >
> >
> >
>
>
>


-- 
Kees Cook
