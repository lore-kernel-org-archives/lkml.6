Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDEBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC7320779
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC7320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932925AbeGCWJW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:09:22 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41970 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbeGCWJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:09:19 -0400
Received: by mail-yw0-f193.google.com with SMTP id j5-v6so1243955ywe.8;
        Tue, 03 Jul 2018 15:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qa4ze6xjCIA2cfRUel3FiMz+5/35PJ2Bygt6z6OuDJY=;
        b=ehj+Ng7Kc2eZUQstmDJ7k6R1qlkqokhgeoeRrG5fZlW8R08Y1J7Kzkx8YqBzJyNAM1
         zIlzDZKH4nyvu4cBPbTJxkEcnD+TeJtbNFquMx6y+XrbjNVJZXIoOK9iG5CFCAXBg8gY
         W+Ay73h6h4F0DdRq4L4D350fkxAM4TeFFsY/CFvV6SvcXXwOqZBu6ebI0OdzX91G/TAc
         wWvXLkgyzGN7G2p05w5hVNh+upHiSHqYJUs+WRa8b657lbf/LM5ntFC6Gsgk/0GkR+PB
         3xZz9nvJ434qjbYRV8tkFq3SvE+Mxa75O1RDj3299pK7XdZ5i1eUcKHslr1pF7tl757Q
         5AuQ==
X-Gm-Message-State: APt69E2s4ZHHKqfwbsSN7yZc28ffryGjdj1wift79Lw8fmfgiRsIN4+T
        sOeBPK26qbBYVtmAXcaGxg==
X-Google-Smtp-Source: AAOMgpeVJQjLZN8SAGHV/hUWiOdjJYxuKBF/kafARVFxmRDeIlrymUxgdbnupG6MjSWucbV78lYo6Q==
X-Received: by 2002:a0d:d342:: with SMTP id v63-v6mr853424ywd.500.1530655759258;
        Tue, 03 Jul 2018 15:09:19 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id b6-v6sm763079ywb.29.2018.07.03.15.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:09:18 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:09:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lei YU <mine260309@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] clk: aspeed: Fix SDCLK name
Message-ID: <20180703220917.GA5938@rob-hp-laptop>
References: <1529978125-28712-1-git-send-email-mine260309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529978125-28712-1-git-send-email-mine260309@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 09:55:25AM +0800, Lei YU wrote:
> The SDCLK was named SDCLKCLK, and no one has used this yet.
> Fix it.
> 
> Signed-off-by: Lei YU <mine260309@gmail.com>
> ---
>  drivers/clk/clk-aspeed.c                 | 2 +-

>  include/dt-bindings/clock/aspeed-clock.h | 2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 2 insertions(+), 2 deletions(-)
