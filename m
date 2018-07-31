Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6691AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B97D208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="sPTBV7Fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B97D208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbeGaISY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:18:24 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41742 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbeGaISX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:18:23 -0400
Received: by mail-io0-f195.google.com with SMTP id q9-v6so12024140ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=WOSrughz8sHEt+Ic1xQG2QZB6nVIIH2vVO5/u2/GqAQ=;
        b=sPTBV7FpO5bHL7NV2o0/IA0hMTzEFoFdln1W6/GxDGjKmd9HC8qQIKjQtdpiVA+fV5
         hsIXjYGSAf97vd1CvRYIZC/L+8VfyoHOxgXbPZfPNIvsyh8VzKOT7QWmbQ/4F/po2HMV
         RRdA6wvjnnWqLtKY6gfEKWm++LMpC4sRaTJRp63oJZsW0fMu3hMvjkCXftrCesI/USTu
         8QenVFxgSRbwBpGGVVxUgS+ogeqF2euHGzfFIgvlhaeTBJH5y+0vtqzDEDpBrFM74Cnr
         REwmoTg1gzx7c4xN7kY8EATTTAvlhHb/g1sAhbO03kTyoHQbL3BFMrNtLPxy5OA9VFeE
         5LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=WOSrughz8sHEt+Ic1xQG2QZB6nVIIH2vVO5/u2/GqAQ=;
        b=D96jaiKYw7NBE5k9GuerCybCIDZx/VGYLBK5WLk6rZHcEdVUkD0O81iY2i+HNVPyMm
         Fsa3EkvzVzCRoIoFX60UZMaHCP0FTKTNfgvpIp0q75kENgUDCVNZSSyvKHgfutSk6vsF
         95EuhT7SHkV5ZgjpLfOJMEIkWcdCm5XC578ONHcwzVfDNiE6jpKOlN8rDMuSY9c9B/U4
         Cd/TJiGePf32GWRYQU0YyiPtgS+ZLLTT2UJpkxgxzXrH9mOWeOGCvARGbW2qxyTRCviS
         jYX66FtDBJ5sCZldkAQsjGKc3LN6FXtXbkk8ldmpixHtcU3PCO0k/n3Fv6GRwBSW8Hku
         GNMw==
X-Gm-Message-State: AOUpUlF1Z+FmtvvX4d9obN/ioQYIvIhyDeeNcOgaPKvM6utQao1iijHV
        NXdz0ufkbs8Ykp6T9PEEEWIz9g==
X-Google-Smtp-Source: AAOMgpejEfcuNNPe6AwgEly1tZXLpoe5TQKQKI5AaMMCXHBqlzXSygPHnDhRefGk09EG5bkc2G0dUQ==
X-Received: by 2002:a6b:8c41:: with SMTP id o62-v6mr15948550iod.84.1533019178604;
        Mon, 30 Jul 2018 23:39:38 -0700 (PDT)
