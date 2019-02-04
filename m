Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D8C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1A52082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEHHeNI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfBDNmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:42:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40485 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBDNmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:42:42 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so20990128ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 05:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TmOQSXGEBk97U5RJF28ewCmxSmS4ibeUojwFavrfioo=;
        b=cEHHeNI20ix2Q/lRNrQal4jipkEGvSenUuXx4El3wFStI6japF4+ZgimtRVkbCuSre
         vgMfeKFGRbAPSKOM7RLFeLjrP5u72IzHCZmrT7hQvafBt+CmTa8rat5bbzJaQZJHDTIJ
         EelEzOGpXYLNN7BZqa+U9CmCPNJyrJFbIvGFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TmOQSXGEBk97U5RJF28ewCmxSmS4ibeUojwFavrfioo=;
        b=ISFaD3klQSbmJkcywob1YQMwvfqHqyhc3RIH6iYt07N1ktWp85FbZurdsW4Q5iJMdF
         ozqsp0vnfRUyv/K0ZB9rhpG9zaW/AukPjhnn0BnXlFOX31uFUsbwFezY0fkS7Y+ncSAx
         P26/bpP5t7VJ5OZCdL9II7GSP4KeJjxGmdMEv1v92fahC00/XiFtm266o+r+3LFxpH6B
         TT1W6d2OjM9Hdj4pGoCwr27BqfZQhPHlbqAWHQvEp212y1o5NuOXd0xWASi0yZ0Ml4mL
         wyCbv58NfTF6M+z2/JzCnOUqgTiePVpy4+CV50GVE1QwuUzLWZ3RoiljQnH9zqvHL1UF
         1EXQ==
X-Gm-Message-State: AHQUAuY9rU/Li1IWcpc0jSXFfMCkm+4ssgqVtIHDKSVl3Ud8IJKzCwXC
        UjaCoAp1jfxqCdfH9gXcGKoOOuLrdkg5iEkjNaba+Q==
X-Google-Smtp-Source: AHgI3IYpA/IbB3j5wOFFEOK5t9QyWQTGaNTKJ7JYmDgpAQwJoZ2TC2XVCeAOmLd7kXJ/V+Dea3Ue00AF/XUO6f5Mty0=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr13994122ion.173.1549287760907;
 Mon, 04 Feb 2019 05:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20190204132904.9288-1-anders.roxell@linaro.org>
In-Reply-To: <20190204132904.9288-1-anders.roxell@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 4 Feb 2019 14:42:30 +0100
Message-ID: <CAKv+Gu80Pct6z9K2HSHHxNGQR=LM37e82h9Wgi5pyHFsGXZyyA@mail.gmail.com>
Subject: Re: [PATCH] firmware: efi: arm-runtime: fix build error void value
 not ignored
To:     Anders Roxell <anders.roxell@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 at 14:29, Anders Roxell <anders.roxell@linaro.org> wrote=
:
>
> Commit e2a2e56e4082 ("arm64: dump: no need to check return value of debug=
fs_create functions")
> changed the return value from 'int' to 'void'.
>
> ../drivers/firmware/efi/arm-runtime.c: In function =E2=80=98ptdump_init=
=E2=80=99:
> ../drivers/firmware/efi/arm-runtime.c:52:9: error: void value not ignored=
 as it ought to be
>   return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/firmware/efi/arm-runtime.c:53:1: warning: control reaches end =
of non-void function [-Wreturn-type]
>  }
>  ^
>
> Rework so that function 'ptdump_init' doesn't 'return
> ptdump_debug_fs_register(...' since the function can work or not, but
> the code logic should never do something different based on this.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Hi Anders,

Thanks for the fix.

Someone else spotted the same bug, and sent a similar fix, and I asked
Will or Catalin to take it through the arm64 for-next tree since this
is where the offending patch lives.

So for either this patch or for the other one

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>



> ---
>  drivers/firmware/efi/arm-runtime.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/ar=
m-runtime.c
> index 352bd2473162..b9ae798192d6 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -49,7 +49,8 @@ static int __init ptdump_init(void)
>         if (!efi_enabled(EFI_RUNTIME_SERVICES))
>                 return 0;
>
> -       return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables=
");
> +       ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
> +       return 0;
>  }
>  device_initcall(ptdump_init);
>
> --
> 2.20.1
>
