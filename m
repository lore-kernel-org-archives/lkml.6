Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A1BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAA9205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394061AbfAPPXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:23:31 -0500
Received: from foss.arm.com ([217.140.101.70]:50732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394042AbfAPPXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:23:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16DDB80D;
        Wed, 16 Jan 2019 07:23:31 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1E853F5C1;
        Wed, 16 Jan 2019 07:23:29 -0800 (PST)
Subject: Re: preempt_schedule_irq() loop question
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <cc989920-a13b-d53b-db83-1584a7f53edc@arm.com>
 <20190116134521.GG10803@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901161550460.1749@nanos.tec.linutronix.de>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4d97b838-6e49-4bba-1c9e-6bf51db3e3a2@arm.com>
Date:   Wed, 16 Jan 2019 15:23:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901161550460.1749@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2019 14:57, Thomas Gleixner wrote:
[...]
> 
> I just went back in the history tree and had to figure out that it's my
> fault :)
> 
> preempt_schedule_irq() was introduced to plug a stupid race, but I did not
> notice (and obviously nobody else) that this made the extra loop in the
> entry code pointless. So it's just histerical raisins without any value.
> 

I see, thanks for clearing that up! Credit goes to Julien & Will for
unearthing the oddity.

> Thanks,
> 
> 	tglx
> 
