Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC29C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACF820864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqJWosc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACF820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756738AbeFOW6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:58:38 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33048 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbeFOW6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:58:36 -0400
Received: by mail-pg0-f68.google.com with SMTP id e11-v6so5030194pgq.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aUZhIFz9cKT2bisxhKJpcdYjq7En3RvITQckXaPhxU=;
        b=hqJWosc4FA1Zum4slacoL5omDDoy/skhGtUf3bDb7t9P/RF0AKe/TtngX26/v7SCkY
         vrAQWUo40FfE5kGN+J57HnixERJ8Ur1McTmyf5EWFqM7JvUcL9SqctukE/21g5B7GnG0
         k3Xv9uGihppG+RBNdixzOTw+I2oO5fb3iUIYaNLCwDyJFuQvo9gqL8ElHDh97Hl1p94J
         zWDkJjO73kfVt1TCc7WJhGcBuYXaohHpJAQgkzqwLfKtXZN5CT/NbQa6hGK5jWaIqkHm
         8tz7Bpm4mv/MzapOFV5vOdlN2D49wnU9k3FHdp6Q2kB4fQpytPfELu2i9lJrzakK9+ye
         fCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aUZhIFz9cKT2bisxhKJpcdYjq7En3RvITQckXaPhxU=;
        b=OhFo+2Db4mEq/Gai8UmrxixU9LMxeOozRwyqpFJcZhIdPd0cx8wEobhIxDDoshxA9I
         9T2FrtyBI718cx2BCP1ll3uLQ+wDfY4CFrUkPH+siIMF3M9cKw7B0F2wKGejb7aWkBDH
         w/EZDG/6A0eS2AcPUwLk41lj2WWjMxCTMcyPx+wWW4eyL2pPEBFswZUhixJmEIwGKpEz
         aBaRZjmk7c6PXes4CEf3DZ0Udacp4TGwihRuXI6uXjV60bFJXLUDw6SOlBUhaoqPYV15
         Tkk8NnBFv4g6AGClYu93Re4Uu8wn3ksdTcDo6Vi3cF+0wCrUbOLSB3R8bTglyIMgdq1J
         EE2Q==
X-Gm-Message-State: APt69E2Ew1RNxnUHqL87NuuEMGfKvklgnrA3febIH/CggPA1CoVcCZy8
        VFhSg2YntzOx1ETK71vR/wRDUQCvSpmoInaHrs4goA==
X-Google-Smtp-Source: ADUXVKII/ikJIUN1Y9zDeX+LEQjUSlDeCZCZcliNjzRoA0MGDqy+t1E3mG1F49w1r1ewuj35BKPQ9pZGqRuYDpaedr8=
X-Received: by 2002:a63:370f:: with SMTP id e15-v6mr3239208pga.192.1529103515757;
 Fri, 15 Jun 2018 15:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180615225606.185324-1-ndesaulniers@google.com>
In-Reply-To: <20180615225606.185324-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Jun 2018 15:58:23 -0700
Message-ID: <CAKwvOd=ntzV5x+rDSH6VEoS2ONZacnqeemewNgv3Aotm3Hd-hA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/nvif: remove const attribute from nvif_mclass
To:     bskeggs@redhat.com, airlied@linux.ie
Cc:     Matthias Kaehlcke <mka@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 3:56 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Similar to commit 0bf8bf50eddc ("module: Remove
> const attribute from alias for MODULE_DEVICE_TABLE")
>
> Fixes many -Wduplicate-decl-specifier warnings due to the combination of
> const typeof() of already const variables.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  drivers/gpu/drm/nouveau/include/nvif/object.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/include/nvif/object.h b/drivers/gpu/drm/nouveau/include/nvif/object.h
> index a2d5244ff2b7..7f188f66931e 100644
> --- a/drivers/gpu/drm/nouveau/include/nvif/object.h
> +++ b/drivers/gpu/drm/nouveau/include/nvif/object.h
> @@ -78,7 +78,7 @@ struct nvif_mclass {
>  #define nvif_mclass(o,m) ({                                                    \
>         struct nvif_object *object = (o);                                      \
>         struct nvif_sclass *sclass;                                            \
> -       const typeof(m[0]) *mclass = (m);                                      \
> +       typeof(m[0]) *mclass = (m);                                      \

Sorry, this messes up the spaces at the end, will send a v2.

>         int ret = -ENODEV;                                                     \
>         int cnt, i, j;                                                         \
>                                                                                 \
> --
> 2.18.0.rc1.244.gcf134e6275-goog
>

-- 
Thanks,
~Nick Desaulniers
