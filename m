Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71697C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208C7215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208C7215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeI0Xyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:54:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43489 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeI0Xys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:54:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id s69-v6so2875923oie.10;
        Thu, 27 Sep 2018 10:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZd70GJELwHNZNCIL4XjmIsm7lLpANr90XzdeDYRo/8=;
        b=D0QUL5AMQRj4mWXTgXhfear9NqU5jGa36xTM6RQMX03asWyOA04LAW/RA5JicWry37
         3GjHU+nXW/T4zPWyr2P8vhCTftDV0l37kQda+SIat0z6EDDhlp2s9mBRkOsURsW60tSJ
         LBDLv+3gq31rIl8Ho3PmvbPMsMuvUyMSeXK9G1X7ah41LbJIfymmhquOZFPnJKkfmKCs
         E5rnZVCWquO4YdkJsniBFq8S2Y4TTO84pJFYdJNI7A0jp/LOXgED1eBWXT5FZmE+r6cu
         RjoWgjLqiOR3DydSBwyCSfc7JOpBee+y5RKXS06JALo/sKxiWFDJbUFMr6blOGDlWt3+
         0zDg==
X-Gm-Message-State: ABuFfojAB7JF4U1j5HWdeC52JCYfJvzMgsW/27FFyceeox6tWTfWyT/J
        uHDAWNSy0KrVs6VykxOx/w==
X-Google-Smtp-Source: ACcGV60Kze8WYEDzVOw/JNj5Pt9441LoVm4adMxS8sihmKH/CddPAvuz3RM5WGKy21N6a90qKMziBw==
X-Received: by 2002:aca:4802:: with SMTP id v2-v6mr3578555oia.259.1538069727191;
        Thu, 27 Sep 2018 10:35:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f5-v6sm627315oih.51.2018.09.27.10.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 10:35:26 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:35:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        green.hu@gmail.com, palmer@sifive.com
Subject: Re: [PATCH V5 25/30] dt-bindings: timer: C-SKY Multi-processor timer
Message-ID: <20180927173526.GA26777@bogus>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <d8f95c8a3be94d29611eccbeac51a3b74e5f570e.1537789737.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8f95c8a3be94d29611eccbeac51a3b74e5f570e.1537789737.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:39:28AM +0800, Guo Ren wrote:
>  - Dt-bingdings doc for C-SKY SMP system setting.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../devicetree/bindings/timer/csky,mptimer.txt     | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/csky,mptimer.txt b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
> new file mode 100644
> index 0000000..1e7e31d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
> @@ -0,0 +1,46 @@
> +============================
> +C-SKY Multi-processors Timer
> +============================
> +
> +C-SKY multi-processors timer is designed for C-SKY SMP system and the
> +regs is accessed by cpu co-processor 4 registers with mtcr/mfcr.
> +
> + - PTIM_CTLR "cr<0, 14>" Control reg to start reset timer.
> + - PTIM_TSR  "cr<1, 14>" Interrupt cleanup status reg.
> + - PTIM_CCVR "cr<3, 14>" Current counter value reg.
> + - PTIM_LVR  "cr<6, 14>" Window value reg to triger next event.
> +
> +==============================
> +timer node bindings definition
> +==============================
> +
> +	Description: Describes SMP timer
> +
> +	PROPERTIES
> +
> +	- compatible
> +		Usage: required
> +		Value type: <string>
> +		Definition: must be "csky,mptimer"
> +	- clocks
> +		Usage: required
> +		Value type: <node>
> +		Definition: must be input clk node
> +	- interrupts
> +		Usage: required
> +		Value type: <u32>
> +		Definition: must be timer irq num defined by soc
> +	- interrupt-parent:

Drop this. It is implied and could be in the parent node.

> +		Usage: required
> +		Value type: <node>
> +		Definition: must be interrupt controller node
> +
> +Examples:
> +---------
> +
> +	timer: timer {
> +		compatible = "csky,mptimer";
> +		clocks = <&dummy_apb_clk>;
> +		interrupts = <16>;
> +		interrupt-parent = <&intc>;
> +	};
> -- 
> 2.7.4
> 
