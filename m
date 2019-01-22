Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EF9C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E0B2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548119612;
	bh=cTlvSvq/pKLJOKijZVMKihppWdcOxkgV+wl/nrwHxP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YXVNz5aMVanovWQzcINFUi90K9QXVnPbr9A5iiX6Un+hG3bq8MyAWXkNaLZiCe0Qe
	 8HucvdHr3/eDQHGwST7gKM57LC5Ca/hDY3Pq2Kyf4PmS/orR5Y9QLdOmdFx16jnMVE
	 RZDKIlkC9+en6tLq94mjh78MPY+gPEwUsWYc5zeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfAVBNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:13:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33956 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVBNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:13:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so17183882otk.1;
        Mon, 21 Jan 2019 17:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GZF6L8E/i+Id6sWOE+wIJZuf7XuNT/ayFD0PmqqRwrk=;
        b=rM3x9Y3Z6Gd5+EvvloYPKpLblNiIXgsX0WG8FbbBYr2nxHe8dCTD9GSK2WiyiZRHUF
         vB6gm0GsXMSta15R0Q3LLxWLIO5F736x4G/TJnncm67RyFgFL72oYFkNrz+HazErsAqG
         uIpGAABh6MDIAeP0UQXreg0mAEaBCyeIMGe7rwTC2VmoQt0tpoA8jgiRTJxzMpqdKjuK
         d5tG323z2ickOaPIK9yglZSg5LAx6dnN6VF3KhzQ6xuuhssR7RNoW+joMHR+XDb8e82K
         3CUltV6cNDCLBL54yLMsrJ+rgm0/ZIDJhFQSEmlwgj83Cx/CwflS4wFQppmJ9TNhaCtU
         opjA==
X-Gm-Message-State: AJcUukcGuf/HUaKzrrbPALeAqs/aTwi4/6Eu4kGonYTMoJPmwq/+4N20
        gCyg12TKMvUtryV+ulWqMA==
X-Google-Smtp-Source: ALg8bN7xZzW4BW2GwLTKydhe+Dz8mJ96E8Cc5HiLFPuc8awcqZ/m0r7HlZInEA6UkOUB7r6mFSSXag==
X-Received: by 2002:a9d:7e6:: with SMTP id 93mr21613231oto.176.1548119609712;
        Mon, 21 Jan 2019 17:13:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u19sm7332969oia.31.2019.01.21.17.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 17:13:28 -0800 (PST)
Date:   Mon, 21 Jan 2019 19:13:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/8 v4] Documentation: bindings: dma: Add binding for
 dma-channel-mask
Message-ID: <20190122011328.GA1422@bogus>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
 <1547658629-25378-3-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547658629-25378-3-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 09:10:23 -0800, John Stultz wrote:
> Some dma channels can be reserved for secure mode or other
> hardware on the SoC, so provide a binding for a bitmask
> listing the available channels for the kernel to use.
> 
> This follows the pre-existing bcm,dma-channel-mask binding.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: dmaengine@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v3: Renamed to hisi-dma-avail-chan
> v4: Reworked to generic dma-channel-mask
> ---
>  Documentation/devicetree/bindings/dma/dma.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
