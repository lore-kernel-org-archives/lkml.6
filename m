Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1744637-1517690133-2-10077636091454249290
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517690132; b=pWhK21t2YPwtPkdHu5LbroaNt5O95URY/SD5Xr2T/s0XsOv
    +qOfrmeZQdcDttmcfuvJqxTjLBCZNC++oBWuT6ppcIquHqM7pJgR0pVcV0Wc1SnU
    6R6dNUiBVzqz/vIBxa9Kd6L3V2tLbEoXS7S3z1sJjEBEKh/QgyJNKlB5FR2llA0k
    r5rXy9DUef0Jhs4gr32U2rO/MwdO2VMLsoIZ3fWlNSIaaK0WixwNqYY1+uq9ft6D
    WpVpPBWw946PJ6+BDmetioJih4FQF5QQ9xb3FPVaWo6tO3MM03xTV8KjMPr2GZ9q
    pWd8ndYgbkit7vJP04bY8xslzGqK7MJaQNyE85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517690132; bh=517bGViOLzjHvKs/iLnK+wcviF
    Opa2O4vQ1UgdrRNBA=; b=AC6FnUlh9FTIfsrVd6j93QESNxVR5/JLaqpcjA6W9Z
    Xj7kCrmWpD1ERoyCXSJU+XZgms8Es5DMqQjxyWMiBISXtTyg1XvcSRqRN6DEkg2l
    CwpfiVLPqp3rIIg9TufHUvKpO9/lHSHyz2867XmPlCqLz/7ipsFMNpO5cRAwWSYf
    clFpmNxiDsunnms6S2SPjYr6Uxri1VUdspsT7xU9PRweVKzKYbrRrSBjplh00i+c
    6f6nGSUWVVdUF8LzKVBg4XyflGDrvAhIdWpAeq6rqwCEwn/OMiPoUUsXKYHPHCTD
    gTouZhXQB81FuHv0Odwoh5bfXHFdwxOoqv4Azi/+fpMg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753692AbeBCUf3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 15:35:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59551 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753374AbeBCUf2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 15:35:28 -0500
Date: Sat, 3 Feb 2018 21:35:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Message-ID: <20180203203525.GA5860@amd>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20180203180015.29073-65-alexander.levin@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-02-03 18:00:59, Sasha Levin wrote:
> From: Matthieu CASTET <matthieu.castet@parrot.com>
>=20
> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
>=20
> With the current code, the following sequence won't work :
> echo timer > trigger
>=20
> echo 0 >  delay_off
> * at this point we call
> ** led_delay_off_store
> ** led_blink_set
> *** stop timer
> ** led_blink_setup
> ** led_set_software_blink
> *** if !delay_on, led off
> *** if !delay_off, set led_set_brightness_nosleep <--- LED_BLINK_SW is se=
t but timer is stop
> *** otherwise start timer/set LED_BLINK_SW flag
>=20
> echo xxx > brightness
> * led_set_brightness
> ** if LED_BLINK_SW
> *** if brightness=3D0, led off
> *** else apply brightness if next timer <--- timer is stop, and will neve=
r apply new setting
> ** otherwise set led_set_brightness_nosleep
>=20
> To fix that, when we delete the timer, we should clear LED_BLINK_SW.

Can you run the tests on the affected stable kernels? I have feeling
that the problem described might not be present there.

Thanks,
								Pavel

> Cc: linux-leds@vger.kernel.org
> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  drivers/leds/led-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index ef1360445413..af630c11c284 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -187,7 +187,7 @@ void led_blink_set(struct led_classdev *led_cdev,
>  		   unsigned long *delay_on,
>  		   unsigned long *delay_off)
>  {
> -	del_timer_sync(&led_cdev->blink_timer);
> +	led_stop_software_blink(led_cdev);
> =20
>  	clear_bit(LED_BLINK_ONESHOT, &led_cdev->work_flags);
>  	clear_bit(LED_BLINK_ONESHOT_STOP, &led_cdev->work_flags);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp2HQ0ACgkQMOfwapXb+vJzcwCggkyvXV+eYBgW9uojRTJQDWXt
cRkAnjid4Uut1U7xVicfyQ6uuNNiHZSn
=x4//
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
