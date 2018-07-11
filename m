Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D996C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD9D20E20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7Yz79Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD9D20E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbeGKOGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:06:31 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46889 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388431AbeGKOGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:06:31 -0400
Received: by mail-lf0-f68.google.com with SMTP id l16-v6so21368322lfc.13;
        Wed, 11 Jul 2018 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TOxEB4cDN3GxqNIpJg6/cmwPDagXh1d6Hlmnl1Jqcpk=;
        b=n7Yz79MtPjA5oJAqCDewhLhr/Jjgnxc8fo4PozofJNqKbQ7MV4uWCFD43y/0B5SlWx
         02CIoGQ0/Y2ITY4d3FO1xBD3mQB9PuNcW0+D2+8TxtVICF2Mfe+y+PmwTEx+9ib03uG/
         WStC2P0nxvHZE1LJ9DEM6dkG2EZ6BiVYxx198RF+qsNsasmOjQFsJEJAk0cNxh2GMkIt
         NB+B3m8QMhO3m25Cp875tEtMua5AgXUA5Z7tdVVsp1Nntf3JmVaYZJSi0sWyEjEEkjW+
         yemT2oIdXrlXWvpmd0ehsYeHyvgoFPTBePdJIyuzR8jg3qpLa28TqWmBcMZkI1lW93xt
         SCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TOxEB4cDN3GxqNIpJg6/cmwPDagXh1d6Hlmnl1Jqcpk=;
        b=ak8rkGOKgm9e/jgpN186yAoLLgUKix+lmlczZPz/IZHM/kaDFSy87VnP+aA5Uj4ema
         9KVTHiGdSt+Gqm2O2Ue5JW//+ikbtSw945jUW8q2Ko1oJM5SnuhBCqGKO8B70m1AhFPy
         0fGktqcZ7S73Yjlhox4s2UMI56wsAYN4jPd8mluTvvoN+WdUA1v5XJ5OP8aye5RDuEHp
         wbb6Ch3jNEkZPp7CTkIFtobAcAkcsQpNZXy0wcN4mTMQsZBDDfKTZ1eelqzA0GGlCzEb
         Qah4B5vWMg62GesgRb/ptTp1WQ7IIBalbtKm0tFxlUc0LmiQTnkiN5qaGIj1UuDZftcM
         DJsw==
X-Gm-Message-State: APt69E1i0n1agoaPyOiXtjbjS6sU38Y1V/3PB7FQPQTjMio8aSAjfno5
        yP0XwhO3TCIq8DbkylKxzop0nmzq1U3kx20Lcj8=
X-Google-Smtp-Source: AAOMgpe+1srFgHzNxCiIloMByPqMh8o0e2BIv0heBp7KgmLXjbeAOtSKyqFd4ev9XqOdBpvGc+s1LMcoo91zo5YXR2A=
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr5867716lfk.132.1531317717513;
 Wed, 11 Jul 2018 07:01:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 07:01:56
 -0700 (PDT)
In-Reply-To: <20180330074751.25987-2-boris.brezillon@bootlin.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com> <20180330074751.25987-2-boris.brezillon@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jul 2018 16:01:56 +0200
X-Google-Sender-Auth: KVUoNK6ELkZWowgSy_QjexmRYgo
Message-ID: <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 9:47 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Add core infrastructure to support I3C in Linux and document it.
>
> This infrastructure is not complete yet and will be extended over
> time.
>
> There are a few design choices that are worth mentioning because they
> impact the way I3C device drivers can interact with their devices:
>
> - all functions used to send I3C/I2C frames must be called in
>   non-atomic context. Mainly done this way to ease implementation, but
>   this is still open to discussion. Please let me know if you think
>   it's worth considering an asynchronous model here

This sounds like it can be changed later if it turns out necessary, so
that's fine to me.

