Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4435CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA542186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545319276;
	bh=ctA6UWidU1uKt7b+MOwgX+5DTj3Qn9wldP9TCkw4T7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=diY/7ubrqnh91FPwIp7ynJenlEiqPE0E/c9ErzF6syQW1FQIGGDgkrWlH+I3O5J+H
	 EpYz9DJg/SDBMjX8VuanxYN4NwqPIY59LPutVLN18lpcy1+7up6BIijVA8PAVHnVnp
	 m82/Q5+xQ8MiaDsB9BL8lSwsuPfMgcUqMJMMSESA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbeLTPVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbeLTPVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:21:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA4821852;
        Thu, 20 Dec 2018 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545319274;
        bh=ctA6UWidU1uKt7b+MOwgX+5DTj3Qn9wldP9TCkw4T7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBkMgYPQ7xvzRElCvMq8UZcM2Uo75K1Fwhd2VqOjmn3SXtOY388HxTVzu6barFC4n
         yJCIK5jtLapvDLmTR+RghIHLFBjBdC4qDHMTeJXVvKLzEV2iZ0XAnzES4valX0gUbH
         kLUvpbuPFvN/TXJcnbqDwp6jiMI+qsyb38H7Lud0=
Date:   Thu, 20 Dec 2018 16:21:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
Message-ID: <20181220152111.GB17408@kroah.com>
References: <20181115011125.GA32556@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115011125.GA32556@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 05:11:25PM -0800, Guenter Roeck wrote:
> On Thu, Nov 01, 2018 at 11:26:06AM -0700, Florian Fainelli wrote:
> > It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
> > result in the inability for the kernel to have a valid console device,
> > which can be seen with:
> > 
> > Warning: unable to open an initial console.
> > 
> > and then:
> > 
> > Run /init as init process
> > Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100
> > 
> > Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
> > really is no drawback to defaulting this config to the value of
> > SERIAL_8250.
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This patch results in situations where CONFIG_SERIAL_OF_PLATFORM is now
> defined where it was not previously. Example mpc85xx_defconfig. This in
> turn results in boot failures for those configurations, with an error
> message of
> 
> of_serial: probe of e0004500.serial failed with error -22
> 
> which wasn't seen before.
> 
> Not sure if replacing a potential problem with a real one is really an
> improvement.`

What ever was the result of this long thread?  Should I revert
something?  Or was a patch proposed?

totally lost,

greg k-h
