Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1E7ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFB621550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFB621550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389991AbeIUUQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:16:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41476 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbeIUUQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:16:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 22BCE20901; Fri, 21 Sep 2018 16:27:13 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id D5456204AE;
        Fri, 21 Sep 2018 16:26:53 +0200 (CEST)
Date:   Fri, 21 Sep 2018 16:26:54 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     airlied@linux.ie, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: sun4i: Fix a uninitialized variable warning.
Message-ID: <20180921142654.ahuhswypvscjsuyj@flea>
References: <1537255520-41614-1-git-send-email-zhongjiang@huawei.com>
 <20180919084719.6ymf6h4eftomfab3@flea>
 <5BA2106C.2080007@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ayc3oltgnjlkh76l"
Content-Disposition: inline
In-Reply-To: <5BA2106C.2080007@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ayc3oltgnjlkh76l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2018 at 05:01:32PM +0800, zhong jiang wrote:
> On 2018/9/19 16:47, Maxime Ripard wrote:
> > On Tue, Sep 18, 2018 at 03:25:20PM +0800, zhong jiang wrote:
> >> Fix the following compile warning:
> >>
> >> drivers/gpu/drm/sun4i/sun4i_tcon.c:1088: warning: 'has_lvds_alt' may b=
e used uninitialized in this function [-Wmaybe-uninitialized]
> >> bool has_lvds_rst, has_lvds_alt, can_lvds;
> >>
> >> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> > I can't see any code path that would lead to an uninitialized usage of
> > that variable.
> >
> > Which compiler produced that warning? I tried building it today with
> > gcc 8.1.1, and I don't see that warning either.
>
> I indeed  hit the issue.  the gcc version is
> gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609

I've tested with 4.* gcc, and it didn't report any error. It seems to
be a false positive for this particular version, so there's no need to
merge that patch. If more people are affected, we'll obviously do
something about it though.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ayc3oltgnjlkh76l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluk/60ACgkQ0rTAlCFN
r3TacQ//bSkkQxX7E4oJAxcF8drs6U518u9hj56SRGi/1OvPryJOC5C6C05lFaju
24Yr/qAa0drigSn7HAWqNZ8jXpHl1L2ckAwXxAbwoiq0LWGcylLr5KpDuvB7UauP
9tmir0ioLDJgm8U84CX8bHBzveYtScEkNJtiURCqc5B6S01L9NgCGI9Kn1D8yNDm
vgLS4rBK+Si3HAVFk8sNfegI5mV6LRD4ktHmz6taaG4U+QwGcboEd5J8Iei4PNpv
1BP/KVNWjThWOr5KvOZSdDex21kriAarmgtjXNxKl7ZIk3mrFOfb/UQJmMYZzY7k
QwaVHMGMnCWWRC6LWGlCAvXtII52GJ34LYUxCQIzk0I0aojd/1gO5BSh1+UdrGMC
3Qi8Nuk1bydued8M/dbUFwRBO09LpQKjNFIasz5nBeizls77J5wWM2g+3b8lLljn
04f6DX0RGQ77MINx37T0qVq9mpiJVbfw+1FJAyQwGKheA4G9FvmpPb6WB5icGF35
PBasmd/ummaw7bTeVS+cpey1suu1039BSLUcf26ugYlJsirRzegOHEzYAT29gSwv
I8OemphfVific8+4mHIVJ9wxQCFKKlo1zu7yBrgUQjQaiGfqMV+ZQDJes+ETnl7Q
SIXGlgFbN7jhgTme+VT+rAKe9IIlzAHSG9uOgrIdlxL8eb4OXbE=
=5SCw
-----END PGP SIGNATURE-----

--ayc3oltgnjlkh76l--
