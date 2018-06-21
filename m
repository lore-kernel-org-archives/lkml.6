Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7C0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BF321837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="m2dCUBQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BF321837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeFUR3S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:29:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42033 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbeFUR3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:29:16 -0400
Received: by mail-pl0-f67.google.com with SMTP id w17-v6so2033979pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=YwmjdZLJlue5CrG4m2X3boWseUmIkUembVOvZunnj18=;
        b=m2dCUBQl4AL6ScyovUDgTXOEhWLDIc95xwIxsNkGzjFB+p1LfS5kRcmGDv+7a4ppoj
         HEplO9icvLsubgltjjRZb4b2WCboDjL60HPmgBs4Evr0t4ePL+fVe+jw8b20h666DOpk
         Iq7Il95C7QxFdjoVNLWHL5dU+bLfHZr2Z/RLOS3Mu5cLgHaipQt+iChko9vqZ4xtf/PD
         P0RDk+1J98HeWlulEZiHzBAuug1avkHqYe0FIkUbRaRkpxkJKkM42mg42EQLi1tQZHc5
         bcjK+lbX2N4a7kFDfrrZ6OVz65viq5k6s9H8Iy0B9r7knpVbZ7w1Plg/z2BRdWsSCXNy
         hmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=YwmjdZLJlue5CrG4m2X3boWseUmIkUembVOvZunnj18=;
        b=QpqJg/JN2Su4nXYX+SmOEZjohbKDlSapPhsdV6En+2e+Gcz1H9TtWI4SJeM50gbXqR
         f8ui+UYfFHBucI3Vh8sToBaSCfurIb2v3M72DLmncyNRV4QTd3By4odmrmG+Fi9z6hun
         AiLHID5M7ecpj79GN9D/xY/pp7fU60u8IRZWPxliRW1AIecN9oUw10EKDklRhLKyzLcJ
         C7nm275W/fPupTTAweS5lbUHwnNamKcbIYqhUy1RueN5GhHoslTiW0RQuCAiWY7nYJbi
         vd4HpD2nI1tRLRNjPrLyiczYCWH3WKLqnCJDZpMj9RHfXUn4cYP+iUOV+Wi/wiNWEIrU
         8Q8w==
X-Gm-Message-State: APt69E0At3dT6gy4l+hqRDugPiyvPHfAJpt19H6HVlqALvq2nYoYbEFw
        qmP8ib2ISCSVTQ65uQEtTc/R1A==
X-Google-Smtp-Source: ADUXVKJYNx8RPPfvd+G1h5qTHgiLCpzH7BZ1WBYAvn5zUBsAxSuqmau8xE/9IAr5+zfNbOxRK1l03A==
X-Received: by 2002:a17:902:4c:: with SMTP id 70-v6mr29401052pla.178.1529602156441;
        Thu, 21 Jun 2018 10:29:16 -0700 (PDT)
Received: from cabot-100.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id y18-v6sm7956701pfl.122.2018.06.21.10.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:29:15 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9ED1876B-995B-490D-9173-467880FDEA7F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C6057F87-5433-49E0-BFE3-D2F243952E2F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/6] ext4: use timespec64 for all inode times
Date:   Thu, 21 Jun 2018 11:29:13 -0600
In-Reply-To: <20180620153322.54221-4-arnd@arndb.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        y2038@lists.linaro.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
References: <20180620153322.54221-1-arnd@arndb.de>
 <20180620153322.54221-4-arnd@arndb.de>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_C6057F87-5433-49E0-BFE3-D2F243952E2F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 20, 2018, at 9:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> This is the last missing piece for the inode times on 32-bit systems:
