Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sAFvOy1qGFs8dwAAmS7hNA
	; Wed, 06 Jun 2018 23:11:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D661F608B8; Wed,  6 Jun 2018 23:11:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVgs8ybF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5D8F7607E4;
	Wed,  6 Jun 2018 23:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D8F7607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeFFXLh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:11:37 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38983 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbeFFXLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:11:34 -0400
Received: by mail-pg0-f68.google.com with SMTP id w12-v6so3735859pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QqTE1+a35fXHFYu5xaBAqOwXQ9rk42azLPZKPXFZSNE=;
        b=UVgs8ybFzPu29nn1ib372Ye3wYp7reeaedw2a6/682nJJiPuXvsColaYM5D90MhJEQ
         jNBQ1i2PDWPhCRbClG9Z9YXiU/7Q/qTC3/9nM9ueY2jX9aQqPdsEUY2T60azzJyvmh15
         OS9daP1KJaqOO9Uis1viD0GUkSLCYjmVlgHjF13/eBLkWO55/QJsAiG6HOAffj6F8F80
         ve+jvY/lm15uKYvtkDQLTDUdRFMPGcIWR1Ikh2N1j9LVTtaeuxap8nyQVWHiJTF45ClJ
         eC9JCDJTOtqCJd0ScDqiPRysEYaKjtUTx+glMYDWgxpHGYmRzoUVt2pVr1k6VMEXfceH
         dkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QqTE1+a35fXHFYu5xaBAqOwXQ9rk42azLPZKPXFZSNE=;
        b=YHzszBzTirHqzOxRGWTJcZU4PueZ6Q87vjjTtp7x9Bdzp53d63ywQHu9V5YFtQJ9HC
         tj/MgnYFKffA7n1TN2lqFILUYfZZi5lripmw3GUKi2EAdh10fwKfZlqC7Tgb8pCkKKOO
         SEkIToyWMcWcZnTxKof06pXlAdYeHa2iuuledHG4ZGgeGpA6sgA4wYthd46ladtTYqiY
         LbzWEydyfwixEa9hJa0SQj8EeXCXgvdBTgIV2CtHWwONrFuuVLbf8eLAzTxqXlPbxcEk
         ddaGYasDASntUmmxmopV162UBNk2APjoWBAg6tbi4zzIQTMuUdhSFFTvnyphQIy5dlTO
         OgVA==
X-Gm-Message-State: APt69E25PIp6pZl250wHMv9NB8dP6GToBf8VHtqdfKN43nwuLOh7DPmh
        MZquxqQTAmR+yMLomk7YT+0vXA==
X-Google-Smtp-Source: ADUXVKJHvKIqAYAoOK+AqNAAfrmDJCKLpX6Rk5fCT8kHd2eiFkqi2oPOUnoC2z1Vo7uHUWb+wWe7VQ==
X-Received: by 2002:a63:9b19:: with SMTP id r25-v6mr4018621pgd.197.1528326693531;
        Wed, 06 Jun 2018 16:11:33 -0700 (PDT)
Received: from decatoncale.mtv.corp.google.com ([2620:0:1000:1501:e4e8:e3c6:19f1:ae51])
        by smtp.gmail.com with ESMTPSA id m11-v6sm28383852pfk.42.2018.06.06.16.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 16:11:32 -0700 (PDT)
Date: Wed, 6 Jun 2018 16:11:30 -0700
From: Benson Leung <bleung@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Todd Broch <tbroch@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Furquan Shaikh <furquan@chromium.org>, bleung@chromium.org
Subject: Re: [PATCH] ACPI LID: increment wakeup count only when notified.
Message-ID: <20180606231130.GA57957@decatoncale.mtv.corp.google.com>
References: <20180604182612.72699-1-ravisadineni@chromium.org>
 <CAJZ5v0jBTpUzqEj1CeQ0CKH7zVRkgj1qJffoSujEZWi0HXABXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jBTpUzqEj1CeQ0CKH7zVRkgj1qJffoSujEZWi0HXABXw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Wed, Jun 06, 2018 at 09:00:43AM +0200, Rafael J. Wysocki wrote:
> > @@ -417,6 +414,7 @@ static void acpi_button_notify(struct acpi_device *=
device, u32 event)
> >                 /* fall through */
> >         case ACPI_BUTTON_NOTIFY_STATUS:
> >                 input =3D button->input;
> > +               acpi_pm_wakeup_event(&device->dev);
>=20
> Not really.
>=20
> There already is an acpi_pm_wakeup_event() call in the else branch below.
>

Ravi removes that other call below. The intent for this is to call
acpi_pm_wakeup_event() regardless if the button->type is ACPI_BUTTON_TYPE_L=
ID,
in case that event is ACPI_BUTTON_NOTIFY_STATUS.
=20
> >                 if (button->type =3D=3D ACPI_BUTTON_TYPE_LID) {
> >                         mutex_lock(&button->input->mutex);
> >                         users =3D button->input->users;
> > @@ -426,7 +424,6 @@ static void acpi_button_notify(struct acpi_device *=
device, u32 event)
> >                 } else {
> >                         int keycode;
> >
> > -                       acpi_pm_wakeup_event(&device->dev);
> >                         if (button->suspended)
> >                                 break;
> >
> > --

Thanks!
Benson
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsYaiIACgkQHwn1ewov
5ljcig/9HuK5rrLVvY1YkXgYqdhyVyY1Vg59CbGF2BQwDPzeEq0fvJzbptMerGWB
oPwC4cs9e5jg2Od4qMo6jujcCPvlkZAIivWq7/YKQSmr3sUAeb875H8aSIMmgCog
v/YI3h91NSixkvk1Ip5WP4Kke4J1wTus6gESaty+gr81OeEunThJ30Vmm87le7nx
Qhcy6zDtXZtm3+CD42wO+k9lCQuQCrF2b2tVyFVdQdLOh4dMJYAsMV6N6gQFnzFx
A7bvMvj+8NDk9G8D3IPHGLHrq0Z+/efSbmQfgeSkAh5NpnLznkxYp4gv5VOxJjWP
ULGWC8Fk9PZfGBA+SN3d1axfEk4TE9kEcjxIcn9JpjGD5gRy9RLdVDm5UMH4/PT/
kSESPP/ExVVbr1NuxWz0v8ntH3le2LEbe84XM+/Ca9CKrzJ0ePDfjeoVDMnqAWSX
paNQjNo27wS/srFtQLDjTgkACt9czmCqwF7AFHCldItIHJou7KeXE/GQENFDOKq5
5KhWQhRuxCJhXp9zglAEg0ltGqL23gudqLPgTB4QJqlLpOy15yXqrSgruiqHpEbn
A8rxlrTqpUiObKUFyf2j1xkLa17AXYAuc52MC3+PAWcgYJP1QL2ZU7oA1+/QQYas
J2UnloTry0Dsp007y7/oeQnab4ctepWKA+t9H5EWTU2R5UKYvvI=
=cKk0
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
