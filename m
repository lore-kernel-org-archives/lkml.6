Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeFESuq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:50:46 -0400
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:40109 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeFESup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:50:45 -0400
Subject: Re: building in 32bit chroot on x86_64 host broken
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
 <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org>
 <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
 <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org>
 <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
From: Thomas Backlund <tmb@mageia.org>
Message-ID: <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org>
Date: Tue, 5 Jun 2018 21:50:56 +0259
MIME-Version: 1.0
In-Reply-To: <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-WatchGuard-Spam-ID: str=0001.0A0C0202.5B16DB85.0103,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.194
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 2018-06-05 kl. 21:38, skrev Linus Torvalds:
> On Tue, Jun 5, 2018 at 11:23 AM Thomas Backlund <tmb@mageia.org> wrote:
>>    #
>> -# CONFIG_64BIT is not set
>>
>> So something _does_ strip away the needed config bit
> Why do you need it?
>
> I get
>
>    CONFIG_X86_32=y
>    CONFIG_X86=y
>
> and CONFIG_64BIT never gets set.
>
> It is true that I don't get the
>
>    # CONFIG_64BIT is not set
>
> line, but why do you care?
>
>              Linus

Because without it running the build in the 32bit chroot will get the 
initial reported issue:


$ uname -m
i686
$ make oldconfig
scripts/kconfig/conf  --oldconfig Kconfig
*
* Restart config...
*
*
* Linux/x86 4.17.0 Kernel Configuration
*
64-bit kernel (64BIT) [Y/n/?] (NEW)


which breaks our buildbots running in chroots...


Now I can work around it by adding the config bit myself, but I'd like 
to understand what changed and why...

--
Thomas
