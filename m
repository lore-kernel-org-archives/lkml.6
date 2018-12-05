Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF7DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AB721527
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jEPlZuZN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="afjxP2At"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AB721527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbeLERxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:53:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLERxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:53:06 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 19F9D6130A; Wed,  5 Dec 2018 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544032385;
        bh=G9oKZZilgO3BZDnZaaI7leZn+vuaR+/z1msJ6vBFp9A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jEPlZuZNYIIBzg2wJoqu5gC0si2wBNHbxujQrzWXruOAfLgEcvEcswnjVBc/zOilo
         0WhaPpR1T1BiADrAiTZGgbT1HyuzjQUJNm9AFxTKIsto4U3d98zlyHJVEhULwWXzHk
         cWAfLqzJ7fgKb7IeYqmaW2Xwicrv8gQ/1GOjDt3Q=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90C3B60D92;
        Wed,  5 Dec 2018 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544032384;
        bh=G9oKZZilgO3BZDnZaaI7leZn+vuaR+/z1msJ6vBFp9A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=afjxP2AtqzEG66du9V2DUvphy8q1rLvutgJTTlCLSMGSGgQ53D8nwK8VeqPeoat6b
         zzsVdTPIUCUzmvZJPkW1pt0VykUsL38kMcZiN/54Ck2qXkRHOOzgq/V8PVv/9/YIx/
         7xqzyb4GdUcR8UtQflOnT4JTMr5gn4AUc3pvJ6FU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90C3B60D92
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [RFT PATCH v1 0/4] Unify CPU topology across ARM64 & RISC-V
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-riscv@lists.infradead.org,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@arm.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Ingo Molnar <mingo@kernel.org>, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:ARM64 PORT AARCH64 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <d72a87f4-8dc1-2ec7-b602-0135c5e4c3a7@codeaurora.org>
Date:   Wed, 5 Dec 2018 10:53:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/2018 4:28 PM, Atish Patra wrote:
> The cpu-map DT entry in ARM64 can describe the CPU topology in
> much better way compared to other existing approaches. RISC-V can
> easily adopt this binding to represent it's own CPU topology.
> Thus, both cpu-map DT binding and topology parsing code can be
> moved to a common location so that RISC-V or any other
> architecture can leverage that.
> 
> The relevant discussion regarding unifying cpu topology can be
> found in [1].
> 
> arch_topology seems to be a perfect place to move the common
> code. I have not introduced any functional changes in the moved
> code. The only downside in this approach is that the capacity
> code will be executed for RISC-V as well. But, it will exit
> immediately after not able to find the appropriate DT node. If
> the overhead is considered too much, we can always compile out
> capacity related functions under a different config for the
> architectures that do not support them.
> 
> The patches have been tested for RISC-V and compile tested for
> ARM64 & x86.
> 
> The socket change[2] is also now part of this series.
> 
> [1] https://lkml.org/lkml/2018/11/6/19
> [2] https://lkml.org/lkml/2018/11/7/918
> 
> QEMU changes for RISC-V topology are available at
> 
> https://github.com/atishp04/riscv-qemu/tree/cpu_topo
> 
> Apologies for the previous patch series with incorrect title and
> was sent only to kernel mailing list due to a bug in my config.
> Please ignore that.
> 
> Atish Patra (3):
> dt-binding: cpu-topology: Move cpu-map to a common binding.
> cpu-topology: Move cpu topology code to common code.
> RISC-V: Parse cpu topology during boot.
> 
> Sudeep Holla (1):
> Documentation: DT: arm: add support for sockets defining package
> boundaries
> 
> .../{arm/topology.txt => cpu/cpu-topology.txt}     | 133 +++++++--
> arch/arm64/include/asm/topology.h                  |  22 --
> arch/arm64/kernel/topology.c                       | 303 +--------------------
> arch/riscv/Kconfig                                 |   1 +
> arch/riscv/kernel/smpboot.c                        |   3 +
> drivers/base/arch_topology.c                       | 294 ++++++++++++++++++++
> include/linux/arch_topology.h                      |  26 ++
> include/linux/topology.h                           |   1 +
> 8 files changed, 435 insertions(+), 348 deletions(-)
> rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)
> 
> --
> 2.7.4
> 

Seems to test fine on QDF2400.

Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

I did see that git am complained about patch #2 -

patch:103: space before tab in indent.
                         };
patch:114: space before tab in indent.
         };
warning: 2 lines add whitespace errors.


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
