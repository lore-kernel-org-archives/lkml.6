Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8BCECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FE0208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0OLTe+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FE0208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbeGPKiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:12 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55655 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbeGPKiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:12 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so20015540itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6O2kusFrE9A+IlAyzZ5uMABv8UtYJBeu8bDTZsW6X7I=;
        b=J0OLTe+DYmF23SnqXtexbT7FeWC1WGrrpqnevRrX167k+PWki1G3ltbPAmver41rB7
         nOfM+Qx8D54Cmnux5+nQ9JmBCg55mDRm/pIEPPSZroSpw4FtjthRd19M4A9C78daptbe
         focqkhGurz79XrltKxLEJtFrhswuYwYydWFQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6O2kusFrE9A+IlAyzZ5uMABv8UtYJBeu8bDTZsW6X7I=;
        b=YumonjPvthdP2VhiDtPeyCoZMifoyAiTnhHbzaaRYQDp9WKqulRsH0X1wTCF4ABuUi
         u4EVHo2yxjsmY7RAjiNLs/7FmP+lZwef0abACEW13Lxt64bDwH5fpwfUTkFIZrtE326f
         T0mgEwC6u2tLfDgoH7lsix61yxsGL7D6G86xrfzJ+XXCy7QeiEdD2peUKPYYvdYD9e5+
         /eLOnhEaItbmubYub95V30+2ijYlgdR7CarE023PqGzdAH06eVmhiBo4HbG1/W8Ld6mA
         c61/g8C/Bd6uJ3sofhOXHJ1u7HLqLZkkrNvJjhvmnoT+E8Gx+M+P4SSwQp0uLPgpwOaU
         yBlg==
X-Gm-Message-State: AOUpUlFsQC36vKDMJbI4fN3VtFVhh11jpdkUNMyoWXN8XMbS7RVoaWqM
        oxndxJ/zWc/7Y7VMyZfHZiraV95A2mwUii+NN10WsA==
X-Google-Smtp-Source: AAOMgpdwnIbWm4MCzJq8YN4RMh7SqUTqnelQ7W5jwp1WCf8O2tye2ZaZ6nqMaBN/Ay4eIeM/z5tLJKj88X6JLLYmnTk=
X-Received: by 2002:a24:1c09:: with SMTP id c9-v6mr12700055itc.38.1531735890621;
 Mon, 16 Jul 2018 03:11:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:11:29
 -0700 (PDT)
In-Reply-To: <20180712195937.GA36007@beast>
References: <20180712195937.GA36007@beast>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jul 2018 12:11:29 +0200
Message-ID: <CAPDyKFpi87UaKLScADOT_gkXkXpLR6r2J71G78zVn0hkc3ng5g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxcmmc: Fix missing parentheses and brace
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 July 2018 at 21:59, Kees Cook <keescook@chromium.org> wrote:
> Looks like the adjusted syntax wasn't fully build tested. This fixes
> failures with powerpc builds:
>
> drivers/mmc/host/mxcmmc.c: In function =E2=80=98mxcmci_swap_buffers=E2=80=
=99:
> drivers/mmc/host/mxcmmc.c:296:51: error: expected =E2=80=98)=E2=80=99 bef=
ore =E2=80=98;=E2=80=99 token
>    void *buf =3D kmap_atomic(sg_page(sg) + sg->offset;
>                                                    ^
> drivers/mmc/host/mxcmmc.c:299:1: error: expected =E2=80=98,=E2=80=99 or =
=E2=80=98;=E2=80=99 before =E2=80=98}=E2=80=99 token
>  }
>  ^
>
> Fixes: b189e7589f6d3 ("mmc: mxcmmc: handle highmem pages")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mxcmmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 75f781c11e89..de4e6e5bf304 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -293,9 +293,10 @@ static void mxcmci_swap_buffers(struct mmc_data *dat=
a)
>         int i;
>
>         for_each_sg(data->sg, sg, data->sg_len, i) {
> -               void *buf =3D kmap_atomic(sg_page(sg) + sg->offset;
> +               void *buf =3D kmap_atomic(sg_page(sg) + sg->offset);
>                 buffer_swap32(buf, sg->length);
>                 kunmap_atomic(buf);
> +       }
>  }
>  #else
>  static inline void mxcmci_swap_buffers(struct mmc_data *data) {}
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security
