Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C967DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767E1208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beVDKCFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767E1208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbeGaUFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:05:09 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41268 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeGaUFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:05:08 -0400
Received: by mail-yb0-f195.google.com with SMTP id s8-v6so6516128ybe.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HcNGn81lVbA2+gznZXJ8pA/U1xZyI+uq5TSOm56MT4k=;
        b=beVDKCFzqxJDXApbkUQLoqst6o4+XOndbDnDmyWL1/dFiUZaekpxA3+/IAZINFDyNI
         Jjt1k+OT/LTxgKNhFktdtGDCT8iCvHOYP8UZKkmCONuZCevpIjLOY1dEIkHqTiCtt6Qc
         QvdvE1mpD68tyur19awcu7HWf7roCqhmHkVzMKV+uEDSftSlZUvpflxqGj+NRjdPaEcg
         sHm7YAqDJp37bEp1jNFlhic2e7izYz8GDa0oVPqrRmNB5eVbmOeuU6JGhvAqXbPN2oUJ
         3PIZpHQtTXxCVJJSAb8BYDsvDfAh9wFJUtz2q44qvMiWzZPAcckIpYpDzyluB4yh2gD9
         GBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HcNGn81lVbA2+gznZXJ8pA/U1xZyI+uq5TSOm56MT4k=;
        b=Wj09MFNQCwNIHkSYk3pHwWJgn3qWUrt9LqkX42y+BNv9ReAAn6dyR7x9KHWj21pAjF
         WmGr9MTrKy1veOd53kbSzh1BD8LjeSZB59C2kwk4DivqYV5Z7YL2yTYHq4crKfpmb1AP
         hn+GWCn4rNAcHIGIRGT6Yvf9S/qqiPr2ZlYbGgGg+FTyAya3+Pbwxf63JGt07KqiFx04
         Wq7gF4GFaGhZXC19lOV3XJUwKs7Mz3oYX4WmAYky3UMzAaZlnwF0yJDZiHmKapcMZTBa
         DfWA/cCFZrKdH45qyJn97tsSyxDZ186L7KJvwRqNZP+H21Bl2ZpEQirWs6xzqFOSoWXv
         K80A==
X-Gm-Message-State: AOUpUlEr5k5AzG742NkN5wZEhQ66/4KApEsXPPnQpcNcLRZtGn71QaKx
        +gSjgtI0yfJ1U5kKecLLeZutLIMoGPrhcIN3v9w+DA==
X-Google-Smtp-Source: AAOMgpdDBRK3IMeMv80FgL5/ym8HtjNfvDsUMP2nuv16bA2vi/0GPp98mklMqVFZxswTu6CXlHroEdSAPzug5ynpVzk=
X-Received: by 2002:a5b:b44:: with SMTP id b4-v6mr12644604ybr.463.1533061415421;
 Tue, 31 Jul 2018 11:23:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:c445:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 11:23:34
 -0700 (PDT)
In-Reply-To: <20180406222350.174104-1-khazhy@google.com>
References: <20180406222350.174104-1-khazhy@google.com>
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Tue, 31 Jul 2018 11:23:34 -0700
Message-ID: <CACGdZY+cHaKSMKqpM3p5SJq9sVyZHViDUoCTmTusr=Dw1iiR0A@mail.gmail.com>
Subject: Re: [PATCH] block/compat_ioctl: fix range check in BLKGETSIZE
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001fdf1a05724fadca"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001fdf1a05724fadca
Content-Type: text/plain; charset="UTF-8"

Ping?

On Fri, Apr 6, 2018 at 3:23 PM, Khazhismel Kumykov <khazhy@google.com> wrote:
> kernel ulong and compat_ulong_t may not be same width. Use type directly
> to eliminate mismatches.
>
> This would result in truncation rather than EFBIG for 32bit mode for
> large disks.
>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>  block/compat_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
> index 6ca015f92766..3a2c77f07da8 100644
> --- a/block/compat_ioctl.c
> +++ b/block/compat_ioctl.c
> @@ -388,7 +388,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>                 return 0;
>         case BLKGETSIZE:
>                 size = i_size_read(bdev->bd_inode);
> -               if ((size >> 9) > ~0UL)
> +               if ((size >> 9) > ~((compat_ulong_t)0UL))
>                         return -EFBIG;
>                 return compat_put_ulong(arg, size >> 9);
>
> --
> 2.17.0.484.g0c8726318c-goog
>

--0000000000001fdf1a05724fadca
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS5wYJKoZIhvcNAQcCoIIS2DCCEtQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBNMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
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
BQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWltZWNhMS5j
cnQwHQYDVR0OBBYEFDBayG/HuozB3nr7XpIwvMdtMOg+MB8GA1UdIwQYMBaAFMs4ErDHmcB4koyz
IZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8v
d3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQBRJEgrMaLvmWUZ+Njl
2Nv1nyyUCOqZ9DVy/vSoHfwEGjfHvU7LKMBXG23U7+MFxsQ+zjvShwVFh+xd1f/WhVYskxUWtFNx
cvVntI7VRiuPMEyzuJAIif7Gz/3nGHYELnuCT/LJiRt+8s5ifvk4ARlTyzXvmTgYI0SWmY3XzG7m
w//hyllv3Oeju53dWy7m08J+wYroHL+95IETljOngoBeyaFJmACcHwdrM+oASBYR5cpauJrFZOuu
6SmC9wsvjI52co5WcO6b7PqO/NjJtIIdXzWZH6P99IHiKI5NU3MAAOtJ7sz9py/SRei4YELyzwFp
KW1mK6xDpJiRbOzZPIC5MYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIMaTEz/DvA
bIQaq/gnMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCTvAmr+pRrcIsBIFFZT75y
SUqoCEyL1acUFaE31/T8gzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xODA3MzExODIzMzZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglg
hkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAm2t1bJAOwA7xQee2Q5GGeKtESeOD+gGi3LuJWB+z
BDbVTKNWAuf5UtngnJnO7n3J7WtXY5owHdOil9Db4+61aHawsfKFyNjCzsXdMnzyletT1OeQ6su/
n0Ttgcf3S3JCVbbnYpBW5a7ayCdsW3hWq/yBo6+zbECI7iM7PjNZlLgrH/EEdVCwPmh/e2Z9Z7xy
BiiV8l7ieotmPluc/vySEyGxJcwqs6SjXpRuURJMfFGbIGIclgA8liGS+zjjkBG1Iu+Gt7vRzqBH
vgVOOKGU8W8LEuFoxFj9yUmyZvVUqxxjZqpXh1nZSCAW6Mr4tIYvLaGnHAPKIlB7g0qPuLyfJQ==
--0000000000001fdf1a05724fadca--
