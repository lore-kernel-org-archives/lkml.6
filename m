Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935352AbeE2Pie (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934860AbeE2Pib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:38:31 -0400
X-Google-Smtp-Source: ADUXVKLs+lyI35jBIP/WCSkh1ansy2odRgeUFIfinM91A6X8PoDTLB64CwjGHYGbLN65LtP/JJpfPBHOpryPLTX48zI=
MIME-Version: 1.0
In-Reply-To: <20180529131014.18641-8-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com> <20180529131014.18641-8-ricardo.ribalda@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 May 2018 10:38:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKRqKJmPc-QQBcN9j5=_y+MH+Rn1aZNun=MAgBMpvDL2w@mail.gmail.com>
Message-ID: <CAL_JsqKRqKJmPc-QQBcN9j5=_y+MH+Rn1aZNun=MAgBMpvDL2w@mail.gmail.com>
Subject: Re: [PATCH 07/19] serdev: Allows dynamic creation of devices via sysfs
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 8:10 AM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Allow creating and deleting devices via sysfs. Devices created will be
> matched to serdev drivers via modalias (the string provided by the user)
> and deleted via their name. Eg:
>
>  # Create device
> root@qt5022:~# echo ttydev > /sys/bus/serial/devices/serial0/new_device
>
>  # Delete device
> root@qt5022:~#
>         echo serial0-0 > /sys/bus/serial/devices/serial0/delete_device

I think the model here should be the kernel provides dummy slave
device for each serial port and then you can use bind and unbind to
bind to a particular driver.

Rob
