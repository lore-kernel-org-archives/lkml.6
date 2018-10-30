Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11A0ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710E920657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710E920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJaFSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:18:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44123 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeJaFSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:18:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id p23so12416005otf.11;
        Tue, 30 Oct 2018 13:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bOGfN6i375narpU7QEV+CpWx3UuRtr8z7uHQPY1YUUs=;
        b=UzBE7ghmn76/lP7U6BYLHiNogvzBSnUxGBfuR/M9Vh29iqiyDE+wUZS0EnxHOb4Zq2
         ixAD13vFCic9gchLRtxp63LW2QUhoBC+y88Q5l9saa+E1c9Oz67HFgfkeTIIWYo5tWqp
         UT4Ul27XXW+HEeW25ms3o21iZt5FkDYhWarZGwDRasiCMi6kw7X1Ftu0bd1AL8oaYDbG
         XdWaqv+4zMdxiK8QOTUF9UGprqSMHAMoWP/lxtAyJVP26FiEC3V2KVNjNpR9emSg9qsn
         m9yCEUsjYiHMuAkKCZQPxcWDQJBd0C1FsEnQadKwVkk57/ICvBgxd372IIINFwRBqD70
         FXmQ==
X-Gm-Message-State: AGRZ1gIg+IGR3yUUnfL64TNIxxJPmrs4MqCCLdlsa0ITzH9Xoyw0w0Zt
        Ziq0Nqd3l3qaJJEPXyJFrQ==
X-Google-Smtp-Source: AJdET5eTH3z9+AQolGsKOMtnYHjzrdwpjFhGv5vLOWM3V+1qkarvZQQaAGYC3VVVNYc3lCJ2REsfpQ==
X-Received: by 2002:a9d:55db:: with SMTP id z27mr154873oti.288.1540930988963;
        Tue, 30 Oct 2018 13:23:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 65sm9781317ott.63.2018.10.30.13.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 13:23:08 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:23:07 -0500
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
Subject: Re: [PATCH v3 17/25] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
Message-ID: <20181030202307.GA13705@bogus>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-18-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026144344.27778-18-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 20:13:36 +0530, Jagan Teki wrote:
> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
> bridge panel, which is available on same PCB with 24-bit RGB interface.
> 
> So, this patch adds DSI specific binding details on existing
> dt-bindings file.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - Use existing binding doc and update dsi details
> Changes for v2:
> - none
> 
>  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
