Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D90DC4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C20B222C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549996378;
	bh=dMJPa9JHlWcyz6cmoZlbCmxOyXakmIaqMU9qI67RmB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yyRraItkT00w+QnJEiSEmoJJyv/5KuofA16M8XTSW7sEkmeFjr/NiknphFePUz4II
	 OFvBpKTzd/8KVtbN2RbTn/Hu0g8yhHF8K7szSNlOrQQHd3EqbD+Rr1PrE7dYLs2kkC
	 IfM6FV5vipRj5hVY9uxIW1+cB/eJ+AN0MdzCIKUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfBLSc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfBLSc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:32:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A7B1222BB;
        Tue, 12 Feb 2019 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549996375;
        bh=dMJPa9JHlWcyz6cmoZlbCmxOyXakmIaqMU9qI67RmB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+U53LQp67Tn+jhFHHmykcrqIKYVw3cr8FNhOc90NqbXo4f+aqumhPcnpqOxIVksC
         fIxatI8mCrgWZzEY/GFblPhN8i2SFDNGs7swfrkcvCEVsU8jwI3GRqxMK1fdq8T1Mu
         kP4vz9RQ5L5/XZiW5Su9QFSr8lxOGZCRQnD7davM=
Date:   Tue, 12 Feb 2019 19:32:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/352] 4.20.8-stable review
Message-ID: <20190212183253.GB14528@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <ecbf2ac8-9958-6f9f-0e86-017ec6afa289@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecbf2ac8-9958-6f9f-0e86-017ec6afa289@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 08:40:03AM -0700, shuah wrote:
> On 2/11/19 7:13 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.8 release.
> > There are 352 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 13 14:17:03 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.8-rc1.gz
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

thanks for testing all of these and letting me know.

greg k-h
