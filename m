Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA55C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451422086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xxR6SuKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451422086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeIJWgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:36:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60292 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeIJWgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mLrntdNq2nCeE3K+Fix0ZRoq+ZJBEOa0Bp3DXrTsBug=; b=xxR6SuKTQklOJOvKfE62x0DHD
        /k1MTb4CPr6yvHKpeoL4zVDKbXHGdc/LNF3NOFdZOmcoCRsJnnU1igYt9eOzu63xNaZFSz9HIyq1N
        7rOXvASyJEFhmYxYhk0HyqGzrTlOP6QwQxg07Zul6s+Rt62zzC34HslpIakxNuz4N6KXs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzQBN-00027f-27; Mon, 10 Sep 2018 17:41:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9850A11227B6; Mon, 10 Sep 2018 18:41:04 +0100 (BST)
Date:   Mon, 10 Sep 2018 18:41:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        David Howells <dhowells@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linus.walleij@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] [Resend] Possible sleep-in-atomic-context bugs involving
 regmap_lock_mutex()
Message-ID: <20180910174104.GD10889@sirena.org.uk>
References: <9bcef57b-1a5c-cd16-8e44-932ef3be08cb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <9bcef57b-1a5c-cd16-8e44-932ef3be08cb@gmail.com>
X-Cookie: You must be present to win.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 30, 2018 at 10:34:20AM +0800, Jia-Ju Bai wrote:

> My static tool DSAC reports many sleep-in-atomic-context bugs involving
> regmap_lock_mutex(), so I wonder whether this function is possible to be
> executed in atomic context.

Have you actually analyzed the code paths that are really taken here?
Static tools really don't cope very well with the pluggable locking in
regmap.  If there are problems I'd suggest reporting them to the authors
of the drivers using them, it's not really anything to do with regmap if
they've messed up their locking.

> Here are some example bugs and their call paths in Linux-4.16 (from bottom
> to top, and [FUNC_PTR] means that there is a function pointer call):

That's quite old now...  not that this has been rapidly developed
recently but still.

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluWrK8ACgkQJNaLcl1U
h9D2Ggf+IRS/Vo6RNxCedLlyo6Clb2Lft0qW0jvtMBVOpOLeTe3zF394SWdyz+cC
RCRqSfDSc0EotIjip8x01HfCsKAGLHSmsnVhVHkiVC7h68lOJvDo9yHOdqTJJxrB
cSno1c7dRPbE8xPtgYcw+RXh/PmWYwnIgYryv7yyzFfWOYifd/6Psrcctl4y06bW
+W9yj3WRxABuL206Ww/chnz8zEGOLknisL+CxO971buZ6rme1DnQjBDYwMO652Xm
u4l4FK4lPQxxTi50vcKfrg2Xq/vzwsJQk8DY1pt5k/Kmr8hzSeM2P4OtQqltoRx3
bgcNWu5Hghq8f9GqAx3p6Zzryj//zA==
=WEKA
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
