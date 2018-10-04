Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFE0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC7E2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQfDRsaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC7E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeJEAUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:20:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33217 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeJEAUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:20:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so2036953wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JTGvXlVAvvYknYoInJAuokGIFDzOATWhj7WXhHLqZBQ=;
        b=bQfDRsajjSz7qFlSmSTgd4gRgXlutj59DUhDiigWFUqVHxddy06F/pFmdMHa6ADso7
         6qOAUo20YS8203M4RLkM6XQJXPbZ5PSIoHJetYwvx1MtHks84dD6eyGg9Eho2uLgid5i
         Wt5VGgsArcbKtzj6VL4dy8Hk0UD625TP6SXG+1BuYi5W4yQIbZHxtKBMNDvGQ9xPcooo
         pfCcpTJOpdoMqFS2GIfFDtVUZkkqOwIfZ1Hlu2aB0ZSXi7KcBMyTrBhG4FfIb42t+1eR
         TrphUYQY+8aBDfwdBBDffE2PL2yVUMw53UbFChAZABYzXkfnEb6bFbkdon6V9KkVicNc
         lZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JTGvXlVAvvYknYoInJAuokGIFDzOATWhj7WXhHLqZBQ=;
        b=C0phqBOWdwX5bVspF3AvM1Xg5TDE7slBNOLwAO2yjRNO32Ut51ih2OEIfzWqld5nsJ
         Nd6ERJhYTNX+p7F5p8gk5A/koMXVEPYsS9g6taipgAY/kofuhqrkSi2H7alSr/45hg1l
         udqands3Q0IaG+E8xUJNxp25zTUsjBty7OZxdTNORqSed6+Zj92WL/42z5Gys5iFE6Q/
         JhSigdvSH7nho4bAkj9O9ROkY7jCv64H/xhthZF8Wl5BE9k96AnFSsLGqhCmLG+8tlTV
         7VWJYtaEL5niaZbd2wzy2fJKqCSjI4YAxBdXf3t/OYmU8TthOBK8EHuLpmnXSw3JFjTb
         cFlw==
X-Gm-Message-State: ABuFfoiaAUw6tcgBJqKfvDAJzkwctttUuvCk9H0OYHS9eRQnFvZChUb+
        OyIIxMqVDv5odcrtadreknXJPMEV
X-Google-Smtp-Source: ACcGV62T6KBjUBo03GFmJ7BWaY6MMjT0Q5wz1McnqeufE97zq7YyJ1MqOl2rNRFGxaCPjJFhlK0yMA==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr5238150wmh.134.1538673991375;
        Thu, 04 Oct 2018 10:26:31 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e7-v6sm6194596wra.37.2018.10.04.10.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 10:26:30 -0700 (PDT)
Date:   Thu, 4 Oct 2018 19:26:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     chenchacha <chen.chenchacha@foxmail.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH 0/2] fs: fat: add ioctl method to read voluem label in
 fat filesystem driver
Message-ID: <20181004172629.v2cvmcbox2roafkp@pali>
References: <20181004172101.15525-1-chen.chenchacha@foxmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3joza362c3mcqio3"
Content-Disposition: inline
In-Reply-To: <20181004172101.15525-1-chen.chenchacha@foxmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3joza362c3mcqio3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 05 October 2018 01:20:59 chenchacha wrote:
> This patch add fat ioctl command FAT_IOCTL_GET_VOLUME_LABEL.
>=20
> We can get the volume label with this command:
>=20
> 	ioctl(fd, FAT_IOCTL_GET_VOLUME_LABEL, &volume_label);

Hi! What is purpose of having such functionality in kernel? Userspace
can read it without any kernel support. (e.g. mlabel or fatlabel)

> FAT volume label (volume name) is exactly same stored in boot sector and =
root
> directory. And this patch read label only from the root directory. If lab=
el in
> root directory is missing then disk would be treated as without label. La=
bel
> from boot sector would not be read.
>=20
> The volume label format reference from Pali Roh=C3=A1r testing results
> (https://www.spinics.net/lists/kernel/msg2645732.html) in the previous ma=
il.
>=20
> chenchacha (2):
>   Add FAT_IOCTL_GET_VOLUME_LABEL in fat_generic_ioctl()
>   Add a new function to get root directory with ATTR_VOLUME
>=20
>  fs/fat/dir.c                  | 13 +++++++++++++
>  fs/fat/fat.h                  |  2 ++
>  fs/fat/file.c                 | 22 ++++++++++++++++++++++
>  include/uapi/linux/msdos_fs.h |  1 +
>  4 files changed, 38 insertions(+)
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--3joza362c3mcqio3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW7ZNQwAKCRCL8Mk9A+RD
UpbMAJ9MxuVF/9Cac9ziFqDaOypsUcih+QCdHI/nTr78LavGdvlLQHh7yqajKDo=
=/K1q
-----END PGP SIGNATURE-----

--3joza362c3mcqio3--
