Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757231AbeEJL5f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:57:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757141AbeEJL5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:57:34 -0400
From: NeilBrown <neil@brown.name>
To: Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Date: Thu, 10 May 2018 21:57:20 +1000
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] mtd: spi-nor: honour max_message_size for spi-nor writes.
In-Reply-To: <cb612906-3d52-66cd-fbbc-7872bd2d9a92@gmail.com>
References: <87efj1kw9u.fsf@notabene.neil.brown.name> <20180509160240.23ef11f2@bbrezillon> <87vabwa2gm.fsf@notabene.neil.brown.name> <cb612906-3d52-66cd-fbbc-7872bd2d9a92@gmail.com>
Message-ID: <87mux7afkv.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, May 10 2018, Marek Vasut wrote:

> On 05/10/2018 12:28 AM, NeilBrown wrote:
>> On Wed, May 09 2018, Boris Brezillon wrote:
>>=20
>>> On Fri, 27 Apr 2018 16:18:05 +1000
>>> NeilBrown <neil@brown.name> wrote:
>>>
>>>> Hi,
>>>>  I've labeled this an RFC because I'm really not sure about removing t=
he
>>>>  error path from spi_nor_write() -- maybe that really matters.  But on
>>>>  my hardware, performing multiple small spi writes to the flash seems
>>>>  to work.
>>>>
>>>>  The spi driver is drivers/staging/mt7621-spi.  Possibly this needs to
>>>>  use DMA instead of a FIFO (assuming the hardware can) - or maybe
>>>>  drivers/spi/spi-mt65xx.c can be made to work on this hardware, though
>>>>  that is for an ARM SOC and mt7621 is a MIPS SOC.
>>>>
>>>>  I note that openwrt has similar patches:
>>>>   target/linux/generic/pending-4.14/450-mtd-spi-nor-allow-NOR-driver-t=
o-write-fewer-bytes-th.patch
>>>>
>>>>  They also change the spi driver to do a short write, rather
>>>>  than change m25p80 to request a short write.
>>>>
>>>>  Is there something horribly wrong with this?
>>>
>>> Marek, any opinion on this patch?
>>>
>>=20
>> Hi,
>>  thanks for following up.
>>  I have since found that I don't need this patch, though maybe others
>>  still do(??).
>>  My hardware can only send 36 bytes and receive 32 in a single
>>  transaction.  However I can run a sequence of transactions
>>  to process a whole message no matter how large that message is.  As
>>  long as I keep chip-select asserted, all the slave device sees is that
>>  the clock period isn't quite constant, and the slave shouldn't care
>>  much about that.
>>  When reading from flash, I found that handling large messages with
>>  multiple hardware transactions was 50% faster than breaking the
>>  read down into lots of 32 byte messages.
>>=20
>>  So, I won't object if this patch is forgotten.  Thanks for
>>  your time anyway.
>
> Nice, which hardware is that ?

Mediatek MT7621 SOC (particularly in the gnubee.org NAS platform).

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlr0M6AACgkQOeye3VZi
gbnc0RAAhISafBi98oeBGi78hzSdG7XP2fL2WJ5S+qeCJt9KdEA8u5BAtl1GsCE7
75mo3CEkgXQLhr6ynfsUbO5hVTkkVfokBUj/wfpXnpW0U9D1WBw4plDljMaW3pxG
72L3qotPapu6oQzZ/9xNFu01bnhKKojwA5htmLkn+Mbn6EBcPUIQQUIKPZGIa9LV
w8PJJ8tzHzIpZW/kbISgh/5cRyOc8I8+KvFVbsYvi4uXu0MDhslvW0Tx1sQTT8sn
VhUwG9i1C2jZRKZ8ahfxBHzF190CtPMzeWtYf/f71W31TWJ3JesImIwf9Q7ztFmW
hQDXKNBUN/3PA8Y8rMSpBOZr1gQSh3AettEy8DCpiGu0ZIzq+ovBm70JibHTL7xx
aft6Of1qwKL7J4zmQdi9wfpWomfafeAfX0UA2BnhG6CU5VwGocCfhXTeeFyB/RTP
Zn+oxJGW1CKpPjKWfhyxx7re4t3xan9oOZ9mK3JUJBdGeFnkiuVnk8Xy1fKy5wyh
P9ipUNQx4aMCD+nHL74aEgpR2Zjp9hZ4i/OqaVvlawDaroGbq/PqS/Ef9zClOnJ/
+NVOk/x+ggWSKAnSSqux+V8pXMiemYi0/4vdgc4e5KqsLOXWHIeCHeGyQc8KWQnR
q0YRE+iQYc0fuBPp0/w6/D/rQcJPEsEJeCad8RHQq77sIAYnAWE=
=Fsjg
-----END PGP SIGNATURE-----
--=-=-=--
