Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7CDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3823208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3823208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbeGJUvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:51:13 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40603 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbeGJUvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:51:12 -0400
Received: by mail-vk0-f68.google.com with SMTP id s23-v6so13248303vks.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 13:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPZQW/F02i853zcCCBBxx4Z5WYSC64yEpmYHpUrf1T0=;
        b=dr6vIeqrm5VgEVxDMTyF2zQ07CtCgnpP4XYuzDTj4h1ZNnp60JNl3wMoPXeJAIgzXY
         mpMCbKLGQbWIFg+tinzAm3Nvho8nT9HeI2r59nXizpTkkx0OgkGRdPKln7CCl+jfGWGj
         CYUCgcXWIOkj+yob+bJ3d7EkmJlDuA1iJJjTQoGUNX5WZqECJdZY/C4eaADYMoSj9+Mn
         9H7KPxtTAGxWfXvUo7/R58pz+iAsl+awcgFpVIU0At6C7FD9enxMt03HBsvQvF3UZrwm
         wgAtJzdxxLFFMcJGGJmSFZVoQxaq9kemCe62/vpGnkT4XIZ2vxPwCxukg3v5NMmyl6tT
         B/SA==
X-Gm-Message-State: APt69E1OtkzdLrC4pWEFVkbab4zaaVg6NOG6Htu84sp1uqNbSjh5Q3Mt
        F6bEdrcdfDSfdGlNeinXq425Fy2y5P//UrIbFtc=
X-Google-Smtp-Source: AAOMgpfOajepcHT62eV+Y+Pqgd3IBCgpQQV/Taz3L6/jQgAklzCmtlGM5Y4AJfeIgOUjL2qpyLsARwN/6a82mHV1aO8=
X-Received: by 2002:a1f:654:: with SMTP id 81-v6mr14819008vkg.159.1531255825660;
 Tue, 10 Jul 2018 13:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180710121014.31119-1-geert+renesas@glider.be> <20180710204706.GA30083@amd>
In-Reply-To: <20180710204706.GA30083@amd>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Jul 2018 22:50:14 +0200
Message-ID: <CAMuHMdVZae7Nb-Nr=f1uJD9ASxaio0Ob-5__FHzN=gEp9MSc+g@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Require author Signed-off-by
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, jgg@mellanox.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Tue, Jul 10, 2018 at 10:47 PM Pavel Machek <pavel@ucw.cz> wrote:
> > Print an error if none of the Signed-off-by lines cover the patch
> > author.
>
> Is it good idea? Signed-off-by system was _not_ meant to prevent
> submission of third party patches.

My main motivation is catching accidentally forgotten Sobs.
It's still up to you to submit or accept a patch that triggers
checkpatch errors.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
