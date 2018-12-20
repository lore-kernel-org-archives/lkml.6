Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ADFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECA72176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXux39F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbeLTJwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:52:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42268 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbeLTJws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:52:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so1018524wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ag0QNA0wdYruisytHPmMw+QPZcCu/RdQK3WVN1MuHgg=;
        b=XXux39F0S0YljA0III7yHwVnwFPT/tXI5bHOBELd0HGONmz4G3N4Wau3SHeG/UUuyQ
         5RBHOYqchSQgGgy1X19pLQE6jY3qjxMmRl6rcf0ALv0i/cSO6AJs5m3RrZUrrrT201KI
         g0ItMQdqtbNMBahSydRKKNdc4OeNYYCzOYYYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ag0QNA0wdYruisytHPmMw+QPZcCu/RdQK3WVN1MuHgg=;
        b=Yhy5FKU9F7e5aILQUw9go7bIo/TDKY2FTIRqCStyrLCky+C3lOZkMd7FF2AU+QEL76
         opC0mnfOWFXtzVICRqXJIRb27Bq/N8NjdUTD4xoyAwIZLP6ohMts9Bs/g9znr5VKa90/
         Um4+SKwcLG7nDiWiaYtD5Zj6VP2JJ+AJkOhfifLPs1UDFXz12OIqNkv6xPuz1RKStDo1
         nCWyStSGB0B6x8vXSyL7PnF2672SCE0IVoqx9O+ruf6oa8WIPDU1GJ4b+IMqwaNIuZBK
         JfxWaXZcE6++AH61LK++AmcXbW+KAEDb+ZRB4b7Nb5fMhOrjTPN3TzYFbaOUVvD9yGAt
         w8nw==
X-Gm-Message-State: AA+aEWbnboDkX89MXMHhENAhKjfp+2Klc3eWQWqCSIgcUADih1J45iv7
        98Fvn3u4rEB1KVO9zUxlEW358g==
X-Google-Smtp-Source: AFSGD/VXataGAz7dK2HUCsA2JSbUeTUrz7EskYwUCHm7jE45txxRKeEhF17KiKBS2kK4od5REq94Sw==
X-Received: by 2002:adf:b608:: with SMTP id f8mr21010797wre.120.1545299566965;
        Thu, 20 Dec 2018 01:52:46 -0800 (PST)
Received: from igloo (119.red-79-146-81.dynamicip.rima-tde.net. [79.146.81.119])
        by smtp.gmail.com with ESMTPSA id 200sm7627606wmw.31.2018.12.20.01.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 01:52:46 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
X-Google-Original-From: Jorge Ramirez-Ortiz <jorge.ramirez0ortiz@linaro.org>
Date:   Thu, 20 Dec 2018 10:52:45 +0100
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.guo@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
Message-ID: <20181220095245.GA7783@igloo>
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/18 10:55:57, Jorge Ramirez-Ortiz wrote:
> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
> controller embedded in QCS404.
> 
> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> definitions.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

any follow up on this patchset?

thanks




