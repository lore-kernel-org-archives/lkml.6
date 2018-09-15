Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872AAECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EC9208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="aTaeepsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EC9208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeIOXZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 19:25:03 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33053 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbeIOXZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 19:25:03 -0400
Received: by mail-it0-f66.google.com with SMTP id j198-v6so7467652ita.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=9FuFpEW6OluqKuthX4CBa7sv1x7Xc51tUAf4oFYFBUg=;
        b=aTaeepsak/NP5fWbaVMz12ZOPIs3lSui1LS9oesTQ9+CFTkWJvFCcI40EOKTSjIssS
         B/OLwq07oXEU/oZex6zBURgRiAKesOak27G8TpnYo41MjOOJvtDx+LRrW3nPJEzCBbet
         sve969pZC3q29F8E4EENy6YL6mTitkYuX5Whx5ISUOQ6OWYF0oeeKLS7fFRjC6Xd9Z5w
         +fGxkT4lrdG9Z/Ny4MM3FV82GEFYCvaan1BtcY0fU7wq68Bnp34dSz3RUOzgmVuZA1Km
         NHA/aO6mGD0Zp1vuHmaPWfBM5xsFKYk81HGiBl/WnOkFue7FuckV+ECnFxgEfNp5VTTq
         db6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=9FuFpEW6OluqKuthX4CBa7sv1x7Xc51tUAf4oFYFBUg=;
        b=Am7w5SIhimdo53D9gm8e2BipZ2t2wuUw4eZMvf+T1X6eolAkx8i6w3wy/IUShJWGc4
         oGA0Vi5XfMJjyQzuZdUw5NSlyTHL/6r+aMx+YARoofDjhYPFaEPANnp6VZRir8vZR5qN
         Pxs4lrt9mr/KotTM3ml9ybBrtWgQY+31pZzTB7dHzhhwUo3uBs2JWtabuBD13CMZTCeo
         oNoZbVGUOpCqq3T08Sn4wk7VqmH/SKT+v+4+dz/t8sPCG8EE9grh8yVUu5kLFEzGWZ5Y
         YWQ1Nbfhe6WTXFxatdZt+EkENUNFiUeonp0sbfkDOmpjBxwenYTaKZb0uIrbKUBMiJog
         XBCg==
X-Gm-Message-State: APzg51AJYpIk88TKEOUuSjn/ST6VEYog33s6H/HQ81a6bWbQDrGQ4tC0
        conFTCpJnUy5F2aNJApLCWW0vA==
X-Google-Smtp-Source: ANB0Vdb1ZGn0DdNfCFXxTDMKlAWYr8S1/asoY46w4kRMBMm74JLlNGrhdOrcIB2oQaYAGgxOtqOZiw==
X-Received: by 2002:a02:c7d1:: with SMTP id s17-v6mr16199580jao.27.1537034712642;
        Sat, 15 Sep 2018 11:05:12 -0700 (PDT)
