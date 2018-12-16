Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43275C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E1E206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzJNRtKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbeLPPpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 10:45:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37622 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbeLPPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 10:45:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so3402928pgb.4;
        Sun, 16 Dec 2018 07:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=o1zildSPS9M6xJaRiD7Re7EsjxjSBCmH2v6qWfCb748=;
        b=lzJNRtKaZOnZGmIGUYhUm4CLoxO048WhCvFRZFoOkHPagVtU726x/9T++uJjGAClKx
         OlCEzKSO9cp/hO2MeJWqz7czFhh04s8G6kWNkBC91JhC2Igsp3b4pcdOukakU7qyJa0j
         a3bxutjQ3K6V/ckC4RtC2t2LpEk1EYkYDDuqRHmZ1AXahLKrLg/tgntgF9pLKcY5c5Ua
         fngMajZjRL35igTchT8bZch26tNxAzpwS2k08E4Z4VcxO76MpAmt4/nF4KquASs0YFUu
         IqRNXwj7J7ww+N77MtPcDxPKJuPKq/O0bw4lz5B0NKoCeNRmS79HyR2r2ijrURn7lgat
         gX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=o1zildSPS9M6xJaRiD7Re7EsjxjSBCmH2v6qWfCb748=;
        b=VDB2Uhk0FcNEZKqBf62P7kdhF5xJoh83iEU0nj/xx+nSAec00yvzD3Xu9AFuVzK6l6
         iDYQ087t7SIC+KcFrr4J5TBzdv81MK2BzPohcy0f2DiXJ0Ue4H+CKiee6OWD7DJEVdCm
         okiZ/NeOJ4oYGbEqkng41QEqytIdnS1bMW7stmKvmvxtGI4vgxr+8iM1uePcymSKQ7CU
         9v/Pe4gKW5sZoLPdWhwafOQlgEDNFwaX2WsZw268gRSxb7LKcR/E2agz4jlfqGCoHSNE
         1l+pfmRlotAiCb3yoF8h9nmWMLBmMaE+hYgzlhpm9S0qNPBryb2LbHsLZ6xWI4qtzdBo
         jPdw==
X-Gm-Message-State: AA+aEWZK9IHMQU3lAq2vrjbm4ARhphaoXrXhMHYZGEXsXiib2mfMdLe4
        sAY4foyrIb583E8sNbmikgu4hcwv
X-Google-Smtp-Source: AFSGD/UtSDDv92gjOCbm6xwnRERuPS3MN2QYE4DGyMEM0uYd3Dd76ITrBkFSINWCVQxnpXHdcpiJ0w==
X-Received: by 2002:a65:6392:: with SMTP id h18mr9397530pgv.107.1544975150014;
        Sun, 16 Dec 2018 07:45:50 -0800 (PST)
