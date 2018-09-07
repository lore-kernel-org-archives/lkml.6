Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14184C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1972075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1972075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeIGLUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:20:50 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55271 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbeIGLUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:20:48 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07489126|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03295;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CnasMR7_1536302452;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CnasMR7_1536302452)
          by smtp.aliyun-inc.com(10.147.42.253);
          Fri, 07 Sep 2018 14:40:52 +0800
Date:   Fri, 7 Sep 2018 14:40:52 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V3 00/26] C-SKY(csky) Linux Kernel Port
Message-ID: <20180907064050.GC16834@guoren>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <20180907020818.GA9110@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907020818.GA9110@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 07:08:18PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Sep 05, 2018 at 08:07:39PM +0800, Guo Ren wrote:
> > This is the 3th version patchset to add the Linux kernel port for C-SKY(csky).
> > Thanks to everyone who provided feedback on the previous version.
> > 
> > This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> > CPU cores and the patches are based on linux-4.18.4
> > 
> > There are two ABI versions with several CPU cores in this patchset:
> >   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
> >   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
> > 	 SMP ...)
> > 
> 
> My key question is about upstream toolchain support.
> The buildroot clone tells me
> 
> $ git describe csky/master
> 2017.11-2111-ge9cc5a5
> 
> and
> 
> $ git log --oneline origin/master..csky/master  | wc
>    1180    7436   57104
> 
> with
> $ git remote -v
> csky	https://gitlab.com/c-sky/buildroot.git 
> origin	git://git.buildroot.net/buildroot
> 
> So it looks like there are more thasn a thousand patches on top of
> buildroot. Adding an architecture to buildroot should only take a
> single patch, or maybe a few, but not more than a thousand.
> This strongly suggests that a lot of changes are not upstream
> but only available in the buildroot clone.
  csky	https://gitlab.com/c-sky/buildroot.git is our CI environment
  based on buildroot and it's so miscellaneous.
  We won't upstream it directly and we'll prepare another patch set for
  buildroot.org update after kernel, glibc upstreamed.
 
> When are we going to see all those changes in upstream gcc, binutils,
> and qemu ? I don't really want to dig through more than a thousand
> patches in a buildroot clone to find out details about the status
> of upstream toolchain support.
  Ok, you want to use upstream gcc, binutils to build the kernel. I'll
  give the tips in next version patch.

Best Regards
 Guo Ren
