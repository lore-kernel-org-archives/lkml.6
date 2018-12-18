Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08C9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0F721850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545139768;
	bh=tRfql5Xs9HQbRoXDjXErgH2XL2W2LOngSW68cwlGLS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZnPGwyhHyu1h9ANA/yInHo+TP4FwRcIn0A5di64Ta+qMfacji0cPQZKidbXMHrj55
	 yFmnzjqQhIP6E8bqadRnVOZ2gFZtxCYY8mT+bQEPQH/QwC5mOpgTOFAfYhj4YqzDmp
	 JyGkwqBenjFnZWdAEfdSbmcoflzxyCuDxf5XduEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeLRN31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:29:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41014 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeLRN31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tRfql5Xs9HQbRoXDjXErgH2XL2W2LOngSW68cwlGLS0=; b=D7IWkEknXaKIJiw51BAztHpVb
        GTq3s/g+NErqcpqAsVB5bfebZARbghHKyjenVhQMBUwkJX4yNelw+z8DNPfIao4cgDhh9cKw0QK2i
        1oc0bsIUAYZCXcJuJs1qkG0MscUvJyoh42WkyiBivu1+Hf+52Oiix61HGYBa1YPjuT97w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZFR4-0006vd-8V; Tue, 18 Dec 2018 13:29:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C3A891125500; Tue, 18 Dec 2018 13:29:20 +0000 (GMT)
Date:   Tue, 18 Dec 2018 13:29:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] config: provide a fragment to enable gdb for qemu
Message-ID: <20181218132920.GC6537@sirena.org.uk>
References: <20181213122910.24193-1-anders.roxell@linaro.org>
 <20181213122910.24193-2-anders.roxell@linaro.org>
 <20181213124042.GG10669@sirena.org.uk>
 <CADYN=9KBpcUSaU_P_sZuhin60huQUBUT-H-FedH=fXu7a_7EWQ@mail.gmail.com>
 <CAK8P3a1qn2SOsk_Uo_VDGSkR6OsDkqzm0Rbo+5F5Pc1WA3tJzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1qn2SOsk_Uo_VDGSkR6OsDkqzm0Rbo+5F5Pc1WA3tJzQ@mail.gmail.com>
X-Cookie: Do not attempt this in your home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 18, 2018 at 10:07:21AM +0100, Arnd Bergmann wrote:
> On Tue, Dec 18, 2018 at 9:45 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> > On Thu, 13 Dec 2018 at 13:40, Mark Brown <broonie@kernel.org> wrote:

> > > Is this specifically for qemu or is this just good for debugging with
> > > GDB in general (eg, via JTAG)?

> > I haven't tried, and I don't have a JTAG so I could test it =/

> The DEBUG_INFO=y and (as a dependency for that) CONFIG_COMPILE_TEST
> are definitely needed for all GDB operation. I would assume that
> the scripts also work with any other gdb environment, but haven't tried either.

I'm fairly sure the requirements are identical, though it has been quite
some time since I tried and I don't have relevant hardware any more so
can't confirm.

> For CONFIG_RANDOMIZE_BASE, I'm not actually sure if that helps or
> not. I think I originally suggested to Anders to turn that off when he
> was analyzing a bug, but I don't know if it helped or if it works just
> as well without that.

Yeah, I'd think it'd be helpful to turn that off.

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwY9jAACgkQJNaLcl1U
h9B/Zwf8C4cYwx1K9uypGPsaSQ3F/rBtCFDdfBPC+H/4BCdMceDK96oa9QogdaZK
rLSEQsyDyOwKLzdiQ3A534jEVnIkJrczuA6kN0IgzCHCy+MBgeuTnhKqgy7w/qsv
lfrHEEwtjk4vqyrhhe0C2bdoDnHRkchc6z0lDedDdP2DpOTMkcI/8n3D/4GXstUm
/M2hnoBYSVE/NMOp678W93EAJBkNhsBHOPSac1n9E+gAhoPhR83I8pNs2fxbN+fX
T0aAlPgtThxe9/9xp31n1OjS/T9kIPXyU/zb5IOvNUWZhwgb/Uzon1F+pcBlbBqG
HTBA1uHs/QXZXCHXbfEBmLA1hceUQg==
=FHMY
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
