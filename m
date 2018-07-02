Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF8DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C30125E06
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fudy85m2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C30125E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeGBORh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:17:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45903 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbeGBORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:17:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id u7-v6so15728880wrn.12;
        Mon, 02 Jul 2018 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+skw4L7dyrpZeSJI5bdlFM7NN9Ego40KS06Y1/h7lNc=;
        b=fudy85m2GjYBpTXBnP0AuhsM08UDerFFMln5MakKkF2NaNhgwnBF3fk47ems48AE8F
         xHNlmkv7KuYBn32LD7ZN+d+CA5zT09MwGqHvgnHJfoKdWj0Cqr7R0pKACQhoh1p4IJU6
         IScoIgWCo7XYrIaYau9mkPwzDqduGJT9u5vXB+aU1peGy4wKujxNoC89kxrHcLB+e/AY
         1IWOy487g69xNIr2zWxQ6bEVKiJSfJ4KmFM/N0yDKEq0NdDFI+CADByyohNdPyP7LU2e
         7gFM18QjDrcVuVdY61oowHii8iUSRLP8f1H2X7X9ir7kyCr+dBjgf+oJAPwHKOFFJcO/
         rFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+skw4L7dyrpZeSJI5bdlFM7NN9Ego40KS06Y1/h7lNc=;
        b=FEoJiH4RmfkL+HFfqJYNBwDVuloLrjHp1S1REKY1hGHegFo5Do97xWvVWSYpy6tTDe
         Y+ZbDIitwnkhqxshvwtU/zrtELLHsLjPFrhgb5Qs1Ik/QmbS8yj6NBG4terzbrL7m6eB
         jHodNnctHnoVjSIxRqkpye4H2Vu4ZL+OMsm2ZAEd6j/TNm4O6mrchl0mN5SNJzfJDk4Z
         U6/uZj2LlY0t3ABtNLUbVQi+h+xouHVYDFzOAP9bMaEUy/YGr7HQrqPZT7q9m4YHVFNS
         deKlqBcEHxvtF5SILmcv6vYGqqtFUuQUxhpR8uXfrVt3pMtTd8q+Ew6A+WUV1O5MobIX
         jvhg==
X-Gm-Message-State: APt69E3MpbePDVtY8SPTZHuGaBzXhNLpUCnrspHUdvFKWriVy7FVmqy5
        79xOyTXnzjB6Uw/jQVEjHH4=
X-Google-Smtp-Source: AAOMgpetH5e0aHbVVWkoNgzU5DnDygW46Kt6lOys0bPh71JI1MF/oeeixHGaELvGiFw6nwbQLYG5Cw==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr19299596wrd.218.1530541049917;
        Mon, 02 Jul 2018 07:17:29 -0700 (PDT)
Received: from localhost (pD9E51838.dip0.t-ipconnect.de. [217.229.24.56])
        by smtp.gmail.com with ESMTPSA id 17-v6sm4969685wmg.5.2018.07.02.07.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 07:17:29 -0700 (PDT)
Date:   Mon, 2 Jul 2018 16:17:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>, jassisinghbrar@gmail.com,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] Tegra Combined UART driver
Message-ID: <20180702141728.GP13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702140343.GO13096@ulmo>
 <20180702140742.GA7977@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mejza3ZMMA5Za1mX"
Content-Disposition: inline
In-Reply-To: <20180702140742.GA7977@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mejza3ZMMA5Za1mX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 04:07:42PM +0200, Greg KH wrote:
> On Mon, Jul 02, 2018 at 04:03:43PM +0200, Thierry Reding wrote:
> > On Mon, Jul 02, 2018 at 02:40:25PM +0300, Mikko Perttunen wrote:
> > > Hi, here's v3. Changes are in individual patches. Acks are still
> > > missing from the following patches:
> > >=20
> > > mailbox: Add transmit done by blocking option
> > > mailbox: tegra-hsp: Refactor in preparation of mailboxes
> > > mailbox: tegra-hsp: Add support for shared mailboxes
> > > serial: Add Tegra Combined UART driver
> >=20
> > There don't seem to be any build-time dependencies between the above, so
> > technically I guess these could be applied to the respective trees
> > separately. The only thing we need to be careful about is to not merge
> > the final patch before the others, because it will break serial console
> > if the other patches aren't applied.
> >=20
> > Jassi, Greg,
> >=20
> > What I could do to resolve the runtime dependency is pull the mailbox
> > patches into a separate branch, create another separate branch for the
> > TCU driver that is based on the mailbox branch and then base the DT
> > changes on that branch, or possibly send a separate pull request for
> > just the DT change late in the merge window or shortly after v4.19-rc1.
> >=20
> > Obviously the latter would be equivalent to you guys merging the patches
> > through your trees for v4.19-rc1 and me sending out a late pull request
> > for the DT bits.
>=20
> No need for me to take the serial driver if these types of dependancies
> are required, you are free to take that in your tree if you want to.
>=20
> does that help?

It does if Jassi's okay if I take the mailbox drivers into the Tegra
tree as well. I'll wait for Jassi to comment and then we can decide what
to do.

Thanks,
Thierry

--mejza3ZMMA5Za1mX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6M/UACgkQ3SOs138+
s6EhnxAAwI9fH8fSx7Du3Z5PMU2jY3cko+JNZUpPiRjiRvvKX6wdCvNW8WVq/9qR
mbQshoHuNPY+BskYBBwECl8cJLDfF0LGOLkCZlQX6THET/L//Fm+LAWP+4u79G0k
f9H+rOduaFfbT4FimYn1BMe/bs0+dl1OdWTwXrB1oHLxjs1Vgyclh1HELlzs2Vbo
olLJlP8DEMCHlALWjPhYRAw7GWdmzV1LTIZ9z973LWJWsxe27dH3AVd71rJ5pFAP
UM2E+8Kuf7vwW8XldsFZzeutJdeqDBqB8DQovutlOhQrQ1/ll76eT2B1lkUSqD/6
xgWw2l5JzDs5pRc0S4xo5HYPMQnD+CLreQ2Sdc9O45p74hpVCjMqFftE5hH8Jx6a
GhaE7grXnRs6Z0BoFYwQHR7EiCNjsxiOiK0p5R16hJeipSCFGUPkyXgibmUJ7zL1
Lcg2JcSF9OF9PQr/Zv4vSf2D1mtI5D2kCRip/6Sf96FhhkEahDqr2EZHLwgFOvS/
1ZWYF2xCqQ3cfjnSvWbdOdbM91wqZR9+6ot86giDclNSAqHdPb61csWcLM5usdnX
zxCWIyvdItud6JgQnoox7+aUxv1GZh6Q6oSYs87dXXGMRiXsW/EBpa8c5hHFB97W
jre7HKlzAAUdG/k4V0aShM7HCwXwpZC92mh6VrNvg9LR5d498OE=
=oIKU
-----END PGP SIGNATURE-----

--mejza3ZMMA5Za1mX--
