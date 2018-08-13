Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D5C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8183A214ED
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8183A214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbeHMSn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:43:59 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45180 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMSn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:43:59 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5C69C72CCFD;
        Mon, 13 Aug 2018 19:01:06 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 5131C7CC7A1; Mon, 13 Aug 2018 19:01:06 +0300 (MSK)
Date:   Mon, 13 Aug 2018 19:01:06 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uapi: fix linux/usb/audio.h userspace compilation error
Message-ID: <20180813160106.GA22902@altlinux.org>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
        Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180813154651.GB22820@altlinux.org>
 <s5hh8jy5kia.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <s5hh8jy5kia.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2018 at 05:55:25PM +0200, Takashi Iwai wrote:
> On Mon, 13 Aug 2018 17:46:51 +0200, Dmitry V. Levin wrote:
> >=20
> > Replace NULL with 0 in uac_mixer_unit_bmControls() to fix the following
> > linux/usb/audio.h userspace compilation error:
> >=20
> > /usr/include/linux/usb/audio.h: In function 'uac_mixer_unit_bmControls':
> > /usr/include/linux/usb/audio.h:304:10: error: 'NULL' undeclared (first =
use in this function)
> >    return NULL;
> >=20
> > Fixes: 6cfd839ae78e ("ALSA: usb-audio: UAC3. Add support for mixer unit=
=2E")
> > Cc: <stable@vger.kernel.org> # v4.18
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>=20
> Hrm, can we include the standard header for definition of NULL
> instead?  It's way too ugly to use 0 just for that.

It's fine to return 0 as a null pointer.  If you prefer NULL,
please include a header that won't break userspace,
or just move the function out of UAPI.

Thanks,


--=20
ldv

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbcatCAAoJEAVFT+BVnCUIEi8P/3b9OIPQUls69/JRacILmsmT
vh+Wd/BsX0vVfli0jQIyzG1BzsJu5234BDkfjpgFLs7ptv+b6KjpdK6PpJCeOfZ8
QyF2diQPikT7xiYJ4MQPFULtf/v9LbzL5s/AlcQuxouttighjEUFis0BaO1i29Dl
UEnjpTv7aJAU+HupSNfJoX19rKWg513T4bmi+E13SHzpgUHDbzqHSjqvTjb2DWFw
goXgs875ENYD/z2o8rLT3e8kjYkFqheIayZ25eTZhU9Zxs78EVAcXkB8+d20jQoh
S4pm1GZFL/Cwb/KB/DjqxUNTIx+QipMfRhF20kWFtOX6UCBc8u0h5M5lmqW06n9Z
1JiszMi92v2+uZj5D3wQZr3jcjZY+Vwgyz46skHNp/1tpdFN+SG/tfkRkA4aNXSt
MrrBvbo6seHppnhDZUXmJZQFcD7aCjnnvYeS+0We6hYgqjCnoJrtyop9XDDepYOh
g1nnLzZl4+3jb7UsRHGw0PRgOCxox/brtkSFzEfOWEQyn4W5PYK3bBMGwbP7wVxt
xwkzTcDS5mSBEg9lLaiCk15lcvrFlY5FsgmmbOGN5eStL5gsN3Ie8h78Bpe6iyVj
799Q435EdY/WLLbCt93JAcwMKe8isnzlmC3Zw8oAKvFL4AKsFJiG1JP+ADEfeV+U
IezRXVHyG0UfXvL7a1BG
=7uHi
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
