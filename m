Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8314C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FC22147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FC22147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeJQG3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:29:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45385 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJQG3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:29:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id e17-v6so19480300oig.12;
        Tue, 16 Oct 2018 15:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kJXyNQ1ZclFXvhkJH2uwYDLtoF6paPKzQPh6/jU17KI=;
        b=PWGe6KfBzAoFbL1sZ8UbUYu6iMk+TqILlceHtS1o22K99RTO8OTx+hKyjIwXecT/X0
         S0K+IFNehI3ICAxJOaSWqmkZ5L7OU4exmD4yQmsgIjYDYTxOqol/sr8L9TpNiYXK+GrB
         5enTwcbW0IPjV7QSuXxLbWE2movu+7WiLuyR1W6PGE/fC2XkJ4GefFRs4DkDFUoIDnUE
         ZYZVT2lrOGJIFdaNux4wCzpwD0qwix+57XqEeglXsdw0A4CoGKJXSVZO6B7TXlqmgAvr
         XO/WwLsTpNLIrl81FfK4EXhK/Mi5Tz2+5GsjRQBsLocBvu5JGDpz4GKsLqrJP4kww7xl
         XKkw==
X-Gm-Message-State: ABuFfoiTCfSP2q5NZesCSzkKLdS1ckugz8ZfBhL50YSLT4hrASc78s7p
        +D3CIWs5wiqs+XEPaWg4OIqxJ0c=
X-Google-Smtp-Source: ACcGV61aGptQR0HwIsGe+v7jU6oxY/ENFVct+FkUp6QrH5U4I4+GxBpDm8oPK5MtppwMALJ573aUpQ==
X-Received: by 2002:aca:3d56:: with SMTP id k83-v6mr12062761oia.61.1539729392672;
        Tue, 16 Oct 2018 15:36:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j2sm2814893otc.54.2018.10.16.15.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 15:36:31 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:36:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: add stm32 qspi controller
Message-ID: <20181016223631.GA19725@bogus>
References: <1538725383-19781-1-git-send-email-ludovic.Barre@st.com>
 <1538725383-19781-2-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538725383-19781-2-git-send-email-ludovic.Barre@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 09:43:02 +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds the documentation of device tree bindings
> for the STM32 QSPI controller. It is a specialized communication
> interface targeting single, dual or quad SPI Flash memories (NOR/NAND).
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/spi/spi-stm32-qspi.txt     | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
