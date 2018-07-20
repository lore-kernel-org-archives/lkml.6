Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28771ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC58020652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC58020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbeGTScw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:32:52 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54948 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387855AbeGTScw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:32:52 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so15729142itb.4;
        Fri, 20 Jul 2018 10:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zhIFmiBWTjfGbbp7avGy699asnvN2tyhu2OJt3MxG+E=;
        b=bHhHRJ6jDOTjscU+4FvqfOrWaQA6kDiqqldQitI7JytKm8RMa5XrnUHxkePGrMxPlH
         MP/yu4rfkDe4g8GrFQvK0oKnKfLdw2b/vsp3BPShaZt7exUng6/QacckAtAtf69MZcVn
         /yT9F8PyuESUvUut+Owzx6jvgdpQLFoj0/FfjndlICPbZXjs7621XRN6pafOUMLMy8Ni
         19+4Mi+NCy4CZDXpHFi0cUc7AMrTo+UU/RlvlhhlQnysdERhshzSyT3gqfZizB/ibRIg
         iYn5WRhw3br2xZwXkjXS3VCQLJmzn7j9HA4l8Hs4h1quQgki7D1U389tClM6bCnBjvmG
         Nxeg==
X-Gm-Message-State: AOUpUlHvbjOysR+x10O3JGRjwBe8KFpiwL79HK2zIKMfMcg68U8LCcjh
        00g+SNqTd/ekRISoHjiIpg==
X-Google-Smtp-Source: AAOMgpdBEJS02VuEq2KWL4ZiYZeHZN8wijs6lh+WTM2q+0weWaJErbmaFbI5kA6gkliI7qLJqipUsA==
X-Received: by 2002:a24:5d45:: with SMTP id w66-v6mr2535487ita.121.1532108613550;
        Fri, 20 Jul 2018 10:43:33 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id d12-v6sm1043962itf.44.2018.07.20.10.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 10:43:32 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:43:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Owen Chen <owen.chen@mediatek.com>
Subject: Re: [PATCH v5 01/11] dt-bindings: clock: mediatek: document clk
 bindings for Mediatek MT6765 SoC
Message-ID: <20180720174331.GA26945@rob-hp-laptop>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
 <1531817552-17221-2-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531817552-17221-2-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:52:22PM +0800, Mars Cheng wrote:
> This patch adds the binding documentation for apmixedsys, audsys, camsys,
> imgsys, infracfg, mipi0a, topckgen, vcodecsys
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
>  .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
>  .../bindings/arm/mediatek/mediatek,camsys.txt      |   27 ++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
>  .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
>  .../bindings/arm/mediatek/mediatek,mipi0a.txt      |   23 +++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
>  .../bindings/arm/mediatek/mediatek,pericfg.txt     |    1 +
>  .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
>  .../bindings/arm/mediatek/mediatek,vcodecsys.txt   |   22 ++++++++++++++++
>  10 files changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> index b404d59..44eaeac 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-apmixedsys"
>  	- "mediatek,mt2712-apmixedsys", "syscon"
> +	- "mediatek,mt6765-apmixedsys", "syscon"
>  	- "mediatek,mt6797-apmixedsys"
>  	- "mediatek,mt7622-apmixedsys"
>  	- "mediatek,mt8135-apmixedsys"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> index 34a69ba..9a8672a 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> @@ -7,6 +7,7 @@ Required Properties:
>  
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-audsys", "syscon"
> +	- "mediatek,mt6765-audsys", "syscon"
>  	- "mediatek,mt7622-audsys", "syscon"
>  - #clock-cells: Must be 1
>  
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> new file mode 100644
> index 0000000..dc75783
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> @@ -0,0 +1,27 @@
> +MediaTek CAMSYS controller
> +============================
> +
> +The MediaTek CAMSYS controller provides various clocks to the system.

Only clocks? If so, then this should be moved to bindings/clocks/.

> +
> +Required Properties:
> +
> +- compatible: Should be one of:
> +	- "mediatek,mt6765-camsys", "syscon"
> +- #clock-cells: Must be 1
> +
> +The AUDSYS controller uses the common clk binding from
> +Documentation/devicetree/bindings/clock/clock-bindings.txt
> +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> +
> +Required sub-nodes:
> +-------
> +For common binding part and usage, refer to
> +../sonud/mt2701-afe-pcm.txt.
> +
> +Example:
> +
> +camsys: camsys@1a000000  {

clock-controller@...

if the above answer is yes.

Same comments on the other docs.
