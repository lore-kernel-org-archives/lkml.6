Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111BDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD2321479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7bPHGIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD2321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeKUSid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeKUSid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:38:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B3C72145D;
        Wed, 21 Nov 2018 08:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542787503;
        bh=+i/VeEj1dvIpkgacGPqFfM0WMJHScJAXDtAisf7ZCLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7bPHGIkLJN3S+0OqSm6uSfcg3HMZcnkoVCqDEfy0gWGxw/ozMn7CuZXaGw818DCY
         JEaOCMmZJG2A3Ld7uSAMRczkF+phgoK9mqNKJ9S9Xd/Xe7ANVFGgJrwXQhV7V6VTxs
         DugimcZlPTHNGn4PZCedlrf4r+6X61wvbKc0pGdw=
Date:   Wed, 21 Nov 2018 09:05:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/205] 4.19.3-stable review
Message-ID: <20181121080500.GB6999@kroah.com>
References: <20181119162616.586062722@linuxfoundation.org>
 <20181120204048.GF19385@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120204048.GF19385@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:40:48PM -0800, Guenter Roeck wrote:
> On Mon, Nov 19, 2018 at 05:25:07PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.3 release.
> > There are 205 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Nov 21 16:24:55 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 135 pass: 135 fail: 0
> Qemu test results:
> 	total: 291 pass: 291 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Thanks for testing all of these and letting me know.

I'll look into the 3.18.y regressions before doing a release there...

greg k-h
