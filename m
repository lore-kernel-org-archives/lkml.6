Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DC2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 13:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D7E20874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 13:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVdgN1Sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D7E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeKYAab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 19:30:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbeKYAab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 19:30:31 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF2C20865;
        Sat, 24 Nov 2018 13:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543066924;
        bh=6mSjNiclj3SfeMOnBF0js/IgccHVmjDZg3wDC4MMxU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DVdgN1SxzXkUBfiK1IAWpt3QFNa6lOgPMEk8P/fDbr+FJJpqdGD0EbdqvgD0edoga
         IVaWRw/oHipv9SDzM9MoR/Tv2okjSHTgkBpv02qJalIVAQ2VjS8XWIxQnG4swUo3pf
         GW9qGD1fMI8AGN8OpTvxN2R9SwVMEpv8jv+fDvmY=
Date:   Sat, 24 Nov 2018 19:11:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Remove __aligned attribute on
 zynqmp_dma_desc_ll
Message-ID: <20181124134155.GC3175@vkoul-mobl.Dlink>
References: <20181025180525.28378-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025180525.28378-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-18, 11:05, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/dma/xilinx/zynqmp_dma.c:166:4: warning: attribute 'aligned' is
> ignored, place it after "struct" to apply attribute to type declaration
> [-Wignored-attributes]
> }; __aligned(64)
>    ^
> ./include/linux/compiler_types.h:200:38: note: expanded from macro
> '__aligned'
> #define __aligned(x)            __attribute__((aligned(x)))
>                                                ^
> 1 warning generated.
> 
> As Nick pointed out in the previous version of this patch, the author
> likely intended for this struct to be 8-byte (64-bit) aligned, not
> 64-byte, which is the default. Remove the hanging __aligned attribute.

Applied, thanks

-- 
~Vinod
