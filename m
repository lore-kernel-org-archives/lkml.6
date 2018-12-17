Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27760C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5792145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH+O1yQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbeLQOfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:35:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45504 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeLQOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:35:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so10885677edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 06:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wX6e/LU2zyDCpBi2ezzJLPh9WEYD8C6iFJXZmGBAud8=;
        b=kH+O1yQLpK3n4H0G1nx8NAoKQDVYT0r0jq3bUagit9jmctdvasp4FB3ziA6on456gF
         rZqz/6N2OwxG8nnk3TgkiiQIKQO5YU86oKGjZl6UxX9faY9SfmEHZq0h46AU2T6Yptj8
         qi1eXiC9yLeEApfyla7OePn9VNA44LJfsVK1bUM3wpfO+WdLUbma+du3fK9YCUYZPujQ
         /4MKdOY1VUl9qz3Rwi/iCYTWbH5ZUiqqBmPPYLiuwEkIiUI+n9O6FBiKUkiqVkCDmJmq
         AuP6fz7s192Ah65EXAZpKLGEcxtNEKO1HyxfIW0XobhWADrvoJF0yzBQX0ZwiwsxWN8R
         rCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wX6e/LU2zyDCpBi2ezzJLPh9WEYD8C6iFJXZmGBAud8=;
        b=ElI6iS7KeWmwLgYefg/Qb2EQKSDuNnyCxDRns5sO6/6rY5VMDzeuDpElmIVwthUQRd
         3oYOjnjsh54vMDJz0ZMrjJdRfrKqW25wHmeJVjEoS8W2XsuwVhA5JW4UpQmv6GZlkX7f
         e/SC+Q410DUUOBV+Msd2Dhq2JiINDPmlIwPZ41A/EoJe5GIzCxarw7Bi3YvLL6vgOReD
         yuy94W2kjgqUtcY3YriFOI8qZcgpMjmTBdDfrMTkqrkOziy/UWvHrq5pGKW8MuX5SElW
         Ql9kSYayFG5xAlJrWtCLIb1vQr2OjWmaEyofS1AAX//ivN27N6NmjmL7w8WYh5hESs3o
         s20w==
X-Gm-Message-State: AA+aEWZ1IA1GppW2b2lwBtxQzVvlQc/AKlsPr/EOUTT4pG1HlO0J2J76
        Ryhkq8s1fXxw+r0JEHGvFOS/DnRY
X-Google-Smtp-Source: AFSGD/USNL91NgwXWOmWBwe1CSEgF23rlJqq1aeewbjoHBoAU/MxZDTXGgTldVNieESbIedaam8Gpg==
X-Received: by 2002:a50:b536:: with SMTP id y51mr12804094edd.201.1545057308549;
        Mon, 17 Dec 2018 06:35:08 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a13-v6sm1812103ejt.69.2018.12.17.06.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 06:35:07 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:35:06 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/19] mailbox: Device-managed registration
Message-ID: <20181217143506.GA29853@ulmo>
References: <20181121145429.7582-1-thierry.reding@gmail.com>
 <CABb+yY3G3VQGcEHaSZq3bUYrJUToP4oQOCns92q3S0Nr9W_09A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <CABb+yY3G3VQGcEHaSZq3bUYrJUToP4oQOCns92q3S0Nr9W_09A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 10:34:59PM +0530, Jassi Brar wrote:
> On Wed, Nov 21, 2018 at 8:24 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Hi,
> >
> > This series of patches adds device-managed registration functions for
> > mailbox controllers. A number of drivers can be simplified by making use
> > of this new API both in the error cleanup paths in their probe functions
> > and in the driver remove implementation.
> >
> > In addition to adding the new API this series converts all drivers to
> > use it. There is also an additional cleanup patch for the mtk-cmdq
> > driver that removes some calls to devm_kfree() that are not needed.
> >
> Any  Acked/Reviewed/Tested-by would have been great, but I see no
> driver author is CC'ed. Do you want to loop in authors too?

I didn't think that was necessary because it's a pretty mechanical
change. But I can resend with all the authors in Cc.

Thierry

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwXtBcACgkQ3SOs138+
s6FNbw//eAyzZPVJmYbXpzp9rz9cA7hByC6iHLvef3PWmhswpKGpmhY74Z0seZZI
zRZwwm8bhZkom26dNfHj2I0OzurUcyIIShkAjiXBJeb34IG4e0cv75BuZXagQs0e
m2TPVqKSOuYAemd4BPxTLfNykLnlmCvqQzqD2wLG20EUX30TKEgY0cG4Zmtkjl+0
fcKGL3yxDDANRCegt5tQpnwITW1462cl02r3eAYkoaKeekgaWqG0UbDwhFfHOoJ+
R9MLmvarIT9iXs4LnNczS8jl2MueDp108AeR44Ts8ygsyYTl+gcVzwFYjbr9zqog
+qUcrXKgqQC/ujEId/n0Z5Ozi50+OAqpvkcXYSxGkWm2ReNteouM9p3Kz22M4kfz
ngBV7ocO3msUqw2uCoOY+qEFEbeXU2ogzMKZda/vltqbJ4uVx43TG+aC115KkaQE
YiNMDv3fvrhz66mpeTDzr+MC0PrSgeMnvP1ZhL/BchpvjNuG3nfguhpXNzfq8A1T
5nyiZkOdy+i2trDM6ok+Mj+m3LzE5jRdtqNNjsC5AhmLJNthH+sZL5nwIjysatB/
6eZAGCC12T1hFIYOsob73BLUlWvtIo4nSh5RExmRp5QoRHqXaNlgrwC7rzRdB3+T
qVgyZrdUIkF9OVHO3KyFWKGlEfewjXPKz+YtJM8Ue9ClGbjjsa8=
=f90O
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
