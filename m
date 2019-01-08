Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801E8C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4142070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546971206;
	bh=fxuCelbzDrO/ReyDYo4jWPz/eXJn0lr9yCggSP4OI4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2tHgXOtQrDlx82XdAfeTNC9u16dIggKYXYjnxOpHXT9399WS5jwJIeREV6FH0NPhv
	 NCXUN0htw7q/1DixPTRi/JmnSRHfG+WMV6YM3OV4PtA88YxFd71rXFGo/VQW2K4ofe
	 OcQLVp8fBSjCOyp8SXOTmI0efDlYnfe3DJgrniCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfAHSNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfAHSNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:13:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E286F20645;
        Tue,  8 Jan 2019 18:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546971204;
        bh=fxuCelbzDrO/ReyDYo4jWPz/eXJn0lr9yCggSP4OI4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbyoJvnqhsi6eN6IdFBvRx+v5y2C2g4QPZojCiI4NVy7Uzl6rm+XwfcMy5K6GTD0o
         eEiTZiMpDRgZ8kEF0F08HFhrC9vBfVTfWD2V5750sA1uuWCfuKaFlCbXdh/R96vuVE
         guE+orQIoG0Ei6ZurFJy6aT3eXtyb+QeIvHoi2Yk=
Date:   Tue, 8 Jan 2019 19:13:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Breno Leitao <leitao@debian.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190108181322.GA4194@kroah.com>
References: <20190107104452.953560660@linuxfoundation.org>
 <20190108172503.GA28031@roeck-us.net>
 <20190108175640.GA2461@kroah.com>
 <20190108180951.GB28031@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108180951.GB28031@roeck-us.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 10:09:51AM -0800, Guenter Roeck wrote:
> On Tue, Jan 08, 2019 at 06:56:40PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 08, 2019 at 09:25:03AM -0800, Guenter Roeck wrote:
> > > On Mon, Jan 07, 2019 at 01:30:27PM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.19.14 release.
> > > > There are 170 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Still (for v4.19.13-171-gc68ce175c3b8):
> > > 
> > > arch/powerpc/kernel/signal_64.c: In function ‘sys_rt_sigreturn’:
> > > arch/powerpc/kernel/signal_64.c:761:21: error: ‘msr’ undeclared 
> > > 
> > > AFAICS commit 5c784c8414fba ("powerpc/tm: Remove msr_tm_active()") is missing.
> > 
> > Breno on this thread just said that this patch should not be applied,
> > and another one will be submitted upstream instead to solve the problem
> > correctly and then we can backport it.
> > 
> > So we can live with this build issue for now.
> > 
> 
> I think you should drop the offending patch in this case. It doesn't make
> sense to keep it - all it accomplishes is to break various builds. What is
> the point of doing that ? Is that somehow better than living with the bug
> it is supposed to fix ?

That's what the developers involved seem to say.

Breno, should I drop the offending patch now, or wait for your fix to
land and then fix up the build then?

thanks,

greg k-h
