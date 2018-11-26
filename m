Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE0AC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC39208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC39208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeK0JpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:45:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38364 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeK0JpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:45:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so14002061otl.5;
        Mon, 26 Nov 2018 14:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zOugLrPivIxbV5Szw69IxstaVGK45UquH2hVk8XlWDc=;
        b=LDfOXUT21wMI+ykCe3//gjFF6aI9SWhDTHsVCsv3wB/oGZb85jARAC/QvoeC5MYp6g
         5Mr1J7d5TGo3Eq60MiXCj/edls0QfgRViwrPZB7V40FtRoc4+qQbE0ob8zTiUi6lHB7B
         Q1i66nNlv8PPHASi0f1vWVJLQJ2lohZ4YErGMIFjSaSRMieh8LY2WzTO8OHSJDP8YGF1
         h5HDe5QrB2enYRxtS0kBOLdrGby7T8hTS/E/tixl/Ao+Dpf/WkTjGbyks/jloZm3LaXJ
         dYufBnBvfNlLDbQg+rO9IqISgEjGBIDZ+h2dQvkyvHjSj+Bgpuw3uMXy1m7YIXkB3MVW
         ah4w==
X-Gm-Message-State: AA+aEWY3ktf/5f6ywS/npZnYB2Mg6QSX+V6dWNucNsBfWWjBpyKviJsV
        iUZk1/fBy63NjKEA31hLazNiTmw=
X-Google-Smtp-Source: AFSGD/VBhKHYi+8iWTMtFNePd2IQXgjVXtpFKaour2r1lD3sywFO8HtRBGG6r1PvHmW1drfjgIhteA==
X-Received: by 2002:a9d:75da:: with SMTP id c26mr17850258otl.39.1543272560359;
        Mon, 26 Nov 2018 14:49:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 187sm2236592oic.12.2018.11.26.14.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 14:49:19 -0800 (PST)
Date:   Mon, 26 Nov 2018 16:49:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v4 04/17] dt-bindings: interrupt-controller: Add
 suniv interrupt-controller
Message-ID: <20181126224919.GA11610@bogus>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <ea00e2cc4dadb4a661e694dd022d8ca06470d3e8.1543131714.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea00e2cc4dadb4a661e694dd022d8ca06470d3e8.1543131714.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2018 10:43:07 +0300, Mesih Kilinc wrote:
> Add compatible string for Alwinner suniv F1C100s SoC interrupt
> controller which is stripped version of sun4i
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt   | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
