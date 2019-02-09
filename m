Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCDAC282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29ABB21919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlLq8Ixg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfBIPkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 10:40:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34916 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfBIPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 10:40:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so8675608wmt.0;
        Sat, 09 Feb 2019 07:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QiiHczim2JPtOsVn9eeNnwa3j9BEi1GOBpK9dZSUDLQ=;
        b=NlLq8IxgOYpbdQwAlaZY4a2ywFdc7lrk8DxPpbEZkqs6cceOp2m6OQJtgUUrqZ/T7m
         pDfQ06IUDdQzot/CxmJJxJ9ZQYDhj+wDnLTVTqYqAj5SnoB1c9lVCkGjaH4GKiNpoNIa
         WmxQMO7ng4JOQDPgAAqzw3BMLzrsO2uVZxYf5Tvp3HAP5QE5/FP+21qnk6Luv6RvgPLY
         au/xVSdeHZfuw+puGzDNv1dGEdXymNm4v/7R7s68rXk0kD08ydsyRr871H8/GNW6hOoG
         zj0PW9aewhzaeikuKDOAZbBj4xj0P9He5Q8KTnWnhQSIYN2oJDF2ivxyHkOnqz/AdJWv
         cRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QiiHczim2JPtOsVn9eeNnwa3j9BEi1GOBpK9dZSUDLQ=;
        b=ocodCg4Qkp+4VHlnyqGOycsI+M9npSy/VAGUf5PoaOTLiG2dCyZxMU+3V3KJ61scMm
         jL44kspgv39HB9uCjiDdK+rUaaYB+hkT7Hj1gZV6rOeHrqEFC1i6NL5kqVTHvEpp3wv6
         xF3jgKo8z8kabX1XLHYHt1O/XH9vc7wHrJu4OnPPmEHBJFFTtMicQvbg7nd/J1NUzR8P
         GcUxCkTO4wl/SrzWvT6GrNcSVEb6qGMGePYKl3RBN3VR/ME1IeW085f8vVPJT+NW2+LF
         P7SJ7OdvFarbHP0F0kJe+iN2xueeCCLikRmQQcGgHVpa8uMOQEpHkj2q5zZBPkoofyMv
         69vQ==
X-Gm-Message-State: AHQUAuZ/VirrgZhzquWoZK5YgsHcaR/sQsQYMNiXWt3/q/pgN3aZVMTI
        LDXv2ryK82OkK8DgFFgCCZ0=
X-Google-Smtp-Source: AHgI3IZ/LRJ2AU9GOxJVyVuPthGKLGKYp2nVXebAHBqBjrBRg03BIV8oMcltUsiRn9EB0OcEOMhKOw==
X-Received: by 2002:adf:f84f:: with SMTP id d15mr16329500wrq.161.1549726806388;
        Sat, 09 Feb 2019 07:40:06 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a14sm4564284wrr.13.2019.02.09.07.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 07:40:05 -0800 (PST)
Date:   Sat, 9 Feb 2019 16:40:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andreas Bombe <andreas.bombe@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mpluskal@suse.com, base-system@gentoo.org,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20190209154004.fwsfajwg75dadfbd@pali>
References: <20181002081654.jxesr3kj62snzez5@pali>
 <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
 <20181012091941.o22srnhse4kzqjhf@fatal.se>
 <20181114113341.yx2wlzqku5yh3k4h@pali>
 <CAPXf_qN66-Mi+o+9ENGqCDe-_2tHaf9uM3moRcCGNvmxwH3ExQ@mail.gmail.com>
 <20181206083828.4bp3oypkto2ngobu@pali>
 <20181212135736.xtb57r2eatqsgenb@pali>
 <20181217095004.c6c6itvyfp7cf3ta@pali>
 <20181227221748.zsz6bwqqia7ybfwj@pali>
 <CAHp75VfJpy572t8swsEsz0kPKfpOE-v0SZVxM2aakX0hkjX4=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jjbqppa3api34i4g"
Content-Disposition: inline
In-Reply-To: <CAHp75VfJpy572t8swsEsz0kPKfpOE-v0SZVxM2aakX0hkjX4=Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jjbqppa3api34i4g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 January 2019 17:32:55 Andy Shevchenko wrote:
> On Fri, Dec 28, 2018 at 12:18 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > On Monday 17 December 2018 10:50:04 Pali Roh=C3=A1r wrote:
> > > On Wednesday 12 December 2018 14:57:36 Pali Roh=C3=A1r wrote:
>=20
> > > Thanks for review of #94! As next you can take #92 from list.
> >
> > Andreas, can you look at next pull requests?
>=20
> Looking from a side how slow this is being processed I think the best
> option to fork and abandon the old project if author / maintainer by
> some reason wouldn't like to give a push rights.

Just quick update: I got github permission for merging pull requests.
I already merge some small changes. Others needs and waiting for review.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--jjbqppa3api34i4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXF70UgAKCRCL8Mk9A+RD
UldOAJ9S3QXS5zAFOgwUhz3o8m1tHxGvVACeJ5D6DpItKD+jyLWGPFOqxcsDFgc=
=jDX8
-----END PGP SIGNATURE-----

--jjbqppa3api34i4g--
