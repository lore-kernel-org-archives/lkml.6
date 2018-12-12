Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AC7C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF0D20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxHkmUnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF0D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeLLN5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:57:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40687 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeLLN5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:57:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so6024351wmf.5;
        Wed, 12 Dec 2018 05:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GGYQrYNrsxa0SLJhAqttZsoR7cAQmea0lm/y+oDipNw=;
        b=FxHkmUnSgac0lH8lZUB0dw08IgxuPb0tkkqX/GX5+wFMGQginhXaEygTvsInsRalpL
         WTC5R9g79mRTxyRIQ1vRfEzxI235t3Dywq+Ttmvuy1FO3MsLgnwBuiEzchyNspbKX4AL
         wqURt/zNbJ6PnpRC6KbMIHdHi2/4b4vl+jYVGxi2OyOQx1ayArCLlC1FGq2HbadXvCHj
         W1Go0QJ4d1veKQsBmJbaUNC5BY4w24NfVYkUJL5EPU9N63WGlbWuCT2EGB9HGtNFh6e6
         g612oy8a07T38aMzgsQlQGQ3A5Sqt3aMnQZM6c8rbOG1eKcnOyB8KXMOvL0kb3ix1y+3
         CUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GGYQrYNrsxa0SLJhAqttZsoR7cAQmea0lm/y+oDipNw=;
        b=W0VakkAKb0aaicehDKSbT2fOWoiw3Mg9fNvdiWKK/FC8qjOCVtFBueH6wtrs6nHVYx
         ZaqxqBauCCKRkp//ofGsiTK8e60Jg6Dj3uZjcF0XuFi+DLMviNQ/TGA81IBbb9R4MMA8
         6cUTAp4Jbb2jtDS5RYU8yeJkRxRJyYUQaPJyOPo31yih28g1w1gR8qAz2vmhXUTAFS9B
         kMysy3j7aSSOiWDeY/3Bm1G5c3sJTurJw2gWND9pkGStNDuYSyRqIPqx34CHtlYcA19Z
         e5HVch3RO6uI575McpTLc3xWh0ein9XB6BM7v1EjB7v3KuiM1o70fpJzgdOTSVM50xc9
         cc7Q==
X-Gm-Message-State: AA+aEWbAdyKXL6FOQzKg9vLRHqs7kzDdqhqCHSEw+/2S9tl6Wg5iKtzy
        CK5IRwfbDzCJaga+iSlc8wo=
X-Google-Smtp-Source: AFSGD/XWZYf9J41+bKPzSKBfrSJ+fuc17rC9IXPltsy41UAmf5sD+4EIuoNyq5qFweSI9XX8i4BTUQ==
X-Received: by 2002:a1c:1688:: with SMTP id 130mr6195606wmw.86.1544623058918;
        Wed, 12 Dec 2018 05:57:38 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n127sm3813959wmd.20.2018.12.12.05.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 05:57:37 -0800 (PST)
Date:   Wed, 12 Dec 2018 14:57:36 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Andreas Bombe <andreas.bombe@gmail.com>
Cc:     Andreas Henriksson <andreas@fatal.se>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpluskal@suse.com,
        base-system@gentoo.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181212135736.xtb57r2eatqsgenb@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali>
 <20181002081654.jxesr3kj62snzez5@pali>
 <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
 <20181012091941.o22srnhse4kzqjhf@fatal.se>
 <20181114113341.yx2wlzqku5yh3k4h@pali>
 <CAPXf_qN66-Mi+o+9ENGqCDe-_2tHaf9uM3moRcCGNvmxwH3ExQ@mail.gmail.com>
 <20181206083828.4bp3oypkto2ngobu@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eafed3sq2aty4xrs"
Content-Disposition: inline
In-Reply-To: <20181206083828.4bp3oypkto2ngobu@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eafed3sq2aty4xrs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 06 December 2018 09:38:28 Pali Roh=C3=A1r wrote:
> On Thursday 06 December 2018 01:53:02 Andreas Bombe wrote:
> > Pali Roh=C3=A1r <pali.rohar@gmail.com> schrieb am Mi., 14. Nov. 2018 um
> > 12:33 Uhr:
> >=20
> > > And... has somebody else time to look at those pending patches and do
> > > some initial review? I would really appreciate if somebody look and
> > > comment them.
> > >
> > > There are 14 open pull requests:
> > > https://github.com/dosfstools/dosfstools/pulls
> >=20
> >=20
> > I'll spend time on this again. It would help if you could make a list of
> > higher priority PRs you would like see being looked at first.
>=20
> So.. here is some list:
>=20
> https://github.com/dosfstools/dosfstools/pull/92
> https://github.com/dosfstools/dosfstools/pull/93
> https://github.com/dosfstools/dosfstools/pull/94
> https://github.com/dosfstools/dosfstools/pull/101
> https://github.com/dosfstools/dosfstools/pull/104
> https://github.com/dosfstools/dosfstools/pull/84

Maybe you can start with Year 2038 problem in PR 94:
https://github.com/dosfstools/dosfstools/pull/94

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--eafed3sq2aty4xrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXBETzgAKCRCL8Mk9A+RD
Uq2YAJ9XHKDJnOorsCjLAB4ZvXWTSODHxACcC9nCjO3YLUBaG/rykj/BQ8EgwJY=
=66Zy
-----END PGP SIGNATURE-----

--eafed3sq2aty4xrs--
