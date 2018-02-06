Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeBFBUl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 20:20:41 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:42605 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFBUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 20:20:31 -0500
X-Google-Smtp-Source: AH8x227hZqIxpQMJsGSa13KMf+kY07wwNzZCC3KsVVWv/vRMmKKRWmXFW8IrYkTAJ40zgP0/qnBZMw==
Date: Mon, 5 Feb 2018 17:20:27 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] input: touchscreen: ar1021_i2c: enable touch mode
 during open
Message-ID: <20180206012027.GF46524@dtor-ws>
References: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
 <CAH9NwWeom2H89D5hUixxSL28YgDna_WS26boayzUBAPyVFUvTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWeom2H89D5hUixxSL28YgDna_WS26boayzUBAPyVFUvTA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 11:07:08AM +0100, Christian Gmeiner wrote:
> Hi all.
> 
> 2017-04-27 14:22 GMT+02:00 Martin Kepplinger <martin.kepplinger@ginzinger.com>:
> > The device could as well be in command mode, in which this driver cannot
> > handle the device. When opening the device, let's make sure the device
> > will be in the mode we expect it to be for this driver.
> >
> 
> I run into issues caused by this change. It turns out that the device
> is non-functional
> after some warm-reboots and as a result I am not able to use xorg's
> evdev driver.
> So I have some questions about this change:
> 
> * Should we enable irq before calling i2c_master_send(..) as the chip raises an
>   irq if the command was processed?

Well, we do not care about the response... However, what is your
interrupt trigger settings? Are you using edge by chance? If so, please
try switching to level.

> 
> * Would it be enough to send this command only once during driver
> lifetime? I can
>   see that on my system open gets called 3 times during boot-up.
> 
> * What are the circumstances the touch device would be in an other state? In the
>   official kernel driver the userspace can send commands via sysfs.
> Also the driver
>   does set the touch enable mode as this patch does.

What is "the official kernel driver"?

Thanks.

-- 
Dmitry
