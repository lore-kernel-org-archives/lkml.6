Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7798C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB1A2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="oyYbGhkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB1A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbeKFHvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:51:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39263 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbeKFHvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:51:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so5143645pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=XuTD0o8VQjl+A2Kw1l4UVsqPbL/IeGIHbmfjGyXJug8=;
        b=oyYbGhkp4goTkpDqsdS1i1NVX0dquhi0JR3SQj3dS8mht4FR2aykAw1nSWUYDQKo9Z
         1NW3HHUqZMI8sL5v1n8nXK/Rnyg/nPyLfqrpp1GOzKHV2R+JcyqIT17WpmYVLuZQTfDq
         0/kCv17NaAqRCghcF9HPjkzUpKHm1WDZT3RpBywbt53d2YqsXZKYQgCpJ6tO8RtvSRfM
         RVX1NxFXbjUEn9k/WKtyw6KgPjVsCyyAQe/W92BjnPt7XRPetp9UMf7EstnxKcKFIBjb
         orUKDJMdSHQs3fiZtU040dCag4hUnY1Rr37OXxHYL72hebN9dF9S4/6+EUZBnyxfeUz/
         0Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=XuTD0o8VQjl+A2Kw1l4UVsqPbL/IeGIHbmfjGyXJug8=;
        b=OkyAdH7pREsOJSFCIqSMHMnyMXeAsrKvc/dqM1wFq8/lb2jp/GAYUUTno5LbZ/Pj9u
         6he0xAovNbdqvevVrPSvAOirmmLCI7j0XMOsmvLObRrcWskGEhA8jdBvIgWoMFhgB3nI
         sis+4X7eYeTouITowAEfXqBFtKBis7YhqJ6V6cmrPNxT5hWHZc+hpTE4jc+VwbKYOrQX
         9KdnluPohGH/4tnTnOg2SPqA7e1fX9Zo7Iw4Q3mp2i4bEOsmJwcqTbvIHrmYe+q0payJ
         zt2EEgwHxaRmfJQmhCZgo6r4ZIqaCeshtMThtTy5ufop+a127pLHfEjIjIJbDVeltXDq
         f+zA==
X-Gm-Message-State: AGRZ1gISLRbEZjQ3ImLZY0MoLuzx9WxluA4s+uYrlHEgpblZnG1MW0Ki
        ls+Lf6ihRuWZ3/vu94GhIQhJOAWq4ncMFQ==
X-Google-Smtp-Source: AJdET5fN7jBBwgPIxnRh3VjUQzNH83liePsew+0rJZsNxD5K+yvSnmDOJK8+duaUi2dD6PU2TlUkdQ==
X-Received: by 2002:a17:902:443:: with SMTP id 61-v6mr23484988ple.216.1541456948000;
        Mon, 05 Nov 2018 14:29:08 -0800 (PST)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f13-v6sm50094473pfa.109.2018.11.05.14.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 14:29:05 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6E9E333D-CD57-4EDB-A55F-CD79DF9E2811@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A3D1DE8D-EBD7-45B5-AD6A-BDCAD24D6C1F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 5/5] nfs: don't clear STATX_ATIME from result_mask
Date:   Mon, 5 Nov 2018 15:29:02 -0700
In-Reply-To: <fbc3501c07fd48e65c0ffc8634870bf57a6f7fe1.camel@hammerspace.com>
Cc:     "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "fw@deneb.enyo.de" <fw@deneb.enyo.de>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
References: <20181019122049.27121-1-mszeredi@redhat.com>
 <20181019122049.27121-5-mszeredi@redhat.com>
 <2ca365ec330cf918188e8c47b26e741073382d9d.camel@primarydata.com>
 <CAJfpegtq1+vZ+uXwzFs20GeSPCR9UbtqD5-fOn8ynoJUJYx25g@mail.gmail.com>
 <05184f29b5778563519174769c675c5f6c5b2dd3.camel@hammerspace.com>
 <CAJfpeguFe=KcahJmZire52TPppMk8amiTJFiBZuv=97bRbCj8g@mail.gmail.com>
 <fbc3501c07fd48e65c0ffc8634870bf57a6f7fe1.camel@hammerspace.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_A3D1DE8D-EBD7-45B5-AD6A-BDCAD24D6C1F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 20, 2018, at 11:46 AM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Fri, 2018-10-19 at 22:48 +0200, Miklos Szeredi wrote:
