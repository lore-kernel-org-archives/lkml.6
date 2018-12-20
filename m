Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56818C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1CF218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338465;
	bh=CWzswqQT8EtEcs1POM5cEnbhIi9Qf3vrNDXPXiUxv1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CqRA2svspwwDBwkxL93lnBhONB5K4JGJXBaGgsePb6QJ8sDPlKf/jxDS+FxvX9pHl
	 c+czswjvcfUnpXgtC1Kt3riFZNpmxI1HUcq14cahmgpmvHe+qNTxlO7HtPBhJpczP0
	 O0UfNL6e0S/zEA0hF+qzP96ZljDL94kFOS78ICgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbeLTUlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:41:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42807 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732984AbeLTUlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:41:03 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so3163250otk.9;
        Thu, 20 Dec 2018 12:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CUs8jZl5JjkZp/zytTGaJW2Ss8AXrgdM0mgq1EB2yCw=;
        b=NlMuURsCXRfY02pW/QWvWGQIt5ks7Wf8BwJbQiQk7oa4u946iuTNmZKZ/VnQbUU0Gm
         ubocx+74vSjwBVGyBnMST9YFr+KkYznMjc+klPUc4bjAvrXJE9bGytwcOMR6pPfosJXn
         VVe1a2/8lGcLH+KZuNHFFbZrbvAMa1mfW7jFjMc0PgVuyjVgQVU6NiE0CT1SQtCpmj96
         OSmoqOIA29d6V0x4Wg9CZrRky4KgWwaEKkgudSo8+iqSXhqCPPLJMUne49EQXHcfDvcH
         wVuBKfY0IPRB5tmVnxlz+Yo6ynrwG584HeMNdWKWrtbR21Jr3bHDeWpCjxAlJamSg3tu
         rA+w==
X-Gm-Message-State: AA+aEWZD2lQKbuRybrUnmuo5M+g7Jox/wKu9/FAVKiEyAOSzYvBwSLnO
        9PDEYE2jCrXV4zUXXS8kIA==
X-Google-Smtp-Source: AFSGD/VZt2+X1qPiLc+3D7UGBwIif9AIdwoaDONEjMyEbqcQbOioZVtFcYuI7ns5n2i/JXDo9nb4vQ==
X-Received: by 2002:a9d:2248:: with SMTP id o66mr20202396ota.61.1545338461991;
        Thu, 20 Dec 2018 12:41:01 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id m3sm10346493ote.64.2018.12.20.12.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:41:01 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:40:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH] media: dt-bindings: rcar-csi2: Add r8a774c0
Message-ID: <20181220204059.GA25828@bogus>
References: <1544732509-6911-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732509-6911-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 20:21:49 +0000, Fabrizio Castro wrote:
> Add the compatible string for RZ/G2E (a.k.a. R8A774C0) to the
> list of supported SoCs.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
