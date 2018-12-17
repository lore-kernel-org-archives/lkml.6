Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BADFC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FFF206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iqr8gxhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbeLQQEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:04:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55702 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeLQQEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+ZRHKN2EnoBxgTijYBWOdFP0b8r9VcWS+c8cyg1GQNo=; b=Iqr8gxhA9kZZBlj2QM7aA0OWlB
        vJfgQZu55btUbwyapAqlQYLkpA45Xc9HEUFYLi3KSxXuYg3i6NC2+qafCWUuhF5GAiW6YzgsmQ1B2
        mxgAsOoOW1n2m5UQlDvFhVAcipdI3BK9L3lQmRWT7/ZvQ4lriVXNM63eiN6jCLsB9+pkwbODfZpAU
        G4v1csxN+HAxsl0pdGuw5iPwrVL9J8vqdSUTnmVZphvmModsOvB710d5gUsgPtY4lDedYdoslBJD4
        WQ9+2dhOWiaiorHNx4k0posTbebJpz4A2b8u7Mj5MUIxYTUuIR+bIuV9V6U9M245XlWOg65QIed4m
        Lfkw9Cuw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYvN9-0002Rx-HM; Mon, 17 Dec 2018 16:03:59 +0000
Subject: Re: linux-next: Tree for Dec 17 (regulator/mcp16502.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrei Stefanescu <andrei.stefanescu@microchip.com>
References: <20181217220914.29144a09@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c7bd09d3-3c04-327e-6c0b-89ee058cced8@infradead.org>
Date:   Mon, 17 Dec 2018 08:03:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181217220914.29144a09@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 3:09 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181214:
> 

on i386:
# CONFIG_SUSPEND is not set
CONFIG_PM=y

  CC      drivers/regulator/mcp16502.o
In file included from ../include/linux/device.h:23:0,
                 from ../include/linux/gpio/driver.h:5,
                 from ../include/asm-generic/gpio.h:13,
                 from ../include/linux/gpio.h:62,
                 from ../drivers/regulator/mcp16502.c:11:
../drivers/regulator/mcp16502.c:527:32: error: 'mcp16502_suspend_noirq' undeclared here (not in a function)
  SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mcp16502_suspend_noirq,
                                ^
../include/linux/pm.h:342:19: note: in definition of macro 'SET_NOIRQ_SYSTEM_SLEEP_PM_OPS'
  .suspend_noirq = suspend_fn, \
                   ^
../drivers/regulator/mcp16502.c:528:10: error: 'mcp16502_resume_noirq' undeclared here (not in a function)
          mcp16502_resume_noirq)
          ^
../include/linux/pm.h:343:18: note: in definition of macro 'SET_NOIRQ_SYSTEM_SLEEP_PM_OPS'
  .resume_noirq = resume_fn, \
                  ^



-- 
~Randy
