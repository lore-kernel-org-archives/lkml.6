Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8P+5I7RTGVtwHwAAmS7hNA
	; Thu, 07 Jun 2018 15:49:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 105E06063F; Thu,  7 Jun 2018 15:49:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="yViGDaBp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 69EB860290;
	Thu,  7 Jun 2018 15:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69EB860290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbeFGPtU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:49:20 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:47875 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932779AbeFGPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gf9Ynfbx35EOav16bCLBi9cQ8oxP+dr54isRhPoN1wQ=; b=yViGDaBpcZqBjnMk0fM15n1EZK
        XRRUUny6BwwNpCOyTkcqotbIL7oen9EWMYExayYT4SyWT/P5H50ykwAOPkhnDiq44pgRoimHIY0gB
        HvrwC/JrvkgRIRDtu5utG0rg+oiHy8F3qf37fXyy0dv+kpmEEfyhneGvM63+JukaLWDVGaYVMArVH
        pydwCmj9g7shYTFgq59lGvV9XbBxSsX+b5Nels4XsfIVCK/MmCAET3V1OyGK/BWHJ2joqkxl4AH/C
        ooGeDZxvRd5XLdT6lLXTSnkpEPNUB/7bMpRLYXoRtTEynsZqFmOL+hHLT+tOQRxN3XTvlq+I/0xAe
        ekzMEV5A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41400 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fQxA4-002OHT-9t; Thu, 07 Jun 2018 15:49:16 +0000
Date: Thu, 7 Jun 2018 08:49:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Chris Ouellet <rabbit.of.war@gmail.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ryzen 2700 Temperature offset?
Message-ID: <20180607154915.GA7061@roeck-us.net>
References: <C85830A6-BCC7-4137-84E5-38503873F278@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C85830A6-BCC7-4137-84E5-38503873F278@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 11:03:13AM +0800, Kai Heng Feng wrote:
> Hi Guenter,
> 
> A user thinks the Ryzen 2700 temperature may not be correct [1].
> Can you take a look when you have time? Thanks.
> 
> Also, where can I find all these temperature offsets? I googled but with no
> result.
> 
Problem is that the offsets are not documented in public, making it
difficult to find out. For Ryzen 2700, there is currently no offset
configured; I was told that there is none. For Ryzen 2700X, the offset
is 10 degrees C.

> [1] https://bugs.launchpad.net/bugs/1774817

The key here is the commit mentioned in the log (1b59788979acd). It does
not only adjust the per-CPU offset, but also takes a configurable offset
of 49 degrees C into account. You'll need to apply that patch in your
kernel, or the temperature may be off by 49 degrees C.

Hope this helps. If not, please let me know. Note that I am travelling;
responses may be delayed.

Guenter
