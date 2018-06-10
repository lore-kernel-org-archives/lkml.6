Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2EK5CsBCHVtFGAAAmS7hNA
	; Sun, 10 Jun 2018 15:24:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0583760791; Sun, 10 Jun 2018 15:24:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="c3Hlzldy"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7A212601D2;
	Sun, 10 Jun 2018 15:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A212601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeFJPYp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 11:24:45 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:44235 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753375AbeFJPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 11:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1KM6sD8+eBDoSy/eOXvOA9UdRfpMMTyglvd82UcdjEw=; b=c3HlzldypJDzV/rXwY26TjIXwS
        hWFV3k+4BBxdSIoOKUhOgHNdraaI0vW1eW2c7bfHXUrTt7YCiBO9/PXzBNn1XOrA86DjhVym7hBa0
        b8IfnCQTgK7iRKhqW+QHOngxon5gSFbQlRFWaL6oWwtbxLDy7dCvil9k62fOpeegpGGpz5MzW8Rwa
        XNGzMQdLqIC1JiaaAZg8ejpUj1TS/ZPzTeA7wjRSQ+qWy4EdoJMAhf9Ao0iDkgwPsOPK7q/hg0nCQ
        nwPKC3KZHE7LiH/W9u1F5METpnU1OyiKajhUtNf4ghdgvGQCdHKDfihvWS4BTO82hKTDKgrauzswS
        5q5wjeAQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:56684 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fS2Cw-00FckT-GH; Sun, 10 Jun 2018 15:24:43 +0000
Date: Sun, 10 Jun 2018 08:24:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/48] 4.16.15-stable review
Message-ID: <20180610152441.GC29924@roeck-us.net>
References: <20180609145947.679103414@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
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

On Sat, Jun 09, 2018 at 05:29:12PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.15 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Jun 11 14:59:28 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 144 pass: 144 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
