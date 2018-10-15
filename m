Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D5BC71138
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0150208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0150208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeJPCLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:11:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46238 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeJPCLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:11:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id k64-v6so15849999oia.13;
        Mon, 15 Oct 2018 11:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RobSL7XGuLEyO5xKg9D0ti9B2XzYKcBMnyQjErhWyvU=;
        b=P8f+wBHWYw0w9maTHtLQsN2IKgbiOS59pFAQ42p72SeJ7xMRyoKrA9riliKXEphmz6
         6fB19LMGNWvtrXx1FFQZ81wVYyjy2VVC7gaksOOeCLGkWSyAkgqXWAADd+e6sxjyOrUP
         N5+p6SEJ8tu+Av+fGffmX8HdUhOdNDlCcTwm/fXEB8FbEYNc+NUmE3HBPp5BlRzeYUbW
         dC6V+7EuKVdGnt7Du0T8EuFxQJ7TWOggxMeNzoTN7V+XZN3W+bARyMpar1xHGb9dP7I9
         ld60SFRodCmi3zE5XlZWUlJVhxFfxq0NOu3cV/cmYMtGWyNWI7kHWxamA4sDVzDsaYVM
         sz9g==
X-Gm-Message-State: ABuFfoiXtxUoqV0vUj22mhGTxLMkbSs22mtS78fk5E08dFpJdOh5aSbA
        zPBeHw7bLIadm/fxlMa4EQ==
X-Google-Smtp-Source: ACcGV63iNQV0GCFf6Zi9U42PglE/E1Sd/VHW9gN7vfC0/lUZg8LZR83muVKoo783gjFRkxsIfP7m2Q==
X-Received: by 2002:aca:cc12:: with SMTP id c18-v6mr9507739oig.150.1539627890348;
        Mon, 15 Oct 2018 11:24:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g36sm4495817otd.66.2018.10.15.11.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:24:49 -0700 (PDT)
Date:   Mon, 15 Oct 2018 13:24:48 -0500
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
Subject: Re: [PATCH 09/12] dt-bindings: panel: Add Bananapi S070WV20-CT16
 MIPI-DSI panel bindings
Message-ID: <20181015182448.GA7134@bogus>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-10-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927114850.24565-10-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 17:18:47 +0530, Jagan Teki wrote:
> Bananapi S070WV20-CT16 is 800x480, 4-lane MIPI-DSI panel, the
> same panel PCB comes with parallel RBG which is supported via
> panel-simple with "bananapi,s070wv20-ct16" compatible.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../panel/bananapi,s070wv20-ct16-dsi.txt      | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-dsi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
