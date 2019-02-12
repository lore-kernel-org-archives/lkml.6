Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58136C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266FC222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="bC+zksAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfBLUSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:18:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32899 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfBLUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:18:17 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so6623pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=jXIL3RE29PsDPaZGlmdeX+8uicygNALwHWDyev5kLPs=;
        b=bC+zksAw7D2RF8ejW6ImYyx5tBsGCQl57+JYJE7SH8F893K5vf/mHY6Ytl8dNeKI8y
         LqzZnhM+7BjmzmQOM/gVjY9b0/ptXyS0DSNCPgDYYqYe/GjUTZ1O8IfaqjcDNJC551M5
         hMxxkgE3Aql34kU2owDMPdQXtZmIeYBNNKWqS6IuRlzTEZifFsBAQPtMcXp4jrGAO06f
         de6b49KUZQ5ZtuVvV5Suj2/61EWo9iXm5W7SKViwZibdmdbpxTfzAzbkPUK+Wklp9wub
         TJ/7Hjjq7C/bQoMBQHsEfzYWPQepLRz19ASLxyWTeQfSmG1+SgtcFeBrxSCT8BiyALde
         I6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=jXIL3RE29PsDPaZGlmdeX+8uicygNALwHWDyev5kLPs=;
        b=ChgitAXlUhQS9uQyVhMAcgUQOh35tpMaQOEN52x09bHYMvjrM89Mdg7gTdkib+tA38
         zhxan8IPhptiG/Vwwq2jY0oNBpYY5bOFXPsVQ6/+H/HALz+bDYXpsf9ofag9SD/qHKIQ
         aZ4MimnYwiGjHoHOrWZOwFE1YRMKI5dxzgAMdBwawb8oV3SoeGIEn1TafU3l8W9gyA4+
         UIc6xQ8aXZU4Pf9RvvkADY53pJE9CoRK3tcU36oTzVVGXUg6oRatx7IqjFiozENdzJPu
         05aSi+47+HtK9MEV0T2kDlE6leA8O3VPx5YWirzuW0dQXcdlWbyfm0n4cxpOeoYdfsWH
         7PjA==
X-Gm-Message-State: AHQUAuYxAe8oiUZVXI0DJDKDccm55t4aLSh75hNZDEsTI1GFutrmynZE
        M5nEA8aHS1saZsZCmdeuiOX3BQ==
X-Google-Smtp-Source: AHgI3IaKy7IJALxOPrc2zoWXWq71ffn6cm6JreVBRaVBnM/cGqHb/ICPI0xV+pwKEMQJbcCjORpg9Q==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr5754759pfe.130.1550002696225;
        Tue, 12 Feb 2019 12:18:16 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id q28sm26449690pgl.35.2019.02.12.12.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:18:14 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <EC2075E7-CB9B-4DC0-B041-1EA1100D6748@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C2E7E05C-2B20-4EA4-8AA7-025ABEE10788";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/4] Expose O_PATHSTATIC to userspace
Date:   Tue, 12 Feb 2019 13:18:10 -0700
In-Reply-To: <20190212145450.2200-2-demiobenour@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
To:     demiobenour@gmail.com
References: <20190212145450.2200-1-demiobenour@gmail.com>
 <20190212145450.2200-2-demiobenour@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_C2E7E05C-2B20-4EA4-8AA7-025ABEE10788
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 12, 2019, at 7:54 AM, demiobenour@gmail.com wrote:
> 
> From: "Demi M. Obenour" <demiobenour@gmail.com>
> 
> This adds the file open flag O_PATHSTATIC, which ensures that symbolic
> links are *never* followed, even in path components other than the last.
> This is distinct from O_NOFOLLOW, which only prevents symlinks in the
> *last* component from being followed.
> 
> This is useful for avoiding race conditions in userspace code that
> should expose only a subset of the filesystem to clients.  This includes
> FTP and SFTP servers, QEMU, and others.
> 
> Currently, O_NOFOLLOW must be set if O_PATHSTATIC is set.  Otherwise,
> open() fails with -EINVAL.

I don't want to bikeshed (discard suggestion if you disagree), but why not
name the flag "O_NEVER_FOLLOW" so that users can see it is also related to
"O_NOFOLLOW"?  Otherwise it seems like they are two completely different
things from looking at the names, when in fact they are closely related.

Cheers, Andreas






--Apple-Mail=_C2E7E05C-2B20-4EA4-8AA7-025ABEE10788
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlxjKgMACgkQcqXauRfM
H+D8gQ//e+7SA0vBv61wtMK0lXxO3SfVSJHlv9UYGJ8XiaZh8Ui12qH9UsaiuZki
o0b2ChHlUVmgWRHB0wDxQ2L8Iabf/WZ+bzYiRU9DE+VDaDHsZusNmpQKRiafEmDw
lOMwc/gvwLColA4Fjl+4CfcSyXURrHCG+pINi+EA+cg8X+qSwMWSvJ/G+39rvJ/Y
jP19/zxoQ9hAvyKo0acpA2/a2LvMAJ9eFySYURD27IniButV/e4YwuzOMy55dp74
rlvElPktrVJtJ4Wg2smHM2978OLAO96RKxBi3UlfeppscQ8ABn/mPPgZjBP7N2yD
NWUxcNEkB6pRznKx/ItqH21B4DZ3ma2QLDu6Hfb59PWBoY0UK86Q4SILJJ7sioxf
eda/pQcmHbj9gefg4IMGjMZ4KK3iuAdDJt/PM/nWzOlu17CD9nEgO61GNUUp04Kd
NVFeXTGx3Sy/avISJf++N1mN5LEKzFpbHU1Bc7SeyI61ujuCE4S4FYJ3q2IvJzYL
66cvgaJFJbZ9v3mOq0jimwYTy7cDgJrgFSNEuxzGSx/HaRYBoBTU0DAaBwvmMQxu
2RDK4ulIYA9uuxRATGGtuowlh81SI/qoWhxssATbO6vUaBJuHxp/D0NoN9jwSpex
MpZUVppYkHQXh/Q9vpxSZtm9Hy19zICQ1Sg7pU0pv/88bv9/iEM=
=Qls+
-----END PGP SIGNATURE-----

--Apple-Mail=_C2E7E05C-2B20-4EA4-8AA7-025ABEE10788--
