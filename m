Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BCBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9E521A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="nVHyTe4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9E521A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbeHGCGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:06:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47426 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbeHGCGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gFq+bCk+CACvqfb5lGpf/IZ/i4wWNQWgNy2g6GJr/VA=; b=nVHyTe4SqQSv6kje7IB0+teW1
        sxZSdWK3A4mLvgshVFMEsHbwuGZupDXSbPgqajQEWpyXyjsbxMMs5t9sepv+jDt9LwU4JWymeO2KH
        435aluiJbhpoPi+xTJiMtrno7/+ofxakYlrHrsW6osjvChIoZtUe4WF9InBDQB+G8nQPQ=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fmpL9-0008Qe-JM; Mon, 06 Aug 2018 23:55:07 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D5A36440078; Tue,  7 Aug 2018 00:55:06 +0100 (BST)
Date:   Tue, 7 Aug 2018 00:55:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180806235506.GU2414@sirena.org.uk>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk>
 <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
 <20180724152514.GJ13268@sirena.org.uk>
 <CAD=FV=WHJcAoR7Y_uhi7_GbVzy6K8FnovVFVRz8js0REONox=w@mail.gmail.com>
 <20180724165942.GP13268@sirena.org.uk>
 <20180726183922.GA4402@hector.mosconeconnections.com>
 <CAD=FV=VJN4vj9eU7wzPV8=WC_+MgRPYx1smF+FUmfDiP3uuTqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BVQ1RKc6+nLPB5pT"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VJN4vj9eU7wzPV8=WC_+MgRPYx1smF+FUmfDiP3uuTqw@mail.gmail.com>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BVQ1RKc6+nLPB5pT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 06, 2018 at 03:55:53PM -0700, Doug Anderson wrote:
> On Thu, Jul 26, 2018 at 11:39 AM, Andy Gross <andy.gross@linaro.org> wrote:

> > The arm-soc guys merged the Qualcomm pull requests.  So you can just use my
> > qcom-drivers-for-4.19 tag.  That won't change at this point.

> > git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
> > qcom-drivers-for-4.19

> Did Andy's idea of using the above tag work for you?  It appears that
> there are a few patches you don't need there, but it shouldn't hurt to
> pick them up too I think?  Here's what I see:

It does make my pull request look larger which is hard to get enthused
about.

> a3134fb09e0b drivers: soc: Add LLCC driver

Stuff like this jumped out for example.

> It seems like it's too late to land RPMh-regulator for 4.19, so I
> guess we'll have to aim for 4.20.  I'm not sure if that means you're
> going to want to wait until 4.20-rc1 comes out to use as a base before
> thinking about landing RPMh-regulator?  If so then I guess we've got

If I apply it after the merge window it's going to be based on -rc1.  If
I get to it this week I guess I'll have to pull in the drivers tag.

--BVQ1RKc6+nLPB5pT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlto39oACgkQJNaLcl1U
h9CxiQf+IPeB3+xZzo4H37XGT8YIYrCvtPobLZy5+AR9/Z3eWcjQmZsfv8IXpubA
a8lr2cAVApP+HeqR+X0ZjNPVWsw7m59v7Ug2GHM6YosgF5ULW4YcR650k5/iZ/EF
saAaWKW4YTnHAedaSPa9MnrXQPJgsG2S5h7ORauD42ANsQAytlJrulEcpx00Q1Id
3R25FR+7F1vrpHBRcg/eeNsh6jFv5rdidUSgXpsilMzoeeUbRei8ITyKEWnHQdX6
bHlIDQRTj7A9CX/GwwdHfN5fzo2oZb0aVWFy8pLrGNqmCgw34urXZAR0JJE7Wm/z
YICfllYPZTWTyWwCxnSkteXJq8a2XQ==
=WoXL
-----END PGP SIGNATURE-----

--BVQ1RKc6+nLPB5pT--
