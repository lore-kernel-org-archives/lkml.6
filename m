Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeCPIM3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:12:29 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32889 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeCPIMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:12:25 -0400
X-Google-Smtp-Source: AG47ELuo8SEU4XQETlMm5l94KRg8/rlOFcR0EQO3McqqjbKr4vRsSIJU5Sf9p7FbaWbYMliUv1HNXyfEirzrwF0jUyA=
MIME-Version: 1.0
In-Reply-To: <2f2e0cd4-02ca-0e01-7003-e519a7706ee4@alum.mit.edu>
References: <20180314143529.1456168-1-arnd@arndb.de> <20180314143656.1495602-1-arnd@arndb.de>
 <20180314143656.1495602-6-arnd@arndb.de> <2f2e0cd4-02ca-0e01-7003-e519a7706ee4@alum.mit.edu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 16 Mar 2018 09:12:24 +0100
X-Google-Sender-Auth: vmGn-eQtB0VxUZyEGIIJv8ZOj4E
Message-ID: <CAK8P3a3GNHBbQpB23p1+b8L=Cg2gDkOz9h_EaWA22B+E+1ropA@mail.gmail.com>
Subject: Re: [PATCH 06/16] arch: remove tile port
To: Chris Metcalf <metcalf@alum.mit.edu>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 2:23 AM, Chris Metcalf <metcalf@alum.mit.edu> wrote:
> On 3/14/2018 10:36 AM, Arnd Bergmann wrote:
>>
>> The Tile architecture port was added by Chris Metcalf in 2010, and
>> maintained until early 2018 when he orphaned it due to his departure
>> from Mellanox, and nobody else stepped up to maintain it. The product
>> line is still around in the form of the BlueField SoC, but no longer
>> uses the Tile architecture.
>>
>> There are also still products for sale with Tile-GX SoCs, notably the
>> Mikrotik CCR router family. The products all use old (linux-3.3) kernels
>> with lots of patches and won't be upgraded by their manufacturers. There
>> have been efforts to port both OpenWRT and Debian to these, but both
>> projects have stalled and are very unlikely to be continued in the future.
>>
>> Given that we are reasonably sure that nobody is still using the port
>> with an upstream kernel any more, it seems better to remove it now while
>> the port is in a good shape than to let it bitrot for a few years first.
>
>
> Arnd, thanks for dealing with this.
>
> There are a number of tile-specific driver files that are mostly called out
> in the MAINTAINERS file.  I would expect you should also delete those.
>
>
> -F:    drivers/char/tile-srom.c
> -F:    drivers/edac/tile_edac.c
> -F:    drivers/net/ethernet/tile/
> -F:    drivers/rtc/rtc-tile.c
> -F:    drivers/tty/hvc/hvc_tile.c
> -F:    drivers/tty/serial/tilegx.c
> -F:    drivers/usb/host/*-tilegx.c
> -F:    include/linux/usb/tilegx.h

Right. I covered all of those in my follow-up driver series, see
https://lkml.org/lkml/2018/3/14/579

It's all in linux-next as of yesterday, but thanks for paying attention here.

       Arnd
