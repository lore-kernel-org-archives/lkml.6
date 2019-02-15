Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7CEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E61020643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404261AbfBOIZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:25:25 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40401 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfBOIZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:25:25 -0500
Received: by mail-vs1-f67.google.com with SMTP id z18so5315755vso.7;
        Fri, 15 Feb 2019 00:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDgNj+hLumR0nv6kzdyxNqixIoCoe5NmWzayHzxN+d8=;
        b=c/rOaGC55XL3mav6pSSSjuDqrDZh2thCFBXjfOQMZzWS41aoXaWGlbhtk+8eiABIHX
         4JULw+dbKk893JXXUj0k17E314XFYE2xzYtNR18YAWpnvrH5Z29bZBBwpGL/gzYXeyZ7
         R8oj/rpR5YsOJySNFtm3/QnSu+Kxraj7m4MMshglETs9bDxktQoFf07CHx8DVPbq/WsZ
         S/xij8g/tuo9VuaZR8YQV/Ut5+6GYHNuIz3GxmyNko/X2V22hk44AyB2v6D0aaQBeuzn
         MWu8logJwWeSMcc9PJA3o9jcgyQb4ciFFcEtgMuCThoVz6tnNK8z+iMjNPl/a9svywAw
         mFVA==
X-Gm-Message-State: AHQUAuboilIO87mxlhkH7vzYi4atCYYa+n7acxBiSgxL4G8kjnX8lGVp
        P/duJ+SuehcVOPJpqtqlcZVU+fO3eDxeHbHMAktI5+PQ
X-Google-Smtp-Source: AHgI3IbrVSUhPlfMbxcHABds1JS46hoFKfr8foOF88yNgUc42iC9odOEZBImKjWtMk5RaxW44sLy+ewc4Ry+4yjPHrU=
X-Received: by 2002:a67:f43:: with SMTP id 64mr4285204vsp.166.1550219124276;
 Fri, 15 Feb 2019 00:25:24 -0800 (PST)
MIME-Version: 1.0
References: <86a3eca8946cbeb648ddbe3ff67b983ece7498d8.1550182390.git.fthain@telegraphics.com.au>
In-Reply-To: <86a3eca8946cbeb648ddbe3ff67b983ece7498d8.1550182390.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Feb 2019 09:25:12 +0100
Message-ID: <CAMuHMdUN1SGHd-BbEWY9xwc5jkybLQ_xbLaE0-jzskorso6brw@mail.gmail.com>
Subject: Re: [PATCH] video/macfb: Remove redundant code
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 3:19 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> The value of info->var.bits_per_pixel get checked in macfb_setcolreg().
> Remove additional checks as they are redundant.
>
> macfb_defined.activate gets initialized to FB_ACTIVATE_NOW by the struct
> initializer. Remove redundant assignments.
>
> macfb_defined.bits_per_pixel, .width and .height all get assigned
> unconditionally. Remove redundant initializers.
>
> Cc: linux-m68k@lists.linux-m68k.org
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
