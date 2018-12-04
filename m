Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA34C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0882082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0882082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbeLDJut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:50:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36286 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeLDJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:50:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so15175868wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 01:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZKVbcR4IStGL63pS+Wn8KIAgvCjxvVnFnBrE1QELbR0=;
        b=qnLABF8cLs0esR9FcgxkhDx/xtQr+Er6tmm9s6KRhSVUOfcFsegrB40NTxM9Uo+G4c
         DO2Gpu6a+UC9yud56Wmj53+D96CCgs1M1u0iRHEJYFitLX6UyevKi7DQ5Qz4L2DgOUEN
         k1+YH/ITjg1ztQBmpCLvW8yWd7LORBuHgwkC7A9Z9i7PvG5tKMKOQjv6FP3A52rijpgM
         JS2aNlgPXgII6smoqWeogm9BZytyNGh/L8zvq7Pzk3Y3u+rcE6Ta0Rihb/6WFNkTSN7Z
         LD61U1GxP86S3YbQ3xgja3gVd3Fw6m+mYNIGjJ4R+GuTafOxlCwBslsnjS1QH5QDgPqS
         oBng==
X-Gm-Message-State: AA+aEWYZwHRxOp/ZSJCybzx0eZ0QrhBSlmmQn/mHsC9ZuRv91jxD9pWF
        JUJyz2en3dKXmyRsWGbYMXbYzg==
X-Google-Smtp-Source: AFSGD/XBNLYa2pvbHEB2Jl2yc78WIOzB7EbaXim1lqSLlGmhd5G5sYpAVmrr/9Ip/zXOzRo0izD5RQ==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr16819820wrs.290.1543917047226;
        Tue, 04 Dec 2018 01:50:47 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id l202sm4698646wma.33.2018.12.04.01.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 01:50:46 -0800 (PST)
Date:   Tue, 4 Dec 2018 10:50:43 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFT PATCH v1 3/4] cpu-topology: Move cpu topology code to
 common code.
Message-ID: <20181204095043.GD23553@localhost.localdomain>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-4-git-send-email-atish.patra@wdc.com>
 <20181203165833.GA27796@arm.com>
 <20181203171223.GD17883@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203171223.GD17883@e107155-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/12/18 17:12, Sudeep Holla wrote:
> (Fixed Juri Lelli's email)
> 
> On Mon, Dec 03, 2018 at 04:58:34PM +0000, Will Deacon wrote:
> > On Thu, Nov 29, 2018 at 03:28:19PM -0800, Atish Patra wrote:
> > > Both RISC-V & ARM64 are using cpu-map device tree to describe
> > > their cpu topology. It's better to move the relevant code to
> > > a common place instead of duplicate code.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >  arch/arm64/include/asm/topology.h |  22 ---
> > >  arch/arm64/kernel/topology.c      | 303 +-------------------------------------
> > >  drivers/base/arch_topology.c      | 294 ++++++++++++++++++++++++++++++++++++
> >
> > Whilst I'm happy seeing this code moved out, I'd like to have an entry in
> > MAINTAINERS so that somebody can review changes from the arm64 side without
> > having to poll a load of different lists. I assume patches would still go
> > via Rafael and Greg, but if we could have Sudeep added as Reviewer for this
> > file, then I'd really appreciate it.
> >
> 
> Thanks Will for pointing this. I agree with you and like to be added as
> reviewer for this.
> 
> Since arch_topology.c was mostly added for ARM/ARM64 and by Juri Lelli 
> (who is no longer with ARM) and I did review the initial version, I would
> like to assume maintenance for this file if both Juri and Greg are OK
> with it so that I can keep an eye on this as we expect more changes to
> this both for ARM and RISC-V.

Sure, this is OK with me. Thanks for keeping an eye on this.

Best,

- Juri
