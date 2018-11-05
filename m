Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB88DECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EBF20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="Wtxoufgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EBF20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbeKEO0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:26:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33108 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeKEO03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:26:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id q5-v6so3658518pgv.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 21:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=D5PBqOYQYihdldkvwncOzleNYLvJNANsfwKsSCRL21U=;
        b=WtxoufgoDl0I6GNCVaHLJHtGFnb72b6CgdAgU8jF2w+mfBlUOQYZxABMBp6B/y2nBe
         2PD/nRAZgxWy103HoPlF4+mskMFFMukkyP+Dyvz4A5/RefU+4GeZN093zrXf6nmBlmuA
         q4EOarj0HTc3McBSmN0fwpaAnw7WnYexu3hukt5fLgx4RUu8N9nQ6cSTY94zpjkrAE8w
         JwkDyh79kH942KWI3AlUNpP4ecYcaQtoU60Ej6CbPWEnPxUCuRkIdnixtP1uhBgAuDRE
         MpipVsPuyT+tJMIsGcYYhu6jI42azR3xeHw+rE7cPiqJZsrtkWUjCu/EFLpf/QlXPLeR
         R1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=D5PBqOYQYihdldkvwncOzleNYLvJNANsfwKsSCRL21U=;
        b=BiD9waKOQFaTn+4dtzUqzqMSI0Xm63rFTC+2qYjAlkPQ8IvVMEJ9fIkl/TskVCat/x
         DxkTGoAwv3swzN4ojQGlnkI7GIeONiT0CLxrKm7fd8KvXScwHSf7BRZzFJoNRHZg+s47
         VEi9ETpLwM3ULij+49rDuHn2NkyGzu3l7eG64JfLYaitGI5+HV7oqkt8awXD6wcbIp/J
         GRzYc/4/HOJgyOx0XRwy3Dz9P0K4TsEc+lEXkZ6/svZOg5yki7SMX5BE4maPdkh+yl4n
         lZYQVgdOxAgVBW/MQzoGZfZamGI1GKb0F+wz6p1fBzS7AyaI7Vhh2GNfqk0KtkjfkfDT
         IiJQ==
X-Gm-Message-State: AGRZ1gK3FvdQ/s6IY/SYPsNJ3UniSR1hDCMgp083u78V9K/A3ojvJwUP
        UOLZ8N4nHP26njxv+ucBR1gv+g==
X-Google-Smtp-Source: AJdET5cPOSJRvHu6Jb1qx4JQ3AvwXjKiIQTvIyxMiu8sJWZ+mEA6lzE23w4eS6nTyFI7kQmKfwIWPg==
X-Received: by 2002:a63:5b4a:: with SMTP id l10-v6mr16109576pgm.50.1541394521735;
        Sun, 04 Nov 2018 21:08:41 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id d2-v6sm45757101pfn.118.2018.11.04.21.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 21:08:41 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E88DA3F6-D339-44D6-95A8-75256A8F57CC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DF051A48-1085-43A6-AE18-80D113602C1B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: remove code duplication in
 update_ind/bind/tind_extent_range
Date:   Sun, 4 Nov 2018 22:08:37 -0700
In-Reply-To: <1f58b6b3-de16-a08d-2952-5db70dbfc778@virtuozzo.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>
To:     Vasily Averin <vvs@virtuozzo.com>
References: <1f58b6b3-de16-a08d-2952-5db70dbfc778@virtuozzo.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_DF051A48-1085-43A6-AE18-80D113602C1B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 4, 2018, at 9:41 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
>=20
> update_ind/bind/tind_extent_page() differs by one variable and can be
> replaced by unified function. These functions are called by similar =
way
> and their caller function can be simplified too.

