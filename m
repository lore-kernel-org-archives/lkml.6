Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A076BC71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725BC20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725BC20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeJPCK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:10:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40957 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeJPCK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:10:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id w67so19868591ota.7;
        Mon, 15 Oct 2018 11:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oq43vtlkbYWB7pK6FkCemibiHF9r0jHPeCXJnjPgNS4=;
        b=nhzOtNPKJzsLij/FQAY9wvm5z5gQ3S4RVK3Re2PZtgrEpfKq0drmfci0OM4P4W5h48
         ziwz3HdAsgs22caYWtOC4EpcSUyFywgwbrtOMw5XCy/V8srjx98dE1OtdvKK8WAY09HE
         VUGdvK2PW8Q2jyMaJXjRtO5YK/HIp/26WhFHWcNg3+fy/64Z9vmF71znotmaKoEWoMTa
         GsM+NVY21e6Vuroyn8N7RTBcrMeCp5h0OHWxTeCfsQZCNAvjTjB2sjZAJ9g88lj7kwIA
         KeAXiEz8d0JJaVXb1g+n1HNWXp8UpET7nLp9TAtRo5H+igptMdwoo6tARUon5aDjQ/jG
         6BMA==
X-Gm-Message-State: ABuFfohWyV2G+c4OwcgdEElcFuvyu33mQJAneWM71bXxNlRMMGIDHyZL
        TnVtQUOPtXNfYEBo1xRS3A==
X-Google-Smtp-Source: ACcGV63pYg8eREe5HFg1fq+FEdwQjFF/Av05a5gQonjA4h/7iyyKxYXyUa1yRv97VBRTmLuBkRlZGQ==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr12251183otl.57.1539627843917;
        Mon, 15 Oct 2018 11:24:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 31sm3603402otw.41.2018.10.15.11.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:24:03 -0700 (PDT)
Date:   Mon, 15 Oct 2018 13:24:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 03/12] dt-bindings: sun6i-dsi: Add compatible for A64
 MIPI DSI
Message-ID: <20181015182402.GA5988@bogus>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927114850.24565-4-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 17:18:41 +0530, Jagan Teki wrote:
> The MIPI DSI controller on Allwinner A64 is similar to
> Allwinner A31 without support of DSI mod clock.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
