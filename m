Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeEGUuG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:50:06 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:42314 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752934AbeEGUuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:50:04 -0400
X-Google-Smtp-Source: AB8JxZohu2zId+/NaxUxmG4aOgxQ83w3JTnquCdzfORnTqjj2n2HzngMP7AyoMpLFp4Rz+Zs5Zc0MtQ77lXzs4qNp70=
MIME-Version: 1.0
In-Reply-To: <4217788.NhxQeTpgEt@merkaba>
References: <20180425154602.GA8546@bombadil.infradead.org> <20180507021554.GN30522@ZenIV.linux.org.uk>
 <CAOmrzkLAm99UTkzV0n+rtLg4XTrxHrCkR1ccitsyhf6XLztkpA@mail.gmail.com> <4217788.NhxQeTpgEt@merkaba>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Tue, 8 May 2018 08:50:03 +1200
Message-ID: <CAOmrzkJ-ao=ACUTw9NK-77s2geXL4bpT-EWMO1YnAx9sC4ORZw@mail.gmail.com>
Subject: Re: moving affs + RDB partition support to staging?
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>, David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Debian m68k <debian-68k@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

On Mon, May 7, 2018 at 7:08 PM, Martin Steigerwald <martin@lichtvoll.de> wrote:
> Michael Schmitz - 07.05.18, 04:40:
>> Al,
>>
>> I don't think there is USB sticks with affs on them as yet. There
>> isn't even USB host controller support for Amiga hardware (yet).
>>
>> Last I tried USB on m68k (Atari, 060 accelerator) the desktop
>> experience was such that I'd rather not repeat that in a hurry (and
>> that was a simple FAT USB stick).
>
> There is USB support available on Amiga since a long time.

Good to hear that. I stand corrected.

> On "Classic" Amigas AmigaOS 3.x with Poseidon USB stack + some USB card.

Haven't seen a Linux driver for that 'some USB card' yet.

> On AmigaOS 4.x built-in. AmigaOS 4.x hardware like Sam boards from Acube
> Systems have USB controllers that work out of the bux.

Forgot about the new (non-m68k) hardware. My focus is somewhat narrow,
on m68k and Linux.

> And I am pretty sure, you can also tell it to use Amiga Fast Filesystem
> (on Linux affs) on an USB stick. Also you can plug in an external
> harddisk with RDB partitions and whatever filesystems you wish.

I already conceded that's possible.

So our problem with the bug Al spotted, and AFFS on USB media are twtofold:

AmigaOS:
Exploitable: yes (unless the AmigaOS AFFS driver detects and mitigates this).
Likelihood: low (as Joanne said there are easier ways to do harm to
these systems)

Linux:
Exploitable: yes, except on hardware that doesn't have USB hardware support.
Likelihood: high

Can we blacklist affs from being autoloaded through udev on USB
storage media discovery?

Cheers,

  Michael
