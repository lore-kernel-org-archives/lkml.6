Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833232086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547588431;
	bh=ovtO+jZKePh7Xgx6e4+3bw8hXDJ/I83a2/nw6RwEXR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mgls7xu1idG7D4wObRSJD2JX2I8M0jhMN1n76m/JTyLZOB1SHF1So0Y/Fgwjqhm65
	 Rm0D6sKFfe3gcwPnuf2h0H3VQGNxmLixmsH5hL+14bQVGqj7BsYHi5rSyM0MW0wJPb
	 IxxBvzNXmmLntdt0d+PxAoQZGHR6KBm/jlsEXKJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbfAOVk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:40:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33484 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbfAOVk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:40:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so3405886oib.0;
        Tue, 15 Jan 2019 13:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S5gV17x4oTl0njUrPIb4oKxcW9iZO+WeMmVfD3Ki7HQ=;
        b=UIwHKPNvLl3eKtAbLFSU6VRmZuUJIrs6JfXEmOjJT3MUklMBYfs75sLBjtcDCCUy14
         xgNGDVewPd7SqyzN4WOM0MWVqfDmVrxcQj6RQl35h0IsQ+JzCrAoFCmTe4XTKuudUIzY
         31x3TvnRLnJVDTn3hHMwe6CnTluZ8+X8Bb1KNud8U8NG14y1k0L/GzzV3HrioiuZDcRN
         UgEMD5mLPmIFixq/95vlmkVZNBq16MAjDHkBWSPZLXr7dhIM0YKHFjjSOjteyuvLptbH
         FoaSGOB/vSZL40BpPqII1TjLCIe+i9bjEmG74AGZk2KnKP+QIH565rSELKocXmJcrX29
         gGEQ==
X-Gm-Message-State: AJcUukfvY9VmLQsJzR8mOhoNWqphXTBOphnbjwavVy0d826eXeHjN/5v
        jiBKT4CciTs4se2lVnJOxw==
X-Google-Smtp-Source: ALg8bN4KLYAh6iGyez5g9YaK1vYopoNMAw0dLx/d+ynT8L0y4ymNxTrBmZU4+oq/88DklmpumD2Zag==
X-Received: by 2002:aca:3a55:: with SMTP id h82mr707168oia.86.1547588428308;
        Tue, 15 Jan 2019 13:40:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r17sm2033412otn.0.2019.01.15.13.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 13:40:27 -0800 (PST)
Date:   Tue, 15 Jan 2019 15:40:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: fsl: add imx7ulp system integration
  module binding
Message-ID: <20190115214027.GA21610@bogus>
References: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 06:22:40 +0000, Anson Huang wrote:
> Add i.MX7ULP system integration module (SIM) binding.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,imx7ulp-sim.txt           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
