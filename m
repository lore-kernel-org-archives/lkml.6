Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F253C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4F52086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544707396;
	bh=pD2P+/UrGdJbh5AC683BwVK4DYQ7ubO1bAwn4oRH3/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U1wcRXyiACsgsoGDP58omKX7hl8U2Gq0Olj4CvYF865YpIK+fa2gCJ0ekH1z9jAQm
	 U9WICP7d+qCY2lLa/HCp4NAqJe/v0HYQ1iNdyuDMQRyDP0YPGwZ1wkK+pyJOJSZoTz
	 3Uvmq87Un8PMmUW0z4VbQqTThk1wwngJ4TGyDBPA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4F52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbeLMNXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:23:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42646 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbeLMNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:23:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so1740647lja.9;
        Thu, 13 Dec 2018 05:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q0/YyjVcWDhg0APpJn+wxw3vscuizWIiOofUwl/s8uA=;
        b=kQgYMYEbwahYGanOXNHmvcsUQFu+8gdAsLtbzWHJmq9VLX1F8jgEl4rsiXjFn4bhAl
         AJhBvOagf/WE0M7HIFn2Lk5qBgQ9yYT1NrBJ+9AVPQ41+wNkXKuv2NPX6hWyDoyR+ls9
         DKRa+Mg9luL9zBzTjUhP0KKxjIEpIFb9zUgnT9wfP4DCubbWGHsFyp9ULZxoeOtyFC1A
         gyKqRF3/2UBcOe9ZE2Wov4xZ91yhnPM3FLFSGUJX9lBMvBPS08AQEMMDtwgHuwIryx1L
         mZPGZNPqI4o9EXTzPg7qseWiH54NjoJGY9ZTKB+AjZPhdryZwh/i+uDScoyZQBRbuOnD
         XwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Q0/YyjVcWDhg0APpJn+wxw3vscuizWIiOofUwl/s8uA=;
        b=GD94tiwU47bL+QZgxEwzslwtxa+MC3secMC3h+bOle4DzDNYyGt8gijpAB3rOcfdT9
         appe+7rsbt1zc+DX/lgKfT0mQKm/ads+jcFCYSJ2UoIaxQGLLIy4dHiNwyyVsyxvbSXB
         WAt2nBfH0bit+Ko3//FZL/wQk6DUV0XNKXuIObxoQSghg2pO62lNc6XXIlhOjeT9EzOQ
         fvC9ULQc7o6mM6wxHlkbm3TbHXWWQAGUQ9szUsiPQpTouswzyC+ngYW5E7KEBroZ4dBa
         lEUbrrDASxy88o4BYCx18wPa35HyIlgCuF3nNigSMskt8S50TMPQO0WO7g51QUENR+2S
         tvcg==
X-Gm-Message-State: AA+aEWazfLFwbW+egdKx90WGlctaCmZYmRM97rhVhm1Zyed+HzBe53Fp
        uYOWNMeuLSQJHd0Nh/nBslQ=
X-Google-Smtp-Source: AFSGD/UBuiKbUh75g9xjAwLsiyl8FDaTa/JCA98Xpvxe869RsNiUuliPp+lxxyXM4XYXFCQIQqLYzQ==
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr14704478lji.57.1544707391355;
        Thu, 13 Dec 2018 05:23:11 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p21sm347792lfj.10.2018.12.13.05.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 05:23:09 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gXQxP-0000j9-JY; Thu, 13 Dec 2018 14:23:15 +0100
Date:   Thu, 13 Dec 2018 14:23:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     Anatolij Gustschin <agust@denx.de>, johan@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: usb: thoughts of adding more support for FT232H
Message-ID: <20181213132315.GN3500@localhost>
References: <48bc71bb-68e4-8b29-f609-940c9aedc0a9@gmail.com>
 <20181205161718.7451d98f@crub>
 <924d4ebb-5f9c-f863-c698-9f978e9bc337@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <924d4ebb-5f9c-f863-c698-9f978e9bc337@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

Sorry about the late reply.

