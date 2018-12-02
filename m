Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3717C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909C9206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeC62SaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909C9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbeLBJvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 04:51:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43300 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 04:51:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so4943485plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 01:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4s25vFae2x7GZcam/BUuHNlzwBlKB0tffzW4/g6MGlo=;
        b=aeC62SaObM/FTY8KJDj2eKww6y9MuuwSI3D6+Qrnkzbvz8OcrBO6zWf0S6CPIL6Ea9
         T6SKYr/MRll0YDL2pOtd6nmSTgXuTgVEo/uQHTty4wI4l24XXWI9yJBjIqxE2NBRVHm6
         Guw7nULkXCSTToNGGlAEuY4TYohawR632hTj+TGD4jXy/b030eKYQJ/7GOYPQhJAq6QW
         lxhyCXNnB0bwwOcMm1WsVeMLp7+wUHm1qobpEhVKW4u5ev0QIroOVWFzfIrlA/YGF8J8
         I+ETZCTUy+zYyzf9JDDzDLorGWdgWWQEZx7a41Yo26/uXbiMYuV0rzcHAO84wlezItyy
         ZVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=4s25vFae2x7GZcam/BUuHNlzwBlKB0tffzW4/g6MGlo=;
        b=tJZoE3GPVfzZQkUHHcFzBdm+4ljliBGpQINnVuKi6c7QSEoGXWljSLPWs48IPEgIbr
         DwRP10aEDCOt/4ie3p19VeAsaEZ+VFo6GGjmf66emXPO83ljGryPc7WNsmurkYoCdvPf
         v/nWJhSYYfNGR08CjP+RDn8DuU0rEOuzvvyVu9cBi4DvWy/g8/NuH4qY7UBxAg+nPerL
         FLZnJevXxANkEzT2VJ+YnrvpKOIb+OnO7KIzoHOq8N2Vl4yIY7SaMh/1msKVqthF+h2/
         LibXMAUR/lsU94jss6+kMae4h83+wLlKd16n/2usUKepeXF0pLx9UrbYSASQSv3ugVhZ
         ML3Q==
X-Gm-Message-State: AA+aEWYomt3D54RsVju0sY2TOgj6CpOL8+EJlSaghSzhBM5KgsctpM+P
        FmjLzGdPWN9RRB8dQSMuiK4=
X-Google-Smtp-Source: AFSGD/XHadD86Xca90MWnDM63smpcmE4tvj2SrVLDNWNwn0rirP5IZqqXZmdVWuP8xch9uYX2KtZ8w==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr11959615plt.157.1543744307470;
        Sun, 02 Dec 2018 01:51:47 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id x26sm12896818pfn.50.2018.12.02.01.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 01:51:46 -0800 (PST)
Date:   Sat, 1 Dec 2018 23:51:44 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drop silly "static inline asmlinkage" from dump_stack()
Message-ID: <20181202095144.5jv6txelrcswjqpf@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20181124093530.GE10969@avx2>
 <20181202073338.aqkrezckv3mbqfj4@gmail.com>
 <20181202090254.GA3896@avx2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zc2mgkuzzzffxaqv"
Content-Disposition: inline
In-Reply-To: <20181202090254.GA3896@avx2>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zc2mgkuzzzffxaqv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2018 at 12:02:54PM +0300, Alexey Dobriyan wrote:
> Empty function will be inlined so asmlinkage doesn't do anything.

Yes, that is an example of a perfect explanation to have in the
commit message :) Ack from me after that addition.

Acked-by: Joey Pabalinas <joeypabalinas@gmail.com>

--=20
Cheers,
Joey Pabalinas

--zc2mgkuzzzffxaqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwDqy8ACgkQ2rGdfm9D
tVIxzQ//WjCum6lgLvW2jbZ8py7uf25hUXKDSnTKIUvSAWPmPZOWB5RcJsslelRA
cPmxWPrwRVEjvzFkcSmVFo7QmJ7QR/tqVpDVnv5plwWCEbdOgmWtwinAhe27INRf
D9FYsqqIvBmONTcPuGH8sPIm2xRs1mwRj0elln+iU96c1rOxOtNk/K6d+z9qsmL1
XHqV8+yKewFxFYahUsinfExixa5F+5swiqEbq8Z+MgUMd/sHJv3ezp7q6XI3LrdT
QmcpGbs6oUwyXljm4uknR95v+CFZKRjqbNW+PnlZGE/Dke35CMGMP3iKqsfKLQa3
Ao8mgn5NrqNSp+w9WmSBY9EZUqFlZat7+O+XuBgJ0xUgyv3JFFHgiQSXGidUDHnp
hBkGVVNpYH4BSv6Juz5VYX9veZGZX9SHuDtFlRWskgNR9VvTkNadapxBwcPZR3xY
RgeeCtBsDGmfs8miwoJE8MMlzVzamGHyvtZ6X6Z+dc38gzyw8gZDs1A+3BCPunZk
DPKj6IbgCPTJ/qnRdSPqLmRW9zCHeDw/74jOijoqzqdxc8g9vkb4XDKJaP2AJB8B
NDRH/nvX7MsaHarPikLOutW6muPNLSxnXiy58fm72gY0Lr8aGuG04PRUY69fVm3z
9Vsx1enopS22bTjuEjDt1subE708iWmbzKC9s6Iq44/lomuCGvA=
=+COU
-----END PGP SIGNATURE-----

--zc2mgkuzzzffxaqv--