> now that VFS interfaces use timespec64, we just need to stop =
truncating
> the tv_sec values for y2038 compatibililty.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h   | 18 +++++++-----------
> fs/ext4/ialloc.c |  2 +-
> 2 files changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 0b127853c584..6b4f4369a08c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -789,17 +789,16 @@ struct move_extent {
>  * affected filesystem before 2242.
>  */
>=20
> -static inline __le32 ext4_encode_extra_time(struct timespec *time)
> +static inline __le32 ext4_encode_extra_time(struct timespec64 *time)
> {
> 	u32 extra =3D sizeof(time->tv_sec) > 4 ?
> 		((time->tv_sec - (s32)time->tv_sec) >> 32) & =
EXT4_EPOCH_MASK : 0;
> 	return cpu_to_le32(extra | (time->tv_nsec << EXT4_EPOCH_BITS));
> }
>=20
> -static inline void ext4_decode_extra_time(struct timespec *time, =
__le32 extra)
> +static inline void ext4_decode_extra_time(struct timespec64 *time, =
__le32 extra)
> {
> -	if (unlikely(sizeof(time->tv_sec) > 4 &&
> -			(extra & cpu_to_le32(EXT4_EPOCH_MASK)))) {
> +	if (unlikely(extra & cpu_to_le32(EXT4_EPOCH_MASK))) {
>=20
> #if 1
> 		/* Handle legacy encoding of pre-1970 dates with epoch
> @@ -821,9 +820,8 @@ static inline void ext4_decode_extra_time(struct =
timespec *time, __le32 extra)
> do {										=
\
> 	(raw_inode)->xtime =3D cpu_to_le32((inode)->xtime.tv_sec);		=
\
> 	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## =
_extra))     {\
> -		struct timespec ts =3D =
timespec64_to_timespec((inode)->xtime);	\
> 		(raw_inode)->xtime ## _extra =3D				=
	\
> -				ext4_encode_extra_time(&ts);			=
\
> +				ext4_encode_extra_time(&(inode)->xtime);	=
\
> 		}								=
\
> } while (0)
>=20
> @@ -840,10 +838,8 @@ do {							=
		       \
> do {										=
\
> 	(inode)->xtime.tv_sec =3D =
(signed)le32_to_cpu((raw_inode)->xtime);	\
> 	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## =
_extra)) {	\
> -		struct timespec ts =3D =
timespec64_to_timespec((inode)->xtime);	\
> -		ext4_decode_extra_time(&ts,					=
\
> +		ext4_decode_extra_time(&(inode)->xtime,				=
\
> 				       raw_inode->xtime ## _extra);		=
\
> -		(inode)->xtime =3D timespec_to_timespec64(ts);			=
\
> 		}								=
\
> 	else									=
\
> 		(inode)->xtime.tv_nsec =3D 0;					=
\
> @@ -993,9 +989,9 @@ struct ext4_inode_info {
>=20
> 	/*
> 	 * File creation time. Its function is same as that of
> -	 * struct timespec i_{a,c,m}time in the generic inode.
> +	 * struct timespec64 i_{a,c,m}time in the generic inode.
> 	 */
> -	struct timespec i_crtime;
> +	struct timespec64 i_crtime;
>=20
> 	/* mballoc */
> 	struct list_head i_prealloc_list;
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index f525f909b559..8c00c871f5dc 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1073,7 +1073,7 @@ struct inode *__ext4_new_inode(handle_t *handle, =
struct inode *dir,
> 	/* This is the optimal IO size (for stat), not the fs block size =
*/
> 	inode->i_blocks =3D 0;
> 	inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D =
current_time(inode);
> -	ei->i_crtime =3D timespec64_to_timespec(inode->i_mtime);
> +	ei->i_crtime =3D inode->i_mtime;
>=20
> 	memset(ei->i_data, 0, sizeof(ei->i_data));
> 	ei->i_dir_start_lookup =3D 0;
> --
> 2.9.0
>=20


Cheers, Andreas






--Apple-Mail=_C6057F87-5433-49E0-BFE3-D2F243952E2F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlsr4GoACgkQcqXauRfM
H+BdIg/+K/BV2pNCUWpP2L7KBRhDU371lHoZogBut1IhnL/h129JtZPZ+B2+bSga
4W6ujs75roeLfC6HrkYdmTR3R4hNAft3uJF2UVX93jLgOc7QF+5gMRyAVYDA0Lh/
sbR0ZYih0j3U0Y+gWarjIwjpRIqfL7M9m0WdlsqSHzV4C0rkAL1Jky7k2MOZE5/C
tQkRuFXlldFHjDePnK7cTIZKdR7ffV0zd/pt0ydsroUPhy7JPrVZaS4v2u6L+kH/
QY33xuCVXxLsFJhBAYKc4RgkFdM8m008w5N9xQ/39Im9Aj1P1D6uLB9EwTlUGSqv
FsOb8m5nF57a+ouRcPAkShkO2Rv732GOEo4HFHpdLiwFCxB04FYoJtB/axCn5JBt
HGzIgHw6NUqkasa/TT+Examp8EaAv35HawrG8qM3TYFjK9lVNArVWe4iFSGqNHWg
h5WkxczfRRA8SCsiZn662/1FDgCDEvTWsfzCmFSNNBP4G8z7eHGRQeDeNT6haVRK
bAJVE4GFNu4bgWbNKkAE+4/U+bPB2SebRikJmpwcRqNt/xju2TNxOreITjRqJXTX
RLKtKj/QbsA8hhGH4FybNqimt3PuC8ynXfP/U5ui0dkc4b++F3d4z1MzpXS5PEMS
U+/2RLfNI1EEcn+BhGTmNy4QCGaKNFl6y+7WWQwQEScb5h+LWxY=
=Q/Vk
-----END PGP SIGNATURE-----

--Apple-Mail=_C6057F87-5433-49E0-BFE3-D2F243952E2F--
