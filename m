Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C384C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337B421571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MiHY2I6p";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HUwv2Th0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337B421571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeI1DbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:31:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:31:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D5488609A8; Thu, 27 Sep 2018 21:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538082653;
        bh=U1f7Qo7jJFn2XoIFfYq9zZn4KCmjZdEBrJuyDk/ikOI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MiHY2I6ps8gl+dYXQwASXCgbQcvel/pp73ZfBOfdUbjXipC5ubX7wxfJeRmBGGgKB
         ggxMz7/WEXb21cUQ4lBcWgtQ719VgxCH0XT0DKHuJtuIIeP4zbMk71v2vDGSDMivn0
         K/SS9YafoxFLPV/PrSMeFaGEepB+SLtmGWiU7whc=
Received: from [10.226.60.82] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rruigrok@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D05C60128;
        Thu, 27 Sep 2018 21:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538082652;
        bh=U1f7Qo7jJFn2XoIFfYq9zZn4KCmjZdEBrJuyDk/ikOI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HUwv2Th05UqM4OBwQaHG1yPgWOkqGPfUhIl5vXlCCYJhea4XOlofJEt63jstijp1A
         E+Qsg2ShATUmTpB1/PoQ6yy28xiwHocgdSwCSAipSH8B/TxmVrjoJHufIp7nCSEUeM
         kdZwlU7gsAP9O0ZJfYc4Tm3b9RMs0d/4HTNf/Ezc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D05C60128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rruigrok@codeaurora.org
Subject: Re: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
To:     Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
From:   Richard Ruigrok <rruigrok@codeaurora.org>
Message-ID: <44ac1fad-8df4-4738-0f25-8a7a2de8f6df@codeaurora.org>
Date:   Thu, 27 Sep 2018 15:10:50 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

On 9/21/2018 1:59 PM, Marc Zyngier wrote:
> The GICv3 architecture has the remarkable feature that once LPI tables
> have been assigned to redistributors and that LPI delivery is enabled,
> there is no guarantee that LPIs can be turned off (and most
> implementations do not allow it), nor can it be reprogrammed to use
> other tables.
>
> This is a bit of a problem for kexec, where the secondary kernel
> completely looses track of the previous allocations. If the secondary
> kernel doesn't allocate the tables exactly the same way, no LPIs will
> be delivered by the GIC (which continues to use the old tables), and
> memory previously allocated for the pending tables will be slowly
> corrupted, one bit at a time.
>
> The workaround for this is based on a series[1] by Ard Biesheuvel,
> which adds the required infrastructure for memory reservations to be
> passed from one kernel to another using an EFI table.
>
> This infrastructure is then used to register the allocation of GIC
> tables with EFI, and allow the GIC driver to safely reuse the existing
> programming if it detects that the tables have been correctly
> registered. On non-EFI systems, there is not much we can do.
>
> This has been tested on a TX2 system both as a host and a guest. I'd
> welcome additional testing of different HW. For convenience, I've
> stashed a branch containing the whole thing at [2].
I tested [2] from the 4.19-rc4 set which included this series and [1].
Tested kexec on Centriq system with ITS support (46 core).  On-board was a MLX CX5 NIC, verified MSIs are active in /proc/interrupts.
Prior to this we used a workaround from Shanker to reuse the same tables in the kexec'ed kernel.
Let me know if further testing is needed, and thanks for adding this support.
> [1] https://marc.info/?l=linux-efi&m=153754757208163&w=2
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gicv3-kdump
>
> Marc Zyngier (10):
>   irqchip/gic-v3-its: Change initialization ordering for LPIs
>   irqchip/gic-v3-its: Consolidate LPI_PENDBASE_SZ usage
>   irqchip/gic-v3-its: Split property table clearing from allocation
>   irqchip/gic-v3-its: Move pending table allocation to init time
>   irqchip/gic-v3-its: Keep track of property table's PA and VA
>   irqchip/gic-v3-its: Allow use of pre-programmed LPI tables
>   irqchip/gic-v3-its: Use pre-programmed redistributor tables with kdump
>     kernels
>   irqchip/gic-v3-its: Check that all RDs have the same property table
>   irqchip/gic-v3-its: Register LPI tables with EFI config table
>   irqchip/gic-v3-its: Allow use of LPI tables in reserved memory
>
>  drivers/irqchip/irq-gic-v3-its.c   | 249 ++++++++++++++++++++++-------
>  drivers/irqchip/irq-gic-v3.c       |  20 ++-
>  include/linux/irqchip/arm-gic-v3.h |   4 +-
>  3 files changed, 208 insertions(+), 65 deletions(-)
>

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

