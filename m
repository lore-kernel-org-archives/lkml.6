Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F88C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E95120660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZW0YtRU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfANIgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:36:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41531 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANIgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:36:45 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so9824501plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eyav2Xd4vPIbQq+IXEwcBzhuQ0gqy8aeKKbOWnFHlow=;
        b=ZW0YtRU78Dc20Bwt9j0gcxCswyNmcX6SDlpyvA4f7oXu2bEl9pmO9Zc9RZkG1gWZdH
         qKo+FBfo+fd53pWJrXW15qOurdpzkqGwU0Kcw5RBvkYHfS9sjCsP9WtwcVgmNAz4D8vG
         QPOWUwF3HwLG034qbAFikR2lZ2Rgufzg4A+Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eyav2Xd4vPIbQq+IXEwcBzhuQ0gqy8aeKKbOWnFHlow=;
        b=nJ+hZoQIaFPIX3Mrp3/nC0EGqxTOTQA6n+6AIStXAnaGFdIVBF4F7ikcfkBtDgr65R
         Cc3FSf3vxv5ef4uTOmfDO4biMYnWW8WypAqKhlhcHQwzjRMZUc0g52rHSWYYAYslTeA3
         +QQMPXFcROPKS4KDmGCWQiiHZaHchCVtbMb9wTmCgVo5do6d4oReJWHS2RT0VS2clFDJ
         M2eUgM2lGzS/ucEdhLGZo9bH7wD8EFlqZjIllT1MHnGgT25GecrEVp8DmJLxoS3miLvy
         2p3ThdBIhmYX1Uhf1IiUatefCBfT/SPhtQfIMjhzQnIZkUl/q0zZ5dzNfg6DD96rEKcr
         lwBA==
X-Gm-Message-State: AJcUukeTjPZFY1tdGPYpNWh/WP3GfI4CbyB4XXAqT64kqbQxkHS4Blb7
        Dohila1XXMAf5wYMSTvYlQEIfA==
X-Google-Smtp-Source: ALg8bN5AKnOcdFbgQl6BzYaNZaVwpK57EQrzb60ctv+Sq0OKOZMNpxJr4blxpMNaqhlfRQeFYnRhvA==
X-Received: by 2002:a17:902:bf0c:: with SMTP id bi12mr24723607plb.0.1547455004352;
        Mon, 14 Jan 2019 00:36:44 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li421-24.members.linode.com. [50.116.3.24])
        by smtp.gmail.com with ESMTPSA id 4sm141415516pfq.10.2019.01.14.00.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 00:36:43 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:36:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     xuwei5@hisilicon.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v2] arm64/hisilicon: fix SDcard detection
Message-ID: <20190114083638.GA12459@leoy-ThinkPad-X240s>
References: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Mon, Jan 14, 2019 at 09:24:34AM +0100, Vincent Guittot wrote:
> The SDcard detection of hikey960 is active low so cd-inverted is wrong.
> Instead of adding cd-inverted, we should better set correctly cd-gpios
> to use GPIO_ACTIVE_LOW.

Just remind, usually ARM maintainer has requirement for subject as:
'arm64: dts: hikey960: xxxx'.

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> SD card detection was not working on v5.0-rc1 but patch
> https://marc.info/?l=linux-mmc&m=154637189021211&w=2 makes it work.
> Nevertheles, latest changes in of_mmc_detection makes possible to have 
> a correct DT config.
> 
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 71bfe41..dc314e7 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -665,8 +665,7 @@
>  	sd-uhs-sdr50;
>  	sd-uhs-sdr104;
>  	disable-wp;
> -	cd-inverted;
> -	cd-gpios = <&gpio25 3 0>;
> +	cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sd_pmx_func
>  		     &sd_clk_cfg_func
> -- 
> 2.7.4
> 
