Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7B3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF13C21546
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF13C21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeI0QMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:12:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37955 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeI0QMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:12:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so1533869pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 02:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8H/NtF82T10HJZRWM/CboNvwMhwu/yGxl8dgUwRJjvc=;
        b=jPHwoEtVaFsH1V4sOr7SSPwNah2B+LNxTbNAUpgfClpbuG6vu6UW+MCP5VHbjDCrM6
         /1PlUv5M/Psm2ip5G4FvRWcfd1NWIdLpy5Q6+mBS+Yw1nQddb4QmXUzEgVLzqovJz7B5
         iijzYSXd2e7vBswQed+8B3QtosgIsAOjXrYH4Pu3dsF22CCxavOrIKRk+OwgJHI11Bax
         N0ch06QzAdEwSaecIzIyxWOWKHL36lhSWFzfkczX6CnmU5Qp5jyxI/m4OdbNtF710XFZ
         zg2Gw6fFxJMqYEwiVV9l1wIad32G5NQo9qmFsRey1T1zaGq/GdefnAOFBPubqMk6qs1z
         Qmsg==
X-Gm-Message-State: ABuFfohcM5rc1ihzs7wfi3OMDHNE9V4C0y64seOaOgiJJ7897p2/ijGB
        SBGreT/gOh7fTvOuL2BPvU+lOw==
X-Google-Smtp-Source: ACcGV62Mi6jNwuJV3UyJ12JPOResuMHpGiFf9rXDvhPDMbyZrC+fxZ/LRYSOknknBGakrGqa3bcZhg==
X-Received: by 2002:a17:902:5e3:: with SMTP id f90-v6mr10372313plf.286.1538042125950;
        Thu, 27 Sep 2018 02:55:25 -0700 (PDT)
Received: from [192.168.1.6] ([171.48.34.255])
        by smtp.gmail.com with ESMTPSA id y69-v6sm4157719pfd.36.2018.09.27.02.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 02:55:24 -0700 (PDT)
Subject: Re: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
To:     Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>, bhsharma@redhat.com
References: <20180921195954.21574-1-marc.zyngier@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <28640b87-007f-dc72-110a-a57179e2b76a@redhat.com>
Date:   Thu, 27 Sep 2018 15:25:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 09/22/2018 01:29 AM, Marc Zyngier wrote:
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
> 
> [1] https://marc.info/?l=linux-efi&m=153754757208163&w=2
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gicv3-kdump
> 
> Marc Zyngier (10):
>    irqchip/gic-v3-its: Change initialization ordering for LPIs
>    irqchip/gic-v3-its: Consolidate LPI_PENDBASE_SZ usage
>    irqchip/gic-v3-its: Split property table clearing from allocation
>    irqchip/gic-v3-its: Move pending table allocation to init time
>    irqchip/gic-v3-its: Keep track of property table's PA and VA
>    irqchip/gic-v3-its: Allow use of pre-programmed LPI tables
>    irqchip/gic-v3-its: Use pre-programmed redistributor tables with kdump
>      kernels
>    irqchip/gic-v3-its: Check that all RDs have the same property table
>    irqchip/gic-v3-its: Register LPI tables with EFI config table
>    irqchip/gic-v3-its: Allow use of LPI tables in reserved memory
> 
>   drivers/irqchip/irq-gic-v3-its.c   | 249 ++++++++++++++++++++++-------
>   drivers/irqchip/irq-gic-v3.c       |  20 ++-
>   include/linux/irqchip/arm-gic-v3.h |   4 +-
>   3 files changed, 208 insertions(+), 65 deletions(-)

Thanks for the patchset. I can confirm that with Ard's patchset in [1] 
and this patchset applied on 'efi/next' branch, I see that the "Booted 
with LPIs enabled, memory probably corrupted" issue that I was seeing on 
gigabyte boards in kdump kernel is fixed. Here are some logs:

without patchset applied:
=========================

[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: no VLPI support, direct LPI support
[    0.000000] ITS [mem 0x801000020000-0x80100021ffff]
[    0.000000] ITS@0x0000801000020000: allocated 2097152 Devices 
@c1000000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GIC: using LPI property table @0x00000000c03b0000
[    0.000000] GICv3: CPU0: found redistributor a region 
0:0x0000801080140000
[    0.000000] CPU0: Booted with LPIs enabled, memory probably corrupted
[    0.000000] CPU0: Failed to disable LPIs
<..snip..>
[  198.702976] dracut-initqueue[298]: Warning: dracut-initqueue timeout 
- starting timeout scripts
[  199.332238] dracut-initqueue[298]: Warning: dracut-initqueue timeout 
- starting timeout scripts
[  199.922944] dracut-initqueue[298]: Warning: dracut-initqueue timeout 
- starting timeout scripts
[  200.512239] dracut-initqueue[298]: Warning: dracut-initqueue timeout 
- starting timeout scripts
<..snip..>


with patchset applied:
======================
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: no VLPI support, direct LPI support
[    0.000000] GICv3: CPU0: found redistributor 109 region 
0:0x0000801080320000
[    0.000000] ITS [mem 0x801000020000-0x80100021ffff]
[    0.000000] ITS@0x0000801000020000: allocated 2097152 Devices 
@c1000000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: Using preallocated redistributor tables
[    0.000000] GICv3: using LPI property table @0x0000000fc0420000
[    0.000000] GICv3: CPU0: using reserved LPI pending table 
@0x0000000fc05c0000


So, please feel to add:
Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh
