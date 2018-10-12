Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CBCC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15CA2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5DBLTBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15CA2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeJLXio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728832AbeJLXio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:38:44 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5A3204EC;
        Fri, 12 Oct 2018 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539360334;
        bh=LGhgAD8SrTUVt/weeDLG68RxKwFEOj2bx0CK6CCd1yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5DBLTBXcxcoInzeyZAhOD6GpXXJhRmgJwWFnzrWx7yvjM9J557T3nwDW3Sj5kQ8l
         Ajm5ixlymME6BTaem/Uxy89r+x9MWr6I7RnPkPC9T8zHfPiTsgb343P7AsI4amSkGE
         S5vuUfScp8cvW24BF5OrloFNewXCDQt1IfhV+vmw=
Date:   Fri, 12 Oct 2018 18:05:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 000/120] 3.18.124-stable review
Message-ID: <20181012160531.GA28524@kroah.com>
References: <20181011152549.500488630@linuxfoundation.org>
 <9b2c52e4-56ce-37a3-b515-a6ff831fe17e@roeck-us.net>
 <20181012133704.GB3706@kroah.com>
 <10e12992-7e33-9569-5a4f-2a8124d3aae4@roeck-us.net>
 <20181012142110.GA10817@kroah.com>
 <20181012151506.GA17468@roeck-us.net>
 <20181012153916.GA13257@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012153916.GA13257@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 08:39:16AM -0700, Guenter Roeck wrote:
> On Fri, Oct 12, 2018 at 08:15:06AM -0700, Guenter Roeck wrote:
> > On Fri, Oct 12, 2018 at 04:21:10PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Oct 12, 2018 at 07:06:13AM -0700, Guenter Roeck wrote:
> > > > On 10/12/2018 06:37 AM, Greg Kroah-Hartman wrote:
> > > > > On Fri, Oct 12, 2018 at 05:19:16AM -0700, Guenter Roeck wrote:
> > > > > > On 10/11/2018 08:33 AM, Greg Kroah-Hartman wrote:
> > > > > > > This is the start of the stable review cycle for the 3.18.124 release.
> > > > > > > There are 120 patches in this series, all will be posted as a response
> > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > let me know.
> > > > > > > 
> > > > > > > Responses should be made by Sat Oct 13 15:25:29 UTC 2018.
> > > > > > > Anything received after that time might be too late.
> > > > > > > 
> > > > > > 
> > > > > > [preliminary]
> > > > > > 
> > > > > > arm:allmodconfig:
> > > > > > 
> > > > > > drivers/mtd/spi-nor/fsl-quadspi.c: In function 'fsl_qspi_init_lut':
> > > > > > drivers/mtd/spi-nor/fsl-quadspi.c:170:5: error: 'LUT_0' undeclared
> > > > > 
> > > > > That is really odd in that there are no patches that touch this file,
> > > > > and I do not even see "LUT_0" anywhere in the 3.18.y tree.
> > > > > 
> > > > 
> > > > Bisect:
> > > > 
> > > > 
> > > > # bad: [8c4ca12b60ea371a32db58cf78b6cb4e2ba4515c] Linux 3.18.124-rc1
> > > > # good: [921b2fed6a79439ef1609ef4af0ada5cccb3555c] Linux 3.18.123
> > > > git bisect start 'HEAD' 'v3.18.123'
> > > > # good: [aed5b0190528303a3f4d319f95d7e38c94ca32ab] USB: remove LPM management from usb_driver_claim_interface()
> > > > git bisect good aed5b0190528303a3f4d319f95d7e38c94ca32ab
> > > > # good: [10441f560c0ad0aeed00402088d71d4d299d6537] r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENABLED
> > > > git bisect good 10441f560c0ad0aeed00402088d71d4d299d6537
> > > > # bad: [0661a919177560337d962f43daa46dde2fa4d89e] mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys
> > > > git bisect bad 0661a919177560337d962f43daa46dde2fa4d89e
> > > > # good: [d4b130cc92bbef445de4ffe4ecd068935375d591] ocfs2: fix locking for res->tracking and dlm->tracking_list
> > > > git bisect good d4b130cc92bbef445de4ffe4ecd068935375d591
> > > > # bad: [1f002a3e6d7250a62966399bd91eeec308c0b756] fbdev/omapfb: fix omapfb_memory_read infoleak
> > > > git bisect bad 1f002a3e6d7250a62966399bd91eeec308c0b756
> > > > # bad: [5396a79f029d54c1e02409335c7dfde43c55e4a4] Make file credentials available to the seqfile interfaces
> > > > git bisect bad 5396a79f029d54c1e02409335c7dfde43c55e4a4
> > > > # good: [7da4d144b6922e94aad8c0d405e4cc63a44b8ec5] dm thin metadata: fix __udivdi3 undefined on 32-bit
> > > > git bisect good 7da4d144b6922e94aad8c0d405e4cc63a44b8ec5
> > > > # first bad commit: [5396a79f029d54c1e02409335c7dfde43c55e4a4] Make file credentials available to the seqfile interfaces
> > > > 
> > > > ... and reverting that patch fixes the problem. No idea why; maybe because of include
> > > > file changes.
> > > 
> > > That patch _adds_ two .h files to be included in
> > > include/linux/seq_file.h, not removes any.
> > > 
> > > Ugh, that's a mess.
> > > 
> > > I've seen the LUT_0 thing show up a long time ago due to some other odd
> > > arm thing.  But I don't remember how it was ever resolved.  Maybe I'll
> > > just let this one go and see if anyone notices :)
> > > 
> > See commit 04850c4d8613127a9b488321c0ad83bff7519311. I'll check if it applies
> > and fixes the problem, and let you know.
> > 
> I confirmed that commit 04850c4d86131 applies and fixes the problem.

Great, now queued up, thanks!

greg k-h
