Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3532869-1524434087-2-15827519966398695814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524434086; b=nYCndLqFKUpUASsLy63Byd9nYa2+ZgdZecv3o0p2wh8/9P0faP
    sJ6A+eMm24IYVgXmYB1xkUEBSGEGSqa1LdK9QCWIjeR+wL/bTH3aZ17A4DAR1T1X
    HDDTM3brtdXOkPOqj6LRyIz3ZL2wW4KOEkE7fDGJybDr64biqr+8+y5Myxgj38pX
    moUaQWx/ijyYpVjK/k1fWF/FUkrkYBQ+8Fm3eh3focv68d0UJKZCxYZHJWfW4+Th
    hvmuhqkr4S8VvgWa0lPcG+ZbAjpa4DPscSnmqKkI4syNh8q0jJaiZO+/TYmNjs6s
    oqP2g1+01rD//V6z97zTKNqcOqGztak/2czA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=fm2; t=1524434086; bh=8zZ8mfdSdYLAEE06ulqj7b2cHbn5pb
    SGkOskOuHog+M=; b=moRqa85yDgCNTSUPW1GAj6egL4JjhN4zpWUbcfEExHWZrU
    Cu2doOj6DsuWEKmrJuTk8lYv27472pTwg85YZbbrGyZYMv/q6FSgtxUD2RXymU5U
    sHARWBJjAPvxqISm/b/zAVDN9y5kYoaBePoSV+fv13hoF6laqqGfCHB+MQk3AmY2
    CH34u5mDTgPMxMqAieiGGUeRUS1faSnooDnLhA98w/InylAELa+l8S8p1n5hRnoi
    vmROMiOs0EKn7l7aRmm46nQCT6dWvLT1HkYz2F1/drKHeRWlFGBy3yuxqKw89ERe
    R5LcUJSjxucwo36L8j/MeI1iM8CBODd1E2HtAdFg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPK188u9q57/PHWiih0MVQJ9zTOfzRNqcE7fswTNSN2W82SlhUCUYt6HOzpPrKUI65Ar+Kr/X1Yd61FNlrppu1+N2EBbPFqpOdDVOrLmcrc3dgpC6K++
    vMUFRLfyLccfViZLDwWBu3WFcCN3E+hVdk/iKCX48D63SQJgW9bqN+r2/U2UnWol8rI3feKGDhWnuIhaCd3fG4GXbK+bbAu/2bwOzMfbCtOw6UYkjayHUtGZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=S-HCu24hAdCtGIPFpFoA:9
    a=YvQux9SmHKPi7k0W:21 a=4fM5IrrvMfbzSwcP:21 a=QEXdDO2ut3YA:10
    a=hmd6EQY16z_NYG9iYrIA:9 a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeDVVyn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 17:54:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45451 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753763AbeDVVyn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 17:54:43 -0400
Message-ID: <30c688b5783a5779811ce68893b7001390b9e200.camel@decadent.org.uk>
Subject: Re: [PATCH 4.9 37/95] ext4: add validity checks for bitmap block
 numbers
From: Ben Hutchings <ben@decadent.org.uk>
To: Theodore Tso <tytso@mit.edu>
Cc: stable@vger.kernel.org, Wen Xu <wen.xu@gatech.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date: Sun, 22 Apr 2018 22:54:23 +0100
In-Reply-To: <20180422135211.941652389@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
         <20180422135211.941652389@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-tTaGDR+1NBH26+EczC03"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-tTaGDR+1NBH26+EczC03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-04-22 at 15:53 +0200, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Theodore Ts'o <tytso@mit.edu>
>=20
> commit 7dac4a1726a9c64a517d595c40e95e2d0d135f6f upstream.
>=20
> An privileged attacker can cause a crash by mounting a crafted ext4
> image which triggers a out-of-bounds read in the function
> ext4_valid_block_bitmap() in fs/ext4/balloc.c.
>=20
> This issue has been assigned CVE-2018-1093.
>=20
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D199181
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1560782
> Reported-by: Wen Xu <wen.xu@gatech.edu>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: stable@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> ---
>  fs/ext4/balloc.c |   16 ++++++++++++++--
>  fs/ext4/ialloc.c |    7 +++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>=20
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -337,20 +337,25 @@ static ext4_fsblk_t ext4_valid_block_bit
>  	/* check whether block bitmap block number is set */
>  	blk =3D ext4_block_bitmap(sb, desc);
>  	offset =3D blk - group_first_block;
> -	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
> +	if (offset < 0 || EXT4_B2C(sbi, offset) >=3D sb->s_blocksize ||
> +	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))

Isn't sb->s_blocksize a count of bytes?  If so, doesn't that mean that
we should be comparing with sb->s_blocksize * 8?

Ben.

