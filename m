Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD69C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195982084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv2QdprX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195982084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeJDUkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:40:10 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:37037 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJDUkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:40:10 -0400
Received: by mail-pf1-f174.google.com with SMTP id j23-v6so3423463pfi.4;
        Thu, 04 Oct 2018 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZgVHF3X9S6Ky8CrrWV52tY2m+rJDK+y9LXo9OG/AbxI=;
        b=fv2QdprX07tzuxgUdtqlXKYUSV2dM/qtBFsnv3W8tP1VNUaE+xbyVX+60DfhUnYeCQ
         u9JumIVo/WknVWOlAGwrV8TCGD5L5LYvseljgKFNUZPfYwFCG3PWGURNvskHemW030Li
         gwk3bOd9Pa6vh2PDn+Y5QwGsjdLB+Z77pfyOhEnzO8+d4gY8ZBiz2r0OfUzCsuJNv5KT
         pKbOxyblB5cGIA7OXca6B/XjJnMESsEsG/Cq28M1KhwIS8DC/Iw9X1W9rUEMpSbBVRvq
         NVwdDNsGy3oX6ht6fAPSdn2Q252ub+q1uddMbwFnAwilOZs6zD28mVH+8na/JQ9xSjNE
         T+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZgVHF3X9S6Ky8CrrWV52tY2m+rJDK+y9LXo9OG/AbxI=;
        b=CyCqwsuQMACabeqFtKvkEQ/PrxxABkmH8VP01MDVCBZuC6Oug9BDJI9ZrxSBK3Zs1z
         zQ7ORG5MK8vJEOwf3eRSA3zjRFgZIjgAjrkgcQ65GcCLn+Q0YH4jyuOi5u9AoI23D45Q
         3hlt/dJwLLHKEAgXZvR1uuhPCCLIvuRAL7MzhTmSCPQK7CtnKzl9qg8k5JixrmC6jOCP
         yeUx59iKSL1iSm5hq/PgTtUGUZLbWuWpCakEzA9x9kijO7b92DYpyYHvfvqopMhO5Z3S
         ldIXqFsis3KzxkXWgbSGHb+EiJUBPQ59pGGBZVnFqU/S6pbXlj0W1mnELikML6N/KvIW
         yaeg==
X-Gm-Message-State: ABuFfogMpLrl/fXXCHvdPjRj8fMDzN3QEY0aenrw7C+ofJ55PErbDf63
        FdWPVF+1wb10j87+cpQXMs+cAPh1
X-Google-Smtp-Source: ACcGV60+7J8HAo/Si0zmPclXGjyUSPVZgFrAdGkYQQ1tmQWGrZoB1SyMy9dUav4wixMcwKk9eLpbLg==
X-Received: by 2002:a62:401:: with SMTP id 1-v6mr6836564pfe.236.1538660807111;
        Thu, 04 Oct 2018 06:46:47 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u36-v6sm15164802pgn.56.2018.10.04.06.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:46:45 -0700 (PDT)
