Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD18C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF68C20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF68C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeK0HBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:01:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40165 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0HBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:01:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so17849407oth.7;
        Mon, 26 Nov 2018 12:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KQ5joNutaw4ez/PLSPqbgWdNm1gYWMuYr+j8QOknVzw=;
        b=SE6xYFTVHIYbFg+juu5KSdFizKlHGdECmk7CdlXR9WMv2bZ52jDZ9HajGdDXh/yAqp
         vzVhCtPsqzpBQ/VLns3Fw2l5Pue3ElFd1cEg9ozoL/nf5t/+IrK3I9NzGFjkIKjxlZgT
         BGpyunJ5OCf8D3LMCVxWVLTVyAcZz1D2x48YNfnFpBjf4bbYRAJlyXw+coQi6NAP4lhJ
         daXd93KB/IAFnzDv2+Z7z3f0c4BqyRNdRMvUP6BCrfKg7YB4Yzm9DcWlLMUlHsH94hTf
         Iwek9eHNcqLcTcmE2BvytMptOp62Pkfv2DR0YFDPPytdF304WwCAgD2QytbT5IJao4hb
         YZmg==
X-Gm-Message-State: AA+aEWaV9YbBCFmQC5aEJrjQDxChHCnKoWnxsvm2GX/n6mQS+wgDv3Md
        Y7L/c8pWVeNa6jim5ZMjQAqoR9E=
X-Google-Smtp-Source: AFSGD/XMu+Mzhy4q/rRue/WqsiZ3UvCWrksHHIQ/HzyVGRhEtDkoKzC55xI530omnNlEweLpUDXJNw==
X-Received: by 2002:a9d:401:: with SMTP id 1mr13430676otc.78.1543262750823;
        Mon, 26 Nov 2018 12:05:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o186-v6sm385946oib.47.2018.11.26.12.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 12:05:50 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:05:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wendy Liang <wendy.liang@xilinx.com>
Cc:     jassisinghbrar@gmail.com, michal.simek@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Wendy Liang <wendy.liang@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Message-ID: <20181126200549.GA611@bogus>
References: <1542662761-31158-1-git-send-email-wendy.liang@xilinx.com>
 <1542662761-31158-3-git-send-email-wendy.liang@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542662761-31158-3-git-send-email-wendy.liang@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 13:26:01 -0800, Wendy Liang wrote:
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
> in ZynqMP SoC used for the communication between various processor
> systems.
> 
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> ---
>  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 127 +++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
