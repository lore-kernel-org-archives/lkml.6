Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFD0C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F202025FC1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PkAl5jjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F202025FC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964947AbeFYRqz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:46:55 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43085 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964852AbeFYRqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:46:52 -0400
Received: by mail-io0-f193.google.com with SMTP id i23-v6so10440858iog.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=esxgpMkvOnY+IVTQpQ+DVLZ8RVCBfFkg5MgDC85c0HM=;
        b=PkAl5jjrUWq/+vEJabu2OVbbNMudNB4VA8xopm/06hxcpi/mcJCuap2mMGqjb6m1L1
         BSw5iXCrIyJifqG9nVPziZTG91S3oogL+g6eEUTCJE9pkxEJwj2NsgEmWphun7QT6Cgq
         b0Ric/F0QGm+WN3o1ETUDgiAPcHQvozH5lvbnANbSZ8xTMH3f+a8B2fmoVtSJvoyBv2Y
         kDN3OZCYViwq7vqyta8XRRpPZv8g0S8ugJm7T6qXQj0y3qBCGqZ6U4Uw2Mtmnt3LNCg4
         LNZLuaqX/5hGk5nvpsqRrXWj9baqZnJ3lYsGxcgPDnJyG2EGU0/mmy46zhQdpgd16GzU
         lTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=esxgpMkvOnY+IVTQpQ+DVLZ8RVCBfFkg5MgDC85c0HM=;
        b=GbrMixfGIGXsQYbhwmkzG3O83LbZY18Cfrs/w9TE3W4gGEYdUd4lnkULbhu5UoVyzR
         dRfCIftLWbS0aBkAQ7Wf05dZOWlCCLXc0tiEmFxWLUYa+HJeLSjJmzBI0t6r2MDdUp4E
         qjqBwenB30PrKM1b5iRMhP022+HRVpSoiWij8u5Qll6rL/kCbT9EAUqdl+7os6G3oQBU
         MAfhCh71f8qW9oHnTgQn2cl0V7YZJU9a0np1Jwq9YV6Rg06qOpygIp8U5ZQjEYK3Crt3
         VgxuF8iwjZj//1ZxsiejzjL8et2TuC07OYOdJpTKho6c/AXXaxvEPw6IrUraHw7z5q8G
         LtZA==
X-Gm-Message-State: APt69E0rka3JHZ9kU3uyZhCiCUjpTl3dT1hxCH0d95owKtkzNQj5zuNn
        YrX4MvGhgwVgeom4f+fSCWqQSbGD782Az1yyBRXx7A==
X-Google-Smtp-Source: AAOMgpePadUNVPd8HYS73XeatKr3uwjy1aypGjYsv6wO99cu9J/Rrwv9w9vsnu379QAFnUC8BODdWDZn8DIchxameD8=
X-Received: by 2002:a6b:6403:: with SMTP id t3-v6mr8812197iog.111.1529948812198;
 Mon, 25 Jun 2018 10:46:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 10:46:51
 -0700 (PDT)
In-Reply-To: <20180625174024.GB17417@lunn.ch>
References: <20180625155025.12567-1-brgl@bgdev.pl> <20180625174024.GB17417@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 25 Jun 2018 19:46:51 +0200
Message-ID: <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing at24_platform_data
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-25 19:40 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Mon, Jun 25, 2018 at 05:50:11PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Since I took over maintainership of the at24 driver I've been working
>> towards removing at24_platform_data in favor for device properties.
>>
>> DaVinci is the only platform that's still using it - all other users
>> have already been converted.
>>
>> One of the obstacles in case of DaVinci is removing the setup() callback
>> from the pdata struct, the only user of which are some davinci boards.
>
> Hi Bartosz
>
> Nice code.
>
> I've got a platform i want to add sometime soon using the at24. I
> noticed you doing the cleanup, so i avoided the setup() call. But
> using it would of helped...
>
> My platform is x86 based, so no device tree. I instantiate a number of
> AT24 devices from a platform driver, and then add nvmem cells so i can
> access data in these eeproms. This new code will make this simpler.
>
>> The only board that's still using this callback is now mityomapl138.
>> Unfortunately it stores more info in EEPROM than just the MAC address
>> and will require some more work. Unfortunately I don't have access
>> to this board so I can't test any actual solutions on a live hardware.
>
> Depending on what i find in the EEPROM, i need to instantiate other
> i2c devices. So i have the problem of knowing when the EEPROM has
> actually probed and i can use the nvmem API to retrieve the contents.
>
> What i have done so far, is registers a bus notifier on i2c_bus_type,
> and look for BUS_NOTIFY_BOUND_DRIVER. I can then check if the i2c
> client in the notifier is the at24 client. But when i then add more
> i2c clients from inside the notifier i get lockdep splats. They are
> false positives, but it does suggest it is not a good idea to do this.
>
> So it would be good to have some sort of recommended alternative to
> the setup() callback. Ideally it would be specific to a particular
> at24, and safe to call other i2c functions from.
>
> Do you have any ideas?
>
>    Andrew

With my patch 1/14 you'll get -EPROBE_DEFER from nvmem_cell_get() if
the nvmem provider is not yet registered. Will that help in your case?

Bart
