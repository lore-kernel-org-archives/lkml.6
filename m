Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF95C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEDA2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEDA2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeKRC6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:58:22 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43239 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeKRC6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:58:21 -0500
Received: by mail-ot1-f51.google.com with SMTP id a11so20479512otr.10;
        Sat, 17 Nov 2018 08:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hJxHP94TwUWvuuVElNci11pG4BxvqPKb7cjDDpOLfwY=;
        b=Vs6wxirJ8BL07CL56WuWORIXkTTOLYQohOWBLRbtiNGWZWP3tojEynbDGdZ/uZnEDn
         Ii5W4Vcn0C5FDiWDvcnpTrYlPaYURWWKcbkft2aXj75WLCzlbHp7kGmWXo0Au6pWVAip
         +94Oc9cVptRbSmRJCa4tATR5tuNwdfi1GIoklsG2M+YSrKYJTA4/eKLR3I5tq4fdUk2u
         q2PdUpYfDs+cANj9t+6vSf4BBtsb8nFM318/jFSgXfLY8jBDls0Kbt9JHUtnVxAxDAGB
         bArAP+drHNy9Yf3tIEi+etM+XcACgCqiC83GmFft1LheUiToXgno+T9HOEzGqBiAIepY
         qiYw==
X-Gm-Message-State: AGRZ1gLNlsQpZnORfrwNfeg48jw5gdP2EAZFLt5OmClceoE//vN5od8h
        dwovAoN0weD3sz5/ezSHqnUJ6Ec=
X-Google-Smtp-Source: AJdET5fgtpw1ojfsguCLTVXLVN+RjhNWVvJs/Z/aNDVJXg7vSZqravFU4o6+3NO496xkqgHDs32ORA==
X-Received: by 2002:a9d:2e0a:: with SMTP id q10mr9716494otb.176.1542472867641;
        Sat, 17 Nov 2018 08:41:07 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id p203sm15868335oic.49.2018.11.17.08.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 08:41:07 -0800 (PST)
Date:   Sat, 17 Nov 2018 10:41:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, todor.tomov@linaro.org,
        hansverk@cisco.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] dt-bindings: media: i2c: Fix i2c address for OV5645
 camera sensor
Message-ID: <20181117164105.GA19803@bogus>
References: <20181109075643.17575-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109075643.17575-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 13:26:43 +0530, Manivannan Sadhasivam wrote:
> The i2c address for the Omnivision OV5645 camera sensor is 0x3c. It is
> incorrectly mentioned as 0x78 in binding. Hence fix that.
> 
> Fixes: 09c716af36e6 [media] media: i2c/ov5645: add the device tree binding document
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/media/i2c/ov5645.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
