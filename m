Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88955C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB9321473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548863520;
	bh=ZhhlYqwvLh9toud0CIF64YLwTruget2QIq7kzw0Xoh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XBD0U3ys4Pca6vjOZQjf8sFeY3TRKfwi9v0bnFiXtyLFbYaKJivFCuZaI572OXELI
	 wHZhKUnZzBWNes42vl3JJUYnIDj6zUytiKfMrStdT77nT9YsIRRcpFDNIJyviFVOHZ
	 vqN8okOKKA6861tCmkXkG/mlfezNaBUg+TuJTH20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfA3Pv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:51:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43858 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfA3Pv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:51:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so21478582otr.10;
        Wed, 30 Jan 2019 07:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tDG0s+kaRFhXQDSossJsUVaZPHCqOg9/B1OVXT7MWPQ=;
        b=MOH2wKwJTV+o6TBqHeAH30eeOgbEl9yonCOk1DTaEIrugK9LGx5rKZ9uw3h0zl7UnK
         RIg050UFbGxpgk6X2ONFgBHxzn8sZK3exctie+4qhgNNw/ipF7A7oHuAgSx2yT/927i9
         uyTLlFkIruc98VZ7O+KzO+8bORWHb8dR5UGdD1v9/8ZlJ9RbmmdFoOaA/6JQ/XF7oNSk
         cN/YBEgUXuOg0zUEFOAwiN0hHNklLnYQA8wwzGoH7SgQpAfKfDEL164NKzS/wTVsG67M
         SAF1Q9K5nKjmSbrDujIQP+ZnMLJvjtUwSsZJJOVoSU2vZHR2H3mR3zbKqqB4HhU+fnEO
         FEKQ==
X-Gm-Message-State: AJcUukehFw05jX3fQGqBhgZwcUTzU1Q6IipFEmy+tglbkS+vTuoc1/Ne
        TuszEEMvNcnHyEPWL6HE7w==
X-Google-Smtp-Source: ALg8bN5JJSb/d1Q125YIh3Kk1fY2HVw6r+pOO50dRa6r7FNdKv9cj+l8uOUQmYxhQ9YqZD8nSIJ9mg==
X-Received: by 2002:a9d:18f:: with SMTP id e15mr23999437ote.84.1548863517715;
        Wed, 30 Jan 2019 07:51:57 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q26sm652009otf.73.2019.01.30.07.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 07:51:57 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:51:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        chunyan.zhang@unisoc.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, anrao@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: Re: [PATCH V11 1/4] dt-bindings: mmc: Add supports-cqe property
Message-ID: <20190130155156.GA31692@bogus>
References: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 11:30:51 -0800, Sowjanya Komatineni wrote:
> Add supports-cqe optional property for MMC hosts.
> 
> This property is used to identify the specific host controller
> supporting command queue.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> ---
>  [V11]: Same as V10
>  [V10]: This patch version moves supports-cqe property from vendor
> 	specific MMC property to common MMC property.
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
