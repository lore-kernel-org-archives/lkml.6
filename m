Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2AEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B6F217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfBGAx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:53:56 -0500
Received: from mx.gwdg.de ([134.76.10.20]:46075 "EHLO mx.gwdg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfBGAx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:53:56 -0500
X-Greylist: delayed 1767 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 19:53:55 EST
Received: from mailgw.tuebingen.mpg.de ([192.124.27.5] helo=tuebingen.mpg.de)
        by mailer.gwdg.de with esmtp (Exim 4.90_1)
        (envelope-from <maan@tuebingen.mpg.de>)
        id 1grXUQ-0006yD-PV; Thu, 07 Feb 2019 01:24:26 +0100
Received: from [10.37.80.2] (HELO mailhost.tuebingen.mpg.de)
  by tuebingen.mpg.de (CommuniGate Pro SMTP 6.2.6)
  with SMTP id 21667922; Thu, 07 Feb 2019 01:25:26 +0100
Received: by mailhost.tuebingen.mpg.de (sSMTP sendmail emulation); Thu, 07 Feb 2019 01:24:25 +0100
Date:   Thu, 7 Feb 2019 01:24:25 +0100
From:   Andre Noll <maan@tuebingen.mpg.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Nix <nix@esperi.org.uk>, linux-bcache@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: Re: bcache on XFS: metadata I/O (dirent I/O?) not getting cached at
 all?
Message-ID: <20190207002425.GX24140@tuebingen.mpg.de>
References: <87h8dgefee.fsf@esperi.org.uk>
 <20190206234328.GH14116@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/T5g/TLNXpBPJeG6"
Content-Disposition: inline
In-Reply-To: <20190206234328.GH14116@dastard>
User-Agent: Mutt/1.11.3 (eeed901d) (2019-02-01)
X-Virus-Scanned: (clean) by clamav
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/T5g/TLNXpBPJeG6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 10:43, Dave Chinner wrote
> File data readahead: REQ_RAHEAD
> Metadata readahead: REQ_META | REQ_RAHEAD
>=20
> drivers/md/bcache/request.c::check_should_bypass():
>=20
>         /*
>          * Flag for bypass if the IO is for read-ahead or background,
>          * unless the read-ahead request is for metadata (eg, for gfs2).
>          */
>         if (bio->bi_opf & (REQ_RAHEAD|REQ_BACKGROUND) &&
>             !(bio->bi_opf & REQ_PRIO))
>                 goto skip;
>=20
> bcache needs fixing - it thinks REQ_PRIO means metadata IO. That's
> wrong - REQ_META means it's metadata IO, and so this is a bcache
> bug.

Do you think 752f66a75abad is bad (ha!) and should be reverted?

Thanks
Andre
--=20
Max Planck Institute for Developmental Biology
Max-Planck-Ring 5, 72076 T=C3=BCbingen, Germany. Phone: (+49) 7071 601 829
http://people.tuebingen.mpg.de/maan/

--/T5g/TLNXpBPJeG6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSHtF/cbZGyylvqq1Ra2jVAMQCTDwUCXFt6tgAKCRBa2jVAMQCT
D6DyAKCR1mgnr+k1DigFJ3ecqGlOH6enywCggXSpPLjRVepKu8maddVQk5KMF9I=
=1sEJ
-----END PGP SIGNATURE-----

--/T5g/TLNXpBPJeG6--
