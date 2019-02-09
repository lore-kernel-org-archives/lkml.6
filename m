Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F6EC282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 04:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C177420857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 04:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k17/YU5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBIEog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:44:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41463 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBIEog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 23:44:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id k15so2645306pls.8;
        Fri, 08 Feb 2019 20:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=AALxpDedMUs9nfdvKWXFLMC4KQnRWD0CcD0vl2Y1cGU=;
        b=k17/YU5pIbyxADDGA/Xue9WwrqcdL89bbYZ5RRX4NOaMaLAmmngiEgk8nhcLL+xaja
         uARDGVzcCl6o4gS0rK/P7Zuk1cHyA6s8YA4Mb7x4Lx8T5UZSjsFrZFIZw+lFKyCIxe5g
         9BUuY8Hkk94YqQqzJ6tDAp8s9QgTmBuLkQD3QuxvdUe/2uEsDgXfdciN9ntxrJ/dTPgq
         JVQ1rqqfmZGMvS0E4M2tIMyEnhVTLMKEunvr+cGIU22LqSCuaQGMbFX/j5d2cKycGAJ0
         cPEaCnKg51/vDrbW//MOKAQCf0ftm1ReC1+sLE4ZxkfRK57exbbk4k1eaIq6wXdus3qJ
         Fz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=AALxpDedMUs9nfdvKWXFLMC4KQnRWD0CcD0vl2Y1cGU=;
        b=ixvrOKVQvvqTfn76PQ9aNOkYQmn2F33zkKVvlXlDkR856n0vnUmO5/zeTNrkaNDdlP
         EQxdZJA7+6Cgt8e48CCqDIjrpeTszv8BambIUDP+7dauI0yBtVC3PRlsk3nMeW6YWP7v
         MV3yVDKFiOZmFxD9SmsOcfjZTe2IBVBw2mObiAIAXLDNAIuHdmOuJW1bq9W4JDgpJvuy
         kqqwkF5hin+qMasgsWQUzPh2DMY7sIMg9bU/cxHuifSMM+XbOvpp4cHHODCh45kT+dg7
         gAnqOgNVm198BgVf6oqbWVwuhWFCyqJfhehXyxWEatjdqvA1BUlii5ZjK6Bze66ZqX+q
         NPsQ==
X-Gm-Message-State: AHQUAubHYjqeAKQrImnRG/UUfbgBZET+RfciX1q+14QN0QIBIAi28BlA
        eTiDrWo3WFUlobXSjB3DjZ0=
X-Google-Smtp-Source: AHgI3IZ65ptAw9F7ZGguALXhM+NGADMZOsrpmieK/FbjMiULvb4Zw1qqheVftIojamSx0KxU0qawAw==
X-Received: by 2002:a17:902:5066:: with SMTP id f35mr26784701plh.78.1549687475387;
        Fri, 08 Feb 2019 20:44:35 -0800 (PST)
Received: from mdr-mbp.hsd1.ca.comcast.net (c-73-189-12-233.hsd1.ca.comcast.net. [73.189.12.233])
        by smtp.gmail.com with ESMTPSA id s79sm5010057pgs.50.2019.02.08.20.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 20:44:34 -0800 (PST)
From:   Mark D Rustad <mrustad@gmail.com>
Message-Id: <870EE9C6-3748-498C-B6E8-33724168C605@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1E0B6E1E-DF4E-46D7-A520-668CC48C1F3F";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Linux 4.4.174
Date:   Fri, 8 Feb 2019 20:44:32 -0800
In-Reply-To: <20190208105431.GB32328@kroah.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20190208105422.GA32328@kroah.com>
 <20190208105431.GB32328@kroah.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_1E0B6E1E-DF4E-46D7-A520-668CC48C1F3F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed

On Feb 8, 2019, at 2:54 AM, Greg KH <gregkh@linuxfoundation.org> wrote:

> diff --git a/Documentation/networking/ip-sysctl.txt  
> b/Documentation/networking/ip-sysctl.txt
> index 2ea4c45cf1c8..7c229f59016f 100644
> --- a/Documentation/networking/ip-sysctl.txt
> +++ b/Documentation/networking/ip-sysctl.txt
> @@ -112,14 +112,11 @@ min_adv_mss - INTEGER
>
>  IP Fragmentation:
>
> -ipfrag_high_thresh - INTEGER
> -	Maximum memory used to reassemble IP fragments. When
> -	ipfrag_high_thresh bytes of memory is allocated for this purpose,
> -	the fragment handler will toss packets until ipfrag_low_thresh
> -	is reached. This also serves as a maximum limit to namespaces
> -	different from the initial one.
> -
> -ipfrag_low_thresh - INTEGER
> +ipfrag_high_thresh - LONG INTEGER
> +	Maximum memory used to reassemble IP fragments.
> +
> +ipfrag_low_thresh - LONG INTEGER
> +	(Obsolete since linux-4.17)

It seems very strange to say that it is obsolete since 4.17 in a 4.4 kernel.

>  	Maximum memory used to reassemble IP fragments before the kernel
>  	begins to remove incomplete fragment queues to free up resources.
>  	The kernel still accepts new fragments for defragmentation.

--
Mark Rustad, MRustad@gmail.com

--Apple-Mail=_1E0B6E1E-DF4E-46D7-A520-668CC48C1F3F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAlxeWrAACgkQPA7/547j
7m50dRAAwvqysInLLQHKmYLLKyWaAByv2pgjwL54NmV0EM8b9qs21ZxyrX0NbLuf
W4417uIusBn6VxA0fMQff/giJI1Pv67Fn+mLIVrTLhyCBzZrc5hUeOnQtvaG61X1
THwNM6VPpdW2+df9BFXEYQtGihZkKHiLrahIbkaeyGQSvMmQocu2sGBbOOhgwyzq
KpwKr7jOvgpPWPzLZGgWVgNwJn1g39Qtu3EgjDMIG+wspV/2F8U9Wj/jTWMH1+rv
rTx0SmZc+6WXkTIxKmMnyeD1DHc5DYA1kVX2YPI/gQBHMBs2zfedS+OFlf7lBUhA
f4zHNdaogIM6VlcXc0dQVBPwtp5MNrq/hs7EPMFi781NeO3tBOYffVqKrVMEUxtZ
kC1U1o/e1XurTFDLjbJrQ79sgM6GKwOLbjIR84tACkuKkyLIG4LNnJ2xvyzQ3bB+
HeP2RdIjC5jRo5wyoDY2rvof/K8Cg0xIyb3hKIV9yrdaf7nJFbVInIF9UDWhZIw5
7jbGtq8mS92PYu9pf+WoXfweDBXa9CYBOdtgjY2xSA04O/HtYLkkN+8+nuaAkoBk
MvDZFXSrdjTz5ZgBnTRJ23HYyn59Vhp8We52Zq1A3XcvK5cGe27eY+LgTMnO/PVa
6oPy7rISVz0JrSkjJdblGLPXDH1eqkVBVA+dKFb9Tz7Tv5ixgUo=
=wyM4
-----END PGP SIGNATURE-----

--Apple-Mail=_1E0B6E1E-DF4E-46D7-A520-668CC48C1F3F--
