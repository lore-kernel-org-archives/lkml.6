Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C38C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118542086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mLddqb7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118542086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeIJQUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:20:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52686 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeIJQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0q8FcFuG2vhFqpzEcw9j34YYz/LpXgWN7kA44u0TLf4=; b=mLddqb7zeLcqwp6UiNLrMrgqb
        KM3WYstE0EckZ05ClZpEY/NLMfv9QQFSwZy3C83tuoiWR0rDRDfwU19Qy+v0zoi6i1WQ3quXy9g5i
        eb7vSjDqtJM1B9qNP2ZtFfzSj8MhGdKr5C/GNCjTsUULVdwx9kXSkTR5c1DNMXE9oKCNk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzKKw-0001v8-4t; Mon, 10 Sep 2018 11:26:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C6ED21122D51; Mon, 10 Sep 2018 12:26:33 +0100 (BST)
Date:   Mon, 10 Sep 2018 12:26:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     dkota@codeaurora.org
Cc:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <20180910112633.GC5856@sirena.org.uk>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
 <CAD=FV=XigmU1LXnNbj9NYkjJmj18chBFjbctrBeOKoS=34PLXw@mail.gmail.com>
 <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
 <CAD=FV=VzYYyive--RzN=_OCQnFT-wgHwbUy1Vao2-8GADxHDLw@mail.gmail.com>
 <c4982ce3fde57c86387cc906332f6d48@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline
In-Reply-To: <c4982ce3fde57c86387cc906332f6d48@codeaurora.org>
X-Cookie: Yow!  We're going to a new disco!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 09:27:09AM +0530, dkota@codeaurora.org wrote:

> > The thing is, we want it to be 100% reliable, not 99.9% reliable.  Is
> > it somehow wrong to add the spinlock?  ...or are you noticing
> > performance problems with the spinlock there?  It's just nice not to
> > have to think about it.

> As I said, timeout will be handled after the calculated time as per data
> size and speed. Enough time is given for interrupt, there is no chance of
> interrupt occurrence during the handle_fifo_timeout(). So there is no need
> of spinlock.

Assuming nothing goes wrong - the system isn't under unusually heavy
load for example, there's some oversight in the code, there's no impact
=66rom power management causing things to run more slowly than you were
expecting, someone uses the driver on a new bit of hardware where there
are extra considerations or whatever else might go wrong.  Like Doug
says unless we're in some performance critical situation where it's
worth thinking *really* hard about how things really are actually safe
even though they might not look it it's both easier and more
maintainable to just write software that's obviously safe to inspection.

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluWVOkACgkQJNaLcl1U
h9Ce8gf/fH5lR8ARDcJnSRV/4P2TV3BomCulX955Trd9bkozncvpodqmmOsiU0af
TFpR91BJ7DBS/gOFEoxjJETYYjzm9+X+0aIhPa5y8bU15O7y5Oe4CXzZM8RFHqqs
0FaCsFYUwRcun4L8C+Lj6QRuDx4KGdlQXdnUS/1gLaie/z1xO+bKoSA29uyVqwH2
0FCIzXrSouVcyk7vt4xRsHilSQfwpa9J3IBKL45+9ObN6vcpGzhXFwa9lVZ4jeo/
yL37rQH+dNzniCBVSSjr1Isq/SJXjuFGygtRF4Y0wkmhZXEIFlh+e0Te3tpr1oB/
rkLDA0HcOBTYxEApAMdfD6Xhu+soag==
=VKo3
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
