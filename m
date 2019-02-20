Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B248C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBC921773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550653500;
	bh=KK3tdbxk1eqQpwZ/Kd+GJUcnaptpL6USf15JxHOhjNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WgDkCARXswYZyBn2+G9tw+MKjnBYt3q/9JPYloeVpCt+EhEdmHWplsKAeAZAJtwm3
	 h4KtyPndZP4xk+SiE5ydoLpbReaT23K02pjvhZOliH6jZ4sTSA2bGdXSrzXvVzXqr2
	 d56HQoPP5QQIxk1+zpAasL5VfQKEqzsE9LevidU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfBTJE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBTJE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:04:58 -0500
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC3A208E4;
        Wed, 20 Feb 2019 09:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550653498;
        bh=KK3tdbxk1eqQpwZ/Kd+GJUcnaptpL6USf15JxHOhjNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvzWN8xsXf39BI52vX6jUTV0FWAAy2vHvhspSX6YA/u1twPDDhilpDLL6IkPukirS
         eQV7j8Beq8CfAhEv4oPfK2ZONZOLCDZzkZoctWRLltBQvY1cfFSk/vuQi1Y38Q1yb7
         awOjQPxxBhAL9TosFbbDqBJUCp4vCZ2dmLg/Azcg=
Date:   Wed, 20 Feb 2019 10:04:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/92] 4.20.11-stable review
Message-ID: <20190220090453.GA29215@kroah.com>
References: <20190218133454.668268457@linuxfoundation.org>
 <1ed0095f-ae1a-f57d-8005-38603ab460b5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ed0095f-ae1a-f57d-8005-38603ab460b5@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:39:11AM -0800, Guenter Roeck wrote:
> On 2/18/19 5:42 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.11 release.
> > There are 92 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 20 13:34:25 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 156 fail: 3
> Failed builds:
> 	csky:defconfig
> 	csky:allnoconfig
> 	csky:tinyconfig
> Qemu test results:
> 	total: 343 pass: 343 fail: 0
> 
> 
> Building csky:defconfig ... failed
> --------------
> Error log:
> mm/memory.c: In function ‘__pte_alloc’:
> mm/memory.c:406:18: error: too many arguments to function ‘pte_alloc_one’
> 
> Commit d6caf1d0d553 ("csky: fixup compile error with pte_alloc")
> (upstream patch 2a60aa14a9a) needs to be removed; the offending patch
> is not in v4.20.y.
> 
> The automatic scripts seem to be a bit too aggressive.

Thanks for finding this.  I'll drop it before I do the release.  And
thanks for testing all of these and letting me know.

greg k-h
