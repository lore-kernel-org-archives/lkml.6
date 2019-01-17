Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C7BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411AD20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547746089;
	bh=5CQ/ckVg4Q4+JCEtfSQaagWBHcqtYYvffKNeAMzLnqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WcJvQYXmNA9mygV3ZgbLh0u1cQVPFrsmGA5n6YDC87mFdl1QXW5IvgdpzOG27DpxP
	 iMzZyk+GlPLKnJKElV/TRVtPHP0E0P9mVqREIad4Of/bkWpgX/MTMvi3KubTy7GRB7
	 w7IbYKphAbBrbjk5Garx+DWBDuwSUbvNTcbTHO1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfAQR2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:28:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35458 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfAQR2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g+0s0UFDxyuc2bXEoXz5hpTKIk6Cd5FmS7nP9fV0m9g=; b=Mm1mrd2YlTmSSPw3s85aohY0F
        6Dvlo1JDstjI/pm5FKjgtLe61uF8SOPIW0pxxxqdJbwXLmfk2nqe3nfJuM14Ornjks90HhEeUSc+K
        x2jO73GAUSbAOf4+R1cZbb1EBnTvzNPA6lOQdc84KvHQkNtsxk5zlUpTXloaN20Y96Guc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gkBSQ-0001Ke-V0; Thu, 17 Jan 2019 17:27:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 502AA1126FE3; Thu, 17 Jan 2019 17:27:58 +0000 (GMT)
Date:   Thu, 17 Jan 2019 17:27:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     robh@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, benjamin.gaignard@linaro.org
Subject: Re: [RFC 2/7] domainsctrl: Introduce domains controller framework
Message-ID: <20190117172758.GD7003@sirena.org.uk>
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
 <20190114144202.27315-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <20190114144202.27315-3-benjamin.gaignard@st.com>
X-Cookie: sillema sillema nika su
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 14, 2019 at 03:41:57PM +0100, Benjamin Gaignard wrote:

> Configurations could be applied with functions like
> domainsctrl_set_config_by_index() or domainsctrl_set_config_by_name().

Do you have any clients in the works for this?  It seems fairly likely
that everything is fine in terms of setting the mode but it'd be good to
confirm that's the case.  The main thing I can think of that might be a
problem here is how you'd handle a case where we were talking to another
processor that owns the permissions, we'd probably want more ways to
query state there but I'm thinking there'd likely be some other higher
level way to talk to the other processor there so perhaps it's moot.

Otherwise this all looks pretty clean and simple, there's some handling
for probe deferral in there which is the only slightly complex thing I
noticed.

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxAux0ACgkQJNaLcl1U
h9Cjsgf+MC6ahPfTbEWy737MbALEikQaTp1QtfUFekmwX0bVdZK0VlR0EW3KqTQY
v6T/UlYbHdkM1VjKZeLPhjst6+YJ+y0rtSfqrBQuPJiuhWv9/PbMIfcvS7I1ERow
AyNBLirU80Gg1pBDwgkZm3WKG35MYos+H+445Us5W8AAXgVoHxVY9hpQ5L/R2KOG
OCaYkbavoicXGEkQIlkv2zVS6GVVBeiJ3omjXNoT+8V9moQpM+DgYqaTaoSv5IH1
CwT/Tl5YwtyS2NgxoC/rS9Bw7104bl67//dfdaXDTcI1rDCnSgN5SbRXAOVAWzPA
D37p9LF9w2LstHkhEd6R2VqDybjz+g==
=n9+8
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
