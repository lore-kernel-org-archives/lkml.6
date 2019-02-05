Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8F2C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12162083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQQyFl2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfBET5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:57:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34031 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfBET5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:57:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id z15so3011801wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 11:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOb9Ght86EhXtNaw/vKFbLJV20IEPfHR6zkY9Ic1KiA=;
        b=lQQyFl2Nj3pL8QzsK1QSTJRkGg2pH4DMu5zqadmqW3xCb+b9qFFTkgb/ncSahfJqr9
         1fdoDgK9LvRjR1/1IKjF+XBfjdrVAfsoWnVFWmITbBjMD2uK+LxMbKuCDAH8kqVUMmJq
         Kzdn0ou4++cSYKOn5JsD2ujY+z2jiAEnM1GYvfsmChT/LEhXzoGTZs3IKqbl4P8YZVPN
         W8kTuNeD7oVx/56pQiRK7NSQPi0vq5tUqWoVP7U5VyvCkYm3MAmqRQFWcUf6YKIaP6qI
         FZ9/E9UJDbmriQyGWXa7q4qldFdpkQA06SxGUFg7dMWkgXzhd76Pb/Q4af3nLFtrKMXQ
         c4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOb9Ght86EhXtNaw/vKFbLJV20IEPfHR6zkY9Ic1KiA=;
        b=Xy2pUT9QYCiHChjeGMR6mcQdIyY4ft9VWm4R3Ifqqc97N7YX4aker5g3FZ64nqoPxh
         IAFJdts34GSM5PZXzMTGJoq0hZnw448jXRLhaitRzVx7VD9qqY+0dliysTx6PnyaIM/c
         o+QtSLuMeHNnmuwLrmYB4P75WFcxcQbA901sQt7pKoFO4f7qSGSjRidthCASDqFNra6r
         zycuDcclUhfSFbDzIhcGLTR+giaBWG+jLafZFv7rhcSmPzPOzglP7MJM87WNj2v5NXZE
         54yRJlAuPexudySIRLB6+8JVSSRlylVda57uuuoYUp7mDPW6MMIhkByKeXGE0YuGAjwV
         FNSg==
X-Gm-Message-State: AHQUAuZnDvZFVenPj5nM+RzbA0A0LdK7SMjwH7VlqSjCjlQkyOXFRX8/
        vT8w3EGYoQlTfTo5bye050O9zYZUlt9CmrLzAFUd
X-Google-Smtp-Source: AHgI3IYYhsxK99B8tX4ui5byPptLgNEmAjtktsTN/9GPyq9arvg6dAEDGgxSEJhsE6KVf5itq60fEZJ4cWnzVVRPff8=
X-Received: by 2002:adf:9246:: with SMTP id 64mr5273602wrj.130.1549396668972;
 Tue, 05 Feb 2019 11:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20181226232258.GA23526@syn-yoga530> <20190205120545.GA1045@kunai>
In-Reply-To: <20190205120545.GA1045@kunai>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 5 Feb 2019 13:57:36 -0600
Message-ID: <CAErSpo5kvFVwo-DCLYT_7UmRQKS1jHahFXawvnZUtZ=ApHKz1Q@mail.gmail.com>
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Elie Morisse <syniurge@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com,
        sandeep.singh@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 6:06 AM Wolfram Sang <wsa@the-dreams.de> wrote:

> > +03:00.7 Non-VGA unclassified device: Advanced Micro Devices, Inc. [AMD] Device
> > +                                                                     15e6
> > +
> > +in your 'lspci -v', then this driver is for your device.
>
> Sidenote: Can't we add something to the pci-ids to make it possible to
> identify it correctly/make it more readable to the user?

Yes, please add the correct info at https://pci-ids.ucw.cz/

> Please remove this debugfs interface. There must be generic ways to read out
> PCI memory?

There are sysfs files that provide access to the raw contents of MMIO
BARs, e.g.,

  /sys/devices/pci0000:00/0000:00:1f.3/resource0

> > +static int amd_mp2_pci_probe(struct pci_dev *pci_dev,
> > +                          const struct pci_device_id *id)
> > +{
> > +     struct amd_mp2_dev *privdata;
> > +     int rc;
> > +     static bool first_probe = true;
> > +
> > +     if (first_probe) {
> > +             pr_info("%s: %s Version: %s\n", DRIVER_NAME,
> > +                     DRIVER_DESC, DRIVER_VER);
> > +             first_probe = false;
> > +     }
> > +
> > +     dev_info(&pci_dev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
> > +              pci_dev->vendor, pci_dev->device, pci_dev->revision);
> > +
>
> The kernel prints already too much during boot. So, please remove this.
> It will also get rid of the static variable which is not so good style.

The PCI core already prints the vendor/device ID of everything it
finds.  I don't think it prints the revision.

I doubt the driver name/version is really useful.  Nobody ever updates
the versions anyway, and I think customers will key off the distro
kernel version, which should uniquely identify the driver version.

> > +struct amd_mp2_dev *amd_mp2_find_device(void)
> > +{
> > +     struct device *dev;
> > +     struct pci_dev *pci_dev;
> > +
> > +     dev = driver_find_device(&amd_mp2_pci_driver.driver, NULL, NULL,
> > +                              amd_mp2_device_match);
> > +     if (!dev)
> > +             return NULL;
> > +
> > +     pci_dev = to_pci_dev(dev);
> > +     if (!amd_mp2_pci_is_probed(pci_dev))
> > +             return NULL;
> > +     return (struct amd_mp2_dev *)pci_get_drvdata(pci_dev);
> > +}
> > +EXPORT_SYMBOL_GPL(amd_mp2_find_device);
>
> Can't you just share a common flag when the PCI driver is successfully
> probed and let the platform driver defer until this flag is set?
>
> Reading this, I also don't think there should be two seperate Kconfig
> and Makefile entries. You need both to have working I2C, so one Kconfig
> entry should compile both files.

IMHO the split into two drivers is a bit of a mess and doesn't really
correspond with the hardware, as I mentioned at [1].  The PCI device
is the real hardware and the driver should claim that.  AFAICT the
ACPI device exists only to pass some config information to the PCI
driver.  I think the natural approach would be for the PCI driver to
directly search the ACPI namespace for that config information.

The fact that driver_find_device() is essentially unused except for a
few very special cases is a good clue that there's probably a better
way.

Bjorn

[1] https://lkml.kernel.org/r/20181030205624.GC13681@bhelgaas-glaptop.roam.corp.google.com
