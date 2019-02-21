Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A1EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EEE2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuNF+Lm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfBUAEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:04:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39528 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfBUAEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:04:51 -0500
Received: by mail-it1-f196.google.com with SMTP id l15so20197187iti.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 16:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9oAliMYmIUlmWhj/q2IpJBDDMtrsKwTnH5h8DksErc=;
        b=nuNF+Lm6ifl0OtOSsZ5RaHw2N5P9Xijn8W6PeP70MDPpno3A/QPVQCJ7GcB5kYFsGn
         JQeU6L21XAgUpdsxbc8Yu1cls/T9n4DgM02mNEJdh2V+N24tPF5MvKn3THCyayiITBXq
         QqP5tZhcHVahQVufyJR3AmdLtU41fQmMbjXVHVc/9ihbcEvjGtDa91AMmfIwFNj77wQP
         0C+wiuXtZvBOO/0FhgT+y4MwD/P2mCd84ocXToL39N+g5QwVsOm4bNshEStO1jp/kI4g
         gGmpCGtAsKUlptdHLI6TSw8ziJNinfvrnvEzz8SPJSB/ePWXCV4JzQ/UnjLX7T1U732D
         hSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9oAliMYmIUlmWhj/q2IpJBDDMtrsKwTnH5h8DksErc=;
        b=XwEqSnecvFf8CZpVDIv/6c2+kC9D8wRE741P8DD2sghrcZmfCCcGHlPXFMLLfQiNro
         Y6LUpGf+cerb8TB8fN0MoBGVSnyJ9ayvB9RblYzjOzINai7urBKLhbTFhMQHFVL+wuBi
         vBG6xfkWEGWi6kZ3Dd6Gqjrz+2qtZ/sKVlHav+jMyo9gU8aZGadFhqHnDDiY4OoiR319
         LmOGdJqB2wUiXY3aNYzrojwlG1ZVsmz0jJLB9IPM8hJBVu67zBNvQEScxsPPjwhp1rKs
         /7oyF4n1R00mkxFwBAwfIjITkPlNx4osRyzFODjMY/ylUJ0x5CqVAFVFfoZGaFvBtfTk
         DFRA==
X-Gm-Message-State: AHQUAuZPdt8ILoLrf7ZxvELRo35FTVCO0gnIEXMO8dLpyslkXnYY7Icv
        L30tMqIntsinR26r4Exb3SuR/PhaxvIKOCVJmEOePg==
X-Google-Smtp-Source: AHgI3IaoAXhrSeoWgzgkhHyfzFjvR4Pf5oZzj5GmiG/4ceubKFM69lDmLCaH68xhumSGP5nomrU88PM4P2C0E3NhqgI=
X-Received: by 2002:a02:5c5d:: with SMTP id q90mr20430863jab.43.1550707490008;
 Wed, 20 Feb 2019 16:04:50 -0800 (PST)
MIME-Version: 1.0
References: <1547706826-16833-1-git-send-email-yamada.masahiro@socionext.com>
 <CAKwvOdkzSTyiiBmpwGFj6K=1Ang6nsVVahaQstk_GkPAcyBZOg@mail.gmail.com>
 <CABC7LbQSxB=WuUz22uunWW=YahNd2-By8LKxLcZYo0L17P---A@mail.gmail.com> <CAK7LNATY8-hJ6QouGjO4wvsw8+W60HhLfNk60RZWyNz4s5fv_w@mail.gmail.com>
In-Reply-To: <CAK7LNATY8-hJ6QouGjO4wvsw8+W60HhLfNk60RZWyNz4s5fv_w@mail.gmail.com>
From:   Jordan Rupprecht <rupprecht@google.com>
Date:   Wed, 20 Feb 2019 16:04:22 -0800
Message-ID: <CABC7LbQ5ooG-K2Fyob1LonJG-=3s_wfYwpxr4A-u3gBKGsOL4Q@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: support llvm-ar
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001f968205825c3949"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001f968205825c3949
Content-Type: text/plain; charset="UTF-8"

Great to hear! If you discover anything later, let me know.

On Tue, Feb 19, 2019 at 10:11 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Jordan,
>
>
> On Thu, Feb 7, 2019 at 9:56 AM Jordan Rupprecht <rupprecht@google.com> wrote:
> >
> > I have a patch up for review that fixes the second case of chopping
> > off the directory when nesting thin archives:
> > https://reviews.llvm.org/D57842. I'll commit it tomorrow if there are
> > no more comments.
>
>
> Sorry for late reply.
>
> Now I tested the latest llvm-ar, and it worked perfectly for kbuild.
> Thanks for your work!
>
>
> --
> Best Regards
> Masahiro Yamada

--0000000000001f968205825c3949
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS7QYJKoZIhvcNAQcCoIIS3jCCEtoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBTMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
QAYIKwYBBQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWlt
ZWNhMS5jcnQwHQYDVR0OBBYEFEzRyLdWAOnD/r5t2oxq71oqZrNuMB8GA1UdIwQYMBaAFMs4ErDH
mcB4koyzIZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0
dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQBJgcZICXH9
7aPN8CWWfdcTGvINItDpd2QzUxJ1QgRSypCd0qXBevDhmEyJiSe2yK3G9ZTjxdY3jweCFpmNoaSG
exz1OSbBBkqR4yVvoaU7vTGg/h7aE0B38UdyLSQpjMaaj/m62h1uZPDFLpzm0W3ZHXvVgcElmR6P
2E3v71/17oqehAv6tOyHq4qpghOkAWbGTS0lArjiRSkP5AtKQHaDqmrUSekn4bO1sx4GcS8C+oWP
tcQ9TZC94SbqpVBmGV0lm58buObjoGy/YDIuffcRzv2edbQRwJ7iFlfGatsbgalYzfRTRNS56BOm
GpqFnR+eKUmZe66ThjUoY1QtIKVjMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIM
Z45BjBNFrislm5V5MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC03tMQ6nd63qP5
QOgNg13JDkjyDoozQ+DxjX8QcukqKDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0xOTAyMjEwMDA0NTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEApw+b9z7qPayB5K6JcoJ9kN5WaO6y0yob
HJkQLi7GYk9r4ysqQG96CMV9rTYNZXPgLNxGTk/mapX0Zl5bjZM4kNOFHYETyD0ueuo3P0VUH+dH
f2oc4vrlMtGa1VAAtXtWmKZm5LNTdxy+hVuBHodlE8oTMhCs3/Lo3EElXAkf2ACBRC+LsHxBAF6B
i1EPwzXwtLcC54QICyRkCj5UnaBWpDldwgAeE8tsbpgtx335afTi2CDA6xhI6IejenACAjgmobS0
lFg/4n0ktCCs+dbjeVJ7XAxUcbaa1/aNBcVU9SLyJntbGewPLDeYjO7RoL84++FA/O/n8plVoBt8
MBsOLw==
--0000000000001f968205825c3949--
