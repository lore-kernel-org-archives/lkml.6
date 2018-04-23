Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754348AbeDWI2i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:28:38 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46176 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754045AbeDWI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:28:33 -0400
X-Google-Smtp-Source: AIpwx4+Ya1QU/MJ5/Qj+dAp6jf6Nqq4EqnC4wSrDqF6BCaz9fwbi8pjkIwbB4TO8arRx0ZB/r8/0xQjH6fE57EkRbYs=
MIME-Version: 1.0
In-Reply-To: <20180423081114.1813726-3-arnd@arndb.de>
References: <20180423081114.1813726-1-arnd@arndb.de> <20180423081114.1813726-3-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Apr 2018 10:28:31 +0200
X-Google-Sender-Auth: ZVY2UI57hL_qMZlx0rZq1S0YVCA
Message-ID: <CAK8P3a30fo0mviQMgg3OXivbVCkC9vBp2R7NfuLKq=si_O0X_w@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc: use time64_t in read_persistent_clock
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vitaly Bordug <vitb@kernel.crashing.org>,
        Geoff Levand <geoff@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> @@ -170,7 +170,6 @@ unsigned long __init maple_get_boot_time(void)
>         request_resource(&ioport_resource, &rtc_iores);
>
>         maple_get_rtc_time(&tm);
> -       return mktime(tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday,
> -                     tm.tm_hour, tm.tm_min, tm.tm_sec);
> +       return rtc_tm_to_time66(&tm);
>  }

No, it's not rtc_tm_to_time66 ;(

I did some build testing over the weekend to make sure I find all the stupid
bugs, but then sent out the version without the two fixes. Please ignore all
five patches, will follow up with v2 that fixes this one and another equally
trivial bug.

       Arnd
