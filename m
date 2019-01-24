Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1615C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9395218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1LF03aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfAXSrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:47:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44606 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAXSrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:47:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id g16so2177053otg.11;
        Thu, 24 Jan 2019 10:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xGC3VmGxH7snSAd/IGXFwlujQYwIyoEfWMW4RKG4pWI=;
        b=T1LF03aRDLYje708eIURsSKPPLXgdNEqB+jQlJqqa23aex+MQ+sgPJZAn0qkaGSCcp
         mZ1IeBUFSAHwRD8EuNm/iAjR8vDmaZO91kCtaOzq1u7M/z8YJVPzMxMwpRgGhIfPRgWG
         /462y0BEs+9W2JblswLVfE+fp0VHvVi5HfYyj4xhZObZLPxgS8Ojm9s3UrhnMVoDtly7
         ENDbLsTJXCd3ryrNk3HA036qwmEMIFhP6B7c5weqVuuxDBRUPral9k3ia/vJkwAxoT5b
         WfZZGqwE0dkPviHG3naoSrNzvZBMnXuSHpLskh932F21Y0Z4UL0x85BTKduRA4wR1Xk5
         tm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xGC3VmGxH7snSAd/IGXFwlujQYwIyoEfWMW4RKG4pWI=;
        b=oplncEVaR02uWxOw3AkkGsavEzKKtNdWuQzolrTNPw+0D3W31U+KXBkNZ1VEq0HQzo
         ZrSTXYJtL6Y2N93yHzrJbLeKoJ6frc0rDrrHex6+hzhswr03hqvRClPY9son1un+ncOH
         wSuZ0dNfQHDAb2IjMCsdbok7NqItZxrBk75ImQZ8nm1fKAiBCLzfEiCCAwDn+5Dhu57q
         psSZjvo2iTjtE4gpkU3sjfl0z3qrA66jOn/HtSVzixUVNZW8HKe9zPY2yVxFAf3TjaWg
         HRsEAL2zRfGXTci9JDTIG3W113sH5JpEbXUYZ7UbEyMHZ1W9eiUJzwGpe+UnV4nNlICZ
         Lbwg==
X-Gm-Message-State: AJcUukdtBDH1HHM247m4v9tNR1qW3gCj53MJVKcv9qjfFEBtYN4/tlLf
        XqIhABQ3zx3bXJFcNtYRk53pFkFE1W6Nfzg309k=
X-Google-Smtp-Source: ALg8bN7sYOtj2hWEQUoRKU2gcZcYEcdBXJTB8fT/092OcJQZ+g1lOrCyeEGpEfPQm9MVhDOGZMIe0+uZP5lze8qcBdQ=
X-Received: by 2002:a05:6830:2115:: with SMTP id i21mr5450416otc.237.1548355634599;
 Thu, 24 Jan 2019 10:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20190123175142.12604-1-matwey@sai.msu.ru>
In-Reply-To: <20190123175142.12604-1-matwey@sai.msu.ru>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Thu, 24 Jan 2019 21:47:02 +0300
Message-ID: <CAJs94EaFU+9stV5CW138eLvxnERR9VRaoLDci86gDMRW63LNfA@mail.gmail.com>
Subject: Re: [PATCH] usb: musb: Fix potential NULL dereference
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, why do we need to store the qh in urb->hcpriv?
qh can always be accessible through urb->ep->hcpriv
Wouldn't it be better to drop entire urb->hcpriv usage?

=D1=81=D1=80, 23 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 20:52, Matwey V. K=
ornilov <matwey@sai.msu.ru>:
>
> We assign "urb->hcpriv =3D qh;" a few lines down. The valid qh for the ur=
b is
> hep->hcpriv in this code path.
>
> Fixes: 714bc5ef3eda ("musb: potential use after free")
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  drivers/usb/musb/musb_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index c6118a962d37..6f267716768e 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -2336,7 +2336,7 @@ static int musb_urb_enqueue(
>                  * odd, rare, error prone, but legal.
>                  */
>                 kfree(qh);
> -               qh =3D NULL;
> +               qh =3D hep->hcpriv;
>                 ret =3D 0;
>         } else
>                 ret =3D musb_schedule(musb, qh,
> --
> 2.16.4
>


--=20
With best regards,
Matwey V. Kornilov
