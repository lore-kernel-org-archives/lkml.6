Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FED4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AC02086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZkQuFL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AC02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbeK1AA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:00:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35623 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeK1AA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:00:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so22628227wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Mld+3QWNPCt0K9kZPC+T07y+SWaca7XaDQXKXN9D8ag=;
        b=kZkQuFL6m0cSmqS3HB72lnWzfyHO6xYdOBs0Gy5Kz9B+0XxEqMRwEPEO52IlR6KaNJ
         xAukKvtBJexKw6FL6eidlYie0+sDEoD646Bw2JMn7q7OIzlzVlvTlSIR8588MP2Rnswd
         poYi4l160iZywxwXBt1JMjEdEsMg8/Tp6vRcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Mld+3QWNPCt0K9kZPC+T07y+SWaca7XaDQXKXN9D8ag=;
        b=CUP9FRLWSm9cT9E4QTFevE8z9HUoY5qIi6uXHXXH9P3aylfKkDt1QiagH50iQeTkw7
         kujZYGw5rZvf9iJ2NmAoltuCNidkZeiLSvqL5VmQouMYiFIvClmbf8P0gyhRG3EHyMOm
         gjaVvzqckCeP17zAeA3p8IQbGB3lqL0T0RIRUmKn5vMtPZpr8Cv0eG4gixgqI29X/cnE
         vGXaDWpBhn8Q+oHGlG6oZQ3KjvWSYnJ1f017duP+NHok6yjeHj3dR7+KvU6OPT6nRzj6
         7e4gnBhqCqO07A4YF7MAle3ds/YQU7fMBj6B81ret4GS4+XDkXCiABfFLk5V3pkKweAu
         /vkw==
X-Gm-Message-State: AA+aEWYz4m0ouRLFDBeH/Cz+Czr8IF3d6nbyr7iAWFY0veJJ65rrT4xr
        2Eg0O07oFXxlfb2D0bfbLgKJeg==
X-Google-Smtp-Source: AFSGD/VDtNd5YNUETMBrSXH/8ckva+lzjGNLBzQ/Rtn9cDgkZptSMfAi/Op7piZQVXnvYbrMdnNJIA==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr22709066wrx.306.1543323784564;
        Tue, 27 Nov 2018 05:03:04 -0800 (PST)
Received: from dell ([2.27.35.241])
        by smtp.gmail.com with ESMTPSA id 80sm6045554wmv.6.2018.11.27.05.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 05:03:03 -0800 (PST)
Date:   Tue, 27 Nov 2018 13:03:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     bjorn.andersson@linaro.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: qcom_rpm: write fw_version to CTRL_REG
Message-ID: <20181127130301.GK4272@dell>
References: <20181114224201.16225-1-jonathan@marek.ca>
 <20181119195317.22617-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119195317.22617-1-jonathan@marek.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Jonathan Marek wrote:

> This is required as part of the initialization sequence on certain SoCs.
> 
> If these registers are not initialized, the hardware can be unresponsive.
> This fixes the driver on apq8060 (HP TouchPad device).
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
> v2: updated the commit message to be more descriptive
> 
> I think its important to note that the downstream driver does this for
> all versions, so it is safe to add this.
> 
>  drivers/mfd/qcom_rpm.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
