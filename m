Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB387C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA43206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQ6jnev5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA43206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeK2MVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:21:09 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46652 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeK2MVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:21:08 -0500
Received: by mail-yw1-f68.google.com with SMTP id t13so91245ywe.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 17:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOfRKn/RSmhVk1aKknVP4+f1zZqt7009vDQRIYyMjnQ=;
        b=VQ6jnev5O94TLRYS9ZsDkfbl9HjV0eMWZavhzIM3zEnE2qF+yvdD/o9nUSW7np7W9U
         hByhoE99gxCeeAYRX1zjbOUJkZyNFIj/TXeT3uLJBAiTLu0f4e0HGl5e8dUtHVxRlnhV
         gD/nxB+8FSqHh10o4mG3/u08lmtIPstnp7oz6VBBVIYlYpIszMo6QpJ/Lg35GecydU+p
         DdoiwV426WbMGT0eqMAqg1vkNgZSgC/r9T2qGccwPYVehpy9Pm8EgwnUNXAtDpzfgLae
         dCR672Z2gNR9XSMJjnWpYfFXHcnd3ML4qGxNOEiksAaEgvklrl2XPArumQow+IAMTT2i
         UsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOfRKn/RSmhVk1aKknVP4+f1zZqt7009vDQRIYyMjnQ=;
        b=rG7XBupIEYV5AhY25/MuQiQA1bZz9PHOAI1gqIQm6Zn05qKew9JTkwnj5nmCwVRWQQ
         SXeticsGKRPEUisr4Ru2Ydvc6cgHMJcN2l9JD7Qx2PfUzRLbN3pTQ9gWUb+gbQ1DqcpA
         9Up/dtr6Nk5pD6Etc8gQmboQWgnkuDurl8yJVGejr+v0EiaiAlcPMP4n52A6uWcfEO5U
         yRPgXF3g5KgU4Mo2IypuWCYGmM7AkO320TePZQ1GG5rmyj+8HLvs/m31Svna68C7YaqC
         BVZ3bPEGWTCny1AhrR1/AQljW8MrvDdKGVnpVi22fVMkzV1KG/26q98SfbAJuiH0hq29
         nHYQ==
X-Gm-Message-State: AA+aEWZz19pqVGePzrPfqhyONnmwIhHZLuL6UaA3n9rQiI+/NFTNnKqw
        wzb6lX+GY1AtankISMsJ3vpRDHJYOoMDAEFBE34USw==
X-Google-Smtp-Source: AFSGD/VLOAXOlPezzDJf+liXi2pUagBXKR8//4uEM+pI2XgKhm5KaL8bue8MUfBmn790qYu7C/AzEdnYqjPB5esqqAA=
X-Received: by 2002:a81:210b:: with SMTP id h11mr30338971ywh.299.1543454253794;
 Wed, 28 Nov 2018 17:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-9-enric.balletbo@collabora.com> <CABXOdTeL6ZC4mfGdU52bkz3-5g-EUL7wMvd-nDjmeBHWM2XSuA@mail.gmail.com>
 <20181127175219.GA30900@kroah.com>
