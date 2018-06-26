Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB26C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD41268D1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD41268D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeFZVMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:12:07 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43227 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeFZVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:12:05 -0400
Received: by mail-pl0-f66.google.com with SMTP id c41-v6so9115655plj.10;
        Tue, 26 Jun 2018 14:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J9UvTTfI/mwJqGTwxKbtlhGJpK2RmyGCESSi/1rYCFQ=;
        b=U048LhZ6LBRZyGyVqNvkuv/79vLt2KFe15jX4iirzuJM0ohVC/wNhKh3fb1qqi2hZI
         1PsefvQ1zSDaQHa1ZnXCTBFSssfpMx6rW7JoK/WtrWfc6z8iAeLjeYpeYDwstQAXseED
         fxkNB5YTQwIFToWRfY/F3TQ6qJlHj5cMi/Tmg5iNSmtIIkI/DeAK0AS4VjFI/f/n63jV
         Cvs6HU9ualIC4llp2zswAc0tKDmOEx59mAtGLl82uun45Xco5gk2VfHaptsHnIS7JRhF
         oUZ/FEQwUXY/KjRs7RTfuW9wWD2c1qVCLdzCmYebW9XXGDZmkccbp3z4sTFctj/uirq+
         TJEQ==
X-Gm-Message-State: APt69E2yKDsc0593YP1W9MLInOywdwgJ5IcuQOGuMbR6cWU+BjJskDnc
        2MePNUCOcslPmL5Kb8KnAw==
X-Google-Smtp-Source: ADUXVKKETt3wmrJXLKJLwN4lGXCdsHStn5CZF4ZwK87/5qKcOwh0Yd/PxzeBp8arscqxZbui2VsNsA==
X-Received: by 2002:a17:902:968c:: with SMTP id n12-v6mr3165207plp.15.1530047525022;
        Tue, 26 Jun 2018 14:12:05 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id l15-v6sm4345221pfg.88.2018.06.26.14.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 14:12:04 -0700 (PDT)
Date:   Tue, 26 Jun 2018 15:12:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] Documentation: dt: keystone: ti-sci: Add optional
 host-id parameter
Message-ID: <20180626211203.GA19874@rob-hp-laptop>
References: <20180619194421.3432-1-nm@ti.com>
 <20180619194421.3432-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619194421.3432-2-nm@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:44:20PM -0500, Nishanth Menon wrote:
> Texas Instrument's System Control Interface (TISCI) permits
> the ability for OSs running in virtual machines to be able to
> independently communicate with the firmware without the need going
> through an hypervisor.
> 
> The "host-id" in effect is the hardware representation of the
> host (example: VMs locked to a core) as identified to the System
> Controller. Hypervisors can either fill in appropriate host-ids in dt
> used for each VM instance OR may use prebuilt blobs where the host-ids
> are pre-populated, as appropriate for the OS running in the VMs.
> 
> This is introduced as an optional parameter to maintain consistency
> with legacy device tree blobs.
> 
> We call this with a vendor prefix to prevent any possible confusion
> with SCSI ID (m68k) kernel option.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since RFC:
> * Commit message update to elaborate usage in VM
> 
> RFC: https://patchwork.kernel.org/patch/10447753/
> 
>  Documentation/devicetree/bindings/arm/keystone/ti,sci.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
