Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5771C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA9F21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY9sqp/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA9F21566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeHBW1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:27:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40038 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeHBW1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:27:18 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so1534384plp.7;
        Thu, 02 Aug 2018 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zMDPKPPqvpfLdvhwrMg0LIjV5CX/LuQaoNpRgKizoeA=;
        b=LY9sqp/i8E1lxTPR+N/YGLDUswZb1Q3pRf6XWxRktQj470PQQeIyP3dnOixaHKERtH
         q3/GvCA5Aj3O2CNTRcSO9t7CO93VMKZN4LflLsmQZIFGa4O8f8KwtiR3Y0dp1WZmKmhp
         sOzG6Cn/EM9QqZuBENlIVbSVt2yBd0V7mLK32MtqMDDVbIlCJUnckkM2+D3auShasatV
         ny5YyOPCcXgnusl/PMbZRaxrKAWkqKuu3Otm4xdFlpOYMuSNulfP8saxWQ/XjcDJXZWV
         ZyyAlGYh9yZqMj14V76QwuTsjZ6/KtOr0FWI3XVEn/cgD1fXUhEvwxv+1/IM6KnbM2W1
         oSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zMDPKPPqvpfLdvhwrMg0LIjV5CX/LuQaoNpRgKizoeA=;
        b=uUYDeoum7coEJBpvgCesuoxxtJxxmcWUmfuRDgTzAVQh2pEpN5K8AnLEFGQ0QZnReW
         kTZ1w+3KEho92hNxhD4CTXSBcWSR80RYSX7rdEUwC5TirxZ6kGjozSrC+OzMUxMnO+2W
         cYRihnwfOJG/GMoF/+d2IFSWtUnc2sRyb0T/7FEQIjBBl6EoLHv1MB04xevCUw7U8d6U
         2Z5fxEIJ021KEPeD+XgBJifj2b0cEIeF9QZ6NZ+rUv7PdiUAMw6FtD2ph+mGyZu2qyNQ
         EUT5+ZyLfYIWJzNIjMakKoJtOQctWSuXTfPyv/A6wldtUTZ2YRG09IhN8k1t6VQX8c1L
         W/4Q==
X-Gm-Message-State: AOUpUlGPnKu8eJj7Yf+/yPrqQn/89hfqIgNQ3ViU7naijwkGCIPY+KD/
        EcJppeXsTkRupkJGB6YSAyuqIRtO
X-Google-Smtp-Source: AAOMgpdU7J0v40OHMtUkhP/f8NSzUBX6CQYSCT/tWGzWAOrFViiWKFJQrLrcKNLYDyMWB858AKjNGQ==
X-Received: by 2002:a17:902:b08d:: with SMTP id p13-v6mr897231plr.0.1533242072174;
        Thu, 02 Aug 2018 13:34:32 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q85-v6sm4342246pfa.151.2018.08.02.13.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 13:34:31 -0700 (PDT)
Date:   Thu, 2 Aug 2018 13:34:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/246] 4.14.60-stable review
Message-ID: <20180802203429.GA30349@roeck-us.net>
References: <20180801165011.700991984@linuxfoundation.org>
 <20180802154325.GB5137@roeck-us.net>
 <20180802182517.GA24531@roeck-us.net>
 <20180802190946.GA25832@roeck-us.net>
 <20180802194135.GA13901@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802194135.GA13901@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 09:41:35PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 02, 2018 at 12:09:46PM -0700, Guenter Roeck wrote:
> > On Thu, Aug 02, 2018 at 11:25:17AM -0700, Guenter Roeck wrote:
> > > On Thu, Aug 02, 2018 at 08:43:25AM -0700, Guenter Roeck wrote:
> > > > On Wed, Aug 01, 2018 at 06:48:30PM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.14.60 release.
> > > > > There are 246 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Fri Aug  3 16:49:18 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > > 
> > > > 
> > > > Build results:
> > > > 	total: 148 pass: 148 fail: 0
> > > > Qemu test results:
> > > > 	total: 198 pass: 198 fail: 0
> > > > 
> > > > Details are available at http://kerneltests.org/builders/.
> > > > 
> > > 
> > > I spoke too early. parisc images crash after adding some configuration
> > > options. I don't see the crash with v4.14.59. I'll send another update
> > > later after figuring out what is going on.
> > > 
> > 
> > The patch causing the problem is commit 27608f359da88eaf ("fasync: Fix deadlock
> > between task-context and interrupt-context kill_fasync()"), see bisect log
> > below.
> > 
> > Kernel log message is as follows.
> > 
> > PDC_CHASSIS: Fault (1), CHASSIS  0
> > Backtrace:
> >  [<10267738>] dput.part.5+0x1dc/0x1f0
> >  [<1026776c>] dput+0x20/0x30
> >  [<1024f79c>] __fput+0x14c/0x230
> >  [<1024f8e4>] ____fput+0x18/0x28
> >  [<1019abe0>] task_work_run+0xa4/0xd8
> >  [<1016d044>] do_notify_resume+0x7c/0x84
> >  [<1015c258>] syscall_do_signal+0x50/0x9c
> > 
> > The problem only affects v4.14.60-rc1; all other stable releases and release
> > candidates are fine.
> 
> That is really odd as that commit is also in the 4.17 and 4.9 -rc
> releases.
> 
> I'll go drop it from all queues just to be safe, odds are something in
> that backport isn't correct.
> 

... or the context is somehow different. But I agree, it is odd that
I didn't see the problem in 4.9/4.17.

I restarted the boot tests; I'll let you know after they are complete.
Build tests will run again tonight.

Guenter
