Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337F7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56BE2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56BE2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934240AbeGJPYD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:24:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35766 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933711AbeGJPYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:24:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id b10-v6so16860745edi.2;
        Tue, 10 Jul 2018 08:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KXj19EGYxwRDWjT20RFzn7JogqxbdYpvA2O7ea01hC0=;
        b=KT4ASqbhS25+54IXWxz0uiuld+F2E+KQPydGBTYJmdf22RvHovUlOcH9DNW/eRTlZ/
         njPH4xJEnhaXLzCCm6XT+45f2l8FjASN634u5nyUoUFfM8ctdQPYRdP8ExJ+0VK/Nz/p
         nAXglnd4W4eajdyCsREWpvKqWZCTRjsOOZpAOpWXQ3Tsk1hQxtZN58FYFCWuNIiQKz8V
         WeFlHoGGJLZsetzHOWeSQK0xPzGYqy2EI7vibkXkwTxm1j9RcRZvs7HWlXp2lYcxpBRL
         L+JMlk370Fv/+BqxnkC4g9Myeo6VpUppe0D3iUEDwXFEnIVQd43yQyHbA2sBB+kzL3BG
         7eZA==
X-Gm-Message-State: APt69E2glqlSiKmwK8qAyvIFz7aSh+bZsmN8PZnnaTgnsyIwkoD61+kO
        ERClBsFuBPpzLGwDCiRvmCXG0tQF
X-Google-Smtp-Source: AAOMgpcy4RC+v+7Rul/YUlUb9FDiWS5VFgSH5DIh5lI60lIBrMeMMRkOG4khrHDcpej6Ud0/JFmY2w==
X-Received: by 2002:a50:b962:: with SMTP id m89-v6mr27175121ede.20.1531236239615;
        Tue, 10 Jul 2018 08:23:59 -0700 (PDT)
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com. [74.125.82.42])
        by smtp.gmail.com with ESMTPSA id p20-v6sm2410395edr.12.2018.07.10.08.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:23:59 -0700 (PDT)
Received: by mail-wm0-f42.google.com with SMTP id s12-v6so25111226wmc.1;
        Tue, 10 Jul 2018 08:23:59 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr15762997wma.143.1531236239146;
 Tue, 10 Jul 2018 08:23:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:23:38
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-6-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-6-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:23:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v660yji16F_EyoezyZrAJaC9_MWF3giCfGXVcL3RJ6c5fw@mail.gmail.com>
Message-ID: <CAGb2v660yji16F_EyoezyZrAJaC9_MWF3giCfGXVcL3RJ6c5fw@mail.gmail.com>
Subject: Re: [PATCH 05/17] drm/sun4i: tcon: Release node when traversing of graph
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Function sun4i_tcon_find_engine_traverse() doesn't release node if it
> needs to traverse of graph deeper than 1 level.
>
> Fix this by calling of_node_put().
>
> Fixes: 49836b11fe71 ("drm/sun4i: tcon: Generalize engine search algorithm")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
