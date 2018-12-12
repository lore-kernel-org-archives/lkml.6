Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35852C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF55720851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544598346;
	bh=/eELqwXHEDVTf/qdyewpXPiZVadYZmM9PbkfkG47Yzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tUtXC2Q9fwRYd9yGBK6bPAFgTVnxUEQmLgY35iy28ARsvkjgnuW6L+SyKg6u2cRL9
	 Aie8tXGgRDYPZAQKk6Z36l3GcCiF7Dm9m/cNqcoyIObsQlGf1l1tXfyuZBjfNxHlnH
	 vg+TJmNd8Kqe3goUAahw/IrxF9S24v8yG/UrXedo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF55720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeLLHFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:05:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLHFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:05:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8999420811;
        Wed, 12 Dec 2018 07:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544598344;
        bh=/eELqwXHEDVTf/qdyewpXPiZVadYZmM9PbkfkG47Yzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKJWAVQeLR3BTrr5auyP8GIrie+ZGpcE+7d9Lsg33WVbMUdVGVGeStHbZSSZd6wiM
         bFlqRU9Sdwx5MCRI6Q0O71ucpWHxnxpBcyaFfZFnOm/nZKokGFmu5TRKCmStFb/X3c
         yF466nkNeU0581nIRX28GWQmPIpg01mvIOIHKETo=
Date:   Wed, 12 Dec 2018 08:05:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/118] 4.19.9-stable review
Message-ID: <20181212070541.GA20333@kroah.com>
References: <20181211151644.216668863@linuxfoundation.org>
 <7d41ab8f-17c7-a228-972e-ce7a012308ea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d41ab8f-17c7-a228-972e-ce7a012308ea@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:03:49PM -0700, shuah wrote:
> On 12/11/18 8:40 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.9 release.
> > There are 118 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Dec 13 15:16:10 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.9-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
