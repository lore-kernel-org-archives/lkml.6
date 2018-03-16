Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeCPBaw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 21:30:52 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42492 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751497AbeCPBau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 21:30:50 -0400
X-AuditID: 12074414-ebbff70000000aea-be-5aab1ca38e13
Subject: Re: [PATCH 06/16] arch: remove tile port
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <20180314143656.1495602-1-arnd@arndb.de>
 <20180314143656.1495602-6-arnd@arndb.de>
From: Chris Metcalf <metcalf@alum.mit.edu>
Message-ID: <2f2e0cd4-02ca-0e01-7003-e519a7706ee4@alum.mit.edu>
Date: Thu, 15 Mar 2018 21:23:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314143656.1495602-6-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqLtYZnWUwZYzGhZ/Jx1jt5j9Xtmi
        Y9dXFovLu+awObB4/P41idHj4LlzjB6fN8kFMEdx2aSk5mSWpRbp2yVwZez+/Y+1YC93Rc/a
        x2wNjFs4uxg5OSQETCTunTjF1MXIxSEksINJYt+OH4wQzk0miXXLz7KAVAkLGEq8638JVMXB
        ISJgK3Hpvy9ImFkgWeLyv72sEPVdjBI77/eygSTYBLQk7uzsYwWxeQXsJZZMOMEOYrMIqEoc
        unGWGcQWFYiVaHn4jAmiRlDi5MwnYLs4BUwlTm9+ygSxwExi3uaHzBC2vETz1tlQtrjErSfz
        mSYwCsxC0j4LScssJC2zkLQsYGRZxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6
        iRES3CI7GI+clDvEKMDBqMTDm9G8KkqINbGsuDL3EKMkB5OSKG/Ka6AQX1J+SmVGYnFGfFFp
        TmrxIUYJDmYlEV7/Z0A53pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUwWRkODiUJ
        XhlgFAsJFqWmp1akZeaUIKSZODhBhvMADS+WBqrhLS5IzC3OTIfIn2LU5bjx4nUbsxBLXn5e
        qpQ47xuQIgGQoozSPLg5sKT0ilEc6C1hXlGQKh5gQoOb9ApoCRPQksxtK0CWlCQipKQaGCWO
        2RTOdtnI2Lxkm3hfeubXx54u4j7Z7TUNR3r+pC00vjf56Kz84lPlZnPiQiQd/s87zLtyddw2
        t5M7J00q4Op5y/eJk5PHh2P/X64WhvWHOEO/F9xLv/a+WevdmiiRI9nbjHZ+S0ycahqtZ9G4
        sUgoSmjDaunfB+pPHprnti73YqqXs9f/CiWW4oxEQy3mouJEAD3kF44lAwAA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/2018 10:36 AM, Arnd Bergmann wrote:
> The Tile architecture port was added by Chris Metcalf in 2010, and
> maintained until early 2018 when he orphaned it due to his departure
> from Mellanox, and nobody else stepped up to maintain it. The product
> line is still around in the form of the BlueField SoC, but no longer
> uses the Tile architecture.
>
> There are also still products for sale with Tile-GX SoCs, notably the
> Mikrotik CCR router family. The products all use old (linux-3.3) kernels
> with lots of patches and won't be upgraded by their manufacturers. There
> have been efforts to port both OpenWRT and Debian to these, but both
> projects have stalled and are very unlikely to be continued in the future.
>
> Given that we are reasonably sure that nobody is still using the port
> with an upstream kernel any more, it seems better to remove it now while
> the port is in a good shape than to let it bitrot for a few years first.

Arnd, thanks for dealing with this.

There are a number of tile-specific driver files that are mostly called out
in the MAINTAINERS file.  I would expect you should also delete those.

-F:    drivers/char/tile-srom.c
-F:    drivers/edac/tile_edac.c
-F:    drivers/net/ethernet/tile/
-F:    drivers/rtc/rtc-tile.c
-F:    drivers/tty/hvc/hvc_tile.c
-F:    drivers/tty/serial/tilegx.c
-F:    drivers/usb/host/*-tilegx.c
-F:    include/linux/usb/tilegx.h

Chris
