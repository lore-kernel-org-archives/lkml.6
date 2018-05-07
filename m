Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeEGUBg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:01:36 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36254 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeEGUBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:01:34 -0400
X-Google-Smtp-Source: AB8JxZq4OzsugpAchfPWLjKjNBou4aJ0F1ee2JjPBkuEHszr55PLRFQgn4ZL/1sxb8J3bxz40o7g6g==
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
To: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx>
 <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
 <87k1sgtf8t.wl-ysato@users.sourceforge.jp>
 <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
 <20180507144519.GH1392@brightrain.aerifal.cx>
 <9f476147-7370-de56-db4e-6745a325a2ca@landley.net>
 <20180507155543.GJ1392@brightrain.aerifal.cx>
From: Rob Landley <rob@landley.net>
Message-ID: <d102251b-334e-0e61-9ecd-1f5c4651e987@landley.net>
Date: Mon, 7 May 2018 15:01:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507155543.GJ1392@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 10:55 AM, Rich Felker wrote:
> On Mon, May 07, 2018 at 10:28:37AM -0500, Rob Landley wrote:
>>
>>
>> On 05/07/2018 09:45 AM, Rich Felker wrote:
>> (You can usually configure/build uboot in a couple different ways, with a
>> brain-dead built in shell or with busybox hush glued into it. Depends on how big
>> you want the image to be. Not sure how much of that is upstream and how much is
>> vendor forks I've used, though. Been a while.)
> 
> This sounds like a pain,

Well yeah. It's u-boot.

> but none of it seems relevant to the setup
> we're using. This U-Boot variant does not install on flash or use

That's the full dance for getting it installed on a board it's not already
running on. Usually somebody else sets it up and you inherit one with a "tftp
download" script and another "boot from persistent storage" script and you
mostly just the command line to swap the autoboot variable to point to the right
one of the two.

> flash; it runs from disk in place of LILO or another MBR-based
> bootloader. I'm just trying to understand where/how the binary blobs
> are installed on the disk so I can reproduce that when making new disk
> images with my kernel and filesystem.

The point of the tftp boot is quick reboot cycles during development, not having
to install the kernel you're booting on target each time. But as long as you're
not replacing u-boot and have a u-boot console you can fall back on an alternate
kernel from disk. (It's not really designed to give you a menu though, it gives
you a command line. You can have the kernel name to load in its own variable and
"set kernelname 'walrus.img'; run hdboot" though.)

There are probably more elegant ways to use this tool. I learned how to hammer
it in and get the lid off, and went on to other things...

> Rich

Rob
