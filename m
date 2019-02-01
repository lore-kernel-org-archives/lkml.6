Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA40C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD8220844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="THLQ9cIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfBAJYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:24:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53840 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBAJYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:24:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so5314835wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mA0dKcx8RuhKcpbgaOrH+2O6eYDnOQYrcZJgPWYakQM=;
        b=THLQ9cIrwazMILBMA7Mercmnzkxyz00ik84YRoowlwuBWTfZmPm1Rz48Min3wY5i1Y
         ocTiAdAOjFv7DmcMZPY4X+MXQU9Eh9j7PMhvyNf0msYX5Mh4jBTZNURvitiCKiJOvqzX
         1miSF02NYbiCp7E++NQfVO2D+wbPY9iovdlag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mA0dKcx8RuhKcpbgaOrH+2O6eYDnOQYrcZJgPWYakQM=;
        b=Q5tdNlntPM6juj5LUZtN3/FlbF07PusS+m4pl/St8Gie/FrSwh4nJp/ghyg5bV+fIU
         aGvID9PJn7Fcnx2TB+yLe2AdC+e8LKVQrGYk2xSfHcG2mpPEaqgTfMioSSNls9ySo75x
         jfICTlJ44qAxkXB3d9O/BYL/7FwzizVCOQckSLB3pMNYouNpZgj4nBo0qMja501O2IEG
         kxKfoJNoTBD45mf9K1WCdvdh4/xy0BktZgPq5d2s54QT3Q2mXrgJltFrJv9d/sbnWlVA
         9IRX6Q+/e5pshPnGgbrZQohgoVN6MEnGxmOpgsQbx9dlu4BCr0d0w9ab70QKN8R6EpU4
         RQTg==
X-Gm-Message-State: AHQUAuZkxFGz+3rm0sjiO4DI4Z/v9AtU0ng00SPhBzEmsPjn9vtOj2RT
        TlcbTJzuFXFfKpasJ2U0TvjOOg1hRoQ=
X-Google-Smtp-Source: AHgI3IYJY0Hx09Xaq3WEDC7Dx9gFmB7B23QztAc+qhpxEAhlL/yX656LmIqFE19L/hyqq39XBxw77w==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr1576386wmc.50.1549013054294;
        Fri, 01 Feb 2019 01:24:14 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id w18sm941710wmi.12.2019.02.01.01.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 01:24:13 -0800 (PST)
Date:   Fri, 1 Feb 2019 09:24:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: rn5t618: Document optional property
 system-power-controller
Message-ID: <20190201092411.GG783@dell>
References: <20190129135917.29521-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129135917.29521-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Jonathan Neuschäfer wrote:

> The RN5T618 family of PMICs can be used as system management
> controllers, in which case they handle poweroff and restart. Document
> this capability by referring to the corresponding generic DT binding.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/mfd/rn5t618.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
