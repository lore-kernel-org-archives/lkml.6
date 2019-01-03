Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E22C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224B721874
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546534882;
	bh=+4g2zqcbBgulcL7BSXFQ66SchqfsWOFlf4R/khSG7g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RUEVst7+DwfZVHfmd3BxEtdabWj3HS3U+ILdV237gLzR41laUawFxxjGvnWB4/BEv
	 Yw571tbDQoDa5QYtRQ4aQVpp1vUeeWt0ECwrVhUMX+mr+SeGpBXJcaNpRytGzJ23xL
	 vydF6X9rA7dX9O0Izowo/UuWDm8Q2e7Oeb/1o1SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfACRBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:01:21 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40803 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbfACRBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:01:20 -0500
Received: by mail-io1-f67.google.com with SMTP id k2so4896460iog.7;
        Thu, 03 Jan 2019 09:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pRVFSQbpENvurgfqZ28oJyPJE+LmcwzUul6Su+z3Ig=;
        b=Wpmux49ck+96mES+eQbQhIlsP1ZPsGkU0GpkZBmseMdwQIF2iDnGXYB4vDYzDPaHjd
         HEIflLwc47tnuGRnRP5klARgoTni0qFPMBeugCrst2SEePsXCvBDzPje4OX/uwhU0120
         5oFDtfq1TQaZuWvYYLhYb29MJ+/bq/KX5nl7Ig9IzKbH/6Y4PflT1IBvZ85DT/vDGZgZ
         ULkIE68JgrsI42fZlgJhVF45aTm+DZa8bAcHr1z2QkFjvflrsp4B8lWakNrNayoKqjJU
         KzrSZeULN2FBvivv6hpJlCjfWC54J8Jb/cedJsNzQ9objkf0qESR7YYGFVXJgY9FIbTv
         1EgA==
X-Gm-Message-State: AJcUukc4o/Kj4NnvYSqcdLiTR3W1mCyEDQCthuyiIc5jm8pWMcG9Uv/n
        i/ZubdljWv1C0BE1/Bs9iw==
X-Google-Smtp-Source: ALg8bN7B8ro8DGx8Y19hZLBLpi39Obu+oyy1+cxdTPH5WaKdPVLUrjmzd/I9ghuKakTn4USeGBMMUw==
X-Received: by 2002:a6b:8e03:: with SMTP id q3mr34004610iod.51.1546534879909;
        Thu, 03 Jan 2019 09:01:19 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id n26sm6568231iob.30.2019.01.03.09.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 09:01:19 -0800 (PST)
Date:   Thu, 3 Jan 2019 11:01:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: thermal: Add binding document for SR
 thermal
Message-ID: <20190103170117.GA11469@bogus>
References: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
 <1546505734-24527-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546505734-24527-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Jan 2019 14:25:32 +0530, Srinath Mannam wrote:
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> 
> Add binding document for supported thermal implementation
> in Stingray.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../bindings/thermal/brcm,sr-thermal.txt           | 105 +++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
