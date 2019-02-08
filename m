Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05808C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B369B217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WejovDZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfBHVTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:19:07 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40260 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfBHVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:19:06 -0500
Received: by mail-ua1-f66.google.com with SMTP id n32so142491uae.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtiqhStuz9aJZ8zxpb/5ZWOLqsQdHlkGKQvbIgjIemE=;
        b=WejovDZpEOGlVMtpwdQ289/d97jXUoRyG9xgg2sFjIdAcWW+CMcBwC4l/Y7SVw0p3U
         bbviPDSg+MhPd8AX+MWZDVjxhmnbxqV1uczfERy1zlzPMoxYLDR48h3Rb4WEkzmctRRZ
         +acxjPg+ujWDz2Vw1dnJpLdlbWGMnZWzoIarjp7iFNsiA/SLqjdrgKAKnrydnlmgIxf1
         M1us3ag+APfxjJ1q94yBCIOYLPZbFRyv+wrHyqE8e8Uo8W66usF+h0xbgpZJ8avtRo1q
         d0xbc+I0eNXrxJzN8SR5CfrWnV+bHIWPoItEXvfwfqnwH/0ODIoKQF2FpLacecWVqM5p
         zZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtiqhStuz9aJZ8zxpb/5ZWOLqsQdHlkGKQvbIgjIemE=;
        b=WXIuHYi8A7fW1quo3n/sRIFQY2VZjHskc8ROQcmdPRnXMTQKd0mVhirHm6Bdm3i7uZ
         /o4nCxbgjcjHXr8vkwWYqwyZCHlpd0ClT/1Jzpi+17jdLfFrgdLPQ/vA3okG3IdxpV38
         FhNDd5y77oITg5B3RJ4YhDX+Bp17R0Rd4hw/I9tQ2nmTskAGWltUMj90ucWfVDQTBIL3
         Fy3n/kptmslPAhFuCgQTN6sek3DPUIPxIKNFTGf6mP0DAyrksRykf88C7n6je29oakY6
         hsCPttt6kt89yJgavOmdTP0yyno4FKtQ8EMv2CwFwfzSjZEbuVJxFQghBIseCPkTkW8x
         jLgg==
X-Gm-Message-State: AHQUAubXbTQD8qGmIUbDls73LlqJKsixxVLTxZdq+R3+cgr+T6ltBTRE
        HoMekUmEzVxkOOHswVzX2ULXgvA07IIe+oUVfjE=
X-Google-Smtp-Source: AHgI3IYDccJpkMYy9YPFipbCSVUYaI/V2u0LegBj+qQ+j2foNob3HIK+uFysMivVgI/a31fRCMkCp+KTzoTVW4WL/XU=
X-Received: by 2002:ab0:22d6:: with SMTP id z22mr6776549uam.66.1549660744833;
 Fri, 08 Feb 2019 13:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20190204203254.4026-1-oded.gabbay@gmail.com> <20190204203254.4026-10-oded.gabbay@gmail.com>
 <20190208121402.GB23483@kroah.com>
