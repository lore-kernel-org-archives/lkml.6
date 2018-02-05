Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeBEKqK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:46:10 -0500
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:36117 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752294AbeBEKqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:46:01 -0500
X-CTCH-RefID: str=0001.0A0B0204.5A78348B.0174:SCFSTAT16437741,ss=1,re=-4.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Subject: Re: [PATCH 1/2] input: touchscreen: ar1021_i2c: enable touch mode
 during open
To: Christian Gmeiner <christian.gmeiner@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
 <CAH9NwWeom2H89D5hUixxSL28YgDna_WS26boayzUBAPyVFUvTA@mail.gmail.com>
From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Message-ID: <5bfec26e-b09c-2fa0-4eb0-3f9a08d293ed@ginzinger.com>
Date: Mon, 5 Feb 2018 11:40:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAH9NwWeom2H89D5hUixxSL28YgDna_WS26boayzUBAPyVFUvTA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.10.1.120]
X-ClientProxiedBy: exc1.buero.ginzinger.com (10.1.1.204) To
 exc1.buero.ginzinger.com (10.1.1.204)
X-EXCLAIMER-MD-CONFIG: 9dd172f7-de2e-4231-b886-ec11f46e03b3
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿



Martin Kepplinger | Entwicklung Software 

GINZINGER ELECTRONIC SYSTEMS GMBH

Tel.: +43 7723 5422 157
Mail: martin.kepplinger@ginzinger.com
Web: www.ginzinger.com




On 2018-02-05 11:07, Christian Gmeiner wrote:
> Hi all.
> 
> 2017-04-27 14:22 GMT+02:00 Martin Kepplinger <martin.kepplinger@ginzinger.com>:
>> The device could as well be in command mode, in which this driver cannot
>> handle the device. When opening the device, let's make sure the device
>> will be in the mode we expect it to be for this driver.
>>
> 
> I run into issues caused by this change. It turns out that the device
> is non-functional
> after some warm-reboots and as a result I am not able to use xorg's
> evdev driver.
> So I have some questions about this change:
> 
> * Should we enable irq before calling i2c_master_send(..) as the chip raises an
>   irq if the command was processed?
> 
> * Would it be enough to send this command only once during driver
> lifetime? I can
>   see that on my system open gets called 3 times during boot-up.

It would. See below for my thought on this change.

> 
> * What are the circumstances the touch device would be in an other state? In the
>   official kernel driver the userspace can send commands via sysfs.
> Also the driver
>   does set the touch enable mode as this patch does.

I did this change as the device was once non-functional unexpectedly
because it wasn't in touch mode. We can set touch mode during open() or
probe() but I figured during open() would keep the driver working even
when others would use the device in command mode.

Does your problem go away when you revert this change or put it into
probe()?

                                  martin



________________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089
