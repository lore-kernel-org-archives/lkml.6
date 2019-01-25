Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5EAC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834CC218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2z/itWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfAYTS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:18:27 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45297 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAYTS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:18:27 -0500
Received: by mail-ua1-f68.google.com with SMTP id e16so3605877uam.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 11:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Q6GjFXe3T27df+4QcYTUvFXIi+gJ1k3P+X4LneyE8k=;
        b=e2z/itWL16DsgkBa9o8tmRFFqBF0WShKV0ufuMK7CNM5LJSovhn5Ijp1p4EhNwG0u6
         +UGWFZPY/frLbZjgEWNaAfGzfigYOnLEIs6XP4YNRhqXSNk69yqlmucidMr/1eNka884
         m1OOwlfzp3xD2lAG7QQRaNCmAXkt9R6iXHgMZ+5Y3e1yScp5p9wCXaOm0utUEMFPXtta
         mcRFFZmwlr9amBpx0OyhjZJb7egpD8VxYanhwm2XVdLopkTcSVfMmVmtIRaPHuZ0++SB
         px9oexjDUG7sOuTFRbPW6mcoc5Bii0wtqWJonEqRa6FcbuewacUlWSLpKYuYl4IY0x/F
         m5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Q6GjFXe3T27df+4QcYTUvFXIi+gJ1k3P+X4LneyE8k=;
        b=rKQH4T70Vyl+HQ2V4c3QRTXMOATMviI41em4zm2VNe92MGdNIIa/ZARtLCSagppvZD
         FYh16B19JfOjyczy6IRuj5euTEK/RyEJUiJvTbyXDPw2RXCbv8gokeo5an8VpwnBMMnb
         Gr2IeJ4XO6tGn+9ji00J1yfWGA2us/WUZP/b9a3EnISN8zxMiLzdz6iO2XP94VpQTHzt
         ymfXCmaFBq3h8t//XGmaqu5JJP+u9o7NDh5zqhPaoFNbQVLVFVC+BND+qYRclMYWXohA
         NgPt8yFamGyVm68S40wtIDTBACasW6wqCh58ct23GzIoC3QYekchDR7BM5OVZgTBntA3
         3cRg==
X-Gm-Message-State: AJcUukeXSNMzqgAAW34UJcDeKg6+M0VobZn7MoZTAtEEdL7zm2PzCYgB
        6YqLU3m9hE3dYxpRLyExTyRv0DC8WpfyAi0LHk/H1Peh
X-Google-Smtp-Source: ALg8bN4KOW7ei+k2+HiEJL9B49SLWInUMf9wCU3XE+VhtzYr6S+QKYiqZUWWELJt2QMl3F73kaYn4C3uMTwUFZCYeVI=
X-Received: by 2002:ab0:4e23:: with SMTP id g35mr5216473uah.8.1548443905673;
 Fri, 25 Jan 2019 11:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-2-oded.gabbay@gmail.com>
 <f6616b8d1983286a9df8e0b62849558487da3847.camel@perches.com>
