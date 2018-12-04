Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A536C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245A92081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kr7Q9gvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245A92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeLDQNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:13:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42268 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeLDQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:13:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so14386022edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvH04Ps5Lg57metAv4huLwhA8TJUMhbN6M61VOMQrfU=;
        b=kr7Q9gvNfbcezDaqjjnrDT/LnJds5yTVVfVr5//Pwu55Xavq8Rjja6NO4cnhCr65kB
         NLlA5zFoqnCsPJzSa3rJpPv+P5j3F9frmdfvW5E6WRCqknJNbvdY6w43DstU4EH9krc4
         8lmiZtrPRY78hROAHGFY5QYNnRQfWM6b1pZyrsv/xB2tNx8GmZ4ZDpi15rZcsRAN4kyS
         25JNadKUyvO2FGVhKan2jGNvH7o1rmGueEyD12bscXQs915WFTKHPVGl24FS9sstS49m
         ULlfftxdCv/PlN2ta54+cKXYpWNRZkaMVfLWQRYtnWToFuTb8gffdCzbUqRiI8Enhgzx
         c2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvH04Ps5Lg57metAv4huLwhA8TJUMhbN6M61VOMQrfU=;
        b=dNzHT4GMt1rcNNw/DPYx3qP3tvp/p02H/w9vrf6Srdq1gWjSPpctIFpQRmb1/MzXNX
         oWSRQ4Wb8HUFcaysxTFwipdpYaYJ2Pq8bNiwJvMwE8j9/Y3FlsM3fzrJ7wOY8YG9NJXp
         gIsZWJiUUD1s3CXXaxkFJS6+V1G1WorWl1Bhb51sBWXkk8IGbzoYg4Hq0SXLKlcgVkKi
         d9iQNMisHAtH76xEeOiAqurBRfQ5osLgkhHDQNiKwzmZKOzWGZHQW+Rzm+ejUtt+4HZG
         zdwky7QjDsdOPoqhMtRFtua8Gp8gt6NYHUgLkfO6oVzsA5z9lbJVK+jvbt2YxoPnGlWx
         072w==
X-Gm-Message-State: AA+aEWasZAUvN/5+PTtV5u5LHsqxEVpmIbpddGD7j1+eLNdJxCY6eCYC
        rWjdQ/CSprmvNn61Eyhh7jSbW8dL3TuAOejuQdoiwA==
X-Google-Smtp-Source: AFSGD/UThh6OJAPGTq0TcvLZ6HSM/WWz45izD6IKqnOYruQwzLiw+pkq2FWEBqdkO56vRvOsbCtgXmb1VaE08PdkChE=
X-Received: by 2002:a17:906:d507:: with SMTP id ge7-v6mr16100494ejb.78.1543940014149;
 Tue, 04 Dec 2018 08:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20181204155843.11411-1-enric.balletbo@collabora.com> <CABXOdTeBL3n1BTToCv0BsAMZKan3RkOgqOG2cP7V8UyEPMup2g@mail.gmail.com>
In-Reply-To: <CABXOdTeBL3n1BTToCv0BsAMZKan3RkOgqOG2cP7V8UyEPMup2g@mail.gmail.com>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Tue, 4 Dec 2018 08:13:21 -0800
Message-ID: <CAE_wzQ_d0YzYqkxhMGuVsMLu5LEv1BFUbV9LSejzXOvn2ghAVA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mfd: cros_ec: Use devm_kzalloc for private data"
To:     Guenter Roeck <groeck@google.com>
Cc:     enric.balletbo@collabora.com, Lee Jones <lee.jones@linaro.org>,
        gwendal@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 8:07 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Tue, Dec 4, 2018 at 7:58 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > This reverts commit 3aa2177e47878f7e7616da8a2050c44f22301b6e.
