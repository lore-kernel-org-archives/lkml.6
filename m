Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB0FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F2D22544
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F2D22544
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeGCCcQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:32:16 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45636 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeGCCcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:32:14 -0400
Received: by mail-yb0-f196.google.com with SMTP id h127-v6so147590ybg.12;
        Mon, 02 Jul 2018 19:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ozakUAXpueTnPEdpdzw9hyQ2HgbwS+nxywZhkCEvfss=;
        b=q/m9/fL8f1jV0aSikkRw511N2oZLAr8Tfh3LN0LG7AIIH3ZSUZm7MOJBTLPHMLYGwT
         +bLxH40ld4FNvL6c+9szofOvOplDMyEUeTJpkkURh+7EjBGVj6rZBfRJKX/X/D99+POV
         NGdK+6oyaLE6ldCuYN0N+colct0+WfMDEPq11OviEBwFxF2lp79dDPV5b3K5GbAQxKPR
         jc1qhsOn8MVnVmh/YrNHMpOC4VU5a85GRKsRsaRMQENrZixV9o1Z3Dd76NzXMbM+Rbfm
         Uq5LxZRI9HIya3AzUZ9Lkim2HrnV3ZlmR/JpeqZHyV9sXOVH8LWE4D51aUBdDFXChtuZ
         K31g==
X-Gm-Message-State: APt69E2SHzruJxx15RIXsLnPwtJOot+t7Jr5vDfP9fe4+WQjlE0xbiD9
        /4VJWLUK6wFKIpDrgqOI93Pq92M=
X-Google-Smtp-Source: AAOMgpcW/1U1iMANt005BFTwgECkG0uoNdQQIAQ572Syb7LPvqwnU00C3QvcjgTJLjQDgEoHS6uk9A==
X-Received: by 2002:a25:8e10:: with SMTP id p16-v6mr8629138ybl.121.1530585134071;
        Mon, 02 Jul 2018 19:32:14 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id o126-v6sm9615ywf.102.2018.07.02.19.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 19:32:13 -0700 (PDT)
Date:   Mon, 2 Jul 2018 20:32:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     p.zabel@pengutronix.de, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, kyan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v6 1/8] dt-bindings: reset: Add AOSS reset bindings for
 SDM845 SoCs
Message-ID: <20180703023211.GA24698@rob-hp-laptop>
References: <20180627142443.1570-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627142443.1570-1-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 07:54:42PM +0530, Sibi Sankar wrote:
> Add SDM845 AOSS (always on subsystem) reset controller binding
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> Not including Rob's earlier Reviewed-by due to change in compatible 
> 
>  .../bindings/reset/qcom,aoss-reset.txt        | 52 +++++++++++++++++++
>  include/dt-bindings/reset/qcom,sdm845-aoss.h  | 17 ++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h

Reviewed-by: Rob Herring <robh@kernel.org>
