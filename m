Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB4DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4501B20874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+XNoftW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4501B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeKYBTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 20:19:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbeKYBTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 20:19:17 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F19EF20865;
        Sat, 24 Nov 2018 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543069843;
        bh=A4zoPxwszAA40d/qMzG+I+iaGq6X+d85x6qeX5pxghE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+XNoftWJIG40VYYpB6khiPL9eAVBOBqDap6IE1l27kl8L386nAG4Vmcz8S960C4i
         QN86QTcEkiDWHfF3NxJDxKYMGjUk22ydgFkbpFuNi68vxKaYUlD6XsL3AJ61m3Z0OF
         CFiiZABVKRHoJq1mvT4848WzySF/6jAjqJAu1/wk=
Date:   Sat, 24 Nov 2018 20:00:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     linus.walleij@linaro.org, dan.j.williams@intel.com,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: coh901318: Fix a double-lock bug
Message-ID: <20181124143035.GJ3175@vkoul-mobl.Dlink>
References: <20181106033348.27361-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106033348.27361-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-18, 11:33, Jia-Ju Bai wrote:
> The function coh901318_alloc_chan_resources() calls spin_lock_irqsave() 
> before calling coh901318_config().
> But coh901318_config() calls spin_lock_irqsave() again in its
> definition, which may cause a double-lock bug.
> 
> Because coh901318_config() is only called by
> coh901318_alloc_chan_resources(), the bug fix is to remove the
> calls to spin-lock and -unlock functions in coh901318_config().

Applied after fixing subsystem tag, thanks
-- 
~Vinod
