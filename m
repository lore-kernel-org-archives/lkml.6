Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCABC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D501208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1HxeXfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D501208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbeGaQYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:24:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40368 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732462AbeGaQYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:24:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so9199634pgp.7;
        Tue, 31 Jul 2018 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i7L2twpfztAVOr5NniDLdECQ3Q8LQkGuEuPTTHNDSio=;
        b=f1HxeXfht9Lgx1Brfyi/BP3Ek1zXxTZ5u/cPbRgrwt+dJku3usaWVcRT//kkIThKKp
         XQSrtTHGs/IH3SHngufbCwK/39CoL8VhyYl6myb5fOemnqJXMS79hKS8lnKoFUwgE3MH
         ssTXrnQrrssePjX9cHcQaX7wuQHHr+iIrEE/bXY/89cNEqNWUm0bBfnJ5M88+1znIHyE
         XChV6wG+QihY4QCeofYOyaJSKOy2V+gdTb6EeRvKYxDSFcpf9wFSSjTu8N6UbNL4P/1X
         TbZsUXo9E4WiiX+n+f9cD4ypj/xKOi4QyoY1jZw0BgUAWkwHUMaUPHdfucS0/lgRGgnN
         6+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i7L2twpfztAVOr5NniDLdECQ3Q8LQkGuEuPTTHNDSio=;
        b=j+qm7T9Fg9K4yoe3thL9ip77gxwufhCyzn6rEM6/js1uz4Nw+sXIKB0kfOyJEoMtlB
         x8BCDRnUr1YYX+JyGMAu3r2pRLnxUN3MEc56bAnhvZu6qvvsYmTfyV/mugRBhFckdFUL
         Qv7V1KeyCUP7NQSwzxMW9AizSHaC0IBYdcjeoG7oHZEkIWNx5d1WkHRFDdBxmCKqxcEZ
         rhGGBtxD8CVvBuZBGQASmLlMQT7mv6iUa022Blp8MalynBMiIewFAInTswwVL8OYWsHU
         /xMODnadx3dy9mjOknY5NncyJdvPOOaNPMY1Crr6qBGr9pb/EwE4BP47R2f5A+mwSBaj
         itfg==
X-Gm-Message-State: AOUpUlEKzlaoBTqcW6LdpwRG/DYlPmXD0O+4ccaiuid98spwiXbs7tmD
        QXcHzYUqYWtM7enJi/HZ05vETlhr
X-Google-Smtp-Source: AAOMgpe9TuVv17TI14Z9YdEWxmLOFzaJvEhRA1VDjmwm1NR3N+1qcmBSD2c2lQ9WODY9Wz6BypUplQ==
X-Received: by 2002:a63:8c51:: with SMTP id q17-v6mr21200913pgn.236.1533048246911;
        Tue, 31 Jul 2018 07:44:06 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p11-v6sm25623446pfj.72.2018.07.31.07.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 07:44:05 -0700 (PDT)
Date:   Tue, 31 Jul 2018 07:44:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 31
Message-ID: <20180731144404.GA27893@roeck-us.net>
References: <20180731182252.17831c15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731182252.17831c15@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 06:22:52PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180730:
> 
> The block tree gained a build failure so I used the version from
> next-20180730.
> 
> The kvms390 tree gained a conflict against the kvm-arm tree.
> 
> The staging tree still had its build failure due to an interaction with
> the vfs tree for which I disabled CONFIG_EROFS_FS.
> 
> The mux tree gained a conflict against the battery tree.
> 
> The pinctrl tree gained a conflict the devicetree tree.
> 
> The kspp tree still had its build failure so I have added a supplied
> patch.
> 
> Non-merge commits (relative to Linus' tree): 9850
>  8993 files changed, 412971 insertions(+), 175848 deletions(-)
> 

In addition to some build failures, I see a large number of boot stalls
with this image. Various architectures are affected (i386, x86_64, mips,
some powerpc). Bisect is inconclusive due to a spurious build failure
in mm code. For those interested, logs are available at
http://kerneltests.org/builders/.

Guenter

---
Build results:
	total: 134 pass: 128 fail: 6
Failed builds: 
	alpha:allmodconfig 
	arm64:allmodconfig 
	parisc:allmodconfig 
	sparc32:allmodconfig 
	unicore32:defconfig 
	unicore32:allnoconfig 
Qemu test results:
	total: 182 pass: 147 fail: 35
Failed tests: 
	mips:malta_defconfig:nosmp 
	mips:malta_defconfig:smp 
	mips64:malta_defconfig:nosmp 
	mips64:malta_defconfig:smp 
	mipsel:24Kf:malta_defconfig:nosmp:initrd 
	mipsel:24Kf:malta_defconfig:smp:initrd 
	mipsel:24Kf:malta_defconfig:smp:rootfs 
	mipsel64:malta_defconfig:nosmp:rootfs 
	mipsel64:malta_defconfig:smp:initrd 
	mipsel64:malta_defconfig:smp:rootfs 
	mipsel64:fuloong2e_defconfig:fulong2e:rootfs 
	powerpc:mac99:pmac32_defconfig:devtmpfs:zilog:initrd 
	powerpc:mac99:pmac32_defconfig:devtmpfs:zilog:rootfs 
	i386:Broadwell:q35:defconfig:smp:rootfs 
	i386:Skylake-Client:q35:defconfig:smp:rootfs 
	i386:SandyBridge:q35:defconfig:smp:rootfs 
	i386:Haswell:pc:defconfig:smp:rootfs 
	i386:Nehalem:q35:defconfig:smp:rootfs 
	i386:phenom:pc:defconfig:smp:rootfs 
	i386:Opteron_G5:q35:defconfig:smp:initrd 
	i386:Westmere:q35:defconfig:smp:initrd 
	i386:core2duo:q35:defconfig:nosmp:rootfs 
	i386:Conroe:pc:defconfig:nosmp:rootfs 
	i386:Opteron_G1:pc:defconfig:nosmp:initrd 
	i386:n270:q35:defconfig:nosmp:rootfs 
	x86_64:q35:Broadwell-noTSX:defconfig:smp:sata:rootfs 
	x86_64:q35:IvyBridge:defconfig:smp:nvme:rootfs 
	x86_64:q35:Nehalem:defconfig:smp:nvme:rootfs 
	x86_64:pc:phenom:defconfig:smp:sata:rootfs 
	x86_64:q35:Opteron_G1:defconfig:smp:scsi[DC395]:rootfs
	x86_64:q35:Opteron_G5:defconfig:smp:initrd 
	x86_64:q35:EPYC-IBPB:defconfig:smp:usbdisk:rootfs 
	x86_64:q35:Skylake-Client:defconfig:smp:initrd 
	x86_64:q35:Skylake-Server:defconfig:smp:usbdisk:rootfs 
	x86_64:q35:Opteron_G3:defconfig:smp:initrd
