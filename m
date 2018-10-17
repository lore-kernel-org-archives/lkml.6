Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABEEECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03291205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="pfHZxlCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03291205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJREUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:20:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36115 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJREUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:20:25 -0400
Received: by mail-io1-f67.google.com with SMTP id p4-v6so19619690iom.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=qOP5mYuiX7N2YazHpkOLhFfFBeNGRF3aGf9BBg7BgZY=;
        b=pfHZxlCVgXqCllQaUrsZRBsvQMf9uomoiDUpBIkyuay4Fl9SMYQ+TDU+NkSmm46b11
         xMFTsoqt+zmNZ/RY+TwXRx7BC80Fxma0aPTGA87glG3yWSIHtgNA6uEzzIYqmckkdVU0
         OuvzCA+kumRLt7HMMF1xaNYYCl4ZDtPe320Lwd/t/dZdt4FGe3PNw/ccVkEU3On0enwM
         vCY3SvMktSFcwItNmwCvCZudcSLCRpFQ4TfdCYAt0m/ndxxgFKQJjEUNUZOolcOaicHn
         xyweYaAfZYnJwvnn7Ivc10ocZrL6drkTHxxX/ibk0HWbfqKqCoZxDC/ClhtVGbRy5IFQ
         nMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=qOP5mYuiX7N2YazHpkOLhFfFBeNGRF3aGf9BBg7BgZY=;
        b=D3UpBdyRnFYacJJes7UoMVZXR0PujjUVSX5N6Fr+wXP29ZNyO9KeOogYa1hxdrGtm2
         2wVF8S9GjK0UGy9z3m/xmM+eBFzbhz3a5poOSgG/7O9gaahS+VCLo4bDS0kR8TO4zvwW
         jdk6CesI261syCSrkl+4sDEHaJreQOztsQPSkGZ51IwIuCNG9GGIR34RWzeYploJ/MKQ
         CO16E78m9L8b9vEVr3KyakaubThDSjEO8sP6BivPjdWcQqeX/9mKZTIuzOD3L01567dm
         qiBU/HFlgXEDgudM/rg6GIzSAg0lIK0DGU+opMumGbS8wM+A0ydrIVdeNT4ld7rOkxeP
         Xdtg==
X-Gm-Message-State: ABuFfojzrD1Efx9XXolPHM4vv3nG1qiy1Q/9qpySBldsQ1pkp2buoUML
        6U7r0SRawl5FaitlzmgYJ3vZFA==
X-Google-Smtp-Source: ACcGV60dGc21E0GIOyehuMJLT8Y30qqfBvEP0JgZ+mX+cHMHABaINr+4DA9/Z8sRi9ml0hshU5W+Jg==
X-Received: by 2002:a6b:1885:: with SMTP id 127-v6mr17284437ioy.263.1539807783009;
        Wed, 17 Oct 2018 13:23:03 -0700 (PDT)
Received: from cabot-100.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id n3-v6sm5564527ioc.77.2018.10.17.13.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 13:23:02 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E9903911-9289-4038-9835-9353762A3BAF@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_93E2257F-0FE4-4BE8-A439-506B41068230";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: statx(2) API and documentation
Date:   Wed, 17 Oct 2018 14:22:57 -0600
In-Reply-To: <CAJfpeguvJZbP83mSULc74Yhpp_CPMBW1XvcgbvCbLnF7QCncUA@mail.gmail.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
 <006890C4-64D4-4DE2-A1F0-335FFFD585BB@dilger.ca>
 <CAJfpeguvJZbP83mSULc74Yhpp_CPMBW1XvcgbvCbLnF7QCncUA@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_93E2257F-0FE4-4BE8-A439-506B41068230
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 17, 2018, at 1:04 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>=20
> On Wed, Oct 17, 2018 at 8:45 PM, Andreas Dilger <adilger@dilger.ca> =
wrote:
>> On Oct 17, 2018, at 12:24 PM, Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>>>=20
>>> I'm trying to implement statx for fuse and ran into the following =
issues:
>>>=20
>>> - Need a STATX_ATTRIBUTES bit, so that userspace can explicitly ask
>>> for stx_attribute; otherwise if querying has non-zero cost, then
>>> filesystem cannot do it without regressing performance.
>>=20
>> Seems reasonable.
>>=20
>>> - STATX_ALL definition is unclear, can this change, or is it fixed?
>>> If it's the former, than that's a backward compatibility nightmare.
>>> If it's the latter, then what's the point?
>>=20
>> The value can change over time.  It is intended to reflect the =
current
>> state of affairs at the time the userspace program and kernel are =
compiled.
>> The value sent from userspace lets the kernel know what fields are in
>> the userspace struct, so it doesn't try to set fields that aren't =
there.
>=20
> What's the point of a userspace program specifying STATX_ALL?  Without
> a way to programmatically query the interface definition it's useless:
> there's no way to guess which mask bit corresponds to which field, and
> what that field represents.
>=20
> And there will be programs out there which specify STATX_ALL without
> considering that in the future it may become slower as it is now due
> to a recompile.

The whole point of statx is that applications should only be requesting
fields that they care about, so "ls --color=3Dnever" shouldn't be asking =
for
the file mode/size/etc., and size/blocks should only be requested with
"ls -ls", etc.

