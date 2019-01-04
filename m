Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01313C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9AD2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546612708;
	bh=LdWbIamEbin08Yoq/X91/PMOtOjqncowLu1f7vCFvwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g4oPs9DNolzveCzI8EYO72HJTYY8Eak5dVvm0142BrRvsNZuoDQDanHD9jjRXrBED
	 E/3/DOc3HOCnz7H11g0Y+MVyA38LvbrwZtgNsQgyGJAVQQfUKXQwdm3sVmaiylGbG4
	 01wdBaPWwur+I2o24+AD/mSX9vkIIlJriMNZlTjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfADOi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:38:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfADOi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:38:27 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB60B2070C;
        Fri,  4 Jan 2019 14:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546612706;
        bh=LdWbIamEbin08Yoq/X91/PMOtOjqncowLu1f7vCFvwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhiHV0/zZpzr5ixNq3RMPwTyfzIDZzm2Ig5oujLvL7++dhoEU9vqHu+4NdHcVTb+g
         NLSWbh+AIJjitLfNGgnCSIAU+wkzis57iNKcF4PsllyRQKZpTKBXXGDA947EJPdkQZ
         EITyp6WUt197V6BciiVicd7bfUyG8jjcnXtAtDnc=
Date:   Fri, 4 Jan 2019 20:06:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma/mv_xor: Fix a missing check in mv_xor_channel_add
Message-ID: <20190104143648.GD13372@vkoul-mobl.Dlink>
References: <20181224174154.19904-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224174154.19904-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-12-18, 11:41, Aditya Pakki wrote:
> dma_async_device_register() may fail and return an error. The capabilities
> checked in mv_xor_channel_add() are not complete. The fix handles the
> error by freeing the resources.

Applied after fixing subsystem tag, thanks

-- 
~Vinod
