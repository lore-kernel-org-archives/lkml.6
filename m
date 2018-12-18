Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF53C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D769B214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeLRIMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:12:30 -0500
Received: from relay.sw.ru ([185.231.240.75]:52904 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeLRIMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:12:30 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gZAUL-0004wz-C7; Tue, 18 Dec 2018 11:12:25 +0300
Subject: Re: [PATCH] scripts/tags: Add more declarations
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        const@MakeLinux.com, joeypabalinas@gmail.com,
        arend.vanspriel@broadcom.com, linux-kernel@vger.kernel.org
References: <154505048571.504.18330420599768007443.stgit@localhost.localdomain>
 <20181217210914.GS10600@bombadil.infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <caf816a4-3ab0-d07e-7559-661999f10f0f@virtuozzo.com>
Date:   Tue, 18 Dec 2018 11:12:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181217210914.GS10600@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.12.2018 00:09, Matthew Wilcox wrote:
> On Mon, Dec 17, 2018 at 03:41:46PM +0300, Kirill Tkhai wrote:
>> -	'/\<DEFINE_\(MUTEX\|SEMAPHORE\|SPINLOCK\)(\([[:alnum:]_]*\)/\2/v/'
>> +	'/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)(\([[:alnum:]_]*\)/\2/v/'
>>  	'/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)(\([[:alnum:]_]*\)/\2/v/'
> 
> I don't know anything about regexes this complex or tags, but couldn't this 
> be '/\<DEFINE_\([[:upper:]_]\)(\([[:alnum:]_]*\)/\2/v/' to catch all
> DEFINE_THINGIES?

I think, we can, but before this it's needed to change arguments order
in macroses like DEFINE_PER_CPU(), and to check, whether tags won't be
polluted something not needed (such wrong defines will be generated
anyway, but if there will be not too many, than it's OK).
