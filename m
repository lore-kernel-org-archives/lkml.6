Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E144AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A666725F47
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A666725F47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934905AbeFYRaS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:30:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46261 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755365AbeFYRaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:30:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id q1-v6so6761043pff.13;
        Mon, 25 Jun 2018 10:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bdMM/amKNcWLOQ4+yrvmy9soOvE7jf1rDB3PCndVysE=;
        b=iVQDQy9N6HmOUH3NljT5jHcpI/hYimzj836qs9rD/1pfTnoj/Rs9OVws4AuA3D70Te
         gA75klOIGRJRSz9b0ZzUsZPToxRAcULt2ZV3X+Y01f85bNRqgmvgP56/ZyDfPH44oK9E
         Nm07hs+xksrBHzBdnXT9F3wqQl6WWfS+eVYbRJKiKvFemfLCeXV2+y5pDj1AEV6xeQrH
         Xb4wF/EiewmVr4RnzlIvqOVBfTcUIo9xG8qYm6Vccsyu+s9D+JsxFeHJZ896Mugu4t9g
         nM7Ot+WQ3rj4Ha7e7hVz6OqQ13S5abj4P4z5MMqdYN69nqSTajMOSdDPcxIYR+ai5Bbe
         1Kew==
X-Gm-Message-State: APt69E2CgQLhJHpxoCbHjUxrXOn11wWzFMNIJARAzGItAUHmRvbB2cUo
        shDaxa/eU95JGmC5ES8NAw==
X-Google-Smtp-Source: ADUXVKIlEU+HA/SmqJjb6v7ZckUSNq/NlFCcNWMMkfsA4zv2v9/cp/PFDB01OHkJ08asG5rv0J/dpQ==
X-Received: by 2002:a65:6252:: with SMTP id q18-v6mr11688374pgv.106.1529947815443;
        Mon, 25 Jun 2018 10:30:15 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id t23-v6sm30021896pfa.86.2018.06.25.10.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 10:30:14 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:30:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH v3 5/5] dt-bindings: dmaengine: xilinx_dma: drop has-sg
 property
Message-ID: <20180625173013.GA2268@rob-hp-laptop>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
 <20180625092724.22164-5-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625092724.22164-5-andrea.merello@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:27:24AM +0200, Andrea Merello wrote:
> This property is not needed anymore, because the driver now autodetects it.
> Delete references in documentation.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes in v2:
> 	- cc DT maintainer
> Changes in v3:
> 	- cc DT maintainerS/ML
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
