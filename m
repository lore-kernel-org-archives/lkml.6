Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E4B21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545225595;
	bh=soVxtL9Eq6Ywe5t1xg4+kFQ1fCZzEmIaRFvZM995/5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0V+VTlReRmVgyBVOOxhJBfKHVuikbjTDSipHp2wtRKqSn3T3DtQL7Cctu4T7IxIa0
	 +wqLEuM8YnyUS+sHOePs3yssjm06bvKPywfI+EooSCoWmQ0I3hNUOk26hEHucYbC+d
	 tMiCGf1D/HvDfHtH23Dbq+maLMqGgVVbeByPiN5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeLSNTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:19:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbeLSNTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:19:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49DAF21873;
        Wed, 19 Dec 2018 13:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545225591;
        bh=soVxtL9Eq6Ywe5t1xg4+kFQ1fCZzEmIaRFvZM995/5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPKsbyiAa+AzkSj6p37T67y+AZVmVxfkHcuT9NpIy1loVZYcOo6hfdrVFmkT7pao4
         M7E+Gvlmou2aA2snhreO2KScbgzxAcD3+sta5wAVOc83bC0tj/eJM3Qmw0rv+JpCc+
         0zrypv3hZ4Mv3eKseETt0Wj1RfBirckcI146r5A4=
Date:   Wed, 19 Dec 2018 14:19:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/44] 4.19.11-stable review
Message-ID: <20181219131949.GB15278@kroah.com>
References: <20181218163927.119623235@linuxfoundation.org>
 <8f3a9d68-44fe-c869-dc33-1f03f8fde091@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f3a9d68-44fe-c869-dc33-1f03f8fde091@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 01:26:00PM -0700, shuah wrote:
> On 12/18/18 9:39 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.11 release.
> > There are 44 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Dec 20 16:39:02 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.11-rc1.gz
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

Thanks for testing and letting me know.

greg k-h
