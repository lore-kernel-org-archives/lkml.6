Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E32BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C2220878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBc1gltK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C2220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeGIQ5a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:57:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43592 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeGIQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:57:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so11728292wrv.10;
        Mon, 09 Jul 2018 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHAT1z3Do7xU0E0LFP+OeSiSci9wAPuwPE2eEw5zjJY=;
        b=UBc1gltKFEae5sh3acc2e1TwKTt31lFLBQZttTow71lbSVmddTeZ1E3bLhVZX5OqOa
         NOBbODKpV7V2KN9ulFABrtMHEaQFwVb1KwKskVCCaWPyf0MxT64vVVPNbzuCKPeyLw4F
         CPG/MIORwknKohC0jz9G43pr1WMKv0V10b/SD5qUXt3+NjWsdWgpLsa1NvYU7ADLSaI5
         a7K2yy1AocATmxNdDc54AyOWF73+Xz0ECjRJPwOq7zqJ4+kEXVjbiu0/qTf4x3aQDAU/
         xS23OE/ZUzE5V20bGz/UHwT9GSt7m+TzM6nWywXjDtyCkI2Dc3+Urs3Tg7fBdj1mtBkN
         YpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHAT1z3Do7xU0E0LFP+OeSiSci9wAPuwPE2eEw5zjJY=;
        b=Ou9FSy46r0Cf7N1uVDEdSUs4KssAt4re9ka7mqg9j0XS7Xa0L6XxM3e1hYhKp0SAtD
         7s20jnhIo9SONs6LMEWZTtXR65I5YR0qn4GRUA99ikhW8ifCmFW8pM2cSKl0sy63ajV2
         CYvuwjqyf+599gbBZUEV/sftC3gAEbEn4/GZ1MpPbuvG6m5aB5CliT9YmoDQUaIKa163
         fGMcyZbqpnLnkS0M0LvHQ3CxppN6DmGEwqPp/xhuTSuWbDWoWU5Uxvo76oQXJH281S9s
         VZGzlq7yXHFBHQVUKw6CJPr7L1Y6rD3Qbo4oET0dgmOcDktQL0bJbcxkXsxPnCyuX/a+
         V+1A==
X-Gm-Message-State: APt69E0DA05hFPEd/hYADSwLvwx696CYi2ZK7l9wI3lvaNojnpfh91Yc
        wCh0TCL/3RPVLcfimI+1FHg=
X-Google-Smtp-Source: AAOMgpe2eGWHt+/hOOGgE9IxN10QMm4RTVbrQZbHa43xiOIAt2wy+A1Kx1OkJVr96uIdbj8KPshogg==
X-Received: by 2002:adf:8796:: with SMTP id b22-v6mr16075885wrb.92.1531155446681;
        Mon, 09 Jul 2018 09:57:26 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id o4-v6sm28897042wra.3.2018.07.09.09.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 09:57:25 -0700 (PDT)
Date:   Mon, 9 Jul 2018 18:57:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Hebb <tommyhebb@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        sebastian.hesselbarth@gmail.com, Jisheng.Zhang@synaptics.com,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2] pwm: berlin: Don't use broken prescaler values
Message-ID: <20180709165724.GB26651@ulmo>
References: <a4e1449967f3dbc95770b9ac2bbc1fd116e3cac7.1528306926.git.tommyhebb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <a4e1449967f3dbc95770b9ac2bbc1fd116e3cac7.1528306926.git.tommyhebb@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 01:42:10PM -0400, Thomas Hebb wrote:
> The Berlin PWM driver is currently broken on at least BG2CD. The
> symptoms manifest as a very non-linear and erratic mapping from the duty
> cycle configured in software to the duty cycle produced by hardware.
>=20
> The cause of the bug is software's configuration of the prescaler, and
> in particular its usage of the six prescaler values between the minimum
> value of 1 and the maximum value of 4096. As it turns out, these six
> values do not actually slow down the PWM clock; rather, they emulate
> slowing down the clock by internally multiplying the value of TCNT.
>=20
> This would be a fine trick, if not for the fact that the internal,
> scaled TCNT value has no extra bits beyond the 16 already exposed to
> software in the register. What this means is that, for a prescaler of 4,
> the software must ensure that the top two bits of TCNT are not set,
> because hardware will chop them off; for a prescaler of 8, the top three
> bits must not be set, and so forth. Software does not currently ensure
> this, resulting in a TCNT several orders of magnitude lower than
> intended any time one of those six prescalers are selected.
>=20
> Because hardware chops off the high bits in its internal shift, the
> middle six prescalers don't actually allow *anything* that the first
> doesn't. In fact, they are strictly worse than the first, since the
> internal shift of TCNT prevents software from setting the low bits,
> decreasing the resolution, without providing any extra high bits.
>=20
> By skipping the useless prescalers entirely, this patch both fixes the
> driver's behavior and increases its performance (since, when the 4096
> prescaler is selected, it now does only a single shift rather than the
> seven successive divisions it did before).
>=20
> Tested on BG2CD.
>=20
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> ---
>  drivers/pwm/pwm-berlin.c | 45 ++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)

Applied, thanks.

Thierry

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDk/QACgkQ3SOs138+
s6GzSg/+JeatRGdrJmsErClcFd4iadL/LxRhrcxR+qX12x/xu1eaVmqdxhTIUDW/
BD2ZwnNIeTs8cDsBEgc2M2Y3+40Qc5XKY6sk/IHHHI4Dkid0dW6PAK+fwpE+nyY+
9UAg2oVG7e5NO7T93SDF4iZdUFYMFve1EHPdayacf+BaLSAHfQSTfNq9EPgShIqq
f9xSNXheIW20D26NNjVxFqXAQzxXDO4+tTNHZC8qyTr9Eulk0MZCjkBzh49COeCw
fpumSqUrohGkBu6RkEgjAYwsIRZzT/mW+SGsOCQOBU5NfYuRsRl4h4jP7dEQXFBU
LIRmbzFaJYVkFMhsT5P9XMcw/sAeSegpV/9YuKMS/7IH4UWN0S+YIVjN0mGWFt45
8UE/S9c3C2zLMEtEFetAX+c+lg2xFWI46Jg+JPGtvuI1YFZ71xU6IWajK+ugK5ie
GwtrGY/V1Q9S45R+18Ypau4mUIPovX7i3HrtFtCNxpceEC9TIfrbi33f1QFdpNSE
sRWP699As3Qp7E9p4tdl6XpssC3GhohyvMNdBnr9D97gjtbp+ZC8bUDEhr0mMumb
vdoC5B34gXUpW9yWwrQQzVWT4d8D9Q1HdR+rXhvI720uiAyqukedZgV1evM1lMN+
VqHCqQ+mFU644jHWKAuMoOW638Gr1UDreQcGLExNW7u4zlp7hGc=
=jPBn
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
