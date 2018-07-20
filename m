Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB5DECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406A520652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406A520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbeGTRpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:45:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41085 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbeGTRpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:45:07 -0400
Received: by mail-io0-f196.google.com with SMTP id q9-v6so10446438ioj.8;
        Fri, 20 Jul 2018 09:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=veg587bLR2HYb8R7QFXmEqZ7DIDk5STOAdHm0ZmCQ7g=;
        b=Wyr7w+WuYXtSc+beUZt5eAnBKYssteEcuG50ucOlc+vdF9ZFm8ma4/HPnLhUHGZKg1
         5z0lwngXzkNSzyJ++FhO5+yRa+4mkUQxyAxba44W+99FvdyiBYDGfJ6PNPVWk9WZupSK
         OGURd/g+dmU59xxIOA3RNW8OQd4Zk1GiKx7kb+BaZS3Jd9bRGgxjivxfj788QJO3WVgj
         0JQH8PsNOi/iXYA6aBUJNvZMjIaTjRSdFI1XThxjYoCbIrN1P6INKAlgwWhDNNPdKsT6
         9N6Go36krHlljCeULWsaFHwY2SiAZ8YLBpjemNikMmwTpiZERdn18cJQRpqmq3mbXfTq
         yhvA==
X-Gm-Message-State: AOUpUlHnS3rPgwBVgLZL9pM6Mc/fPGEkaQj6FmeyX/0f3N7B+FvmHVtx
        66AOPD7UjFWTHu6mebs4cw==
X-Google-Smtp-Source: AAOMgpeHw2uYnxMbQtWhBxT3wMShM7bY94fIkqKo5CAsZLr8jM+Uhr1KEaTwT0OhdW7/fT9Mr7Glug==
X-Received: by 2002:a6b:7b03:: with SMTP id l3-v6mr2359051iop.36.1532105759515;
        Fri, 20 Jul 2018 09:55:59 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id w193-v6sm1193751ita.35.2018.07.20.09.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 09:55:58 -0700 (PDT)
Date:   Fri, 20 Jul 2018 10:55:58 -0600
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
Subject: Re: [PATCH v1 3/7] Documentation: spi-rockchip: add description for
 px30
Message-ID: <20180720165558.GA11251@rob-hp-laptop>
References: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
 <1531813747-8804-4-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531813747-8804-4-git-send-email-cl@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:49:03PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> Add "rockchip,px30-spi", "rockchip,rk3066-spi" for spi on px30 platform.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
