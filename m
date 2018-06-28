Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB44C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4047F25C8C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4047F25C8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753191AbeF1C0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:26:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38204 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeF1C0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:26:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id a5-v6so4201946edt.5;
        Wed, 27 Jun 2018 19:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ShY+oP8owvh7JF0CZoZI2SQXuxz3wVtlal2rHsKv0ak=;
        b=buwaNjhqi67PC/afbJWQ/vyXcVlPeVWJ7MTunQisqqiW6bquXXjdjiJVjUaHuaDPoS
         NAAUjPiuYxnV10gc5YdyZ9/LaYhIh1ASw9S4OZE00pj1NnJKhSD+z0GvLZ/n+bFjvC1O
         yDmzDAWUHvskkPzGOqwt/0Ff8HPuvCxrez2RV6t6KJbGWZhHZwS0DciCntBKcpaoQI/o
         SKzQp4QdhTJidJWXvB8Sp6HCFLeuLGWGWkB0FSUNkaLIPWwb+FaQnk/qpmMl6sMjnwjW
         uOdmp/+IYoqaZbl1MrYlAQti8is8ArlXXIvOVTg+D/VdYbRL/V9TRMgvdq5MeypiDiA4
         JF1g==
X-Gm-Message-State: APt69E2DL4iqlUU0IS9+dWE2Z+Taapd4HadpumVPQNA66VkoN6Zv8uHt
        8edQ7pgISEzMWcGTBuzixZ7gWFi/
X-Google-Smtp-Source: AAOMgpesXiJ+0J9f1hH9Zxg9rr3pOllLK468brHy0rwyCUjBIVYiz24LaKY0Jx/vIzgAADHO7PWmrA==
X-Received: by 2002:a50:96d1:: with SMTP id z17-v6mr7220634eda.55.1530152775621;
        Wed, 27 Jun 2018 19:26:15 -0700 (PDT)
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id m19-v6sm2510537edr.33.2018.06.27.19.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:26:15 -0700 (PDT)
Received: by mail-wr0-f174.google.com with SMTP id l2-v6so3251975wro.7;
        Wed, 27 Jun 2018 19:26:15 -0700 (PDT)
X-Received: by 2002:adf:e94a:: with SMTP id m10-v6mr7053472wrn.126.1530152774853;
 Wed, 27 Jun 2018 19:26:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:25:54
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-19-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-19-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:25:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v651RGegpAi-2efhBUkyFf1iC+zxOGTbRkmjuWcYSTgYJw@mail.gmail.com>
Message-ID: <CAGb2v651RGegpAi-2efhBUkyFf1iC+zxOGTbRkmjuWcYSTgYJw@mail.gmail.com>
Subject: Re: [PATCH v3 18/24] drm/sun4i: DW HDMI PHY: Add support for second PLL
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Some DW HDMI PHYs, like those found in A64 and R40 SoCs, can select
> between two clock parents.
>
> Add code which reads second PLL from DT.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

This patch by itself does not do anything. It should be merged with the
next one.