>  		/* bad block bitmap */
>  		return blk;
> =20
>  	/* check whether the inode bitmap block number is set */
>  	blk =3D ext4_inode_bitmap(sb, desc);
>  	offset =3D blk - group_first_block;
> -	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
> +	if (offset < 0 || EXT4_B2C(sbi, offset) >=3D sb->s_blocksize ||
> +	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
>  		/* bad block bitmap */
>  		return blk;
> =20
>  	/* check whether the inode table block number is set */
>  	blk =3D ext4_inode_table(sb, desc);
>  	offset =3D blk - group_first_block;
> +	if (offset < 0 || EXT4_B2C(sbi, offset) >=3D sb->s_blocksize ||
> +	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group) >=3D sb->s_blocksize)
> +		return blk;
>  	next_zero_bit =3D ext4_find_next_zero_bit(bh->b_data,
>  			EXT4_B2C(sbi, offset + EXT4_SB(sb)->s_itb_per_group),
>  			EXT4_B2C(sbi, offset));
> @@ -416,6 +421,7 @@ struct buffer_head *
>  ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block=
_group)
>  {
>  	struct ext4_group_desc *desc;
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>  	struct buffer_head *bh;
>  	ext4_fsblk_t bitmap_blk;
>  	int err;
> @@ -424,6 +430,12 @@ ext4_read_block_bitmap_nowait(struct sup
>  	if (!desc)
>  		return ERR_PTR(-EFSCORRUPTED);
>  	bitmap_blk =3D ext4_block_bitmap(sb, desc);
> +	if ((bitmap_blk <=3D le32_to_cpu(sbi->s_es->s_first_data_block)) ||
> +	    (bitmap_blk >=3D ext4_blocks_count(sbi->s_es))) {
> +		ext4_error(sb, "Invalid block bitmap block %llu in "
> +			   "block_group %u", bitmap_blk, block_group);
> +		return ERR_PTR(-EFSCORRUPTED);
> +	}
>  	bh =3D sb_getblk(sb, bitmap_blk);
>  	if (unlikely(!bh)) {
>  		ext4_error(sb, "Cannot get buffer for block bitmap - "
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -119,6 +119,7 @@ static struct buffer_head *
>  ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
>  {
>  	struct ext4_group_desc *desc;
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>  	struct buffer_head *bh =3D NULL;
>  	ext4_fsblk_t bitmap_blk;
>  	int err;
> @@ -128,6 +129,12 @@ ext4_read_inode_bitmap(struct super_bloc
>  		return ERR_PTR(-EFSCORRUPTED);
> =20
>  	bitmap_blk =3D ext4_inode_bitmap(sb, desc);
> +	if ((bitmap_blk <=3D le32_to_cpu(sbi->s_es->s_first_data_block)) ||
> +	    (bitmap_blk >=3D ext4_blocks_count(sbi->s_es))) {
> +		ext4_error(sb, "Invalid inode bitmap blk %llu in "
> +			   "block_group %u", bitmap_blk, block_group);
> +		return ERR_PTR(-EFSCORRUPTED);
> +	}
>  	bh =3D sb_getblk(sb, bitmap_blk);
>  	if (unlikely(!bh)) {
>  		ext4_error(sb, "Cannot read inode bitmap - "
>=20
>=20
--=20
Ben Hutchings
It is easier to write an incorrect program
than to understand a correct one.


--=-tTaGDR+1NBH26+EczC03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlrdBI8ACgkQ57/I7JWG
EQkTnw/+IOk4m59TAT0FvTi4EUhRy/kbdAhPNR2C0Nxa7/T4BYdm9qD+XY/het4p
Yo1FJOI0AZ22jmkcGpxjaENalIEECIr8wciYom081PUB6/k1EvLcEJkAdhDrVmKY
eulX4jb39nYfVNFpja3TgZ/2Cp5bxk3O47fUT97r4h63lhbQXqDN+WVIowLIHCTX
wOicovDODOM4VvyF0iQ4d5NpImLa/1LFUKKRR9Be4q8DgSc+wjMfQO8h8FUfPMbl
vlwbeCZOXWZeVyQ0qE0anuuT3jB1VPkAdo9wUy7y3JFeCvkzJYJ77/NierAEh3eV
/XX9LZmwWXtBU0OV2MDZJpbMpCbcAKu8df+e1LFfa/x2HFYQTRS2MnCiUviCAFd3
VyUnzlkhwvKXVoCpsWumnt+6BfzSirIYskk6JJfl5yjtM+MLyrAc5o3qlnssqKDy
cocZ/Aq01K9X1lVGhcWfm2V4qLkrBxQFFe1MPBNRid2NSNByWR6BqQoXDmdakelf
JlMfoNNrcCqLX0CGZbbl83cpIMVkzUduNgwq93yKWD++Q0qiUBb8NAR3U2f2KGob
X61iwI4KgazwKNcvMjiO9d7bgs1+E4t7lBa2eHaOa7QPw0W0WRABvMPagiXVRrkX
RB75GQiXOjTeOHCl5rsu4ticG5Imkk+5k4I8pM+ZBLb97qhvyHk=
=EwUi
-----END PGP SIGNATURE-----

--=-tTaGDR+1NBH26+EczC03--
