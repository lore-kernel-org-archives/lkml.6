Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D526C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B212218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546077326;
	bh=473XBoPyX46aQdW2+8bsbyVEjpIh4hoOYrqGTQul0Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dziRkoo5Ade5/45Cr3uvwCjH9M0M9HIyW3NDKYkKQakvi94AWLvPtmIU9xeYHsrm3
	 /DW77bfSGIjOFEkFOCpJFT0oFgq6xbm2J+40CZvb9I9oUd6Ju9AUrT3AgKrZlW7Vvg
	 jt9u0n8shPbj2cJAaJpqAutvH+BnJDmJCY3s9eI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeL2JzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 04:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbeL2JzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 04:55:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F5F62184E;
        Sat, 29 Dec 2018 09:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546077323;
        bh=473XBoPyX46aQdW2+8bsbyVEjpIh4hoOYrqGTQul0Bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjhPgU1KVpRcdExKgsEHu/4ZCXm3a/m1ex6Bwfu3eLdZ+SO+aS0fOlFxFKXMhA/iz
         WQYvfBCPUasP4qYtPpgzUbOY586P6mYoth1TJ3JBTiA4v4GUYmYor6qAxY+l2c9dYp
         vgUE+tE/ERQaTbNMCx1pE1rVQJ7T80JSbLIw31ew=
Date:   Sat, 29 Dec 2018 10:55:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/46] 4.19.13-stable review
Message-ID: <20181229095520.GA11598@kroah.com>
References: <20181228113124.971620049@linuxfoundation.org>
 <cb67dc18-b708-e331-7409-0cffe8aacbfd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb67dc18-b708-e331-7409-0cffe8aacbfd@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 01:08:02PM -0700, shuah wrote:
> On 12/28/18 4:51 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.13 release.
> > There are 46 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Dec 30 11:30:49 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.13-rc1.gz
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
