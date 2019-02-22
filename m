Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE03C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFAC20665
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550867704;
	bh=d0iGF+fexo8DA3y8flVz4wEP/K1j/kb7J1yYW5arAeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LXTobNhqNPMtAmP4E888cuGWluuOuIWmYMkh2Jym8PJqVLWavvSaxhNxosTtZKc1o
	 1C/BnFu6vDC48iYAzhbjJjs+N/P2pvfF7Xp7TN3HTC4/L9syTbUYRYWs95l/l5rXdI
	 xY6mD0f4PNG5YGD9SobIEjMJTrV/h4CDTxb01bqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfBVUfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:35:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36641 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfBVUfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:35:02 -0500
Received: by mail-oi1-f196.google.com with SMTP id t206so2762440oib.3;
        Fri, 22 Feb 2019 12:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DPZubu+48opp2+sPVYdKlvqjiRKERF/rzD8rM9cu458=;
        b=dsTxe4lTAjYWeGG/vCd6pBgevPnBLsmmMF1YFQjnu72bwJ0JZxFk8xlbkxp7HSIofy
         AP+frZj/uYT3OA52vwvpUS0k760jgj/JN1igtDIi+npIb4la/Tkf72uvIqIuNeDWCdmK
         CWRyh+kPPx9/OZvkoHKvjlZxBBvN2TS/zeeLeX+NZniI0h6AIzaxF/0HGYkP3eIvK2CN
         aE4ciCnVhJHLCX6Toq9Phtwi4rSSbxQY30sZ+Im3JS7u6dsslixHnG8T5O4f33E5oa2C
         N3/uQi+mzDXor4zmR4VzzosLEaGaf0VyQvo4btrfVqaw/yCd7BBEGyavXfDYRNazwR2O
         /vfg==
X-Gm-Message-State: AHQUAuaoIaacn2OQ+moiKFyTUV+6e6o5FB5F4nWKDTO2SwG13Gwm17L+
        MiWLvHkzrD0BHsxAQNDZEA==
X-Google-Smtp-Source: AHgI3IYCLHRg9UosyCtzmBsC2Ea0LCRzT3Emgz+uhvJF/FOBSJzUNdVLFPagtHfOj25g9CuXKqZArQ==
X-Received: by 2002:aca:cd0c:: with SMTP id d12mr3745860oig.49.1550867700924;
        Fri, 22 Feb 2019 12:35:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l6sm936359otf.63.2019.02.22.12.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:35:00 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:34:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci  reset
Message-ID: <20190222203459.GA16999@bogus>
References: <20190219072358.43493-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219072358.43493-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 07:23:14 +0000, Ran Wang wrote:
> When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> (or its control signal) will turn on immediately on related Root Hub
> ports. Then the VBUS will be de-asserted for a little while during xhci
> reset (conducted by xhci driver) for a little while and back to normal.
> 
> This VBUS glitch might cause some USB devices emuration fail if kernel
> boot with them connected. One SW workaround which can fix this is to
> program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> host mode in DWC3 driver(per signal measurement result, it will be too
> late to do it in xhci-plat.c or xhci.c).
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v2:
>   - Correct typos
>   - Shorten the name to snps,host-vbus-glitches
> 
>  Documentation/devicetree/bindings/usb/dwc3.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
