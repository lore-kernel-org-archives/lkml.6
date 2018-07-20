Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACA0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62F820652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62F820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbeGTRof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:44:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40603 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733198AbeGTRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:44:35 -0400
Received: by mail-io0-f195.google.com with SMTP id l14-v6so10459835iob.7;
        Fri, 20 Jul 2018 09:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s07+GFFgDuE0PtGc8wxxe9KVkCANUh87+itlfetOlOw=;
        b=BK2ifkuFlyz2MXm4KAYpetbd06+DHEj+XZhlPmvVsGnq3Bk78UTrE4qMvyvyYDd21k
         2+NIQMLH4htPlDdoCujnaTC4JbAJ4qWyP6DDkuwoaQaoQPYlGNhdXu7ThDBS2q6enukp
         6mL3gQTYDtz/gXq7nLGMQsG+AZnoUJ8RG2/cyET5cAVT2S8SUdHeT6/73t73xzT3LMLI
         eSe0mpFEgOCK4IGx6oc0r262Cg+I+zr4LWC7tpgxgzNcFBY937v6W8mjVB4qpEgvwbaE
         fidzN2cfrmcfYI3gyLMizElHlHyI0qaby9jA8PV8miEX6puzcBpzX23TSywwUmtFFqwL
         pa7w==
X-Gm-Message-State: AOUpUlE+zzFaHp6tpLtOb5tyyX61TrLYxd/7uhDVn/ot4HptQKcIeD5l
        gva7X1Yvau0hIWR4RqqrH7adIo5tFQ==
X-Google-Smtp-Source: AAOMgpe2120FDRZt3Qyotr8os0jKvj3OI2tVqon2U17PetU1+9qg5XtqobF/h+ydBZW+KjW4ERy5og==
X-Received: by 2002:a6b:3954:: with SMTP id g81-v6mr2122756ioa.225.1532105727124;
        Fri, 20 Jul 2018 09:55:27 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id c5-v6sm1128203itj.9.2018.07.20.09.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 09:55:26 -0700 (PDT)
Date:   Fri, 20 Jul 2018 10:55:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, mark.rutland@arm.com,
        klaus.goger@theobroma-systems.com, jagan@amarulasolutions.com,
        djw@t-chip.com.cn, jacob-chen@iotwrt.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com, arnd@arndb.de,
        zhangqing@rock-chips.com, shawn.lin@rock-chips.com,
        kever.yang@rock-chips.com, david.wu@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com,
        william.wu@rock-chips.com, sandy.huang@rock-chips.com
Subject: Re: [PATCH v1 2/7] Documentation: rockchip-dw-mshc: add description
 for px30
Message-ID: <20180720165525.GA9952@rob-hp-laptop>
References: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
 <1531813747-8804-3-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531813747-8804-3-git-send-email-cl@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:49:02PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> Add "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc" for
> dwmmc on px30 platform.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
>  1 file changed, 1 insertion(+)

Same subject comment, but:

Acked-by: Rob Herring <robh@kernel.org>
