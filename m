Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD9C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6284C2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6284C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeI2Ud2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 16:33:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:50314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728089AbeI2Ud1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 16:33:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B3EEAE78;
        Sat, 29 Sep 2018 14:04:50 +0000 (UTC)
Subject: Re: [PATCH 1/2] sc16is7xx: Fix for multi-channel stall
To:     Phil Elwell <phil@raspberrypi.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1536762716-30673-1-git-send-email-phil@raspberrypi.org>
 <1536762716-30673-2-git-send-email-phil@raspberrypi.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Michael Allwright <allsey87@gmail.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        Xue Liu <liuxuenetmail@gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <6028e8e5-f8a6-fbe0-8d2a-b6bb3c91aa14@suse.de>
Date:   Sat, 29 Sep 2018 16:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536762716-30673-2-git-send-email-phil@raspberrypi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil and Greg,

Am 12.09.18 um 16:31 schrieb Phil Elwell:
> The SC16IS752 is a dual-channel device. The two channels are largely
> independent, but the IRQ signals are wired together as an open-drain,
> active low signal which will be driven low while either of the
> channels requires attention, which can be for significant periods of
> time until operations complete and the interrupt can be acknowledged.
> In that respect it is should be treated as a true level-sensitive IRQ.
> 
> The kernel, however, needs to be able to exit interrupt context in
> order to use I2C or SPI to access the device registers (which may
> involve sleeping).  Therefore the interrupt needs to be masked out or
> paused in some way.
> 
> The usual way to manage sleeping from within an interrupt handler
> is to use a threaded interrupt handler - a regular interrupt routine
> does the minimum amount of work needed to triage the interrupt before
> waking the interrupt service thread. If the threaded IRQ is marked as
> IRQF_ONESHOT the kernel will automatically mask out the interrupt
> until the thread runs to completion. The sc16is7xx driver used to
> use a threaded IRQ, but a patch switched to using a kthread_worker
> in order to set realtime priorities on the handler thread and for
> other optimisations. The end result is non-threaded IRQ that
> schedules some work then returns IRQ_HANDLED, making the kernel
> think that all IRQ processing has completed.
> 
> The work-around to prevent a constant stream of interrupts is to
> mark the interrupt as edge-sensitive rather than level-sensitive,
> but interpreting an active-low source as a falling-edge source
> requires care to prevent a total cessation of interrupts. Whereas
> an edge-triggering source will generate a new edge for every interrupt
> condition a level-triggering source will keep the signal at the
> interrupting level until it no longer requires attention; in other
> words, the host won't see another edge until all interrupt conditions
> are cleared. It is therefore vital that the interrupt handler does not
> exit with an outstanding interrupt condition, otherwise the kernel
> will not receive another interrupt unless some other operation causes
> the interrupt state on the device to be cleared.
> 
> The existing sc16is7xx driver has a very simple interrupt "thread"
> (kthread_work job) that processes interrupts on each channel in turn
> until there are no more. If both channels are active and the first
> channel starts interrupting while the handler for the second channel
> is running then it will not be detected and an IRQ stall ensues. This
> could be handled easily if there was a shared IRQ status register, or
> a convenient way to determine if the IRQ had been deasserted for any
> length of time, but both appear to be lacking.
> 
> Avoid this problem (or at least make it much less likely to happen)
> by reducing the granularity of per-channel interrupt processing
> to one condition per iteration, only exiting the overall loop when
> both channels are no longer interrupting.
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> ---
>  drivers/tty/serial/sc16is7xx.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

These two patches seem to be applied in linux-next tree, but are lacking
a Fixes: header for backporting to affected stable trees.

openSUSE Tumbleweed's 4.18 appears to be affected, and I didn't see it
in linux.git for upcoming 4.19 either.

Can the commit message still be updated to get this fixed everywhere?

Which is the offending commit, this one from 2016? The only other 2018
change seems an unrelated error handling cleanup.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/tty/serial/sc16is7xx.c?id=04da73803c05dc1150ccc31cbf93e8cd56679c09

Also, the above commit message confuses me as to how after this commit
the driver should be used: Should the interrupt still be falling-edge,
as documented in the DT bindings, or do user/documentation need to
switch to level-triggered now?

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