The patch looks quite reasonable, though I'd suggest a couple of very
minor style changes (inline).  You can add to the resubmitted patch:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
> fs/ext4/migrate.c | 111 ++++++++++------------------------------------
> 1 file changed, 23 insertions(+), 88 deletions(-)
>=20
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index 61a9d1927817..02ce99ba32be 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -109,12 +109,13 @@ static int update_extent_range(handle_t *handle, =
struct inode *inode,
>=20
> static int update_ind_extent_range(handle_t *handle, struct inode =
*inode,
> 				   ext4_fsblk_t pblock,
> -				   struct migrate_struct *lb)
> +				   struct migrate_struct *lb,
> +				   ext4_lblk_t inc)
> {
> 	struct buffer_head *bh;
> 	__le32 *i_data;
> 	int i, retval =3D 0;
> -	unsigned long max_entries =3D inode->i_sb->s_blocksize >> 2;
> +	ext4_lblk_t max_entries =3D inode->i_sb->s_blocksize >> 2;
>=20
> 	bh =3D sb_bread(inode->i_sb, pblock);
> 	if (!bh)
> @@ -523,34 +464,28 @@ int ext4_ext_migrate(struct inode *inode)
>=20
> 	/* 32 bit block address 4 bytes */
> 	max_entries =3D inode->i_sb->s_blocksize >> 2;
> -	for (i =3D 0; i < EXT4_NDIR_BLOCKS; i++) {
> +
> +	inc =3D 1; mult =3D 1;
> +	for (i =3D 0; i < EXT4_N_BLOCKS; i++) {
> +		if (i =3D=3D EXT4_IND_BLOCK)
> +			mult =3D max_entries;
> +		else if (i > EXT4_IND_BLOCK)
> +			inc =3D inc * mult;

This should be "inc *=3D mult".

> 		if (i_data[i]) {
> +			if (i < EXT4_IND_BLOCK)
> +				retval =3D update_extent_range(handle, =
tmp_inode,
> 						le32_to_cpu(i_data[i]), =
&lb);
> +			else
> +				retval =3D =
update_ind_extent_range(handle,
> +						tmp_inode,
> +						le32_to_cpu(i_data[i]),
> +						&lb, inc);
> 			if (retval)
> 				goto err_out;
> +
> +		} else if (i < EXT4_TIND_BLOCK)
> +			lb.curr_block +=3D inc * mult;

There should be {} around the else-block to match the if-block.

Cheers, Andreas






--Apple-Mail=_DF051A48-1085-43A6-AE18-80D113602C1B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvf0FUACgkQcqXauRfM
H+BpZRAAk2N6dQu6NVMuEVzfNGV33ziHKmwTa8fgtSnHgxI3K+OCStu7tVA9y7H2
dwIytTuGMFqvgtijmh2deJj8Q5sgi0odFHwSssHMyHmNu0bJY+AK4VCA3p83+FUI
Ci+3Y57yLbETRbS7uFFuXAi54LrXgNPOUtS9siPdmXJdI/WwnLSYNCScTuilM133
xzfgMG0n08RsPW+Y07WFKtHZhG36AEH5+E84bSG2oMZZBQnVI9UHiQ9fVTyVzSx6
G5WY9KxzFb2PMP2QKzNS19LDElcqXEb+hLWkgsoxKDK10rjbiRyfxVkmGmN4BPHL
Np3zcKnaeX5oDtWEgTEkT+8O/ZQ03ztQ8XcA6TrKf+vc1GvaYQ0kMG9jWaXj9gkS
QM8MBwcxJuaFMFp+Tod2bt6EQbBv4FYz7siXaLJxR8+exTOuknvKsIwwKw4V8q5o
HB7r+cmZ82EZ5Y1SUEqC87WfeunlnbO6LZ84hg+CEbqgk4d8aSM3JghAZyf25aHu
ExeC5pTiNG30NZjR6TRpGrexSes7QESTZIBkP+AvmQn0BgMgDiLWtZPcD+D6mozH
bwlovKkzIQwDMLeFoL1E8B1rrYwVfCVX9sXB+GucoPCrnTi3Dcj2ECSBaJoawMWW
lVVJtvElsjM/nSWuZSy2wyNCESDq3uHYch22rghxFfvczxZJ5RU=
=kD+9
-----END PGP SIGNATURE-----

--Apple-Mail=_DF051A48-1085-43A6-AE18-80D113602C1B--
