Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FF32075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfBUPaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:30:01 -0500
Received: from relay.sw.ru ([185.231.240.75]:33138 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfBUPaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:30:00 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gwqIH-0000tC-Sr; Thu, 21 Feb 2019 18:29:50 +0300
Subject: Re: [PATCH 4.19 23/30] x86_64: increase stack size for KASAN_EXTRA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
 <20190221125251.864751477@linuxfoundation.org>
 <953de00c-82df-3ac2-8dd7-a023c511cbb9@virtuozzo.com>
 <20190221152642.GA23121@kroah.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <f3ce6a5a-8923-dcbb-516f-8c291b33a63d@virtuozzo.com>
Date:   Thu, 21 Feb 2019 18:30:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190221152642.GA23121@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/19 6:26 PM, Greg Kroah-Hartman wrote:
> On Thu, Feb 21, 2019 at 06:00:06PM +0300, Andrey Ryabinin wrote:
>> On 2/21/19 5:36 PM, Greg Kroah-Hartman wrote:
>>> 4.19-stable review patch.  If anyone has any objections, please let me know.
>>>
>>
>> Drop it please. It increases kernel stack up to 4-order which is above PAGE_ALLOC_COSTLY_ORDER.
>> This changes behavior of the fork() by making it fail with -ENOMEM due of high memory fragmentation.
>>
>> The patch that removes KASAN_EXTRA (not in Linus's tree yet) would be a better fix for the problem.
> 
> Ok, should this also be dropped from 4.20.y?
> 

Yes.
