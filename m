Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ED9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF1421710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF1421710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeI1COq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:14:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33705 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1COq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:14:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id a203-v6so3309017oib.0;
        Thu, 27 Sep 2018 12:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LxQxeMg3qQzlvwbSIdSa4I4cNVZis+K1vnNKhoQ57sA=;
        b=KAtSu+RuZZA437Glti0tbgJadiqAtfPqZFAxUxw96ciEsw8S1EFlP37jGXJ8YRafYW
         hykdV/LuJId5KslIe9ILVqSc7co48bvrSiwnS1lAen3igHkd/Xjl3anieMiIGrV0VkXA
         OryDrMrKkptd6MaR0h4oc0Bl7YrGq/K1x6zEd4vdUZcxMl92qkkhwLfPB6FYn3lELPV3
         SWd3tjpSZQXIYDeZqifk57ZIXhZk8ctuCSaPTpVElAFhSY2BW1tJKgaR9GdtfDBeWMOz
         RwbjXRigwbP5MBezXg/B7xkjwhWSDIrLXfvowa+VblCwPMvwoF6p6TWxDP5/EArAZChp
         qlXw==
X-Gm-Message-State: ABuFfogCxB+eNNGugXeI4XzLwD7bndYNMVGeFFVdrIdyYCOEXO4Dot7A
        vec62c2l6Ptr3OZt5pU841wpcovj2DEi
X-Google-Smtp-Source: ACcGV61MI3p0yxE/f+/x4wTKKwn+nM4MKUeCXPrVmjmzROMlUlm3XY/PtOI0XQf7USSAr2o89AMEEA==
X-Received: by 2002:aca:3946:: with SMTP id g67-v6mr4174992oia.145.1538078090206;
        Thu, 27 Sep 2018 12:54:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v20-v6sm1057734ote.48.2018.09.27.12.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 12:54:49 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:54:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        andrew@aj.id.au, openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org, joel@jms.id.au,
        hverkuil@xs4all.nl, Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: media: Add Aspeed Video Engine
 binding documentation
Message-ID: <20180927195449.GA25789@bogus>
References: <1537903629-14003-1-git-send-email-eajames@linux.ibm.com>
 <1537903629-14003-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537903629-14003-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 14:27:08 -0500, Eddie James wrote:
> Document the bindings.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../devicetree/bindings/media/aspeed-video.txt     | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
