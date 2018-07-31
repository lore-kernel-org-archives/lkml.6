Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433DFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC28B20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC28B20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeGaX2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:28:07 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39355 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeGaX2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:28:07 -0400
Received: by mail-io0-f196.google.com with SMTP id o22-v6so14346783ioh.6;
        Tue, 31 Jul 2018 14:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nn70vAIwPg5ECjY3qz93XBGg5M8ghBh72HIAT0em6Gc=;
        b=dIXIRPXiASEuTW7A08eKXZlzmTEKheZJH+m7nvl9QbpqVYT5R6cilEHEYFNvmBnJCV
         4MaiL+QMjFpK/G0fxel/9mGVMOmKCXZGOPRiAZ+W3zRSoDdgRdsxHzhtdLIdT6/WKxTP
         KxvkkVQPiqoE90IkNFNunW343iTsnBkjbFxFKyLZj1bebT/i0ULQBwx1sscPF1AtfYnI
         coZvUSgWFlr6pSvifW66VweZN+P6CbhyapPGcbghMIw9nUi1pEycHDWkUcbkuOPrQpYI
         a8hMWkNI97w8cwabGxqiZUgqRsFHfKgRi/1xKVH+FkKKDbyT4jIEveUmBhPXeGHTbKjt
         GKZQ==
X-Gm-Message-State: AOUpUlH/DT/+2uztFN27K5fgDqPcT0xfYRVbfx07jdy8Pmt/lCss7RRB
        JhB/y0TKjFnTmpfYFDteDw==
X-Google-Smtp-Source: AAOMgpc3bMMG22innU7JU2pG2+W6LPl90QVVp1c2PFFuxEkXtAeUvhrURH/1E0u8TIlW+rgXlX04SA==
X-Received: by 2002:a6b:ef08:: with SMTP id k8-v6mr1268057ioh.12.1533073546242;
        Tue, 31 Jul 2018 14:45:46 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id e19-v6sm4997386ioc.46.2018.07.31.14.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 14:45:45 -0700 (PDT)
Date:   Tue, 31 Jul 2018 15:45:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 12/15] ARM: tegra: apalis-tk1: add
 toradex,apalis-tk1-v1.2 compatible
Message-ID: <20180731214545.GA19887@rob-hp-laptop>
References: <20180724104309.21741-1-marcel@ziswiler.com>
 <20180724104309.21741-13-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724104309.21741-13-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 12:43:06PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add toradex,apalis-tk1-v1.2 compatible.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/arm/tegra.txt | 2 ++
>  arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
