Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D2DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE35920867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlaMRhns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE35920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeIDAVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:21:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38483 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbeIDAVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:21:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so563781plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PJurB58XLk0A3i4EfnY5BtfqQs/tRHYmavPlF3b54n0=;
        b=GlaMRhnsfES/LrZHCNQqxctpZAmgUrnEjo6gE70jSzI1jTB5+aJROtgnEaXwjQ7UHo
         ORF6w2L0/46N2d63MpRyfb8l5Q3uoa805V5UQa8ofSbfoergg7ufeXSi9XhOmE4MrOcC
         HURyZuvJX7jzUgAs57XlSqjSxYXJ6dHB8yk+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PJurB58XLk0A3i4EfnY5BtfqQs/tRHYmavPlF3b54n0=;
        b=tAX+CstdXw16pABkZUKuc53q846R4s+aHcclMcK2zBb95/6yUw2s0GEIIBkJKE3EM9
         Wg0B8+YeHMZlTRmXOTCh5hJQCTCIb4oCNHgQAfy8iYKJuSE9QMrtoMpph6oOjVw+XQU7
         hQH2Ljz17lhxO1Dr9UBD6qDpuQIuSPe/WFJeHi7Tc0wf1ajVE0UjywoBblSgw3Wipds7
         pX2DBJUGLBNSZHGq74q6Smluuwq4C/B5CydHqqIqpT0zCzKyB927+G/eiw48pSzmHXAu
         PHrThd1270AAK6I3pZXCR3l8iO7+FqfDSf+G9jaFoMzyH2tpI8hzb1FcnYMNHheLYnw9
         FhRA==
X-Gm-Message-State: APzg51CCxMqEh1dQrZJN4hWu4vAgyqvR1phfWHnpDS5CezwQhEaECc8d
        JE9h57K8QIxQkZiWr+Ej9uTKdQ==
X-Google-Smtp-Source: ANB0VdYXDpGMsrW6WkgwZ0N26uC0we190Y1ke7Tfv7th0btZXX5vf+u2f9Oxq/afJv9/tYaVnKeW/Q==
X-Received: by 2002:a17:902:22:: with SMTP id 31-v6mr29829392pla.190.1536004809548;
        Mon, 03 Sep 2018 13:00:09 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a2-v6sm21671447pgc.68.2018.09.03.13.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 13:00:08 -0700 (PDT)
Date:   Mon, 3 Sep 2018 13:04:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/11] dt-bindings: thermal: Fix a typo in
 documentation
Message-ID: <20180903200402.GN3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <8480b996596184a478fe74dfdb97ead7dba6fb11.1535462942.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8480b996596184a478fe74dfdb97ead7dba6fb11.1535462942.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:

> c(1) + x(1) was actually meant to be c(1) * x(1).
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index eb7ee91556a5..ca14ba959e0d 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -152,7 +152,7 @@ Optional property:
>    Elem size: one cell	the sensors listed in the thermal-sensors property.
>    Elem type: signed	Coefficients defaults to 1, in case this property
>  			is not specified. A simple linear polynomial is used:
> -			Z = c0 * x0 + c1 + x1 + ... + c(n-1) * x(n-1) + cn.
> +			Z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn.
>  
>  			The coefficients are ordered and they match with sensors
>  			by means of sensor ID. Additional coefficients are
> -- 
> 2.17.1
> 
