Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77352C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A5F2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="NvnfNzeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A5F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935977AbeFRS3m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:29:42 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:47521 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935951AbeFRS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QNCUvK+lot/SHqR2Vc7fpmhvJCUdW3lrmMTfMR3IVB0=; b=NvnfNzeJm9GYd3WYPJdprpqaka
        tbLR9ugrZ4QwZSNdlU4Z27MaraGpih2L/sCqkOg4b8uPra9+dEdOpxwjj7YEos5/okyWvndfp/llL
        UKxK1KYdcsnjENQorawkRwR/xhcV6X3aGrc+qiCg2dtvvc3tgVqIefLKoAoHAPeB4lX3PglVIuwB3
        fG5pMeaerg5Imrgvh7wS//HTNLW0VIIK3bKqvDxkmkHHW9WnwZnsv3qJ3BxlW2cttYAZokJ5WYymv
        oxqz3djI9kNatP7KlyYXy77Lv1PdbkyqOtAbBaJgkX5+TlcUGqAjHDXK4UUtSS18Ri7f0aKAL89gU
        FRmXDNzA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38128 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fUyuI-00064K-9f; Mon, 18 Jun 2018 18:29:38 +0000
Date:   Mon, 18 Jun 2018 11:29:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/189] 4.14.51-stable review
Message-ID: <20180618182937.GA29875@roeck-us.net>
References: <20180618081209.254234434@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
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

On Mon, Jun 18, 2018 at 10:11:36AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.51 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jun 20 08:11:38 UTC 2018.
> Anything received after that time might be too late.
> 

For 4.14.50-189-g3e67e20:

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 154 pass: 154 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
