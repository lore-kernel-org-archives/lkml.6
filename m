Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FA5ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAA720664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAA720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeJaFW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:22:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45229 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeJaFW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:22:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id g10so1379469otl.12;
        Tue, 30 Oct 2018 13:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Zd7eGUaOP7Hm+eTjWZlL4Elkwa0b9qjlU2Ei8d3yBw=;
        b=f5c2HZ5++UiYkuyas764UvFvcFbH7fG8jMIoqAVTRvPhXN0DR+UHFVNh9j/hCNrMGS
         niKGPeJ79q2HhtgfCwZx96Q04hPsL638x7uSWXGe8/z3CCaabzUA3tY8h+lmdTb0NGEN
         dBpMhH6/QzViLtzC6B2dc1Ef/nscIG9Q5SpQp8uPoJWJZ1CA9nCNOyC5II2r6PZuJ1UJ
         UPeGXXWBZVcTa1p1lsbvTfImitgDkEuhDDRf9t9s0Ui6+7t/knIPC0/NzyGbMVFw31PG
         VgkbBGSahfBBlCHwq3BkrkatS0QCXFpTC1jST9gke6M8mJKqAVSEfpf8DDOR+BLZRFLZ
         s1zg==
X-Gm-Message-State: AGRZ1gLqdHl1evSjrYw3KtlenBo2i6NC5ycCsgGucRv0jWtXS6ofW/M2
        KYkdE0a7W3E1FOkIoRpYQg==
X-Google-Smtp-Source: AJdET5ezwMCObQdKf/OBJQj+XEw+nPBSqyMRs980jn6DjdAUbNCN6sYA63WoC1FfnSy/IgMYEINj6g==
X-Received: by 2002:a9d:29f2:: with SMTP id g47mr153585otd.200.1540931250329;
        Tue, 30 Oct 2018 13:27:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t125-v6sm4520159oig.31.2018.10.30.13.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 13:27:29 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:27:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 19/25] dt-bindings: panel: Add Techstar TS8550B MIPI
 DSI panel
Message-ID: <20181030202723.GA20468@bogus>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-20-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026144344.27778-20-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 20:13:38 +0530, Jagan Teki wrote:
> Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI
> LCD panel. Add dt-bingings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - new patch
> Changes for v2:
> - none
> 
>  .../display/panel/techstar,ts8550b.txt        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
