Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757586AbeD0IBJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:01:09 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:60739 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757544AbeD0IBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:01:07 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matthew Wilcox <willy@infradead.org>, David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-m68k <linux-m68k@vger.kernel.org>,
        Joanne Dow <jdow@earthlink.net>
Subject: Re: moving affs + RDB partition support to staging? (was: Re: Moving unmaintained filesystems to staging)
Date: Fri, 27 Apr 2018 10:01:04 +0200
Message-ID: <4119984.9IAShGbTL3@merkaba>
In-Reply-To: <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
References: <20180425154602.GA8546@bombadil.infradead.org> <1613268.lKBQxPXt8J@merkaba> <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven - 26.04.18, 13:08:
> On Thu, Apr 26, 2018 at 12:28 PM, Martin Steigerwald
> 
> <martin@lichtvoll.de> wrote:
> > You probably put your stick into a cave with ancient sleeping
> > dragons 
> > 
> > Added in linux-m68k mailing list, as they likely have an opinion on
> > how to treat affs + RDB partition support. Also added in Jens Axboe
> > about patching that RDB support broken with 2 TB or larger
> > harddisks issue which had been in Linux kernel for 6 years while a
> > patch exists that to my testing back then solves the issue.
[…]
> If there are bugs in the RDB parser that people run into, they should
> be fixed.
> If there are limitations in the RDB format on large disks, that's
> still not a reason to move it to staging (hi msdos partitioning!).

What I ran into was *not* a limitation in the RDB format, but a bug in 
the Linux implementation on it. After Joanne Dow´s change the 2 TB disk 
was detected and handled properly by Linux. Also AmigaOS 4.x handles 
those disks just well and I think also AmigaOS 3.1/3.5/3.9 supported 
them, but I am not sure on the details on that, it has been a long time 
since I last booted one of my Amiga systems.

Many classic Amiga users may not deal with such large disks, but AmigaOS 
4 users probably still, and some of them may run Linux on their PowerPC 
motherboards as well.

So I think the issue is worth fixing and am looking into submitting the 
fix, which looks pretty straight-forward to me upstream unless someone 
bets me to it.

Thanks,
-- 
Martin
