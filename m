Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393A1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3B620852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3B620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbeGXC4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:56:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:56824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388295AbeGXC4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:56:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64245AD99;
        Tue, 24 Jul 2018 01:52:03 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Date:   Tue, 24 Jul 2018 11:51:49 +1000
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Cyrille Pitchen" <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCHv3 2/2] mtd: m25p80: restore the status of SPI flash when exiting
In-Reply-To: <20180724012226.307f578d@bbrezillon>
References: <20171206025342.7266-1-Zhiqiang.Hou@nxp.com> <20171206025342.7266-3-Zhiqiang.Hou@nxp.com> <20180723181350.GA58212@ban.mtv.corp.google.com> <20180723221002.736e0830@bbrezillon> <CAN8TOE904WXMScHo1b2jhusz-L8eGBK=gzUUX079ZVfiFk+HoQ@mail.gmail.com> <87in55po3a.fsf@notabene.neil.brown.name> <20180724012226.307f578d@bbrezillon>
Message-ID: <87fu09pfii.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24 2018, Boris Brezillon wrote:

> On Tue, 24 Jul 2018 08:46:33 +1000
> NeilBrown <neilb@suse.com> wrote:
>
>> On Mon, Jul 23 2018, Brian Norris wrote:
>>=20
>> > Hi Boris,
>> >
>> > On Mon, Jul 23, 2018 at 1:10 PM, Boris Brezillon
>> > <boris.brezillon@bootlin.com> wrote:=20=20
>> >> On Mon, 23 Jul 2018 11:13:50 -0700
>> >> Brian Norris <computersforpeace@gmail.com> wrote:=20=20
>> >>> I noticed this got merged, but I wanted to put my 2 cents in here:=
=20=20
>> >>
>> >> I wish you had replied to this thread when it was posted (more than
>> >> 6 months ago). Reverting the patch now implies making some people
>> >> unhappy because they'll have to resort to their old out-of-tree
>> >> hacks :-(.=20=20
>> >
>> > I'd say I'm sorry for not following things closely these days, but I'm
>> > not really that sorry. There are plenty of other capable hands. And if
>> > y'all shoot yourselves in the foot, so be it. This patch isn't going
>> > to blow things up, but now that I did finally notice it (because it
>> > happened to show up in a list of backports I was looking at), I
>> > thought better late than never to remind you.
>> >
>> > For way of notification: Marek already noticed that we've started down
>> > a slippery slope months ago:
>> >
>> > https://lkml.org/lkml/2018/4/8/141
>> > Re: [PATCH] mtd: spi-nor: clear Extended Address Reg on switch to
>> > 3-byte addressing.
>> >
>> > I'm not quite sure why that wasn't taken to its logical conclusion --
>> > that the hack should be reverted.
>> >
>> > This problem has been noted many times already, and we've always
>> > stayed on the side of *avoiding* this hack. A few references from a
>> > search of my email:
>> >
>> > http://lists.infradead.org/pipermail/linux-mtd/2013-March/046343.html
>> > [PATCH 1/3] mtd: m25p80: utilize dedicated 4-byte addressing commands
>> >
>> > http://lists.infradead.org/pipermail/barebox/2014-September/020682.html
>> > [RFC] MTD m25p80 3-byte addressing and boot problem
>> >
>> > http://lists.infradead.org/pipermail/linux-mtd/2015-February/057683.ht=
ml
>> > [PATCH 2/2] m25p80: if supported put chip to deep power down if not us=
ed
>> >=20=20
>> >>> On Wed, Dec 06, 2017 at 10:53:42AM +0800, Zhiqiang Hou wrote:=20=20
>> >>> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>> >>> >
>> >>> > Restore the status to be compatible with legacy devices.
>> >>> > Take Freescale eSPI boot for example, it copies (in 3 Byte
>> >>> > addressing mode) the RCW and bootloader images from SPI flash
>> >>> > without firing a reset signal previously, so the reboot command
>> >>> > will fail without reseting the addressing mode of SPI flash.
>> >>> > This patch implement .shutdown function to restore the status
>> >>> > in reboot process, and add the same operation to the .remove
>> >>> > function.=20=20
>> >>>
>> >>> We have previously rejected this patch multiple times, because the a=
bove
>> >>> comment demonstrates a broken product.=20=20
>> >>
>> >> If we were to only support working HW parts, I fear Linux would not
>> >> support a lot of HW (that's even more true when it comes to flashes :=
P).=20=20
>> >
>> > You stopped allowing UBI to attach to MLC NAND recently, no? That
>> > sounds like almost the same boat -- you've probably killed quite a few
>> > shitty products, if they were to use mainline directly.
>> >
>> > Anyway, that's derailing the issue. Supporting broken hardware isn't
>> > something you try to do by applying the same hack to all systems. You
>> > normally try to apply your hack as narrowly as possible. You seem to
>> > imply that below. So maybe that's a solution to move forward with. But
>> > I'd personally be just as happy to see the patch reverted.
>> >=20=20
>> >>> You cannot guarantee that all
>> >>> reboots will invoke the .shutdown() method -- what about crashes? Wh=
at
>> >>> about watchdog resets? IIUC, those will hit the same broken behavior,
>> >>> and have unexepcted behavior in your bootloader.=20=20
>> >>
>> >> Yes, there are corner cases that are not addressed with this approach=
,=20=20
>> >
>> > Is a system crash really a corner case? :D
>> >=20=20
>> >> but it still seems to improve things. Of course, that means the
>> >> user should try to re-route all HW reset sources to SW ones (RESET in=
put
>> >> pin muxed to the GPIO controller, watchdog generating an interrupt
>> >> instead of directly asserting the RESET output pin), which is not alw=
ays
>> >> possible, but even when it's not, isn't it better to have a setup that
>> >> works fine 99% of the time instead of 50% of the time?=20=20
>> >
>> > Perhaps, but not at the expense of future development. And
>> > realistically, no one is doing that if they have this hack. Most
>> > people won't even know that this hack is protecting them at all (so
>> > again, they won't try to mitigate the problem any further).
>> >=20=20
>> >>> I suppose one could argue for doing this in remove(), but AIUI you're
>> >>> just papering over system bugs by introducing the shutdown() function
>> >>> here. Thus, I'd prefer we drop the shutdown() method to avoid mislea=
ding
>> >>> other users of this driver.=20=20
>> >>
>> >> I understand your point. But if the problem is about making sure peop=
le
>> >> designing new boards get that right, why not complaining at probe time
>> >> when things are wrong?
>> >>
>> >> I mean, spi_nor_restore() seems to only do something on very specific
>> >> NORs (those on which a SW RESET does not resets the addressing
>> >> mode).=20=20
>> >
>> > The point isn't that SW RESET doesn't reset the addressing mode -- it
>> > does on any flash I've seen. The point is that most systems are built
>> > around a stateless assumption in these flash. IIRC, there wasn't even
>> > a SW RESET command at all until these "huge" flash came around and
>> > stateful addressing modes came about. So boot ROMs and bootloaders
>> > would have to be updated to start figuring out when/how to do this SW
>> > RESET. And once two vendors start doing it differently (I'm not sure:
>> > have they done this already? I think so) it's no longer something a
>> > boot ROM will get right.
>> >
>> > The only way to get this stuff right is to have a hardware reset, or
>> > else to avoid all of the stateful modes in software.
>> >=20=20
>> >> So, how about adding a flag that says "my board has the NOR HW
>> >> RESET pin wired" (there would be a DT props to set that flag). Then y=
ou
>> >> add a WARN_ON() when this flag is not set and a NOR chip impacted by
>> >> this bug is detected.=20=20
>> >
>> > I'd kinda prefer the reverse. There really isn't a need to document
>> > anything for a working system (software usually can't control this
>> > RESET pin). The burden should be on the b0rked system to document
>> > where it needs unsound hacks to survive.
>> >=20=20
>> >> This way you make sure people are informed that
>> >> they're doing something wrong, and for those who can't change their HW
>> >> (because it's already widely deployed), you have a fix that improve
>> >> things.=20=20
>> >
>> > Or even better: put this hack behind a DT flag, so that one has to
>> > admit that their board design is broken before it will even do
>> > anything. Proposal: "linux,badly-designed-flash-reset".
>> >
>> > But, I'd prefer just (partially?) reverting this, and let the authors
>> > submit something that works. We're not obligated to keep bad hacks in
>> > the kernel.
>> >
>> > Brian=20=20
>>=20
>> One possibility that occurred to me when I was exploring this issue is
>> to revert to 3-byte mode whenever 4-byte was not actively in use.
>> So any access beyond 16Meg is:
>>  switch-to-4-byte ; perform IO ; switch to 3-byte
>> or similar.  On my hardware it would be more efficient to
>> use the 4-byte opcode to perform the IO, then reset the cached
>> 4th address byte that the NOR chip transparently remembered.
>>=20
>> This adds a little overhead, but should be fairly robust.
>> It doesn't help if something goes terribly wrong while IO is happening,
>> but I don't think any other software solution does either.
>>=20
>> How would you see that approach?
>
> I think the problem stands: people that have proper HW mitigation for
> this problem (NOR chip is reset when the Processor is reset) don't want
> to pay the overhead. So, even if we go for this approach, we probably
> want to only do that for broken HW.

I agree that a "my-hardware-is-suboptimal" flag is appropriate.
I was addressing the suggestion that the current approach doesn't handle
all corner cases and was suggesting a different approach that might
handle more corner-cases.  I should have been more explicit about that.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltWhjUACgkQOeye3VZi
gblijhAApzxhwMyQiNozZdNPcjamxTeQtKQsT0D6DQ1Gxok3D+38aEk/UXS20Vpv
ThyL19XtP2iVFkkTlfT7ngHvWS9E0rrkpb2/yofaZYBiE8LFKGxfPkIdfYPT9Hlz
ozGQ1WCBRS8sMNfswmfa1UTl0agw4AtyfZa7WzlYCfUhWKs2AKxOwXwTfV/IF/RY
aNGIC8Xut0rMU9qmzPAFNfVxWyPK4GlP3SK+1DiDp0cjPZTq9acnIXvLgzekB/A5
avVlLOUGCMjzLS/zIQYa+dDlYDAwY6kVjcG59gYHM6dtQt/weknweNXlfeRcXwc5
LzLsD/uKWn/JNpZaRGNhgvAPN/nXVRFfPsrRENTZWFOAvM0HrBzqVJXO7jRK0imN
Bonlzhl09z/mDu8zccyeIAPToIdIC63mxL6lSwHOmijoSvO2ydcODmY5KA9w5gef
/cNny4JY3maW9L1Q/MmsOWxJRSr8LbqP/Jc4gjRi/VFsKVSrFz/lBZuu0adHhqQY
Mz/faiuKlAq4+rSnNwh2OjNoFcnP8lh6qtqI/bVw9A21zKXgYE9qlrwEMA5yKUOU
T/Q8dyP8Y2oHq9PEiNen3TQkEaZ5uUW8R12IAiDriWjk8rb1n6bMC6DawhdKJqTi
MRTNMuBsFjciyAiuQIvIpuClt7uauaPH4TPbMQFMSinp56ZU4PI=
=lK2I
-----END PGP SIGNATURE-----
--=-=-=--
