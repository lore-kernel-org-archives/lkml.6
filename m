Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA411C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDBA206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550878754;
	bh=zBxc0o9y1e24tL0YlkiJKG4it/wn+tjgKfKsuqGrB4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qrx1qG0x30hbFf+D9YgkPUOomnWHpn8CGhJRF1nSBHe8zK90AAI5SJdNPhkemLf7I
	 2KdaePo6C/yNLE7oP2NvjVD8FqJfaocIENtS0UNaqftxnXFoxy3j64mxgu1x9Reg+I
	 Aazj6Jia/esoXx8jr3t/iClNckl+rpy3+Nm29KPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfBVXjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:39:13 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37440 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:39:12 -0500
Received: by mail-oi1-f195.google.com with SMTP id w66so3096517oia.4;
        Fri, 22 Feb 2019 15:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4wSN5e5zNt5rUxlT0rDs5fxVAcazIusWOWVEyB1L5g8=;
        b=eCklpHRXSw1kypyLpoClAuy9uKxHWMD42xLKn2CQsQ7d2Jn4dmEzk+d22KPubyC3SE
         M6+AY2MTL3lc9rafm54lKGugbiT1thU7aPwI4JIqjGrS/gSgo5xQjJu6Il1yOmq+3d3v
         zLQmUvAjviRWzGTeY++gh4ENytcrpaWl+ggKmNeRJLKAi0O1ZSrrLuwFBY2STLNHRJJ0
         UjBYClWdotDU1+sP9WxcWlCNnQpykOsK+PWxLEe/C5j3dZgz0kOCSrFT+WRaZq+Jldjx
         R+rEUk5Hjy+RuDIOpDzASIc03JmW61lWt7OYVUEtME/tTYv1siRujG/NficeTLieEZau
         HX+Q==
X-Gm-Message-State: AHQUAubrRxkfGL1+F+e2UWdcOxJc4RTKlrjkiJfDBmRLDk4Mwsil85bG
        nTOxTmxr6xK9+SN/CvUs/Q==
X-Google-Smtp-Source: AHgI3Iam2Fs3QHzVpShgvrQbnwq0GU/As4IyEenW8fFZv/aKsXc1Wh9NlR3GLv3/U7aBUNXRMlWzPQ==
X-Received: by 2002:aca:4a95:: with SMTP id x143mr4187777oia.18.1550878751757;
        Fri, 22 Feb 2019 15:39:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w22sm1100773oth.45.2019.02.22.15.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 15:39:11 -0800 (PST)
Date:   Fri, 22 Feb 2019 17:39:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: tegra: Add Tegra186 support
Message-ID: <20190222233910.GA14887@bogus>
References: <20190221154634.10684-1-thierry.reding@gmail.com>
 <20190221154634.10684-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221154634.10684-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 16:46:30 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Extend the bindings to cover the set of features found in Tegra186. Note
> that, technically, there are four more supplies connected to the XUSB
> pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL), but
> the power sequencing requirements of Tegra186 require these to be under
> the control of the PMIC.
> 
> Reviewed-by: JC Kuo <jckuo@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/phy/nvidia,tegra124-xusb-padctl.txt         | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
