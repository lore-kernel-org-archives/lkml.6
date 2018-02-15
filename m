Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033902AbeBOUVp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:21:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033275AbeBOUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:21:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 582BD60585
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 15 Feb 2018 20:21:41 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org
Subject: Re: [PATCH v6 1/2] drivers: irqchip: pdc: Add PDC interrupt
 controller for QCOM SoCs
Message-ID: <20180215202141.GC23714@codeaurora.org>
References: <20180209165735.19151-1-ilina@codeaurora.org>
 <20180209165735.19151-2-ilina@codeaurora.org>
 <alpine.DEB.2.21.1802121430020.1158@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1802121430020.1158@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12 2018 at 13:40 +0000, Thomas Gleixner wrote:
>On Fri, 9 Feb 2018, Lina Iyer wrote:
>> +enum pdc_irq_config_bits {
>> +	PDC_POLARITY_LOW	= 0,
>> +	PDC_FALLING_EDGE	= 2,
>> +	PDC_POLARITY_HIGH	= 4,
>> +	PDC_RISING_EDGE		= 6,
>> +	PDC_DUAL_EDGE		= 7,
>
>My previous comment about using binary constants still stands. Please
>either address review comments or reply at least. Ignoring reviews is not
>an option.
>
>Aside of that I really have to ask about the naming of these constants. Are
>these names hardware register nomenclature? If yes, they are disgusting. If
>no, they are still disgusting, but should be changed to sensible ones,
>which just match the IRQ_TYPE naming convention.
>
>    PDC_LEVEL_LOW	= 000b,
>    PDC_EDGE_FALLING	= 010b,
>    ....
>
>
Checkpatch doesn't like binary constants. I guess I will need to keep
the enum definitions in hex or decimal. I will remove the binary from
the comments though.

commit 95e2c6023b0e4c8499fb521697f79215f69135fe
Author: Joe Perches <joe@perches.com>
Date:   Wed Jul 3 15:05:20 2013 -0700

    checkpatch: warn when using gcc's binary constant ("0b") extension

    The gcc extension for binary constants that start with 0b is only
    supported with gcc version 4.3 or higher.

    The kernel can still be compiled with earlier versions of gcc, so have
    checkpatch emit a warning for these constants.

    Restructure checkpatch's constant finding code a bit to support finding
    these binary constants.

    Signed-off-by: Joe Perches <joe@perches.com>
    Suggested-by: Andrew Morton <akpm@linux-foundation.org>
    Cc: Andy Whitcroft <apw@canonical.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>


Thanks,
Lina
