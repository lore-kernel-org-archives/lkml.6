Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6C12089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6C12089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJOWcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:32:50 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32990 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbeJOWct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:32:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id a203-v6so15278811oib.0;
        Mon, 15 Oct 2018 07:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Q/PU/7rOXSHJd1wKxUjTkOra9/nJ8wcOcIymepInME=;
        b=VQpNhL51yi9UfRSmL33TlWEBIz1jjb3DL7xMbJyIkyVfQolQcZbzAaUaLoOmEJL4Km
         fT1WyHeUZCRCUBMFACOkfYvwEq43JXC1vBzYLldaPtPHIwjqn1fv7eKNofYOMpip5ePk
         Wb86Zw45RESI+vJdr7ECN9Jyc34z3ctv3DUYuraiq7n+VOdFyseRvW13OPHtSQI9QRyE
         KMBKpH793OM+YtaksbOnfjs6So/kj1970tGDIvsmblY2SOJAmkj+85+ssoUwsWqDi2bq
         rsSsQFWf9IrBAM4vq83PcFeZa+rhtp5saUZQqBGFELEae/veob9O7Ft09P1rkEBIgfX4
         Dezg==
X-Gm-Message-State: ABuFfoimPJjkze4vEPba0hM1zpdIcwEPyBhRd2io9cnxMJUu9fzIullb
        WMFksPPJYNm+CQzTN8hRgw==
X-Google-Smtp-Source: ACcGV61X6SIryTGv4odcRrziawEV1Gi2osG7yOGfuZWbzpqpseKlZ89BuF/Bca7GupjY42qiYs0d/g==
X-Received: by 2002:aca:bed6:: with SMTP id o205-v6mr9011831oif.294.1539614834627;
        Mon, 15 Oct 2018 07:47:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q39sm3562018otc.67.2018.10.15.07.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 07:47:14 -0700 (PDT)
Date:   Mon, 15 Oct 2018 09:47:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: tegra186-pmc: Add interrupt controller
 properties
Message-ID: <20181015144713.GA7327@bogus>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
 <20180921102546.12745-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921102546.12745-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 12:25:38 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The PMC can be a top-level interrupt controller that provides the top-
> level controls for wake events. Add optional properties to mark the PMC
> as interrupt controller.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt      | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
