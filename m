Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBED3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C42208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C42208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbeGaNvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:51:00 -0400
Received: from foss.arm.com ([217.140.101.70]:53126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731880AbeGaNvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:51:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD3FE80D;
        Tue, 31 Jul 2018 05:10:57 -0700 (PDT)
Received: from [10.4.12.39] (e113632-lin.emea.arm.com [10.4.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D0083F5D0;
        Tue, 31 Jul 2018 05:10:56 -0700 (PDT)
Subject: Re: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
To:     Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     mingo@redhat.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <20180731120057.GS2476@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e9ebcee9-52e4-450e-7814-c8187e2b4fb5@arm.com>
Date:   Tue, 31 Jul 2018 13:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731120057.GS2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 31/07/18 13:00, Peter Zijlstra wrote:
> 
> 
> Aside from the first patch, which I posted the change on, I've picked up
> until 10. I think that other SD_ASYM patch-set replaces 11 and 12,
> right?
>
11 is no longer needed, but AFAICT we still need 12 - we don't want
PREFER_SIBLING to interfere with asymmetric systems.

Also, I've been playing around with a patch to modify 5 (the nohz kicks) that
first scans the capacity of nohz CPUs before doing any kick (pretty much like
what asym packing is doing with nohz CPU priority), do you want me to toss
it your way? I haven't done run any tests with it yet...

Cheers,
Valentin