> >
> > That commit triggered a new WARN when unloading the module (see at the
> > end of the commit message). When a class_dev is embedded in a structure
> > then that class_dev is the thing that controls the lifetime of that
> > structure, for that reason device managed allocations can't be used here.
> > See Documentation/kobject.txt.
> >
> > Revert the above patch, so the struct is allocated using kzalloc and we
> > have a release function for it that frees the allocated memory, otherwise
> > it is broken.
> >
> >  ------------[ cut here ]------------
> >  Device 'cros_ec' does not have a release() function, it is broken and must be fixed.
> >  WARNING: CPU: 3 PID: 3675 at drivers/base/core.c:895 device_release+0x80/0x90
> >  Modules linked in: btusb btrtl btintel btbcm bluetooth ...
> >  CPU: 3 PID: 3675 Comm: rmmod Not tainted 4.20.0-rc4 #76
> >  Hardware name: Google Kevin (DT)
> >  pstate: 40000005 (nZcv daif -PAN -UAO)
> >  pc : device_release+0x80/0x90
> >  lr : device_release+0x80/0x90
> >  sp : ffff00000c47bc70
> >  x29: ffff00000c47bc70 x28: ffff8000e86b0d40
> >  x27: 0000000000000000 x26: 0000000000000000
> >  x25: 0000000056000000 x24: 0000000000000015
> >  x23: ffff8000f0bbf860 x22: ffff000000d320a0
> >  x21: ffff8000ee93e100 x20: ffff8000ed931428
> >  x19: ffff8000ed931418 x18: 0000000000000020
> >  x17: 0000000000000000 x16: 0000000000000000
> >  x15: 0000000000000400 x14: 0000000000000143
> >  x13: 0000000000000000 x12: 0000000000000400
> >  x11: 0000000000000157 x10: 0000000000000960
> >  x9 : ffff00000c47b9b0 x8 : ffff8000e86b1700
> >  x7 : 0000000000000000 x6 : ffff8000f7d520b8
> >  x5 : ffff8000f7d520b8 x4 : 0000000000000000
> >  x3 : ffff8000f7d58e68 x2 : ffff8000e86b0d40
> >  x1 : 37d859939c964800 x0 : 0000000000000000
> >  Call trace:
> >   device_release+0x80/0x90
> >   kobject_put+0x74/0xe8
> >   device_unregister+0x20/0x30
> >   ec_device_remove+0x34/0x48 [cros_ec_dev]
> >   platform_drv_remove+0x28/0x48
> >   device_release_driver_internal+0x1a8/0x240
> >   driver_detach+0x40/0x80
> >   bus_remove_driver+0x54/0xa8
> >   driver_unregister+0x2c/0x58
> >   platform_driver_unregister+0x10/0x18
> >   cros_ec_dev_exit+0x1c/0x2d8 [cros_ec_dev]
> >   __arm64_sys_delete_module+0x16c/0x1f8
> >   el0_svc_common+0x84/0xd8
> >   el0_svc_handler+0x2c/0x80
> >   el0_svc+0x8/0xc
> >  ---[ end trace a57c4625f3c60ae8 ]---
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>

Indeed, we need to be mindful that refcounted objects should not be
allocated with devm_kzalloc().

Reviewed-by: Dmitry Torokhov <dtor@chromium.org>

>
> > ---
> >
> >  drivers/mfd/cros_ec_dev.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index 8f9d6964173e..b99a194ce5a4 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -263,6 +263,11 @@ static const struct file_operations fops = {
> >  #endif
> >  };
> >
> > +static void cros_ec_class_release(struct device *dev)
> > +{
> > +       kfree(to_cros_ec_dev(dev));
> > +}
> > +
> >  static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> >  {
> >         /*
> > @@ -395,7 +400,7 @@ static int ec_device_probe(struct platform_device *pdev)
> >         int retval = -ENOMEM;
> >         struct device *dev = &pdev->dev;
> >         struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
> > -       struct cros_ec_dev *ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
> > +       struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
> >
> >         if (!ec)
> >                 return retval;
> > @@ -417,6 +422,7 @@ static int ec_device_probe(struct platform_device *pdev)
> >         ec->class_dev.devt = MKDEV(ec_major, pdev->id);
> >         ec->class_dev.class = &cros_class;
> >         ec->class_dev.parent = dev;
> > +       ec->class_dev.release = cros_ec_class_release;
> >
> >         retval = dev_set_name(&ec->class_dev, "%s", ec_platform->ec_name);
> >         if (retval) {
> > --
> > 2.19.1
> >
