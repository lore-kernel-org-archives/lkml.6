Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E25C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EED20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vX4HvifT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfAHOee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:34:34 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40578 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfAHOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:34:32 -0500
Received: by mail-yw1-f68.google.com with SMTP id g194so1598527ywe.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 06:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUsGNSltqysvk6dVmJGAHD+qRCQCL+1LMRu0GmFD3PQ=;
        b=vX4HvifTvuUfF7HfEwFbpCNWzIQtcZ8DpOFbsK3yDf1NVPYZIJws8tuEMMypm6IYjN
         2b+nPqC3kr7EmTUo42ZJOQ3NP6fkpCmGw7g0LR+Rh3256x+66gciEjXxvMterhfIL2Kg
         kUnqmlw48Hi4RsMflaMh2MyS+PBN3TRqegFMP9bgJCIyxIV1sBcAB3AbXUJxJRTo/grJ
         B4ia2gY7+XTndXsoIthlX6hNAfFsLBPhPA/B4hK2M30AvP2iGm9Q3Rb27Mvn8/90BTtx
         T3fKaDAvQfqeuqK1NCwsGlG074UG6Twai2qhumsXtjZnNZVX6usnRFttB/j0KBOUlcQ4
         vmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUsGNSltqysvk6dVmJGAHD+qRCQCL+1LMRu0GmFD3PQ=;
        b=VtC4l5yz6hed3g6tVv8IxmE1haR5DsK6K/1jikSx6vH6MnSlZtMZD5HtdzQrD58ey/
         JFyDzuSnR+b2NpHTCybigdQmBjy7EmIXO+pQG08Gw0oT0+cCCJD+0sp9kDviisLkboCW
         ohWgr8uxk75IvNMTCRUabdRjGjmWeLJ7bdlE1Z0PO3Xo1whzwG1fTKJ9jed+QDK4ChQv
         mOh7a67DiR000TiNHANJRXOet+ZxcuRBQYBqi2V016i9HtwD8nNf/GxAC303oNIDe8ft
         HAKQuv8U3rMm0IvRqMI4WbtoR/KzazEc8C65PR0vLDzkrTeWX2fheOfke4CWMCxhxOhz
         tvrw==
X-Gm-Message-State: AJcUukfMDopQbf3nPQMXAGMU/ZDwkVzfMeAhve+mWAMgnmEOchh0MJO8
        Z7KfxeMyJpX7EQmwDQfSvRzayYrvjg0s4kibWem7Og==
X-Google-Smtp-Source: ALg8bN6pXVqyVndyFAYVfHVC5JYjD1tJ2tt63dq2uvKP7Wf5RelvpJT7pqTTsljkFXfAtHwmV44BlCEDpDsSSAlRu80=
X-Received: by 2002:a81:a395:: with SMTP id a143mr1733752ywh.444.1546958071221;
 Tue, 08 Jan 2019 06:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20190108035638.9685-1-moritz.fischer@ettus.com> <27c7db25-51c0-c283-c4bb-4a65df9b2105@collabora.com>
In-Reply-To: <27c7db25-51c0-c283-c4bb-4a65df9b2105@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 8 Jan 2019 06:34:19 -0800
Message-ID: <CABXOdTdsuWdVWAev6KHqVZRsRyNsfdSmL4HYQWsuCZSA1v37ow@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: Add cros_ec_readmem() helpers for
 I2C/SPI based ECs
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Moritz Fischer <moritz.fischer@ettus.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, moritz@ettus.com,
        Moritz Fischer <mdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 6:28 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Moritz,
>
> Many thanks for the patch,I've one concern on this, and I'd be also interested
> on Benson and Guenter opinion ...
>
> On 8/1/19 4:56, Moritz Fischer wrote:
> > From: Moritz Fischer <mdf@kernel.org>
> >
> > Add cros_ec_readmem() based helpers for I2C/SPI based ECs.
> > Unlike the LPC based ECs the I2C/SPI based ones cannot just directly
> > read the mapped region.
> >
> > This is useful for things like accessing fan speeds or temperatures.
> >
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >
> > Hi all,
> >
> >
> > I had submitted this back in May 2017 [1] and then somewhat forgot
> > about it. So here's a new version :)
> >
> > As to why is this required? we're using this in some of our devices
> > [2] that run a modified firmware based on Chromium-EC.
> > I've been carrying the patch downstream in our tree for a while and
> > it would be nice if we can merge this upstream so I can stop rebasing
> > this :)
> >
>
> Right, if we merge this you'll probably reduce your downstream patches but
> actually, if I am not wrong, there is no user for this. There isn't an upstream
> driver that uses the new functions so we will end up having upstream dead code.
> IMO if you want to have this upstream you should also upstream the drivers that
> use that code. Makes sense?
>

He has a hwmon driver which I think uses it. Question would rather be
if that is an acceptable use or if it exposes EC internals, ie non-API
data. Comments, anyone ?

