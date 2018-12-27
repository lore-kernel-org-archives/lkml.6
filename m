Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA4EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA0A214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545947733;
	bh=QHuHbp0K8ZXS8JWLw/8yjxTAKp5bopzXiD5kwRNeF/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NOjZst3MNAlhdgT+TFWV8hAyfQdtXRDvmA8u3u0D2C2xQ1ArYt7fux1cSI6wsQHe4
	 /CvSZsqOKPQqPKhLB1WI4lErcIuik/Ana7vfBt1ojT9UFUOLDQWmqbhY4ya+6mWCES
	 MfiS75Ytrwjq30tHxqSVbKzli/N+FhWOjPdZXvE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbeL0Vzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:55:32 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45421 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbeL0Vzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:55:32 -0500
Received: by mail-io1-f66.google.com with SMTP id p7so4646216iog.12;
        Thu, 27 Dec 2018 13:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k0U7J2xOIEEC+eWkilrMlWfIWSU0tnSbCNiiL3pABK8=;
        b=Un+goGwI8f+HtG0GtGO1o67StWSSUL+Eds3fOTUsLd3eBVSbbdA1LcvhrNShEXimpW
         PdS3g7LNNe9QIEJe8ti6cpM2FOFOqtr2o4+ltiuBOCPNQysJMcWk6CNuLteMq+77NaPg
         B/KOFq2GVl9+ft6sWHnKt9pq3qcTEY6wmE4re0zDHrdxqYI+IRIhmFGi/7IC/yZWL2EX
         WRRIB4+mah0C9dfTZAoeUnXSeOLqWS7bgnlyt28mLNj4vXpsBZVfE1F5vop1FW+N7dXk
         /cav+TkOZNY+PGo7afS+izHik4S2jRBD0bA5OKBCqcEOFbW+FwVkTCCZcEF29cs7Sham
         Y7Rg==
X-Gm-Message-State: AJcUukeq/eiSVN0CZKbwuELYgjPCUJr2ytSnKaFqVwoLfj9+wnMXmf+7
        bEcUPORH+sf3WSE926NIFxC5udg=
X-Google-Smtp-Source: ALg8bN7mH6HQCvMJLH8zx9yWurN0Uz5QjqtUOCNzsdt/52P/Ueujz50bHUvPv1SP21xcxvm9c6Px3A==
X-Received: by 2002:a6b:3bc8:: with SMTP id i191mr18307377ioa.23.1545947731029;
        Thu, 27 Dec 2018 13:55:31 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id e16sm19699465iob.43.2018.12.27.13.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:55:30 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:55:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: remoteproc: qcom: Introduce
 shutdown-ack irq for Q6V5
Message-ID: <20181227215529.GA13758@bogus>
References: <20181224084824.25193-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224084824.25193-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2018 14:18:21 +0530, Sibi Sankar wrote:
> Introduce shutdown-irq binding required for sysmon shutdown for Q6V5 MSS
> on SDM845/MSM8996 SoCs and for WCSS Q6V5 on QCS404 SoC.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> v2:
>   Make shutdown-ack mandatory for MSS on SDM845/MSM8996 and
>   for WCSS on QCS404 (Dropping Rob's reviewed-by due to this)
> 
>  .../bindings/remoteproc/qcom,adsp.txt           | 17 ++++++++++++++---
>  .../bindings/remoteproc/qcom,q6v5.txt           | 15 ++++++++++++---
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
