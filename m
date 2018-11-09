Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2C7C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF74D20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF74D20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeKIWIe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:08:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:45221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbeKIWIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:08:34 -0500
Received: from [74.104.183.64] ([74.104.183.64]) by
 msvc-mesg-gmx023.server.lan (via HTTP); Fri, 9 Nov 2018 13:28:00 +0100
MIME-Version: 1.0
Message-ID: <trinity-e1d06dde-12e1-4e2a-8871-d6c5f4af9f51-1541766480902@msvc-mesg-gmx023>
From:   "Qian Cai" <cai@gmx.us>
To:     "Marc Zyngier" <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "Jason Cooper" <jason@lakedaemon.net>
Subject: Re: WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 9 Nov 2018 13:28:00 +0100
In-Reply-To: <c8ff3004-33ee-19d5-8eb8-38d41f78c8ee@arm.com>
References: <1541710771.12945.7.camel@gmx.us>
 <c8ff3004-33ee-19d5-8eb8-38d41f78c8ee@arm.com>
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:subnKnNWiRT0ExeeKzajQGySooqyqbC7y3FHAfAeR6yqdEUnIVUJga0Xe+oNaoUjoT8rk
 D1ojyiQcsSwLmZ3NOMOPep7EBzB8U4Z3cWWpVyv3pg/oKBHZ3n3KFHz1Wgr55Qv9vhl2Se76JdDK
 vv3xxqjQGWNtJ0S2SIXvui4z1XC/N6U61R3kwBCMXPPnm01OtknsOpaWU5TE2OixvuCGridiUn1A
 lvCLjkhIFVGy9lbnqDHwXQk8yvQNhwDLjNxbjbpatmDTWHFnRoqIMYPkCEqgnZ3BRMFaynJqIW5N
 nMuQwwaiwC8/zslRJNQdSS0
X-UI-Out-Filterresults: notjunk:1;V01:K0:kAIGrQ2VSdk=:NzZfW9B05CnTOsIJASmGtw
 NcG/56PO0+hF8x7ZD54xBKFv9m5+oKfKQlvE7VyZH1V58ACNX5ookmjvXB8IEGwNuQfezVRJl
 9lMmiAWi+f4NT082/ALErw+KfsDi5YtuY2XsBRSj6GRcMu7j4jjnqZivXSoQnm2FpfacOks/D
 Iwgf3GQeI4jMG5PrjWLTwp8KjsAKXYtsakhFsf+CvjERP2gnbkodHT740bkY5qbK3TzNXb2cK
 tleRPvwLCoQ+RYpY7BlN03aW/9xAPZirO24MUIuSnFDum1mowsy5qnD+2wltrPasxiVq/Op3g
 fI9ux9LGhk9k5M4Kap5xmw/WZF5m3H9kjtHWN/Z+OlonveCC2sH5wd/ouz8bJmEXepyLqGoJ5
 2joLsr7ylmQ2gYfarq9sPZLS+twdT3yb/vtpmbWc+OnhK+IZBWm8X1A8RpEqaYtpPaN2UeQkp
 ht2wVGj1gc1kIfVzFCHqog6iFOONKOVQfNV2ao0y+4Rzf2LymJFu7Ta/dEhgKLJ9p36lAdxB6
 0CZs+zwpdkOqxae1At7yvKybNYkfhUAxcy4iaZpJHTTgxWatskAGpF2gtxYkpRH60JNJobqK9
 U3r3x3Moi2K/WTW65W3aGYjrXDZPLRWj2V
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/9/18 at 7:08 AM, Marc Zyngier wrote:

> [+Ard]
> 
> On 08/11/18 20:59, Qian Cai wrote:
> > Just booting up the latest git master (b00d209) on an aarch64 server and saw
> > this. Not sure about the third warning (at kernel/cpu.c:315
> > lockdep_assert_cpus_held+0x50/0x60) relates to irqchip or not, but appended it
> > to here anyway just in case.
> > 
> > [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:1696
> > its_init+0x588/0xb54
> 
> It looks like EFI cannot manage to reserve the memory for your GIC
> redistributors. Pretty annoying. At the same time, you have reported
> other issues with the EFI reservation mechanism, such as:
> 
> https://lore.kernel.org/patchwork/patch/1008413/
> 
> for which you have given a "Tested-by:". Is that related?
No, I don’t think so. Those warnings are still there even after applied the patch above.
