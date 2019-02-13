Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85134C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A06222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550094266;
	bh=zf8fGSH6+PYUwxAIAm8wc1hnvSumjwkU7s3ZGE1gxh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RLrdnk5PBPQ/4dHV59DgCGkZxcfqK8ckBDmJG26cDk2vczcDLfuYNR9HMNY+tnKW5
	 N6RRAkyjhYtNYOyfaubNy0X6OCr9Ii0kjQgZUG2K4ZLmhFo/YUf3+qw+7qeTf1TG8h
	 2FbRkXrthQhXly7eI2tb+u2uw9p7EDm9l2UodUyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394999AbfBMVoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:44:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36947 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390797AbfBMVoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:44:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so6983836otp.4;
        Wed, 13 Feb 2019 13:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qgeq9ef3JVUvr1rCSWxPRE1noszY4CjdYdlwSxQIIwI=;
        b=Tw1MQKtmPu3MDz6i/N/IpREUoZuKNWJtx9ecWSQiMshkajI6Vs7yV13pM3cqe8SART
         OhAMYd2Ti+dVaTPaPV4uRApCoCnmvhlsIjKKvNcV3rCG/B5bCxz0n+t8pm62w9mrvZ2S
         weCLOPidSs7psp8UkM+7d8JJIMnC33NkVYOsVKOoZ4L7Zo7vflV4efi9wW5CadFJ3VZC
         RU+lNcw9M/bb8TyeRP6cecSiMb8p5WydRzXr2tMDJwXOUu1dR0JIyYuVZvNenLVARudm
         HvS9tIy7q/7gAJwhtHmK9v3V4mkSozuu7M7uMk/hVRpMvnDDGtcU3jaKFD+6v334bjnF
         Zd0Q==
X-Gm-Message-State: AHQUAuZI1KOo/aCtg6JoDWx6OAMzLoR5bTwSt9s+2QLc0i6GNKPrkiUc
        cfhArL1oUC9U2uqsWQXIFg==
X-Google-Smtp-Source: AHgI3IZmuRVPl+drsV7gNz5BYUQ7QVgWNd4MtmZC5VuyWFmxr5vDhxxbwGjJSwma71fdeUyNA9aiSQ==
X-Received: by 2002:aca:f389:: with SMTP id r131mr222752oih.58.1550094263652;
        Wed, 13 Feb 2019 13:44:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 11sm535442oth.35.2019.02.13.13.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:44:22 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:44:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     jorge.ramirez-ortiz@linaro.org, robh@kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khasim.mohammed@linaro.org
Subject: Re: [PATCH v4 2/4] dt-bindings: connector: Add vbus-supply property
Message-ID: <20190213214422.GA31951@bogus>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
 <20190207111734.24171-3-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207111734.24171-3-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Feb 2019 12:17:32 +0100, Jorge Ramirez-Ortiz wrote:
> Some phys might need to control their VBUS regulators while not being
> supplied by them. If such support is required, use the vbus-supply
> property in the connector to retrieve the regulator.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  Documentation/devicetree/bindings/connector/usb-connector.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
