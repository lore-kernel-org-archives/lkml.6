Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748F8ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280592145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tEM0mk/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280592145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJSM6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:58:34 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46198 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726542AbeJSM6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 08:58:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D08348EE108;
        Thu, 18 Oct 2018 21:54:11 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oISp8a1CZPZW; Thu, 18 Oct 2018 21:54:11 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6CBA98EE0D5;
        Thu, 18 Oct 2018 21:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539924851;
        bh=iWBS837HpxOLEB1msdNNcGBsS1ydeC4ha5uhfuI5sUQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tEM0mk/M9jn4iwNz7WUiY0QhguEfMFzCckBfgPw21AvrTbaaEcyoPLBAMgE71BfiO
         sgNXu6W/JhxhLvWgTxiydC/72Srt66R3qDS3clm9CrPGU0E6RGpeXjnog1fNmLnsGh
         mhivGHpjMgWjcrVy8AkZBIHRWm0SnE49HxU4OSt0=
Message-ID: <1539924843.18970.35.camel@HansenPartnership.com>
Subject: Re: linux-next: build warning after merge of the scsi tree
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Thu, 18 Oct 2018 21:54:03 -0700
In-Reply-To: <20181019155034.2cf7f864@canb.auug.org.au>
References: <20181019155034.2cf7f864@canb.auug.org.au>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-t6+FJjiqLsyK2mQ5G4Ul"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t6+FJjiqLsyK2mQ5G4Ul
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-10-19 at 15:50 +1100, Stephen Rothwell wrote:
> Hi James,
>=20
> After merging the scsi tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>=20
> drivers/scsi/lpfc/lpfc_debugfs.c: In function
> 'lpfc_debugfs_nodelist_open':
> drivers/scsi/lpfc/lpfc_debugfs.c:706:17: warning: 'nrport' may be
> used uninitialized in this function [-Wmaybe-uninitialized]
>    switch (nrport->port_state) {
>            ~~~~~~^~~~~~~~~~~~
> drivers/scsi/lpfc/lpfc_debugfs.c:553:30: note: 'nrport' was declared
> here
>   struct nvme_fc_remote_port *nrport;
>                               ^~~~~~
>=20
> I am not sure where this has come from :-(

It's the merge commit ... it was obviously the wrong choice; I'll fix
it.

James

--=-t6+FJjiqLsyK2mQ5G4Ul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCW8ljawAKCRDnQslM7pis
hY0SAQC+UTjH/MHC0MlO40CsXZOqqa57+sxS9ALQaJ1uU72HaQD8DvXRaqc85GQf
3efCPD1vS0dideELBA/zVCBOgSSvmwk=
=bgKI
-----END PGP SIGNATURE-----

--=-t6+FJjiqLsyK2mQ5G4Ul--

