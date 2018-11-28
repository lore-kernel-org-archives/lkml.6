Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E90CC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4972081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Itnlm02p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4972081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeK1UQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:16:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42119 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeK1UQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:16:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so21434539edp.9;
        Wed, 28 Nov 2018 01:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w3jTjRc1HLHClQXrBAEDRU7DDb7CT8XFNzumgazIGnc=;
        b=Itnlm02pUBXrl3ZPtTv9MUrZ1BNoAw+i5p9bAKNOvKThWMQZQN5zR7nqu7kZ/dhIL2
         npG8H4t+N6iwdp5US9bAz2CmnUmU6XBQGugoX08M61uLnD2bQk8DKijjT+/BZFcyfHaA
         EjZ0SncNHyr56Dj2Mzjdtdqg4Gvlj9Z54q+xUIAGH08QgUuWStx4ziKgS4PLXQ+fRqVs
         01NWshLeK9Ba/lEZnzWFJ+Nw3vj5+ZNA8aGUL0GINUibGNduQMY/aA1hvCDO4vAAWWjl
         QW2OGJq9BSDdjgrXM2bSGF7ERXy9aSmvLJhCusFz+9zluYVLryt76HL0MLlmR7Kzu5m/
         JsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3jTjRc1HLHClQXrBAEDRU7DDb7CT8XFNzumgazIGnc=;
        b=uK1VRgG6shgl2aDBf4rsvV/oFDoX0j2AP699JljDmZ+6wNz5loUaNvFl5puiwgKkHU
         t1wtAezXa9GpJGQ9KbszHyhxKvnu+PEZT1kqIk7+Lbhuus1RxrvsqglchgdNM0e1c5IO
         koTrKBfyS1U38Auldz4WNhmKVUG6XA8MM4Y111h50zgTPEsIY8co1nt98W7VxEyIFhaB
         tV0No1BXq3EO1SV0CxxRK+Qjr+Cjs7VBE1qXk6Rg39CBnHipogbTK6DUydapntNPR1Kf
         CndbOl1tx8APGwZtb3g7tWVuXd229KlJvFL8XC0XfDNDWZLyf7cGgi8cW7c+k5jW7ZH/
         3ssw==
X-Gm-Message-State: AGRZ1gIshCh26SaWre3XsWJiYKshsNRDugvEqlqZm8+nP4gWVONTXM28
        zdTQtU4Spx46ugVLEqkHHc0=
X-Google-Smtp-Source: AJdET5dM+KhFBynvQS2uI0aGFffULIMFA8BHf0DFr7YbGrh8HOsYOfoVo3QgrEXCXXzlReSjPTXBQQ==
X-Received: by 2002:a17:906:5803:: with SMTP id m3-v6mr26452302ejq.33.1543396514627;
        Wed, 28 Nov 2018 01:15:14 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id p21sm1564801edr.67.2018.11.28.01.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:15:13 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:15:13 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org, jonathanh@nvidia.com,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: tegra: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181128091513.GB17419@ulmo>
References: <20181123150104.27336-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <20181123150104.27336-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:01:04AM -0500, Yangtao Li wrote:
> Use macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/clk/tegra/clk-dfll.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+XKAACgkQ3SOs138+
s6H78g//eWqXRVmqbexbcbiZ8amJmllm9PsvDFGa8CjpSJgRw8h6a0gC1PqGGZ4p
kvRwnl77ymRCPgJNd2z5lRu2o5VDa7gPlmtOQKjwyrtcvWneoEkznRsWt3LQ7Lw3
p2a2w9GA/k+EUuwEa+X0b+sjOeb4s2dmY97b3QK7+tjwFPgxR3RN3/+OqjhHJlOm
7yosUtTdyjsdvjOj4IVYG8xs1RvpEd0IwDLQTly7o9d9qAyA8lr7+9PNEuqwwCq2
x4KlSa5svB8w1UGlTiBaXWfMhYMZ/OVQE7gFxq7X1t93qOk+c4B8XvzvU1aIuSQz
5O+s4jNgwm9B63Hat1Ya0Ez7PPciwOz1kM7mPkintRYGmI3ANweN0f+7dXXxOgO6
YF94POXmZDbwgdifCjWJ0BFqfMQlxZPTEAKbHmAagBkWBLMV+nnyj9BOhGLBxWng
k7BBUyM+2wFfGBTaOWYo9mgpgfrxWUDDU/7J+BQZJGVIxNJZc0mtbC20/Wuj1K2U
CHMIwH7IqUdc6XI8VqXyn6Hc0mO0pGn235uWQpeCkuVoJtWR7EDDIPmWyyVwBtt8
O861cu+kzURbURKcbn6Bez8YcYStLRnGODRS071sSDT28YYHSDKo6ky5lZ+2YoRx
qj/Ha/DJCD3od1B616Daq7gQX2xPNickpWiL2mz9Nq0PIl28i50=
=zZQo
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
