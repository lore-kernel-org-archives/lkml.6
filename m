Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3CCC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077B5214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077B5214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbeHBO64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:58:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37433 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbeHBO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:58:56 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flDKR-0006dy-DZ; Thu, 02 Aug 2018 15:07:43 +0200
Date:   Thu, 2 Aug 2018 15:07:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>
cc:     daniel.lezcano@linaro.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:timers/core] clocksource/drivers/arm_arch_timer: Fix bogus
 cpu_all_mask usage
In-Reply-To: <3fc750c9-fd3d-3a0c-ee86-b893de9ecc77@arm.com>
Message-ID: <alpine.DEB.2.21.1808021507320.2037@nanos.tec.linutronix.de>
References: <tip-6777996d27dd4f0a569ed9593e78db68c6b659cd@git.kernel.org> <3fc750c9-fd3d-3a0c-ee86-b893de9ecc77@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018, Sudeep Holla wrote:
> On 02/08/18 13:57, tip-bot for Thomas Gleixner wrote:
> > Commit-ID:  6777996d27dd4f0a569ed9593e78db68c6b659cd
> > Gitweb:     https://git.kernel.org/tip/6777996d27dd4f0a569ed9593e78db68c6b659cd
> > Author:     Thomas Gleixner <tglx@linutronix.de>
> > AuthorDate: Thu, 2 Aug 2018 14:53:10 +0200
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Thu, 2 Aug 2018 14:55:52 +0200
> > 
> > clocksource/drivers/arm_arch_timer: Fix bogus cpu_all_mask usage
> > 
> > Using cpu_all_mask as target mask for clockevents is wrong as it never can
> > actually target not possible CPUs. Use cpu_possible_mask instead
> > 
> 
> I think this was already merged for v4.18 as:
> Commit 5e18e412973d ("clocksource: arm_arch_timer: Set arch_mem_timer
> cpumask to cpu_possible_mask")
> 
> I assume you have earlier -rc as base for tip tree and you might have
> missed it.

AArg.
