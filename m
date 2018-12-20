Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE280C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E2120989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbeLTBq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:46:59 -0500
Received: from mail.windriver.com ([147.11.1.11]:34059 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLTBq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:46:59 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wBK1kcmW029929
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 19 Dec 2018 17:46:39 -0800 (PST)
Received: from [128.224.162.162] (128.224.162.162) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 19 Dec
 2018 17:46:38 -0800
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     <tglx@linutronix.de>, <rostedt@goodmis.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
 <20181123095314.hervxkxtqoixovro@linutronix.de>
 <40a63aa5-edb6-4673-b4cc-1bc10e7b3953@windriver.com>
 <20181130181956.eewrlaabtceekzyu@linutronix.de>
 <e7795912-7d93-8f4e-b997-67c4ac1f3549@windriver.com>
 <20181205191400.qrhim3m3ak5hcsuh@linutronix.de>
 <16ac893a-a080-18a5-e636-7b7668d978b0@windriver.com>
 <20181218150744.GB20197@arrakis.emea.arm.com>
 <20181219153022.w5le6nf7meiogh72@linutronix.de>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <b967b22a-78a9-5b73-9b04-26085f796e5d@windriver.com>
Date:   Thu, 20 Dec 2018 09:46:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219153022.w5le6nf7meiogh72@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.162]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/19 23:30, Sebastian Andrzej Siewior wrote:
> On 2018-12-18 15:07:45 [+0000], Catalin Marinas wrote:
> …
>> It may be worth running some performance/latency tests during kmemleak
>> scanning (echo scan > /sys/kernel/debug/kmemleak) but at a quick look,
>> I don't think we'd see any difference with a raw_spin_lock_t.
>>
>> With a bit more thinking (though I'll be off until the new year), we
>> could probably get rid of the kmemleak_lock entirely in scan_block() and
>> make lookup_object() and the related rbtree code in kmemleak RCU-safe.
> Okay. So let me apply that patch into my RT tree with your ack (from the
> other email). And then I hope that it either shows up upstream or gets
> replaced with RCU in the ende :)

I'd like to do the upstreaming or replacing. Thanks.

Zhe

>
> Thanks.
>
> Sebastian
>