> - the bus element is a separate object and is not implicitly described
>   by the master (as done in I2C). The reason is that I want to be able
>   to handle multiple master connected to the same bus and visible to
>   Linux.
>   In this situation, we should only have one instance of the device and
>   not one per master, and sharing the bus object would be part of the
>   solution to gracefully handle this case.
>   I'm not sure we will ever need to deal with multiple masters
>   controlling the same bus and exposed under Linux, but separating the
>   bus and master concept is pretty easy, hence the decision to do it
>   like that.
>   The other benefit of separating the bus and master concepts is that
>   master devices appear under the bus directory in sysfs.

I'm not following here at all, sorry for missing prior discussion if this
was already explained. What is the "multiple master" case? Do you
mean multiple devices that are controlled by Linux and that each talk
to other devices on the same bus, multiple operating systems that
have talk to are able to own the bus with the kernel being one of
them, a controller that controls multiple independent buses,
or something else?

> - I2C backward compatibility has been designed to be transparent to I2C
>   drivers and the I2C subsystem. The I3C master just registers an I2C
>   adapter which creates a new I2C bus. I'd say that, from a
>   representation PoV it's not ideal because what should appear as a
>   single I3C bus exposing I3C and I2C devices here appears as 2
>   different busses connected to each other through the parenting (the
>   I3C master is the parent of the I2C and I3C busses).
>   On the other hand, I don't see a better solution if we want something
>   that is not invasive.

Right, this seems like a reasonable compromise.

> Missing features in this preliminary version:
> - I3C HDR modes are not supported
> - no support for multi-master and the associated concepts (mastership
>   handover, support for secondary masters, ...)
> - I2C devices can only be described using DT because this is the only
>   use case I have. However, the framework can easily be extended with
>   ACPI and board info support
> - I3C slave framework. This has been completely omitted, but shouldn't
>   have a huge impact on the I3C framework because I3C slaves don't see
>   the whole bus, it's only about handling master requests and generating
>   IBIs. Some of the struct, constant and enum definitions could be
>   shared, but most of the I3C slave framework logic will be different

All of these seem ok to me for an initial version. It's already too
big to review properly, so leaving out stuff helps.

> +/**
> + * i3cdev_to_dev() - Returns the device embedded in @i3cdev
> + * @i3cdev: I3C device
> + *
> + * Return: a pointer to a device object.
> + */
> +struct device *i3cdev_to_dev(struct i3c_device *i3cdev)
> +{
> +       return &i3cdev->dev;
> +}
> +EXPORT_SYMBOL_GPL(i3cdev_to_dev);
> +
> +/**
> + * dev_to_i3cdev() - Returns the I3C device containing @dev
> + * @dev: device object
> + *
> + * Return: a pointer to an I3C device object.
> + */
> +struct i3c_device *dev_to_i3cdev(struct device *dev)
> +{
> +       return container_of(dev, struct i3c_device, dev);
> +}
> +EXPORT_SYMBOL_GPL(dev_to_i3cdev);

Many other subsystems just make the device structure available
to all client drivers so this can be an inline operation. Is there
a strong reason to hide it here?

