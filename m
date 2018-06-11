Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id X1/kCuqBHltWAgAAmS7hNA
	; Mon, 11 Jun 2018 14:06:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B30BE607BB; Mon, 11 Jun 2018 14:06:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="yXVuDHnu"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 512D460791;
	Mon, 11 Jun 2018 14:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 512D460791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933451AbeFKOGl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:06:41 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:54120 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933223AbeFKOGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=waK/pft7dHI/2nWgZj88ujOh6mLBgufYhj2a61nLOAc=; b=yXVuDHnu/P3yn1dlGgfa046/wQ
        I1MsTk1KrVpzy+KwAjJxPJfW0XH+LtudOlyZfLVHblPTUP3x/QwNZglm/ceYqWHrXus3gXWxS9nfy
        jNxiNc5t49oyeH13JTo29LRFASpoj5CBUSBVSlpjBh+uOSliNi1i2+nGwTogCoTDTShk=;
Date: Mon, 11 Jun 2018 10:08:58 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/13] memcontrol: schedule throttling if we are congested
Message-ID: <20180611140858.GB1507@cmpxchg.org>
References: <20180605132948.1664-1-josef@toxicpanda.com>
 <20180605132948.1664-8-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605132948.1664-8-josef@toxicpanda.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 09:29:42AM -0400, Josef Bacik wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> Memory allocations can induce swapping via kswapd or direct reclaim.  If
> we are having IO done for us by kswapd and don't actually go into direct
> reclaim we may never get scheduled for throttling.  So instead check to
> see if our cgroup is congested, and if so schedule the throttling.
> Before we return to user space the throttling stuff will only throttle
> if we actually required it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good to me now, thanks.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
