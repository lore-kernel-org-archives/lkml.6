Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39966C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB80921564
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB80921564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeI0DvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:51:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38160 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeI0DvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:51:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id h15-v6so495388otj.5;
        Wed, 26 Sep 2018 14:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQ1yHFe0s9a+dWmxjQ5HtbHvWZyPUcQrC220Vlus2V8=;
        b=dk/C3+2ihd9oNcCtYFBfi8f/A83atInyL9y9buCCaGSvvA7w4OtIAhvn/ey/gLv4mb
         ufaGp67uq8QyWvPn3mWq/mhuIzto2dOif90aHeUBktXWTx/orPnihVF190ZR8msHa34T
         A1TgX5qKNE6KyjVYVTw9EwzLj7CxI7bJXyGAZ4fYOd5jAs6gbAWk1QlMTXqzDTpbpDl4
         X6whTDubMv4iBtk/6R90AaWDOvTMUz5ybA/vyE+YJbtEnSD33kuQPPJQTl7m1vO1flGo
         EyrUdkpFqLoAkCsaouCvZp7EHfa5aDUh+EAgdcDfeLsexhujMz7/ur9oZ/bSNmhNnm3h
         DMxQ==
X-Gm-Message-State: ABuFfoi+mXJk+So5goO1mIJ7APPNmdnPUrqTaLHvQ1veADsOInn+gatj
        HPoX9OWm7G7yh219WrNF4A==
X-Google-Smtp-Source: ACcGV60Xoql9fyn2Ahz5aWxOU5iPnAEFGl/84qgUqMvfZhgP5lY1kU6ZMuLKho5zXoAbrh3qgDPVAg==
X-Received: by 2002:a9d:892:: with SMTP id 18-v6mr5783164otf.269.1537997786136;
        Wed, 26 Sep 2018 14:36:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m7-v6sm52400oia.32.2018.09.26.14.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:36:25 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:36:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH net-next v3 09/11] dt-bindings: add constants for
 Microsemi Ocelot SerDes driver
Message-ID: <20180926213624.GA13387@bogus>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <73113ea4b3d8d34c05d88413b3d15cc1733cf25e.1536912834.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73113ea4b3d8d34c05d88413b3d15cc1733cf25e.1536912834.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018 10:16:07 +0200, Quentin Schulz wrote:
> The Microsemi Ocelot has multiple SerDes and requires that the SerDes be
> muxed accordingly to the hardware representation.
> 
> Let's add a constant for each SerDes available in the Microsemi Ocelot.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  include/dt-bindings/phy/phy-ocelot-serdes.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-ocelot-serdes.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
