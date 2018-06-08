Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FfBzKJq3Glv7OAAAmS7hNA
	; Fri, 08 Jun 2018 17:08:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4201F607E4; Fri,  8 Jun 2018 17:08:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 833ED601D2;
	Fri,  8 Jun 2018 17:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 833ED601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeFHRII (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:08:08 -0400
Received: from anholt.net ([50.246.234.109]:40140 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752411AbeFHRIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:08:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D4FE910A1860;
        Fri,  8 Jun 2018 10:08:04 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ImP5RkL9H6_f; Fri,  8 Jun 2018 10:08:03 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B502710A01F9;
        Fri,  8 Jun 2018 10:08:03 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id E89062FE462E; Fri,  8 Jun 2018 10:08:02 -0700 (PDT)
From: Eric Anholt <eric@anholt.net>
To: Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/v3d: Add a note about locking of v3d_fence_create().
In-Reply-To: <1528453446.26356.12.camel@pengutronix.de>
References: <20180605190302.18279-1-eric@anholt.net> <20180605190302.18279-3-eric@anholt.net> <1528453446.26356.12.camel@pengutronix.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Fri, 08 Jun 2018 10:08:02 -0700
Message-ID: <87vaatxl3h.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lucas Stach <l.stach@pengutronix.de> writes:

> Am Dienstag, den 05.06.2018, 12:03 -0700 schrieb Eric Anholt:
>> This isn't the first time I've had to argue to myself why the '++' was
>> safe.
>
> And now you need to do the same thing with me...
>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>> =C2=A0drivers/gpu/drm/v3d/v3d_fence.c | 3 +++
>> =C2=A01 file changed, 3 insertions(+)
>>=20
>> diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_f=
ence.c
>> index bfe31a89668b..6265e9ab4a13 100644
>> --- a/drivers/gpu/drm/v3d/v3d_fence.c
>> +++ b/drivers/gpu/drm/v3d/v3d_fence.c
>> @@ -3,6 +3,9 @@
>> =C2=A0
>> =C2=A0#include "v3d_drv.h"
>> =C2=A0
>> +/* Note that V3D fences are created during v3d_job_run(), so we're
>> + * already implictly locked.
>> + */
> I don't see where you would be locked in the job_run path. I think what
> you mean is that this path needs no locks, as it is driven by a single
> scheduler thread, right?

Yeah, it's only called from run_job, and run_job can't reenter.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlsat/IACgkQtdYpNtH8
nug0mQ/+IMSetfCyvK+L46SrA8It0CnDp54NK9KeuBk/mjj6CbZG0Ej/Savq5mJN
xJZSDNx6uMYSe4gpOwlfD8qzAWtXtFf3H8RJMx1ijqRet42e6v6oDHY3y3C/2LtN
A4sopkjFut7hGdVvahwvR/HiVFO8SSpVPS+HPWlgRECoYAYCc1/9hnYxq+XELCK6
1ux3ekduqDcDZ/WOTNa3VY0Hr2aDFkKyTYeULkGtamh57IXso3RN7rYnuXuE29Yd
T3NehonlofNVjhcHau6VEknCaki+lsQjJ5owXgL/Q61HBFMIzdXA3cK5Q2G84Rew
6Gmo9//vBUfvhg/Dt2rO8ul+N1VvLz77UTUHMdEo3FdfaKGSsIRY2xosBQ268RCk
g48sKpw90rH3G0Wa0Dc2ycp20c9m0EJXq7rTUD7uSCDzfB3NicVONKATBRTVRw6T
FtNH4FYi8HzeQS9ydK7tXVlDc4y5YUHCTIo6kbqVlwZLUXSDgZOljzBlQZWwjdc/
9Elgs3noZeZMytbR9Kv8FYCvjgqFH6lT8MfR3XL3H3RBJxp0+ufHw7TjOy5TgCLC
TGwr/aKWiQRmgBl1AtYx4Q7c+KhHWyEQ20TmCmQmlF6BMNLnQHbeRa+XaXHvzD5N
W7l4ltptfQzvMFto2KMPJja8gGB94oJHsnhp9Bv+BVYWVz2wD38=
=5GKX
-----END PGP SIGNATURE-----
--=-=-=--
