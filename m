Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A54ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44802084C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44802084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeGPWC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:02:59 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42639 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPWC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:02:59 -0400
Received: by mail-oi0-f68.google.com with SMTP id n84-v6so77623380oib.9;
        Mon, 16 Jul 2018 14:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tLMg6k/mwE9JutdGNUoTrKQN9z8d0yYh3gZ+rnkmhq0=;
        b=T3ncPO3VlQcW44tR8hx0fXZfH5sGnTarpKf2D4m3IiG7Cb9TaoGIMGPklcW73w29Rr
         h9f9ZLyjtGDJol/y8a9hap+G38yDV0FrMIrzikL6JBxsyTKoKy4fHGj//Uz4wQOMO65+
         ecVl1L2TiQR9Oa6TzVDbX0yLi48dd6Op278NPe/xkG5eTcxSe3FNsEw+meIzDpCGRYHB
         2DOGr7gjKV8UYbrXbZv3nvaKU6Q2MG5cKLA424TW7Wte2UWyEFxmrN7NORqGPBklT4ph
         94WucPLggTtXUf6uhe7w6E+fWM7YcIEoJIBf67AcH/n7yjLxWHyTDnZg2gVIC44wbGZT
         SV1Q==
X-Gm-Message-State: AOUpUlFd/K7j9SKCXgTecV2DGkVANPjif6j1bvDNffxP7uiWL/RE1pmR
        spZJ/2fWOJaQBTZHw/v3eA==
X-Google-Smtp-Source: AAOMgpcte/0EZl5FO8x8p88ft1DpjW4Q6UcDFzZQ1vxbT4Y84K8MQ8EmuxHzhf7mjOz+phEBAES4QA==
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr1055172oia.5.1531776822226;
        Mon, 16 Jul 2018 14:33:42 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id e2-v6sm12307986oiy.50.2018.07.16.14.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:33:41 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:33:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod <vkoul@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 05/14] dmaengine: dma-jz4780: Add support for the JZ4740
 SoC
Message-ID: <20180716213339.GA19161@rob-hp-laptop>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-6-paul@crapouillou.net>
 <20180709171226.GK22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709171226.GK22377@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:42:26PM +0530, Vinod wrote:
> On 03-07-18, 14:32, Paul Cercueil wrote:
> 
> >  enum jz_version {
> > +	ID_JZ4740,
> >  	ID_JZ4770,
> >  	ID_JZ4780,
> >  };
> > @@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
> >  }
> >  
> >  static const unsigned int jz4780_dma_ord_max[] = {
> > +	[ID_JZ4740] = 5,
> >  	[ID_JZ4770] = 6,
> >  	[ID_JZ4780] = 7,
> >  };
> > @@ -801,11 +803,13 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
> >  }
> >  
> >  static const unsigned int jz4780_dma_nb_channels[] = {
> > +	[ID_JZ4740] = 6,
> >  	[ID_JZ4770] = 6,
> >  	[ID_JZ4780] = 32,
> >  };
> 
> I feel these should be done away with if we describe hardware in DT

The compatible property can imply things like this.

But how this is structured is a bit strange. Normally you have a per 
compatible struct with these as elements and the compatible matching 
selects the struct.

> 
> >  
> >  static const struct of_device_id jz4780_dma_dt_match[] = {
> > +	{ .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 },
> 
> adding .compatible should be the only thing required, if at all for this
> addition :)
> 
> -- 
> ~Vinod
