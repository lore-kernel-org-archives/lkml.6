Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665C2206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfBWM0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 07:26:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47068 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfBWM0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 07:26:07 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gxWNZ-0000l6-HJ
        for linux-kernel@vger.kernel.org; Sat, 23 Feb 2019 12:26:05 +0000
Received: by mail-wr1-f71.google.com with SMTP id f5so2355283wrt.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 04:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version;
        bh=psB05eQm18cvQBZKRhaKJ3VSoH8+uGpYg64t1f+eiN8=;
        b=OYeZMAqNYHLKl0Bx6u/4El/rHGIcJ3U/49gWS7BSm8IhZnj5bkFAiWxaNLwPG0uqFB
         +vOmQbXRtPp7lo4OpO01ie7p4mvh8Zen5tBHuI/CjekOmQ/tI+Dtp2jw3hjroRpObeTq
         2iUwadfIHGN6eMoFkl5Izo708TwWWh3XM4fNWbOR25J6hcZOcuZbkpC9/ebxv47pOj+n
         2UP+u6lzaFE3IyebHSbEDpei4Kiye9FeFmQIxL29TBicykOqWIc2o2HwjCZIQ+XuK4i9
         FTQu6tOx6WWnhq7rvPJLUQVo5CeBUht0NVWB2pRTtxsbTMM3kEQtl2iPFZlBjXY/PiCW
         gtXw==
X-Gm-Message-State: AHQUAuaVtnb9THpbq1EHHwkFHgb8inuKwgzYNeQxgOig2pUi+ekw8qQN
        aLb7vCI/fr9SFk6DFjk49eicAy63jo+3qzTBpB1FPJ5fZMFf4VB8cNj+ZdF4T0VbCjzIj7sexid
        LBIyskS2+5F/kItZWfHJxNnB/hD090pumHHPNr76xrg==
X-Received: by 2002:a1c:48f:: with SMTP id 137mr5143602wme.21.1550924765104;
        Sat, 23 Feb 2019 04:26:05 -0800 (PST)
X-Google-Smtp-Source: AHgI3IaQhcCeiHpk+zbHHomqdaBQv5zDU/Y90IYqAY5MpsaO5SwrX/BGA8TnlPV0Hrq5yWnbPZVz9w==
X-Received: by 2002:a1c:48f:: with SMTP id 137mr5143586wme.21.1550924764849;
        Sat, 23 Feb 2019 04:26:04 -0800 (PST)
Received: from smeagol ([195.158.90.129])
        by smtp.gmail.com with ESMTPSA id j41sm12377424wre.9.2019.02.23.04.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 04:26:03 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
Date:   Sat, 23 Feb 2019 13:25:51 +0100
To:     shuah <shuah@kernel.org>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/2] selftests/ftrace: Replace \e with \033
Message-ID: <20190223132551.5afc02bb@smeagol>
In-Reply-To: <aedb3a7e-058e-ec62-93c7-0767717b9ea9@kernel.org>
References: <20190222091021.10178-1-juergh@canonical.com>
        <20190222205351.743-1-juergh@canonical.com>
        <20190222205351.743-3-juergh@canonical.com>
        <aedb3a7e-058e-ec62-93c7-0767717b9ea9@kernel.org>
Organization: Canonical Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/sR5IvWWqWP4IEeSfd.dqVN+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sR5IvWWqWP4IEeSfd.dqVN+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Feb 2019 15:46:03 -0700
shuah <shuah@kernel.org> wrote:

> On 2/22/19 1:53 PM, Juerg Haefliger wrote:
> > The \e sequence character is not POSIX. Fix that by using \033 instead.
> >=20
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> > ---
> >   tools/testing/selftests/ftrace/ftracetest | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/=
selftests/ftrace/ftracetest
> > index 20c9c0ad8682..136387422b00 100755
> > --- a/tools/testing/selftests/ftrace/ftracetest
> > +++ b/tools/testing/selftests/ftrace/ftracetest
> > @@ -161,10 +161,10 @@ color_green=3D
> >   color_blue=3D
> >   # If stdout exists and number of colors is eight or more, use them
> >   if [ -t 1 -a "$ncolors" -ge 8 ]; then
> > -  color_reset=3D"\e[0m"
> > -  color_red=3D"\e[31m"
> > -  color_green=3D"\e[32m"
> > -  color_blue=3D"\e[34m"
> > +  color_reset=3D"\033[0m"
> > +  color_red=3D"\033[31m"
> > +  color_green=3D"\033[32m"
> > +  color_blue=3D"\033[34m"
> >   fi
> >  =20
> >   strip_esc() {
> >  =20
>=20
> Which release is this patch based on?
>=20
> This one failed to apply to linux-kselftest next - I resolved a minor
> merge conflict and applied it. Please review to make sure it looks good.

Looks good. It didn't apply cleanly because you don't have
https://lore.kernel.org/lkml/20190220153706.24686-1-juergh@canonical.com/T/=
#u
Sorry about not copying you on that patch. Want me to resend?

...Juerg


> thanks,
> -- Shuah


--Sig_/sR5IvWWqWP4IEeSfd.dqVN+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAlxxO9AACgkQD9OLCQum
QrcFhRAAjcfgCqTkG5+qxPmKD2RJbcCmi2ml1jPxnHjWbY1yU9mnR6bp+n0PQr7M
GV3RSk+8UcBIEHZf7wXz/Iaj89rkR77Hsf5DlxPghxxrsvXtb0sJblvLbwAvEoeE
m0147o9YJ7oXl9abw3MI9vJEol2bOPuv5CFOMIILKH6XCTqzo5zE9DbyGG/MhPXh
VTuD9KQ4cRsX2puHRvX5jtilLyjzoyLRCk0UpUJ+1UVN2i8CIq9z3p76z1+byQCm
pal2aCVcrIcbLUMQ7XKnLXniuYljCm5yNs256Q17gfLtK9yytMkKdKaor/G4u+vD
zdja8zz/ixTrGkqD+QGq9FYH3SbDfk04wLUGCqFu4TFSZHECrFOy5GAxMLbg5fsX
izDm/6E55n7ij1XyDf9x66584Q9tecmFWKMKM5abG68TodkKIWONYo2BlZbJcfRE
w0Y6xozmoWPtppKVXBHiMJmi0ARDhkQqSxJZIqZqnZ8YFWN8Txs1lnSIgHeFZCAM
XoqOk0XfxBfjnI/rJWPc+2fKgvKe7BUxjOv8u9OQd+M3LXVpRjKOhTwvEyvatIcy
nNFgyreSCvu9ni346qX56igSY1mXEQlevkn3hZIBRIBlZ7C+J9wSlPZY7ObCNA2Q
9MhPT6wQHtLg2b+YfUFfd7jd0dY/bFFTDbIMkLmJP5RTEDREDCM=
=qHuo
-----END PGP SIGNATURE-----

--Sig_/sR5IvWWqWP4IEeSfd.dqVN+--
