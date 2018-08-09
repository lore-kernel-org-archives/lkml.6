Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CE9C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FC021EFA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp0NDexF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FC021EFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeHIXvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:51:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42239 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeHIXvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:51:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so3327201pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9SJzJjr9DyWXKRqVAeib1kyuLakLV3GeOzV44zSzPHg=;
        b=jp0NDexFnwY2zgjyaPaEG4u4Ac3LlH2iyR1CpfNbnDFT6P6TthSHS0x7Ag5VKmGH/Q
         vazkOv+wlevsizH8VwKPcb83mpm4rO+5/4zO4tR61g71i4lUAmwcaSk/xMgT/ZEbBW0p
         Xmb2nCyUbrsDhfjaQRFAoGOmnUcNY6Ea4HwHwHDZWKfwUuwyt9p2tm3iXaTBLEEk49Um
         jPZDjOCOAXzwDfdGLEk76Aljn69tV/9kJI+TN8PfdIGQhY2nwxTAmE5lsqGL5Ss/91Pb
         CKo1RbcXR/0F6zlA6BUiU/xpxuxan9X4isjKMyfH6u3vfpdh+6IPmYO49UWifREcrYJQ
         9m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9SJzJjr9DyWXKRqVAeib1kyuLakLV3GeOzV44zSzPHg=;
        b=Nl+BED7iBAmz5adkQXi9cm9XnSRhWtimLWVYqoRWUMjgqpyP26HCuM2nS0Hz80cq4J
         sTHQeCD0J90jnahL2mNQoylgpvGLofy/Mf/20plkzQxfHis3gTq3kFcGtz+4uTRQwNti
         6mSdFownyF9Yty/spRTJysRgcCBxebTe86zcb5wLrSYEoRAk+Z0NxAdbvfdK0TN+c9fJ
         zoEutyDHFLrXYTc8snxW0I7sq5znBzfhmEPkY2nIk1v/dn+7f+Qm8UeMs63aIfre8jHS
         SyRENOOTAelCy16xmrnDHdyvScmY2v3DpkhClgtt2wmQwdQXpJ97NetTJB0eKyOfixm6
         e6mQ==
X-Gm-Message-State: AOUpUlEhCsd787otFx06pvxFNub/p7Loo1Yyo/2kMlTeMmjxwlcFvXJt
        f2J5hoP5jr1ezz+7bgTIzaY=
X-Google-Smtp-Source: AA+uWPwOSUPJAL+JkhO4Bz0MW+w1G5Ubr3jbpSdEWgs+MIUWoqT2k6/14ovzGFdiXbkCk2LjeR1D3Q==
X-Received: by 2002:a63:6b03:: with SMTP id g3-v6mr3690952pgc.57.1533849863591;
        Thu, 09 Aug 2018 14:24:23 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g20-v6sm9600560pfo.94.2018.08.09.14.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 14:24:22 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:24:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        Andrew Waterman <andrew@sifive.com>, dan.carpenter@oracle.com,
        linux@dominikbrodowski.net, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: [PATCH v2 2/2] RISC-V: Don't use a global include guard for
 uapi/asm/syscalls.h
Message-ID: <20180809212422.GB13675@roeck-us.net>
References: <20180809202524.1702-1-palmer@sifive.com>
 <20180809202524.1702-3-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809202524.1702-3-palmer@sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 01:25:24PM -0700, Palmer Dabbelt wrote:
> This file is expected to be included multiple times in the same file in
> order to allow the __SYSCALL macro to generate system call tables.  With
> a global include guard we end up missing __NR_riscv_flush_icache in the
> syscall table, which results in icache flushes that escape the vDSO call
> to not actually do anything.
> 
> The fix is to move to per-#define include guards, which allows the
> system call tables to actually be populated.  Thanks to Macrus Comstedt
> for finding and fixing the bug!
> 
> I also went ahead and fixed the SPDX header to use a //-style comment,
> which I've been told is the canonical way to do it.
> 
> Cc: Marcus Comstedt <marcus@mc.pp.se>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

[Compile-]Tested-by: Guenter Roeck <linux@roeck-us.net>

on top of linux-next after reverting the version of the patch there.

I also tried to run the resulting image (defconfig) with qemu (built
from https://github.com/riscv/riscv-qemu.git), but that still doesn't
work. I assume there are still some patches missing ?

Thanks,
Guenter
