Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94DDC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D0E2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2TTkWT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D0E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeJBCx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:53:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34261 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBCx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:53:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id z25-v6so3867892wmf.1;
        Mon, 01 Oct 2018 13:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BGpel+k1GsaKytAeQORtTYGyBhLiyraJYtHqM1YTvaA=;
        b=b2TTkWT0dVSw+kw9CzRl2RDs5sKhUUVMS539piqTIZcemXCCsEMH+IySYK39sRF4rr
         kiZ+dsgeMSqdLgS+X7KiRk3F14vN+87NqgnYT2lJckXUG1QzpIEPynMdslh4g6uKv/JE
         YWefzk2KUUhUGsBBlFex4azPnPwTEdV9twlwKwhEbTLHDdEZyev+ROQw8ylO+aZ2Aioz
         RtKu+w5LXe0wD2hjzgB9z6vrKJxR2qfEePmzB18LPgyPhlUUzTunFVvTj2GG/iYH5WR/
         i35Tocgm6tDsiuVUXWjAeanYA7L/yxqa3ASdWowRhMhccTFd+wiV2tyvkOluVZG9URlm
         ev2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BGpel+k1GsaKytAeQORtTYGyBhLiyraJYtHqM1YTvaA=;
        b=CUiy2n+o/7770N6DuPtsXWU7VbnCcEc21CKhkmZsn8MvZ/zTACXYICy7wdSoAxCl8I
         lGyEA2BCnxh8RTFRL7iumKJkNbwAwx5fB2ApJaum1OCyB7C+OgTodEGyo2X10dPYHdG/
         ByBw4iXHNltcD3hu+P0qvuL+a3FMhdnlT3L3k9u/cTVDe7r4NdrnqPho5QbpkGVh5XPj
         v4tQddnLKCZZveDNRH6S593FOtsU7NXN6IEjJsRCRqBXNva9sA8RzGk32Aqk8SeN01us
         Y2z8Q+3zFs9ewLTgIjcPuFKBm7TW3q+apPdovx+OduS1sPdPveFNWvl+DrHCAX252u51
         i//A==
X-Gm-Message-State: ABuFfojiUSsZEgoOhvk8IzsfEK21r5PKdvYvUFQVofF88FV9L2O5TMPF
        Zu0xlUMI2WRcWc3XNPnt5yQ=
X-Google-Smtp-Source: ACcGV60rRk1gEEvLWOw3McbUj5agOYOWnTgSo30QnjPB5QBcVfldXStHqiHTQ7I5j5nAb1pdakp9nQ==
X-Received: by 2002:a1c:b157:: with SMTP id a84-v6mr9488836wmf.18.1538424868686;
        Mon, 01 Oct 2018 13:14:28 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w72-v6sm19936175wrc.52.2018.10.01.13.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 13:14:27 -0700 (PDT)
Date:   Mon, 1 Oct 2018 22:14:26 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181001201426.onlfasqcre6lgb5l@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali>
 <404F3F76-402D-4E29-9957-429CB7D7ECFC@dilger.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5ogtvwa62vz75m5u"
Content-Disposition: inline
In-Reply-To: <404F3F76-402D-4E29-9957-429CB7D7ECFC@dilger.ca>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5ogtvwa62vz75m5u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 01 October 2018 14:00:28 Andreas Dilger wrote:
> If not, then you are the new maintainer.

Hi! I really do not want to have another project.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--5ogtvwa62vz75m5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW7KAIAAKCRCL8Mk9A+RD
UqMlAKCEtpDKfMcVgHBVI4SOy6OKTh1eIwCdExvUHcjU1K9ghwyzrI4EgqWbGPE=
=Yfx4
-----END PGP SIGNATURE-----

--5ogtvwa62vz75m5u--
