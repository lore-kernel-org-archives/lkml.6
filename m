Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E9C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 04:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3857D247AB
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 04:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="aqDZ1zFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3857D247AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbeF3EgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 00:36:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43400 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753909AbeF3EgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 00:36:11 -0400
Received: by mail-pg0-f65.google.com with SMTP id a14-v6so4807753pgw.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Pb9U1/hSbMVUkgpCk/PvqbOJeWDzAE827Qt38kzByDA=;
        b=aqDZ1zFKwPB5UZ64SIvogYu5LCFWGsf0rgRkuhu4/9hLIzwC6i/4NGDJEQZoEb059k
         ymWfpG7mFYMkzsVZNWHVUsYulydBz/HyyTghm8faRc1VgNFELd7GwhwnpPMtWX3ZIF5W
         +qbE8aWQXS1Ri57hYAXvFxTW6OQg8wjf7aLcnaQbC30DFYol4Xnl9Z9ZSxQFAdxwOGzf
         DDDvaOUC0YemJh0XalBoSvSfdIqDX3RdWCBoXj84xEW7wKYlDQwNX6fcQsu/1ME5pwVD
         nAn47SMWLwBj4BMLeyQ31ixxIKWcBkTvgdlqFlwbkv2hhGG2eSrVwNvdCc3lA2dms8zh
         t4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Pb9U1/hSbMVUkgpCk/PvqbOJeWDzAE827Qt38kzByDA=;
        b=S16QBvO6N69y3aWvalKmr1gqptBNZf2zMlewaG/RU1CO74EL1m9wIGwV6HSzbnm3he
         ZeI+ZI2a+hfaV33tbqV+hiVAFE03uqsYAeUe4cUp+ZRTOpg33P7t3YIzJDmefWKmKhzk
         iLcK7EbVpbGoyuc+Comuqu9LLCBGCxzhrK+9hD9AojwEyXRNodHZEDJ0Sa8B0fOUAsDF
         yafaieStdVWTM1uTUJUFnTyX4yhAotD4EZh80pRyc0V/vHsc+k710+C2vdZI5sMeMRO8
         36RFvTtmEKaMD/8Yv3pOWJVwB9nxOZOATTaoVLQKdG4TD5AhoCfWGqPXHhT/+PI6ZZcw
         IaXQ==
X-Gm-Message-State: APt69E1Vyr0vVCyjeN6DfD7+znltWMWGdvF92BaacvpEsxuIlJcvSabi
        57hoT/dHlU3puFQOLPOTV2kOcKTcZhE=
X-Google-Smtp-Source: AAOMgpd8hnahLMN6EWB67AKpl68ir+ladgaWvqOxsYbzsbTIgjmi2Ts0s7+9uG6FaZxQIHrmgMIACQ==
X-Received: by 2002:a63:2e81:: with SMTP id u123-v6mr11352187pgu.225.1530333370871;
        Fri, 29 Jun 2018 21:36:10 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 4-v6sm19977729pfi.78.2018.06.29.21.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 21:36:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A869A023-8695-48CC-B577-DAA1C75837C3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E8FFBE7E-1B06-4D58-8BBF-BAE19556F898";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Check superblock mapped prior to committing
Date:   Fri, 29 Jun 2018 22:36:06 -0600
In-Reply-To: <1530300995-25583-1-git-send-email-jonathan.derrick@intel.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
References: <1530300995-25583-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_E8FFBE7E-1B06-4D58-8BBF-BAE19556F898
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 29, 2018, at 1:36 PM, Jon Derrick <jonathan.derrick@intel.com> =
wrote:
>=20
> This patch attempts to close a hole leading to a BUG seen with hot
> removals during writes [1].
>=20
> A block device (NVME namespace in this test case) is formatted to EXT4
> without partitions. It's mounted and write I/O is run to a file, then
> the device is hot removed from the slot. The superblock attempts to be
> written to the drive which is no longer present.
>=20
> The typical chain of events leading to the BUG:
> ext4_commit_super()
>  __sync_dirty_buffer()
>    submit_bh()
>      submit_bh_wbc()
>        BUG_ON(!buffer_mapped(bh));
>=20
> This fix checks for the superblock's buffer head being mapped prior to
> syncing.
>=20
> [1] https://www.spinics.net/lists/linux-ext4/msg56527.html
>=20
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
> fs/ext4/super.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0c4c220..ee33233 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4736,6 +4736,14 @@ static int ext4_commit_super(struct super_block =
*sb, int sync)
>=20
> 	if (!sbh || block_device_ejected(sb))
> 		return error;
> +
> +	/*
> +	 * The superblock bh should be mapped, but it might not be if =
the
> +	 * device was hot-removed. Not much we can do but fail the I/O.
> +	 */
> +	if (!buffer_mapped(sbh))
> +		return error;

This still looks a bit racy, based on the stack trace you posted.
There is already a "block_device_ejected()" check a line above,
which makes me think that the PCI device removal should be handled
like an ejected device, so that it is also handled elsewhere.

Even so, the check here in ext4_commit_super() can pass, and the
PCI card can be removed on the next instruction and still trigger
the BUG_ON().

That said, this is probably still an improvement on the existing
situation.

Cheers, Andreas






--Apple-Mail=_E8FFBE7E-1B06-4D58-8BBF-BAE19556F898
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAls3CLYACgkQcqXauRfM
H+B1IQ/+Ivh2zNIIOCJEilXbgCSnYxWDUwDWUEX8I3q1FuDqoRC80U5Di2sx2ibK
pfAF5a61IJMvinjW5VlnxIzDtc+kq//aZT/5ddLOSvY161+JHF1AysVjQIGZWEBS
5dFpOGarmjZa3HfDjDkcNGwBdolB1SSE1W8GX8V8Zlk/R8aUqHOQitYusmUQHNbf
ZG6EQmZuuN0ydEyOZCnUbDm2ab9YIDQtxzhvIBqfTLSdXOhwMVnL0ftJqaiFiEn4
yt4dXo3sZEWxpAGWYmnZK+Pjwxyc6xvqAd1YlnchDZxsKlkICvicliU19NzCaVIe
2GTi5kQ84dYNtTpSsoOhOYGNfyUpE6QegF5NdL2+1o4vnqYoC7c1rMxrMVBBiGJl
lazFrGvnZSFTKMt0Aqy4Ytt15w0XPZmaY17TOge4/xCCXZhZzMFv4OWav50qL4Ye
ppkzTWTNFKZ1GYjYmgmmYtaHyjwaSys2O3wvws/sU+RHn768MFdjfL7vDXHAxMby
MWY9M8n2PUIi7o6Am8m7aBGpwJF8d3oJGcUt40K5UMoJFalnGqHCy4vKMEEa1JdM
HHqLtw3lgKml4zhSfZqY7T4/NHd4KMGuv9a6hcuppIRhCFW9qlWy74X9aU5PTNyX
kKK9vW+LtgSiHjMR04IpcwvUPwEhQbV8x0NvuQFi5pw8pTeOCXE=
=9q8V
-----END PGP SIGNATURE-----

--Apple-Mail=_E8FFBE7E-1B06-4D58-8BBF-BAE19556F898--
