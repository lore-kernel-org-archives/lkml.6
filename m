Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8AAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB39208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB39208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbeGaVEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:04:00 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38869 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbeGaVD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:03:59 -0400
Received: by mail-it0-f68.google.com with SMTP id v71-v6so5946844itb.3;
        Tue, 31 Jul 2018 12:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ya/qzEE3diRZwyeXwG17NJU1cWSnDUU21fpFY33xMxo=;
        b=MTz27X2GyAqTuUKBl/xhlWOUMxdAG/Eo2ef37js+pUjWpDoTmoIOxCTqjT5IdY0LnD
         uFSw1yqkg5v5tY5ysUZeSzf7FKcpk8vrW4jfLBTwpUU3X1aeuOGbzOU5ha6EpjvcdtV1
         5GKJml6/6wfFm6TfkJS1Vq5707YsDKurqdFq6ve8ZEVNXCilwObzHhfETVWD6pv9N4ee
         dsyUNbUz2yQfaw+IgyxJogkJfQ7lhjQcw/SK/lVjUhFG1s3U+DBt08TQ15hlvx6uQW7I
         1wufQkcdKW8moIh0AxQCr54LodnRskltkyf10iG9wG2OEDXA3z9IY40LlYh3vOQXhDbN
         aLbQ==
X-Gm-Message-State: AOUpUlEqs8cAasbZMWUDf3A066PqIiSg+3htCCaGpIhw1p6nk8u1O/sa
        gC3nYRWDkjsJ9L9Cf3sQew==
X-Google-Smtp-Source: AAOMgpdK5ZIgJmUHYj5sxsc+u9SKGZHr/M44nPBjixRN4fjeMg3fvL3OyJD31yR+ZSqYsGoSJi97qQ==
X-Received: by 2002:a02:910d:: with SMTP id a13-v6mr18353316jag.14.1533064933804;
        Tue, 31 Jul 2018 12:22:13 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id n127-v6sm1871410itn.7.2018.07.31.12.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:22:13 -0700 (PDT)
Date:   Tue, 31 Jul 2018 13:22:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Erin Lo <erin.lo@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
        mars.cheng@mediatek.com, eddie.huang@mediatek.com,
        linux-clk@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: Re: [PATCH v4 04/10] dt-bindings: ARM: Mediatek: Document bindings
 for MT8183
Message-ID: <20180731192212.GA6510@rob-hp-laptop>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
 <1533015487-60189-5-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533015487-60189-5-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 01:38:01PM +0800, Erin Lo wrote:
> From: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> This patch adds the binding documentation for apmixedsys, audiosys,
> camsys, imgsys, infracfg, mfgcfg, mmsys, topckgen, vdecsys, vencsys
> and ipu for Mediatek MT8183.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  1 +
>  .../bindings/arm/mediatek/mediatek,audsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,camsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,imgsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,infracfg.txt    |  1 +
>  .../bindings/arm/mediatek/mediatek,ipu.txt         | 43 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,mfgcfg.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  1 +
>  .../bindings/arm/mediatek/mediatek,topckgen.txt    |  1 +
>  .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  1 +
>  .../bindings/arm/mediatek/mediatek,vencsys.txt     |  1 +
>  11 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt

Reviewed-by: Rob Herring <robh@kernel.org>
