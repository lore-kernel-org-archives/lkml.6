Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507BAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149D520C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149D520C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbeHWP3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:29:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40202 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731244AbeHWP3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:29:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so5511917wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 05:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fi7mItNBqd1eTFdRoxIk+4KZG8sbnTdIIa8i1ouoXA4=;
        b=O25xuuy9IM6BAAnfC7/BGWgxtGIi6Ua5u9wYxi+hHrjtZzm081F5pLgaqcASZSj58+
         2Qc+tSp+Xfjof1cBuI3yiq0MaV5Kp8sTVNPcL1iEzZtTWWI3IGSMQtSJyIxwBWFGA32W
         vJgWQBFe2zbrKuvyJ6IUWdgzjDAqoHrOq5uybZblz1QyNgNR1J2AaHRZgzF42IZcUiew
         ezqV4XlTdnXqGDKEW/92vmLQ7VMvfHPQN1RHAHt4LW2lUe6vqRGTDsYfTDoDPhGG5T9r
         dywEJckarECaauAod3NgvL7EXCsmuOS81af24TyoMGQpFsz3tT4SkYESnJwLcnDz4IzU
         JaSA==
X-Gm-Message-State: APzg51CU68ndJfirHUMZPwR1Bsxlbx6xNjr1fX1uwxorUriY3y1zjI6k
        C5+wtfqK0Ad49u2aFHPha3ItPiFbR1vrcZ9tqxBIcg==
X-Google-Smtp-Source: ANB0VdZbV8ePDkLeUROAXPdzhC2xUaFLQGxIm1eWfAzRmUVE467z7uaFh+N1325jclRX9Pcs1fm8bgXVYRkJJrPc3uI=
X-Received: by 2002:a1c:7408:: with SMTP id p8-v6mr4908641wmc.118.1535025626444;
 Thu, 23 Aug 2018 05:00:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 05:00:25
 -0700 (PDT)
In-Reply-To: <20180823012151.20099-2-lyude@redhat.com>
References: <20180823012151.20099-1-lyude@redhat.com> <20180823012151.20099-2-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 23 Aug 2018 14:00:25 +0200
Message-ID: <CACO55tsuJUyQULA3oGm9VxH7ufObvW1bNH_1g7WCwcpJPrVugw@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/nouveau: Check backlight IDs are >= 0, not > 0
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>, stable@vger.kernel.org,
        Jeffery Miller <jmiller@neverware.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1-5 are Reviewed-by: Karol Herbst <kherbst@redhat.com>

I think it might be worth to test those patches on a system without
any backlight devices just to verify we don't break things, but the
code looked good already, so maybe we don't really need to test.

On Thu, Aug 23, 2018 at 3:21 AM, Lyude Paul <lyude@redhat.com> wrote:
> Remember, ida IDs start at 0, not 1!
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Jeffery Miller <jmiller@neverware.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index 408b955e5c39..6dd72bc32897 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -116,7 +116,7 @@ nv40_backlight_init(struct drm_connector *connector)
>                                        &nv40_bl_ops, &props);
>
>         if (IS_ERR(bd)) {
> -               if (bl_connector.id > 0)
> +               if (bl_connector.id >= 0)
>                         ida_simple_remove(&bl_ida, bl_connector.id);
>                 return PTR_ERR(bd);
>         }
> @@ -249,7 +249,7 @@ nv50_backlight_init(struct drm_connector *connector)
>                                        nv_encoder, ops, &props);
>
>         if (IS_ERR(bd)) {
> -               if (bl_connector.id > 0)
> +               if (bl_connector.id >= 0)
>                         ida_simple_remove(&bl_ida, bl_connector.id);
>                 return PTR_ERR(bd);
>         }
> --
> 2.17.1
>
