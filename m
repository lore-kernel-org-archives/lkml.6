Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31083C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FEB20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FEB20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbeGKQOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:14:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40565 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbeGKQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:14:30 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so50226314oie.7;
        Wed, 11 Jul 2018 09:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pFL5J4xLysoe0+DyjjXe3ZzhZ+7SbtznbFjHRHG0Ce4=;
        b=Xxl2efVEbuKoaTnHa7FKKhPDhaXlMN4nb+ORXWHVfl6Ijx8YwYd85ahmgYMo+iUACo
         31f6cTfz4P3YTdFkUYZW7+c7N/xnE7vhB9Tbl2RKYNFyddN44noz1Y3fF8RXicWxtrSn
         eIZhrGoxBxyhxyY5AxgSXgFOg2aVULLI12ocl2dU+IE9QGgtwRgFNQSL/QX811639BZC
         ljvMa1BPTro6iphaBvzBbgW2i97m7eZG8yYnOczO8mvTq76OXv6VPZ58iNPXheQX349+
         HNXTEE3A4zNK7cCt0G4MwpkY3ZQLicmfKlCqXpICua4Xo/S5Rheteh7xKpgETrNdUV6r
         yk2g==
X-Gm-Message-State: APt69E3/HPgmU9pkIQAB7MpUPLq6kVfUIqVFxQlrqO6xBnx1qYAvWo6Y
        CRnUwlMRrhzM6a/7m+ZxLA==
X-Google-Smtp-Source: AAOMgpc2n5KEy8pnTW713vus4ezXgalYY9pUUjPJasDWMs06jLL0Yg8zMpbJaNFK7X2usMqPaEafGA==
X-Received: by 2002:aca:e6cd:: with SMTP id d196-v6mr31482459oih.94.1531325368635;
        Wed, 11 Jul 2018 09:09:28 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id n188-v6sm12801070oia.17.2018.07.11.09.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:09:28 -0700 (PDT)
Date:   Wed, 11 Jul 2018 10:09:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod <vkoul@kernel.org>, Guodong Xu <guodong.xu@linaro.org>
Cc:     mark.rutland@arm.com, dan.j.williams@intel.com,
        xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com,
        liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: k3dma: add optional property
 hisilicon,dma-min-chan
Message-ID: <20180711160927.GA31359@rob-hp-laptop>
References: <20180706035521.13736-1-guodong.xu@linaro.org>
 <20180706035521.13736-2-guodong.xu@linaro.org>
 <20180709103438.GC22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709103438.GC22377@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:04:38PM +0530, Vinod wrote:
> On 06-07-18, 11:55, Guodong Xu wrote:
> > From: Li Yu <liyu65@hisilicon.com>
> > 
> > Add optional property hisilicon,dma-min-chan for k3dma.
> > 
> > Signed-off-by: Li Yu <liyu65@hisilicon.com>
> > Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/dma/k3dma.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> > index 4945aeac4dc4..f34202a80f3c 100644
> > --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> > @@ -12,6 +12,11 @@ Required properties:
> >  		have specific request line
> >  - clocks: clock required
> >  
> > +Optional properties:
> > +- hisilicon,dma-min-chan: the minimum DMA channel number which is usable
> > +		Default value is 0, but in some platform it is
> > +		configured 1, like in hi3660 platform
> > +
> >  Example:
> >  
> >  Controller:
> > @@ -21,6 +26,7 @@ Controller:
> >  			#dma-cells = <1>;
> >  			dma-channels = <16>;
> >  			dma-requests = <27>;
> > +			hisilicon,dma-min-chan = <1>;
> 
> Am still expecting this to be a mask

If so calling it 'min' doesn't make sense. And a mask should have 'mask' 
in the name.

Rob
