Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14152C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD40E2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD40E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeKRCFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:05:13 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33740 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRCFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:05:13 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so16520968oib.0;
        Sat, 17 Nov 2018 07:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q9qXbVr9432g49R7wHi5hUvG/yffLgeLdpEqi5AVWGo=;
        b=LT8BpNDt4q2M6lCOMMLauVZ2tSuy+66TOK6Ee33ACvgCXAKmHVao783qY5uY4J4XtQ
         4oDtr0mHA45+gClaKDjjeVd3ElE0XCcyB1WUBKPZQRkhcYo6JLFFK4YUEVYWquIbPhSx
         b6LY+0DpWL5mJsCZXDxiDj6dYY4oVWB/qvbB5cozvjDX70svRTjJhYp+5BIj0eNjLiKu
         lfKOvVqBW2hGcIYpAB5WmBbS8Khet2wfRx1j9XncNuJ4dZ3qqdrm6DehzgxwyrGVRGfN
         03ws8GaaECskoVQLayCHpulvixE+jBUUYshutdC5hNcZvUK8XeVPRpTcnibgJVzcOnBG
         ccxA==
X-Gm-Message-State: AGRZ1gIYfxh7iZtEbYOZqmTp5tFDpHCLBnDmwNWMip5ao6S0blYjzoDN
        wSLXErl2ku/99MtDbYWwJ3fPHYc=
X-Google-Smtp-Source: AJdET5dcrWaSZt5o1tNZ7Ivgy6+2IIWpUAa6FyPxj/XieUgEfN+hCtJHVnZRQgO+4IqSNKEEvTpV/Q==
X-Received: by 2002:aca:c088:: with SMTP id q130-v6mr3564952oif.353.1542469689426;
        Sat, 17 Nov 2018 07:48:09 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id f9sm12544806oth.17.2018.11.17.07.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 07:48:08 -0800 (PST)
Date:   Sat, 17 Nov 2018 09:48:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, todor.tomov@linaro.org,
        hansverk@cisco.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: media: i2c: Fix external clock frequency
 for OV5645
Message-ID: <20181117154806.GA11193@bogus>
References: <20181114121338.28026-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114121338.28026-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 17:43:38 +0530, Manivannan Sadhasivam wrote:
> Commit "4adb0a0432f4 media: ov5645: Supported external clock is 24MHz"
> modified the external clock frequency to be 24MHz instead of the
> 23.88MHz in driver. Hence, modify the frequency value in binding.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v2:
> 
> * Removed the wording about supported frequency since the hardware is
>   capable of accepting freq range from 6-27MHz.
> 
>  Documentation/devicetree/bindings/media/i2c/ov5645.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
