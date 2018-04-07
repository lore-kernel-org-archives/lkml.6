Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeDGJqI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 05:46:08 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53485 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeDGJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 05:46:06 -0400
X-Originating-IP: 2.224.242.101
Date: Sat, 7 Apr 2018 11:45:56 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, airlied@linux.ie, vladimir_zapolskiy@mentor.com,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
Message-ID: <20180407094556.GQ20945@w540>
References: <1523018517-24121-1-git-send-email-jacopo+renesas@jmondi.org>
 <1664336.M7KDjLhzuK@avalon>
 <20180406142558.GP20945@w540>
 <2441543.5xTHaLXzZ0@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5Dr6Wqe9hdyl7LAI"
Content-Disposition: inline
In-Reply-To: <2441543.5xTHaLXzZ0@avalon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5Dr6Wqe9hdyl7LAI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent


On Fri, Apr 06, 2018 at 06:40:14PM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
>
> (CC'ing Mark Brown)

Hi Mark

[snip]
> >
> > Anyway, we spent enough time on naming issues, starting from my first
> > stupid 'pdwn' permutations then on this semi-standard names.
> >
> > I'll send next version with 'powerdown-gpios' and 'oe-gpios'
> > properties hoping that would be finally accepted by everyone.
>
> I certainly won't complain (as long as you write pwdn instead of pdwn in the
> driver :-)).
>

Oh, so you won't complain if I address your comments? Thank you! :D
By the way, the dumb pdwn name comes, again, from the chip name. I can
change it to a saner name for sure...

> > Same on the mandatory/optional VCC supply thing. Let's try to make
> > next version the final one. If the optional property with the dummy
> > regulator doesn't satisfy you and it is preferred to have a fixed-regulator
> > anyhow in DT I'll do in next version, othewise let's try not to change
> > it again. I'll just remark here that in the current Eagle design vcc is
> > connected to a power rail with no regulator at all :)
>
> I don't like the dummy regulator much, as it generates a dev_warn(), which
> makes me believe that it's a hack rather than a proper solution. You might
> want to ask Mark Brown for his opinion.
>

Sure: Hi Mark, a bit of context here to save you a long(er) reading.

Unsurprisingly, the chip for which I'm writing this small driver needs
a power supply to be properly functional :) In the development board
it is installed on, the power supply is connected to a power rail,
with no regulator. At the same time, some other designs may instead
include a regulator. I assume that's a very common situation. I
started by describing the regulator as optional in DT bindings, and
use regulator_get_optional(). If that function returns PTR_ERR, the
regulator is then ignored in driver's power management routines.

In this last version I thought I was acting smart and copied what happens
in other DRM bridges like adv7511, which use 'regulator_get()' and work
with a dummy if no regulator is provided in DT. Laurent has the above
doubts on using a dummy, and I actually share some of his concerns
(that dev_warn() is how I found out adv7511 was using a dummy, actually).

To sum up: when a regulator is described as optional in DT, do you
suggest to work with a dummy if it's not there, or use the _optional()
version of regulator_get() and manually set it to NULL and ignore it
in the enable/disable driver's routines?

Bonus question: Laurent likes to have the regulator described as required,
and thus require it to be described in DT also in cases where it is not
actually there using a 'fixed-regulator' and refuse to probe if the regulator
is not available. Do you encourage this approach, or prefer to have it
optional and handle it in the driver in one of the above described
ways?

Thank you
    j

--5Dr6Wqe9hdyl7LAI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJayJNUAAoJEHI0Bo8WoVY8OSMP/1Ws8zIHiIxBHM+D8JDRqLr/
PwKqUx8CwAw7mMHsSYW6uIc+aTU5KStGMezxUKc3j+QcEUJmJcCb195KBn6yh1MD
JV+oWZPPCeKrX4AfbFY9uYmYHAOdJoYky9w5NA0hdrpjIbF6iLehRhTM0syyKct1
/o7VN2jsxHgZTnt4LBuCzd83E+Jx9MaTl8pERSr61feNUX8Hp+Xmofs0iXPZna9L
vKdo4W/k4qG0Ap+ukZLd5MNkZXfWzTbsF7Wx+xntMtuXOPpJ9Ltzy5V/r3XphAHX
ehawHATR8FjcCdzji5JINkOqXWvlSFgmXelBs2DHIhIZaaUC2X8HryuRPkkfhGlP
3jF7egepZghYyCnoNyRxM7SXBnBqmGwSp+8zD+l5jVBhr4hRGqx+OFz8p4LA648A
Bzgkx0HoEr0c5XvlNexgdhTPurRRGYYIGf5hFUGpFzS3rdlQKtRBZD+soRkt5K/Q
2ldO8CI5gJHnFKVDYyMwBbERbua9e9QmPMNLT6R9AtkJFr1cs2sRBDK+f4LqTXS3
/6clkHtP8O/1JlSKOo+BasIMgfynrFpcbX6HjlzdKP7h9PcSy+TEht/eybk42hwG
/mENQ77D/pymSyQZHMh4i3jMR3j95L1q9utBaDH9CHZ50CC/w2z/DoujWlr2C2uH
8IY5Np0FPDDO4bT+m/eu
=n0wZ
-----END PGP SIGNATURE-----

--5Dr6Wqe9hdyl7LAI--
