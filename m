Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DF1C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5F720853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxGcvhJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5F720853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeINMjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:39:41 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43561 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeINMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:39:41 -0400
Received: by mail-ua1-f66.google.com with SMTP id f4-v6so6596492uao.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 00:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scwqT49AcEnW3+76PRPG5WOxruMIRhxgal+sAhxELSQ=;
        b=DxGcvhJOBjEYCYHCkcer8IJKkTGt+7kYWit5bAoX6kV01dJmG2UIDaJpnabG9FokHK
         C1t1CuIZPjNDnDOHbGO1FNqlvXfG7gLNAiZXDg2f2a9O5R4B3ZseJud670gJDYjyN3hb
         AinsohtZ2czRlt9bAXii7zNzmLJ6TuKxER4fmgxx2tIz2fn/wqSo+OkOlimg9AbhBPFB
         RF9AwpFGZvsXdU5iDDXRwr3QEhEoohjmJDgGAGb1LdsGv5rf0QLIHeCzzupJm+6O3emL
         zLw0zvhKqEQnUiust9qoyPob7+f1eq1oNh6Fs9v5zEW0nhQ9bCVyKLpLz9+StHZ8M5mB
         sueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scwqT49AcEnW3+76PRPG5WOxruMIRhxgal+sAhxELSQ=;
        b=CHV1Jacs7LyK1mbuFx5ClNC4iloz1pHEL9kaOMb88xLNaF2yGRfh0RK34lzTMWo9zW
         c1yIBUrie7Rsay8xaCxSpTuBw/BovggG8ApKhCnc/l/EQpTlFKiwGH9VUkTGhoplKWuu
         +P3cpUejipsENyiqVr0dO+Pk1HjpdhR8mWT66mqsP/XU56nSRAQv4uaY8c4x0KPtq0Pa
         Afl4uQsBLVd8yzl2Rm+4UuyS5EmSeSN2z8Td7ENMDgqeNq50ESQBAqklTliJxajKbGW4
         3l9/9h6SBcbUJxqwl4+b6g4FaJ/47zbRDN6sE+0uNk7sXRVzwWLryG3fSAKkuWV5JAec
         vIiw==
X-Gm-Message-State: APzg51DtX/XxMEIyd1SSSEUE4/DEUYK0mtlCAl/2ZZPPyLKpEuPcShIz
        1qEiTds0aANfTsq5u+TGFJXyN/GtfNaMb3tDamg=
X-Google-Smtp-Source: ANB0VdbajbHXIdbH3+S3HHoU/R9j12XFtuo4faUaexIJPF3aPEy4P+9GH4WDxrAMFGXgkDEdqpl08leQv4Iiz8h7xtQ=
X-Received: by 2002:a9f:25d5:: with SMTP id 79-v6mr3562877uaf.183.1536909990552;
 Fri, 14 Sep 2018 00:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180724132719.GA32237@embeddedor.com> <d9e87a82-f70f-3eca-5f63-2450863e7099@embeddedor.com>
 <f35a04a0-fa60-7905-96bf-36a0dfb055a8@nvidia.com> <CAGXu5jKd5SEabmr4sCW-=Oksi6WvO11tDB_9Un1fRYQAoq2h0w@mail.gmail.com>
In-Reply-To: <CAGXu5jKd5SEabmr4sCW-=Oksi6WvO11tDB_9Un1fRYQAoq2h0w@mail.gmail.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Fri, 14 Sep 2018 17:26:19 +1000
Message-ID: <CACAvsv4V6yJyB1yNaSR7OCHZztc5e3ZoPirz5NorE_Xy222RXA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/secboot/acr: fix memory leak
To:     keescook@chromium.org
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018 at 07:35, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 7, 2018 at 8:02 PM, John Hubbard <jhubbard@nvidia.com> wrote:
> > On 8/2/18 12:51 PM, Gustavo A. R. Silva wrote:
> >> Hi all,
> >>
> >> Friendly ping! Who can take this?
> >>
> >> Thanks
> >> --
> >> Gustavo
> >>
> >> On 07/24/2018 08:27 AM, Gustavo A. R. Silva wrote:
> >>> In case memory resources for *bl_desc* were allocated, release
> >>> them before return.
> >>>
> >>> Addresses-Coverity-ID: 1472021 ("Resource leak")
> >>> Fixes: 0d466901552a ("drm/nouveau/secboot/acr: Remove VLA usage")
> >>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>> ---
> >>>  drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
> >>> index d02e183..5c14d6a 100644
> >>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
> >>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
> >>> @@ -801,6 +801,7 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
> >>>              bl = acr->hsbl_unload_blob;
> >>>      } else {
> >>>              nvkm_error(_acr->subdev, "invalid secure boot blob!\n");
> >>> +            kfree(bl_desc);
> >>>              return -EINVAL;
> >>>      }
> >>>
> >>>
> >
> > Hi Gustavo,
> >
> > Seeing as how I've been working on this corner of Nouveau lately (don't ask, haha),
> > I reviewed and also tested this. It looks good, you can add:
> >
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>
> Ben can you take this?
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
I've got it in my tree.  Thanks!

>
> -Kees
>
> --
> Kees Cook
> Pixel Security
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
