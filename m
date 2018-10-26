Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD91ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54E420856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="jTt0m9YU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54E420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeJ0Fxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:53:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50630 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeJ0Fxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5pysEKxv4qBjNF2n0UoV+8KB1yAevpWIjfufMw6mPN4=; b=jTt0m9YU4g6ovtRGiWgFYn4qY
        qeAwtVPZ1Fa7jwb8+CvX2fEkKJFhQeNBnh9h37+dbXM2Oq/wwu8in+d/G9pfzB3RCEtcnnevDf8/i
        p0P7f11zNhnQoUBlXLCgKITZeVTSCd2f1a1zgQcgLlzFmLrQbIGuOkYQRYwn4e9wBQGCM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gG9Rh-000463-Oi; Fri, 26 Oct 2018 21:15:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 023E21122667; Fri, 26 Oct 2018 22:15:04 +0100 (BST)
Date:   Fri, 26 Oct 2018 22:15:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <rob.herring@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kirill@shutemov.name, Linus Walleij <linus.walleij@linaro.org>,
        boris.brezillon@bootlin.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>, jacek.anaszewski@gmail.com,
        axboe@kernel.dk, Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Git pull ack emails..
Message-ID: <20181026211504.GG27137@sirena.org.uk>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
 <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com>
 <20181023093521.dm3l5oen2j7etsot@kshutemo-mobl1>
 <CAHk-=wh6i5t5jYHrC-ZCdj8qoZWP3BptV87U=G9G4UyunzPf7Q@mail.gmail.com>
 <20181023200408.GA13179@chatter.qube.local>
 <CAHk-=wjVJ1w=MYXhu42+1rPybtztz+7q=KWo53nQmasR7R4SNA@mail.gmail.com>
 <CABGGiszsw=QXPwTe3mf26BG=Pxig6zGcXXJfRA+w0Pawrm5qpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Content-Disposition: inline
In-Reply-To: <CABGGiszsw=QXPwTe3mf26BG=Pxig6zGcXXJfRA+w0Pawrm5qpQ@mail.gmail.com>
X-Cookie: Kin, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 26, 2018 at 12:36:14PM -0500, Rob Herring wrote:
> On Thu, Oct 25, 2018 at 9:14 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:

> > Are there other situations where you might want to track something
> > _outside_ of a pull request? Maybe. I can't really think of a lot of
> > them, though. Patches etc don't have commit ID's to track, but it

patchwork gives them IDs and lets you do lookups using them, that's what
I'm doing.  You can get the ID from a git commit by piping the output of
git show into parser.py from the patchwork source, it works a lot of the
time but things like editing the commit message will break it (this is a
theme with my scripting around the mail stuff...).

> submissions. For example, with Greg and Mark B you can expect an
> automated replies. Mark's reply gets threaded with the original, but
> Greg's do not. For networking, you may or may not get a manual reply,

Mine *mostly* gets threaded, it's relying on being able to talk to
patchwork to figure out the message ID at the minute so if the patchwork
lookup fails for whatever reason it'll just use on what's in the commit
for the CC list and not thread.  That isn't ideal, especially when I'm
travelling and my network connection isn't the best, I keep meaning to
try to figure out a better way which would probably be based on git
notes as discussed earlier.

> maintainers apply. I've somewhat solved it for myself by automating
> checking linux-next, but maybe automated email replies to patches
> being in linux-next would be nice. While that's not immediate, it

Yeah, I do that as well (I have an outbound patch queue I rebase against
-next, this also tells me if stuff starts conflicting with other work).
I can see the automated e-mails be useful but it might be tricky for a
bot that's only looking at git to figure out which people and lists to
CC to ensure visibility unless we do the annotation thing, it's not just
the patch submitters that want visibility - I did the patchwork stuff
due to user demand for that with some help from Brian Norris.

> BTW, patchwork tracks pull requests too, so maybe there's a common solution.

Ooh, interesting...

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvTg9gACgkQJNaLcl1U
h9DYmAgAgGqWsn5eK9h1PSKT7VnEp54AXrQRntSymGcKChCE7gWIdX9ju9iftvIH
/M9//6gaba0ugGj9lFaUKXbLzfBpniTt0Tr9SazWRJeG7HteugXWjUoa1bF6w1tt
Vq6DvtycLSqUAhXQ9vT2QENc12MchJ6C+In/5spx+h8tXnwxcECShaCFn+DnwBQr
7MO0e8I3SEFvTxz2HTGokW5a2UZtohUSP+I75dF9C/FRWNSfY2faFlL4BbwEnW5U
tKqp32wHiNoj0ieY5b5iAc3ChcetywJVEL6N4XFqwJ4/8gN59lInubrOQMKkUqX2
/+vHxdtDhseedsAz/c/ZflD+fVgw6w==
=WjIa
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--
