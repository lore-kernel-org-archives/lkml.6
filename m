Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeDYDXW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 23:23:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39645 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeDYDXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 23:23:18 -0400
X-Google-Smtp-Source: AIpwx4/XpGYDd5KWYKt1eu5V2IbSmPhe/Hd/wvvxf9Uqyt7lOVn/xx027YvbhN7/y+Xsla5R2K5DRg==
To: linux-kernel@vger.kernel.org
Cc: Marc Zyngier <marc.zyngier@arm.com>, tglx@linutronix.de,
        jason@lakedaemon.net, Catalin Marinas <catalin.marinas@arm.com>
From: valmiki <valmikibow@gmail.com>
Subject: Affinity for GIC irq line
Message-ID: <2880aee6-704c-a5aa-e193-75bba1bce43d@gmail.com>
Date: Wed, 25 Apr 2018 08:53:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When an IRQ line is set affinity using irq_set_affinity, which calls 
irq_do_set_affinity, this API copies affinity mask to affinity variable 
in irq_common_data of this irq descriptor.

But as per ARM GICv2 document in order to drive a interrupt to a 
specific CPU we need to program GICD_ITARGETSRn register.

But irq_set_affinity isn't writing to this register.Please correct me if 
I'm wrong i did not find code for this register being updated in 
irq_set_affinity flow.
So how affinity is being set for an IRQ line ?

If affinity was set successfully on what CPU does asm_do_IRQ run ?
For every interrupt this runs on CPU0 and then FIQ/IRQ handling is 
scheduled on different CPU as per affinity ?
How the respective irq line handler is handled on specific CPU core ?

Regards,
Valmiki


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
