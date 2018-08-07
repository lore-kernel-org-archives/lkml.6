Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78EAC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609922154F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609922154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbeHGUQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:16:31 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37002 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388577AbeHGUQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:16:30 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so14762938ioh.4;
        Tue, 07 Aug 2018 11:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L8ZO4jSdzTHk+7VZQ0B6fBuITNcX4MWq1x1LT5rpgck=;
        b=UlbPr6/33AAL8n1N8YiJdiP5Q1ed/iGKgkDF6KUa1BBcqob2EICGBg91w2V1t9TfhD
         eNG3/1V8Muu0tVEmllu/pTZ0MzfhOm0q73ira7NKshv4cP1LO4TQRsE9y/zd5jIe4iKU
         hQ2iURnGnXS40PeBuCVQdM4BYW2uZrnolnX8Q9+Z8YqDR5GoX47NinI2s/2F7T+2Zw7W
         3YyYNcD4VmYHr++zPaIk45ier/dpx0ZMqhy7fyFJLu4j3VZOxY0klBKMSirogBr3pmiP
         lEeAXB4ICXFKIcv5+R0kkC5LWx1ypPkyLokpn7ZZvrGqQ4WIAKFfXJ8mo3c7WUB9wnZ6
         5/Dw==
X-Gm-Message-State: AOUpUlG8lPUT8Pgvyv2cXmaZB0hXgCDgvCliZ2WIKqutdhITipSuu2Zy
        1fkOXUpjgN1pac0NnuzwPQ==
X-Google-Smtp-Source: AAOMgpfCtFMg+EVlbXRUvTzxx6OdrWyqgiJhRkl0ciAoe6K/K/GM+XJCYPHmYjpwy3VOLgnnCam7Jw==
X-Received: by 2002:a6b:c8c8:: with SMTP id y191-v6mr19521103iof.295.1533664860672;
        Tue, 07 Aug 2018 11:01:00 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id x14-v6sm1503881ita.18.2018.08.07.11.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 11:00:59 -0700 (PDT)
Date:   Tue, 7 Aug 2018 12:00:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     joro@8bytes.org, mark.rutland@arm.com, dinguyen@kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: stratix10: Add Stratix10 SMMU support
Message-ID: <20180807180059.GA4415@rob-hp-laptop>
References: <1532543077-8933-1-git-send-email-thor.thayer@linux.intel.com>
 <1532543077-8933-2-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532543077-8933-2-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 01:24:36PM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add SMMU support to the Stratix10 Device Tree which
> includes adding the SMMU node and adding IOMMU stream
> ids to the SMMU peripherals. Update bindings.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> This patch is dependent on the patch series
> "iommu/arm-smmu: Add runtime pm/sleep support"
> (https://patchwork.ozlabs.org/cover/946160/)

I don't think so.

> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 25 ++++++++++++++++++
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 30 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
