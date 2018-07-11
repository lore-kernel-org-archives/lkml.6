Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F381C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE56020C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IifICxaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE56020C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbeGKPo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:44:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46572 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389195AbeGKPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:44:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so8704613ljj.13;
        Wed, 11 Jul 2018 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SY8vwH8HvMI62hiOgFGJooBTRfQaHoRvqnodPnknhBs=;
        b=IifICxaMX5Uygxb2XO26uj1MAsNbH2g0ayu8PEqHVrs95YIRGFZKuZ8P3c0W4FDjVh
         ELw14iEjiTComRTjxh2auZGQtK+EKT/JZiUqL0aVaYjiKtWfaVPgjT1Fy7c60XXZMNtH
         LMzUpaE4Zs0bTkf9tHTHs5xSTAa+wwJgXpU8M16rZlVWsDNYB/03e5RW6OZ37ok0Thvt
         +Wh5BXPZwEgh8qRCTc+rRTZARF/L2Bf1wholtVuJfdaAXmXdW9nuVUZtR6y4sp/w6zvo
         x6HB/6TLLDC9Z8jupEl1z+gx14NV09bG5ski+t85f04+GI74JrTBS5E+5A6coY6rL9TV
         zgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SY8vwH8HvMI62hiOgFGJooBTRfQaHoRvqnodPnknhBs=;
        b=gierOqqXG9s6nhmNldFDCFG0/WOGmQ3tmr+ktFYVwsdr2Qgy2A3VRC9yxXnspXD4tv
         qpjvlle7Q9ka/iwQ1GMOxL5kILLPxaBMREyGlpvwlXPXhfQIHDZ6wnqizjlF5IyAcsYi
         XEQoLQffnUvOdxGiAJ0zF1vD6YlG7MfL4K921EXm63R+4J8soS/WJKtwvFR09E2h3QLj
         wGrC1bbeLb06nRKMPILcG7cDqk9S9/hnIb+OewxtRJIs5ZkPNASm1elG9UKO7MutJB9P
         x63h1MvEVtHQeHQqoaiKFd47zGNg3MDhjsggGw6B49ELb8dsPjDyqYlVzSZVDcHpFJhH
         tUsw==
X-Gm-Message-State: APt69E0YfIG4Nqn2CXeQKLTHPVrkHakDM8SM+ts4HmW3WdQcS/yJ0Toj
        1Cp6xAofN2PjodfridQRml8bKsH1tPnW67q+tyI=
X-Google-Smtp-Source: AAOMgpcVC14oNLQ7iIxFDSQhhJXIrdB4gZpSc/yUhYybseaGbBtLLFLvItv766o5qBzr/Ri26+/RDX12niqGwTkB4oo=
X-Received: by 2002:a2e:1207:: with SMTP id t7-v6mr18902806lje.129.1531323597316;
 Wed, 11 Jul 2018 08:39:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 08:39:56
 -0700 (PDT)
In-Reply-To: <20180711164120.3e32fb08@bbrezillon>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com> <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
 <20180711164120.3e32fb08@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jul 2018 17:39:56 +0200
X-Google-Sender-Auth: HI0bzqHk0-CmvDBVKx07Tma1k5Q
Message-ID: <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
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

On Wed, Jul 11, 2018 at 4:41 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Wed, 11 Jul 2018 16:01:56 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>> > - the bus element is a separate object and is not implicitly described
>> >   by the master (as done in I2C). The reason is that I want to be able
>> >   to handle multiple master connected to the same bus and visible to
>> >   Linux.
>> >   In this situation, we should only have one instance of the device and
>> >   not one per master, and sharing the bus object would be part of the
>> >   solution to gracefully handle this case.
>> >   I'm not sure we will ever need to deal with multiple masters
>> >   controlling the same bus and exposed under Linux, but separating the
>> >   bus and master concept is pretty easy, hence the decision to do it
>> >   like that.
>> >   The other benefit of separating the bus and master concepts is that
>> >   master devices appear under the bus directory in sysfs.
>>
>> I'm not following here at all, sorry for missing prior discussion if this
>> was already explained. What is the "multiple master" case? Do you
>> mean multiple devices that are controlled by Linux and that each talk
>> to other devices on the same bus, multiple operating systems that
>> have talk to are able to own the bus with the kernel being one of
>> them, a controller that controls multiple independent buses,
>> or something else?
>
> I mean several masters connected to the same bus and all exposed to the
> same Linux instance. In this case, the question is, should we have X
> I3C buses exposed (X being the number of masters) or should we only
> have one?
>
> Having a bus represented as a separate object allows us to switch to
> the "one bus : X masters" representation if we need too.
...
>>
>> This feels a bit odd: so you have bus_type that can contain devices
>> of three (?) different device types: i3c_device_type, i3c_master_type
>> and i3c_busdev_type.
>>
>> Generally speaking, we don't have a lot of subsystems that even
>> use device_types. I assume that the i3c_device_type for a
>> device that corresponds to an endpoint on the bus, but I'm
>> still confused about the other two, and why they are part of
>> the same bus_type.
>
> i3c_busdev is just a virtual device representing the bus itself.
> i3c_master is representing the I3C master driving the bus. The reason
> for having a different type here is to avoid attaching this device to a
> driver but still being able to see the master controller as a device on
> the bus. And finally, i3c_device are all remote devices that can be
> accessed through a given i3c_master.
>
> This all comes from the design choice I made to represent the bus as a
> separate object in order to be able to share it between different
> master controllers exposed through the same Linux instance. Since
> master controllers are also remote devices for other controllers, we
> need to represent them.

