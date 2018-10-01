Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8E2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCBC2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="cjQRjhKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCBC2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJBCj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:39:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42021 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeJBCj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:39:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so10000813pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=epdQ4glNry3E8TfOTlB0eXqarlkliCgkPhIqDcT68Ns=;
        b=cjQRjhKrNFdsHjo5fyBDW/QlceeRIO75PafmMt9XePuP1wkDGkXobrw7exVUoRs7Sh
         btHxKS08RONWOvZzB5Qri+4OWKU7zU6EDsU0fXouM2YIg2QDwtCKzjX+bwk15CbmMTlj
         iu58CZpetI2iUYmLJWWgMPF3EZIqtQDe3dUO7xCDYlGsHCYIdiSN7ZZIsu/9lmPPLKrD
         YUho7OENEZ+8nboQ2hOO4RqM6oea3IjNApqGuSCMZYRID9ZbXr0ONS7lf+Kk/euHzKrc
         wgeCvACTgJq5uEitLpyBToef8M5yqlf2fsE/SvOrBo4iWwAw/P8jO9C5GdP+wdtKOtSW
         /jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=epdQ4glNry3E8TfOTlB0eXqarlkliCgkPhIqDcT68Ns=;
        b=V1YSpwO5kIrUy0vJrcpDid6xyS14z85AhL+Mh9Cxvum8yoR0ZbOTsvERCdZ4pT3oul
         KS/42g7Glri+NQnIwb5cT+QLMPrENQ+MYHzJPwxNZElCZbbsOfpsLsArl30h0DbVRTW5
         KPlkBxnnNkw3MsVqsUW7TVaLgIQVkWu7LKot9BbdxbTbdQYLqpxVuEegoSvbrnxgeJTH
         4NNkgL+IwpiNddhKXwChc/J4mv2s0Udt5txGXwkeoA0sP3N/dKAMyRmF87OaShA7Atxk
         DWNDx7yjMwZljj1RcO8hqyA7ZDnrakS/U5G1wbQDjOmmya062qlzoLuRLLkUYnnnCCuu
         qkIQ==
X-Gm-Message-State: ABuFfojdP1LQEroM7nV95hfSb0tQWN5SgrhN6rEM7FYjocOccF3cqL22
        95Mawns3ZjqMJBoReOXkeZXjUw==
X-Google-Smtp-Source: ACcGV61YQE2sDmr+WkDIZLJRj/V/okSHNd5QqOmMw+1ukAicUQ7ij2y2jWy7zPaWQ5s9nEkyaF+3WA==
X-Received: by 2002:a63:5c63:: with SMTP id n35-v6mr6900847pgm.402.1538424032270;
        Mon, 01 Oct 2018 13:00:32 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id r205-v6sm20488783pgr.11.2018.10.01.13.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 13:00:31 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <404F3F76-402D-4E29-9957-429CB7D7ECFC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4596DF16-CEEF-4C6F-8E92-96CFCF730F45";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Future of dosfstools project (FAT)
Date:   Mon, 1 Oct 2018 14:00:28 -0600
In-Reply-To: <20180929084038.an6pfhnsd6tblejl@pali>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
References: <20180929084038.an6pfhnsd6tblejl@pali>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_4596DF16-CEEF-4C6F-8E92-96CFCF730F45
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Sep 29, 2018, at 2:40 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
>=20
> Hi!
>=20
> Last year I did some research how Windows and Linux tools handle FAT
> labels (boot sector vs root directory) and proposed some unification.
> More in thread: https://www.spinics.net/lists/kernel/msg2640891.html
>=20
> My proposed change for manipulating with FAT labels is now implemented
> in util-linux v2.33, prepared new mtools version, and also in =
dosfstools
> git (unreleased) https://www.spinics.net/lists/kernel/msg2645732.html
>=20
> Project dosfstools contains de-facto standard Linux userspace tools =
for
> FAT filesystems (mkfs.fat, fsck.fat, fatlabel) and so it is quite
> important because of high usage of FAT.
>=20
> But there was no new release of dosfstools since Jan 2017 and for more
> then month I'm unsuccessfully try to contact maintainer of dosfstools
> project (Andreas) about future of project itself.
>=20
> I do not know what happened, if either Andreas do not have time or
> something else...
>=20
> So does somebody know what is state of dosfstools project?
>=20
> Also there are lot of proposed changes (with patches) for this project
> https://github.com/dosfstools/dosfstools/pulls and also more reported
> bugs https://github.com/dosfstools/dosfstools/issues
>=20
> If Andreas does not have time, can somebody else at least look at pull
> requests and do some code review?
>=20
> I have some other unpublished/unfinished changes for dosfstools, but I
> do not know now if it make sense to invest more time in this project
> when maintainer does not respond... if this project is active or going
> to be dead...
>=20
> If dosfstools is going to be inactive/dead, there is still mtools
> project with provides FAT tools too and maintainer of it is now
> preparing new bugfix version. So at least some alternative exists.

If the current dosfstools maintainer is non-responsive, you could always
fork the project in GitHub, land the critical patches into your branch,
 and make a release on your own.  If the maintainer surfaces again, then
they can pull in your patches.  If not, then you are the new maintainer.

Cheers, Andreas






--Apple-Mail=_4596DF16-CEEF-4C6F-8E92-96CFCF730F45
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAluyfNwACgkQcqXauRfM
H+Cc7A/+P5AaNxOVq2Nf9I/rkxajuSt1LmUb0kc/o/bVRLzeHXHvKup2svrtDCoq
kcahTf4iAQRc6A0FIMen9USo3TihLpiS2OJ7oE25WUrhE66nlCAMhIpTzWuzX190
7CETWuGlyt93kOQI7DV5esrhxNwzVwh0uAMsNRjtcsjfg/eWn96sFZ3ywxro/0WC
/b+TwBWqFfkUdBBOPgFXK/c4HHV5Y3xjHPHhr98bWFRbSZgibkhokNjXTbBpJHGe
+Srmm+fgfMmZU12+IedlgQyFewcM+3G/kb5ahXvn+6PDEeUAPD2QBqDppuQSBfq8
E04mqOiIMIV5tuX0lmN5fgdAT3PILjBzzLM32a7Y6B9cTH+9s3d88db4kQaUfa16
V66Ad0G+1C8N2Isbf8XQgzhzJX5kxNqEqr53GVoiAiy5Et9odcH9BjS7YuWfSyE+
1Q5SZDOH59dW+y/g4Q35GFLVrxOlBxjwy+X3R2NzdlohLbvS0Xh0OM/IT7M73vad
w/G6ix2T95fRJeM8Onl2X/6bvGJwzSHz8TFrwuevmN4bY+p4y7ShLJey9AxAH5Pi
7q0CtHrjoZvX587VYJxgeTz9tQgXZnNhEbm+Y05NzNUrlJ6r77Gz8+MRLxfdLCT8
QmU2SIiwber7/h1/QxZgMmKx9EYzP2aVviiFhJITC3pQWRJEXso=
=En8f
-----END PGP SIGNATURE-----

--Apple-Mail=_4596DF16-CEEF-4C6F-8E92-96CFCF730F45--
