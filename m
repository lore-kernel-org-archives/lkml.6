Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74EBC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BF720859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547044724;
	bh=CS7hX7fiaKoLq6y53UHrQDz/4hKwSLI86hyOFZUpbX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OVLCnP+nMOTBhf/P61srlb2Z0RFf9TnewzhFOuqAVu5tZYI8RUacyjbPAwbdtOro3
	 pACWWUMbfO4GwZIDzjDPmuxyqJd9eOwyPbXBwhD90d6s2EN1/g4JGTxEWCtksa/njf
	 5FjwF53Bl2mmh7VmUtWtkFI/SuZuMG8BhWoRjgFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfAIOio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:38:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbfAIOin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:38:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77800206BA;
        Wed,  9 Jan 2019 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547044723;
        bh=CS7hX7fiaKoLq6y53UHrQDz/4hKwSLI86hyOFZUpbX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOm2uEj72bXe/PfbDX/ug6gjP+5uBye676IPKc0ofHYS7wa6X7SUDYAEgFEJa9LEh
         /EC/pOfIXZ6OxTm1oNcPx86UnZeO8uuk8NjxV1rGUtWZFZK0ify8aIqhvEYQh85WwS
         oAbq33wbaexV5uD2N/QEti5Pd2KKTCVBOcc9gGTU=
Date:   Wed, 9 Jan 2019 15:38:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190109143840.GC29274@kroah.com>
References: <20190107104452.953560660@linuxfoundation.org>
 <20190108172503.GA28031@roeck-us.net>
 <20190108175640.GA2461@kroah.com>
 <20190108180951.GB28031@roeck-us.net>
 <20190108181322.GA4194@kroah.com>
 <20190108182938.GA19265@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108182938.GA19265@roeck-us.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 10:29:38AM -0800, Guenter Roeck wrote:
> On Tue, Jan 08, 2019 at 07:13:22PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 08, 2019 at 10:09:51AM -0800, Guenter Roeck wrote:
> > > On Tue, Jan 08, 2019 at 06:56:40PM +0100, Greg Kroah-Hartman wrote:
> > > > On Tue, Jan 08, 2019 at 09:25:03AM -0800, Guenter Roeck wrote:
> > > > > On Mon, Jan 07, 2019 at 01:30:27PM +0100, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 4.19.14 release.
> > > > > > There are 170 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > > 
> > > > > > Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
> > > > > > Anything received after that time might be too late.
> > > > > > 
> > > > > 
> > > > > Still (for v4.19.13-171-gc68ce175c3b8):
> > > > > 
> > > > > arch/powerpc/kernel/signal_64.c: In function ‘sys_rt_sigreturn’:
> > > > > arch/powerpc/kernel/signal_64.c:761:21: error: ‘msr’ undeclared 
> > > > > 
> > > > > AFAICS commit 5c784c8414fba ("powerpc/tm: Remove msr_tm_active()") is missing.
> > > > 
> > > > Breno on this thread just said that this patch should not be applied,
> > > > and another one will be submitted upstream instead to solve the problem
> > > > correctly and then we can backport it.
> > > > 
> > > > So we can live with this build issue for now.
> > > > 
> > > 
> > > I think you should drop the offending patch in this case. It doesn't make
> > > sense to keep it - all it accomplishes is to break various builds. What is
> > > the point of doing that ? Is that somehow better than living with the bug
> > > it is supposed to fix ?
> > 
> > That's what the developers involved seem to say.
> > 
> That will prevent anyone affected from actually using 4.19.14, and earlier
> kernels will still have the problem people are now so concerned about.
> In other words, this will accomplish exactly nothig except confirm the
> notion that stable releases are not well tested. I _really_ don't get
> the point, sorry.

No, you are right, we shouldn't include stuff we know is broken for a
large group.  I've dropped the patch now from everywhere.

thanks,

greg k-h
