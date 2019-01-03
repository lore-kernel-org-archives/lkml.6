Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C40C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D47820675
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rc75zxyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfACUS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:18:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38664 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfACUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:18:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so16359826plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C9UGwsZURAxttMcy2R8lpl3u9qiypy8QEsnv9icbYik=;
        b=Rc75zxynFSMEtzMa6BdXH5rMf7U68AjaMc87cDewCNnvSbtDw0aNOiKGCJ8qWkaVqM
         jgffZSLQuJxeepn1BHSG9LzqfDIqtKE0jGH46CbPNl3ANQpmE4p6CAYLrGQv7sBoyv36
         9TPy+SAwt9G/Zn8qxMocEiu5lNPzo7X052GEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C9UGwsZURAxttMcy2R8lpl3u9qiypy8QEsnv9icbYik=;
        b=TNyzSU8X7Nd6RtXBo1IqGOGRt9I9zPK4qZFTkU87sjK9sFfS1gHrte8aJcpwE2mnxi
         3GAIFsWkCLhLHaZWQBZ3dgRnmXHEJlhkZroJy8NIC8oaaJ4lrIxiTe+o8VMLfNiLxkYH
         C3g5Nvsdzh0I5feQEMDu+ONWgH8TG5LKNwS9HeoCL52REL85Zl7LbehBDWbHUoG1x1/p
         dy8mzClmZSIHtlAombDsmNZgnLzuQx0dJoc7x2UnNLkdEXy31HTfJwp4UFPJ5KcN+4Yb
         QrfxjTfS0HTChzps62g2ZuLz6d6BrPaUl20c00wCHp+tH0TUC1A2CWPQcBUs5qsU7Z4V
         NRYw==
X-Gm-Message-State: AJcUukcRSErhcT0Js7f8P2Ns3yW1grnnkJNw2VOwgN7DV5NNE9OWkysE
        LqZrFEtYLV3VWd4d6OfPzHecVQ==
X-Google-Smtp-Source: ALg8bN4j+lOlP2jaklAx0wLia0awvJ2TUvn83vAUMATSYc4QV/10q7XHeahwUWQSGEk/WcJQf2dG3Q==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr47734122plt.2.1546546705459;
        Thu, 03 Jan 2019 12:18:25 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y6sm104584409pfd.104.2019.01.03.12.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 12:18:24 -0800 (PST)
Date:   Thu, 3 Jan 2019 12:17:20 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        clew@codeaurora.org, akdwived@codeaurora.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, evgreen@chromium.org,
        briannorris@chromium.org, sricharan@codeaurora.org
Subject: Re: [PATCH v4 1/8] dt-bindings: soc: qcom: Add remote-pid binding
 for GLINK SMEM
Message-ID: <20190103201720.GE31596@builder>
References: <20181228185307.25645-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228185307.25645-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28 Dec 10:53 PST 2018, Sibi Sankar wrote:

> Add missing qcom,remote-pid dt binding required for GLINK SMEM
> which specifies the remote endpoint of the GLINK edge.
> 
> Fixes: 2b41d6c8e696 ("dt-bindings: soc: qcom: Extend GLINK to cover
> SMEM")
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for the updates Sibi!

@Andy, as this relates to rpmsg I'll take this (patch 1/8) through the
rpmsg tree.

And I'm picking 2-7 through the remoteproc tree.


PS. Please use a --cover-letter when sending a series of patches.

Regards,
Bjorn

> ---
> 
> v3:
>   * Fixed typo
> 
>  Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> index 0b8cc533ca83..587bb1ddc8cc 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> @@ -21,6 +21,11 @@ edge.
>  	Definition: should specify the IRQ used by the remote processor to
>  		    signal this processor about communication related events
>  
> +- qcom,remote-pid:
> +	Usage: required for glink-smem
> +	Value type: <u32>
> +	Definition: specifies the identifier of the remote endpoint of this edge
> +
>  - qcom,rpm-msg-ram:
>  	Usage: required for glink-rpm
>  	Value type: <prop-encoded-array>
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
