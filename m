Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E045C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D8A213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D8A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeJFDxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:53:49 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34757 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFDxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:53:49 -0400
Received: by mail-oi1-f195.google.com with SMTP id v69-v6so11502321oif.1;
        Fri, 05 Oct 2018 13:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WkJuI2uBMKXzxYtz0EkNUwH2uD1hlqyiltXRioWeLkM=;
        b=Lz2OA/0LDDP8z62QFkwMh68aMSk2IQtfbYOIbFYlcAFV7FWo3TJsxoss/YTvisyHsZ
         Ot7djH0yJTY4r5KDo5h2P2haifymV8+YM3Pe1IKkTe0WzXnjQdfOvW0MYH364RDlXPys
         JVvMt9blBul+0MRFaaDBMKcEflP6+vCACMFnSAZ2pn5RwOOs1PvbssbFP7IX4RA6/QIF
         MnKSyRZzyMSh78iMuh43k0O07cimIcaDdYtlnMF4NMoz88Lmf3gcvyNMvnfZBOj8S2o7
         mpZo/aJvI4KIT15nKqRL3p5kvK5t23JCj6UqU1zhgkM/91N5O4YEQ+Bps8UNXTvRN8oz
         P4+A==
X-Gm-Message-State: ABuFfoi3EI5hv/Wj+Kiu0dEBDhXR828Ek3aU7HLiJThmFOBLx8VKhiBQ
        oe4Cxjw4BMWyp7R+EfESHw==
X-Google-Smtp-Source: ACcGV611aNu+H9eNA3RLXeCrjnRgMtMPjULZlIq1OuECevUqY/juTejL3q00do7jgOi5y/WgT9aOeg==
X-Received: by 2002:aca:c656:: with SMTP id w83-v6mr318029oif.122.1538772803220;
        Fri, 05 Oct 2018 13:53:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 107sm1976858oth.20.2018.10.05.13.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:53:22 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:53:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v4 01/10] dt-bindings: phy: add binding for Allwinner H6
 USB2 PHY
Message-ID: <20181005205321.GA2217@bogus>
References: <20181004122855.22981-1-icenowy@aosc.io>
 <20181004122855.22981-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004122855.22981-2-icenowy@aosc.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Oct 2018 20:28:46 +0800, Icenowy Zheng wrote:
> The USB2.0 PHY on Allwinner H6 is similar to the ones on the ones on
> older SoCs, but with holes in PHY number (USB1 and USB2 are missing, in
> which USB1 is a USB3 PHY).
> 
> Add binding for the PHY.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> New patch in v4.
> 
>  Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
