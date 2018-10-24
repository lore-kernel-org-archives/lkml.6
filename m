Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9D7ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A053720834
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A053720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeJYI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:27:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41482 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeJYI1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:27:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id c32so6861283otb.8;
        Wed, 24 Oct 2018 16:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MTVznae+akc6QY8XO51ygXNZquOMNkrNc+AHFN5Uoy4=;
        b=gvCK28AVlPzsICbwWR31zhdeIjNqNPloQww768NizE9KSwBRMem1nuxmPcYyt71UOR
         lbJqsAd+qRwgDCNKueRYQNE6BBUeafCB7KfWq2Ez5z282kFYjIndfN/BJ0kfL25ePxO+
         mfXSeekPDI0HkNQxqXnfzUJEaTPG5RPGSutiJvyBCeQg72DUnPoi+vMHysm6iyj6rk8A
         MuMecavLn3dcnGtfPeRBkpliZLw8ryc/kvU4N368rZkP7lcIx8kfm/96VwpwI9NdtO3Q
         VcEboKP7l/WI420p/gK5p7vPUBpvRbe2gdPdxzx1edEnsaBTPqwTC9X7bqM2NOSs5SAP
         cdjw==
X-Gm-Message-State: AGRZ1gI8u5RiYJCFkHcFDV0GMZ+ctAkHmjhCabStFfoRcMsWN1/k5lM7
        80JLda1B5CALCxMzbFKsEA==
X-Google-Smtp-Source: AJdET5dy8OKS8H+HHecpMSiYFONszvysG+SLpFhzSZqG5ZcH2xEBJC9nLTSFf9hLz9JRpBRWCiI9ag==
X-Received: by 2002:a9d:460e:: with SMTP id y14mr3256543ote.199.1540425428074;
        Wed, 24 Oct 2018 16:57:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 111sm3648927otf.51.2018.10.24.16.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 16:57:07 -0700 (PDT)
Date:   Wed, 24 Oct 2018 18:57:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH V1 2/2] Documentation: can: flexcan: Add stop-mode
 property to device tree
Message-ID: <20181024235706.GA22938@bogus>
References: <20181023051449.2116-1-qiangqing.zhang@nxp.com>
 <20181023051449.2116-3-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023051449.2116-3-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 05:17:10AM +0000, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> The FlexCAN controller can parse the stop-mode property to enable CAN
> self wakeup feature.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index bfc0c433654f..b5ccfc9c14fb 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -24,6 +24,14 @@ Optional properties:
>                if this property is present then controller is assumed to be big
>                endian.
>  
> +- stop-mode: register bits of stop mode control, the format is

Should have a vendor prefix: fsl,stop-mode

> +			<&gpr req_gpr req_bit ack_gpr ack_bit>.
> +			gpr is the phandle to general purpose register node.
> +			req_gpr is the gpr register offset of CAN stop request.
> +			req_bit is the bit offset of CAN stop request.
> +			ack_gpr is the gpr register offset of CAN stop acknowledge.
> +			ack_bit is the bit offset of CAN stop acknowledge.
> +
>  Example:
>  
>  	can@1c000 {
> -- 
> 2.17.1
> 
