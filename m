Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77633C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C79216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C79216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeI0VYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:24:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37695 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0VYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:24:49 -0400
Received: by mail-ot1-f67.google.com with SMTP id o13-v6so2885902otl.4;
        Thu, 27 Sep 2018 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vgjWdRWALPh0lXYXcEsA5HyF8xanlDXqIaN1CKyFMDU=;
        b=dyXspPsUxV/9lIz5Gii16voheNax7la4oWs1nb4vQ/Rq0hspO9Cpdmc3c1bBV8gAF9
         SdDhKGDjSsuanZK2FK54p/gvHnxxXjQ7XIAquZ7a8wm6oazwKn6H/BY3t/VFJ4VgoiWZ
         rZQR3eXJ1UDekcDyhJcn6WTBfI49FJ3GNpN+i0xaMnn/gjV4+zhunLOoydoh5/HRMDsF
         vaH2GLulJoHeUUjehldxBKu6t6iY0z8INWG9hYMU7eC5GwtHwRlsjd1tHO/jeOGiQqC0
         tcWjVn0Z8f6UiKIl4rzJzgzEaDP868e6QYawqxy+uS7uOGlmIbsgffP4xyLq4fqA29qi
         L0Jg==
X-Gm-Message-State: ABuFfoiejQm63G0dhHL6CHVo0thoDEIBH4pXKQw1i+YDk1NcVpVOLhzo
        bVmlh91tXLmXMtE14ypN+w==
X-Google-Smtp-Source: ACcGV63DiNg/YqIxlW4h6+EkggXDmOPcUd2XdXkRQmkBrJMZSDZl7w4xpq1aoukKt9Ve71pDgPySTA==
X-Received: by 2002:a9d:3f83:: with SMTP id r3-v6mr7142950otc.202.1538060767274;
        Thu, 27 Sep 2018 08:06:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p18-v6sm740296otl.63.2018.09.27.08.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:06:06 -0700 (PDT)
Date:   Thu, 27 Sep 2018 10:06:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, evgreen@chromium.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        Can Guo <cang@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 7/7] dt-bindings: ufshcd-pltfrm: Add core reset string
Message-ID: <20180927150606.GA20771@bogus>
References: <1537504081-29976-1-git-send-email-quic_cang@quicinc.com>
 <1537504081-29976-8-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537504081-29976-8-git-send-email-quic_cang@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 09:28:00PM -0700, Can Guo wrote:
> From: Can Guo <cang@codeaurora.org>
> 
> Add core reset support string for UFS.
> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index c39dfef..6b697c4 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -11,6 +11,11 @@ Required properties:
>  					  "qcom,ufshc"
>  - interrupts        : <interrupt mapping for UFS host controller IRQ>
>  - reg               : <registers mapping>
> +- reset             : reset specifier pair consists of phandle for the reset provider
> +                      and reset lines used by this controller. It is mandatory for
> +		      QCOM SDM845 platform.
> +- reset-names       : reset signal name strings sorted in the same order as the
> +		      resets property. It is mandatory for QCOM SDM845 platform.

This already exists as of 4.19 under optional properties. (And you can't 
add new required properties anyways.)

>  
>  Optional properties:
>  - phys                  : phandle to UFS PHY node
> @@ -64,6 +69,8 @@ Example:
>  		clocks = <&core 0>, <&ref 0>, <&iface 0>;
>  		clock-names = "core_clk", "ref_clk", "iface_clk";
>  		freq-table-hz = <100000000 200000000>, <0 0>, <0 0>;
> +		resets = <clock_gcc GCC_UFS_BCR>;
> +		reset-names = "core_reset";

And the name should be "rst" (or omitted).

>  		phys = <&ufsphy1>;
>  		phy-names = "ufsphy";
>  	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
