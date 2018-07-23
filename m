Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBC9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2D820647
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqX+Jz0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2D820647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbeGWJgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:36:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42545 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387972AbeGWJgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:36:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id u202-v6so5791718lff.9;
        Mon, 23 Jul 2018 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8TqsfMd8D4U8Mc123LDWj9YYgXy0e/AlforSXrxzjTc=;
        b=dqX+Jz0iXBJu75QaKDVz/HIu+UfVn5dZzM3O2Bi6kAC4EUBEipaBl7qSmvSd6XxHwT
         ek/7fLVU837xLR0FY3krgmstZAykXqXlcatqWvX6E1mPcqwzLC62NvVwzowqMiwbAiUn
         +B5usm6LtvIUzKGc4e1la841a6tP83OV2A0XqyhNji32/F9YjHTCKxkOIaz1kSL0Oueg
         5hep5WAuPmFMOqXVKDrfcOo5F/kIz2eweWGsKJzyEfmSA1CfjGdFCBTlSl9UUJk/s/Yb
         tEWZVLvdqCruBGGYB4HSZ0Nff6nzFO+lMhe/k7g39tX8Qdc4mxRcOI3VPbC+Fmk8+dgn
         y5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8TqsfMd8D4U8Mc123LDWj9YYgXy0e/AlforSXrxzjTc=;
        b=O4IaRimnfWHKYpLU6simdStAs0WjSIjr+cAnuEdksFoBtwJws9knWveW07POx+Wf02
         kCp37VfkzYH4N5h8Zn+adccP4UvQmgcqCAn8wOC05jsFy6Xxhl5O53tvyoVfWvZ2bOpx
         Tm5hZwixRRtz8iJY4Wc2SEVL6DcdsSV3nlNCT8EWogcDTpN4B8jcnoJEwzVM11rv9B5W
         D6mT3qlM5ITv2GScJkpJ5ntTsxMe0SrZX6d9L0ijlxmhyLxlh/gKCOELUqt2ZaYYdNsX
         g+uKxXUsbjMTl3H76Kk8WIutuz9u1ercfOAa1rxTFlkhmFGNldwku2Z55nVXFiMdDawg
         igmQ==
X-Gm-Message-State: AOUpUlG/i/4zSYM3e0zWW1Zvzy0e5wFoQ8NfRGL8vikVAvmspuUuTuFt
        p6jNkHo/gC53V3B8Gl49aQg=
X-Google-Smtp-Source: AAOMgpcjnEjmM97Q3r1Iq9STLH8Gp28ZQXaYmOK+sgZf/k3oZ2Q6KoUUey1PZ2+TapRFtUUz/Jv+CA==
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr6612990lfh.19.1532334968033;
        Mon, 23 Jul 2018 01:36:08 -0700 (PDT)
Received: from gmail.com (c-2ec2f9f0-74736162.cust.telenor.se. [46.194.249.240])
        by smtp.gmail.com with ESMTPSA id o203-v6sm1305993lff.28.2018.07.23.01.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 01:36:07 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:36:13 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Message-ID: <20180723083613.GA13016@gmail.com>
References: <20180721195923.7610-1-marcus.folkesson@gmail.com>
 <20180721195923.7610-2-marcus.folkesson@gmail.com>
 <20180722091111.6c55602f@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20180722091111.6c55602f@archlinux>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Jul 22, 2018 at 09:11:11AM +0100, Jonathan Cameron wrote:
> On Sat, 21 Jul 2018 21:59:22 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20

[snip]

> > +Optional properties:
> > + - device-addr: Device address when multiple MCP3911 chips are present=
 on the
> > +	same SPI bus. Valid values are 0-3. Defaults to 0.
> > + - external-clock: Use external clock instead of crystal oscillator.
> As mentioned, in the code, can we use the standard fixed clock bindings h=
ere.
> We don't actually care what the value is, but it might be nice to be able=
 to
> power down the clock if we are suspending or something..
>=20
> > + - external-vref: Use external voltage reference
> > + - vref-supply:	Phandle to the external reference voltage supply. (onl=
y valid in combination with `external-vref`)
>=20
> Just use the optional regulator stuff and get rid of the bool.
>=20
> > + - ch0-width: width for channel0. Valid widths are 16 and 24bits.
> > + - ch1-width: width for channel1. Valid widths are 16 and 24bits.
>=20
> As I asked in the code, are these a function of the wiring etc or are
> they something we should really be leaving up to userspace (with a sensib=
le
> default).
>=20


I agree with all of your comments.
I will remove the channel width properties and fix the regulator/clock
bindings.

Thanks,

Best regards
Marcus Folkesson

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltVk3gACgkQiIBOb1ld
UjKoRg/9EfioKOruahSRmFCbX8GMzfRfNv2zyqdbKgaOCYSvBex1mYdNRbvmWCyA
pGFmyXsrrXhB0t0UY/tsRdio92vxhfdhUgcYtVbt6dcwLXd9tTESeQ7sjsLTkm+i
OxnmgKLwXX5VfS31rq4nZPExvY0XI0Qiz6gaVn9tmp0ioJZZ1MM0EO6rlSNhAdGT
3nVlyhWqfNe8KRjEMSUGsdvFZYIlMMoDxqkRMid8WkqnLi5WkW+h3cZ7645ROARz
161w8Dx2HJDdfNMFCzkKcYtVt/tPYCkImNsbDQ2DR6USNmnwMDlwtKEw/uRBRnYz
y7Vl4CYX295uIN3bmSnHRo4DMrSnBstn1w0fCfbx8bZk0mX5GvIHitWSwCRvuuOc
3gJSJtuk1mDufvceUhf4ZayOvzla3/o+NiCBxr4DhHPWVBfPdEHPUMVHISidw+bG
hP17n9qy/L1xGIVKNcY958M3EB2H7oy7FGAkZsGOSuEYD8mtP0O2aJrVbIope0lz
ty/huysyVoTb2LQj3FVXdfQCO46JxyoIqqDeA1v1hc8pGgUuaROIKdsJxkolaNSg
DxMmIcMyHx8B51Avn8fQhr+WQZmaLkKSInotpvm/dz9fcLH34xYkMSUaTLohb9/P
PRsLexWLC4noPMrCIJrNm7EFZH6GoDl6sUeJKgN6u+0G+Q9Ms58=
=Wv8b
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
