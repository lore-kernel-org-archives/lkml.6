Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46911C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014752089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDU1JaWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014752089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeJBVZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeJBVZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:25:23 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE482082A;
        Tue,  2 Oct 2018 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538491299;
        bh=o73yemGWZ9ZSBXYs0ahZVw1MndVXz6f8VK1WJXdcryE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDU1JaWnkmCLanCpz/upQE/1fKUW8vqfQyRnfQz+l5C636b5xHGc7Ke4F0YMkyYsD
         mlBfh58HaHr/NIu/RDKnXplVMdNbb+3nyHGkcvrYU/8WtBfL8Q+ZHidPrue0guzjLz
         lH2teFwU7Ay4yKqvxkOgj0iSEYSXVYDkwtqsYEVM=
Date:   Tue, 2 Oct 2018 20:11:30 +0530
From:   Vinod <vkoul@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] dmaengine: timb_dma: Use proper enum in td_prep_slave_sg
Message-ID: <20181002144130.GB19792@vkoul-mobl>
References: <20180911232025.4909-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911232025.4909-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-09-18, 16:20, Nathan Chancellor wrote:
> Clang warns when implicitly converting from one enumerated type to
> another. Avoid this by using the equivalent value from the expected
> type.
> 
> drivers/dma/timb_dma.c:548:27: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>                 td_desc->desc_list_len, DMA_MEM_TO_DEV);
>                                         ^~~~~~~~~~~~~~
> 1 warning generated.

Applied, thanks

-- 
~Vinod
