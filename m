Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA833C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAFC21546
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tDjby+w6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAFC21546
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeI0DmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:42:17 -0400
Received: from ozlabs.org ([203.11.71.1]:52353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeI0DmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:42:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42L9y06CvVz9s4V;
        Thu, 27 Sep 2018 07:27:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537997241;
        bh=6LGXLue76dgjClJzn4NJzzdsfCOU+5IejgutFRs7bgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tDjby+w6QiWGWKWyTqU/uTinYoF7MJE/KfqEEIwTa/vlyyHaN4cKYml1foDCPzuB0
         FktqxHkPO7NOLpf0oCBWGmtRZyCHglPGy5yiJTmSWpcazRfQHTdvxp1BwvEw9x9x71
         mjnFPSEtB4ArRg1UOk3WUNxrwBlT0stk8n9A6jakBM5uVXBs4HDLrisaM8U4dtXI3T
         ipWJYeYlMHw9La7o6BZpXdlehIwcnsuoxtgNP1M7eeF62Ygo+FkPabdvCPxmxfrFEm
         9pjnlWbuIam6jtSy9Y03D67qneJ4VsISJ6TVNIH/F2aXpihbiyqoY2iYSsKUIuB5Pm
         IQI7SJ+IcSUMA==
Date:   Thu, 27 Sep 2018 07:27:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        linux-next list <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pci tree
Message-ID: <20180927072705.3cbafb12@canb.auug.org.au>
In-Reply-To: <CAErSpo6CAMrNafXPcdkYRgZsNtBj+zOdWoAKqG2r5h-jDCaVJQ@mail.gmail.com>
References: <20180926150051.6ee97aae@canb.auug.org.au>
        <20180926142540.GB14407@localhost.localdomain>
        <20180926145820.GA14688@localhost.localdomain>
        <CAErSpo6CAMrNafXPcdkYRgZsNtBj+zOdWoAKqG2r5h-jDCaVJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4d_gddnm/a.Qnb+xh7/HVda"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4d_gddnm/a.Qnb+xh7/HVda
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Wed, 26 Sep 2018 14:48:10 -0500 Bjorn Helgaas <bhelgaas@google.com> wrot=
e:
>
> On Wed, Sep 26, 2018 at 9:56 AM Keith Busch <keith.busch@intel.com> wrote:
> >
> > On Wed, Sep 26, 2018 at 08:25:40AM -0600, Keith Busch wrote: =20
> > >
> > > Thanks for the notice. Does this mean you don't have CONFIG_SYSFS? I
> > > must admit I missed that connection for building slot.c.

Yes, it was an "allnoconfig" powerpc build.

> > There's unfortunately second bug here when there are no slots, which
> > would be the case without CONFIG_SYSFS: the slot list is empty, and the
> > function just returned success, but it should have gone to the default
> > secondary bus reset behavior in that case. I'll send a patch shortly. =
=20
>=20
> I folded in Keith's patch for this, so you should be able to drop your
> workaround, Stephen.

OK, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/4d_gddnm/a.Qnb+xh7/HVda
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlur+akACgkQAVBC80lX
0GyYOQf9ERGOjpU5wBwCa/QlTrqDzTz71BIA1GWH2SDWFqtChG69h8yPQPSoOFVo
KZ6EFvt+Ix4mQV1HYn8Hl19qMrnbCBQF9PPKjkpaHd5jEhZI95+6wdgVzcjihIK6
ILTIPGTXNqvG1tkiHJkyV8HGzjG/Tywzzs86zaGHGXmBKEvi8NEWgYNAYZQY1hAi
I7opCoN00EfX0JJrYB6RwJNbKw5y2qRgHZDtYz2Iv5+/PMS4Y+pVDU35MMjSDkwF
0JSkMLbPAIy9f9iGhDPTM9DWAx4e1LN3+VwO1oFJWBIkqxVNlnbC2AGxYYIr/3xO
5Ila8BeM+frVgnFOCRiMj8jv61xATg==
=xfXF
-----END PGP SIGNATURE-----

--Sig_/4d_gddnm/a.Qnb+xh7/HVda--
