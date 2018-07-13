Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773D4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7F020857
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDxtOXTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7F020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbeGMOlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:41:13 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:37045 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:41:13 -0400
Received: by mail-vk0-f65.google.com with SMTP id h22-v6so18278261vke.4;
        Fri, 13 Jul 2018 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o0s95QqcHWBZvnqqkEAY/j0d7SkjPCAMs+ki4WvQcUQ=;
        b=pDxtOXTWFmPc4k6G7O9CAf8lwQYLNT1rXuXCZXkYFjxMkMMlt2PaInfEOHxiyHohhm
         ZjouMQr8ik0RGJTW03jEOobDACDsS2VAQ4QftnRvbykEhHkDIn6bW+++TgJlTQzXRjJb
         z6sUOlEOYs/f23alsoXOCYBZgbujCEB9aqXgmuOKLVphbSZ1hljgtQp35YqlLutX3jSu
         B2BNvxPYLYgmwhE6MbVoWukQohFiEhI9TowYOIHRL8qrldgWryeefSmkZxzVgcob3Su5
         vRgw+q8OASYVxszzbMII3mkGALZbBfcTpUEC4NGeFLWXWSGEHEyobBQ1Hq35C4WpBMgg
         RngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o0s95QqcHWBZvnqqkEAY/j0d7SkjPCAMs+ki4WvQcUQ=;
        b=mVLWbPN5St6GINNNTQ2EyOSKkf5rwulkw++4l7Tacj63T8l4SzF7Zb4JpSi3AqfpVv
         5IdsGHYrOkWboD6athKXRco35+5xdbiGVi/K5nHt+2DmZ1D8+61hE6UYCUXt86Z/mtvJ
         o9tbTt6F1IGjzP16FY+os+Cbz4E4kekdNxzYQdcwUhTTMJc1tYJLXYUAfTEFM5E0xPwN
         SOPRpa4XWkZy64G87qVkmBZ43EeMWiGKXOn8gTcbzr4G831c6DIxi9vvNgd0RYfSpob2
         rtTSlXYYUxlBAjoEVKSVgnUSuIYQq3/WhxQFuKwyZJA4G2zjjjq5rpQivyM2dUv1PNwB
         Dn+g==
X-Gm-Message-State: AOUpUlFjR9CJqRBQu6e8NEAUcoiG54j2r1uUf/LbqHJai9jHi+QDRfrw
        DVkIGRNscOxYX8ogSiZqmcXcP/T1rGHyS9EtuyU=
X-Google-Smtp-Source: AAOMgpfc6toLqeEIr+XBzNkFAJEkMf8Rb4cK2wUjtzKBc52NlEX7DcNm5x0oGMfAsiQnFhxyGUKkag1xruJpTopEELU=
X-Received: by 2002:a1f:50c:: with SMTP id 12-v6mr3816136vkf.26.1531491980559;
 Fri, 13 Jul 2018 07:26:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 07:26:20
 -0700 (PDT)
In-Reply-To: <eca11a9c20d14480ae02b2912b7a6447@ausx13mpc120.AMER.DELL.COM>
References: <eb0db565-5f8a-ab1e-2bf3-2def3ec3eddc@gmail.com>
 <5318cc53-31b4-5c83-abb7-c3ff5d892af2@gmail.com> <eca11a9c20d14480ae02b2912b7a6447@ausx13mpc120.AMER.DELL.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Jul 2018 17:26:20 +0300
Message-ID: <CAHp75VfpX7m3zLii3MKbW=S2rkh7O4BVygFdP7aB95jJ8hCBuA@mail.gmail.com>
Subject: Re: [PATCH resend v4] dell_rbu: make firmware payload memory uncachable
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stuart.Hayes@dell.com, Takashi Iwai <tiwai@suse.de>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 7:28 PM,  <Mario.Limonciello@dell.com> wrote:

> Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>

Pushed to my review and testing queue, thanks!

>> This driver has no maintainer.
>
> Stuart,
>
> Outside of this patch, I think it would make sense to send some follow up patch
> series that do the following:
>
> 1) Let you take over as maintainer (Update MAINTAINERS)

> 2) Move this driver to platform-x86

Darren, what do you think about this step?

If we would go this way, first move, then take maintainership to reduce a churn.

> 3) Update dell_rbu.txt with the correct URLs and mention that it's only for enterprise
> hardware.    Client hardware has instead opted to support UEFI capsules for updates
> from Linux.
>
> Since it's really a platform feature and specific to only Dell enterprise hardware
> I think it makes sense to move over to an area with subsystem maintainers that
> can help to review patches as needed.

-- 
With Best Regards,
Andy Shevchenko
