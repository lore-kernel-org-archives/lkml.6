Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C3CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE562146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tsoff5/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE562146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeISDjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:39:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38035 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbeISDjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:39:33 -0400
Received: by mail-io1-f68.google.com with SMTP id y3-v6so2878411ioc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oBMGK7wn0pM2rKeXp9igJZu/qcejhBbhBiG7lzy2ZIk=;
        b=Tsoff5/tcIPDUKF9NwhurYEVAVngBcN/cycMV8tDfjcskJKQ64VntoioCXjywC8Ido
         PF9ivn11dEpfbCHRkurziyAjAKuJaW1NgxBo2dsdeRvqdLjiB+2OHPmXIRxlMpL6nbzS
         vsXUjuiFducXh4pak0loGlZIpZ6jeRyyJGJD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oBMGK7wn0pM2rKeXp9igJZu/qcejhBbhBiG7lzy2ZIk=;
        b=JiZQWxTEa9ovDay48SBLs1vCFFZQhyrJKDLJlKQXuWs8jn1Hcyp0HC9KZcANZx5pfE
         ZeRNdnkSKnMmDFHnIBuBQ7MQxz6bWPL6NBVAfHc0DGbx/C//Deb6Vy1IuqPEskhqwPwv
         f9b6avdVIF+yK76JGUoB7V3lSClnJEE0P+BtEAYRxQ4YOtywSg9478fBW66kudbgHWid
         XnVJS2ac2fSaYEsZNrvY0ic6LiCpirXR0e/8fD1qq/RVmMWXt80yzvlZYo6aVPJt/4FB
         ViMYuX8iXRvId8ATyPIXHCxRs0XCwDmGibJ+4AJUghpC/gltWC1qVfexgjhY/L9uCq6x
         z+EA==
X-Gm-Message-State: APzg51A92JuuPWfFipySTdsiGg1Hc7W7zDh8hXO5hW1Fsgk1wXCEr+kU
        PsyjPYwm/y7bge4IBqEAmUaxhqIVgEelx2jklQc1GwISquU=
X-Google-Smtp-Source: ANB0Vda5XFkPfTQo527B1b1saDcMf5pjCfVlEnt6QHMto/5w0+5uEGhQvoWRunZZo6DJPL8pNl7d5dPKbiDOwvfzniw=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr26526934iof.173.1537308295452;
 Tue, 18 Sep 2018 15:04:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 15:04:54
 -0700 (PDT)
In-Reply-To: <20180916152246.GG4765@decadent.org.uk>
References: <20180916152246.GG4765@decadent.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 18 Sep 2018 15:04:54 -0700
Message-ID: <CAKv+Gu8-u+Nfw0hx_iyMFFhG=-T0M_OuKfg34m1U3RgC13dUqA@mail.gmail.com>
Subject: Re: [PATCH] x86: boot: Fix EFI stub alignment
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 September 2018 at 08:22, Ben Hutchings <ben@decadent.org.uk> wrote:
> We currently align the end of the compressed image to a multiple of
> 16.  However the PE-COFF header included in the EFI stub says that the
> file alignment is 32 bytes, and when adding an EFI signature to the
> file it must first be padded to this alignment.
>
> sbsigntool commands warn about this:
>
>     warning: file-aligned section .text extends beyond end of file
>     warning: checksum areas are greater than image size. Invalid section =
table?
>
> Worse, pesign-at least when creating a detached signature=E2=80=94uses th=
e
> hash of the unpadded file, resulting in an invalid signature if
> padding is required.
>
> Avoid both these problems by increasing alignment to 32 bytes when
> CONFIG_EFI_STUB is enabled.
>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---

Thanks, queued in efi/next.


> --- a/arch/x86/boot/tools/build.c
> +++ b/arch/x86/boot/tools/build.c
> @@ -391,6 +391,13 @@ int main(int argc, char ** argv)
>                 die("Unable to mmap '%s': %m", argv[2]);
>         /* Number of 16-byte paragraphs, including space for a 4-byte CRC=
 */
>         sys_size =3D (sz + 15 + 4) / 16;
> +#ifdef CONFIG_EFI_STUB
> +       /*
> +        * COFF requires minimum 32-byte alignment of sections, and
> +        * adding a signature is problematic without that alignment.
> +        */
> +       sys_size =3D (sys_size + 1) & ~1;
> +#endif
>
>         /* Patch the setup code with the appropriate size parameters */
>         buf[0x1f1] =3D setup_sectors-1;
