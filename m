Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39DAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A0E2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550213705;
	bh=crHCs2IYLcT4a2Melau+jdor48Od4BFgUBjnknBRLnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SUVd8mPK0vOXIh8caAaMa+Hn21H656M2JhIeNuRzmQpgIsP2CeipQZb9j6yGDn0oN
	 30ApOalQU8+U80rBPFjVSg81F4vEWKzehsALfqnQXJ8/1xMXPqaCLroE9SV/LiaPX4
	 oObyOPH8w3txn5U+MWCLLJ+FIqxAhMWERZeDavow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbfBOGyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 01:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfBOGyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 01:54:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01C121927;
        Fri, 15 Feb 2019 06:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550213650;
        bh=crHCs2IYLcT4a2Melau+jdor48Od4BFgUBjnknBRLnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUhDXB0MERpUq4OmS5MpvbjOaFGe9l7HZoFubYACI8JRb+RSKlMvrJ6zLTTy4bHlZ
         2Zx4DgayJt3/3z8sFg2yjHwiTw3FETiokfdZx1l+3anPQQxKlWWKxoZIPkksyvP31O
         p40s8Ztp5VMWskndO3ENfTXynKpSD5P00Xss0W6Q=
Date:   Fri, 15 Feb 2019 07:53:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/50] 4.20.9-stable review
Message-ID: <20190215065356.GA14473@kroah.com>
References: <20190213183655.747168774@linuxfoundation.org>
 <18da29ff-335c-5885-f941-73c7feff25d8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18da29ff-335c-5885-f941-73c7feff25d8@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 03:24:07PM -0700, shuah wrote:
> On 2/13/19 11:38 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.9 release.
> > There are 50 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Feb 15 18:36:30 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.9-rc1.gz
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
