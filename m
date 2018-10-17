Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0694DECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF24821486
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="FbpvgD3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF24821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeJRCmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:42:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46825 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeJRCmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:42:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id r190-v6so1322677pgr.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=PToSBD7oqxOydWrsXjeracRZozpn2NHPrcMvL9xq4qM=;
        b=FbpvgD3cRmnSnBtz5oEpEZ5hqacIt6xUCIz0e2hqssrI1Juz8tAzFIlMtHYF9ylw3z
         12o7Cuw83YLvWn9XoBNspArNUhAkXJQ8d6qNfPpnGefpedBcSdFGDyYyZXDXEAf5Fs98
         gygVv8C++B+pa3bFEwtJIOvx/S+Fd3DQ5ZU/auXGs9yKcgKrQdyVqVFRWEQRXIKi36/U
         RYezpANEwnMhmu2ocoXD1w47O+xTUEtPiQvaSNZ6Ks0bwNhoxnlOfLG/f7O9iKQ8aRMF
         jesAFcdRTH5N9QkgrQffgat1HipQyYp4mxj9v/YsKKS6CZWSxw2jsSEmCi8lTtsEKzSV
         QEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=PToSBD7oqxOydWrsXjeracRZozpn2NHPrcMvL9xq4qM=;
        b=R5el7xop9X/mXJwRsUgC/uAMbAl+DQNi74PCvZtYzAZRWaxeEYExVysE81OnXL2/Hz
         RC+TVrwYg5ulQC0C3maCbG79pAcyAz1KJnJnyG32jpCrUaACTFG76tuMvQ+mdUUSvG+f
         K5pGqG8dGjEX8Wsg9PNDlgyLN+sKy/itDyDIsGmgUHiL6PaNjHl3BLuLlAsxe5NzKlLT
         sdRhzUiwjbJbft89UWgHodrBYtqdpWvU6W0jPbQDrNnlx5tGwikCkSoC99r5i071lHzB
         oehqi3KRLbDF/WjtBQk0eefCiAFHPcgDDzpQy2557tPeWSh9+HIfHit7jM4Ah8H0pnYX
         AA6A==
X-Gm-Message-State: ABuFfogF8Zk6ek3lHvheNe14LQ0+z/bxoT7yx85gvmd5RO5NkwHnABR1
        e05SgT/E7++k7PW9k0EFZVt5Xw==
X-Google-Smtp-Source: ACcGV62Ox23aIVurx0c7uKm7Hwq4PSjIZiuw1QneU5esyArPS0PWPkwtQQNgPc5RwI1N1uXowygHLw==
X-Received: by 2002:a65:5147:: with SMTP id g7-v6mr25905160pgq.252.1539801946191;
        Wed, 17 Oct 2018 11:45:46 -0700 (PDT)
Received: from cabot-100.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 68-v6sm24222046pfg.136.2018.10.17.11.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 11:45:45 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <006890C4-64D4-4DE2-A1F0-335FFFD585BB@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AE0B5849-9F29-4FFB-A808-0809BDB00948";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: statx(2) API and documentation
Date:   Wed, 17 Oct 2018 12:45:43 -0600
In-Reply-To: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_AE0B5849-9F29-4FFB-A808-0809BDB00948
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 17, 2018, at 12:24 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> I'm trying to implement statx for fuse and ran into the following issues:
> 
> - Need a STATX_ATTRIBUTES bit, so that userspace can explicitly ask
> for stx_attribute; otherwise if querying has non-zero cost, then
> filesystem cannot do it without regressing performance.

Seems reasonable.

> - STATX_ALL definition is unclear, can this change, or is it fixed?
> If it's the former, than that's a backward compatibility nightmare.
> If it's the latter, then what's the point?

The value can change over time.  It is intended to reflect the current
state of affairs at the time the userspace program and kernel are compiled.
The value sent from userspace lets the kernel know what fields are in
the userspace struct, so it doesn't try to set fields that aren't there.
The value in the kernel allows masking off new fields from userspace that
it doesn't understand.

> - STATX_ATIME is cleared from stx_mask on SB_RDONLY, and on NFS it is
> also cleared on MNT_NOATIME, but not on MNT_RDONLY.  We need some sort
> of guideline in the documentation about what constitutes
> "unsupported": does atime become unsupported because filesystem is
> remounted r/o?  If so, why isn't this case handled consistently in the
> VFS and filesystems?

Strange.  I'd think that if userspace is requesting atime, it should
get an atime value.  The fact that the kernel is not updating atime
due to mount options just means that atime might be old.  That doesn't
mean (IMHO) that atime doesn't exist.

> - What about fields that are not cached when statx() is called with
> AT_STATX_DONT_SYNC?  E.g. stx_btime is supported by the filesystem,
> but getting it requires a roundtrip to the server.  Requesting
> STATX_BTIME in the mask and adding  AT_STATX_DONT_SYNC to the flags
> means the filesystem has to decide which it will honor.   My feeling
> is that it should honor AT_STATX_DONT_SYNC and clear STATX_BTIME in
> stx_mask.   Documentation has no word about this case.

The btime value shouldn't change over the lifetime of a file, so
DONT_SYNC shouldn't have any effect on its validity?

I think DONT_SYNC applies to values like size, blocks, mtime, ctime
that may change rapidly over the lifetime of the file, so a totally
up-to-date value is not needed from the server in that case.

Cheers, Andreas






--Apple-Mail=_AE0B5849-9F29-4FFB-A808-0809BDB00948
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvHg1cACgkQcqXauRfM
H+CqrRAAgoCd6bKzHq0tRoHjcysy7L0xS8sTqhX+GhRC5ZYfLOFiLMjZYHu81Bsf
h2Ra6QC/QnTHzI+4eht3uQr4dZUBTQ7bYtBlzG6uJKo/SWbX2ZU8vlmZR9kUfRnb
6O8AgTFRh0k/aEkZQQNYnBazexET+ypTPwilMg0y4K0sUDuGGQudmI90P92/aZ3S
8Rps0+J9XYEF9Oe1fvWf9vZzmHvVnm9m4McFubcktR28uo1qJWQsDLOoLfI/NS/m
KJthGnbG00wlka+nrumvU3CH6aKu7PkUAqcCS8ZSyrT1+NXS0fnJJYcFXAHvET+X
0h5TGr0SBCVvvzV5eu72T30XAShfgekg281keR0+bUXqGrLjdf0HikJQYoqfrB+e
yMx5CWy5beCd81Dm+Q7z2sszMxJuzQMplG35Q/vitZWvHfMt0JsCGkLO2/kTDuRc
pdd1bBzfMtcMvLXl6km7jUJln8+y0oGs8cVSZRv3k0mQf8xWDTTpKAG3R1goi6P+
MZA/iNVJD1k8GL/v9LPiHqajHci2cFiRrZuM8LWUhwNac84NW0kVSjYgHHypHxFS
vE18YIr9qQypTv0S1+1JNDcMZlrPkr1o3sf0omoL61FWz1BwImV7Kere8Gd+UN1y
L875khg4P9QbUdyXUY+MOZBCqbmwYr/3C97n2m8hCtHAm1kIdbg=
=GULC
-----END PGP SIGNATURE-----

--Apple-Mail=_AE0B5849-9F29-4FFB-A808-0809BDB00948--