Received: from cabot.hitronhub.home (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id b81-v6sm842901itg.6.2018.07.30.23.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 23:39:37 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E3E7B6AF-3819-4998-9B12-DACB4EBC14F1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_10DC5A89-BDD9-4578-B2E7-CA670E54AF27";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/3] ext4: super: Fix spectre gadget in ext4_quota_on
Date:   Tue, 31 Jul 2018 00:39:41 -0600
In-Reply-To: <20180727174654.bnooz26puuo7456w@treble>
Cc:     Jeremy Cline <jcline@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
To:     Josh Poimboeuf <jpoimboe@redhat.com>
References: <20180727162357.30801-1-jcline@redhat.com>
 <20180727162357.30801-2-jcline@redhat.com>
 <20180727174654.bnooz26puuo7456w@treble>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_10DC5A89-BDD9-4578-B2E7-CA670E54AF27
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jul 27, 2018, at 11:46 AM, Josh Poimboeuf <jpoimboe@redhat.com> =
wrote:
>=20
> On Fri, Jul 27, 2018 at 04:23:55PM +0000, Jeremy Cline wrote:
>> 'type' is a user-controlled value used to index into 's_qf_names', =
which
>> can be used in a Spectre v1 attack. Clamp 'type' to the size of the
>> array to avoid a speculative out-of-bounds read.
>>=20
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jeremy Cline <jcline@redhat.com>
>> ---
>> fs/ext4/super.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 6480e763080f..c04a09b51742 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -40,6 +40,7 @@
>> #include <linux/crc16.h>
>> #include <linux/dax.h>
>> #include <linux/cleancache.h>
>> +#include <linux/nospec.h>
>> #include <linux/uaccess.h>
>> #include <linux/iversion.h>
>>=20
>> @@ -5559,6 +5560,7 @@ static int ext4_quota_on(struct super_block =
*sb, int type, int format_id,
>> 	if (path->dentry->d_sb !=3D sb)
>> 		return -EXDEV;
>> 	/* Journaling quota? */
>> +	type =3D array_index_nospec(type, EXT4_MAXQUOTAS);

This check just papers over the issue, but AFAICS doesn't actually
solve any problems.  It ends up squashing an invalid value to be
the same as EXT4_MAXQUOTAS, rather than returning an error to the
caller as it should.

>> 	if (EXT4_SB(sb)->s_qf_names[type]) {
>> 		/* Quotafile not in fs root? */
>> 		if (path->dentry->d_parent !=3D sb->s_root)
>=20
> Generally we try to put the array_index_nospec() close to the bounds
> check for which it's trying to prevent speculation past.
>=20
> In this case, I'd expect the EXT4_MAXQUOTAS bounds check to be in
> do_quotactl(), but it seems to be missing:
>=20
> 	if (type >=3D (XQM_COMMAND(cmd) ? XQM_MAXQUOTAS : MAXQUOTAS))
> 		return -EINVAL;

Agreed that this should be checked at the highest layer possible.
IMHO, this means one check in the VFS/quota layer, and a separate
check in the filesystem layer.

> Also it looks like XQM_MAXQUOTAS, MAXQUOTAS, and EXT4_MAXQUOTAS all =
have the same value (3).  Maybe they can be consolidated to just use
> MAXQUOTAS everywhere?

No, the filesystem-specific MAXQUOTAS values were separated from
the kernel MAXQUOTAS value for a good reason.  This allows some
filesystems to support new quota types (e.g. project quotas) that
not all other filesystems can handle.  This may potentially change
again in the future, so they shouldn't be tightly coupled.

>  Then the nospec would be simple:
>=20
> 	if (type >=3D MAXQUOTAS)
> 		return -EINVAL;
> 	type =3D array_index_nospec(type, MAXQUOTAS);
>=20
> Otherwise I think we may need to disperse the array_index_nospec calls
> deeper in the callchain.
>=20
> --
> Josh


Cheers, Andreas






--Apple-Mail=_10DC5A89-BDD9-4578-B2E7-CA670E54AF27
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAltgBC4ACgkQcqXauRfM
H+Cu6xAAs5ILnj4vwZJw2+rJDtGADMRHQJO0tvEuhc6ual0yh6SVi8DH92s8Z3gd
u3omxJCNQNlQamxys9VBUDaUOHbJOt1EvZzlvp6stmEHPHkJ6othYZB7i5octvAO
HboxA2dhE1bFHfizcs9eYM6BtyzJ+xtNixyG+MUMJQZf+v4KNWm8YaQYOkKtJ5YS
9XWA5sS8Gcds4Jn+ZEWWETaJrjdKf4I3olsO2DHdwrCUirvkN0NRB5l/of29bYWs
tPddwKz3pZWQOkIFOnF6tIMgE7ViFHPjsd8I/CPo6kM6L2ngbFb9jbIBp0ZWIm9i
BmDPua2UbxMmkgnKzswuO/M0libkTvOyDEJ3/q1g+wdfnD1etLD+5dmxwdS0ZddI
I8qMNypv4LJmD+1ty4UHuBg9gD8Nwu8cUmgCOZqFKJ3ZaVF/JOaz2I8d25UYar1c
c6Mu8xlBPd6itP4wom5KXG9a7kE6eINXwOXGsPcHhj485LMei4z6rkRrpPL+hzDM
/4fi9/3mFPd+ZS6oi8trE4Hf706CHZqtpD0vFsOYKyxIMPPf1p3fHAiddwpZBv7n
K+6OBII6tli1GS136uq2SEXnTrZkfdC/HktXpkvkukcX0hcRd8WH1sN9hxTh5RaO
UZ1hAyntV4cyyNtiHBfy7wTX75CkwJsor1NZKNUx0N+0JlwWod8=
=BMKy
-----END PGP SIGNATURE-----

--Apple-Mail=_10DC5A89-BDD9-4578-B2E7-CA670E54AF27--
