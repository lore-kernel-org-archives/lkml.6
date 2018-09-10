Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6E0C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41E520866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED4vNcYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41E520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeIJN7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:59:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38212 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIJN7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:59:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so20511986wmi.3;
        Mon, 10 Sep 2018 02:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DZsFerDPKrwSbQqHt2X2KEzt4/yzhAiCWmPVan7QfBQ=;
        b=ED4vNcYCcA7f751NqfjqzIcwiqRi0eOPOOJj6dF7o08vIB69GXPZAX/zIvk3FwNaW5
         qkwSj17rJ0wI3t5FE6ozrw2Db0P1yjEEceDxFOg1rvWsTT5SNFZTHgg6C5YwVJCh54K+
         XHXyDDOYctV/AncFslAYthOwOB9lBrEnBlecLExO99A+ffOH7a7NWBUi2hxD0JMaM2Yv
         Gr2PpJBipErMNqg/nhUqj92CQN/chqtx6XlLPEldSFcQmRzZ0Pt2bgw3L3gnc1q06f3d
         jh7dGqo2vbUOi3g+WcB4fKuzljLM+gjjrk2hi22+gFLXdHPzK/j22FVtU94i4TLLOMyL
         568w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DZsFerDPKrwSbQqHt2X2KEzt4/yzhAiCWmPVan7QfBQ=;
        b=YrgTfyncjfy6w/44D1XVT6C9eZ2//hilD9VfZWW6uGUrsoDYJslHW4TOuI4jvvoCnA
         c0lyZeI1amOSINsnZIUvl0l8kAbGakRIE3jumXIgz0GivTO1MgtQekVDGO+WaTNAAc9f
         TfmKhwLmo7hM4W+gw0pr/QIO0nNGTTUCN5hP7z19T6y6azwjWfA2HEWftNF2p9zh5p6f
         ptF5z9hjdBKjtt4JMM6URL9doY57proq+9bn9YJgZG78lJRhhs4GlhVZY9QWkQbwQqY5
         eQ/ep+9JUyMNoJVrwwWmL2S/Py3u65zbdI21BhzRColfEREcvnKRXak/BTmBmMGXb4CY
         yozA==
X-Gm-Message-State: APzg51ADSpKgKoAPiurW2ETFqyLtON0ePCjk8skJOSxY3TqJo4WK8ad7
        cngKVh4bVB5vK8lpSbTI9RA=
X-Google-Smtp-Source: ANB0VdbZJEtvK//xjrjfKYjrDL+i90Kaep2dfpGDmtL2BYnRw8LLo5GnE0dBHmmVoUROWFRrNB+Xrg==
X-Received: by 2002:a1c:1510:: with SMTP id 16-v6mr25901wmv.74.1536570387222;
        Mon, 10 Sep 2018 02:06:27 -0700 (PDT)
Received: from localhost (p2E5BE549.dip0.t-ipconnect.de. [46.91.229.73])
        by smtp.gmail.com with ESMTPSA id u127-v6sm11528993wmf.48.2018.09.10.02.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 02:06:26 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:06:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 3/4] of: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180910090625.GA702@ulmo>
References: <20180828155254.10709-1-robh@kernel.org>
 <20180828155254.10709-4-robh@kernel.org>
 <20180907122928.GA5821@ulmo>
 <0999919005219fa94ccc69ff57659d47911d3abd.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <0999919005219fa94ccc69ff57659d47911d3abd.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 05:30:23PM -0700, Joe Perches wrote:
