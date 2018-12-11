Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FD0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D063C20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8FtuZKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D063C20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbeLKK1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:27:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43210 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKK1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:27:13 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so12051429eds.10;
        Tue, 11 Dec 2018 02:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C39Ebe+u9vRs/oGF0Y8KDtLex/KgNm9kk0ZWGxChBVE=;
        b=f8FtuZKq4GueT8vCVdM3RRjZq2S9ebYsOxyzMck5S/9pdV8RIaEotd8wqXxhS+K2W5
         L37XvvcS72sH6DWygDbI0OJVwYusktQldnr3J6eLSWZkRYpiJ5EBvMF76EuHrdcmlxIY
         PsNcQZEbBGus1PhX7YY/jt8Vl0adqXmhXiMClEZe3rcPMAPdlsgsm3tNyIlT4wJDuMCk
         qbVadcKvLtz3lxQjpjgTZlzzPhtJFfN2Ivxyzlp+X2u88KaUwBnh9TvkFbKEY5Iv+O9h
         7h7cLnVFMECLgDhVyDM30WJKTVKfSWLogHxPq4HN0Nagzs4YT45y3BfyAPSMKJ6v0a/0
         6mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C39Ebe+u9vRs/oGF0Y8KDtLex/KgNm9kk0ZWGxChBVE=;
        b=HLIN/MnDo32Ja5kqYA695RF0qMq+cdzRK0/eNq3aOQJd/WfnlLVF0qx5fo5aiu0Scx
         RR4Hxo/I/sJof/KMBqb9YBMDnS6Qmod9SSMUHEm7UA+tFJ2XTTYKlxE8psHy6Lr9ZFrP
         787oDlD4hBYO+neKnonaeI8Y9qQGtdfScbN3+eIhpu3bx3x/ozTU3kXG7XKjQpRD+EhV
         JTftOBnszHeBERVunUgA3XfXDDykdiZklbHcAUpmHunBEkkMprxN9Wa1M2RieU5xgRxY
         fC0aPN1H3zUEuKcPc/Xd0dgJL0fTpkcoFxWzv/wKuM7OmytguFmW51rzu0LSiohmiz7y
         R8YQ==
X-Gm-Message-State: AA+aEWafYmtUIfHpwcInCHm4+0/xCAfMGDdMrgiKAzu7EUJeaJG++W6J
        hDvZsHxmrd0NCkJOEf/5vC4=
X-Google-Smtp-Source: AFSGD/WDfL7crCaG4aaz86Z/Ed8t6c0dgpwwPbRgGyYNX1Q1MxbmJdD/RVMBM6cSiGm5fSJMp+Z45Q==
X-Received: by 2002:a50:903c:: with SMTP id b57mr14898949eda.161.1544524031969;
        Tue, 11 Dec 2018 02:27:11 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id e53sm4000074ede.90.2018.12.11.02.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 02:27:11 -0800 (PST)
Date:   Tue, 11 Dec 2018 11:27:10 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>,
        Dmitry Osipenko <digetx@gmail.com>, emil.fsw@goode.io,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] host1x: cdma: use completion instead of semaphore
Message-ID: <20181211102710.GH14426@ulmo>
References: <20181210215119.1903413-1-arnd@arndb.de>
 <20181211100832.GE14426@ulmo>
 <CAK8P3a08VEReXUZ39f3iQS3wUZSwKYObnn-jQrUiMJ4Gyx6hVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Content-Disposition: inline
In-Reply-To: <CAK8P3a08VEReXUZ39f3iQS3wUZSwKYObnn-jQrUiMJ4Gyx6hVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 11:11:38AM +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 11:08 AM Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >
> > On Mon, Dec 10, 2018 at 10:51:04PM +0100, Arnd Bergmann wrote:
> > > In this usage, the two are completely equivalent, but the
> > > completion documents better what is going on, and we generally
> > > try to avoid semaphores these days.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  drivers/gpu/host1x/cdma.c | 6 +++---
> > >  drivers/gpu/host1x/cdma.h | 4 ++--
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > My understanding is that potentially many userspace processes could be
> > blocking on this, which I think is the reason for it being a semaphore.
> > Is the completion going to work for those cases as well?
>=20
> Yes, it behaves the exact same way here.

Great, I'll queue this for v4.22.

Thanks,
Thierry

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwPkP4ACgkQ3SOs138+
s6HIbA/+JFwP435Ilng50f4ZLkabfeZnPpo3KewBVB3x9kqif203Z/fvqNPtnW61
bHltheckdQUJitANGYP2sehBL+bfld6jkFrguQVjLkinZ6LIAeNszxaQGS5RQxny
a8L4IE/TGkpWmVhMFvfE2emcaGXBD5XwyU9eSYKnH+wMKAVqzpNIQW+I0vKVPLF6
60dPm/KJBZtDXrorAlv8NuZjcYZA66NQIjUS2aLw4zykjFiNdI8gc3DHzTrBYGHF
OI//UPtbD1Z34jJ+yrMKXC1BMj8TI5jW6Ze6f6Go2t8GJpsELs9L897ti8/8AuDp
AY3NJ2pNoLtJaurxomJJqXILDCj/uHNQ6dcKMtNxQTEbWjYVslAeo9sp9LSkGHLW
fy/Oo6GiTw7dlQQ581Efao1L7zADnMxsOjsPN0QIAoFYTWrgyM5MaaVvqSO4ckxk
cMpe2lLnB8Q0N8XuLVue7fwe9a634mqYgfwRsx3WE/SSkAO8GuHFtJlGquv/MDm7
q+a/Wlf8Si6j0N/S2psz9e5DAIbjTv3VyGxeEbAV/rR7OHOYTvdOwZI5Z+XWXuxs
8aQbo9ct8LhlCDB0SpRAc69p+CbdEzPJYw0m2Tce/qLDxY7+G0mb5nYQthARBHF4
JSY7iOpNm03GOC2/AiBxBJzndN5dTOC58cwDlRSRkfgopB2UCcg=
=f3WX
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
