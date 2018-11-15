Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE7BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F44208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puOTXfiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F44208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbeKOXan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:30:43 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35834 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbeKOXan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:30:43 -0500
Received: by mail-vs1-f65.google.com with SMTP id e7so11657901vsc.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6bVqNIwIjcqyAYRf50vXBp4OyR+LNfvyTizOI66xHF4=;
        b=puOTXfiI2DGAhVMtVCBW39dXRZgdGgPodyyc5puFvwz2y4L/PZdHOOLAOqBtXbJgXI
         MRoCoZKeU0CfK372huZyBNX91lobd2NdkX1hhvHFztRCPHvpGw3Si6zLibMVySCoW2LD
         KMVNnEza2Xpgm+HfMMSkw33ZVve4/bYV7USq1tDaZkxDP4DwiX+5K4FGPpAjWgFDOmm+
         gpBIItpEsSNDfiMteIogwxn5fF3dOQv/TmJT5/BhUMDsrPCSeokewzqA8lcR7BkDVC/g
         xhMyMCo80qDZyuPCfgvKJAmuFjLvcvlyiZc1IOIXaWKGvn/zOQf+JSidpdkFgACq8BJA
         BUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6bVqNIwIjcqyAYRf50vXBp4OyR+LNfvyTizOI66xHF4=;
        b=i77WHGhpwUIc920PpIEKsZBnmzLpPr6LXQ+ttIvL6U42m/QeN4mhWPf9xSIdEvM20m
         zQZHDAV54rlJbYJhqeGENfYuFv0L/txtisORpqa+66cJ5mZQw7Ij46z/RYfMBTbNnEz7
         m6Cpq87WY6/LA14GRGfi86E39PMMmEZX3094sH6YChX4yMyM2zjv5i+S3ItEV6DNE+zC
         5b3UeQeGVvgdPC+6vWfyY2gKySfkkpjTyvXEz7otNUPDp811lMHHXex1FX6ZmFt9XvDE
         zMVk5/uOK3JO+1CtVhKgtuUdgJcPsKuD6WoxI2lPfPmiISVeirlyxjDSo0i9N5ztYWHl
         QM/Q==
X-Gm-Message-State: AGRZ1gLxxizHAtlvqRxTQlSCezO7wl7ITX9LgzJ6A8qRIYUuNDSNa6vM
        4LazdXffUjhvRZN7LDav4NQva+O9EdoSj+hzRm3KhP7v
X-Google-Smtp-Source: AJdET5fYbZBOAxU6WoZHmvBI9fDTE1gHnGMlieSWAR1zOb/yibqY+esH7AQoVqxJ+t9NdhfRaHmMQFT/7UZEE9xiLCs=
X-Received: by 2002:a67:4b0f:: with SMTP id y15mr2661713vsa.50.1542288171324;
 Thu, 15 Nov 2018 05:22:51 -0800 (PST)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 15 Nov 2018 18:52:39 +0530
Message-ID: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
Subject: [ARM64] Printing IRQ stack usage information
To:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        kernelnewbies@kernelnewbies.org,
        Pintu Kumar <pintu.ping@gmail.com>, jungseoklee85@gmail.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        takahiro.akashi@linaro.org, mark.rutland@arm.com,
        barami97@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a requirement in printing irq stack usage information for each cpu.
I am using the following:
Linux Kernel: 4.9.x
Board: hikey620 (arm64, armv8 with 8 cores)
Platform: Ubuntu 14 debian

As a vague idea, I tried to implement like this:
-------------------------------------------------------------
static int dump_irq_stack_info(void)
{
        int cpu, actual;
        unsigned long irq_stack_ptr;
        //unsigned long sp, sp1;
        unsigned long stack_start;
        unsigned long used;

        actual = IRQ_STACK_SIZE;
        used = 0;
        pr_info("CPU UNUSED-STACK ACTUAL-STACK\n");
        //seq_printf(m, "CPU UNUSED-STACK ACTUAL-STACK\n");
        for_each_present_cpu(cpu) {
                irq_stack_ptr = IRQ_STACK_PTR(cpu);
                //sp1 = current_stack_pointer;
                //sp = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
                stack_start = (unsigned long)per_cpu(irq_stack, cpu);
                used = irq_stack_ptr - stack_start;
                pr_info("%2d %10lu %10d\n", cpu, used, actual);
                //seq_printf(m, "%2d %10lu %10d\n", cpu, used, actual);
        }

        return 0;
}
-------------------------------------------------------------
Currently, when I tested this (as a proc interface), I got the below output:
CPU    UNUSED-STACK    ACTUAL-STACK
 0         16368                     16384
 1         16368                     16384
 2         16368                     16384
 3         16368                     16384
 4         16368                     16384
 5         16368                     16384
 6         16368                     16384
 7         16368                     16384
-------------------------------------------------------------

But, I have some doubts:
1) I am not sure if my implementation is in right direction, or the
logic is totally wrong.
2) Is there better way to perform the similar objective?
3) How should I test it to get the different usage values for unused stack ?
    Can I get these values by implementing a sample interrupt handler,
and printing information from there?

If this works, then I want to use it as part of dump_backtrace() function.

If anybody have done a similar thing in past, or have some ideas to
share, please help me.

Note: This is required only for our internal debugging purpose.


Regards,
Pintu