Received: from cabot-100.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id y18-v6sm1077998ita.29.2018.09.15.11.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 11:05:11 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <22C71398-EFD7-4638-AAE4-CE7E30E95B7E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_024CC7D5-5AFC-4E92-92E1-51525F7D4B85";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: metadata operation reordering regards to crash
Date:   Sat, 15 Sep 2018 12:04:51 -0600
In-Reply-To: <CAJDTihx2MEpdWdp6V6AsOD35Lh_6R=uFXBGtO8fL8s0o5C_t8Q@mail.gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, cmumford@cmumford.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
References: <CAJDTihzzLV3qwg0tGH_D4xAjCrgMy+oc4H9snpnMC_RC2q7nyw@mail.gmail.com>
 <20180914222336.GD16550@dastard>
 <CAJDTihx2MEpdWdp6V6AsOD35Lh_6R=uFXBGtO8fL8s0o5C_t8Q@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_024CC7D5-5AFC-4E92-92E1-51525F7D4B85
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Sep 15, 2018, at 12:58 AM, =E7=84=A6=E6=99=93=E5=86=AC =
<milestonejxd@gmail.com> wrote:
>=20
> On Sat, Sep 15, 2018 at 6:23 AM Dave Chinner <david@fromorbit.com> =
wrote:
>>=20
>> On Fri, Sep 14, 2018 at 05:06:44PM +0800, =E7=84=A6=E6=99=93=E5=86=AC =
wrote:
>>> Hi, all,
>>>=20
>>> A probably bit of complex question:
>>> Does nowadays practical filesystems, eg., extX, btfs, preserve =
metadata
>>> operation order through a crash/power failure?
>>=20
>> Yes.
>>=20
>> Behaviour is filesystem dependent, but we have tests in fstests that
>> specifically exercise order preservation across filesystem failures.
>>=20
>>> What I know is modern filesystems ensure metadata consistency
>>> after crash/power failure. Journal filesystems like extX do that by
>>> write-ahead logging of metadata operations into transactions. Other
>>> filesystems do that in various ways as btfs do that by COW.
>>>=20
>>> What I'm not so far clear is whether these filesystems preserve
>>> metadata operation order after a crash.
>>>=20
>>> For example,
>>> op 1.  rename(A, B)
>>> op 2.  rename(C, D)
>>>=20
>>> As mentioned above,  metadata consistency is ensured after a crash.
>>> Thus, B is either the original B(or not exists) or has been replaced =
by A.
>>> The same to D.
>>>=20
>>> Is it possible that, after a crash, D has been replaced by C but B =
is still
>>> the original file(or not exists)?
>>=20
>> Not for XFS, ext4, btrfs or f2fs. Other filesystems might be
>> different.
>=20
> Thanks, Dave,
>=20
> I found this archive:
> https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg31937.html
>=20
> It seems btrfs people thinks reordering could happen.
>=20
> It is a relatively old reply. Has the implement changed? Or is there
> some new standard that requires reordering not happen?

There is nothing in POSIX that requires any particular ordering.  =
However,
the sequence "A, B, C, sync C" on ext3/ext4 has "always" resulted in A, =
B
also being sync'd to disk (including parent directory creation, etc).

For a while, ext4 with delayed allocation resulted in write A, rename =
A->B
causing "B" to potentially not have any data (commit =
v2.6.29-5120-g8750c6d).
While the applications are depending on non-POSIX behaviour, the =
operation
ordering behaviour has been around long that applications have grown to
depend on it, and consider the filesystem to have a bug when it doesn't
behave that way.

If you want to write a robust application, you should fsync() the files =
you
care about (possibly with AIO so you get a notification on completion =
rather
than waiting).

Cheers, Andreas






--Apple-Mail=_024CC7D5-5AFC-4E92-92E1-51525F7D4B85
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAludScsACgkQcqXauRfM
H+B51g//RtucN7xoWHw6x+k1YAOFJXpc5sYOBfCT4EktAn1NuTkNcSd8TIJ9Y1Ad
EJvzQAt9K8PwuLcMCsD3hef1cG2D66UwCyw+HMCxftlxOJ32dh1ZNc3Vg3L1KUf2
EkepyzDrApjsxnjTq7u4L1cykmhZs/hLPvN+XfJFqeyLSsBxUUU1raE+THfLH+sW
8cmCIurnCRH7RgSq1wq0/mZbWTPoH6TDi3bTco7I5zPMAb2a1PIb8pqtUXuoPuzS
jW2xQ4CqcCqLboaCbEplQBa75U/SMIUmNX+RoUxXpcIFnE5dOdUmGSq/Eq+708bo
Oil6MBhhnspiijQOzLsbhp2Wg2kpDFpBeUjdU/vTHx3VArACUUjYwjjE8qJya5NY
X2JTKjYLjra1As/09hU7ccbyWGb9JmPKd/+rUQRDFr8uhBi5+I0TRxjkTwqaVd/4
DKhb5VZJNVead4KzvalAItckvrJEOqKHzM0tpjSujNCJvn834GhipQiFC/jnZWsu
Lrupc0nmm+Gk35bvasGtnZXZ2ekovzpQEhGP2PIG2UiUIEelF48ex9D5f4vaOUVI
OcAxjRsspU2BIccEOEIAXfSzp6Ct/3X/jtvAyX8rt4FwnTpCMR+QkBbX2FVJWG5V
Bzsuw4Hj3FzXnd3/zyJu+k53Qxa1dSOwPu7J97KZWCAvzHbZCyM=
=/EmR
-----END PGP SIGNATURE-----

--Apple-Mail=_024CC7D5-5AFC-4E92-92E1-51525F7D4B85--