Ok, so I think this is the most important question to resolve: do we
actually need to control multiple masters on a single bus from one OS
or not?

The problem that I see is that it breaks the tree abstraction that
we use in the dtb interface, in the driver model and in sysfs.
If we need to deal with a hardware bus structure like

              cpu
             /   \
            /     \
       platdev   platdev
           |        |
     i3c-master   i3c-master
            \      /
             \    /
            i3c-bus
             /    \
         device   device

then that abstraction no longer holds. Clearly you could build
a system like that, and if we have to support it, the i3c infrastructure
should be prepared for it, since we wouldn't be able to retrofit
it later.

What would be the point of building such a system though?
Is this for performance, failover, or something else?
IOW, what feature would we lose if we were to declare that
setup above invalid (and ensure you cannot represent it in DT)?

>> > +/**
>> > + * struct i3c_ccc_mwl - payload passed to SETMWL/GETMWL CCC
>> > + *
>> > + * @len: maximum write length in bytes
>> > + *
>> > + * The maximum write length is only applicable to SDR private messages or
>> > + * extended Write CCCs (like SETXTIME).
>> > + */
>> > +struct i3c_ccc_mwl {
>> > +       __be16 len;
>> > +} __packed;
>>
>> I would suggest only marking structures as __packed that are not already
>> naturally packed. Note that a side-effect of __packed is that here
>> alignof(struct i3c_ccc_mwl) will be '1', and architectures without efficient
>> unaligned access will have to access the field one byte at a time because
>> they assume that it may be misaligned.
>
> These are structure used to create packets to be sent on the wire.
> Making sure that everything is packed correctly is important, so I'm
> not sure I can remove the __packed everywhere.

I mean just the ones for which the __packed attribute only changes
the alignment of the outer structure but not the layout inside of the
structure. Alternatively, set both __packed and __aligned().

>> > +/**
>> > + * struct i3c_i2c_dev - I3C/I2C common information
>> > + * @node: node element used to insert the device into the I2C or I3C device
>> > + *       list
>> > + * @bus: I3C bus this device is connected to
>> > + * @master: I3C master that instantiated this device. Will be used to send
>> > + *         I2C/I3C frames on the bus
>> > + * @master_priv: master private data assigned to the device. Can be used to
>> > + *              add master specific information
>> > + *
>> > + * This structure is describing common I3C/I2C dev information.
>> > + */
>> > +struct i3c_i2c_dev {
>> > +       struct list_head node;
>> > +       struct i3c_bus *bus;
>> > +       struct i3c_master_controller *master;
>> > +       void *master_priv;
>> > +};
>>
>> I find this hard to follow, which means either this has to be complicated
>> and I just didn't take enough time to think it through, or maybe it can
>> be simplified.
>>
>> The 'node' field seems particularly odd, can you explain what it's
>> for? Normally all children of a bus device can be enumerated by
>> walking the device model structures. Are you doing this just so
>> you can walk a single list rather than walking the i3c and i2c
>> devices separately?
>
> The devices discovered on the bus are not directly registered to the
> device model, and I need to store them in a list to do some operations
> before exposing them. Once everything is ready to be used, I then
> iterate the list and register all not-yet-registered I3C devs.

Can you explain what those operations are and why we can't
register everything directly? This seems rather unconventional,
so I want to make sure it's done for a good reason.

      Arnd
