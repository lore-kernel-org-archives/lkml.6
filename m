Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAECFECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E30B205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E30B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbeGTO7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:59:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53959 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731203AbeGTO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:59:31 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so14839179itw.3;
        Fri, 20 Jul 2018 07:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bjwRApTlucHEB1rkzrPo7vUlH9S4EpCsNAw5xSJc3E8=;
        b=MNZub5BEwYcavxWQ9/0YF4PRbFSOAOjnCt/hBr4lW4BnxLkGvWhe+N3K/1gGZIeXX7
         +kvXZkA6JNDjT1swffkOyHCda9ZpEA4PvpliNYHInGXRHcQ1sSiS92zPc2IL8w1YSjZK
         HM8eczFI2SwYDhNZiV9R0Vr+wx5ESRwmf2Z8qS1izajpa18BK3W1L7AFjGbS4ThfVRwG
         dMMtnTQn0clvinlLPC4qn0b+M8uaHUNFNHJvbZjQKxmrwePnNidCmYFq2ifTNa6vVio4
         +gzcz8shXK61SR6Hxc2CcxjS6zYU8LrvEuq5k1APggUecOSI+B82ThPx05vLZf0QSw3j
         mVAQ==
X-Gm-Message-State: AOUpUlGSoSbh4FmIjDCoqLlRpV7UW/hInAXcjQXvLwBlUDdIFpQypULv
        o5Rvx5BgYma7QCGGef8Wsw==
X-Google-Smtp-Source: AAOMgpfy/O4h+p8msvMnC6zGKS6jcZKe1W1uI+UiHcNzO3A+popvzovuhh4oxndssRzbi1A0+lRHAw==
X-Received: by 2002:a24:dac2:: with SMTP id z185-v6mr2093171itg.72.1532095861061;
        Fri, 20 Jul 2018 07:11:01 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z195-v6sm1136075ioe.38.2018.07.20.07.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 07:10:59 -0700 (PDT)
Date:   Fri, 20 Jul 2018 08:10:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     kishon@ti.com, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
Subject: Re: [PATCH] phy: qcom-qmp: Fix dts bindings to reflect reality
Message-ID: <20180720141059.GA3064@rob-hp-laptop>
References: <20180706233142.166296-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706233142.166296-1-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 04:31:42PM -0700, Douglas Anderson wrote:
> A few patches have landed for the qcom-qmp PHY that affect how you
> would write a device tree node.  ...yet the bindings weren't updated.
> Let's remedy the situation and make the bindings refelect reality.

"dt-bindings: phy: ..." for the subject.

> 
> Fixes: efb05a50c956 ("phy: qcom-qmp: Add support for QMP V3 USB3 PHY")
> Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index 266a1bb8bb6e..0c7629e88bf3 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -12,7 +12,14 @@ Required properties:
>  	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>  	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.
>  
> - - reg: offset and length of register set for PHY's common serdes block.
> + - reg:
> +   - For "qcom,sdm845-qmp-usb3-phy":
> +     - index 0: address and length of register set for PHY's common serdes
> +       block.
> +     - named register "dp_com" (using reg-names): address and length of the
> +       DP_COM control block.

You need to list reg-names and what are the names for the other 2 
regions?

> +   - For all others:
> +     - offset and length of register set for PHY's common serdes block.
>  
>   - #clock-cells: must be 1
>      - Phy pll outputs a bunch of clocks for Tx, Rx and Pipe
> @@ -60,7 +67,10 @@ Required nodes:
>  
>  Required properties for child node:
>   - reg: list of offset and length pairs of register sets for PHY blocks -
> -	tx, rx and pcs.
> +	- index 0: tx
> +	- index 1: rx
> +	- index 2: pcs
> +	- index 3: pcs_misc (optional)
>  
>   - #phy-cells: must be 0
>  
> -- 
> 2.18.0.203.gfac676dfb9-goog
> 
