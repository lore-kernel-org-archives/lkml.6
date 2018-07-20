Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC31EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646CC2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646CC2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbeGTRqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:46:05 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40311 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387868AbeGTRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:46:05 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so15425091ita.5;
        Fri, 20 Jul 2018 09:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=juUM4QBW+/q5KsOB8pvWAC+i3s9hcNe6dPN/h0i6Uso=;
        b=QhC9BNq9scmLafNYaBEMiC+senkpMKtAaLhFYgGNOzEq5ixdzuklDkCAbkHKTK7OVV
         5BFEXt4R2lNKHBMryH3uzD8Tr0ExqMz3+mZBU4xPJH0/3NaoH5CvuYqN1kxg7uoczeHz
         0W2JE0yTEhw+lXk37unk1UXqpIpfMhBRkZT/Cgmep/Z74BvZpeHzdtapNLssQQnxRdek
         j7vIvEnBy+nhVTNkHND5Uq5mrxM90AgaqabWv7y2hf5QOLrndER+tpWeQZmsXJRYLrPi
         LlZpDsIxYHIs1uODNEclWTldX4c7Nzxtwhn7zvCoMsh069uCZxNY5XyiT/N3XAffyuEp
         5k1A==
X-Gm-Message-State: AOUpUlH8hon+WBNc+a2G4AsVejsegprwnly+ZVbou8ySr/0CXT0dE+Ty
        /Q2+nKXNTMr2K01c6fFvoA==
X-Google-Smtp-Source: AAOMgpdGT5+0FQceSnqZZ25GFyEc52P7DefeM7Gs8cmVRWtsdT/5gNDtIMTaUFmothktNvm3jCE1Og==
X-Received: by 2002:a24:bd6:: with SMTP id 205-v6mr2430799itd.146.1532105816915;
        Fri, 20 Jul 2018 09:56:56 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z71-v6sm1962398ioz.34.2018.07.20.09.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 09:56:56 -0700 (PDT)
Date:   Fri, 20 Jul 2018 10:56:55 -0600
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
Subject: Re: [PATCH v1 5/7] Documentation: rockchip: grf: add grf and pmugrf
 description for px30
Message-ID: <20180720165655.GA12289@rob-hp-laptop>
References: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
 <1531814161-8940-1-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531814161-8940-1-git-send-email-cl@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:56:01PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch adds the compatible of GRF and PMUGRF for PX30 SoCs.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
