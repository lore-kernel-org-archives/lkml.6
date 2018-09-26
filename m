Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79163C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AE72152A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AE72152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeI0DPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:15:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44783 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeI0DPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:15:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id 36-v6so361757oth.11;
        Wed, 26 Sep 2018 14:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YQBoDvtmWF4Fkjgat4DJFnzFHoptjk4ILK5taMlCwDI=;
        b=O8LyU8uISQpQAavF6z2/bvEhTkNDBNecJkO+os7LhV1cKAR9MyBUUyo+RLjO2b/2NU
         PT71Rtz6bJQT91vd8gciNU+hKf3JhczV/+cokQNyXp2PuIV8amZoUMHWAz53AiQ6WUf3
         EMkGV9rADKQvQNRAaWywM6ycE6Z/vyBbmbWDXDsTNFTtTtErkdYKv1QkArHKYND0EzUP
         d5s0zYQakhmI3iuIpoVFMuJeajCPhI4EVQuv0CwKxMUkZQkD47cWKdLqXFhJJJOcZFg0
         Ljk67YBUd9PDiAkOQxp0+WRJpmH5obi1O9drBTMZq+bX+gcZJzlsl4fM/nvqKYdoW9t6
         ACXQ==
X-Gm-Message-State: ABuFfoiCdmEPh7Wu5xGiBYR06aN672Nd41mPY1FUJKo+C9EK1EUq1Vx3
        6OIjPKkdnXw9Z2JP7P4k9w==
X-Google-Smtp-Source: ACcGV61irj7J9Rpw4w542BatZgxVZ4IRcLrZ+ougKjb4Ozwyo/fS/lis9p8otk/7BF8R2HgNvj14nQ==
X-Received: by 2002:a9d:5915:: with SMTP id t21-v6mr3570259oth.217.1537995661678;
        Wed, 26 Sep 2018 14:01:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x124-v6sm27228oif.24.2018.09.26.14.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:01:01 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:01:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     linus.walleij@linaro.org, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        p.zabel@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, architt@codeaurora.org,
        a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 5/8] dt-bindings: display: add data-enable polarity
 property
Message-ID: <20180926210100.GA31471@bogus>
References: <20180912183222.25414-1-stefan@agner.ch>
 <20180912183222.25414-6-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912183222.25414-6-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 11:32:19 -0700, Stefan Agner wrote:
> Allow to specify the data-enable polarity required by a dumb VGA
> DAC converting parallel RGB to VGA.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../devicetree/bindings/display/bridge/dumb-vga-dac.txt         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