On Thu, Dec 06, 2018 at 02:02:21PM +0800, Song Qiang wrote:
> 
> On 12/5/18 11:17 PM, Anatolij Gustschin wrote:
> > Hi,
> >
> > On Wed, 5 Dec 2018 22:10:40 +0800
> > Song Qiang songqiang1304521@gmail.com wrote:
> > ...
> >> I've been developing some iio device drivers and found that some people
> >> would like to test their devices with a qemu system which requires an
> >> i2c or spi port on our development hosts. Usually this is achieved with
> >> a DLN-2 adapter, while this is a bit difficult for me because it costs
> >> ~175$ in my country. Then I found that FTDI's FT232H supports both these
> >> two modes and costs only less than 5$ but without full support in kernel.
> >> The ftdi-sio driver supports FT232H only as a serial converter.
> >> So I'm planning to write a mfd driver for it supports both these three
> >> modes, here are my thoughts:
> > There already has been a discussion [1] about adding an MFD driver for
> > FT232H, since the operating modes are mutually exclusive (and bus pins
> > shared between different modes), the MFD approach doesn't seem to be
> > a good fit.
> >
> >>   - This device cannot support these three modes together because they
> >>     share some common pins, so I'm planning to add a sysfs entry
> >>     'current_mode' for selecting which mode the device should be working
> >>     on.
> >>   - This device is in uart mode on reset, so default mode would be reset,
> >>     too. This also helps for people only want to use this as a serial
> >>     converter feels nothing has happened (compatible).
> >>   - I was trying to reuse the ftdi-sio driver but it seems like mfd can
> >>     only register platform devices, while this is a usb driver. I may
> >>     have to copy some functions from this driver.
> >>
> >> Would you share any ideas? I'd appreciate it.
> > There is a patch series [2] adding an interface driver for FT232H-
> > based adapter devices, it already supports adding custom MPSSE based
> > SPI busses with SPI slaves for a custom USB PID. It already supports
> > adding custom CBUS-/MPSSE-GPIO adapters for user-defined USB PID.
> > Adding I2C driver/adapter support should be easy, too. Maybe you can
> > re-use it.

> > [1] https://patchwork.kernel.org/patch/9828985
> > [2] https://patchwork.kernel.org/project/linux-usb/list/?series=48255

> Patch series [2] added new custom PIDs to distinguish the mode this device 
> should be in when powered on, is this right? Since USB has a convention for all 
> the VIDs and PIDs, is this really a good approach to use some us-defined PIDs?

As I mentioned, I have not really had time to look at [2] yet, but yes,
the driver appears to encode the mode configuration in the device id
table.

> In the discussion [1] #4, Johan said that mfd is not suitable for this situation 
> because 'all drivers for these devices be able to retrieve the current mode 
> during probe and only bind when the mode matches'.

Right, MFD is for devices exposing multiple functions concurrently, but
the FTDI serial-engine modes are mutually exclusive (as you also point
out below).

> I think this is saying that we can only register these devices(i2c, spi, gpio) 
> when we plug it in, but FT232H's functions are surely mutually exclusive, so 
> can't we dynamically register these devices in userspace? I mean through a sysfs 
> interface, and through the implementation functions of this interface, we can 
> try to use mfd_add_devices() and mfd_remove_devices() to unload one 
> function(like uart) and load it as another device like a spi adapter. Is there 
> any side effects of doing this in this way?

It gets pretty messy implementation wise. That's one reason why having
separate drivers and binding based on PID is preferable (another is
being able to determine the mode at probe).

But if this is to be implemented, we probably also do want to be able to
share some code (e.g. for managing the cbus pins as gpios, and that
part could possibly be modelled as an mfd...).

Then you also have the problem of describing the buses that the FTDI
chip exposes. There's currently no way for example to load a device-tree
overlay from userspace after you configure the mode for, say, spi in
order to register the spi slaves.

This is also related to what we want to solve for serial-connected
devices (serdev). Using device-tree overlays for this has been
discussed, but there are some missing pieces for that to be realised
(not least a user-space interface for loading overlays).

Thanks,
Johan
