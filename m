Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D608BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6012145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="YUaddg60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6012145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJSWj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:39:28 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36009 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeJSWj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:39:28 -0400
Received: by mail-it1-f193.google.com with SMTP id c85-v6so4706697itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Sq3xcTJ8myRCehDLeNkS5suGO7bJSCGevfOgzKCtjqs=;
        b=YUaddg60V2IWBr0i7x5vp9YTkVO5dRIYPOTRGIJHA7nCRVv08CBDbnRLHlMmPTjFeA
         t3cnC9g0ORG0HKHBTUgN5YMtw1MIYPLwEu/peRCOYigFYE6NuNw+zFlUdb6sOtCUsbty
         DKc78E3rhr3IteN7gcr2jQOxJo0OfW3saR0V3zLwFrYvXu0Zy3RSdMIJdyZeRL6pj+Se
         Hmou8NZXRmSnFB97S3dcdS26iu8eHlal3nmdrm2bWkUCvFVXrjgf4F8IsgXu2puEdssM
         MfdG+8cA8eV/qQmg/OOn20reufFiEOxXXqjiUlFyn8xBXMnq+Jb9KX7U+VAl/1RVq/5U
         3X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Sq3xcTJ8myRCehDLeNkS5suGO7bJSCGevfOgzKCtjqs=;
        b=jBiSUZ8KInPBaiP1Wkeps3yLwM/J9tL2CSrFQKmkGS+Hzcvci2rz4/36/2NQLqwtVz
         pFrbQoejmy36nmVOU0yzAMY67p9izFK/jHqR1G9qBUPD4XQQhedHOh5XTbuM6LI80U+u
         yOhZ/4Uyg9+deVVja95VD3jypgE0I4ofvh5Nh8dbbihlaJ2spUJk2BsPEGmuCnvLDlJl
         1sZrC6xOSj2WmwU0+UpOP+AEXV1Yrvm6ahe7UkFfZgUQexc7NktrTG5mvjjcvsoHWhmo
         M82nP254/UWR+znadLphRDfjzdQzTx7xPqRmIaCpvDVuhTm9A7WnzKnSDUT9cNTnwF9/
         Hstw==
X-Gm-Message-State: ABuFfojmghj8rdOjYQUjNfZvhrmT0ipG4434i6mMRdR9iqGPHyk8gN/o
        uyp++08xN6Q6gWP29ROLsxZ2V6NucnE=
X-Google-Smtp-Source: ACcGV6013C/dLzQc4hjjnlg7eUXdoJO0H66Mok+4fxr9jkiRP3NGZRG2YK0KWoMQjpYUPndTEfK1tQ==
X-Received: by 2002:a24:d388:: with SMTP id n130-v6mr3212357itg.28.1539959584328;
        Fri, 19 Oct 2018 07:33:04 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id h123-v6sm1354977ith.21.2018.10.19.07.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:33:02 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9D62CF17-A2F8-43A2-A054-AF281FD96C13@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_88902FA3-F33A-4B04-8242-4DAE6FB12E7B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 1/5] orangefs: fix request_mask misuse
Date:   Fri, 19 Oct 2018 08:27:05 -0600
In-Reply-To: <20181019122049.27121-1-mszeredi@redhat.com>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mike Marshall <hubcap@omnibond.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
References: <20181019122049.27121-1-mszeredi@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_88902FA3-F33A-4B04-8242-4DAE6FB12E7B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 19, 2018, at 6:20 AM, Miklos Szeredi <mszeredi@redhat.com> wrote:
>=20
> Orangefs only handles STATX_BASIC_STATS in its getattr implementation, =
so
> mask off all other flags.  Not doing so results in statx(2) forcing a
> refresh of cached attributes on any other requested flag (i.e. =
STATX_BTIME
> currently) due to the following test in orangefs_inode_getattr():
>=20
> (request_mask & orangefs_inode->getattr_mask) =3D=3D request_mask
>=20
> Also clean up gratuitous uses of STATX_ALL.
>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: Martin Brandenburg <martin@omnibond.com>
> Cc: Mike Marshall <hubcap@omnibond.com>
> ---
> fs/orangefs/inode.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 31932879b716..bd7f15a831dc 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -256,7 +256,8 @@ int orangefs_getattr(const struct path *path, =
struct kstat *stat,
> 		     "orangefs_getattr: called on %pd\n",
> 		     path->dentry);
>=20
> -	ret =3D orangefs_inode_getattr(inode, 0, 0, request_mask);
> +	ret =3D orangefs_inode_getattr(inode, 0, 0,
> +				     request_mask & STATX_BASIC_STATS);

Does it make sense to mask this off at the caller, rather than within
orangefs_inode_getattr()?  Otherwise, orangefs_inode_getattr() will
never see additional stats passed in, even if it is enhanced to return
other values.

Cheers, Andreas






--Apple-Mail=_88902FA3-F33A-4B04-8242-4DAE6FB12E7B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvJ6boACgkQcqXauRfM
H+BRUA/+KhZhIkycQtUFCDFyXS4zsczmZn2BdFLg687vdfLzgFrQSMAbsJVLYgbe
8pRDYrgDn305iymYbOx323GuEtAqjRUaKOV7viS8ugFFGwgIuB5xTDttcWfW60Ib
VVNhXo+jDvcOjDplUaEI3yEMCohcgTIQiJ0HD7WS8JtbjYc5FWPrJ05Au86I+rtW
pq8Z0rEzF7rzowimnlLPzu6dvMuMisYo3sNI6Ypp1qRwX6m5imzmr6J5dEziVigi
LNrSDiEwR37eXKbQEaMJj0185o6j9Pdh2D3d5I1ha6HG2RGNUy666xXklvBn8uAn
xEKvt54jj4uWgUG+7ASC+C1GrVTUIeHryGYP3PvhRXXwOOC+VxHqVcmZVZbaSVYz
7nlR7VnCqa/pqMeAboB1YpG5CasiqcSj7Id7DFhXOLKuAT9SeaeyWl1hEcr/C+pM
sHJWlB/ByY2E0cTOf9tSITmWkYptq7XKiJ7NygZgalqtxaG4nM7NQX7Pbv8HD8Sr
bro5pm2cPrOARAXP5mrSL/sPg+HPzo0ONH2i0YL/holVk0tiUSlkMQnGcEFFNX+R
uBvybTYKauR75pmn5tvB/LZ30v3RSCAgjfMuFIyopjv5xn0kkQ/X6fhvHmXRqgIl
nPaSS/Urqzin6DUB7G3fdgLOuiy6kcbvm4WQ669YU4gc4Va8chw=
=p4EX
-----END PGP SIGNATURE-----

--Apple-Mail=_88902FA3-F33A-4B04-8242-4DAE6FB12E7B--
