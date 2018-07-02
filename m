Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB37C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D836525D46
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1eUddB8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D836525D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeGBMRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbeGBMRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:17:13 -0400
Received: from localhost (unknown [122.167.89.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 386B1256B6;
        Mon,  2 Jul 2018 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530533832;
        bh=vD9eB7J/CsbPRyW6rFZUdTw63ssPOOiQWvV21bzem4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1eUddB8BShTnlgQzZ+0YTdepSAV+I2BfzYqTZAxdoR9QW16lSYs3kVyAgJRcboCCU
         1sV9PC44zOKFgNFBtS46OrrolXNF9mh/hmSoPM3T7YdaH0cnquXKo+nwCfUFw7zWsU
         5aF+YfKi3eHPK8bRzMwRNDGejwEp3opmDcyZ8k7Y=
Date:   Mon, 2 Jul 2018 17:47:04 +0530
From:   Vinod <vkoul@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: ste_dma40: Remove VLA usage
Message-ID: <20180702121704.GI22377@vkoul-mobl>
References: <20180629185107.GA37488@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629185107.GA37488@beast>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-18, 11:51, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a pre-allocated scratch register space, set up with
> all other other allocations.

Applied after fixing subsystem tag, thanks

-- 
~Vinod
