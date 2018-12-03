Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E291C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A9C20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWiEiDZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A9C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLCT6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:58:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46853 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeLCT6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:58:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so6898905pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 11:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YIDFunJvTP/droGzlbqYsetOXj0jnj8R/u1TJotTzKg=;
        b=sWiEiDZsuURQRFaR8I7XzFI17T/XwzjKuSrEHGsNva4P8J1l81QsXfVin1VHzHTxzm
         uK185dsX9DJx6ORMIf0x1M0I9IUz8yFxzTvHy1ld6wsMtXuMTDZwK5BgZCmsGRTwkvOq
         wdoWEKOI1OBRZriMxyiYds7UwNaSpiYIHwSzo7dT1/g002TCBHxqOEym7kvvtkzyxT5u
         PpLoSafp62Ot4Sq1iGaAFDauP4M1RWKEbiNunlFOeUZcmCF2ceB2yIQZDtHStnM9PyDk
         0/0wjO0ArkmyqD3F1Jsa6GQ3c+vaIethTIlXgbfFKVliDQLZF6NOXb7/Pk1YTEct8EUH
         NOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YIDFunJvTP/droGzlbqYsetOXj0jnj8R/u1TJotTzKg=;
        b=t+715S2U0ECJ8tYm6Rn9wAQewYTiqQIUcK16Xti1IEepWDwzIqzYl8K1y/tO/koh6D
         ee3eBD9j7LQWbUOX+5ejR2YkG8S5l1u6KsI49oBPxNZ5k8f4pYbYvTxTNpsoklDKoEPa
         Zeh8dYnwKUelB29jvXU2Wt6gKD1y/1jkEK9iWh5kf6CkzJrAks0OYIJIOiIFyhQGiK+a
         p3OQmBIkPB5XWt0UCaFR/EwIDIA3Vpna2L1sK1/40L0gAJfyTkpVAZfVYsz3Pxdjushi
         B/R+MlHhmEHWR2keMPaTKtR7yIaVk21k4JzquTP+8zs4lCrcT10GVH+IWw/hIS3G0UnJ
         AvAw==
X-Gm-Message-State: AA+aEWbiC6GgmzYO+PY5inoVPycL8dzHnVBEdw4nZTlADIsgIToOitTj
        IC9T4fSNrVfA4zMpf0H8h2JvPw==
X-Google-Smtp-Source: AFSGD/WI0P9Q2XNg8hdZp71K9rouKD8tR5TR4iFRnWhlN/yfV2YjH1n9R389m359luxnI0lNSoCUMA==
X-Received: by 2002:a63:554b:: with SMTP id f11mr14767561pgm.37.1543867128518;
        Mon, 03 Dec 2018 11:58:48 -0800 (PST)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id x27sm21422365pfe.178.2018.12.03.11.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 11:58:47 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:58:45 -0800
From:   Benson Leung <bleung@google.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pm@vger.kernel.org, sre@kernel.org,
        Sameer Nanda <snanda@chromium.org>, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com,
        bleung@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, bleung@google.com
Subject: Re: [PATCH v2 1/2] power: supply: add input voltage limit property.
Message-ID: <20181203195845.GA120704@google.com>
References: <20181122101119.29194-1-enric.balletbo@collabora.com>
 <20181123232203.GA3852@amd>
 <c122a1f9-70d7-7129-f139-4a0449c366a5@collabora.com>
 <20181201150934.GA7052@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20181201150934.GA7052@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Sat, Dec 01, 2018 at 04:09:34PM +0100, Pavel Machek wrote:
> > I think that handle this via dt / ACPI is not possible for our use case=
=2E It can
> > be a hardware bug or a hardware/user constrain, let me try to explain b=
etter
> > with an example.
> >=20
> > On Pixel C's devices, userspace uses this to set a USB input limit of 5=
V when
> > the screen is on for thermal reasons, but those go away when the screen=
 is
> > off/system is sleeping, so we allow 9V and 12V levels when sleeping.
>=20
> So, on pixel C, what happens if userland ignores the constraint, keeps
> display on and sets charger to 12V?

I was the software tech lead for the Google Pixel C and was involved in this
particular code change in 2015 before the release of the product.

So there's nothing fundamentally broken about the hardware that would cause
the Pixel C to malfunction if we were charging at 9V or 12V instead of 5V
when the screen is on, ie if userspace doesn't change this.

This is part of the Pixel C's thermal management strategy to effectively
limit the input power to 5V 3A when the screen is on. When the screen is on,
the display, the CPU, and the GPU all contribute more heat to the system
than while the screen is off, and we made a tradeoff to throttle the charger
in order to give more of the thermal budget to those other components.

What would happen is that you wouldn't meet Google's skin temperature targe=
ts
on the system if the charger was allowed to run at 9V or 12V with the screen
on.

For folks hacking on Pixel Cs (which is now outside of Google's official su=
pport
window for Android) and customizing their own kernel and userspace
this would be acceptable, but we wanted to expose this feature in the power
supply properties because the feature does exist in the Emedded Controller
firmware of the Pixel C and all of Google's Chromebooks with USB-C made sin=
ce
2015 in case someone running an up to date kernel wanted to limit the charg=
ing
power for thermal or other reasons.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlwFivIACgkQHwn1ewov
5lg8+hAAkU3bSc1yCGH1bSwmoNTjpDQHMs/45GRZKQsgfDOKkraVTOm2BM5WriGQ
r5fB85winldp6rdghBT9Epa+zVNYEANaQwcesgoWhgbaqBhpRdyXFLyWLVsGCg/8
2mqfJri7T/uRGLzwFlLVwJwJk/5OrzaNPVPDBTHdfpVirSeYdU34QdiNeDP/TQ8n
TtWE//JApbXb9vB+F+QKlrrU6ImIm0jrukAM6eR+chi8rXPAt2TW1cmlb9JcJxDg
1h9U1uRevKat7zXZ64+LPayQ7R9v64oUMIeKSHapgCXrOqCL0PDlcI4wbVhdK1Cn
h39OEGmhoaub/csJLkUSrn/wjKoLg39edefcZ+sQ5BPosWDrAmvCHh0fZoqKsjfv
Zi3dHFw4qgp/O3vpkvJMcRgpN621FWnNCG7/pRBgr3W+L6HlTXW1s+WADzSkgbzW
4A40LDTWB/4trGv/CKSZgTX93AZhmj7GNdVZyr/XUfKIZWcaNQhMHAPTYttLtFbp
X9jN0YGZvIQ+JaZQyGqEYDxm3rOiidRf40LPrMpoza93npG6FIeGDvAa42XfllHk
AWnmJDxusgJb+oZmKIQMAe9k2jHxafSqzCFjnH57T/6vD1Tn5YYmqJy+b4gAbI83
9IexSFTWAyAbwYg+/pRzcaUnzKCYirLxJSe+585uWEcoilITZ0c=
=Rk1S
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
