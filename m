Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C67CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F67220842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F67220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeIZDS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:18:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35804 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIZDS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:18:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id j9-v6so25957489otl.2;
        Tue, 25 Sep 2018 14:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tpsnErnQh/oGX3Tak2SXuumOWaKek1lpfVHBykQOuDY=;
        b=Sy/3SxcO+W2JM/Zwk9EQB77bijsShs+QOZMCZAwKrMolwXiVz9PZ8RH8GKCPkFzncw
         OOAvBm3/rrzrvsr7OiaZef2DkymCUitowsYDk7VgqcILynmBcVUHPbDgg8UiM9FFhcXv
         qtp4mwhsANAq4qAFZnptDmJMMjMf5EzCU5jVE5myWs0/Pg71PBuxunhidKnAxBoFwgFj
         VNZ2MqYuTu2OUR1L7DJcULGC/Q/yIR4FxkTt8b3U0KIRfV/D8IXOIvBsUojHhm4OIXtv
         HDLoB5Dzue6H5V3xUp7hf95a4uuj+c/bxOMBO7G1Hd96s00ca/4AOCcz45vqmg3rDGQk
         qiAw==
X-Gm-Message-State: ABuFfohA2BjMANFTAchRTVK8fbIqShyXZLslaL9A64vAH+XZUMp3nIsx
        +6YbsyxqLm64JTAos1uwoy2351r+PQ==
X-Google-Smtp-Source: ACcGV63Z6MLv5Kyy6lmytkPQqFQ0IMSCsLUr9JwZPTGcz3dOekiTgDmVPUhQAxFhnBfC8wYSivV2Yg==
X-Received: by 2002:a9d:750d:: with SMTP id r13-v6mr2004955otk.108.1537909741651;
        Tue, 25 Sep 2018 14:09:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g18-v6sm1223404otd.11.2018.09.25.14.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:09:00 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:09:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Moritz Fischer <mdf@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fpga: fix freeze controller compatible in
 region doc
Message-ID: <20180925210900.GA30292@bogus>
References: <20180906180152.3620-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906180152.3620-1-atull@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:01:52PM -0500, Alan Tull wrote:
> Documentation/devicetree/bindings/fpga/fpga-region.txt has an error
> regarding the freeze controller bridge, secifically:
> 
>  compatible = "altr,freeze-bridge";
> 
> The compatibility string should be "altr,freeze-bridge-controller"
> as set forth in altera-freeze-bridge.txt.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> Reported-by: Dalon Westergreen <dalon.westergreen@intel.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied.

Rob
