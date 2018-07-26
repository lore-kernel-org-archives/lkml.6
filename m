Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03721C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B830A2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B830A2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbeGZODC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:03:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49528 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbeGZODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:03:01 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fifeo-0007D2-0z; Thu, 26 Jul 2018 14:46:14 +0200
Date:   Thu, 26 Jul 2018 14:46:13 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH RT] rtc: Disable RTC_DRV_EFI on RT
Message-ID: <20180726124613.xgmidioqd4mcqpiw@linutronix.de>
References: <20180726090449.hfvtey3ruzzhzdaz@linutronix.de>
 <CAKv+Gu_+t_VwY3xDq3nWbnOTfzBc6OtQeRD2GKsseO2uK-uruw@mail.gmail.com>
 <20180726121504.ba35z3j3wsesryy3@linutronix.de>
 <5052E25B-9942-40C1-BD53-86E3D7014557@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5052E25B-9942-40C1-BD53-86E3D7014557@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-26 14:26:25 [+0200], Ard Biesheuvel wrote:
> What i mean is whatever you end up with if you pass efi=noruntime to the kernel.
ah. So I wouldn't have to patch this, just document it. That might work.

> But as i mentioned before, you may also lose the ability to reboot/shut down your system this way. Can you please double check?

I checked before posting the patch. psci is used instead (on softiron
here, have nothing else). psci_sys_poweroff() works.

Sebastian
