Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B7E21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KCuNC0LM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QKu1W79e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B7E21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbeKPEka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:40:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKPEka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:40:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D0296076A; Thu, 15 Nov 2018 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542306695;
        bh=jpEIkjvcZ8jlQzVWhG3nb8LE1eYiqzJG4XzJilQuduI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KCuNC0LMz7AfCGu/kdvTHh7oblZPtonfPdbiEoVPpiJzyGShTBzNZX2QvIvzHPaoq
         Q/jlFSmTdBpsN/3MuO82Fg+dFlNlhnhFDJzq82AW4FzLL5bV03x8AA4WPZcimFFxxG
         9xKiMOIrZhhNwcB9BnhdRkM6vxS6tu8mVVSOGw24=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 909E96044B;
        Thu, 15 Nov 2018 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542306694;
        bh=jpEIkjvcZ8jlQzVWhG3nb8LE1eYiqzJG4XzJilQuduI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QKu1W79eS6Bw8yuhfurqGZFSHwzm/7sD/nYeABUsCmytWancBGfZ6zLl2EvyszIyd
         zX5w9mkzJJaO+prs6AEWlVgKsn1jNkoZ58EchcUTq2w4dwishZ12L2ze90yQ0U3WCw
         pGo2DvmiAn2FUcL1QafDrEo8TfMrYqzA4pmAvftY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 909E96044B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [RFC 0/3] Unify CPU topology across ARM64 & RISC-V
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        Damien.LeMoal@wdc.com, juri.lelli@arm.com, anup@brainfault.org,
        palmer@sifive.com, jeremy.linton@arm.com, robh+dt@kernel.org,
        sudeep.holla@arm.com, mick@ics.forth.gr,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <07d92dd4-f943-47ee-e168-46bfaf4ed755@codeaurora.org>
Date:   Thu, 15 Nov 2018 11:31:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/2018 6:50 PM, Atish Patra wrote:
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
> to code. The only downside in this approach is that the capacity
> code will be executed for RISC-V as well. But, it will exit
> immediately after not able to find the appropriate DT node. If
> the overhead is considered too much, we can always compile out
> capacity related functions under a different config for the
> architectures that do not support them.
> 
> The patches have been tested for RISC-V and compile tested for
> ARM64.
> 
> The socket changes[2] can be merged on top of this series or vice
> versa.
> 
> [1] https://lkml.org/lkml/2018/11/6/19
> [2] https://lkml.org/lkml/2018/11/7/918
> 
> Atish Patra (3):
>    dt-binding: cpu-topology: Move cpu-map to a common binding.
>    cpu-topology: Move cpu topology code to common code.
>    RISC-V: Parse cpu topology during boot.
> 
>   Documentation/devicetree/bindings/arm/topology.txt | 475 -------------------
>   .../devicetree/bindings/cpu/cpu-topology.txt       | 526 +++++++++++++++++++++
>   arch/arm64/include/asm/topology.h                  |  23 +-
>   arch/arm64/kernel/topology.c                       | 305 +-----------
>   arch/riscv/Kconfig                                 |   1 +
>   arch/riscv/kernel/smpboot.c                        |   6 +-
>   drivers/base/arch_topology.c                       | 303 ++++++++++++
>   include/linux/arch_topology.h                      |  23 +
>   include/linux/topology.h                           |   1 +
>   9 files changed, 864 insertions(+), 799 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/topology.txt
>   create mode 100644 Documentation/devicetree/bindings/cpu/cpu-topology.txt
> 

I was interested in testing these on QDF2400, an ARM64 platform, since 
this series touches core ARM64 code and I'd hate to see a regression. 
However, I can't figure out what baseline to use to apply these. 
Different patches cause different conflicts of a variety of baselines I 
attempted.

What are these intended to apply to?

Also, you might want to run them through checkpatch next time.  There 
are several whitespace errors.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