> So what's the point exactly?

Ah, I see your point...  STATX_ALL seems to be mostly useful for the =
kernel
to mask off flags that it doesn't currently understand.  It doesn't make
much sense for applications to specify STATX_ALL, since they don't have =
any
way to know what each flag means unless they are hard-coded to check =
each of
the STATX_* flags individually.  They should build up a mask of STATX_* =
flags
based on what they care about (e.g. "find" should only request =
attributes
based on the command-line options given).

>> The value in the kernel allows masking off new fields from userspace =
that
>> it doesn't understand.
>=20
> Okay, but that has nothing to do with the UAPI.  Even as an internal
> flag we should be careful, as it might grow uses which can have
> similar issues as the userspace one above.
>=20
>>> - STATX_ATIME is cleared from stx_mask on SB_RDONLY, and on NFS it =
is
>>> also cleared on MNT_NOATIME, but not on MNT_RDONLY.  We need some =
sort
>>> of guideline in the documentation about what constitutes
>>> "unsupported": does atime become unsupported because filesystem is
>>> remounted r/o?  If so, why isn't this case handled consistently in =
the
>>> VFS and filesystems?
>>=20
>> Strange.  I'd think that if userspace is requesting atime, it should
>> get an atime value.  The fact that the kernel is not updating atime
>> due to mount options just means that atime might be old.  That =
doesn't
>> mean (IMHO) that atime doesn't exist.
>=20
> Right, OTOH I sort of see the value in  NFS: no roundtrip to server if
> atime value is useless anyway.

Well, "noatime" might be a client-only option, which doesn't mean that =
the
server or some other client isn't updating the atime.  Returning an old
atime isn't the same as not returning anything at all.

>>> - What about fields that are not cached when statx() is called with
>>> AT_STATX_DONT_SYNC?  E.g. stx_btime is supported by the filesystem,
>>> but getting it requires a roundtrip to the server.  Requesting
>>> STATX_BTIME in the mask and adding  AT_STATX_DONT_SYNC to the flags
>>> means the filesystem has to decide which it will honor.   My feeling
>>> is that it should honor AT_STATX_DONT_SYNC and clear STATX_BTIME in
>>> stx_mask.   Documentation has no word about this case.
>>=20
>> The btime value shouldn't change over the lifetime of a file, so
>> DONT_SYNC shouldn't have any effect on its validity?
>=20
> Not validity, but presence in the cache.  Network filesystem or fuse
> may or may not have it available in the cache at the time the inode is
> first initialized on loookup.  So when statx(..., AT_STATX_DONT_SYNC,
> STATX_BTIME) comes along, it may need a roundtrip to the server.  What
> should it do?

To my thinking, if the user/app requests btime/ctime/size/blocks the =
kernel
should return these fields.  If DONT_SYNC is set, it means the kernel =
can
return potentially stale values, but if the kernel doesn't have *any*
values for these fields at all it still should query the server instead =
of
just returning random garbage.

That said, it seems that it isn't even possible to get into =
nfs_getattr()
without the VFS having instantiated a dentry and inode (i.e. queried the
server via nfs_lookup() at some point), so the inode fields have already
been filled with *something*.

Cheers, Andreas






--Apple-Mail=_93E2257F-0FE4-4BE8-A439-506B41068230
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvHmiIACgkQcqXauRfM
H+A9VA/+Kpylm80gTZnIFdxJl7frYp0k3FiZTT+8nS17CuVnb21J3Cdv95T57xn3
dMIxOlDUTg32EKkRHdMAEC4Cg0cQM64xYVIVRvU5nXCUUT5fQvPFu0NJROF3HKii
PwWq5oDyA3GijAiBn6wWkqqfXdQwh28OBbEIwMOz0WSiDKIIsc+gVOxEYXfJCbJu
zUOHYfuVLkpNAeicY840ExkjtukqGAPcvXvIB2V9IRmmR3q2ePRk+15Y4iiPTCKb
5eOWZLq8wgp9n2e8EAsvpM0GHJO2Ys9uFcnwPNtPMzW4hhEx/SF7vKOaz4YSWKgy
4zmQkRyzImcsNuLf4ZGy/Rbd7/tZzkihMMX1qh4aJZJF9nzwgyd1Iun0+Ju3mbUJ
uDI2jazh+M8Ru6JKDKIOUr7ajV4bekng8tvMizf/aMhou3bK4m2zDLGebioFFf0j
9ylPITCqgNvjy+IfHhNas1KbQWTSR9Aw7sdl5vBU5na8m6+lQq+rVqQWmYCHA2b0
r7LR0oFBu6GSggsdiuqPsxZspA+Jz2hkMoF/uBZvV3BNzv+exezVpjfxrJNAZ6Zi
UoUdfnCuNxVwTH1FKwq+W8CYo3UQQQAdtkiMlpcVhabiHcwiuZF088jwc4GlAzAd
D+PPXMx85+BSCRqQR5tgO+UmM3pP42PV7Ls2BK4cA53ATqZyrck=
=GolS
-----END PGP SIGNATURE-----

--Apple-Mail=_93E2257F-0FE4-4BE8-A439-506B41068230--