In-Reply-To: <20190208121402.GB23483@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 8 Feb 2019 23:18:39 +0200
Message-ID: <CAFCwf11M1-zD89=QqPnvSqELwCSRvHSfALdUc6YX3Ar3oUz6Dw@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] habanalabs: add sysfs and hwmon support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mike Rapoport <rppt@linux.ibm.com>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 2:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 04, 2019 at 10:32:48PM +0200, Oded Gabbay wrote:
> > This patch add the sysfs and hwmon entries that are exposed by the driver.
> >
> > Goya has several sensors, from various categories such as temperature,
> > voltage, current, etc. The driver exposes those sensors in the standard
> > hwmon mechanism.
> >
> > In addition, the driver exposes a couple of interfaces in sysfs, both for
> > configuration and for providing status of the device or driver.
> >
> > The configuration attributes is for Power Management:
> > - Automatic or manual
> > - Frequency value when moving to high frequency mode
> > - Maximum power the device is allowed to consume
> >
> > The rest of the attributes are read-only and provide the following
> > information:
> > - Versions of the various firmwares running on the device
> > - Contents of the device's EEPROM
> > - The device type (currently only Goya is supported)
> > - PCI address of the device (to allow user-space to connect between
> >   /dev/hlX to PCI address)
> > - Status of the device (operational, malfunction, in_reset)
> > - How many processes are open on the device's file
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  .../ABI/testing/sysfs-driver-habanalabs       | 190 ++++++
> >  drivers/misc/habanalabs/Makefile              |   2 +-
> >  drivers/misc/habanalabs/device.c              | 146 +++++
> >  drivers/misc/habanalabs/goya/Makefile         |   2 +-
> >  drivers/misc/habanalabs/goya/goya.c           | 230 +++++++
> >  drivers/misc/habanalabs/goya/goyaP.h          |  21 +
> >  drivers/misc/habanalabs/goya/goya_hwmgr.c     | 306 +++++++++
> >  drivers/misc/habanalabs/habanalabs.h          | 101 +++
> >  drivers/misc/habanalabs/habanalabs_drv.c      |   7 +
> >  drivers/misc/habanalabs/hwmon.c               | 449 +++++++++++++
> >  drivers/misc/habanalabs/sysfs.c               | 589 ++++++++++++++++++
> >  11 files changed, 2041 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-habanalabs
> >  create mode 100644 drivers/misc/habanalabs/goya/goya_hwmgr.c
> >  create mode 100644 drivers/misc/habanalabs/hwmon.c
> >  create mode 100644 drivers/misc/habanalabs/sysfs.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
> > new file mode 100644
> > index 000000000000..19edd4da87c1
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
> > @@ -0,0 +1,190 @@
> > +What:           /sys/class/habanalabs/hl<n>/armcp_kernel_ver
> > +Date:           Jan 2019
> > +KernelVersion:  5.1
> > +Contact:        oded.gabbay@gmail.com
> > +Description:    Version of the Linux kernel running on the device's CPU
>
> Hey, nice!  We can see how old that kernel gets over time :)
>
> > +What:           /sys/class/habanalabs/hl<n>/soft_reset_cnt
> > +Date:           Jan 2019
> > +KernelVersion:  5.1
> > +Contact:        oded.gabbay@gmail.com
> > +Description:    Displays how many times the device have undergone a soft-reset
> > +                operation
>
> "how many times" since when?  Power on?  Kernel boot?  Driver load?
Thanks, fixed that (Driver load).
>
> > +static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
> > +                             char *buf)
> > +{
> > +     struct hl_device *hdev = dev_get_drvdata(dev);
> > +     long value;
> > +
> > +     if (hdev->disabled)
> > +             return -ENODEV;
> > +
> > +     value = hl_get_frequency(hdev, MME_PLL, false);
> > +
> > +     if (value < 0)
> > +             return value;
> > +
> > +     return snprintf(buf, PAGE_SIZE, "%lu\n", value);
>
> Meta-comment.  You do this in all of your sysfs show functions, and I
> understand the "I want to be safe!" feeling here, but you should just
> use sprintf().  The size of a sysfs buffer is PAGE_SIZE, and you should
> never even get close to it if you are only writing a single numeric
> value.
>
> So no need to do anything fancy, just use sprintf() please.
Got it, fixed.
>
> > +static DEVICE_ATTR_RW(mme_clk);
> > +static DEVICE_ATTR_RW(tpc_clk);
> > +static DEVICE_ATTR_RW(ic_clk);
> > +static DEVICE_ATTR_RO(mme_clk_curr);
> > +static DEVICE_ATTR_RO(tpc_clk_curr);
> > +static DEVICE_ATTR_RO(ic_clk_curr);
>
> Some people like to put the macro right under the show/store functions,
> to keep them all in one place.  Makes it easier to change/add things
> later over time.
I really prefer it this way, you get a clear picture of all the ATTR
you expose without the need to go over the entire file.
If you don't mind I want to leave this as it is.

>
> > +int goya_add_device_attr(struct hl_device *hdev)
> > +{
> > +     int rc;
> > +
> > +     rc = device_create_file(hdev->dev, &dev_attr_mme_clk);
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to create device file mme_clk\n");
> > +             return rc;
> > +     }
> > +
> > +     rc = device_create_file(hdev->dev, &dev_attr_tpc_clk);
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to create device file tpc_clk\n");
> > +             goto remove_mme_clk;
> > +     }
> > +
> > +     rc = device_create_file(hdev->dev, &dev_attr_ic_clk);
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to create device file ic_clk\n");
> > +             goto remove_tpc_clk;
> > +     }
> > +
> > +     rc = device_create_file(hdev->dev, &dev_attr_mme_clk_curr);
> > +     if (rc) {
> > +             dev_err(hdev->dev,
> > +                     "failed to create device file mme_clk_curr\n");
> > +             goto remove_ic_clk;
> > +     }
> > +
> > +     rc = device_create_file(hdev->dev, &dev_attr_tpc_clk_curr);
> > +     if (rc) {
> > +             dev_err(hdev->dev,
> > +                     "failed to create device file tpc_clk_curr\n");
> > +             goto remove_mme_clk_curr;
> > +     }
> > +
> > +     rc = device_create_file(hdev->dev, &dev_attr_ic_clk_curr);
> > +     if (rc) {
> > +             dev_err(hdev->dev,
> > +                     "failed to create device file ic_clk_curr\n");
> > +             goto remove_tpc_clk_curr;
> > +     }
>
>
> You do know about attribute groups, right?  Please use them so you don't
> have to hand-roll the "add a bunch of files" logic here and elsewhere.
> The driver core will just automatically add and remove all of the files
> when the device is bound properly without you having to do anything.
> That saves you a lot of code and debugging logic.
>
> Same for your other lists of attributes, they can all be handled
> automatically, no need for this type of logic.
ah... hmm... oops, didn't know about them. feelsbadman :(
I don't think they are used in drm (or at least not in amd) which is
where most of my kernel knowledge comes from.
Indeed, much more elegant. Fixed the code.

>
> thanks,
>
> greg k-h
