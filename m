Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29221C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AC8218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546035218;
	bh=jjXNm6xh1RAVFF3mXMHP1dfQhx8UPO2/Zj+spuK+w/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ArayCdwQTDVaAtS1A3eJu4H2KikzwS3ciyCdGa5CYuNeAn0ND/eZGgXG6MI4kh1L/
	 Yele1G5ncCPsg3dJRc+2nXJxpipzosjs6gYeCpqAZ1NVItxZQqmlklKAmL4WdLena7
	 JaPlAJ+nLIQa4ge8VWqUBeMxDDHifgCHl3BUrGgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeL1WNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:13:37 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36083 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeL1WNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:13:36 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so28487113itj.1;
        Fri, 28 Dec 2018 14:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gkW/Wc4rMwQC2hhMxBSszaW9tO6sHpqbQpqxLrwQu7k=;
        b=aIfKBHPSyLaIG+FQyjcsxTmaL0gS/7KR0ACy2mhzM5lY8Bh2Ls5q1RjI3tZ0mGgqZm
         DFK1RgopiASFTx4nVGsc3VT2tqAS4nvCafc5V2PLP8BOtu4ps8szZICUTgKO7Zo/ehmz
         4nkplaNq+gTJYkSzUnugmnzvvbKC1W4LXpyoVYRd79rIyO0AHOBFbHxdpK8p6PUQJF5J
         FSYe8MAu/7B7JXE7NzksxAzF6tRtvrS+siS+8rgEPHGohWpaoBgTDvVSAarSuQt63DWw
         C76l1oEigWUH/AJwJRPFT6Qr6RtYL7SZA87qGoK4WkMaHQRwrU0ljn7o/zMPQ2XQn/WV
         cWYw==
X-Gm-Message-State: AA+aEWbkWxz5v4ylcAa13HPprzPPoYXJihCG4mwhR0wDk4TbGxK9FELM
        8DcfBSd07T+1EqNYNo9b9Q==
X-Google-Smtp-Source: AFSGD/VLeWTtdaOqawSmeZZe2c85TRMlxZaH4imn8HTj1VVbt1mXnnsLHBYwSeTvnVct7njGVnMQ4Q==
X-Received: by 2002:a24:1dce:: with SMTP id 197mr19978899itj.154.1546035214800;
        Fri, 28 Dec 2018 14:13:34 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id w16sm17388001ita.38.2018.12.28.14.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 14:13:34 -0800 (PST)
Date:   Fri, 28 Dec 2018 16:13:33 -0600
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
Subject: Re: [PATCH v4 3/8] dt-bindings: remoteproc: qcom: Add missing clocks
 for MSM8996
Message-ID: <20181228221333.GA16672@bogus>
References: <20181228185307.25645-1-sibis@codeaurora.org>
 <20181228185307.25645-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228185307.25645-3-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018 00:23:02 +0530, Sibi Sankar wrote:
> Add missing clock bindings for Q6V5 MSS on MSM8996 SoCs.
> 
> Fixes: 9f058fa2efb1 ("remoteproc: qcom: Add support for mss remoteproc
> on msm8996")
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> v4:
>   * Re-order clocks for consistency as suggested by Rob
> 
> v3:
>   * Fixup dt-binding documentation as suggested by Doug
> 
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
