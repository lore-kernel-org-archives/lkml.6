Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C68EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92212084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550909124;
	bh=dwK3QpI6E4loYiuMac4DbwCMg54isGDrZo0X5ixOe54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xzx3VREM9PdZeXX/hyqW8YMU7jiOM00oljtIuWe3T6+H1QeyjryX0ynstcUqZED32
	 HvhmTm1wNncF74Xjqh3+FJepTukt5IKQrIxqWM6hXwuF1ugvP+zgvKC3PWE8j3pcYG
	 KgRt2Ku6lljKoFOXnnalLP8fIH8zOM1/+OLPeGBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfBWIFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfBWIFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:05:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6535B20854;
        Sat, 23 Feb 2019 08:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550909121;
        bh=dwK3QpI6E4loYiuMac4DbwCMg54isGDrZo0X5ixOe54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zEpBlDKWW4axPUQf1X8XIlWnHIIIebQY/e8pPc5rwx9LbRITOyO5Hh4gcn2HODRGF
         PN5AEqUy+1KY/lHFTKBCnWWf4vyffcmxtppXWNcKjgt5FvL7YYK79NO6xoTEFcbBe8
         xwJLv77XBu6EZPP96C9l4FyiGs+v5AQ07G1+gZtE=
Date:   Sat, 23 Feb 2019 09:05:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/32] 4.20.12-stable review
Message-ID: <20190223080518.GE2640@kroah.com>
References: <20190221125250.855065214@linuxfoundation.org>
 <48518256-b431-bea5-d654-dd41a2ad9936@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48518256-b431-bea5-d654-dd41a2ad9936@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 04:15:39PM -0700, shuah wrote:
> On 2/21/19 7:35 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.12 release.
> > There are 32 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Feb 23 12:52:26 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.12-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
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
