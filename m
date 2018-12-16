Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D37C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBA5217FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReSE2hgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbeLPTGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:06:44 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:34877 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbeLPTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:06:43 -0500
Received: by mail-pl1-f181.google.com with SMTP id p8so5062300plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 11:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=vndxZu36rUR5AP+jQGGWquqDwjytEcLMUb3D+64Y+Mo=;
        b=ReSE2hgRPcmjY876Q5OUMBXg01nm3jkozjMItAizT8Ttw/dIiEC9UwIe85BFAhPI1U
         jAyfAu8pNV5i5WybyhtiIaSf9GRTKD+5a3QekgSkE8yCFnrDqaQ0BZRiPelF0bwOq6tR
         UqgllTyp4sQ/PA5yxkLV/OZ4A8rJKhwrAEggS/hhfrWXpL4l7iyE4/cj8n/0YNVFvTSZ
         zVr1n9FAiP4xrNxoTVIYVwSv0/jWv+5BNRW3/4UNML67wD1wNIqUNtDg37jIcOrTjycZ
         HX7PX44aQF36GyEjB9p471jQ7pEVDOoarPs0GtcoOWmKeHb2M72s4yTXOuRf6G8PWWxp
         APOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=vndxZu36rUR5AP+jQGGWquqDwjytEcLMUb3D+64Y+Mo=;
        b=abmhTqskPDn4xc8YEwscVh3v/RWYYYwzmVJE1LhjpCmaW+/9J99fZlj542iJ4N5UEn
         NpJrl/ZEREDUG8a/3dJc07YDtXM9EiOtvtGgz3DTZrMtrGGDlnl2TsA8ZYOXDlKepBS1
         FLEgmQoERjSWlinueD6eTK3kuPY/hzh+JUDcsNfuYJJOOu2lnt3h/oh2vHCaGq7okuTR
         UVf1opPg3PTWiKV7Mu0muanxZjU3cqwdZJ9G1f4Jgh7PQfk5lj5bXAh3lYZTAc5OgGXZ
         dLoZu4HFAUXowkUOshdzbflk5LIlMtuAf/6Q+rHtHK/A4E7ftX7tXjIjs443b0XvJg4P
         a8dQ==
X-Gm-Message-State: AA+aEWZQNleAb0fOH2sATemqp6LsVGDSjxGRwvZnQiE4B6g4AsXLEijh
        oG24zpmsovmtnVr3EVwenBnrJEj5
X-Google-Smtp-Source: AFSGD/UWaqc8iWDWqCrKPEfXnD3JA/ipDcbTCWxipH4E0rSsT82f8hhwoxJzPVkF3EDWiHxwnGz/wA==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr10373018plb.52.1544987202695;
        Sun, 16 Dec 2018 11:06:42 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id l5sm10537641pgp.82.2018.12.16.11.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 11:06:41 -0800 (PST)
Date:   Sun, 16 Dec 2018 09:06:39 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [RFC] LKML Archive in Maildir Format
Message-ID: <20181216190639.6safwjqwdphkce67@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2xiiwlep474ny6h"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2xiiwlep474ny6h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I spent a lot of time trying to find an LKML archive in Maildir format
that I could use for local searches with nutmuch or something, but all
the links I was able to find were all dead.

I ended up just compiling one myself and I currently host it at:

https://alyptik.org/lkml.tar.xz

It's possible I'm the only weirdo who finds this kind of thing useful, but
I figured I should share it just in case I'm not.

It's about 1.1 million files, I was wondering if anyone had an idea of a
better way to host this? I've tried Github and GitLab, but they don't
appreciate repos with that many files, hah.

Open to suggestions, thanks!

--=20
Cheers,
Joey Pabalinas

--p2xiiwlep474ny6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwWoj4ACgkQ2rGdfm9D
tVIOmw/+Jfs9dD/9Zrm7iX13JuvQjsWNPnLGt0Wq/l8cTpeHET19JkszpMZCwA4C
DWgufUURhJ4e8rTczECRpdDwsMw7AoFHIDiiARQMdOCGSjSzmA+sgoRLhL6qBPTo
oSVMxD3a40liurMZZXjXihhvVD3UDIhZj2W2gwMDskWFYFQPJOFojKE9PxaPVeyb
cqCMAkSX9r4j4cDM2nhrcyMz4rtQ+v5QQL1WjS2teYqSFWgRlFPQqZyXlsLsT0Ub
jhsS1fgWT2XqxwYWEzkYSSB6uL8HqT9rF0huxGUXTaOJX1zslIjBDs6mxqmTwM5M
8Wd/PR6r3XHNjTZ46HKpaoh9uPIqQbo8VYkD0O35KIebSmOr2OQBU6bE1a6+cKYp
VSZF4MhgPVi2PyjVaNEViWSzfXzf+hKxGAqW4xsRpnYgwM4V6LEySpv4EsRTIEuK
/e5i/qvmF0T0KIbFzhI4uZHwZQB5RwhF7J93eQXGNMN0BIngFfeC51hxDNODVn4m
fv/g2l6oNk+L2ghmwN4cGeWOX7My5qLLO5afivwaITPxm2wkV/3G5NclYQjNzzlZ
Jaga5WEqrNhtLW8XzdVWd1fueY5GKTpRgJQe9kOk1hkHxQigyaWGVZU4Xzob8cmG
B96Zucs/lRJ0ZKryv3fvODKE4CMIGaNIMy7VnWltrpQdUDZ2bxc=
=nlG5
-----END PGP SIGNATURE-----

--p2xiiwlep474ny6h--
