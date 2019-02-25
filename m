Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C473C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E732087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfBYPDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:03:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54847 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfBYPDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:03:03 -0500
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gyHmX-0005Zm-SL
        for linux-kernel@vger.kernel.org; Mon, 25 Feb 2019 15:03:01 +0000
Received: by mail-ed1-f69.google.com with SMTP id d31so4039944eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 07:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version;
        bh=V0DUHcSHhRwJTzt/wXoAtgHHzNX7WomxEZSMT9ia8vM=;
        b=FIxsw2VDfCNVHpjorTAkrGbU0WdsVWFtkS1q+NYudalC/Oe3czNqZW6MP2eCWhu9h2
         0vutqTWpyOgkRKPncYAY0sdqc87NslGLCoz6ANu3/m9/o8zwShafJqZ8d/O6abhP413Y
         45Zydq+xH7ayZETzzg5eNiSKMXuCOgR72iVp5Z1hWTGQ6hBRokPwkZpQkie7N8VItIFz
         aWWNWPFXulA7C0loe258jXAsHh52+CikATYEnOmw0PBpCV4mj15T5ek665DeKdHRFLlU
         MFjPxWT0SvhBCmper6ZejWSurC4yh8eylm1JSbGVUCtQuyUeljJQyZVBi/HSEza9fb/8
         Xb7A==
X-Gm-Message-State: AHQUAuYCtL76Nz/4dMLaixRo6lBosElwjh1HwyE8QsJQwR+KgSev3IWi
        ZQSj+YEE5QRPy1S17+v0Ao/Fd007xMwgi3SOYaTp8j1zUYXhbNoFO6xj58VpN+OkB7rKTiUqOlP
        NoB7Js4bSHAEmTRmI1BNro83avlA3y/Ofgwy046BmXQ==
X-Received: by 2002:a50:eb4a:: with SMTP id z10mr14939680edp.284.1551106981480;
        Mon, 25 Feb 2019 07:03:01 -0800 (PST)
X-Google-Smtp-Source: AHgI3IbgfTPiSaB2vI6pToDNbyxyO0NzczF5p2Es3+zIo+KSXqQcPCnax6e3n3ERi/Bi31ziM0NI1w==
X-Received: by 2002:a50:eb4a:: with SMTP id z10mr14939657edp.284.1551106981211;
        Mon, 25 Feb 2019 07:03:01 -0800 (PST)
Received: from gollum ([81.221.192.120])
        by smtp.gmail.com with ESMTPSA id l15sm2727130edb.79.2019.02.25.07.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 07:02:59 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
Date:   Mon, 25 Feb 2019 16:02:57 +0100
To:     shuah <shuah@kernel.org>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        rostedt@goodmis.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] selftests/ftrace: Handle the absence of tput
Message-ID: <20190225160257.1a96e26e@gollum>
In-Reply-To: <41adf479-e6e3-8233-4066-983d5e701177@kernel.org>
References: <20190220153706.24686-1-juergh@canonical.com>
        <20190225131450.4775-1-juergh@canonical.com>
        <41adf479-e6e3-8233-4066-983d5e701177@kernel.org>
Organization: Canonical Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/f=hcG7pZ8GoQZ5w=Y+Khf.T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f=hcG7pZ8GoQZ5w=Y+Khf.T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Feb 2019 07:51:13 -0700
shuah <shuah@kernel.org> wrote:

> On 2/25/19 6:14 AM, Juerg Haefliger wrote:
> > In environments where tput is not available, we get the following
> > error
> > $ ./ftracetest: 163: [: Illegal number:
> > because ncolors is an empty string. Fix that by setting it to 0 if the
> > tput command fails.
> >=20
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> > ---
> >   tools/testing/selftests/ftrace/ftracetest | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/=
selftests/ftrace/ftracetest
> > index 75244db70331..fc755e1b50f1 100755
> > --- a/tools/testing/selftests/ftrace/ftracetest
> > +++ b/tools/testing/selftests/ftrace/ftracetest
> > @@ -154,13 +154,13 @@ fi
> >  =20
> >   # Define text colors
> >   # Check available colors on the terminal, if any
> > -ncolors=3D`tput colors 2>/dev/null`
> > +ncolors=3D`tput colors 2>/dev/null || echo 0`
> >   color_reset=3D
> >   color_red=3D
> >   color_green=3D
> >   color_blue=3D
> >   # If stdout exists and number of colors is eight or more, use them
> > -if [ -t 1 -a "$ncolors" -a "$ncolors" -ge 8 ]; then
> > +if [ -t 1 -a "$ncolors" -ge 8 ]; then
> >     color_reset=3D"\e[0m"
> >     color_red=3D"\e[31m"
> >     color_green=3D"\e[32m"
> >  =20
>=20
> Juerg!
>=20
> Thanks for the resend. Applied to linux-kselftest next for 5.1-rc1.
>=20
> Since I applied this patch out of order, I had to resolve minor merge
> conflict. Please review.

Looks good.

Thanks Shuah!
..Juerg


> thanks,
> -- Shuah


--Sig_/f=hcG7pZ8GoQZ5w=Y+Khf.T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAlx0A6EACgkQD9OLCQum
Qreajw//fy1e1ZODGJkScpVUiaTRF5oXCU6W6tjoRYLNIhtXtjAwC7Ci7rfhrJ/b
v4KiW07DJ+VBeWZ3n+sXgPRLNiC+76WwI8QJAiGxoTX7YLKnfvonWQiTjHx2ePwj
BvhpcGYAte6/QSe+d7ZGUXZG91lJ2NA8Wvn7TcOE9G3KHwcJ7w/KGQORNcy12rVR
ZdoCMKxTIpS8QCKFhmbl4Woq8WosuNfwAdF2aeU/jGajeuOglE6Yg5EaV/iAMZRT
s0BEkaRDrn8W9m329qhmF9YHxNPKvlaxQx+nKaQcXfrpJTDAQN9A8XkshSNzJpds
URsUXUcfLTRNrESQhlc7fz+PXKUtLlX8cEZUn9WWAB8d0MZRuVdrtnzeRV5ZF/Rs
uKltvKNzbSvXEZxCiU6W3KhxCyfe+lXWmFmkhxb/rXf1b0Z3m5sMnzxIAOtIKSYk
s+jdVpObZK2CDUXzBGTwayW8Sw8GqA/96HJfEb4BVsxXNK2FWD5u4CoHlORiUDMg
Q17USyCDsNLKHRABHXH9B43WmtZx48LmTPy+lInTPolkzqRK0kBv+CCuVedWR6D+
Ri02isOFSBV2LgFqerC2K5QLXx5r0JVKWxwPRZOUmnDKOglC2n15cb9ExtrJyjcx
IfHA0/t9++0HUH+0TiXXHDH7R09Yzf+kwhQa851eibuOGlFHw4U=
=7ZeT
-----END PGP SIGNATURE-----

--Sig_/f=hcG7pZ8GoQZ5w=Y+Khf.T--