In-Reply-To: <20181127175219.GA30900@kroah.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 28 Nov 2018 17:17:22 -0800
Message-ID: <CABXOdTehDNf_8DHjua6BTJ-_AA6wcfcis1DPFS5=93sEh-6LQA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mfd: cros_ec: add a dev_release empty method.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Nov 27, 2018 at 9:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 27, 2018 at 09:29:38AM -0800, Guenter Roeck wrote:
> > Hi Enric,
> >
> > On Tue, Nov 27, 2018 at 4:19 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > >
> > > Devices are required to provide a release method. This patch fixes the
> > > following WARN():
> > >
> > > [   47.218707] ------------[ cut here ]------------
> > > [   47.223901] Device 'cros_ec' does not have a release() function, it is broken and must be fixed.
> > > [   47.234430] WARNING: CPU: 0 PID: 3585 at drivers/base/core.c:895 device_release+0x80/0x90
> > > [   47.243560] Modules linked in: btusb btrtl btintel btbcm bluetooth ecdh_generic [...]
> > > [   47.323851] CPU: 0 PID: 3585 Comm: rmmod Not tainted 4.20.0-rc2+ #29
> > > [   47.330947] Hardware name: Google Kevin (DT)
> > > [   47.335714] pstate: 40000005 (nZcv daif -PAN -UAO)
> > > [   47.341063] pc : device_release+0x80/0x90
> > > [   47.345537] lr : device_release+0x80/0x90
> > > [   47.350001] sp : ffff00000b17bc70
> > > [   47.353698] x29: ffff00000b17bc70 x28: ffff8000e48e9a80
> > > [   47.359629] x27: 0000000000000000 x26: 0000000000000000
> > > [   47.365561] x25: 0000000056000000 x24: 0000000000000015
> > > [   47.371492] x23: ffff8000f0248060 x22: ffff000000b700a0
> > > [   47.377414] x21: ffff8000edf56100 x20: ffff8000edd13028
> > > [   47.383346] x19: ffff8000edd13018 x18: 0000000000000095
> > > [   47.389278] x17: 0000000000000000 x16: 0000000000000000
> > > [   47.395209] x15: 0000000000000400 x14: 0000000000000400
> > > [   47.401131] x13: 00000000000001a7 x12: 0000000000000000
> > > [   47.407053] x11: 0000000000000001 x10: 0000000000000960
> > > [   47.412976] x9 : ffff00000b17b9b0 x8 : ffff8000e48ea440
> > > [   47.418898] x7 : ffff8000ee9090c0 x6 : ffff8000f7d0b0b8
> > > [   47.424830] x5 : ffff8000f7d0b0b8 x4 : 0000000000000000
> > > [   47.430752] x3 : ffff8000f7d11e68 x2 : ffff8000e48e9a80
> > > [   47.436674] x1 : 37d859939c964800 x0 : 0000000000000000
> > > [   47.442597] Call trace:
> > > [   47.445324]  device_release+0x80/0x90
> > > [   47.449414]  kobject_put+0x74/0xe8
> > > [   47.453210]  device_unregister+0x20/0x30
> > > [   47.457592]  ec_device_remove+0x34/0x48 [cros_ec_dev]
> > > [   47.463233]  platform_drv_remove+0x28/0x48
> > > [   47.467805]  device_release_driver_internal+0x1a8/0x240
> > > [   47.473630]  driver_detach+0x40/0x80
> > > [   47.477609]  bus_remove_driver+0x54/0xa8
> > > [   47.481986]  driver_unregister+0x2c/0x58
> > > [   47.486355]  platform_driver_unregister+0x10/0x18
> > > [   47.491599]  cros_ec_dev_exit+0x1c/0x258 [cros_ec_dev]
> > > [   47.497338]  __arm64_sys_delete_module+0x16c/0x1f8
> > > [   47.502689]  el0_svc_common+0x84/0xd8
> > > [   47.506776]  el0_svc_handler+0x2c/0x80
> > > [   47.510960]  el0_svc+0x8/0xc
> > > [   47.514171] ---[ end trace 9087279fc8c03450 ]---
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > >
> > > Changes in v3: None
> > > Changes in v2:
> > > - Fix WARN when unloading. This is new in these series.
> > >
> > >  drivers/mfd/cros_ec_dev.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > > index 1ba98a32715e..cdb941c6db98 100644
> > > --- a/drivers/mfd/cros_ec_dev.c
> > > +++ b/drivers/mfd/cros_ec_dev.c
> > > @@ -35,9 +35,14 @@
> > >  #define CROS_MAX_DEV 128
> > >  static int ec_major;
> > >
> > > +static void cros_ec_dev_release(struct device *dev)
> > > +{
> > > +}
>
> Yeah, as part of the in-kernel documentation, I now get to make fun of
> you in public!
>
> You did read the documentation, right?
>

To be fair, the problem is difficult to understand. Maybe it is easy
for you, but that is not true for everyone, including me. Remember the
block discussion we just had ? As for the in-kernel documentation,
maybe there is a comprehensive explanation someone, one that clueless
people like me can understand, but all I found was

"If a bus driver unregisters a device, it should not immediately free
  it. It should instead wait for the driver model core to call the
  device's release method, then free the bus-specific object.
  (There may be other code that is currently referencing the device
  structure, and it would be rude to free the device while that is
  happening)"

Does that apply to mfd devices ? What other code may that be that
accesses the structure ? What else does it mean, or in other words,
what other cleanup code besides releasing the data structure needs to
reside in the release function ?

Sure, it would be easy to use kzalloc() instead of devm_kzalloc(), and
to release the memory in the class release function, but does that
actually _fix_ the problem ? Is dummy_sysfs_dev_release() in the
extcon core buggy, or is there a reason why the dummy function works
there ? I for my part have no idea whatsoever, and, sorry, the
documentation doesn't really help me to find out.

Guenter

> {sigh}
>
> Step back and think about _why_ the kernel is telling you this is not
> ok, and ponder the process that came to you that resulted in, "I know,
> let me trick the kernel, I know better than it!".  I didn't just put
> that warning there for no good reason, I was trying to save yourself
> from a major bug.  And here you go working around it, and making that
> bug almost impossible to now find.
>
> The kernel told you this, look:
>
> > > [   47.223901] Device 'cros_ec' does not have a release() function, it is broken and must be fixed.
>
> How much more blatent and obvious can I make it in a single sentance
> without it being rude?
>
> Anyway, no, this is not what to do.  You have to actually realease the
> memory you created for your device in this function.  If you do not do
> that, you have a major bug.  Please fix this properly and next time, do
> not ignore what the kernel is trying to tell you.
>
> thanks,
>
> greg k-h
