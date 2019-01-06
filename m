Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88BEC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 09:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835AF2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 09:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfAFJd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 04:33:56 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44253 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfAFJdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 04:33:55 -0500
Received: by mail-ua1-f67.google.com with SMTP id d19so13299201uaq.11;
        Sun, 06 Jan 2019 01:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdNAX7FQNMmgvTU4emoCSCNjVBTjt7pbdDOEoGqmPfc=;
        b=Q4SFE+SMt+/8rF3X8f7szloKc9XAbRKyyB1ooWce95LtmmkH513oscn6yuZ5iTPv5m
         J7a5F3sHqVzQqY0A1NbQv1PmlpPntaIoPaROAPhyalvdtHEiayG+ktwcnU/kmEEpARU8
         wSMuo9Id3WuECYiwF6WIbQiWGeiSJBcLXuZH9xePWLqKnwCzgfsiBCupFI2ATcV5WCQ5
         3jmCZmCl8n/tWkF2X2gSKqSPGXwCCuiW+QNm1vjyIZPBCsR+o08cNM7xqMkziy0Pj2/n
         mPia+S+GpAnQtYbTm+OXypH2JA+fECUsLvD0XieKcxnCRvd8QzIpYovCcCQNlwhcZnmS
         6NaA==
X-Gm-Message-State: AJcUukcxAdSoOaWtuHTr4i7s3BPN/bRrjLUWXAwVEbaHdk5U4yDIy3th
        ZUJIEU7mLidnLg/BOn+RRoZY5AbhPadK+pMHRzs=
X-Google-Smtp-Source: ALg8bN6lAmEDwDCOXjTe1TOTvQtFadmVTOGq+vtJLNlLOanqTzNEuKjVRV5yTqcD9eNcFKjXGR8RMnWOfwPBcFQqw4A=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr21918198ual.20.1546767234650;
 Sun, 06 Jan 2019 01:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20181126215725.2548-1-peda@axentia.se> <20181126215725.2548-3-peda@axentia.se>
In-Reply-To: <20181126215725.2548-3-peda@axentia.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 6 Jan 2019 10:33:43 +0100
Message-ID: <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fbdev: fbmem: add config option to center the bootup logo
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Nov 26, 2018 at 10:59 PM Peter Rosin <peda@axentia.se> wrote:
> If there are extra logos (CONFIG_FB_LOGO_EXTRA) the heights of these
> extra logos are not considered when centering the first logo vertically.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

> --- a/drivers/video/logo/Kconfig
> +++ b/drivers/video/logo/Kconfig
> @@ -10,6 +10,15 @@ menuconfig LOGO
>
>  if LOGO
>
> +config FB_LOGO_CENTER
> +       bool "Center the logo"
> +       depends on FB=y
> +       help
> +         When this option is selected, the bootup logo is centered both
> +         horizontally and vertically. If more than one logo is displayed
> +         due to multiple CPUs, the collected line of logos is centered
> +         as a whole.
> +

Isn't a kernel command line option more suitable to configure the position
of the logo?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
