Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B042C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D096B218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551258356;
	bh=jLRIILbkAHQoJLBTtET7hTsshl19zntoNAjVw/ufF/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GEQ5uGl0PIX0HGc2/fRk+SDqqftxP6/5RXQ8DAVC5Prp9BQ32ygtKv6vrkP3h50Qh
	 99I2AA80Vfvb1g7cxxKixzvp2sRyfQgomy1Semy4FRLKDh/WnNRG3I4JiSFXEdSvvV
	 +q6nu4ffmrIfgYanwGGkialzm42HzL4z/lR/KNl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfB0JFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfB0JFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:05:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6E16218CD;
        Wed, 27 Feb 2019 09:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551258354;
        bh=jLRIILbkAHQoJLBTtET7hTsshl19zntoNAjVw/ufF/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brweHBtASzkSTdJK/91He9UAbM/mOrvg6CFSw2iyxJDrSf18nu+I8RVWq9vZEfQmC
         iSQIcCs0UcaSPdXcN4OFqsH6HZ4b6WR9U9ApfGTB8XssS+fVpSd2fE63pEP7lA+1m/
         IjY89tbS9au4uuIoYWkllbhGAjx6wtMjVJNxhxdM=
Date:   Wed, 27 Feb 2019 10:05:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/183] 4.20.13-stable review
Message-ID: <20190227090551.GA23360@kroah.com>
References: <20190225195054.748060397@linuxfoundation.org>
 <20190226172940.GA7933@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226172940.GA7933@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 09:29:40AM -0800, Guenter Roeck wrote:
> On Mon, Feb 25, 2019 at 10:09:33PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.13 release.
> > There are 183 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 27 19:49:59 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 171 pass: 169 fail: 2
> Failed builds: 
> 	powerpc:ppc6xx_defconfig 
> 	powerpc:86xx/sbc8641d_defconfig
> Qemu test results:
> 	total: 291 pass: 291 fail: 0
> 
> The build failure is:
> 
> In file included from arch/powerpc/kernel/ptrace.c:24:
> In function ‘user_regset_copyin’,
>     inlined from ‘vr_set’ at arch/powerpc/kernel/ptrace.c:490:9:
> include/linux/regset.h:258:4: error:
> 	‘memcpy’ offset [-527, -529] is out of the bounds [0, 16] of object ‘vrsave’ with type ‘union <anonymous>’ 
> 
> The problem is not new. It is seen now because I switched to use
> gcc 8.3.0. The problem is fixed in linux-next.

Ok, I'll ignore these powerpc build issues for now, thanks for testing
all of these and letting me know.

greg k-h