In-Reply-To: <f6616b8d1983286a9df8e0b62849558487da3847.camel@perches.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 25 Jan 2019 21:18:00 +0200
Message-ID: <CAFCwf13in=4BUFwfmkQSc+77jNuCrWXTRv-Dx=aY+7oEHd-aMQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] habanalabs: add skeleton driver
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 2:49 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2019-01-23 at 02:00 +0200, Oded Gabbay wrote:
> > This patch adds the habanalabs skeleton driver. The driver does nothing at
> > this stage except very basic operations. It contains the minimal code to
> > insmod and rmmod the driver and to create a /dev/hlX file per PCI device.
>
> trivial notes:
>
> >
> > diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
> []
> > \ No newline at end of file
>
> You should fixes these.  There are a least a couple of them.
>
> > diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> []
> > @@ -0,0 +1,331 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright 2016-2018 HabanaLabs, Ltd.
> > + * All Rights Reserved.
> > + */
>
> Add #define pr_fmt(fmt) "habanalabs: " fmt
>
> > +
> > +#include "habanalabs.h"
>
> or add it in this file
>
>
> > +static int device_setup_cdev(struct hl_device *hdev, struct class *hclass,
> > +                             int minor, const struct file_operations *fops)
> > +{
> > +     int err, devno = MKDEV(hdev->major, minor);
> > +     struct cdev *hdev_cdev = &hdev->cdev;
> > +     char name[8];
> > +
> > +     sprintf(name, "hl%d", hdev->id);
>
> Might overflow name one day
>
> > +
> > +     cdev_init(hdev_cdev, fops);
> > +     hdev_cdev->owner = THIS_MODULE;
> > +     err = cdev_add(hdev_cdev, devno, 1);
> > +     if (err) {
> > +             pr_err("habanalabs: Failed to add char device %s", name);
>
> So #define pr_fmt can auto prefix these and this would be
>
>                 pr_err("Failed to add char device %s\n", name);
>
> missing terminating '\n' btw
>
> > +             goto err_cdev_add;
> > +     }
> > +
> > +     hdev->dev = device_create(hclass, NULL, devno, NULL, "%s", name);
> > +     if (IS_ERR(hdev->dev)) {
> > +             pr_err("habanalabs: Failed to create device %s\n", name);
>
> And this would be:
>                 pr_err("Failed to create device %s\n", name);
>
>
> etc...
>
> > +static int device_early_init(struct hl_device *hdev)
> > +{
> > +     switch (hdev->asic_type) {
> > +     case ASIC_GOYA:
> > +             sprintf(hdev->asic_name, "GOYA");
>
> strcpy or perhaps better still as strlcpy
>
> > +int hl_device_init(struct hl_device *hdev, struct class *hclass)
> > +{
> []
> > +     dev_notice(hdev->dev,
> > +             "Successfully added device to habanalabs driver\n");
>
> This is mostly aligned to open parenthesis, but perhaps
> it could check with scripts/checkpatch.pl --strict and
> see if you agree with anything it bleats.
>
> > +int hl_poll_timeout_memory(struct hl_device *hdev, u64 addr,
> > +                             u32 timeout_us, u32 *val)
> > +{
> > +     /*
> > +      * pReturnVal is defined as volatile because it points to HOST memory,
> > +      * which is being written to by the device. Therefore, we can't use
> > +      * locks to synchronize it and it is not a memory-mapped register space
> > +      */
> > +     volatile u32 *pReturnVal = (volatile u32 *) addr;
>
> It'd be nice to avoid hungarian and camelcase
>
> > +     ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
> > +
> > +     might_sleep();
> > +
> > +     for (;;) {
> > +             *val = *pReturnVal;
> > +             if (*val)
> > +                     break;
> > +             if (ktime_compare(ktime_get(), timeout) > 0) {
> > +                     *val = *pReturnVal;
> > +                     break;
> > +             }
> > +             usleep_range((100 >> 2) + 1, 100);
> > +     }
> > +
> > +     return (*val ? 0 : -ETIMEDOUT);
>
> Unnecessary parentheses
>
> > diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
> []
> > +static struct pci_device_id ids[] = {
> > +     { PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GOYA), },
> > +     { 0, }
> > +};
>
> static const?
>
> > diff --git a/drivers/misc/habanalabs/include/habanalabs_device_if.h b/drivers/misc/habanalabs/include/habanalabs_device_if.h
> []
> > +struct hl_bd {
> > +     __u64   ptr;
> > +     __u32   len;
> > +     union {
> > +             struct {
> > +                     __u32   repeat:16;
> > +                     __u32   res1:8;
> > +                     __u32   repeat_valid:1;
> > +                     __u32   res2:7;
> > +             };
> > +             __u32   ctl;
> > +     };
> > +};
>
> Maybe use the appropriate bit-endian __le<size> instead of __u<size>
> with whatever cpu_to_le<size> / le<size>_to_cpu bits are necessary.
>
>

Hi Joe,
Thanks for the review.
I fixed everything except for two things:
1. Alignment to open parenthesis. I never code like that in the kernel
and I don't really believe in anything that requires to combine spaces
and tabs.
2. The bit-endian format. We don't support big-endian architecture
(what's left after POWER moved to support little endian ?). And in any
case, our software stack is so big that this minor change in the
driver won't have any impact.

Thanks,
Oded
