Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD04ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609CE214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdSoIjMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609CE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeIQXHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:07:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41494 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIQXHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:07:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so7893083pfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=seQS80gYm50yZRwErCF5bisa0RzoGRqYDj+JrsIzWKE=;
        b=HdSoIjMMSQNlbSXGfJCDgfkVoXBWnpB58Ku9UvZx9RSQZeoD2YaZTc51Mxjd+yd6Jv
         LfGr+/NDU+ST6vOBAUPMimRuWR43jeUH/Wp+G4dxhMwCBWFOUqE1vJ1gYAHi3PQTa55Y
         /06vTcqRiDzycKCdhdlOtnhbzkl5tNVG4h1QMA7HyVYW6RHnvE4l9FjJAm3Im5zGfaqw
         /09xqEfJA1m+DXuSF1TB2cgZv/ZQdJS5yjxVv6GJnO/zrWou9pwsBXu2VGimFdVWzxAU
         2ddjJxK0eC8180KqpDbGJfsMNfwSK3oQARcizCUgsjK7k+PV/ewFGFj5e0RERfJnOqIc
         csdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=seQS80gYm50yZRwErCF5bisa0RzoGRqYDj+JrsIzWKE=;
        b=HgRt6X9WjgA5TEJijblNQ2xtIBc2SV7Yj64wsrxcI0mTqSWnHL+XfJ9zQxCCjOwtfx
         VwYV0TXHF4G530oZS4a70JxbW7W65+9G1uonw6++aAbuIzLQU7R15T15f74Hd9Hyj0eY
         iO5LJysglDsUW7Kqvr/fqq2aFHzx0L05QGq5bdH0qoL3bUdytlc89FFs0kKgVq8YAvBE
         VMs6zmse1zAeYKyyLDo05Ze+NNa/y0tD+n++Og35mX7tUAF0JYBVwfE0qMPVflvYaVvp
         6l+mHZUGhnFzCWGUuXmTKEglmJTwGOymUSxE4OwDG4aVNRbrTWK1kmwdmYIoWV0u1tmh
         vpRQ==
X-Gm-Message-State: APzg51CSTc9Em9Oxh22qOdCu8iqbKu1V1OSGXQ2JV6ld2QAsmBiiRJAn
        BrpVIjLLqmBsckMPk5B94QBuOUjRuVYyUfLVcgWsgQ==
X-Google-Smtp-Source: ANB0VdYHVTC+X8+UKATfVZ/OyMXpKRXgrF8em6SdK4XEGcQxYN/LYHv6JDNIPOSrH0vRt3YEuZwLFCkGwwpYO7znpx8=
X-Received: by 2002:a63:1363:: with SMTP id 35-v6mr24396865pgt.202.1537205957209;
 Mon, 17 Sep 2018 10:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180915061615.25308-1-natechancellor@gmail.com>
In-Reply-To: <20180915061615.25308-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Sep 2018 10:39:05 -0700
Message-ID: <CAKwvOd=FY9_F=yDOPaesM1VmYW0jTaAAYcMTmG6TFwa=ACu62w@mail.gmail.com>
Subject: Re: [PATCH] media: davinci: Fix implicit enum conversion warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     prabhakar.csengg@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 11:16 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another.
>
> drivers/media/platform/davinci/vpbe_display.c:524:24: warning: implicit
> conversion from enumeration type 'enum osd_v_exp_ratio' to different
> enumeration type 'enum osd_h_exp_ratio' [-Wenum-conversion]
>                         layer_info->h_exp = V_EXP_6_OVER_5;
>                                           ~ ^~~~~~~~~~~~~~
> 1 warning generated.
>
> This appears to be a copy and paste error judging from the couple of
> lines directly above this statement and the way that height is handled
> in the if block above this one.


The above code for reference looks like:
   492                 if (h_exp)
   493                         layer_info->h_exp = H_EXP_9_OVER_8;

so it makes sense to me that:
if (h_exp) layer_info->h_exp = H_EXP_...;
then
if (v_exp) layer_info->v_exp = V_EXP_...;

Thanks for this patch Nathan, looks like an actual bug has been fixed.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

We should send this to stable if/when it lands.  Maybe the maintainers
could apply it with:
Cc: stable@vger.kernel.org


>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/media/platform/davinci/vpbe_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/davinci/vpbe_display.c b/drivers/media/platform/davinci/vpbe_display.c
> index d6bf96ad474c..5c235898af7b 100644
> --- a/drivers/media/platform/davinci/vpbe_display.c
> +++ b/drivers/media/platform/davinci/vpbe_display.c
> @@ -521,7 +521,7 @@ vpbe_disp_calculate_scale_factor(struct vpbe_display *disp_dev,
>                 else if (v_scale == 4)
>                         layer_info->v_zoom = ZOOM_X4;
>                 if (v_exp)
> -                       layer_info->h_exp = V_EXP_6_OVER_5;
> +                       layer_info->v_exp = V_EXP_6_OVER_5;
>         } else {
>                 /* no scaling, only cropping. Set display area to crop area */
>                 cfg->ysize = expected_ysize;
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
