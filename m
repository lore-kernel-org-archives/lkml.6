Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1141DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAAB2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAAB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeH2EjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:39:03 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40899 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeH2EjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:39:03 -0400
Received: by mail-oi0-f68.google.com with SMTP id l202-v6so6185071oig.7;
        Tue, 28 Aug 2018 17:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v+yTJrPfJNkJJNuoSksLRrPz5YxuPdVXL+6mIEy5vRU=;
        b=QBhL4JiPqTWpz0J9ZDjik4gvTJ0iyogwvN9/W2ry0RCfwQlgJCnEt5/vyqlm4QP+iF
         CnB6YAZG21tPZLHnRP7g3dskuDY9Dx3aIkMMCB/4rpCz7RaflHXXhtNWtPWu6iJv0xQo
         f3yUIwpplcODzcs6xj9ZxrX+1VR4liYLFE2xH9QNo3hi4Cw8PJja7+DmshtDXTF+wg91
         fOlDrVue5qFRV3RGr8ERr/VIC5d0Oyjbsh5hhWJxC6BTcbNpDr2lGrKRNAt5c59FNuz2
         d5KKHcBvHN9l2zpi+gx0c2jfJKrmZoYGWt5Py1P/EynYesxhrIbFp+Q9tAE4Yf2KrLAp
         NzDg==
X-Gm-Message-State: APzg51Bp0R/JMZf7Hi5QyEvr/VAL9fpdM/FV94pyfAdQAX2u/E/bk+hL
        t6rxzOtRuq4MT935Fmw8oQ==
X-Google-Smtp-Source: ANB0VdYkTRSg48sW36EJjLmnO43W2VC3VTKVWuwCKY4YjlNOqTvIQoWP9ceuaBX1SAUlNMJZZ/Cbdg==
X-Received: by 2002:aca:6285:: with SMTP id w127-v6mr497449oib.120.1535503490131;
        Tue, 28 Aug 2018 17:44:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z141-v6sm275916oia.56.2018.08.28.17.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:44:49 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:44:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: remoteproc: Add PDC reset binding
 for Q6V5 PIL
Message-ID: <20180829004449.GA3468@bogus>
References: <20180824131900.5353-1-sibis@codeaurora.org>
 <20180824131900.5353-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824131900.5353-5-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 18:48:58 +0530, Sibi Sankar wrote:
> Add additional pdc_reset binding required for Q6V5 Modem PIL on
> SDM845 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
