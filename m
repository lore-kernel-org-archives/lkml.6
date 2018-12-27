Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D60C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDAA21741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545945604;
	bh=ygIkdRZuCIset6eJnyl6gzrbp/iXgMFgWBKsljXZz88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hKLvEsPseUuMC30GlwBoRYtOUyk3G11jQKDHUEoLAU0Xkda20yUe9m7FJBuKEBKkd
	 5yNsQWWTiB5WM98vjoCZ9xDo7FNTC9UN+8rCzML/yjLjWy2Gn6yR8Isx8aJ5wnJafF
	 3+ZsyW4irF53zxuRZOxONaO78PMXC67+0KFa6tNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbeL0VTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:19:54 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37595 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbeL0VTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:19:54 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so25135298iti.2;
        Thu, 27 Dec 2018 13:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=54R7iCFFkDkl3ne0KZVs72iF7lO2XrWbCMH8LzF8ie4=;
        b=B5OlCL6yyr+mKOHvnOrCn3kQdRfPuhVVQd+EEheTaEVzKSX6PZMNSzbCeAwEkv5FZM
         s5P2Ckbumakk/cDcYf4/ovUssukiaOGavVnjFVsTV+GpTFZG266LP/jJ0OS5Q3yGIjJj
         DthEL9u1MO/mE1gDUeqeDdwBs84P19x1auradS7NsfGQRyfpqn3ZSH8n1MaeH0Rz7WY/
         RKNrUKPpczczjePH4NOoztRFNzrHNbdFdxiPghcGfm8eIPsGLUaA7g/pmWDs7WK/b+OP
         9kkKBxF0qgZsUSEm7AInDFml7MTt6IbhBr4qyzDt6HdBg6OdsUmVns3eaWmOkq4dVzs2
         QdqQ==
X-Gm-Message-State: AA+aEWbXb8KqtE3N9foiz9CsMn+SBqyUD8rNcsg77aOOQ2mF3br6dz/7
        eaRzOsfJhK0kHEQ/X+p3Sw==
X-Google-Smtp-Source: AFSGD/WwGaKxmndQeyIx5m5e8QIaql5bepgeXlzRMfKYFD6pbEY+qu66P1aFDI6ZICozx66O6a7XRw==
X-Received: by 2002:a02:b464:: with SMTP id w33mr17166778jaj.131.1545945592827;
        Thu, 27 Dec 2018 13:19:52 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id u126sm14874180ita.1.2018.12.27.13.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:19:52 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:19:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        clew@codeaurora.org, akdwived@codeaurora.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, evgreen@chromium.org,
        briannorris@chromium.org, sricharan@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: soc: qcom: Add remote-pid binding
 for GLINK SMEM
Message-ID: <20181227211951.GA19726@bogus>
References: <20181226125229.20149-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226125229.20149-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2018 18:22:22 +0530, Sibi Sankar wrote:
> Add missing qcom,remote-pid dt binding required for GLINK SMEM
> which specifies the remote endpoint of the GLINK edge.
> 
> Fixes: 2b41d6c8e696 ("dt-bindings: soc: qcom: Extend GLINK to cover
> SMEM")
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
> 
> v3:
>   * Fixed typo
> 
>  Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
