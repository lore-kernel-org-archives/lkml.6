Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024ABC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D0F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwuJrjTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D0F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbeG0COe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 22:14:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44125 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbeG0COe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 22:14:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so1131094pff.11;
        Thu, 26 Jul 2018 17:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r+qX+r/J3JrCXa26zepx8oYZzNTJmSzWhcahIDNPnk0=;
        b=dwuJrjTtecdMN7FVjZfJQlrBRgxaZxwYUjrw7lU7pNTfz15dgda/EbbZSNk5rx/eHz
         6hR9lRYZR1mQFtNyZUUGqI8BFqbOq4j7dusnB6/SXdLAagSD9wRTUKDUHpnywdXtvJzN
         d0bbG4/LOzQcPSa0wWtXSFQHOyAvIV1QTYoZXsLfjZF3dlwZ6PXLu4Ix1wcNBnzKiYA2
         hODa+wrcfsNqPu/94iiQdbyD1TCoaQkHl1IuF5T70OmvGVB4P5cWrqnqb1LPKJS0EF7Y
         s8QaOoWHy706pd7EKHbPptGX3qGECppUMaktducRG6s7q+q0rktWFcol7tRgWFaqh8ht
         YFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r+qX+r/J3JrCXa26zepx8oYZzNTJmSzWhcahIDNPnk0=;
        b=J3oZJUNTuat8n7pDeNWcn3ebrTat8zZyW8lcg4SZD3iWWZYy7ico5i8sWdZO1XrrTp
         lBYywKkj6lhVM9ovIv3ISszarCxd0ndQ0OsOeUOIZydURUjW+mWdyOmjGpJU7KymNz1X
         Wd1koGbdNmp5C+XPo70c1jy0tVuBgiI4Vh1ZtCy13pnTuvy7zSXlVOjaHze/QpqrkFIg
         USPtsYF3JfX4Z+p6i4Uwc2zHEruaAqu2JEZ/1DYkACWGNN5nfoQrXlX4FNpU/K26CLFi
         +i+i7pFyqFimoJvisMnHVS8xEv8YbRBm6M9tjuYOjbyIRN9yG2iWgOSF2pL1OKDpLQGn
         aiRg==
X-Gm-Message-State: AOUpUlHXvLxKsOfZpKx8tao9thZUe+ZsSTirVEtQO6hkG/5McgITrLKT
        G+/RMI0+ZFO9KuFVO9/jFcU=
X-Google-Smtp-Source: AAOMgpc9QZTNnJ3JtFm6aeqjuGckKszbvsGufzEsNFNUV0I6h3lGeZgOfqkhnihEYdfkFmEMSfzYvA==
X-Received: by 2002:a65:594b:: with SMTP id g11-v6mr4002739pgu.260.1532652915105;
        Thu, 26 Jul 2018 17:55:15 -0700 (PDT)
Received: from hobbes.alyptik.lan ([2605:e000:1117:c002:2e0:1bff:fe70:ea])
        by smtp.gmail.com with ESMTPSA id u71-v6sm4038267pfk.174.2018.07.26.17.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 17:55:13 -0700 (PDT)
Date:   Thu, 26 Jul 2018 14:55:11 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Richard Weinberger <richard@sigma-star.at>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        miaoxie@huawei.com, yuchao0@huawei.com, sunqiuyang@huawei.com,
        fangwei1@huawei.com, liguifu2@huawei.com, weidu.du@huawei.com,
        chen.chun.yen@huawei.com, brooke.wangzhigang@hisilicon.com,
        dongjinguang@huawei.com, Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [NOMERGE] [RFC PATCH 00/12] erofs: introduce erofs file system
Message-ID: <20180727005511.igabkdzwpb64bniq@hobbes.alyptik.lan>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <CAFLxGvw5PXBLKuaaK5xipiwTOXohtdeenD0XQHgX6+r4rS=GqQ@mail.gmail.com>
 <aae078b7-c364-106a-dd56-91abc945d7bb@huawei.com>
 <1670077.cnVahIradn@blindfold>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="luuepj5gh2e6h5z4"
Content-Disposition: inline
In-Reply-To: <1670077.cnVahIradn@blindfold>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--luuepj5gh2e6h5z4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 11:28:07AM +0200, Richard Weinberger wrote:
> > We also think of other candidate full names, such as
> > Enhanced / Extented Read-only File System, all the names short for "ero=
fs" are okay.
>=20
> TBH, I read "erofs" as "error fs". ;-)

I thought the exact same thing; opened the thread and was a bit confused
at first. In my opinion the name feels slightly misleading.

--=20
Cheers,
Joey Pabalinas

--luuepj5gh2e6h5z4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAltabW4ACgkQruvLfWhy
VBkcPxAAjHR5A3LXGQzDNgTIdBETDgkqfM5UtXYKlUV/hqnzb9OrRTcpmjckd3oD
IeB0BicApQ6el5CCNj0x8DAVMOzLDwW5cYc0d2MWHcaZwr0g5KBWAUZ7G2lyVM2q
cgh5P63b8WFzkC1AY6oVQvuGagiHgj85I9X61112XSqGNh4Hm0toNry4qqEGGJ/U
IJ7KjQrkWAGkSGRqfV+10Vf5x6YobxrP1mdhlfTdyXO73wyAdn4KMNj03Fblby8T
vaf8vng7mQv92wZZuVNiqMJUucSrfQHLEIARNMxF/OZ3KekkF53yvSzEQg1K7KEo
iHQlledBelXKp0GGENdvCu2yw3xfJ/mxKuRsf+lZeRn0/WTaCx3I8nGodnWECtgY
n2LmHFkMgDX7Uyaw3I9nhTskZgTBPyy4i2veq5wrNATPwPRRhsz05MnEpjbM6kWo
0ILXjOEZ2FiwWy3a6t+NfErPxJ2HbaJndmWl1tuNzG/JeVXsz/z3SIq96II9dHZC
rVfSbVobgx2So/6rSP1MdGvuHSRRrIIa+C/TGlyEHN5STxtp9G0AcUOKZItUhuaS
iBe8vgmOL7kgK8QgUccdRXaxb1oQFeVC2fqLjq3V43c40pZVX+/XAKEX9wEoRSrp
Bhcsm+ZLKPOGWwk2QA0+H9O22Os4BwrCQhwPXbqSa8KthGeu3bc=
=YCXi
-----END PGP SIGNATURE-----

--luuepj5gh2e6h5z4--
