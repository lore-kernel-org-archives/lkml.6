Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A00ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0287120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0287120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbeGTRpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:45:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33879 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387818AbeGTRpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:45:35 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so10458293ioj.1;
        Fri, 20 Jul 2018 09:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NxNhufx4OLklTlj9kr6cCHdVZX70zdNwrgqAm7SiHD4=;
        b=i3HKso5IESQ/GnARgdYLynRZAk1GTYFKKbM6lpPFWfNbHsap9HnP3nK05x0u15SZd+
         2WU2MeSCOY8nEJ4q8SgX42POBktS+nK3MTMhQ/yYCX6ZGHIWgUFi5ClorJ/BiONOhwho
         iZDYgdATuz/uEJ23gZomgz0ith3UScwYmEDeiu+HiZQyWv2cDcTxw6VB9JWUGkAQZNtO
         E7hJxVrm+byy9t81lD4HKEVRTwAAMCt+4xlFjNENB+zwQ9/Q5RHeszJPTdscEkfYPPWN
         HYFKRVzKlJvJw0A8DjXoBYTLS9rjNOpROpL/gBE8PoFC96RtNbHmCxQNr0v5wVupBLga
         0DBA==
X-Gm-Message-State: AOUpUlGVjGoJGQvfC3mZDGAy6vSFelh8MIWmbHvS1XGPQr3YFXSrOmUk
        OPTM5Haac6/eRjdZmKecJQ==
X-Google-Smtp-Source: AAOMgpcBqmgwxObyUnXgxkCbYZzsWmidIy5jfq4MU7Cc2fD+I5dRi9u9K9Dt+Ga5tzTMo4NMCbWYlA==
X-Received: by 2002:a6b:b307:: with SMTP id c7-v6mr2235873iof.25.1532105787355;
        Fri, 20 Jul 2018 09:56:27 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 7-v6sm1170176itz.12.2018.07.20.09.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 09:56:26 -0700 (PDT)
Date:   Fri, 20 Jul 2018 10:56:26 -0600
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
Subject: Re: [PATCH v1 4/7] Documentation: rockchip-i2s: add description for
 px30
Message-ID: <20180720165626.GA11848@rob-hp-laptop>
References: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
 <1531813747-8804-5-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531813747-8804-5-git-send-email-cl@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:49:04PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> Add "rockchip,px30-i2s", "rockchip,rk3066-i2s" for i2s on px30 platform.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
