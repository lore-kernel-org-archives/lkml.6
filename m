Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC229C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E9C20870
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 16:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pGEsJLPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E9C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeIHU5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 16:57:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeIHU5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 16:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CV9g6onZuKAiAFtEJZxkdBQQZuRcICrLjEIM0EBJOd4=; b=pGEsJLPHHFKOiust77aFwfucZ
        foevOKyAqeXLluvmAWCUH03pMIzFshN3Ac6D6zw/GJiNG8ZqJyR5TyH9f3gfrO0xuP0Zi9XUT6zHm
        fBGSWUzwW0jiXct18qBDlOM0NTq40ScwHJEOcrsP6ZiVzKVt3ONFc+P16uGGqJ3LdoHEGiFyQ7+rv
        EsRLiymTjYTxVsCHSLlC4LHaIoqNH6+VYPODgWosRjPhz15CU6r5b50whHtEiSjoKRtxxXBAaWow0
        mVIZAhEbwP7BFctgtfHY1MqK9+bZ4gS7JBj2hvRfeRbysQI5MeoFj+9tOEng7+eXUIKm1HYzHb4yh
        BD+Vw0tKQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyfou-0006tP-Sa; Sat, 08 Sep 2018 16:10:48 +0000
Subject: Re: + mm-slab-shorten-kmalloc-cache-names-for-large-sizes.patch added
 to -mm tree
To:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, vjitta@codeaurora.org,
        sumit.semwal@linaro.org, rientjes@google.com, mhocko@kernel.org,
        mgorman@techsingularity.net, labbott@redhat.com,
        iamjoonsoo.kim@lge.com, guro@fb.com, cl@linux.com, vbabka@suse.cz
References: <20180906224849.1JOWr%akpm@linux-foundation.org>
 <20180907195816.GA28375@avx2> <20180908140306.GB17637@cmpxchg.org>
 <20180908155422.GA26807@bombadil.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bd363bd7-9e28-5499-235f-6e6c3c66c829@infradead.org>
Date:   Sat, 8 Sep 2018 09:10:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180908155422.GA26807@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2018 08:54 AM, Matthew Wilcox wrote:
> On Sat, Sep 08, 2018 at 10:03:06AM -0400, Johannes Weiner wrote:
>> On Fri, Sep 07, 2018 at 10:58:16PM +0300, Alexey Dobriyan wrote:
>>> On Thu, Sep 06, 2018 at 03:48:49PM -0700, akpm@linux-foundation.org wrote:
>>>> -	{"kmalloc-1024",         1024},		{"kmalloc-2048",         2048},
>>>> -	{"kmalloc-4096",         4096},		{"kmalloc-8192",         8192},
>>>> -	{"kmalloc-16384",       16384},		{"kmalloc-32768",       32768},
>>>> -	{"kmalloc-65536",       65536},		{"kmalloc-131072",     131072},
>>>> -	{"kmalloc-262144",     262144},		{"kmalloc-524288",     524288},
>>>> -	{"kmalloc-1048576",   1048576},		{"kmalloc-2097152",   2097152},
>>>> -	{"kmalloc-4194304",   4194304},		{"kmalloc-8388608",   8388608},
>>>> -	{"kmalloc-16777216", 16777216},		{"kmalloc-33554432", 33554432},
>>>> -	{"kmalloc-67108864", 67108864}
>>>> +	{"kmalloc-1k",           1024},		{"kmalloc-2k",           2048},
>>>> +	{"kmalloc-4k",           4096},		{"kmalloc-8k",           8192},
>>>> +	{"kmalloc-16k",         16384},		{"kmalloc-32k",         32768},
>>>> +	{"kmalloc-64k",         65536},		{"kmalloc-128k",       131072},
>>>> +	{"kmalloc-256k",       262144},		{"kmalloc-512k",       524288},
>>>> +	{"kmalloc-1M",        1048576},		{"kmalloc-2M",        2097152},
>>>> +	{"kmalloc-4M",        4194304},		{"kmalloc-8M",        8388608},
>>>> +	{"kmalloc-16M",      16777216},		{"kmalloc-32M",      33554432},
>>>> +	{"kmalloc-64M",      67108864}
>>>
>>> I'd rather use KB and MB suffixes or at least capital 'K'.
>>
>> I like k and M better.
> 
> k and M work for me too.  It we were going to be anal then we should
> go with the IEC standard of KiB and MiB, but we're trying to make

But                           ^K and  ^M.

Small 'k' .. I don't know what that is.

> /proc/slabinfo a little less ugly, and so we have 16 characters to work
> with.  "dma-kmalloc-256KiB" is 18 characters.  The obvious place to lose
> two characters is the "iB" which are implicit; we know we're measuring
> bytes and the binary nature is assumed in this context of memory bytes
> (not storage bytes).  "dma-kmalloc-256k" is better.
> 


-- 
~Randy
