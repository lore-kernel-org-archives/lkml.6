Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F958C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4177121715
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdhHN8ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4177121715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeHML5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 07:57:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46303 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbeHML5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 07:57:20 -0400
Received: by mail-pl0-f65.google.com with SMTP id t17-v6so6640107ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lIvBvkAVZ0SXYTkc194Qdv+vdu6sjb9S4BnY1Zs4Qro=;
        b=PdhHN8ql8q3RdqnYmPcN/DwMAbTdJLO5ZE0mXEAO4zMOk4CyPUOnGloXNQ3wk/T8mx
         dXOhqJiPHeOZEdRTHXpBrDyJbMz6h+eNL0ay1Zo1iivtwCKzMqvZqVJMvQinAolpW5s6
         /czJaQyKXdy4znMfg31uhbXWxWjDHCaxIKvCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lIvBvkAVZ0SXYTkc194Qdv+vdu6sjb9S4BnY1Zs4Qro=;
        b=Sza/it+OjOpmhJYyYZo5Bf/6qAocWY1YVVlFhS63hf8r6FHEySElQHUp0+CW/YjA/9
         sbKBOLh0Ke+Nhi4rD/Omq2UfKrwjkLcTSwAEKUprvOyJev7bcVac1a7Dhv8WatrjviBI
         tT+QMWlFruwWqjvctbd9fzbeZ+0esQSSFQD68hV/2KmOyeQjJectHGHdPuIwOsC3il5v
         3TjZSlPo7oR76BLkE02kcKzwe1ptpNaHmcfe80cyzzDfpEST+pEkbaiXtl+L6dmB6YvL
         bw+NTdskCBw3tCBtj1anhi72K5dPvdXGmwKi5klfeHtST9j6ZSbh42tDKZPWf51DY4zx
         7Kew==
X-Gm-Message-State: AOUpUlHuTeWxFiHu3IiD83m8kf8nMkqX8919c76jymtsA2I4/jedF/cg
        Nlc2D6rWpuweniyfbb7CDazy
X-Google-Smtp-Source: AA+uWPx+RJGf6AWwNFGaFuU7krg1FFWiKj/BeMqUequD/eUigzORi0+CYz1/0c6FH+3p3BSlWOz+iA==
X-Received: by 2002:a17:902:28a6:: with SMTP id f35-v6mr15568702plb.240.1534151758000;
        Mon, 13 Aug 2018 02:15:58 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id h18-v6sm55432462pfa.173.2018.08.13.02.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 02:15:57 -0700 (PDT)
Date:   Mon, 13 Aug 2018 14:45:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Parthiban Nallathambi <pn@denx.de>, tglx@linutronix.de,
        jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sravanhome@gmail.com,
        thomas.liau@actions-semi.com, mp-cs@actions-semi.com,
        linux@cubietech.com, edgar.righi@lsitec.org.br,
        laisa.costa@lsitec.org.br, guilherme.simoes@lsitec.org.br,
        mkzuffo@lsi.usp.br
Subject: Re: [PATCH v2 1/3] dt-bindings: interrupt-controller: Actions
 external interrupt controller
Message-ID: <20180813091547.GA22149@mani>
References: <20180812122215.1079590-1-pn@denx.de>
 <20180812122215.1079590-2-pn@denx.de>
 <20180813043406.GA16275@Mani-XPS-13-9360>
 <f1043a48-6c8d-cf08-d6a1-582d84ea2530@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1043a48-6c8d-cf08-d6a1-582d84ea2530@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 08:51:54AM +0100, Marc Zyngier wrote:
> On 13/08/18 05:34, Manivannan Sadhasivam wrote:
> > Hi Parthiban,
> > 
> > On Sun, Aug 12, 2018 at 02:22:13PM +0200, Parthiban Nallathambi wrote:
> >> Actions Semi OWL family SoC's provides support for external interrupt
> >> controller to be connected and controlled using SIRQ pins. S500, S700
> >> and S900 provides 3 SIRQ lines and works independently for 3 external
> >> interrupt controllers.
> >>
> >> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> >> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> >> ---
> >>  .../interrupt-controller/actions,owl-sirq.txt      | 46 ++++++++++++++++++++++
> >>  1 file changed, 46 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> >> new file mode 100644
> >> index 000000000000..4b8437751331
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> >> @@ -0,0 +1,46 @@
> >> +Actions Semi Owl SoCs SIRQ interrupt controller
> >> +
> >> +S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,
> >> +in which external interrupt controller can be connected. 3 SPI's
> >> +45, 46, 47 from GIC are directly exposed as SIRQ. It has
> >> +the following properties:
> > 
> > We should really document the driver here. What it does? and how the
> > hierarchy is handled with GIC? etc...
> 
> Absolutely not. This should document the binding, irrespective of the
> operating system. The word "driver" is completely out of place here.
>

Oops, my bad. I meant to say that we should add it as a description in the
commit message.

Thanks,
Mani

> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
