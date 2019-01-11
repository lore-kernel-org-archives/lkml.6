Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4468FC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189522184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547237386;
	bh=dWmOn+R7TxUENgiI7ULkixE5UroSFRW6Q175NNhh4Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fuiQio9/s7EZTqvvgLmb8hgzq+2kbdUMqckQuBIalGYVLS39dgIm35rcjFj2hPd4E
	 7Vec7vO6B80E1iiz9HzED6f0YULoVP1Khpdh31MixgzvNc4GQr9r5NxXwEQauU5rTZ
	 dIsJzkCynPOg0dR2/PdnIKIExp+T6H60WSUmAQy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388995AbfAKUJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:09:45 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37731 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731440AbfAKUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:09:45 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so13221320oia.4;
        Fri, 11 Jan 2019 12:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ozLB4eItNh38XiaTZC1HQmCoOYneLP4TFm8jXIMT24k=;
        b=C2W+3kNHHfi+1KNv4fKxUxzgI1FVZcQQEfdCPouADEd9g2ve62E8wrdOTrip2BO23l
         2hW2zqk4s/f6B5NSiAdEIGtjVE9wH5VH2+4vS5Pa45F+MPQVM2ocWgCSFqi7qQ87tt++
         NlgVQyzRtGkF3JXK5YD8eYzDJWzJwjYnRl+rvYsMBGBQfK9eirao1bm1bv9Br7swvdXZ
         hG0qQ3fNTUG5nIt/r8YL/tw94PK6QOEyz/qDo7vzE5+EwmQsNobxbn3qJStQ+hj4WJqz
         +rcynkof/IiITBRGzGbGUXZl3BNDkB4205SKXtBwMdePnpClN4H3dbvdM8t4QWbwthVJ
         IsMw==
X-Gm-Message-State: AJcUukd9xhXJoJ2nvJGMPfo5tMqa0FtiJHG5ma+1NwxjcGdC/KtOZiE9
        VUlohPF8mcih9t84V/Y/XmfodD40tA==
X-Google-Smtp-Source: ALg8bN7Y5g2FaX5SHmq2tpvInGk0fAzgfe8q3egnt+r9F57nTKQ9k2JINHKPRc4ORkyL1tKYtWYn/w==
X-Received: by 2002:a05:6808:89:: with SMTP id s9mr10396347oic.131.1547237380583;
        Fri, 11 Jan 2019 12:09:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z191sm42879549oig.3.2019.01.11.12.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 12:09:39 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:09:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, nava.manne@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: Add ZynqMP power domain
 bindings
Message-ID: <20190111200939.GA28260@bogus>
References: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
 <1546638982-12954-2-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546638982-12954-2-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2019 13:56:19 -0800, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add documentation to describe ZynqMP power domain bindings.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../bindings/power/xlnx,zynqmp-genpd.txt           | 34 +++++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h      | 39 ++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
>  create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
