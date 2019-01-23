Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80655C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC0620861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548246368;
	bh=2PraOFjPf/4zAPlqdONCVOlhzNvbCGfyN11TKJgKkTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=akDlIc090xgqJBbKRQcq+TUN0ihV4RcOtc/PTQLHv7Im6aW/qZMgPrw8p1WbYX0Lc
	 ifr1GmPXUDvXDP2KKfA/+HdeXUIKpthwRQqM4jHJ5fgf+/bHsou9A3mFPqEeme/RQE
	 mVsxi8Q1B5l3QY5Jlaf/6D21y4XDJBE6wTwLK5Eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfAWM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:26:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAWM0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:26:02 -0500
Received: from localhost (unknown [106.200.229.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F315F20861;
        Wed, 23 Jan 2019 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548246361;
        bh=2PraOFjPf/4zAPlqdONCVOlhzNvbCGfyN11TKJgKkTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fKeXKBDevNCp4PJjYL5vOWzaVDEp3lcFEMwn63+/iMfzPw3GNGMb2EHIJju2uRDfT
         m3M2FoRd1VVRWoR/9m1/BAVWYc1uTapTXeVqSd9MvJG83blh23+ui+QLym4OJ+F3Q3
         l7E8N2VLsu9WCzu8QYzs3Haw0Lb+PLVqYE5rEeXI=
Date:   Wed, 23 Jan 2019 17:54:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: Potential info leak: Kernel pointer leak?
Message-ID: <20190123122429.GO4635@vkoul-mobl>
References: <CABXRUiRP8fHvGkO3T9AOFV=prVUACiCm2frbAEnG2v6UhrTw0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXRUiRP8fHvGkO3T9AOFV=prVUACiCm2frbAEnG2v6UhrTw0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-19, 21:25, Fuqian Huang wrote:
> Hi, recently I came across some code and it seems to be able to leak
> kernel address?
> Is the following code cause info leak in the Linux kernel?
> The callback function address is printed to debugfs.
> The local user could know the kernel object address, and is able to
> bypass kASLR.
> linux-4.14.90
> drivers/dma/qcom/hidma_dbg.c:46
> function - hidma_ll_chstats

Doesnt %p not print kernel addresses anymore, see
Documentation/core-api/printk-formats.rst

> 
> The hidma_ll_chstats function in drivers/dma/qcom/hidma_dbg.c in the
> Linux kernel 4.14.90 allows local users to obtain sensitive address
> information by reading "callback=" lines in a debugfs file.
> 
> Similar to CVE-2018-7754

-- 
~Vinod