> +static struct i3c_device *
> +i3c_master_alloc_i3c_dev(struct i3c_master_controller *master,
> +                        const struct i3c_device_info *info,
> +                        const struct device_type *devtype)
> +{
> +       struct i3c_device *dev;
> +
> +       dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +       if (!dev)
> +               return ERR_PTR(-ENOMEM);
> +
> +       dev->common.bus = master->bus;
> +       dev->dev.parent = &master->bus->dev;
> +       dev->dev.type = devtype;
> +       dev->dev.bus = &i3c_bus_type;

This feels a bit odd: so you have bus_type that can contain devices
of three (?) different device types: i3c_device_type, i3c_master_type
and i3c_busdev_type.

Generally speaking, we don't have a lot of subsystems that even
use device_types. I assume that the i3c_device_type for a
device that corresponds to an endpoint on the bus, but I'm
still confused about the other two, and why they are part of
the same bus_type.

Can you describe whether it's possible to have these arbitrarily
mixed, or is there a strict hierarchy such as

host_bus (e.g. platform_device)
    i3c_busdev
          i3c_master
                i3c_device

If that is the actual hierarchy, why isn't it enough to have multiple
masters as children of the platform_device, and then multiple
devices under each of them? Can you also have a platform_device
that controls multiple busdev instances, which each have multiple
masters?

> +/**
> + * i3c_generic_ibi_alloc_pool() - Create a generic IBI pool
> + * @dev: the device this pool will be used for
> + * @req: IBI setup request describing what the device driver expects
> + *
> + * Create a generic IBI pool based on the information provided in @req.
> + *
> + * Return: a valid IBI pool in case of success, an ERR_PTR() otherwise.
> + */
> +struct i3c_generic_ibi_pool *
> +i3c_generic_ibi_alloc_pool(struct i3c_device *dev,
> +                          const struct i3c_ibi_setup *req)
> +{
> +       struct i3c_generic_ibi_pool *pool;
> +       struct i3c_generic_ibi_slot *slot;
> +       unsigned int i;
> +       int ret;
> +
> +       pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> +       if (!pool)
> +               return ERR_PTR(-ENOMEM);
> +
> +       spin_lock_init(&pool->lock);
> +       INIT_LIST_HEAD(&pool->free_slots);
> +       INIT_LIST_HEAD(&pool->pending);
> +
> +       for (i = 0; i < req->num_slots; i++) {
> +               slot = kzalloc(sizeof(*slot), GFP_KERNEL);
> +               if (!slot)
> +                       return ERR_PTR(-ENOMEM);
> +
> +               i3c_master_init_ibi_slot(dev, &slot->base);
> +
> +               if (req->max_payload_len) {
> +                       slot->base.data = kzalloc(req->max_payload_len,
> +                                                 GFP_KERNEL);

You do a lot of allocations here, each with the same GFP_KERNEL
flag. Do the objects have different lifetimes, or could you combine
them into a larger allocation?

Is this called frequently, or only while initializing a device?

> +/**
> + * struct i3c_ccc_mwl - payload passed to SETMWL/GETMWL CCC
> + *
> + * @len: maximum write length in bytes
> + *
> + * The maximum write length is only applicable to SDR private messages or
> + * extended Write CCCs (like SETXTIME).
> + */
> +struct i3c_ccc_mwl {
> +       __be16 len;
> +} __packed;

I would suggest only marking structures as __packed that are not already
naturally packed. Note that a side-effect of __packed is that here
alignof(struct i3c_ccc_mwl) will be '1', and architectures without efficient
unaligned access will have to access the field one byte at a time because
they assume that it may be misaligned.

> +/**
> + * struct i3c_ccc_mrl - payload passed to SETMRL/GETMRL CCC
> + *
> + * @len: maximum read length in bytes
> + * @ibi_len: maximum IBI payload length
> + *
> + * The maximum read length is only applicable to SDR private messages or
> + * extended Read CCCs (like GETXTIME).
> + * The IBI length is only valid if the I3C slave is IBI capable
> + * (%I3C_BCR_IBI_REQ_CAP is set).
> + */
> +struct i3c_ccc_mrl {
> +       __be16 read_len;
> +       u8 ibi_len;
> +} __packed;

This one clearly needs the __packed to get sizeof(struct i3c_ccc_mrl)==3

> +/**
> + * struct i3c_ccc_cmd_payload - CCC payload
> + *
> + * @len: payload length
> + * @data: payload data
> + */
> +struct i3c_ccc_cmd_payload {
> +       u16 len;
> +       void *data;
> +};
> +
> +/**
> + * struct i3c_ccc_cmd_dest - CCC command destination
> + *
> + * @addr: can be an I3C device address or the broadcast address if this is a
> + *       broadcast CCC
> + * @payload: payload to be sent to this device or broadcasted
> + */
> +struct i3c_ccc_cmd_dest {
> +       u8 addr;
> +       struct i3c_ccc_cmd_payload payload;
> +};

There seems to be a lot of padding in this structure: on a 64-bit
machine, you have 11 bytes of data and 13 bytes of padding.
Not sure if that's intentional or important at all.

> +/**
> + * struct i3c_ccc_cmd - CCC command
> + *
> + * @rnw: true if the CCC should retrieve data from the device. Only valid for
> + *      unicast commands
> + * @id: CCC command id
> + * @dests: array of destinations and associated payload for this CCC. Most of
> + *        the time, only one destination is provided
> + * @ndests: number of destinations. Should always be one for broadcast commands
> + */
> +struct i3c_ccc_cmd {
> +       bool rnw;
> +       u8 id;
> +       struct i3c_ccc_cmd_dest *dests;
> +       int ndests;
> +};

Moving the 'ndests' above the pointer will make this structure 16 bytes instead
of 24 on 64-bit architectures.

> +/**
> + * struct i3c_i2c_dev - I3C/I2C common information
> + * @node: node element used to insert the device into the I2C or I3C device
> + *       list
> + * @bus: I3C bus this device is connected to
> + * @master: I3C master that instantiated this device. Will be used to send
> + *         I2C/I3C frames on the bus
> + * @master_priv: master private data assigned to the device. Can be used to
> + *              add master specific information
> + *
> + * This structure is describing common I3C/I2C dev information.
> + */
> +struct i3c_i2c_dev {
> +       struct list_head node;
> +       struct i3c_bus *bus;
> +       struct i3c_master_controller *master;
> +       void *master_priv;
> +};

I find this hard to follow, which means either this has to be complicated
and I just didn't take enough time to think it through, or maybe it can
be simplified.

The 'node' field seems particularly odd, can you explain what it's
for? Normally all children of a bus device can be enumerated by
walking the device model structures. Are you doing this just so
you can walk a single list rather than walking the i3c and i2c
devices separately?

> +/**
> + * struct i3c_bus - I3C bus object
> + * @dev: device to be registered to the device-model
> + * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
> + *             this can change over the time. Will be used to let a master
> + *             know whether it needs to request bus ownership before sending
> + *             a frame or not
> + * @id: bus ID. Assigned by the framework when register the bus
> + * @addrslots: a bitmap with 2-bits per-slot to encode the address status and
> + *            ease the DAA (Dynamic Address Assignment) procedure (see
> + *            &enum i3c_addr_slot_status)
> + * @mode: bus mode (see &enum i3c_bus_mode)
> + * @scl_rate: SCL signal rate for I3C and I2C mode
> + * @devs: 2 lists containing all I3C/I2C devices connected to the bus
> + * @lock: read/write lock on the bus. This is needed to protect against
> + *       operations that have an impact on the whole bus and the devices
> + *       connected to it. For example, when asking slaves to drop their
> + *       dynamic address (RSTDAA CCC), we need to make sure no one is trying
> + *       to send I3C frames to these devices.
> + *       Note that this lock does not protect against concurrency between
> + *       devices: several drivers can send different I3C/I2C frames through
> + *       the same master in parallel. This is the responsibility of the
> + *       master to guarantee that frames are actually sent sequentially and
> + *       not interlaced
> + *
> + * The I3C bus is represented with its own object and not implicitly described
> + * by the I3C master to cope with the multi-master functionality, where one bus
> + * can be shared amongst several masters, each of them requesting bus ownership
> + * when they need to.
> + */
> +struct i3c_bus {
> +       struct device dev;
> +       struct i3c_device *cur_master;
> +       int id;
> +       unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
> +       enum i3c_bus_mode mode;
> +       struct {
> +               unsigned long i3c;
> +               unsigned long i2c;
> +       } scl_rate;
> +       struct {
> +               struct list_head i3c;
> +               struct list_head i2c;
> +       } devs;
> +       struct rw_semaphore lock;
> +};

Now here you have two separate lists. How is the i3c list
different from i3c_bus->dev.p->klist_children?

How do you get to the i2c_adapter from an i3c_bus? Does
each master have one?

        Arnd
