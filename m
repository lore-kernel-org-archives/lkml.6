Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538CDC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E4E2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hONyyxg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E4E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeILMhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:37:38 -0400
Received: from ozlabs.org ([203.11.71.1]:44677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbeILMhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:37:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 429D7J39tdz9sBn;
        Wed, 12 Sep 2018 17:34:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536737661;
        bh=iXhds9CGCraKsVeh/9gSz2j5A4Lm645jxXcLBIDE+lo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hONyyxg5/c+S8KDOSNFzw6go65OI47RrPzi6gUmFlne8Ingtx0II7o7THxhHiK0kK
         kQ4ryNc6fu1Xkxi5/HEmDRIa+TxcExbxpDmK2BK/oPQnnrHBbxtdJjkvE0lvdomem1
         AcnLabUyZF9TeMvnms2p170w3AtCTJOCZtTk2JB3NRsIQgFicUOlHgEJngSjy+YQ2C
         rLFT5yoD9zhiVVxkW/BJzmgh7PsttxvT2Lrp28TA6yhsh7/dOFTxOTeYfqkekUt7/T
         O1Vbc6Hm7nQa7b/ah2CUnJhIaqYZUlXqRYx6aY2GpobHfzfwo9DgcnLTcPb51hvzAR
         DvC3ozjNQjJgg==
Date:   Wed, 12 Sep 2018 17:34:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
        <devel@driverdev.osuosl.org>, Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, <weidu.du@huawei.com>,
        <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH] Revert "staging: erofs: disable compiling temporarile"
Message-ID: <20180912173404.288ea2e5@canb.auug.org.au>
In-Reply-To: <58dbf050-ac24-9d8a-bbf3-0e28e10149ff@huawei.com>
References: <1535427588-69630-1-git-send-email-gaoxiang25@huawei.com>
        <20180828054444.GA4453@kroah.com>
        <0c701b3c-5553-cf4c-c0b3-ad151b84662c@huawei.com>
        <f12ae5df-3130-f293-5863-3d9ff0802e92@huawei.com>
        <20180828130559.GA5427@kroah.com>
        <16974cb6-2eed-7c12-9e27-c65a32b81673@huawei.com>
        <20180829094403.3a3bf19b@canb.auug.org.au>
        <20180906092504.282d5f62@canb.auug.org.au>
        <58dbf050-ac24-9d8a-bbf3-0e28e10149ff@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UGpUTf55C_0tqjhVIY1aVtz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UGpUTf55C_0tqjhVIY1aVtz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chao,

On Wed, 12 Sep 2018 15:19:16 +0800 Chao Yu <yuchao0@huawei.com> wrote:
>
> To make sure, did -next tree enable erofs compiling now?

Yes, from yesterday.

> Xiang has made two patches to fix integration issue with other vfs change=
s,
> and Greg and David have already picked them in their tree.
>=20
> staging: erofs: rename superblock flags (MS_xyz -> SB_xyz)
> staging: erofs: update .mount and .remount_sb

I noticed, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/UGpUTf55C_0tqjhVIY1aVtz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluYwWwACgkQAVBC80lX
0GzO7wf/R/QBANvTbw5jhoJZn3JonWExnILmeXhfpdCRLN754Ogu5EbausJjQNfZ
OWrGe3xkInrAKeT7fEEKiLpZNoaeHokLYnZickZEqjtWd0/eUPlxVUm4Y+zBCyD5
9qVQObaYYOziaL34w1wYwLI4ImYsoKPmpFZ6NBq4lWo9TLo6p85nmKcYR/E2CaCF
0krxCW2yyDss/fpWmRi/3/BmRORf+qnV+o5xBIvNqOj8+MaopEBz8yPEizj4PYNM
3O1TqOXWVgyRvs5Mt5jErWDeJ7iPOxijXdSkL/0DvdBTmUhduu3bg3GqJ9ISF777
GDodDpSHHkWOb2D2sKNne2Kj7wXegQ==
=EbhR
-----END PGP SIGNATURE-----

--Sig_/UGpUTf55C_0tqjhVIY1aVtz--
