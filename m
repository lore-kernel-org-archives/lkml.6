Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B1BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1443F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1443F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbeGYQqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:46:00 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44663 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbeGYQqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:46:00 -0400
Received: by mail-io0-f196.google.com with SMTP id q19-v6so6664433ioh.11;
        Wed, 25 Jul 2018 08:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7y7Z3FPvjwjugB0ZzsYCxT3ELRbhvkdAsRzsEHDLKc=;
        b=A6VnHFMxcRxqHy/VLusM+sUTgGBG7DzDj1g0w1vIrqkrcUJgesMp63I3PsgPeA2AI5
         cYqjpU8M/u7O/XDd2A6dT84Wj0lBzYkBGeCu22VNsvhpyH4AfBwrxQ63i0PZ2mVteFGU
         OankH8tYR8Dthd7RgamkvX+G+JTehx+cseQLXv7WKEV6n4q+WcdfOQ/SJg9oYnWm6rpZ
         p9E+kZB6ere055U0W5a9xGI3PHxwS4Kx/Wn4crt8Sx2NDE3IfttXxd3vD2Qa2bAB5deN
         jWu8Jy552cjJWLzjRyIDXfM4RE+tmrv2r8dDM7Q6ATf5Dfi/dRltbEvFcmFs37j6f+JE
         xkyw==
X-Gm-Message-State: AOUpUlHgMd1lWhnf/iUFmyt0RHsbfodDp/yiR5yfeYlGN6oCXeKNg40i
        ToVKL+t3uaPnqjWd63Lp4g==
X-Google-Smtp-Source: AAOMgpdNrmtffis/ZxEWL8AW814jhhHjnQCNk54h6vfs3b4drOIPKdzlrpnzq8ABvfo96HzTIdRs/A==
X-Received: by 2002:a6b:a192:: with SMTP id k140-v6mr16901721ioe.130.1532532829234;
        Wed, 25 Jul 2018 08:33:49 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id r3-v6sm938120itb.16.2018.07.25.08.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 08:33:48 -0700 (PDT)
Date:   Wed, 25 Jul 2018 09:33:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, fabio.estevam@nxp.com,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        Anson.Huang@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: pfuze100: add optional disable
 switch-regulators binding
Message-ID: <20180725153347.GA19576@rob-hp-laptop>
References: <20180723074747.9328-1-m.felsch@pengutronix.de>
 <20180723074747.9328-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723074747.9328-2-m.felsch@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 09:47:46AM +0200, Marco Felsch wrote:
> This binding is used to keep the backward compatibility with the current
> dtb's [1]. The binding informs the driver that the unused switch regulators
> can be disabled.
> If it is not specified, the driver doesn't disable the switch regulators.
> 
> [1] https://patchwork.kernel.org/patch/10490381/
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> ---
> Changes in v3:
>   - rename dt binding, add -sw suffix
>   - fix description
> 
> Changes in V2:
>   - add more information about the binding
>   - rename binding and add vendor prefix
> 
>  Documentation/devicetree/bindings/regulator/pfuze100.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
