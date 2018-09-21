Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1318FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBE62150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD/2lxL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBE62150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389935AbeIUSgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:36:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42529 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbeIUSgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:36:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id w73-v6so2318360qkb.9;
        Fri, 21 Sep 2018 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xhR8c49X1oItXOMFB/yvowhp2isimQUTwFmgWM51eQ=;
        b=mD/2lxL84SwBiySzcuyc8MpwT4Fa2Ke09PsLN5efOw9gHDHYzKOL2RmgdS1oGCgXhF
         Sy7Wp99NDAmm+4FeqyYJv+8MvC6h9RPPp961zFG80+xawjN3mxNK31zpZ/zUyBs4WIi2
         PwFCV8v0wzMXmgUxYz/+mEUSrHRHH68OeaOTazi1LilvZ4SphBs3hd2Oii7DfLMS/gGA
         OZRiFzLof1/VuGzy93s/J7cb5mdxGEAPaaE6qV2N9roAVVT2T3oLMnwJqqtCXeezhm2B
         O3p1SlovflLdf8UWQfFsJYOwdxheoZqMWdPdDtU6H1XNZa5Xnmyopbtgr+46I7Wrm0eY
         zLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xhR8c49X1oItXOMFB/yvowhp2isimQUTwFmgWM51eQ=;
        b=oxVF7OcDtl87YOPAu2JWTxH0gVBjFv4JZvrsSqqKj+FMjm6fZlwlPC5sX6rxTqy3Rj
         Fe2X4A/LeYOdeGq9pbfML4BhaeBHWyGRIrB/Lsvcha3It7zxn+RIwCWoa4EgUBX28W4n
         r9TD8zZBvgwzKacsW9YaSI2ecH2uCLEZ8DmQLCjrLBNoYF+4qUdtvp6Y/97Ay2pqVnt+
         3bqlb+lyFAfLJj/rmlgt/eRpLYigDvkhhnExjhejHuPpZ6a1TBe7HqDCt+8szrtWlt6X
         9+9YMg2uIxMudsiCZ0eVxUtHhDr7L6fB5pCQ7bJt4fhpg3bgtcHB6sT2uipV4EhwrEDY
         XXdg==
X-Gm-Message-State: APzg51CGyTXYyWyqPbE4XqMDqUqUJz6ISrG/bHPxDQuwfMFkHcCFCCu2
        9U4I95KZqGG2Dc63SWw7+AY4wKaQ2KkLrinq5Q8=
X-Google-Smtp-Source: ANB0VdZ6BRdhhNszEPa093tRMgY4LvGbi09ZMx1w7kESmVfGlliA73jLhmxp7XSbi6+PkGAizMToPTavWfqkaseNaQQ=
X-Received: by 2002:a37:270f:: with SMTP id n15-v6mr10995967qkn.33.1537534085159;
 Fri, 21 Sep 2018 05:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180920223436.202454-1-mka@chromium.org> <20180920223436.202454-2-mka@chromium.org>
 <20180921071312.gg7xshwa2ro3hiix@kekkonen.localdomain>
In-Reply-To: <20180921071312.gg7xshwa2ro3hiix@kekkonen.localdomain>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Sep 2018 15:47:54 +0300
Message-ID: <CAHp75Vc-evA6MCxGN+Ho+XQkBqtQ_JpMEpPUmMGxMxUSmL1LMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] device property: Add device_get_bd_address() and fwnode_get_bd_address()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, mw@semihalf.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, bgodavar@codeaurora.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:16 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Matthias,
>
> On Thu, Sep 20, 2018 at 03:34:35PM -0700, Matthias Kaehlcke wrote:
> > Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
> > address (BD_ADDR) for a device. If the device node has a property
> > 'local-bd-address' the BD address is read from this property.
> >

I have nothing to object for the idea and agree fully on Sakari's comments.

After addressing them, fill free to add my

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/base/property.c  | 49 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/property.h |  4 ++++
> >  2 files changed, 53 insertions(+)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 240ab5230ff6..8fe546b9805a 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -18,6 +18,8 @@
> >  #include <linux/etherdevice.h>
> >  #include <linux/phy.h>
> >
> > +#define BD_ADDR_LEN  6
> > +
> >  struct property_set {
> >       struct device *dev;
> >       struct fwnode_handle fwnode;
> > @@ -1315,6 +1317,53 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
> >  }
> >  EXPORT_SYMBOL(device_get_mac_address);
> >
> > +/**
> > + * fwnode_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) from the
> > + *                         firmware node
> > + * @fwnode:  Pointer to the firmware node
> > + * @addr:    Address of buffer to store the BD address in
> > + * @alen:    Length of the buffer pointed to by addr, should be BD_ADDR_LEN
> > + *
> > + * Search the firmware node for 'local-bd-address'.
> > + *
> > + * All-zero BD addresses are rejected, because those could be properties
> > + * that exist in the firmware tables, but were not updated by the firmware. For
> > + * example, the DTS could define 'local-bd-address', with zero BD addresses.
> > + */
> > +int fwnode_get_bd_address(struct fwnode_handle *fwnode, u8 *addr, int alen)
>
> How about using bdaddr_t instead? The original caller was casting it to u8
> probably just because there was no function specifically for this purpose.
>
> I wonder if this also should be made depend on CONFIG_BT. The fwnode
> framework is unconditionally a part of the kernel and it's not very big at
> the moment but adding stuff little by little will add up eventually.
>
> > +{
> > +     u8 buf[BD_ADDR_LEN];
> > +     int ret;
> > +
> > +     if (alen != BD_ADDR_LEN)
> > +             return -EINVAL;
> > +
> > +     ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> > +                                         buf, alen);
> > +     if (ret < 0)
> > +             return ret;
> > +     if (is_zero_ether_addr(buf))
> > +             return -ENODATA;
> > +
> > +     memcpy(addr, buf, BD_ADDR_LEN);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(fwnode_get_bd_address);
> > +
> > +/**
> > + * device_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) for a
> > + *                         given device
> > + * @dev:     Pointer to the device
> > + * @addr:    Address of buffer to store the BD address in
> > + * @alen:    Length of the buffer pointed to by addr, should be BD_ADDR_LEN
> > + */
> > +int device_get_bd_address(struct device *dev, u8 *addr, int alen)
> > +{
> > +     return fwnode_get_bd_address(dev_fwnode(dev), addr, alen);
> > +}
> > +EXPORT_SYMBOL(device_get_bd_address);
> > +
> >  /**
> >   * fwnode_irq_get - Get IRQ directly from a fwnode
> >   * @fwnode:  Pointer to the firmware node
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index ac8a1ebc4c1b..4e2f1b276f4f 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -287,9 +287,13 @@ int device_get_phy_mode(struct device *dev);
> >
> >  void *device_get_mac_address(struct device *dev, char *addr, int alen);
> >
> > +int device_get_bd_address(struct device *dev, u8 *addr, int alen);
> > +
> >  int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
> >  void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
> >                            char *addr, int alen);
> > +int fwnode_get_bd_address(struct fwnode_handle *fwnode,
> > +                       u8 *addr, int alen);
>
> This would be a good opportunity to add a newline here, and avoid adding
> one after device_get_mac_address().
>
> >  struct fwnode_handle *fwnode_graph_get_next_endpoint(
> >       const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
> >  struct fwnode_handle *
>
> --
> Regards,
>
> Sakari Ailus
> sakari.ailus@linux.intel.com



-- 
With Best Regards,
Andy Shevchenko
