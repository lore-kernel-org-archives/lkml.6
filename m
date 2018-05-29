Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936856AbeE2Qcr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:32:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52770 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934984AbeE2Qcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:32:43 -0400
X-Google-Smtp-Source: ADUXVKIUUZMvmJYiAFzBNjG7kmPHhO9/uXJ0P3JNnN5CMPv99ov23WgZXapUxpnQpQSWTBsmW2/KPw/6MPIG/lOHNQo=
MIME-Version: 1.0
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-8-ricardo.ribalda@gmail.com> <CAL_JsqKRqKJmPc-QQBcN9j5=_y+MH+Rn1aZNun=MAgBMpvDL2w@mail.gmail.com>
 <CAPybu_1Pxc_Bd9gTaKO2TJ83aZbA4R1wcAhCE+HQxJbfAFNYDA@mail.gmail.com>
In-Reply-To: <CAPybu_1Pxc_Bd9gTaKO2TJ83aZbA4R1wcAhCE+HQxJbfAFNYDA@mail.gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 29 May 2018 18:32:25 +0200
Message-ID: <CAPybu_2n2+2vPnvqB_ZYHC3KpqFUQs0OMM7PgTKTa5wX=27_aQ@mail.gmail.com>
Subject: Re: [PATCH 07/19] serdev: Allows dynamic creation of devices via sysfs
To: Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the right address for Wolfram
On Tue, May 29, 2018 at 6:30 PM Ricardo Ribalda Delgado <
ricardo.ribalda@gmail.com> wrote:

> Hi Rob

> On Tue, May 29, 2018 at 5:38 PM Rob Herring <robh@kernel.org> wrote:

> > On Tue, May 29, 2018 at 8:10 AM, Ricardo Ribalda Delgado
> > <ricardo.ribalda@gmail.com> wrote:
> > > Allow creating and deleting devices via sysfs. Devices created will be
> > > matched to serdev drivers via modalias (the string provided by the
user)
> > > and deleted via their name. Eg:
> > >
> > >  # Create device
> > > root@qt5022:~# echo ttydev >
/sys/bus/serial/devices/serial0/new_device
> > >
> > >  # Delete device
> > > root@qt5022:~#
> > >         echo serial0-0 > /sys/bus/serial/devices/serial0/delete_device

> > I think the model here should be the kernel provides dummy slave
> > device for each serial port and then you can use bind and unbind to
> > bind to a particular driver.


> I have been researching a bit that approach, but I found a couple of
issues:

> - With the bind/unbind you need to modprobe manually the module. Something
> like

> modprobe myserdev
> echo myserdev > bind

> - You need one module per part_number, with modalias you can have a
> different alias per module

> - I guess that the final user will appreciate that the serdev has the same
> API as other serial slow bus (i2c).

> ccing Wolfram becase maybe he has some feedback to same from his
experience
> with the i2c bus.

> Thanks!


> > Rob



> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
