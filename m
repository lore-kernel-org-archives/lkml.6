Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180F2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FDC20684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FDC20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeGQRIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:08:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49806 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbeGQRIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:08:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E7057A9;
        Tue, 17 Jul 2018 09:35:12 -0700 (PDT)
Received: from [10.1.207.53] (e112298-lin.cambridge.arm.com [10.1.207.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C8CA3F318;
        Tue, 17 Jul 2018 09:35:11 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] genirq: Provide basic NMI management for
 interrupt lines
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        ricardo.neri-calderon@linux.intel.com, marc.zyngier@arm.com,
        mingo@kernel.org
References: <1531152846-19374-1-git-send-email-julien.thierry@arm.com>
 <1531152846-19374-2-git-send-email-julien.thierry@arm.com>
 <alpine.DEB.2.21.1807171114280.3238@nanos.tec.linutronix.de>
 <e0c00482-7125-32e5-faa1-4251c118de5e@arm.com>
 <c4f7e808-d416-63c9-2972-fb90a5c72753@arm.com>
 <20180717155117.GJ2494@hirez.programming.kicks-ass.net>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <b03c672a-1329-9867-2a5c-dce97ec4b72a@arm.com>
Date:   Tue, 17 Jul 2018 17:35:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180717155117.GJ2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/07/18 16:51, Peter Zijlstra wrote:
> On Tue, Jul 17, 2018 at 04:48:17PM +0100, Julien Thierry wrote:
>> Supporting desc->affinity_hint for NMIs shouldn't be an issue, right?
> 
> Shouldn't NMIs be strictly per cpu interrupt sources?

That's a good question, and I don't have a proper answer right now...

However, per cpu or not, the affinity still needs to be set for that 
interrupt. It seemed to me that the desc->affinity_hint was just a way 
to keep track of the interrupt affinity when it gets set through 
irq_set_affinity_hint.

Is that not the case?

Thanks,

-- 
Julien Thierry
