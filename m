Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E61BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A7A2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfBTUU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:20:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35857 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBTUU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:20:27 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gwYLw-0001My-Jt
        for linux-kernel@vger.kernel.org; Wed, 20 Feb 2019 20:20:24 +0000
Received: by mail-wr1-f69.google.com with SMTP id v8so10892192wrt.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 12:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version;
        bh=l5qv4p38mlg0Pt1NxYLmxEmIvzrMPdeXm4Z7ZTwG0xg=;
        b=nbBvBV/7MCBzy3SgSn5rwLY2ZKwogVCBmm29FegkjOVWMCTULyzommweuXN+0Vtr83
         f57x+cm61Yht1P5HToWLgZ8rkggFzA1cSqsWcm3IaZdyjBsZ3NrxTVKPCIi9mr4MFV7J
         1Ru13rJFowLKdSlnwGXOmN/AQbAqWvG2Mmn9Vbd15nqBi/SyPSlAXcXULtYaWkKfNKe2
         lnbciRANl7u/ewTZVfDczlNy7EZBM6OfA4HmMDDJ+1LX4xp95M8To7w0Y9uC1Jv/9gJ7
         UaAX+9wO79JzhbvzmKE4WpqsScqwffNj/KM0H7UjfvA47/XHk3ojj9TzLQGNP1y+Zy9b
         kERQ==
X-Gm-Message-State: AHQUAuYn3bu+Y8gZVfGYH2qrCRtPFdMowfRsRUT8iUYlbwDMV+lugjxe
        ddU1am0z/bC5KezoPcKaWKLDPpoTIEbmlrspPJJvtkmetaW3XdJ+HLzr8w5XwbOBJTC33ieHNSj
        CkuiSEKejvzMd9DL6RlCyNP3P8hoaP08YS1FwaN6c0g==
X-Received: by 2002:a1c:6505:: with SMTP id z5mr8291874wmb.7.1550694024218;
        Wed, 20 Feb 2019 12:20:24 -0800 (PST)
X-Google-Smtp-Source: AHgI3Ia0eb8G4fWdsMLyqr01oJGhqJkvcJRghVC2HD4N51dOtLOyFv4m+nh4mzIsuBuvDfaz53yrSA==
X-Received: by 2002:a1c:6505:: with SMTP id z5mr8291860wmb.7.1550694023932;
        Wed, 20 Feb 2019 12:20:23 -0800 (PST)
Received: from smeagol ([194.204.107.10])
        by smtp.gmail.com with ESMTPSA id u8sm11137923wrp.55.2019.02.20.12.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 12:20:23 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
Date:   Wed, 20 Feb 2019 21:20:20 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH] selftests/ftrace: Make the coloring POSIX compliant
Message-ID: <20190220211922.051fd2fc@smeagol>
In-Reply-To: <20190220144934.22c52092@gandalf.local.home>
References: <20190220161333.28109-1-juergh@canonical.com>
        <20190220144934.22c52092@gandalf.local.home>
Organization: Canonical Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/H/zuKEUJfZm4ZmD4h5YCl3P"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H/zuKEUJfZm4ZmD4h5YCl3P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Feb 2019 14:49:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 20 Feb 2019 17:13:33 +0100
> Juerg Haefliger <juerg.haefliger@canonical.com> wrote:
>=20
> > echo -e and \e are not POSIX. Depending on what /bin/sh is, we can get
> > incorrect output like: =20
>=20
> I'm curious to which shell this is.

Quite frankly I don't know but that's the output we get when we run it in
Jenkins. I'll try to find out.


> > $ -e -n [1] Basic trace file check
> > $ -e 	[PASS]
> >=20
> > Fix that by using \033 instead of \e and printf.
> >=20
> > Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> > ---
> >  tools/testing/selftests/ftrace/ftracetest | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/=
selftests/ftrace/ftracetest
> > index fc755e1b50f1..f200898e3e2c 100755
> > --- a/tools/testing/selftests/ftrace/ftracetest
> > +++ b/tools/testing/selftests/ftrace/ftracetest
> > @@ -161,10 +161,10 @@ color_green=3D
> >  color_blue=3D
> >  # If stdout exists and number of colors is eight or more, use them
> >  if [ -t 1 -a "$ncolors" -ge 8 ]; then
> > -  color_reset=3D"\e[0m"
> > -  color_red=3D"\e[31m"
> > -  color_green=3D"\e[32m"
> > -  color_blue=3D"\e[34m"
> > +  color_reset=3D"\033[0m"
> > +  color_red=3D"\033[31m"
> > +  color_green=3D"\033[32m"
> > +  color_blue=3D"\033[34m"
> >  fi
> > =20
> >  strip_esc() {
> > @@ -173,8 +173,13 @@ strip_esc() {
> >  }
> > =20
> >  prlog() { # messages
> > -  echo -e "$@"
> > -  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
> > +  newline=3D"\n"
> > +  if [ "$1" =3D "-n" ] ; then
> > +    newline=3D
> > +    shift
> > +  fi
> > +  printf "$@$newline"
> > +  [ "$LOG_FILE" ] && printf "$@$newline" | strip_esc >> $LOG_FILE
> >  }
> >  catlog() { #file
> >    cat $1 =20
>=20
> This should probably be split into two patches, as they are two
> different issues.

Will do.

...Juerg

=20
> -- Steve


--Sig_/H/zuKEUJfZm4ZmD4h5YCl3P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAlxttoQACgkQD9OLCQum
Qrd29g//RC9maNvP185owF2eUIdK4SBUMgsnMeSZCUpAuHCy57LacQlYevTz0/Vu
clkqXE7o4Gw8kYQ0vRHkletGpem/66qFdcOmYD35ky1havMJ4m5VCwgahyIHUIpm
o12YonRQHz9lWcYtWWRtaxaBergkr991dk7foa5+hsAWJla00xrCd57JZ1aRzZ1Y
CMR4v3NTnppgl5ihgoqnWZ0V3TOtGEB6bTnPLbb7ArV4Q5R9QIwu8ojY44QmHMlF
bkctzf5GuecHGv1CExQFPe9izVKDgZoGY4xMWEoDlPVJ58zPZI9/iwizMte6JegN
FoEBMiPgTE9yv1e3XtlDHRyQFNK2PeaT+T2jABm1NzOkWLbjaGxWipnNc/swIZ7I
g3tW6HtIq5yFtlIHFrFp1qzihzLyjIjVyjmelOnreLHE1wAqFqeY6uZ0x9qj7zPO
DxZV3/QJfjretWyUdgiFgW/3BXc0Z2ElmKgy5mhrmqdjw0InvpOVWFfSwt7D5IL2
42ige5VD8RpJhJoJ7yjC1akt67v2jazxulV4eTZgrSrOCJWXjo6i81CeTRyO0GPu
ZlVtkPWrNzCgOiYS6xyA9MZHt3rl9cGEAOIvSPK+sTgtk8IzD1wITKEnNQxwbH/e
dP08/VBh52awO2S4plmj2/cQM3j+1gsL261LwKRX8+oY213fxlo=
=BCNl
-----END PGP SIGNATURE-----

--Sig_/H/zuKEUJfZm4ZmD4h5YCl3P--
