Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA65C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089E42077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mD2Z8MEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089E42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeIEAiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:38:03 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:37066 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbeIEAiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x19rrKJXdrL7tbNEM8ddm08CujY08GlWjsTio/6A34Y=; b=mD2Z8MEHT7vunSDqGckqhU2D6
        jQLxffHkrTeNMV/9V5UNrcDQoHGOr56SkZOv7jhuPMG4N+QK1wS7nRNV++8/+Bm8bTnB9hIrcRxZf
        m1pJUo8CdBT3buT/Q8oL87V3yIGxkcW23YfvkM9xaQgn8eLMwYa95fwg4z53I+jzJqvkE=;
Received: from pd9e2ffa7.dip0.t-ipconnect.de ([217.226.255.167] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1fxHfS-0002FC-UM; Tue, 04 Sep 2018 22:11:19 +0200
Date:   Tue, 4 Sep 2018 22:11:09 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kishon <kishon@ti.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix wakeirq handling on removal
Message-ID: <20180904221109.54604ebf@aktux>
In-Reply-To: <CAPDyKFpHPre_turpYtpB+N+LHR+EMW2p2GJ92J1zu8h6p5W=LQ@mail.gmail.com>
References: <20180902073058.17053-1-andreas@kemnade.info>
        <CAPDyKFpHPre_turpYtpB+N+LHR+EMW2p2GJ92J1zu8h6p5W=LQ@mail.gmail.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7=6K2spKo_oqu0jpG3fbWO_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7=6K2spKo_oqu0jpG3fbWO_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 4 Sep 2018 16:34:56 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 2 September 2018 at 09:30, Andreas Kemnade <andreas@kemnade.info> wrot=
e:
> > after unbinding mmc I get things like this:
> > [  185.294067] mmc1: card 0001 removed
> > [  185.305206] omap_hsmmc 480b4000.mmc: wake IRQ with no resume: -13
> >
> > The wakeirq stays in /proc-interrupts
> >
> > rebinding shows this:
> > [  289.795959] genirq: Flags mismatch irq 112. 0000200a (480b4000.mmc:w=
akeup) vs. 0000200a (480b4000.mmc:wakeup)
> > [  289.808959] omap_hsmmc 480b4000.mmc: Unable to request wake IRQ
> > [  289.815338] omap_hsmmc 480b4000.mmc: no SDIO IRQ support, falling ba=
ck to polling
> >
> > That bug seems to be introduced by switching from devm_request_irq()
> > to generic wakeirq handling.
> >
> > So let us cleanup at removal.
> >
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > Fixes: 5b83b2234be6 ("mmc: omap_hsmmc: Change wake-up interrupt to use =
generic wakeirq") =20
>=20
> Applied for fixes, and added a stable tag, thanks!
>=20
What also might be critical (still analyzing) of that patch I am fixing
is:
It keeps the wakeup irq also enabled when the sdio irq is disabled.

Regards,
Andreas=20

--Sig_/7=6K2spKo_oqu0jpG3fbWO_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAluO5t0ACgkQfb1qx03i
kySTPw/+OGneOSwYXVhucGsyRSQ489fq5hX1hX/+hZiNZc8m+jb8tT1vxY9mqLAj
W9tC2aCARIXTRUi1/m7IaUx278Zv1WmbUZswWechQJoKiWLFdbed2KTcuH41tac/
5xyik3fnvmVfONPrYCkqbDdz/lzgPMI7WAoQY4G8Z4NRX3cGlfx/3MMjF4vxkAVy
13Y5C15ugE7NyQCpeoNUOc5ltmsHyS63GFryQjZik1i0khZDZxzXFrT56z+9ERpK
Vtc0RPsSJdzEP6qEOQTBJor174bBozkvAp0m2jHCnC83EWcqL7IoDbUWUnOUh2dX
pnNVPve7ZEgH0Zrq/++bfs0Z7VWZJVKQIUZIfElF/WPDh8McFRVscekv2fG1jYek
FLvk5bV3CE6+RgsVZG8T58YF11ifk7HW4QFMTacEejBQqqYusjQdRGRNahcPbuxa
LrdOndt7RGwGs8OZiGtzl7vI8YTZvj4Wgff6USzP/rDLfAOBDfL6KaBlt3CAHoN1
fAJ95chsv8SzA8U0+xXMhZGNkk2wPsv8lByKNqx/BRs4rqhi1Dm6GuN+nq0EgPDZ
C3yOEq/IoXqg6i1x35NR1yMjsk1gai6XUernvtiQ6qnNEHfdrj0lasmNwZhCsEDq
Td/IA5uX9QLf0NdLN1wzK3fiSks5GiP4/LdThtVmCKh0/2oUw/4=
=aY7t
-----END PGP SIGNATURE-----

--Sig_/7=6K2spKo_oqu0jpG3fbWO_--
