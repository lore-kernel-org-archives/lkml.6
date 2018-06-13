Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 87E55C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E560208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E560208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935839AbeFMXVq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:21:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:35280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935540AbeFMXVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:21:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 171D8AC25;
        Wed, 13 Jun 2018 23:21:44 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     James Simmons <jsimmons@infradead.org>
Date:   Thu, 14 Jun 2018 09:21:37 +1000
Cc:     Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 11/11] staging: lustre: centralize setting of subdir-ccflags-y
In-Reply-To: <alpine.LFD.2.21.1806132237140.12664@casper.infradead.org>
References: <152826510267.16761.14361003167157833896.stgit@noble> <152826511930.16761.12770722873423628004.stgit@noble> <alpine.LFD.2.21.1806132237140.12664@casper.infradead.org>
Message-ID: <871sdai872.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13 2018, James Simmons wrote:

>> We don't need to set subdir-ccflags-y in every Makefile.
>> The whole point of the "subdir-" bit is that the setting
>> can go once in the top-level Makefile.
>>=20
>
> Nak: When attempting to build individual components I get:
>
> ~/lustre-upstream$ make SUBDIRS=3Ddrivers/staging/lustre/lustre/lmv modul=
es=20
> -j 16
>
>   WARNING: Symbol version dump ./Module.symvers
>            is missing; modules will have no dependencies and modversions.
>
>   CC [M]  drivers/staging/lustre/lustre/lmv/lmv_obd.o
>   CC [M]  drivers/staging/lustre/lustre/lmv/lmv_intent.o
>   CC [M]  drivers/staging/lustre/lustre/lmv/lmv_fld.o
>   CC [M]  drivers/staging/lustre/lustre/lmv/lproc_lmv.o
> drivers/staging/lustre/lustre/lmv/lproc_lmv.c:38:28: fatal error:=20
> lprocfs_status.h: No such file or directory
>  #include <lprocfs_status.h>
>                             ^
> compilation terminated.

Yes, I noticed that too.  Thanks.
It seems to suggest that subdir-ccflags-y isn't really a useful macro.
Maybe we should stick with cc-flags-y.  It is much more widely used.

Thanks,
NeilBrown


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlshpwEACgkQOeye3VZi
gbmu4A/9EHPDQ9enTDzDYgcKpvfVoptN7WvI2IBTV1Yvtyxa5w244sJMrIzOIAN6
mq1/RexZ7TCDqE5q6R7Z+ylI4++3vIbQ2aZeHzB5eAzRzgdi6Ba4g2wtRFSMaOgq
NB+AcoCfru0KRUziocsqvVKc9EJvfmmgpgX3iWwq8VQ5ZTr7C8nnz7gLhk8KI3Eb
1aQhc6REdkRdNzFXqt1SNUv2O0TKYhVN9C2rQI08xXPboRJm3AFJj6WUPkYnCo9w
cqJZUPM6Z3fwewHTq8SSg9cJvVNdu37JbKP6msS9z/jzdSn+wgzG9L4wAntTd5ev
3FRs6EkCV+fQ98kL5iLzYkhRnAOAbasOL8hEmPTml4FDteiZpSKoghBIbBA4PLGq
1jhgQyKVdCNmlWq/QkyTCmFMkf+GmOm3yIYCdFukNorKnND46X65hlU26ikQaXEP
TvvM7ugR9Fh1XMzl89HSlyJ0/WGOn2UzOE3zsyaxVvIlXibmVxNNkQvwN7TUnJEK
9RAC72XUtcCE8LRzkb6UaJAweFOtQLwF4EG2a67z7c1vcS9zIv/ePTJibmopDvli
SlrOH+UyGObdnBL4Bmig+uywBsavcCjYjCp3BfggMcF76mbEGtrWrF0wrfovO2hv
0ScqQroz2PjP7oJHmplAdjFY9ICpBNgXrgP1JZWBR9EOzFzQsIo=
=vgTl
-----END PGP SIGNATURE-----
--=-=-=--
