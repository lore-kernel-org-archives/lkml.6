Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2073621920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545416902;
	bh=z7LK2uMGRVPn1gYyoXetfRSgWzzYyCvpsbKm3ub1nf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=beVXiJRe+1WCTXcMqIPLy77xTR97i3SrHkgOGKiu/7eHcMu0TwIvxAXjYFR8Nc5jY
	 fmJ0xOYilBpNgJTr/nTdipoi6rew/z46EAuH8aXrsb9DHOy5M+IxNu/360P1dX1sLX
	 3yH6jCj+xmIgB4Fe/l9QKujieFpj+vwPfUROXdMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391475AbeLUS2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:28:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38971 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeLUS2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:28:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id i6so5508583oia.6;
        Fri, 21 Dec 2018 10:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xasl8uB29JgK0QgLnzAjIrJ45cPJvJPkGwc9Ekvw98I=;
        b=jnkGfi6Y2skoiKTDcsI1lDPSYcBZ9PqHCcvWymoEcP5S0rlC8OkPBkZdTTRnLe8Cpy
         /e2qrlx81HkaHa/IHg9ylCi69pJiNOoaqops6VEliBz5RM6NtFBryAK5y0fyxKw50Cna
         4CHfbRvQaA9nZwT2xA9l3djTTttQfv+c9msS1Ai8vNC6JqimktK1YWVoiTysa7PXB6Je
         Lo3Nq4BD8LidleX9FkCBv10mUL/fyawElYhYKR6tpB5SVI58hfMT3EzpLJq6whb4b9Ca
         mudG/0M/8zHdvbjMLWfN2idfSsDZEQQ5yL0S+g2kGMnNWv4q9dt0YcecuKtk9wxSZ6n0
         0u7g==
X-Gm-Message-State: AA+aEWbR2IAi0XEKPDowkrrtPnzDhiINeL1yIm4Bjh1dAAfeLg0DmlSm
        XbtTT+oaa5raBSrSKBnJhA==
X-Google-Smtp-Source: AFSGD/UQ1OVjzboZ2494SAiRFyNvLQY47RfStBMq+BdNc1YMV8nzFelwDhrdVoH1//ouP/zysglcNw==
X-Received: by 2002:aca:6c4:: with SMTP id 187mr2197234oig.290.1545416900019;
        Fri, 21 Dec 2018 10:28:20 -0800 (PST)
Received: from localhost (ip-70-12-27-227.kscymo.spcsdns.net. [70.12.27.227])
        by smtp.gmail.com with ESMTPSA id f18sm12854561otl.18.2018.12.21.10.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 10:28:19 -0800 (PST)
Date:   Fri, 21 Dec 2018 12:28:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dianders@chromium.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: drm/msm/a6xx: Document interconnect
 properties for GPU
Message-ID: <20181221182816.GA12981@bogus>
References: <20181220173026.3857-1-jcrouse@codeaurora.org>
 <20181220173026.3857-3-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220173026.3857-3-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 10:30:25 -0700, Jordan Crouse wrote:
> Add documentation for the interconnect and interconnect-names bindings
> for the GPU node as detailed by bindings/interconnect/interconnect.txt.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  Documentation/devicetree/bindings/display/msm/gpu.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
