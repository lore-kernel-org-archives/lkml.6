Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24ABC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94134217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548225785;
	bh=LdVpB4uZZ6xQHMsyoyxjl+8y6qun18Xb/RsBmAi0MMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zCxg7fMSYtWkeDLia77Xi4ZUsuwVudu7pwKwhqGUmj39esg41cTieOYxP65wDiwcj
	 62sGd3/eDFLj+UeGKmbHFw/nMwT13Egqv9Y8rWVC7dpspHUnTaavDEjsuM2G7Ud4AD
	 mpsI2WzqC0Dafmaokhvh/GB8S+ihMJOazw7OjOhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAWGnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfAWGnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:43:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 878E021726;
        Wed, 23 Jan 2019 06:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548225783;
        bh=LdVpB4uZZ6xQHMsyoyxjl+8y6qun18Xb/RsBmAi0MMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bs9df/I/RRSFFXb9Pk1In4LaSrC9EQkrEJ5B2A0M2tO19RtGbC5Pxam6ET+g6M2tq
         IBgtQcXQ2QZp8DRZqhWEuc0Unm6FTUbtP98bjwjOxX06xLjb3ZkikUhU/lO67OlKGw
         d18EBaX2ncTVWIuM9vHAiXt69iiniWgjn8ZCjFk8=
Date:   Wed, 23 Jan 2019 07:43:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
Message-ID: <20190123064300.GD26046@kroah.com>
References: <20190121122455.819406896@linuxfoundation.org>
 <c35b105e-3473-ef59-c8d5-2dd39708474b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c35b105e-3473-ef59-c8d5-2dd39708474b@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:25:58PM -0700, shuah wrote:
> On 1/21/19 6:41 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.4 release.
> > There are 111 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jan 23 12:23:56 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.4-rc1.gz
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
