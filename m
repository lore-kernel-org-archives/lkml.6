Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YknpIkiPGltJSwAAmS7hNA
	; Fri, 08 Jun 2018 14:14:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 73F046089E; Fri,  8 Jun 2018 14:14:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="UhXQU3Bt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EACD960290;
	Fri,  8 Jun 2018 14:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EACD960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeFHOO3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:14:29 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:51872 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeFHOO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dfMILGaiyAa6xsz/32/PkuS67Xcrrr7kzziAQp4wrk0=; b=UhXQU3BtAcwmfP0bY9KXJZrZrq
        O4GyQa7N3HEUs/AXTToV4kBWhmJ8QdU1GKKaTdhqGmSbLhKhlhTI1WE7CbVz3r25I7oq6YQGiUjbk
        65FzyBONGqSsury7cXJJogY2SgudVJwqXmA+R8R/cQjyVYlDdFuQTlUhM7jRyQYGtThA9AcKFS2fW
        t8XoCuVyLHnROgfhuz774LmTMA72jWhmfg3RnHnhd/+s2XgbSjWWPuIoj4JmLjSLWEa4AGwyKr6sr
        eMhQ+U7LX0cWfyHgCs5fes8Nyf4SPSsBm6eotfFlq9KtT6MGd76RZulf3lYFBQw8vEQ2H80AmuQFm
        2K+nDM2A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:46504 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fRI9r-0046kh-K9; Fri, 08 Jun 2018 14:14:28 +0000
Date: Fri, 8 Jun 2018 07:14:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.16 000/410] 3.16.57-rc1 review
Message-ID: <20180608141426.GA5242@roeck-us.net>
References: <lsq.1528380320.647747352@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
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

On Thu, Jun 07, 2018 at 03:05:20PM +0100, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.57 release.
> There are 410 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jun 14 18:00:00 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 138 pass: 136 fail: 2
Failed builds: 
	i386:tools/perf 
	x86_64:tools/perf 
Qemu test results:
	total: 116 pass: 116 fail: 0

tools/perf builds are new, so it is probably not entirely surprising
that they fail.

Deetails are available at http://kerneltests.org/builders/.

Guenter
