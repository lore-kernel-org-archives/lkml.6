Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B15C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22855206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbeLTQKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:10:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40862 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbeLTQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so2382531oth.7;
        Thu, 20 Dec 2018 08:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evFPKsEg+uPJhMf0jnt9a5FV1SgNua3Tw/qn+yPgmHg=;
        b=jyw5Ph4rlQwWwT5JAmPEUaJSf1JWUAeEJtLHcKszgTUXNSIxYsM30lmqfVkqr8aQaK
         bakuM7YNia0B9//p4khQ02BxeCHGsW7ljVX3nnJRfysgO+zox4Gbx8o6CPqffVoWscjP
         qzDLcCalM72rV3eOnEx3Wp8qLJe53/hu+wZ+ZeTLfiMzZ7+T6FQbrqEGHKNt8liIXZ0M
         IYzeqntMMDcDYD940YqibYYhlyjWeK8/JjbX4pYSBGI6Ol5Zu1sH3Du9iknE+9tmNT+d
         eZ2VeWjTcgLMwy96CVXkLLooMRiIWz/Rr34e1SfLgXFXIm+ps6P2vI9OSrOaDxn+Pk0l
         2nnA==
X-Gm-Message-State: AA+aEWac997DTo4SMr/mlml2rKmoYnRCWZPwCC9v4QhagpzAwHuOnVgD
        WtwfDTLonPx5fGL7hSNNcDsdNqmuxllMHulkGNqG8w==
X-Google-Smtp-Source: AFSGD/XJwz5cXm8mN2d4mU5SW03BhMV5qUOBSULtnT+eByrANJm8p7V4HiI+hmRi/MjB11NwPJf5UomHRkrUkrp9AWE=
X-Received: by 2002:a9d:22a:: with SMTP id 39mr19611100otb.354.1545322231949;
 Thu, 20 Dec 2018 08:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20181207125844.18775-1-malat@debian.org>
In-Reply-To: <20181207125844.18775-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Thu, 20 Dec 2018 17:10:20 +0100
Message-ID: <CA+7wUszBpmd2r18WZVjAXv2xq+ySrnKTqaRT7bGcHa71_M_j7g@mail.gmail.com>
Subject: Re: [PATCH] video: offb: Pass actual name in offb_init_palette_hacks
To:     Rob Herring <robh@kernel.org>
Cc:     "# v4 . 11" <stable@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, any comment ?

On Fri, Dec 7, 2018 at 1:59 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> This is a partial revert of commit 5c63e407aaab ("fbdev: Convert to
> using %pOFn instead of device_node.name"). This is the minimal work to
> get a Mac Mini G4 back to a bootable state. The function
> offb_init_palette_hacks would need to handle the case where `name` has
> been set to NULL.
>
> Cc: Rob Herring <robh@kernel.org>
> Fixes: 5c63e407aaab ("fbdev: Convert to using %pOFn instead of device_node.name")
> Cc: stable@vger.kernel.org # v4.19+
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/video/fbdev/offb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index 31f769d67195..6e75851f8142 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -648,7 +648,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
>                 /* kludge for valkyrie */
>                 if (strcmp(dp->name, "valkyrie") == 0)
>                         address += 0x1000;
> -               offb_init_fb(no_real_node ? "bootx" : NULL,
> +               offb_init_fb(no_real_node ? "bootx" : dp->name,
>                              width, height, depth, pitch, address,
>                              foreign_endian, no_real_node ? NULL : dp);
>         }
> --
> 2.19.2
>
