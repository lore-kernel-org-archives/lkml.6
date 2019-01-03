Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C361C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECCD208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546537287;
	bh=+UYRW9v45SJoPxQSkfwmJgmlzpJ4vpuw9nqSM/BkuIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yVJDzt5YA6G0N7drylPkQdTusF5PSpvzGXrj+sfcmD1gI86hEvB2Wzo1O0JYRU/DL
	 p/Ng570tKexGfl+Ouo6/gGJ/HVr23r6C7Gqx4AQXuQinCzBQcasOlRi4A6dwtSnR1f
	 2m/42FvnnXYSmaraOoSTaICzKn2NFlvmB28xf658=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbfACRl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:41:26 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54527 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731865AbfACRlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:41:25 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so46286944ita.4;
        Thu, 03 Jan 2019 09:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XgtY3ON4bBMzyuiNr7dfPpNVT+C5KIh9dO8CbrGw7tk=;
        b=S2cj9SxBvbx51dS4EpTBE57RjisNPFQsEm+RtsUXLlXtb9TZwC3wNyG8sDoPThGG5d
         jsJh2U4OdAhxzckZh4moS3Q1P/LxMj/1zJxStWxK6gd7Lex6uY3v+U/hcMeG9EHipIRj
         FU1m7tDzC1miwIXYahcLp0ElFk2SpiFYSKeFZBeoa7sGAGoHicBJwOr8IMPI4SZpOvw5
         PkvekJbXjFl2uTSrGeYfu3vhPivTKwKd7CWvRNS/w/F7nwGRBipmYU1dPsbXqU8uE8qo
         gA9jI2joJ93rLobg9ANYJNQI0iKYI+1hKGSM6c8r2sS3/7pDz2yjh3iyEuEcGrHoDfWC
         7o7Q==
X-Gm-Message-State: AA+aEWY12f8nSxe26Fl8qnHs3HU2eN23poA9I/Qzyz94FEj/qWMGEMlh
        MD/m7Avt14bKcbxFQeRJnQ==
X-Google-Smtp-Source: AFSGD/V9b5yqNsHDxHuE9KElWPtdLZDxaY7MyTLeweez3j5H2PftNm0IWXF0oxxaHSQNzRuuliNPtg==
X-Received: by 2002:a24:16cc:: with SMTP id a195mr31184772ita.38.1546537284031;
        Thu, 03 Jan 2019 09:41:24 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id h13sm6088944ioq.72.2019.01.03.09.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 09:41:23 -0800 (PST)
Date:   Thu, 3 Jan 2019 11:41:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
Message-ID: <20190103174117.GA6613@bogus>
References: <20181221013409.14324-1-f.fainelli@gmail.com>
 <20181221013409.14324-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221013409.14324-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 05:34:08PM -0800, Florian Fainelli wrote:
> Add a binding document for the Broadcom STB reset controller, also known
> as SW_INIT-style reset controller.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/reset/brcm,reset.txt  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/brcm,reset.txt b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> new file mode 100644
> index 000000000000..6e5341b4f891
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> @@ -0,0 +1,27 @@
> +Broadcom STB SW_INIT-style reset controller
> +===========================================
> +
> +Broadcom STB SoCs have a SW_INIT-style reset controller with separate
> +SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
> +reset lines.
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible: should be brcm,brcmstb-reset
> +- reg: register base and length
> +- #reset-cells: must be set to 1
> +
> +Example:
> +
> +	reset: reset-controller@8404318 {
> +		compatible = "brcm,brcmstb-reset";
> +		reg = <0x8404318 0x30>;

Based on this address, should this be a sub-node of something else? Or 
not even a sub-node and just make the parent be a reset provider?

Rob