> On Fri, 2018-09-07 at 14:29 +0200, Thierry Reding wrote:
> > On Tue, Aug 28, 2018 at 10:52:53AM -0500, Rob Herring wrote:
> > > In preparation to remove the node name pointer from struct device_nod=
e,
> > > convert printf users to use the %pOFn format specifier.
> > >=20
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: Andrew Lunn <andrew@lunn.ch>
> > > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: netdev@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/of/device.c   |  4 ++--
> > >  drivers/of/of_mdio.c  | 12 ++++++------
> > >  drivers/of/of_numa.c  |  4 ++--
> > >  drivers/of/overlay.c  |  4 ++--
> > >  drivers/of/platform.c |  8 ++++----
> > >  drivers/of/unittest.c | 12 ++++++------
> > >  6 files changed, 22 insertions(+), 22 deletions(-)
> > >=20
> > > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > > index 5957cd4fa262..daa075d87317 100644
> > > --- a/drivers/of/device.c
> > > +++ b/drivers/of/device.c
> > > @@ -219,7 +219,7 @@ static ssize_t of_device_get_modalias(struct devi=
ce *dev, char *str, ssize_t len
> > >  		return -ENODEV;
> > > =20
> > >  	/* Name & Type */
> > > -	csize =3D snprintf(str, len, "of:N%sT%s", dev->of_node->name,
> > > +	csize =3D snprintf(str, len, "of:N%pOFnT%s", dev->of_node,
> > >  			 dev->of_node->type);
> > >  	tsize =3D csize;
> > >  	len -=3D csize;
> >=20
> > This seems to cause the modalias to be improperly constructed. As a
> > consequence, automatic module loading at boot time is now broken. I
> > think the reason why this fails is because vsnprintf() will skip all
> > alpha-numeric characters after a call to pointer(). Presumably this
> > is meant to be a generic way of skipping whatever specifiers we throw
> > at it.
> >=20
> > Unfortunately for the case of OF modaliases, this means that the 'T'
> > character gets eaten, so we end up with something like this:
> >=20
> > 	# udevadm info /sys/bus/platform/devices/54200000.dc
> > 	[...]
> > 	E: MODALIAS=3Dof:Ndc<NULL>Cnvidia,tegra124-dc
> > 	[...]
> >=20
> > instead of this:
> >=20
> > 	# udevadm info /sys/bus/platform/devices/54200000.dc
> > 	[...]
> > 	E: MODALIAS=3Dof:NdcT<NULL>Cnvidia,tegra124-dc
> > 	[...]
> >=20
> > Everything is back to normal if I revert this patch. However, since
> > that's obviously not what we want, I think perhaps what we need is a
> > way for pointer() (and its implementations) to report back how many
> > characters in the format string it consumed so that we can support
> > these kinds of back-to-back strings.
> >=20
> > If nobody else has the time I can look into coding up a fix, but in the
> > meantime it might be best to back this one out until we can handle the
> > OF modalias format string.
>=20
> Or just use 2 consecutive snprintf calls
>=20
> 	csize =3D snprintf(str, len, "of:N%pOFn", dev->of_node);
> 	csize +=3D snprintf(str + csize, len - csize, "T%s",
> 			  dev->of_node->type);

Yeah, that's what I ended up doing. Rob came up with another alternative
which is to output the 'T' via %c, which also works around the issue.

Thierry

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluWNAwACgkQ3SOs138+
s6Gokg/+K3EawlUajE6ZpjcPOUOT9YUvcNEj3Z0/11JF7nBbZ52sBrBs7PEOdLWW
Rgw3+5UX70U5o/oB2+d0m9mCS6zk5zsqAhDacU/3xEHod64qdjexPuU4VH1skk2Q
2m/Tx3Z/aivJAKjovI5IRjk8lD3RUVkTk1x3Jw2BrNxtahYygKNNeh3aqrjHqonm
DFaZBn6gBGMeDSGFVL0n2X+5rE0NJFLIhbBs0isfQppTZeerqawm25i0r+vT/IJd
lGYar4hPqFb9VGtBwe0rZ6hg0j7f1BI+JUe4tV/XmGmKLJJc5IWBhAwlsNCwjFpt
UN3NtJBv5oWOAazcvV/YrCxk/C5dzdNRgp6ccbcc2GUHlqHnvs86dcNlvhv3DcBG
B+umZbQC+b30qyZs4xcZUAg7qygf22BbyAF+OMDxn9YR6GIivqNgSJTtTErAExLB
HtSS1awvtCETNlgNY5vy/Nh0Jnzm5XzUAauuO467e/OzqWgN0IQCteNlWpD9ZNOe
RNEUWEdb49qN2coDLi/pi4Mc+nkHhFcQ+rfQDN5OKwcomx9dE5XHNzPTJmsLbbAr
2Z/7P+g2IePJOUpVWUvz+wcESGCExsd+rgXHYUC+HYekCSJal2MtfkP1zMoFfefH
hlistUPBmCXmJpHokHsq0QLPK04lpp2P8hMBic9YXcOyKw1ShDI=
=TA2P
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
