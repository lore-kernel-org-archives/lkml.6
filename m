Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68605C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5F3208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9bIH6Kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5F3208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeFQVjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 17:39:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40398 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeFQVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 17:39:54 -0400
Received: by mail-wr0-f195.google.com with SMTP id l41-v6so14770431wre.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=cT+QEify0UkXSsaDvFYBX3jCIe0gWqnD5E4FfeL5jxM=;
        b=O9bIH6Kv55t3ChKNdH2lyO0QgeIamgQ1uFVLAwwweQcNxNwddozme1l2EaCP/rRTuB
         /irOP0+OHYfatesCvlU6ktfBaJC1MQD4ugOgzQzfX0tlDpsF+28kksanJBdrwqe6lmeE
         1PlRI8X+yMjd5l6BO/QxSrxaxieqElcRh0aDDNJIz8XMwh2i00LA0G/IMOwMdZhgEmU8
         /kZYdbYchakQOgM0sK+9P8JfPj/f6obAohWKcQ7nCcmkB1GP/KehAU2x58B2CaQNwQwE
         4SP0i1o0WzUiS8E49miLE3LgHbQk1pdB3mH/se96seBhCKQ1NlfuIVPhs2dQ9KRFeCgH
         E6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=cT+QEify0UkXSsaDvFYBX3jCIe0gWqnD5E4FfeL5jxM=;
        b=txhKSu4V9hcGEtVEcATXTaMV2tUkl8dIN++s6O6XBQCmCr+G0UGl9ULzSI1WyDLxyr
         h/NHAVEuDgu1XLcH4xtkGXQGP8BL8hYI3BVgxdbVJw7BxYpbW9v8HmtRLX6GzAhYLVrG
         hyHHbrgUVEJFoQKRQ96xwS4vN6V8gr4ON6uDELuDaRD0S7TfdYS1ufrS+35ImfMxfc+a
         q4gtdJdPkGUkVOdUuaObgjmFabRITjWqFmzGK4WxKA5JYWO3mjFfSx9GkcE3R6hHKIRl
         HSeyizvFZAyRhXwFFamrUmgjJVfWMzaGRXouBY+/YHmFybBwpw2FouhHjTN4562fQ/dJ
         v0TA==
X-Gm-Message-State: APt69E0BuNrlGZXARlkJVoZyTTZvErVDTA78Q/Ld3I/oDnQMB7yy2ykW
        iB6HJs3+SZlFhvGI3mIrbDs=
X-Google-Smtp-Source: ADUXVKJFiht8CcdtQE0KUhf3ICgFCnBVbw3VzWYKFSEbJwYMsf6MRTCnNAYvyEjpqQDHmPsoS1oF3g==
X-Received: by 2002:adf:dc52:: with SMTP id m18-v6mr8653644wrj.84.1529271592834;
        Sun, 17 Jun 2018 14:39:52 -0700 (PDT)
Received: from sf (trofi-1-pt.tunnel.tserv1.lon2.ipv6.he.net. [2001:470:1f1c:a0f::2])
        by smtp.gmail.com with ESMTPSA id z14-v6sm5410928wma.11.2018.06.17.14.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 14:39:52 -0700 (PDT)
Date:   Sun, 17 Jun 2018 22:39:41 +0100
From:   Sergei Trofimovich <slyich@gmail.com>
To:     libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: x86_64: movdqu rarely stores bad data (movdqu works fine).
 Kernel bug, fried CPU or glibc bug?
Message-ID: <20180617223941.3e1e4973@sf>
In-Reply-To: <20180616222250.618cecaa@sf>
References: <20180616222250.618cecaa@sf>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/0/IHR=MHGvQz/5AQoC5jeZa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0/IHR=MHGvQz/5AQoC5jeZa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Jun 2018 22:22:50 +0100
Sergei Trofimovich <slyich@gmail.com> wrote:

> TL;DR: on master string/test-memmove glibc test fails on my machine
> and I don't know why. Other tests work fine.
> ...
> This fails:
>   loop {
>     movdqu [src++],%xmm0
>     movntdq %xmm0,[dst++]
>   }
>   sfence
> This works:
>   loop {
>     movdqu [src++],%xmm0
>     movdqu %xmm0,[dst++]
>   }
>   sfence
> ...
> If there is no obvious problems with glibc's memove() or my small test
> what can I do to rule-out/pin-down hardware or kernel problem?

Found the cause: bad RAM module.

After I've tweaked test to allocate most of available physical RAM
I've got fully reproducible failure.

I unplugged RAM modules one by one and ran the test. That way I've
nailed down to one bad chip. Removing single bad chip restored
string/test-memmove test on this machine \o/

Sorry for the noise!

--=20

  Sergei

--Sig_/0/IHR=MHGvQz/5AQoC5jeZa
Content-Type: application/pgp-signature
Content-Description: Цифровая подпись OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSZKa0VG5avZRlY01hxoe52YR/zqgUCWybVHgAKCRBxoe52YR/z
qq6fAJ9NIvK9XdOxNwHE20NPbDnGiUWY/ACfWHSy5bqY6Qpg3IIyibb5PfcaW1Q=
=B3bY
-----END PGP SIGNATURE-----

--Sig_/0/IHR=MHGvQz/5AQoC5jeZa--
