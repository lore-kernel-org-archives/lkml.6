Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE553C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DB7218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549554418;
	bh=tIW8t1X31YY5v+zFntnGn5lY6mu8sKR3DO8nH8GydrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UvU50T1UvhMGMKZVkythtCbYXmkgg60LqPRdneCusBMpEgCDj8z5VGWS0kilyHGnc
	 0uJbf4+JutOHc9w1pMedpmJBayf/Gy9C22la8mV9AoXvut3u1TZf5T+bIV1hEQ91k4
	 toi4N3s6b2M4nUcM73wW/zPMl0PQt9rPZQW6KKZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfBGPq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:46:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfBGPq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:46:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A90121872;
        Thu,  7 Feb 2019 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549554416;
        bh=tIW8t1X31YY5v+zFntnGn5lY6mu8sKR3DO8nH8GydrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=elmfSfqW7gGXWRaEuL36Dhjlmhtph1EeP57jHJwN9ntsI4Iexh2fsqN0m/6AGn/OE
         nL54jM5W5AiSU64seAF1/dvFUFBizBraBM/UgAHsyakbKaDvtVqTUgZRtOYHTZkpaD
         sVl5chol0hjcXNH0rpnemJbQAtSCI7y8fOyTqLuw=
Date:   Thu, 7 Feb 2019 16:46:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/34] 4.4.174-stable review
Message-ID: <20190207154653.GA7164@kroah.com>
References: <20190207113025.552605181@linuxfoundation.org>
 <2780bab7-047c-33c2-e0dc-cdc0cec46400@roeck-us.net>
 <abf78f65-b3c4-de63-8d11-7d014bd1e42c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abf78f65-b3c4-de63-8d11-7d014bd1e42c@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 06:41:01AM -0800, Guenter Roeck wrote:
> On 2/7/19 6:20 AM, Guenter Roeck wrote:
> > On 2/7/19 3:41 AM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.4.174 release.
> > > There are 34 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat Feb  9 11:30:10 UTC 2019.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> >      total: 171 pass: 170 fail: 1
> > Failed builds:
> >      x86_64:allyesconfig
> > Qemu test results:
> >      total: 291 pass: 291 fail: 0
> > 
> > The build failure is interesting.
> > 
> > Relocation offset doesn't fit in 32 bits
> > make[3]: *** [arch/x86/boot/compressed/vmlinux.relocs] Error 1
> > make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> > make[3]: *** Waiting for unfinished jobs....
> > make[2]: *** [arch/x86/boot/compressed/vmlinux] Error 2
> > make[1]: *** [bzImage] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [sub-make] Error 2
> > 
> > Unfortunately it doesn't tell me _which_ relocation doesn't fit.
> > 
> > I may have to revert to an older compiler. Wouldn't be the first time.
> > Let me try...
> > 
> 
> Confirmed. This builds fine with gcc-6.5.0 and binutils 2.26.1. Sigh :-(.

That's really really odd :(

Let me try this, I only normally build allmodconfig.

greg k-h
