Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F6FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C81620852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C81620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbeGWXuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:50:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:33112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388179AbeGWXuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:50:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16BD1AE8F;
        Mon, 23 Jul 2018 22:46:44 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Date:   Tue, 24 Jul 2018 08:46:33 +1000
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-mtd@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCHv3 2/2] mtd: m25p80: restore the status of SPI flash when exiting
In-Reply-To: <CAN8TOE904WXMScHo1b2jhusz-L8eGBK=gzUUX079ZVfiFk+HoQ@mail.gmail.com>
References: <20171206025342.7266-1-Zhiqiang.Hou@nxp.com> <20171206025342.7266-3-Zhiqiang.Hou@nxp.com> <20180723181350.GA58212@ban.mtv.corp.google.com> <20180723221002.736e0830@bbrezillon> <CAN8TOE904WXMScHo1b2jhusz-L8eGBK=gzUUX079ZVfiFk+HoQ@mail.gmail.com>
Message-ID: <87in55po3a.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, Jul 23 2018, Brian Norris wrote:

> Hi Boris,
>
> On Mon, Jul 23, 2018 at 1:10 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
>> On Mon, 23 Jul 2018 11:13:50 -0700
>> Brian Norris <computersforpeace@gmail.com> wrote:
>>> I noticed this got merged, but I wanted to put my 2 cents in here:
>>
>> I wish you had replied to this thread when it was posted (more than
>> 6 months ago). Reverting the patch now implies making some people
>> unhappy because they'll have to resort to their old out-of-tree
>> hacks :-(.
>
> I'd say I'm sorry for not following things closely these days, but I'm
> not really that sorry. There are plenty of other capable hands. And if
> y'all shoot yourselves in the foot, so be it. This patch isn't going
> to blow things up, but now that I did finally notice it (because it
> happened to show up in a list of backports I was looking at), I
> thought better late than never to remind you.
>
> For way of notification: Marek already noticed that we've started down
> a slippery slope months ago:
>
> https://lkml.org/lkml/2018/4/8/141
> Re: [PATCH] mtd: spi-nor: clear Extended Address Reg on switch to
> 3-byte addressing.
>
> I'm not quite sure why that wasn't taken to its logical conclusion --
> that the hack should be reverted.
>
> This problem has been noted many times already, and we've always
> stayed on the side of *avoiding* this hack. A few references from a
> search of my email:
>
> http://lists.infradead.org/pipermail/linux-mtd/2013-March/046343.html
> [PATCH 1/3] mtd: m25p80: utilize dedicated 4-byte addressing commands
>
> http://lists.infradead.org/pipermail/barebox/2014-September/020682.html
> [RFC] MTD m25p80 3-byte addressing and boot problem
>
> http://lists.infradead.org/pipermail/linux-mtd/2015-February/057683.html
> [PATCH 2/2] m25p80: if supported put chip to deep power down if not used
>
>>> On Wed, Dec 06, 2017 at 10:53:42AM +0800, Zhiqiang Hou wrote:
>>> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>> >
>>> > Restore the status to be compatible with legacy devices.
>>> > Take Freescale eSPI boot for example, it copies (in 3 Byte
>>> > addressing mode) the RCW and bootloader images from SPI flash
>>> > without firing a reset signal previously, so the reboot command
>>> > will fail without reseting the addressing mode of SPI flash.
>>> > This patch implement .shutdown function to restore the status
>>> > in reboot process, and add the same operation to the .remove
>>> > function.
>>>
>>> We have previously rejected this patch multiple times, because the above
>>> comment demonstrates a broken product.
>>
>> If we were to only support working HW parts, I fear Linux would not
>> support a lot of HW (that's even more true when it comes to flashes :P).
>
> You stopped allowing UBI to attach to MLC NAND recently, no? That
> sounds like almost the same boat -- you've probably killed quite a few
> shitty products, if they were to use mainline directly.
>
> Anyway, that's derailing the issue. Supporting broken hardware isn't
> something you try to do by applying the same hack to all systems. You
> normally try to apply your hack as narrowly as possible. You seem to
> imply that below. So maybe that's a solution to move forward with. But
> I'd personally be just as happy to see the patch reverted.
>
>>> You cannot guarantee that all
>>> reboots will invoke the .shutdown() method -- what about crashes? What
>>> about watchdog resets? IIUC, those will hit the same broken behavior,
>>> and have unexepcted behavior in your bootloader.
>>
>> Yes, there are corner cases that are not addressed with this approach,
>
> Is a system crash really a corner case? :D
>
>> but it still seems to improve things. Of course, that means the
>> user should try to re-route all HW reset sources to SW ones (RESET input
>> pin muxed to the GPIO controller, watchdog generating an interrupt
>> instead of directly asserting the RESET output pin), which is not always
>> possible, but even when it's not, isn't it better to have a setup that
>> works fine 99% of the time instead of 50% of the time?
>
> Perhaps, but not at the expense of future development. And
> realistically, no one is doing that if they have this hack. Most
> people won't even know that this hack is protecting them at all (so
> again, they won't try to mitigate the problem any further).
>
>>> I suppose one could argue for doing this in remove(), but AIUI you're
>>> just papering over system bugs by introducing the shutdown() function
>>> here. Thus, I'd prefer we drop the shutdown() method to avoid misleading
>>> other users of this driver.
>>
>> I understand your point. But if the problem is about making sure people
>> designing new boards get that right, why not complaining at probe time
>> when things are wrong?
>>
>> I mean, spi_nor_restore() seems to only do something on very specific
>> NORs (those on which a SW RESET does not resets the addressing
>> mode).
>
> The point isn't that SW RESET doesn't reset the addressing mode -- it
> does on any flash I've seen. The point is that most systems are built
> around a stateless assumption in these flash. IIRC, there wasn't even
> a SW RESET command at all until these "huge" flash came around and
> stateful addressing modes came about. So boot ROMs and bootloaders
> would have to be updated to start figuring out when/how to do this SW
> RESET. And once two vendors start doing it differently (I'm not sure:
> have they done this already? I think so) it's no longer something a
> boot ROM will get right.
>
> The only way to get this stuff right is to have a hardware reset, or
> else to avoid all of the stateful modes in software.
>
>> So, how about adding a flag that says "my board has the NOR HW
>> RESET pin wired" (there would be a DT props to set that flag). Then you
>> add a WARN_ON() when this flag is not set and a NOR chip impacted by
>> this bug is detected.
>
> I'd kinda prefer the reverse. There really isn't a need to document
> anything for a working system (software usually can't control this
> RESET pin). The burden should be on the b0rked system to document
> where it needs unsound hacks to survive.
>
>> This way you make sure people are informed that
>> they're doing something wrong, and for those who can't change their HW
>> (because it's already widely deployed), you have a fix that improve
>> things.
>
> Or even better: put this hack behind a DT flag, so that one has to
> admit that their board design is broken before it will even do
> anything. Proposal: "linux,badly-designed-flash-reset".
>
> But, I'd prefer just (partially?) reverting this, and let the authors
> submit something that works. We're not obligated to keep bad hacks in
> the kernel.
>
> Brian

One possibility that occurred to me when I was exploring this issue is
to revert to 3-byte mode whenever 4-byte was not actively in use.
So any access beyond 16Meg is:
 switch-to-4-byte ; perform IO ; switch to 3-byte
or similar.  On my hardware it would be more efficient to
use the 4-byte opcode to perform the IO, then reset the cached
4th address byte that the NOR chip transparently remembered.

This adds a little overhead, but should be fairly robust.
It doesn't help if something goes terribly wrong while IO is happening,
but I don't think any other software solution does either.

How would you see that approach?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltWWskACgkQOeye3VZi
gbnB0g/8DU9/hDtAgTwT1qn69i8hoBgiAb0zOo7IMTAfFvgcp1z3rm0+WkLCHQis
/xjD6gl8xDhVROs6fb4Ig3zfVxz5F+jKN7pvaLKfSpekVtdyYyI/tm42SRWAZJ8z
UifD+qhTxBlIejiLWlar2Fjt9WRZY4WhmbETRVBfcOHpGiBN8cCDeF7Wt6WR0zHt
H82XhK2Ay6LEgmDErCrSXkrvDh/viTvu8EdEx4+iItCo75bOK46EKLBbUvPQJLNR
lYCilAIQXABMNeEp9YzJKiRCcXlXFsWe+ksEIV0p9f6zWDB5s8Af48t3cO2hlw7U
HNDIzcXEDh/S01qa3Rrkx5alalB5505lR1+1SlyKynKliZ3WJn27oVey1soP3SOT
rF5GCH3zBZRtrYUFle4KkCu8TIVk5OaayHhIP/kJa3OcXSPfl2x/liCCP/lCKFdo
8K484nkjcvqB+FQa8thvleZnluG+iGa8GQm1ghHsNlGZ7B+PoTTIeWvGQv9glawQ
WGitHhEo0Bfu7/fQMuh6BB9YDhs7hiINtYZWmM2bC7J9wDwLefntvx9LyZcZ6NTK
P7E4bXs/TCNNslLXkOJctUU1/BtK4LIFDFj4q0MAFoH818jazX8DeSTrgDcKgiAx
FYtXSmQeOrj/WENdYo7ZXEo8EC/aVFL9Gl7ZGvC07v7A6VIPjSE=
=shdW
-----END PGP SIGNATURE-----
--=-=-=--