Date:   Thu, 4 Oct 2018 06:46:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Oct 4
Message-ID: <20181004134644.GA9130@roeck-us.net>
References: <20181004183449.36bcc93b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004183449.36bcc93b@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 06:34:49PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181003:
> 
> The bpf-next tree still had its build failure so I used the version
> from next-20181002.
> 
> The kvm-arm tree gained conflicts against the arm64 tree.
> 
> The tty tree gained a build failure so I used the version from
> next-20181003.
> 
> The slave-dma tree gained a build failure so I used the version from
> next-20181003.
> 
> The userns tree gained a conflict against the y2038 tree.
> 
> Non-merge commits (relative to Linus' tree): 8120
>  7864 files changed, 365604 insertions(+), 168933 deletions(-)
> 

Time for a status report.

Build results:
	total: 135 pass: 121 fail: 14
Failed builds: 
	arm:allmodconfig 
	i386:allyesconfig 
	i386:allmodconfig 
	m68k:defconfig 
	m68k:allmodconfig 
	m68k:sun3_defconfig 
	mips:allmodconfig 
	parisc:allmodconfig 
	powerpc:ppc6xx_defconfig 
	s390:defconfig 
	s390:allmodconfig 
	s390:allnoconfig 
	sparc32:allmodconfig 
	xtensa:allmodconfig 
Qemu test results:
	total: 318 pass: 249 fail: 69
Failed tests: 
	m68k:q800:m68040:mac_defconfig:initrd 
	m68k:q800:m68040:mac_defconfig:rootfs 
	mips:malta_defconfig:smp:usb-xhci:rootfs 
	mips:malta_defconfig:smp:usb-uas-xhci:rootfs 
	mips:malta_defconfig:smp:scsi[53C810]:rootfs 
	mips:malta_defconfig:smp:scsi[53C895A]:rootfs 
	mips:malta_defconfig:smp:scsi[DC395]:rootfs 
	mips:malta_defconfig:smp:scsi[AM53C974]:rootfs 
	mips:malta_defconfig:smp:scsi[MEGASAS]:rootfs 
	mips:malta_defconfig:smp:scsi[MEGASAS2]:rootfs 
	mips:malta_defconfig:smp:scsi[FUSION]:rootfs 
	mips64:malta_defconfig:smp:usb-xhci:rootfs 
	mips64:malta_defconfig:smp:usb-uas-xhci:rootfs 
	mips64:malta_defconfig:smp:scsi[53C810]:rootfs 
	mips64:malta_defconfig:smp:scsi[DC395]:rootfs 
	mips64:malta_defconfig:smp:scsi[AM53C974]:rootfs 
	mips64:malta_defconfig:smp:scsi[MEGASAS]:rootfs 
	mips64:malta_defconfig:smp:scsi[MEGASAS2]:rootfs 
	mips64:malta_defconfig:smp:scsi[FUSION]:rootfs 
	mipsel:24Kf:malta_defconfig:smp:usb-xhci:rootfs 
	mipsel:24Kc:malta_defconfig:smp:usb-uas-xhci:rootfs 
	mipsel:34Kf:malta_defconfig:smp:scsi[53C810]:rootfs 
	mipsel:74Kf:malta_defconfig:smp:scsi[53C895A]:rootfs 
	mipsel:M14Kc:malta_defconfig:smp:scsi[DC395]:rootfs 
	mipsel:24Kf:malta_defconfig:smp:scsi[AM53C974]:rootfs 
	mipsel:24Kf:malta_defconfig:smp:scsi[MEGASAS]:rootfs 
	mipsel:24Kf:malta_defconfig:smp:scsi[MEGASAS2]:rootfs 
	mipsel:24Kf:malta_defconfig:smp:scsi[FUSION]:rootfs 
	mipsel64:64r6el_defconfig:boston:rootfs 
	parisc:defconfig:smp:nvme:rootfs 
	parisc:defconfig:smp:scsi:rootfs 
	parisc:defconfig:smp:scsi[53C895A]:rootfs 
	parisc:defconfig:smp:scsi[DC395]:rootfs 
	parisc:defconfig:smp:scsi[AM53C974]:rootfs 
	parisc:defconfig:nosmp:usb-xhci:rootfs 
	parisc:defconfig:nosmp:usb-uas-xhci:rootfs 
	parisc:defconfig:nosmp:nvme:rootfs 
	s390:defconfig:initrd 
	s390:defconfig:virtio-blk-ccw:rootfs 
	s390:defconfig:scsi[virtio-ccw]:rootfs 
	sh:rts7751r2dplus_defconfig:nvme:rootfs 
	sh:rts7751r2dplus_defconfig:usb-xhci:rootfs 
	sh:rts7751r2dplus_defconfig:usb-uas-xhci:rootfs 
	sh:rts7751r2dplus_defconfig:scsi[53C810]:rootfs 
	sh:rts7751r2dplus_defconfig:scsi[53C895A]:rootfs 
	sh:rts7751r2dplus_defconfig:scsi[FUSION]:rootfs 
	i386:q35:Broadwell:defconfig:smp:ata:rootfs 
	i386:q35:IvyBridge:defconfig:smp2:efi32:nvme:rootfs 
	i386:q35:Conroe:defconfig:smp4:scsi[DC395]:rootfs 
	i386:q35:Nehalem:defconfig:smp6:scsi[AM53C974]:rootfs 
	i386:q35:Westmere-IBRS:defconfig:smp:efi32:scsi[53C810]:rootfs 
	i386:q35:Skylake-Server:defconfig:smp2:scsi[53C895A]:rootfs 
	i386:pc:EPYC:defconfig:smp:efi32:scsi[MEGASAS]:rootfs 
	i386:q35:EPYC-IBPB:defconfig:smp:scsi[MEGASAS2]:rootfs 
	i386:q35:Opteron_G5:defconfig:smp:efi32:scsi[FUSION]:rootfs 
	i386:q35:Opteron_G4:defconfig:nosmp:efi32:ata:rootfs 
	i386:q35:n270:defconfig:nosmp:ata:rootfs 
	i386:q35:pentium3:defconfig:pae:nosmp:nvme:rootfs 
	x86_64:q35:Broadwell-noTSX:defconfig:smp:mem256:ata:rootfs 
	x86_64:q35:IvyBridge:defconfig:smp2:efi:mem512:nvme:rootfs 
	x86_64:q35:Conroe:defconfig:smp4:efi32:mem256:scsi[DC395]:rootfs 
	x86_64:q35:Nehalem:defconfig:smp:mem512:scsi[AM53C974]:rootfs 
	x86_64:q35:Westmere-IBRS:defconfig:smp2:efi:mem1G:scsi[53C810]:rootfs 
	x86_64:q35:Skylake-Server:defconfig:smp4:efi32:mem2G:scsi[53C895A]:rootfs
	x86_64:pc:EPYC:defconfig:smp:mem4G:scsi[FUSION]:rootfs 
	x86_64:q35:EPYC-IBPB:defconfig:smp2:efi:mem8G:scsi[MEGASAS]:rootfs 
	x86_64:q35:Opteron_G5:defconfig:smp4:efi32:mem256:scsi[MEGASAS2]:rootfs
	x86_64:q35:Opteron_G4:defconfig:nosmp:efi:mem512:ata:rootfs 
	x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:efi32:mem2G:ata:rootfs

Details are available at https://kerneltests.org/builders.

Guenter
