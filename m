Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA09020661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA09020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeHaLHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:07:34 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:44481 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHaLHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:07:34 -0400
Received: by mail-vk0-f67.google.com with SMTP id 125-v6so5110499vke.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 00:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMU22EdUcmHRCMp0IGQdIo7vm8BY/VMqL4n8mQzvJgg=;
        b=r55thBF5kw97Y7grKjhQm/67/kNOlqjdryvfryEWwHEN+eRubHaeRC/VNGmxGaQ10H
         drVAWmQWsxTvKO2y2et37IUNVb+0v2WUBYLqeLujp+A6iXEXzIahMQjJoQ//J+4PdkM5
         V7j0K/OKLAITLxhH2l7aUjUl4TzgP26TYlmSFkZafQjxbaOU8f+eTgjAjr8NdpjTp/C8
         jkYKHI9rqFe7wgiQihzc6OWFAq0D1MfsWZ+OwRIO3rt5yWUSE3Wego3VYqtPKUxO2ON7
         rzL1bdGE2aCwKbTZPZTQlsAg6q3FqgBTe32wAqV/6RS3vV321OZ0XRog+Y9colE26v2X
         G1Cg==
X-Gm-Message-State: APzg51DGIllQrqre7ratrhXpd1G6BBptnVNLyHA939rWvjg5SPNf0Lg0
        B09iUJ2f4HC5VGBSc8pq6j5MSoENNmvFszXHzpbhnOLT
X-Google-Smtp-Source: ANB0VdZIlbCN6PwiTF9H8vaXXerJv0jXSM6JQBZM5iKXOwUMVh3W79F3aUWCUpKyF5bpFXvoqAumHpFfEI7l8JCISxI=
X-Received: by 2002:a1f:1246:: with SMTP id 67-v6mr8276971vks.82.1535698890197;
 Fri, 31 Aug 2018 00:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <9b103c232c73b223ec951994c9789326754ef7a9.1535015050.git.fthain@telegraphics.com.au>
In-Reply-To: <9b103c232c73b223ec951994c9789326754ef7a9.1535015050.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Aug 2018 09:01:18 +0200
Message-ID: <CAMuHMdUFss2C_ifNxU7OH_rbY4b9zS-v9P54qAfsjYuiZa8Jiw@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Use correct PMU response format
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Fri, Aug 24, 2018 at 4:02 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Now that the 68k Mac port has adopted the via-pmu driver, it must decode
> the PMU response accordingly otherwise the date and time will be wrong.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Looks good to me, so I will queue as a fix for v4.19.

I guess the proper Fixes tag is:

Fixes: ebd722275f9cfc67 ("macintosh/via-pmu: Replace via-pmu68k driver
with via-pmu driver")

Can you please confirm? Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
