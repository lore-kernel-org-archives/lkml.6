Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B55C67869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B42B2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B42B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeJLQf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:35:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44275 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeJLQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:35:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so10798871edb.11;
        Fri, 12 Oct 2018 02:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4TZrMRGJL3JuH3IQ1gMGDFlYyt0CxS8K+87nIULwbw=;
        b=oH3MrAg+Bz+GhES7rode8RUhPzwn6WSO/9Vp/xNYba9omE9jzMir1k+/OvGy7j9aiG
         4vOKv6VyTqJYjeFEEnGCe8rYU+GBthsK2FU537dmew5KZZdXQs0EhebHBO6i9KErACrK
         /5qQtGXaF1ZPJmY2+e6lfsQcq9Bgfc5ANfmzXfJvXlRko0jmq+R167UIQE0a9QGuVU03
         pfrj9RDnGX1bEiehh+7NKvjI+YsgUfYlar+MXeKOCO2+Fp5ndL4kGYpSbvVGYqrc2o8G
         VJCX602BUksniWCTHs/06Q4BmhaHJp0hIph8ZnUspV499iYIlZlXxp78AkSX3NuG6l3H
         jqbw==
X-Gm-Message-State: ABuFfohFbvJDLw1j/5NrNxer05z81hLn7HqMZdhLM02xzVufhoUUMKSd
        IK2FlAotXkpAjEl1/A9YjX9uOQ8tb4s=
X-Google-Smtp-Source: ACcGV60bjrc+oEfQ93AF9xiVVfbYbVCuQEqbQUMgXH0osRgy70vOE/wxgOTlfjCckU2WCt7vlu/QBw==
X-Received: by 2002:a50:8a42:: with SMTP id i60-v6mr7552163edi.236.1539335037915;
        Fri, 12 Oct 2018 02:03:57 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id c24-v6sm369495ede.73.2018.10.12.02.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 02:03:57 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 193-v6so12129366wme.3;
        Fri, 12 Oct 2018 02:03:56 -0700 (PDT)
X-Received: by 2002:a1c:f53:: with SMTP id 80-v6mr4254857wmp.58.1539335036136;
 Fri, 12 Oct 2018 02:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-5-jernej.skrabec@siol.net> <a303145c-b123-d912-91d7-9830dec3244e@openedev.com>
In-Reply-To: <a303145c-b123-d912-91d7-9830dec3244e@openedev.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 12 Oct 2018 17:03:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v64GM4JBx4SqjpWgAw3kEKA9m2-7trwiok8fy+xOQGV7Eg@mail.gmail.com>
Message-ID: <CAGb2v64GM4JBx4SqjpWgAw3kEKA9m2-7trwiok8fy+xOQGV7Eg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 04/29] clk: sunxi-ng: h6: Set video PLLs limits
To:     Jagan Teki <jagan@openedev.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 4:14 PM Jagan Teki <jagan@openedev.com> wrote:
>
> On Sunday 07 October 2018 03:08 PM, Jernej Skrabec wrote:
> > Video PLL factors can be set in a way that final PLL rate is outside
> > stable range. H6 user manual specifically says that N factor should not
> > be below 12. While it doesn't says anything about maximum stable rate, it
>
> Manual says "In application, PLL_FACTOR_N should be more than or equal
> to 11" can't it be 11?

PLL_FACTOR_N is the raw value, which starts from 0.
That translates to an actual factor of 12 used in the calculations.

> > is clear that PLL doesn't work at 6.096 GHz (254 * 24 MHz).
> >
> > Set minimum allowed PLL video rate to 288 MHz (12 * 24 MHz) and maximum
> > to 2.4 GHz, which is maximum in BSP driver.
>
> Is this max freq from here [1]
>
> [1]
> https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/drivers/clk/sunxi/clk-sun50iw6.c#L164
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