>> On Fri, Oct 19, 2018 at 8:14 PM, Trond Myklebust
>> <trondmy@hammerspace.com> wrote:
>>> On Fri, 2018-10-19 at 19:46 +0200, Miklos Szeredi wrote:
>>>> How is it then that only STATX_ATIME is cleared and not the other
>>>> fields?
>>>=20
>>> It isn't just the atime. We can also fail to revalidate the ctime
>>> and mtime if they are not being requested by the user.
>>>=20
>>>> Note: junk !=3D stale.  The statx definition doesn't talk about the
>>>> fields being up-to-date, except for AT_STATX_FORCE_SYNC, so stale
>>>> attributes are okay, and do not warrant clearing the result_mask.
>>>=20
>>> I disagree. stale =3D=3D junk here, because the default of
>>> AT_STATX_SYNC_AS_STAT is described by the manpage as "Do whatever
>>> stat(2) does." which this is not.
>>=20
>> Ah, you are talking about this:
>>=20
>>  /* Is the user requesting attributes that might need revalidation? =
*/
>>  if (!(request_mask & =
(STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
>>                    STATX_MTIME|STATX_UID|STATX_GID|
>>                    STATX_SIZE|STATX_BLOCKS)))
>>        goto out_no_update;
>>=20
>> Well, if this is triggered for statx(...,  STATX_ATIME,
>> AT_STATX_SYNC_AS_STAT) and MNT_NOATIME, then yes, result will be
>> junk. Which means that the code is wrong, it shouldn't do that.
>=20
> The problem is that vfs_getattr_nosec() populates stat->result_mask
> with a default of STATX_BASIC_STATS, which makes no sense unless you
> assume that the user will always ask for a superset of
> STATX_BASIC_STATS (or you assume that those attributes never need
> revalidation, which is obviously braindead).

I guess the assumption in the VFS code is that statx is mostly called
by local filesystems, for which STATX_BASIC_STATS is usually right,
so the basic VFS helper is OK to set those stats.  It should also be
possible for the filesystem to clear flags out of result_mask for
attributes that it doesn't want to return.

For filesystems that know what they are doing, it might just be best
to always clear stat->result_mask and fill in what they want, based
on the available attributes and request_mask rather than assuming
something is set by the caller.

Cheers, Andreas

>> Otherwise (if something other than STATX_ATIME or STATX_INO or
>> STATX_TYPE is given as well) it *will* do the same thing as what
>> stat(2) does, so in that case STATX_ATIME should not  be cleared (yet
>> it is cleared).
>=20
> As far as I'm concerned, we can definitely get rid of the
>=20
>        /*
>         * We may force a getattr if the user cares about atime.
>         *
>         * Note that we only have to check the vfsmount flags here:
>         *  - NFS always sets S_NOATIME by so checking it would give a
>         *    bogus result
>         *  - NFS never sets SB_NOATIME or SB_NODIRATIME so there is
>         *    no point in checking those.
>         */
>        if ((path->mnt->mnt_flags & MNT_NOATIME) ||
>            ((path->mnt->mnt_flags & MNT_NODIRATIME) && =
S_ISDIR(inode->i_mode)))
>                request_mask &=3D ~STATX_ATIME;
>=20
>=20
> however the rest needs to stay, or there is no way we can use statx()
> to allow optimised retrieval of only those attributes that your
> application cares about.


Cheers, Andreas






--Apple-Mail=_A3D1DE8D-EBD7-45B5-AD6A-BDCAD24D6C1F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvgxC8ACgkQcqXauRfM
H+DhlA/8DfrhlinN2C5XAwZltrRk/RhipSbv/YqBj6u2eTqVaL4y5B4BMlrUjtNc
LQ1cB51KKRQg8gqmVvAdxMXaWyctrHXlbVR9u44dYweCD48lsxzxJX+LnsJRF72J
Bk5QMXenxhQDuS+B8x/vI63/ReC995hq8/jlvs2w1CLZM2wnzUl4PqOwXkXO5cDt
3XniAVAbJ1Io9ESBPKwrztQ3LDraBR7Y3zcNI9n5UQrIxc2qoZGZso8vKs1j4DiU
TzOTIM+8qffNd6ZPPaOkbTHEkHlNXIlEjoNNxEecEF7YmtcgOq6RwstiiWqVB8kn
OHjhNjgjnhX591RCnlQkhacYbmA4NMKjlOYzUD5ie74Dv//XO/hDkbgROVrEzF30
ics3MQnvCzYkL4e+7Sj0OJigImS+lmjfSOartBjwHqCGC8pm5JE+32ojSYqSwPjG
BeadvZcMUimFIMv5StSjASa3u8/0h8x9S9vdmhi0BVpa0xYuBefF/pYyBFiXVGM/
w9i8XMiVxu3uX/oWzBA0/wEdiNHqV3whVyjcCGPT2k/u69G58I3V2GBkU90iIsme
k9Xmm5Ui7e/qF7SjG9cpg2OwTZsrPbquYKDKeU6QWAaizp5TwyctTxbdo6rI7yG0
YI6A1m2HCt5Y/qgtCfvHcPHOCduchZbnYT9dovJLMpSlCnZdPOQ=
=fMRQ
-----END PGP SIGNATURE-----

--Apple-Mail=_A3D1DE8D-EBD7-45B5-AD6A-BDCAD24D6C1F--
