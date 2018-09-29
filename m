Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B9C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800972084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKNJplro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800972084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeI2PIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 11:08:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39784 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeI2PIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 11:08:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so4228130wmq.4;
        Sat, 29 Sep 2018 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1Z2JBKiEOl1TXZs8MsgSkRCdNpEbZk5MR2Xv/HKGD7Y=;
        b=HKNJplroxoIjKypXOmu7hh9s4hk8kiQNjKnnWQZjWkZhABbEaWGaihe1TcT5ksboLU
         0BQ3X87nbesyRsqVaLXb/xIBOncfTmrsJSdU8X2BdimayGXcI6KPgr8QvPdkOS5ISEFr
         dVtbSj4uOR78QYMf7hayvrFZrF7a0khIMUl+ACXOA5q6fdG7DG9Epjb095dhhZP+j+zy
         7R4l9NcbLB97XPmFG5JzN0VP0fOptp9xqvvXC4T6B2yjehLGB8DFv5pJ9pc6nFFRCV3v
         F912Ry0wad6L4xr8k+qyHxO1KQxTn2XeJR/HNRNVcmU870JrQ8WtBTg+xbnAluiKDOAy
         RaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1Z2JBKiEOl1TXZs8MsgSkRCdNpEbZk5MR2Xv/HKGD7Y=;
        b=lPEn8xBZRmyiSBeRnFOnb/Y0u4MkfJP08cBocOrQfF3LAVnUNUCPCqhCPTaVPjCxz3
         SVbADZXMnaZ/DofXb+W20R1+Z2A3/GuRfoCucWahXrpx1qaq+WxOWizmyQgjCcP6gqF4
         X+7TvajLMENLfNbXRiTLEXVE4NaS8FR7bCsS3I+s/x/bchLH1lK9fHyxZUNQu16uFMyP
         /INSZnJ+3aRJa5aCieUYSGcDcn6Ir2z1RRpk4TITJeYYq7RR9paYiG2rfZzh06QSfO/t
         cjhue+O/GdNyHJwAacCzkalpphOKDu2FLt3KYbfqEEPzufaWVtyitwDTNcm9x/zcB1ki
         hxGg==
X-Gm-Message-State: ABuFfoi8bt8zaOZoamRQZdCt4BPbJfNcNNi1LA9b0Z4TW4I8kvrIKsv6
        chWicrrHH1mGVJ77ghhAGvtngApl
X-Google-Smtp-Source: ACcGV60snTnaaEjEgWot1sC/A4PQU4MidL70csTt8IysdPn1KPIvwwHyrcDORwAvvtGKw5tdpHELJg==
X-Received: by 2002:a1c:c2c3:: with SMTP id s186-v6mr3988762wmf.16.1538210440735;
        Sat, 29 Sep 2018 01:40:40 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c19-v6sm7578397wre.86.2018.09.29.01.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 01:40:39 -0700 (PDT)
Date:   Sat, 29 Sep 2018 10:40:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>
Subject: Future of dosfstools project (FAT)
Message-ID: <20180929084038.an6pfhnsd6tblejl@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bhtqwubaqu7r5vc7"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bhtqwubaqu7r5vc7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Last year I did some research how Windows and Linux tools handle FAT
labels (boot sector vs root directory) and proposed some unification.
More in thread: https://www.spinics.net/lists/kernel/msg2640891.html

My proposed change for manipulating with FAT labels is now implemented
in util-linux v2.33, prepared new mtools version, and also in dosfstools
git (unreleased) https://www.spinics.net/lists/kernel/msg2645732.html

Project dosfstools contains de-facto standard Linux userspace tools for
FAT filesystems (mkfs.fat, fsck.fat, fatlabel) and so it is quite
important because of high usage of FAT.

But there was no new release of dosfstools since Jan 2017 and for more
then month I'm unsuccessfully try to contact maintainer of dosfstools
project (Andreas) about future of project itself.

I do not know what happened, if either Andreas do not have time or
something else...

So does somebody know what is state of dosfstools project?

Also there are lot of proposed changes (with patches) for this project
https://github.com/dosfstools/dosfstools/pulls and also more reported
bugs https://github.com/dosfstools/dosfstools/issues

If Andreas does not have time, can somebody else at least look at pull
requests and do some code review?

I have some other unpublished/unfinished changes for dosfstools, but I
do not know now if it make sense to invest more time in this project
when maintainer does not respond... if this project is active or going
to be dead...

If dosfstools is going to be inactive/dead, there is still mtools
project with provides FAT tools too and maintainer of it is now
preparing new bugfix version. So at least some alternative exists.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--bhtqwubaqu7r5vc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW686gAAKCRCL8Mk9A+RD
UvXVAKCr6iGBqFh8fo/05TIjyc5wayLyFACeNWmBCWH1icwfZ6yK20IaPZpNI+k=
=c8Sj
-----END PGP SIGNATURE-----

--bhtqwubaqu7r5vc7--
