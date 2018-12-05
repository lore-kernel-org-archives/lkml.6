Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C3AC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57E620989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544050479;
	bh=AVS7o0b7+lm6ZVk2q+mkLoxyAyiVzAQZHqz8Pai+a8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hE+9lWRjw02q3sXLj1LdTaY+fjBAZafklAYOwooOnljJ6gxl2QtVlgAz829ldIV8L
	 5XgcjP3NqlelAUhHpvA7ZNm6jFE5co0grMpIlPbxomoKpehVv0y/eoJwk0SX6IgmeR
	 QKKLPONGMtH0ZrDMmlWfV1JbymSUQ4qMdliUlwNg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57E620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeLEWyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:54:38 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44408 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeLEWyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:54:37 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so19053647oig.11;
        Wed, 05 Dec 2018 14:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rNupeygO25bAORrcQpQPF8KCLv/J0W9v9dF40ZcPMQo=;
        b=FJpgNx2goNK41C9Ay2cCTHpSA3AfiROpvb2aqdkYV6HjQE81H5cYdmzfWcjpGUXAHg
         8jl0/SQAmjmqObu0efNkZDScqZL4gSboDegioP6YM7h4+sCJhbNtYoveT/SL6GXT++zt
         wJxIuQXFLFnrJQUT2b8uMOD1yVF62CQvkaufubF+JSO14QqUfqL0zuYO9+7zHjl1sGyy
         qE+vvSCLeRhvsJeGBHTxzd5sfQV9ijyPZLt47wQg1hevcHfVUEe+cNidvYxCEHXPXfff
         +ZoRt4MsrPK9DAPI1hPuBzIxm2I8OlQPQ0f6JcTl1KG6bS4k+P+PqRvE+Bqba7VYfuwa
         CAFg==
X-Gm-Message-State: AA+aEWYtFV+15l6Ecxj+EpaXKbkWdeXABt0dVmhluKNtvd5XGiCwjeWd
        G1tvBBhpGmDIQo7tB5oF/g==
X-Google-Smtp-Source: AFSGD/XHrhhpl9+PVSankcEZrKHzYk5LZm57I7WuSbstkGqApqFVIQ6cZgfsqaejNbsGV9C8rjhWVA==
X-Received: by 2002:aca:b707:: with SMTP id h7mr15038173oif.89.1544050476074;
        Wed, 05 Dec 2018 14:54:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r203sm8169861oih.11.2018.12.05.14.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 14:54:35 -0800 (PST)
Date:   Wed, 5 Dec 2018 16:54:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: qcom: Add shutdown-ack irq
 for Q6v5
Message-ID: <20181205225434.GA5059@bogus>
References: <20181120210209.9029-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120210209.9029-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 02:32:07 +0530, Sibi Sankar wrote:
> Add optional shutdown-irq binding required for sysmon shutdown on
> SDM845/MSM8996/QCS404 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
