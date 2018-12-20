Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D5CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0FA21905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338780;
	bh=bTccyKLKF6zYBe+Zve/lh7YrZ+ypM5r9whlilg+dVgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H8DVMMlOVvyHKJvILrCb18IHFAvrO0YkUoXRmxm1myh1CvH86HFm2Vej0IwxWSaWb
	 YXeEhnODtSmhnl0XkvjH1txZV+OU/He7u8OZU+a+PNpDiZYtdwf0L0Su5v5/OUi10G
	 uUl7ECVXPEUtOYc4IhEi8lk2/TyN2do3TNFf/QI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389632AbeLTUqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:46:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36591 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbeLTUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:46:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so3199803otk.3;
        Thu, 20 Dec 2018 12:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H/p/Jc068FZbYYymYSJXNWUqOBdncNuVva4cW2LHqpI=;
        b=hE/PhaP20Z86rdvPaVWxH9+oXBgBSL/hrOdIXshDNjF0lxg/fzmS71ylWX0IWly352
         le6R0YNXUx6mzVcOv5+CCk2rqXKGrTBXBW2++pznPCapaHqhxvjO6ef3wC4pOzcPHaX8
         g3/tVNVk/UIFrKXCpmblVqPxLYQUDsw1mtCW4OdHhR6bZkW1C5+8JhN5nciRN+iwKdLo
         AFVgtZo/wDolMcKeWjFBmyiDm34FgYw0sombb9cleRRfbf8VEzl+bunUMpaW7VETj/68
         pZn7nRCAHZ93pvvLEm7OOHeYdUt8uqG37/uDxsU9TM2AWlmDvRu50JpHvs/XBuo0Gcpd
         163Q==
X-Gm-Message-State: AA+aEWbd3W42JfNyBZYIXI1WU1Ca7Sj5eSoKZVYG4r/CyAWGFw03ey5D
        5hlVK4a+y+iNk8DE98LA/w==
X-Google-Smtp-Source: AFSGD/XjwVw+/JmKsl1e8kNkrJ3oUAfxOPvTWXnLKO6f5nbQnIT64o47qtcvDU96OOky4KOfOFhCMw==
X-Received: by 2002:a9d:66f:: with SMTP id 102mr20395922otn.293.1545338778042;
        Thu, 20 Dec 2018 12:46:18 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id v141sm11901076oia.25.2018.12.20.12.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:46:17 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:46:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio-omap.txt: add reg and interrupts properties
Message-ID: <20181220204616.GA31850@bogus>
References: <20181214194822.lvavgczxq4cy7v64@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214194822.lvavgczxq4cy7v64@arbad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 08:48:25PM +0100, Andreas Klinger wrote:
> Document properties reg and interrupts for OMAP GPIO controller bindings
> 
> Also add unit address in node name of the example
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-omap.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied.

Rob