Received: from [0.0.0.0] (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id d68sm13955108pfa.64.2018.12.16.07.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 07:45:49 -0800 (PST)
Subject: Re: usb: thoughts of adding more support for FT232H
To:     Johan Hovold <johan@kernel.org>
Cc:     Anatolij Gustschin <agust@denx.de>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <48bc71bb-68e4-8b29-f609-940c9aedc0a9@gmail.com>
 <20181205161718.7451d98f@crub>
 <924d4ebb-5f9c-f863-c698-9f978e9bc337@gmail.com>
 <20181213132315.GN3500@localhost>
From:   Song Qiang <songqiang1304521@gmail.com>
Message-ID: <1aedd285-967a-4876-66be-c881fb81476c@gmail.com>
Date:   Sun, 16 Dec 2018 23:45:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213132315.GN3500@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/13 下午9:23, Johan Hovold wrote:

> Hi Song,
>
> Sorry about the late reply.
>
> On Thu, Dec 06, 2018 at 02:02:21PM +0800, Song Qiang wrote:
>> On 12/5/18 11:17 PM, Anatolij Gustschin wrote:
>>> Hi,
>>>
>>> On Wed, 5 Dec 2018 22:10:40 +0800
>>> Song Qiang songqiang1304521@gmail.com wrote:
>>> ...
>>>> I've been developing some iio device drivers and found that some people
>>>> would like to test their devices with a qemu system which requires an
>>>> i2c or spi port on our development hosts. Usually this is achieved with
>>>> a DLN-2 adapter, while this is a bit difficult for me because it costs
>>>> ~175$ in my country. Then I found that FTDI's FT232H supports both these
>>>> two modes and costs only less than 5$ but without full support in kernel.
>>>> The ftdi-sio driver supports FT232H only as a serial converter.
>>>> So I'm planning to write a mfd driver for it supports both these three
>>>> modes, here are my thoughts:
>>> There already has been a discussion [1] about adding an MFD driver for
>>> FT232H, since the operating modes are mutually exclusive (and bus pins
>>> shared between different modes), the MFD approach doesn't seem to be
>>> a good fit.
>>>
>>>>    - This device cannot support these three modes together because they
>>>>      share some common pins, so I'm planning to add a sysfs entry
>>>>      'current_mode' for selecting which mode the device should be working
>>>>      on.
>>>>    - This device is in uart mode on reset, so default mode would be reset,
>>>>      too. This also helps for people only want to use this as a serial
>>>>      converter feels nothing has happened (compatible).
>>>>    - I was trying to reuse the ftdi-sio driver but it seems like mfd can
>>>>      only register platform devices, while this is a usb driver. I may
>>>>      have to copy some functions from this driver.
>>>>
>>>> Would you share any ideas? I'd appreciate it.
>>> There is a patch series [2] adding an interface driver for FT232H-
>>> based adapter devices, it already supports adding custom MPSSE based
>>> SPI busses with SPI slaves for a custom USB PID. It already supports
>>> adding custom CBUS-/MPSSE-GPIO adapters for user-defined USB PID.
>>> Adding I2C driver/adapter support should be easy, too. Maybe you can
>>> re-use it.
>>> [1] https://patchwork.kernel.org/patch/9828985
>>> [2] https://patchwork.kernel.org/project/linux-usb/list/?series=48255
>> Patch series [2] added new custom PIDs to distinguish the mode this device
>> should be in when powered on, is this right? Since USB has a convention for all
>> the VIDs and PIDs, is this really a good approach to use some us-defined PIDs?
> As I mentioned, I have not really had time to look at [2] yet, but yes,
> the driver appears to encode the mode configuration in the device id
> table.
>
>> In the discussion [1] #4, Johan said that mfd is not suitable for this situation
>> because 'all drivers for these devices be able to retrieve the current mode
>> during probe and only bind when the mode matches'.
> Right, MFD is for devices exposing multiple functions concurrently, but
> the FTDI serial-engine modes are mutually exclusive (as you also point
> out below).
>
>> I think this is saying that we can only register these devices(i2c, spi, gpio)
>> when we plug it in, but FT232H's functions are surely mutually exclusive, so
>> can't we dynamically register these devices in userspace? I mean through a sysfs
>> interface, and through the implementation functions of this interface, we can
>> try to use mfd_add_devices() and mfd_remove_devices() to unload one
>> function(like uart) and load it as another device like a spi adapter. Is there
>> any side effects of doing this in this way?
> It gets pretty messy implementation wise. That's one reason why having
> separate drivers and binding based on PID is preferable (another is
> being able to determine the mode at probe).
>
> But if this is to be implemented, we probably also do want to be able to
> share some code (e.g. for managing the cbus pins as gpios, and that
> part could possibly be modelled as an mfd...).
>
> Then you also have the problem of describing the buses that the FTDI
> chip exposes. There's currently no way for example to load a device-tree
> overlay from userspace after you configure the mode for, say, spi in
> order to register the spi slaves.
>
> This is also related to what we want to solve for serial-connected
> devices (serdev). Using device-tree overlays for this has been
> discussed, but there are some missing pieces for that to be realised
> (not least a user-space interface for loading overlays).
>
> Thanks,
> Johan

Hi Johan,


Thanks for your reply, now I understand why the mfd doesn't fit.

So this is saying that currently there is not a very proper way of 
implementing this kind of driver, right? I also noticed that there are 
other series of chips supporting mutually exclusive multi-functions.  I 
think we quite need a framework for them.

Is there a kind of this framework under development? I'm curious and 
want to know how everyone thinks about this problem.


yours,

Song Qiang