Digging ... https://patchwork.kernel.org/patch/9670517/

Guenter

> Thanks,
>   Enric
>
>
> > Thanks,
> >
> > Moritz
> >
> > [1] https://lore.kernel.org/patchwork/patch/786065/
> > [2] https://www.ettus.com/product/details/USRP-E320
> >
> > ---
> >  drivers/platform/chrome/cros_ec_i2c.c   |  1 +
> >  drivers/platform/chrome/cros_ec_proto.c | 38 +++++++++++++++++++++++++
> >  drivers/platform/chrome/cros_ec_spi.c   |  1 +
> >  include/linux/mfd/cros_ec.h             | 12 ++++++++
> >  4 files changed, 52 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
> > index ef9b4763356f..c3a9bee37b1d 100644
> > --- a/drivers/platform/chrome/cros_ec_i2c.c
> > +++ b/drivers/platform/chrome/cros_ec_i2c.c
> > @@ -303,6 +303,7 @@ static int cros_ec_i2c_probe(struct i2c_client *client,
> >       ec_dev->irq = client->irq;
> >       ec_dev->cmd_xfer = cros_ec_cmd_xfer_i2c;
> >       ec_dev->pkt_xfer = cros_ec_pkt_xfer_i2c;
> > +     ec_dev->cmd_readmem = cros_ec_readmem;
> >       ec_dev->phys_name = client->adapter->name;
> >       ec_dev->din_size = sizeof(struct ec_host_response_i2c) +
> >                          sizeof(struct ec_response_get_protocol_info);
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index cc7baf0ecb3c..2f1d45a7a934 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -636,3 +636,41 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
> >       return host_event;
> >  }
> >  EXPORT_SYMBOL(cros_ec_get_host_event);
> > +
> > +int cros_ec_readmem(struct cros_ec_device *ec, unsigned int offset,
> > +                 unsigned int bytes, void *dest)
> > +{
> > +     int ret;
> > +     struct ec_params_read_memmap *params;
> > +     struct cros_ec_command *msg;
> > +
> > +     if (offset >= EC_MEMMAP_SIZE - bytes)
> > +             return -EINVAL;
> > +
> > +     msg = kzalloc(sizeof(*msg) + max(sizeof(*params), bytes), GFP_KERNEL);
> > +     if (!msg)
> > +             return -ENOMEM;
> > +
> > +     msg->version = 0;
> > +     msg->command = EC_CMD_READ_MEMMAP;
> > +     msg->insize = bytes;
> > +     msg->outsize = sizeof(*params);
> > +
> > +     params = (struct ec_params_read_memmap *)msg->data;
> > +     params->offset = offset;
> > +     params->size = bytes;
> > +
> > +     ret = cros_ec_cmd_xfer_status(ec, msg);
> > +     if (ret < 0) {
> > +             dev_warn(ec->dev, "cannot read mapped reg: %d/%d\n",
> > +                      ret, msg->result);
> > +             goto out_free;
> > +     }
> > +
> > +     memcpy(dest, msg->data, bytes);
> > +
> > +out_free:
> > +     kfree(msg);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(cros_ec_readmem);
> > diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> > index 2060d1483043..b95c1a25adfc 100644
> > --- a/drivers/platform/chrome/cros_ec_spi.c
> > +++ b/drivers/platform/chrome/cros_ec_spi.c
> > @@ -666,6 +666,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
> >       ec_dev->irq = spi->irq;
> >       ec_dev->cmd_xfer = cros_ec_cmd_xfer_spi;
> >       ec_dev->pkt_xfer = cros_ec_pkt_xfer_spi;
> > +     ec_dev->cmd_readmem = cros_ec_readmem;
> >       ec_dev->phys_name = dev_name(&ec_spi->spi->dev);
> >       ec_dev->din_size = EC_MSG_PREAMBLE_COUNT +
> >                          sizeof(struct ec_host_response) +
> > diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> > index de8b588c8776..0228fb42dcda 100644
> > --- a/include/linux/mfd/cros_ec.h
> > +++ b/include/linux/mfd/cros_ec.h
> > @@ -335,6 +335,18 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
> >   */
> >  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
> >
> > +/**
> > + * cros_ec_readmem - Read mapped memory in the ChromeOS EC
> > + *
> > + * @ec: Device to read from
> > + * @offset: Offset to read within the mapped region
> > + * @bytes: number of bytes to read
> > + * @data: Return data
> > + * @return: 0 if Ok, -ve on error
> > + */
> > +int cros_ec_readmem(struct cros_ec_device *ec, unsigned int offset,
> > +                 unsigned int bytes, void *dest);
> > +
> >  /* sysfs stuff */
> >  extern struct attribute_group cros_ec_attr_group;
> >  extern struct attribute_group cros_ec_lightbar_attr_group;
> >
