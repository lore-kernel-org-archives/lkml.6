Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8823BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4894221470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbAGqmAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4894221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeJDA6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:58:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42918 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeJDA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:58:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id f26-v6so1907451pfn.9;
        Wed, 03 Oct 2018 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Euneg3Hio6mUk4GB3wE4Y34xLTr/H4jUJNpitqLmwh0=;
        b=DbAGqmAeWjd341NsOYq87QKdy66ALE1tJbUga30niEnjbyDp8ZZ/ULJTXsqT3ablGl
         qYtbDj9PNKAwElgQ5UoXZsDc837Jf5PkzTkO8ScFDD5FtnnGOyNNrOwcKBByyLlHvux8
         owdm2vqfQ6w7EQPagr9le1IBXa54f05B8zXYpk3OKJ72LoLMwuzIM39/MtRKe/+68Gzl
         qB6JLjGuWcVW+bO1MS4D5tEzKqlQVhPF9VlIH1JV7bRNh3/+dX5U4DJj3KREgtxb0Id9
         FTCVKVLwZSI7N1GgrPJuibRbecxCVUPHVTQjbqbtAQ8GqEnWkqFzwnMSx9YboVCYVYUH
         pibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Euneg3Hio6mUk4GB3wE4Y34xLTr/H4jUJNpitqLmwh0=;
        b=rCEi7UcIZeov5ujPG9o4zk3/GiP6DDUK51bWZ+wlashlFbxl+ZyIcJXMPqznEasc4h
         CYfiUjwDQAXrqv3kHzjYqBjoeocAVeNFgPehbjrBEOLSgdDlVmnkW41cYbDLxoCHwlTA
         356qZW9MO2GhBiyxs9Hu4yakXMZxuIzQEroq4bchQgxPBRh4rclptwXQqkAUtGm8y+0f
         +Cood8pERvV8/ON1N8JgUWgMlcQgFT/04r5w9BlYDrA9BNlTKHhXEsPjLNSPbZJTjv++
         uEeyZLu2UAkgUoSjW0qloMbYjOsAJFblnLR4BubLKjAy1lYdNwpc9UeHUzAYxNjGKT1u
         nlmQ==
X-Gm-Message-State: ABuFfoiyVabKyLnWfIwmHTyRjR7IyQOzmcO+5/IxPw2C9q9l95o7kABm
        0fxzMn4vc7ul1r3TDyrzrOfH44IP
X-Google-Smtp-Source: ACcGV63OpPh8v+5O1g2rn47iU4y/GgDT2NgXMSKQpJx1gDMxsizQ72XWCdgbcPTcnWJwmOruUvxWcg==
X-Received: by 2002:a63:e505:: with SMTP id r5-v6mr2403909pgh.170.1538590130343;
        Wed, 03 Oct 2018 11:08:50 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k1-v6sm3047085pfi.62.2018.10.03.11.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 11:08:49 -0700 (PDT)
Date:   Wed, 3 Oct 2018 11:08:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.18 000/228] 4.18.12-stable review
Message-ID: <20181003180847.GA15682@roeck-us.net>
References: <20181002132459.032960735@linuxfoundation.org>
 <af80bbc1-6753-01d2-1ecb-830720b38f48@roeck-us.net>
 <20181003162539.GA4653@kroah.com>
 <20181003172440.GA7955@roeck-us.net>
 <CAL_Jsq+GBDB21tSDTq7p39SvQEGq1R3ZPeH7Yx+9fHttx3v9Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+GBDB21tSDTq7p39SvQEGq1R3ZPeH7Yx+9fHttx3v9Ew@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 12:53:11PM -0500, Rob Herring wrote:
> On Wed, Oct 3, 2018 at 12:24 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Oct 03, 2018 at 09:25:39AM -0700, Greg Kroah-Hartman wrote:
> > > On Wed, Oct 03, 2018 at 05:59:09AM -0700, Guenter Roeck wrote:
> > > > On 10/02/2018 06:21 AM, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.18.12 release.
> > > > > There are 228 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Thu Oct  4 13:24:08 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > >
> > > >
> > > >
> > > >
> > > > Build results:
> > > >     total: 137 pass: 137 fail: 0
> > > > Qemu test results:
> > > >     total: 321 pass: 320 fail: 1
> > > > Failed tests:
> > > >     powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
> > >
> > > What is the status of that powerpc failure fix?  What's the odds it can
> > > get into mainline soon?
> > >
> >
> > The fix has been -next for about a week.
> >
> > da08d8cb8cfc of: unittest: Disable interrupt node tests for old world MAC systems
> >
> > You'll have to ask Rob (copied) if he plans to send a pull request before
> > the next commit window opens.
> 
> I wasn't planning to as it's just for the unittest and has been that
> way for how long? Why's the unittest enabled for a defconfig anyways?
> 

I enabled it to improve test coverage for stable releases. This is how
I found the problem in the first place. Are you suggesting that I should
not run DT unit tests for stable release candidates ?

> There was another g3beige fix (e54192b48da7 of: fix phandle cache
> creation for DTs with no phandles) which is tagged for stable. Not
> sure if qemu would hit the issue though.
> 

Depends if there is a test that can be enabled which hits the problem.

Thanks,
Guenter
