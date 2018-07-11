Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5825DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1323C2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1323C2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389703AbeGKTnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:43:22 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35597 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389485AbeGKTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:43:21 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so51434555oik.2;
        Wed, 11 Jul 2018 12:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8mhlto1WR7QP3SPXMUL/OnpNYkKVxsawb2owZHqaxI=;
        b=MYTdgM0RBvt3Wt8gZlJuQLa00jCB5RhXsqJEvlREiY4IyytPcb/9VJo9D+Mi0JjnN3
         QBAlw9UrkyCvRdbfqIeehL5ItKNVeKoRBSwwer17Cb0y4P8eeNZ2jwHOW72yd+scxNgT
         y4CPM5LoUIJgx5g8eJx7ANEjDrssXYJU6KC4o60fG1Yfvcrebhy+8TgJ5d/ozgKnGIED
         Q/EflcEGiDTjTEZJghd54E9LtZxTNs/lYuu5Lpo9UKY78BPsv4Q0+vz/R47dqo+1swrK
         6IeMVIK6Y6Fnv5h2VUGE3TRkpDjSDosguknfxiBwSc5DzM0+d/O88xTyGzSwxX3wo+gn
         jPVA==
X-Gm-Message-State: AOUpUlGRSNb43IxnKGwk3Ig5Nma8se8NiGJfyWumuGoy+x6V41tlg6cE
        3e3XW65lfspQRYJ59Ki40w==
X-Google-Smtp-Source: AAOMgpdZQPUVUR290My76c1QBjT1HfZKQv/Gz5gULFurwvCWyqxX/K1op2Ufo5Dmj+Xhz3wPS9k3Pw==
X-Received: by 2002:aca:cd41:: with SMTP id d62-v6mr640374oig.207.1531337852750;
        Wed, 11 Jul 2018 12:37:32 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id q124-v6sm484907oif.8.2018.07.11.12.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 12:37:31 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:37:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: uniphier: add USB3 core reset
 support
Message-ID: <20180711193730.GA31593@rob-hp-laptop>
References: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1531185257-16444-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531185257-16444-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:14:16AM +0900, Kunihiko Hayashi wrote:
> Add DT bindings for reset control of USB3 core implemented in UniPhier SoCs.
> The reset control belongs to USB3 glue layer.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/reset/uniphier-reset.txt   | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
