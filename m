Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCD9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EFD20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfBZSEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:04:01 -0500
Received: from foss.arm.com ([217.140.101.70]:51556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfBZSEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:04:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A6D580D;
        Tue, 26 Feb 2019 10:04:00 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1022F3F738;
        Tue, 26 Feb 2019 10:03:57 -0800 (PST)
Subject: Re: [PATCH v6 0/6] Add ARMv8.3 pointer authentication for kvm guest
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <7dac868e-c0dc-ce20-a183-b42f694ffb12@arm.com>
Date:   Tue, 26 Feb 2019 18:03:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 19/02/2019 09:24, Amit Daniel Kachhap wrote:
> This patch series adds pointer authentication support for KVM guest and
> is based on top of Linux 5.0-rc6. The basic patches in this series was
> originally posted by Mark Rutland earlier[1,2] and contains some history
> of this work.
> 
> Extension Overview:
> =============================================
> 
> The ARMv8.3 pointer authentication extension adds functionality to detect
> modification of pointer values, mitigating certain classes of attack such as
> stack smashing, and making return oriented programming attacks harder.
> 
> The extension introduces the concept of a pointer authentication code (PAC),
> which is stored in some upper bits of pointers. Each PAC is derived from the
> original pointer, another 64-bit value (e.g. the stack pointer), and a secret
> 128-bit key.
> 
> New instructions are added which can be used to:
> 
> * Insert a PAC into a pointer
> * Strip a PAC from a pointer
> * Authenticate and strip a PAC from a pointer
> 
> The detailed description of ARMv8.3 pointer authentication support in
> userspace/kernel and can be found in Kristina's generic pointer authentication
> patch series[3].


> This patch series is based on just a single patch from Dave Martin [8] which add
> control checks for accessing sys registers. 

Ooeer, If you miss this patch, (like I did) the series still applies to rc6, it just
doesn't build. If you depend on extra patches like this, please re-post them as part of
the series. (you need to add your Signed-off-by if picked the patch up from the list).

This lets people apply the series from the list (everyone has a script to to do this),
without having to go and find the dependencies.


> [8]: https://lore.kernel.org/linux-arm-kernel/1547757219-19439-13-git-send-email-Dave.Martin@arm.com/

This is v4 of Dave's patch. He changed the subject and posted a v5 here:
https://lore.kernel.org/linux-arm-kernel/1550519559-15915-13-git-send-email-Dave.Martin@arm.com/

Re-posting the patch you tested with would avoid someone accidentally pickup v5, then
trying to work out how its supposed to work with your series. (check_present() was
replaced by a restrictions() bitmask).


As we can't have both, and v5 of that patch has been reviewed, could you rebase onto it?
You'll need to pick up any tags and make any changes reviewers asked for. If you could
note 'this v7 patch is Dave's v5 with $changes', then it makes it clear what is going on.



Thanks,

James
