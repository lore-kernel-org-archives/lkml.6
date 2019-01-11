Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D15AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B2620874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbfAKJyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:54:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfAKJyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:54:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 650C8EBD;
        Fri, 11 Jan 2019 01:54:02 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B4AD3F694;
        Fri, 11 Jan 2019 01:54:00 -0800 (PST)
Subject: Re: [PATCH 0/2] System-wide mute of hotplug lockdep during init
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     cai@gmx.us, daniel.lezcano@linaro.org,
        linux-arm-kernel@lists.infradead.org, longman@redhat.com,
        marc.zyngier@arm.com, mark.rutland@arm.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, dietmar.eggemann@arm.com
References: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
Message-ID: <0f2b6cc8-ad2f-bd0b-fe51-c333a8033452@arm.com>
Date:   Fri, 11 Jan 2019 09:53:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/12/2018 18:23, Valentin Schneider wrote:
> In [1] Peter had a suggestion to broadly mute hotplug lockdep warnings during
> init instead of going after every single warning and wrapping them with
> cpus_read_{lock, unlock}(). This is implemented in [PATCH 1/2].
> 
> [PATCH 2/2] is a logical follow-up as [PATCH 1/2] is the generalized version
> of the reverted patch.
> 
> [1]: https://lore.kernel.org/lkml/1543877121-4098-1-git-send-email-cai@gmx.us/#t
> 

Gentle ping - I suppose this flew under the holidays radar.

> Valentin Schneider (2):
>   cpu/hotplug: Mute hotplug lockdep during init
>   Revert "sched/core: Take the hotplug lock in sched_init_smp()"
> 
>  kernel/cpu.c        | 9 +++++++++
>  kernel/sched/core.c | 5 +----
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> --
> 2.7.4
> 
