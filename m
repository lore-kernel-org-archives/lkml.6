Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28367C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE56D20837
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE56D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeH2Ehe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:37:34 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41854 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeH2Ehe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:37:34 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so6181561oiw.8;
        Tue, 28 Aug 2018 17:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJnLS3wS0fGBmJ3prj+l4BjR/gEc4knBBnFY8NAIVjA=;
        b=DSbjjK8pRFvP7UeLepxERXobkb0hyKOHG5Wgx4Rcz9ECOnDtAbbxBzuwp+8c2pqpI5
         iWt6DNXks7GplYJF2GPbzORAD17cD1JAwNEGltwd0nouSaaovJuOfuhQEbT4rOvMegFS
         3dpaTMR/WOAK29KfmjMF23P/5wzZajk2ZShglgUe2Gl3H5OSOJsiW9qzoyZU192R49oL
         40Wy3jOcoP+IyaT/TBvKf92UQH08YPvRRVKmp/ggJUeIbhFJd1aseZASRz4jTuFAU6A3
         pP0MfCf38M2bPl/UbUUKkKTs1EWyw9YYv6KxTe1DBWoDbVhGoGF0RSL7ceboxKyeRZdD
         WYvw==
X-Gm-Message-State: APzg51CPOT3BLlwBx2d+OJw9tkAzYm2WRZVFSf6duYJlxFCKIFBDe1n4
        D2yOC+s5Ho/yszemWcU2Qw==
X-Google-Smtp-Source: ANB0VdZgsnC34pILVqd0MnkB9d90N4ZtLbkfFR4XJwF7BwD3QErUwjYiTu5WeaLCm/zzT+SobCnpnA==
X-Received: by 2002:aca:a6d4:: with SMTP id t81-v6mr469972oij.113.1535503401642;
        Tue, 28 Aug 2018 17:43:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n84-v6sm1359676oif.23.2018.08.28.17.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:43:21 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:43:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: reset: Add PDC Global binding for
 SDM845 SoCs
Message-ID: <20180829004320.GA1201@bogus>
References: <20180824131900.5353-1-sibis@codeaurora.org>
 <20180824131900.5353-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824131900.5353-2-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 18:48:55 +0530, Sibi Sankar wrote:
> Add PDC Global(Power Domain Controller) binding for SDM845 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/reset/qcom,pdc-global.txt        | 52 +++++++++++++++++++
>  include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
