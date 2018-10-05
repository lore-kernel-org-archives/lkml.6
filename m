Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FCAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F493213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F493213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeJFDXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:23:25 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40543 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFDXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:23:25 -0400
Received: by mail-oi1-f193.google.com with SMTP id j68-v6so11420841oib.7;
        Fri, 05 Oct 2018 13:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mf5dtABVGmRHw/YQw/K0P54g+5mov2I/aLbLbm3MGlw=;
        b=bOu8x/J7hzzs9GHgYgRcY2OsYLidA+Ie1n1ujjUWo+6OPBcP4OYatxyHqaOf7EEeO4
         AGCqxWNkeD+LF/mV1h2bsVpSIptE3kwMfSkfKio1xVlRGJbpHSX2JzWFbVhVwaNxBTXe
         FRpHUWsiBYppSU48URDoKD2jFKdoC8/OjaT82DgFXPTSl2a3YzOdWcB9H62hX7KGQnkl
         0DZfKFKCn6C3RBf3P1VsNbkoiFqFHrlYuT2FaJz6Ohh9Wk93XXafe+yDErmyoS9TPtbe
         wMzKgtHqH8SxtxN+Wel9x4aDzEwha6lro4ZkO38CbTEtUSAo7f0ANep+dGvIwvqQGfO3
         MbLA==
X-Gm-Message-State: ABuFfogeaPWuzeoYJN2xM7iriBd/SBNCr+qFBvW1kARDh7OHtpvadMZb
        FqH+rpEIcKAkWqbHQ4AbPQ==
X-Google-Smtp-Source: ACcGV61dA0+1f9ojCUS+0prFpYJanNYFxa6wW9P88B1b5HPQUna0wk15Nw6wVVUl1l0hN6KIvc0OVw==
X-Received: by 2002:aca:6a48:: with SMTP id f69-v6mr270801oic.279.1538770985555;
        Fri, 05 Oct 2018 13:23:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s203-v6sm2813400oif.33.2018.10.05.13.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:23:04 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:23:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        daniel.lezcano@linaro.org, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V10 6/8] dt-bindings: timer: C-SKY Multi-processor timer
Message-ID: <20181005202304.GA26220@bogus>
References: <cover.1538672812.git.ren_guo@c-sky.com>
 <98c73d601d7ad98993ecfe8d8ce4b5abbc07e4da.1538672812.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98c73d601d7ad98993ecfe8d8ce4b5abbc07e4da.1538672812.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 01:22:26 +0800, Guo Ren wrote:
> Dt-bingdings doc for C-SKY SMP system setting.
> 
> Changelog:
>  - Drop the interrupt-parent.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../devicetree/bindings/timer/csky,mptimer.txt     | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
