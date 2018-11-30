Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263D3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9892145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPM4sTvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9892145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeLAC2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:28:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbeLAC2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:28:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5687220867;
        Fri, 30 Nov 2018 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543591116;
        bh=4a+fKmqH8rDSqb4qe9H1X83ihjh7R+XtjSA/uLj18ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPM4sTvBjeHnHe86uGBngtN8AMxvWAvOmhf3Odj5//OZlnRe0c0OV/+Udw2k+GCcf
         jPlia25DZ9C52UOqvqJtSuIUc8dc8CmytvmQWeabCy42tZrX8rGH3l1cj7C3gbS+7O
         JjyGqTHy2YgCzEGSjA7qfyD20ev0uWWeFpky7lFs=
Date:   Fri, 30 Nov 2018 16:18:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/100] 4.14.85-stable review
Message-ID: <20181130151834.GA25470@kroah.com>
References: <20181129140058.768942700@linuxfoundation.org>
 <e5bf27b0-5611-e2ea-c8b1-d08f3910e9d5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5bf27b0-5611-e2ea-c8b1-d08f3910e9d5@roeck-us.net>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 06:20:49AM -0800, Guenter Roeck wrote:
> On 11/29/18 6:11 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.85 release.
> > There are 100 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Dec  1 14:00:29 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> arm:allmodconfig, arm:exynos_defconfig
> 
> arch/arm/kernel/smp.c: In function 'secondary_biglittle_init':
> arch/arm/kernel/smp.c:117:19: error: implicit declaration of function 'lookup_processor'; did you mean 'lookup_resource'?
> 
> Also affects v4.19.5-111-gac4af649901b.

Thanks, I'm about to rip out a bunch of these arm patches as Russell
says not to include them just yet.  Let me do a -rc2 in a bit with them
gone...

thanks,

greg k-h
