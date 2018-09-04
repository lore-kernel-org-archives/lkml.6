Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AE2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0689E2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0689E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tomt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeIDMae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:30:34 -0400
Received: from mail1.ugh.no ([178.79.162.34]:55436 "EHLO mail1.ugh.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbeIDMad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:30:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.ugh.no (Postfix) with ESMTP id 817602493DB;
        Tue,  4 Sep 2018 10:06:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at catastrophix.ugh.no
Received: from mail1.ugh.no ([127.0.0.1])
        by localhost (catastrophix.ugh.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UJp582a7rY4Q; Tue,  4 Sep 2018 10:06:33 +0200 (CEST)
Received: from [10.255.99.10] (unknown [185.176.245.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: andre@tomt.net)
        by mail.ugh.no (Postfix) with ESMTPSA id B45F42493DA;
        Tue,  4 Sep 2018 10:06:32 +0200 (CEST)
Subject: Re: [PATCH 4.18 050/123] mm/tlb, x86/mm: Support invalidating TLB
 caches for RCU_TABLE_FREE
From:   Andre Tomt <andre@tomt.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will.deacon@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
 <20180903165721.576888426@linuxfoundation.org>
 <CA+G9fYsyr_AxbmuWfD6svin4Cq_5QJOYvOW_ohnS7fUobRU7ZA@mail.gmail.com>
 <20180904052428.GA26045@kroah.com>
 <75d7b2f6-e057-5c76-0da0-2e76b54d10a5@tomt.net>
Message-ID: <4059f8e5-391c-5898-a6ce-8aa6ed887731@tomt.net>
Date:   Tue, 4 Sep 2018 10:06:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <75d7b2f6-e057-5c76-0da0-2e76b54d10a5@tomt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. sep. 2018 08:10, Andre Tomt wrote:
> On 04. sep. 2018 07:24, Greg Kroah-Hartman wrote:
>>> Full test log link,
>>> https://lkft.validation.linaro.org/scheduler/job/404027#L4051
>>
>> Does Linus's tree also crash with this patch applied?  Being "bug
>> compatible" is good :)
>>
>> thanks,
>>
>> greg k-h
>>
> 
> I suspect it is because we're missing upstream commit 
> db7ddef301128dad394f1c0f77027f86ee9a4edb
> mm: move tlb_table_flush to tlb_flush_mmu_free
> 
> Have not tested.

Tested it now. Adding this commit to my local 4.18.6-rc1 based tree 
fixes the crashing on my systems.

On 4.18.6-rc1 they would fall over within seconds of getting to the 
login prompt.
