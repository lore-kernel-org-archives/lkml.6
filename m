Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C356C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA96217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550520294;
	bh=E2X6O+YDjSc+lcai9OnPeZVP03lgquOnVRBJ5Y2rtGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F9xwOIBleGYh5/sIFNC2mYNXIVQupO5SRjTo3FwB7xvZP2ym/kfpGpT/KtECMO3Wr
	 D3kd/ZSpx22zHO54S1RM5IxSrxN7Avb4swAjClROwyq7ZDA6JiitadPyS/7cbEJnDe
	 pBPMykwv90P0KWZZLB96geq8v/FEgPdMA6jXmNmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfBRUEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:04:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46213 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRUEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:04:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id c18so8761564otl.13;
        Mon, 18 Feb 2019 12:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B+x2incSj0C+DkTX95+6ke3OKgtXf3toGQqasEk4wj0=;
        b=hAdI4GRX8we5xVakhmKUeIcN2e2AeA4SwuTGYIwlQNdfdhzyvOA9kO6WfaY6vyB5Fh
         S23Zi6x5mBqYTrl1zYZUB80ME0j+6Ut2fhtT99rAfWONA9NM5xUGhKJVp4afCgLjf8Y9
         YT8VSQ71Y53xwryIMpOPM2oGB8wVbGAUL3l/gQqm9SLgrpSPk3miVZAWFSTQVN63BtGc
         vOnqqiJR4B4ZNt9pU7UnzD3t9RgjAA+nZQ0kzuFoB/wiqH4HA21roppJipIHjQNSvDTG
         wqAwtIjy0SBsD/RkITq0zre6cI8TydD25sDa8du76zX8LVoKGYFFhrK965OYqxfH4ACM
         AulQ==
X-Gm-Message-State: AHQUAuat4cQPNzg1gh4SZ90PEZnLR+wLHC/vJvAw1dfLfM4l3mVvSXEd
        eavjuIgp9V6LaKHyjGT8Qg==
X-Google-Smtp-Source: AHgI3IaeCnhJ+xDVtm0C4DG88T1M6FFfqfTSOqkVbUM6H7bpEzeTS8bkg0x3DQnpzVVrVUgjqvYdSw==
X-Received: by 2002:aca:3506:: with SMTP id c6mr343700oia.65.1550520291652;
        Mon, 18 Feb 2019 12:04:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm2909281otx.57.2019.02.18.12.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:04:51 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:04:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 3/3] dt-bindings: clk: at91: add bindings for
 SAM9X60's  slow clock controller
Message-ID: <20190218200450.GA3545@bogus>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
 <1550146447-1441-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550146447-1441-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 12:14:36 +0000, <Claudiu.Beznea@microchip.com> wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add bindings for SAM9X60's slow clock controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/clock/at91-clock.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
