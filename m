Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF92AC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D62121470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuAJ6w0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D62121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeJMBDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:03:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35064 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMBDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:03:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so14272821wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDMEv8MypMJ0eJSFlLkP6nYZYzgrJvR6W8381Z6l7q8=;
        b=OuAJ6w0t1NXC6zshtMvC0OQf/3PmNoJnL25uH483KpcVOuLnworiimOjrNhl8hsxiF
         QR3X2/wHKivALG9vJDCPCJiPzff+93t3o7WvNpoFBpAZE6zAJIR7OFK+TalLo24fupqF
         x56dbvF3s0WWXGLFoqXQXnIezUShdlEdLc0s8uA2rpu1GLSTlb/pgQ4PU6wcfHcDP8B7
         zpkBVV6KNKlLKc4bgioiesfwxOIB+0xchEbTBrOeMaa1bYEYbP5uNr7by8bg2Blbl07o
         QmwP0q0T3H7ZmsVmjnUksMZQ8wdw9FfskcXIz7NTYhgJQA6YGEFfMx4yqoQ2kdtGb+sY
         Z/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDMEv8MypMJ0eJSFlLkP6nYZYzgrJvR6W8381Z6l7q8=;
        b=RohYLfcOchmUj8YFfxw4OEw4AdV6HdzW6d4H8yK3ic8/KZbwfOoiEXfBwnTXqSXTwH
         HR31YYwUpLB8+5GCvd1VCJqij2SwH+jYBIsKm2rrvE7uKspsqqtcBRNiz5Bk7Ximd5vM
         FBp2cdkD4uQwh8rTfBOIzmzVZ0/Xj78lL/DJEsgTyxIgOavIborspgmx9Kc7wtUoN64K
         Y+NZ5+glsRtzXSVCRGY86EjPmDluzotvrMhVvlnRYFKG/d4HdoJvL0PSereZozLl++Ej
         VgjEB6PPot0MLHp9lxAQjbpZ0CHmfrGUxhheUZFzNeRPQ/TlEiyaYxXNhR3qii8G0Py/
         tX2g==
X-Gm-Message-State: ABuFfogtbsN5GOD0obg3OzQ9S/Hyv4IKENdMcQxFBMenPocTT2vLSwAH
        7v16rTj8jDfr6PyP+++wH2Q2dY2MGat7cAFwo71ayQ==
X-Google-Smtp-Source: ACcGV612ysKu68/NicVfeffrq0CLaMPQHU45m+H+R2/DgIGPm73ZECDwEQIWz+ZD2p6hwke+0bZw/QuC2tyLWDqr/tY=
X-Received: by 2002:a5d:4b50:: with SMTP id w16-v6mr4018967wrs.173.1539365387673;
 Fri, 12 Oct 2018 10:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181012161236.GA21768@embeddedor.com>
In-Reply-To: <20181012161236.GA21768@embeddedor.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 12 Oct 2018 13:29:33 -0400
Message-ID: <CADnq5_ODxnRPUFe-Sr3TN3E7kq+kxXVo_VvOVpT5_CdNSu3oCw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/r300: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This and the r420 patch applied.  Thanks!

Alex
On Fri, Oct 12, 2018 at 1:11 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in this particular case, I replaced "Pass through." with
> "Fall through.", which is what GCC is expecting to find.
>
> Addresses-Coverity-ID: 114734 ("Missing break in switch")
> Addresses-Coverity-ID: 114735 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/radeon/r300.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
> index 21161aa..652126f 100644
> --- a/drivers/gpu/drm/radeon/r300.c
> +++ b/drivers/gpu/drm/radeon/r300.c
> @@ -814,7 +814,7 @@ static int r300_packet0_check(struct radeon_cs_parser *p,
>                                           ((idx_value >> 21) & 0xF));
>                                 return -EINVAL;
>                         }
> -                       /* Pass through. */
> +                       /* Fall through. */
>                 case 6:
>                         track->cb[i].cpp = 4;
>                         break;
> @@ -965,7 +965,7 @@ static int r300_packet0_check(struct radeon_cs_parser *p,
>                                 return -EINVAL;
>                         }
>                         /* The same rules apply as for DXT3/5. */
> -                       /* Pass through. */
> +                       /* Fall through. */
>                 case R300_TX_FORMAT_DXT3:
>                 case R300_TX_FORMAT_DXT5:
>                         track->textures[i].cpp = 1;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
