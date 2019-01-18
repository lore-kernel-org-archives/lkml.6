Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED1DC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BEF2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547833050;
	bh=dUbG0GyyPYOxbc8f/aP21xgHaDPPptDs3kmwixzfWZU=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=gUea7o559jl3sJTt0EnxtpFgGoZfrOJOWIA/wIWA8AWGTUWh+/oZ//DZpzKAskuDi
	 q/n6EhwO4TGtYdXm/EoTzaoorNHj+XK/qsYrdOZNVQLEJvobvvA254PNs79dMpjtfw
	 BRbu/W2pqR38YIRJdmp7Vfi3TS+UjL0j3X60V4Pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfARRh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:37:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfARRh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:37:28 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620122086D;
        Fri, 18 Jan 2019 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547833047;
        bh=dUbG0GyyPYOxbc8f/aP21xgHaDPPptDs3kmwixzfWZU=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=z0L2kYXXRbFDWMAB0rTEyhj2caq+EUaxVI0RHQKCNVVJuU2lBKQ58DTe//NhKTR1z
         5ye04ysyIFq9XNys2/Aw10fQViWGoCbAbprO6hoiLPvs6jFplW0GA5qWKfDJMw3ycO
         E4zmBoJCcUOi2mZ2XUWONlsbs0ZF6Xw234gkOI+o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: linux-next: Fixes tag needs some work in the clk tree
User-Agent: alot/0.8
In-Reply-To: <878szi3zp6.fsf@concordia.ellerman.id.au>
References: <20190116083440.11b6839c@canb.auug.org.au> <154767815973.169631.1738587342757192096@swboyd.mtv.corp.google.com> <CAOMZO5DSbVpha=1_s5K+-vodD+N1fGnj41_UKmvqxDOPhxXwfg@mail.gmail.com> <154775054438.169631.5111867106558251203@swboyd.mtv.corp.google.com> <878szi3zp6.fsf@concordia.ellerman.id.au>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>
Message-ID: <154783304655.169631.12906027462791855701@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 18 Jan 2019 09:37:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Ellerman (2019-01-18 04:41:41)
> Stephen Boyd <sboyd@kernel.org> writes:
>=20
> > Quoting Fabio Estevam (2019-01-16 17:25:21)
> >> On Wed, Jan 16, 2019 at 10:44 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >>=20
> >> > Ok sure. Does this matter to scripts? Is it documented in
> >> > Documentation/process/submitting-patches.rst? I've seen both types, =
one
> >>=20
> >> From Documentation/process/submitting-patches.rst"
> >>=20
> >> "If your patch fixes a bug in a specific commit, e.g. you found an iss=
ue using
> >> ``git bisect``, please use the 'Fixes:' tag with the first 12 characte=
rs of
> >> the SHA-1 ID, and the one line summary.  For example::
> >>=20
> >> Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()=
")"
> >
> > Yes but 'one line summary' is not clear to me. Does it mean the summary
> > line? Or the one line summary on one line regardless of commit message
> > column wrapping? Sorry to be pedantic but I can see how this can be
> > misunderstood.
>=20
> Yeah "one line summary" is referring to the subject of the commit.
>=20
> So it doesn't explicitly say not to split it across lines, it probably
> should.
>=20
> eg: ?

Yes, thanks!

>=20
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation=
/process/submitting-patches.rst
> index 30dc00a364e8..12a283ba3929 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -186,6 +186,8 @@ If your patch fixes a bug in a specific commit, e.g. =
you found an issue using
> =20
>         Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvd=
ata()")
> =20
> +To ease parsing of the 'Fixes:' tag please don't split it across multipl=
e lines.
> +
>  The following ``git config`` settings can be used to add a pretty format=
 for
>  outputting the above style in the ``git log`` or ``git show`` commands::
> =20
>=20

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Do you have a patch for checkpatch too? Maybe Joe can solve my problem.

