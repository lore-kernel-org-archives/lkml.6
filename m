Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbeEFIk5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 04:40:57 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:47027 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750981AbeEFIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 04:40:55 -0400
Subject: Re: moving affs + RDB partition support to staging?
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, dsterba@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-m68k@vger.kernel.org,
        Debian m68k <debian-68k@lists.debian.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org> <1613268.lKBQxPXt8J@merkaba>
 <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
 <20180506005946.GI30522@ZenIV.linux.org.uk>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <a0d2e079-275a-b275-e70f-5fe822b4060a@physik.fu-berlin.de>
Date: Sun, 6 May 2018 10:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180506005946.GI30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 85.182.115.218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2018 02:59 AM, Al Viro wrote:
>> There is nothing at the moment that needs fixing.
> 
> Funny, that...  I'd been going through the damn thing for the
> last week or so; open-by-fhandle/nfs export support is completely
> buggered.  And as for the rest... the least said about the error
> handling, the better - something like rename() hitting an IO
> error (read one) can not only screw the on-disk data into the
> ground, it can do seriously bad things to kernel data structures.

Well, yes, there are certainly things in the affs code that can cause
unexpected behavior. But that wasn't my point. My point was that the
purpose for what people are using the affs driver in the kernel, it's
doing its job perfectly fine.

The standard use case is either to run Debian m68k on an Amiga and
access the Amiga partitions through Linux for simple file transfers
between the two operating systems, e.g. copying a new kernel plus
newly generated initrd to the affs boot partition of AmigaOS.

Or, just reading data off an old Amiga harddisk or floppy disk by
either attaching the disk to the Linux machine directly or reading
the contents of a floppy disk with an advanced floppy disk controller
like the Catweasel or KryoFlux.

For both cases, I haven't run into any issues with the affs driver
and I also haven't heard of complaints from anyone in communities
like EAB Amiga, amiga.org, a1k.org etc. That doesn't mean that people
haven't run into issues, of course. I'm just saying I haven't heard
of any.

> Is there anything resembling fsck for that thing, BTW?  Nevermind
> the repairs, just the validity checks would be nice...

Not that I know of.

Adrian

PS: Even Matthew Garrett seems to be a Linux/m68k fan:

    > https://twitter.com/mjg59/status/945779704329629697

    :)

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
