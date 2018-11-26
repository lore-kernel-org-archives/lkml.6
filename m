Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A037C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53949208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53949208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeK0DHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:07:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43196 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0DHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:07:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so17060613otr.10;
        Mon, 26 Nov 2018 08:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NiIx+SzbBCo65yJWjl175jFQgbd4NOd7dqzLNO1bvRA=;
        b=UtOeeNcAv3uxQzqzfl1cRwdLUXc53RLZ5A2hzNJ3P5rmWu685jU7w+Xc3jMt2KGmk7
         Vk83tNcJe4hsVPuqf+BZCw3QYFc9a3RCGw6AKzG2T0lOs6DosEjvmy2AvyZYUEoCeIwI
         e6w/+yfMrDybQlgzJbkRk4p9s38STO4d+RplgE7//kmCUwxYsb2edW1lnGY7QqdgdeP8
         xtnq8XHKuDNQAxaSOfm5/pSCg2mfxRC7ae1ZedNBlAtp+Im+LpNkGNA2ibG/OnghVCXX
         0QtDFue+vlt4LGQooyAGf8fHHVY5D687SY+SpxAr3avIMKwotUJtpw/sCIuz3W5ncuVC
         VitA==
X-Gm-Message-State: AA+aEWbYawSXB/90ACnBXK121S8kuWOG9/bFytz/c3f8G2SdigNzdfqP
        5WpISUIOc+ZNJcbOgeirpg==
X-Google-Smtp-Source: AFSGD/VqVp+yZ3BCcze4o5NndEjRnggVfpxxw+Pp2yvAMFJL/Hg7fyKdY1RamEWvgx12DDAZTuBBhw==
X-Received: by 2002:a9d:32c7:: with SMTP id u65mr15139836otb.236.1543248763640;
        Mon, 26 Nov 2018 08:12:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x4sm189513otk.37.2018.11.26.08.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 08:12:42 -0800 (PST)
Date:   Mon, 26 Nov 2018 10:12:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH v6 3/7] dt-bindings: dmaengine: xilinx_dma: add optional
 xlnx,sg-length-width property
Message-ID: <20181126161242.GA19168@bogus>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
 <20181120153151.18024-3-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120153151.18024-3-andrea.merello@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 04:31:47PM +0100, Andrea Merello wrote:
> The width of the "length register" cannot be autodetected, and it is now
> specified with a DT property. Add documentation for it.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes in v2:
> 	- change property name
> 	- property is now optional
> 	- cc DT maintainer
> Changes in v3:
> 	- reword
> 	- cc DT maintainerS and ML
> Changes in v4:
> 	- specify the unit, the valid range and the default value
> Changes in v5:
> 	- commit message trivial fix
> 	- fix spaces before tab
> Changes in v6:
> 	None
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Please add acks/reviewed-bys when posting new versions.
