Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B14C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBC42229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MHT4nG1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfBKRbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:31:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfBKRbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BvHOGo1g8yWo1gRoRLczgUpiw0DBDlt2BwWSm5YsHr0=; b=MHT4nG1dwudLVuNb9uk/lYi9C
        Ld+XmRNlSqXb3sl80y8roVhsnsLcDrU7QLhZD/rMYuw/+gYPZHdhyfqeaMqkpbUFFk9rwiK0r4VFm
        V2qSXAdaisVAOikr3Xso+aUmgYxoZJKF6B/IPfuLpNNLAqTVkOXEJW1lm46BuBIUqBEbFQ2fRNTYB
        D75MY13KTo1xiNsOfHL1R/B1rruuCNsSzlv4JKsqLhQN3ULxnP9VX1BPD1HK290Aq/o8vTe5ITXLM
        JBciWTtVahiE9SU1OFS//O0/y+RKqRdWuXdd4z1j4YaR8vhiyhcbEpPiqvzY1crui8ytlOsG/UW+b
        yNv3z/a9g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtFQg-00022a-Uf; Mon, 11 Feb 2019 17:31:39 +0000
Subject: Re: [PATCH] Documentation: fix vm/slub.rst warning
To:     Jonathan Corbet <corbet@lwn.net>, Linux MM <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Tobin C. Harding" <tobin@kernel.org>
References: <1e992162-c4ac-fe4e-f1b0-d8a16a51d5e7@infradead.org>
 <20190211082705.0ff3d86b@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2a14eb40-ea42-fcf0-6f1a-458e13f9983d@infradead.org>
Date:   Mon, 11 Feb 2019 09:31:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190211082705.0ff3d86b@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 7:27 AM, Jonathan Corbet wrote:
> On Sun, 10 Feb 2019 22:34:11 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix markup warning by quoting the '*' character with a backslash.
>>
>> Documentation/vm/slub.rst:71: WARNING: Inline emphasis start-string without end-string.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Christoph Lameter <cl@linux.com>
>> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
>> ---
>>  Documentation/vm/slub.rst |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- lnx-50-rc6.orig/Documentation/vm/slub.rst
>> +++ lnx-50-rc6/Documentation/vm/slub.rst
>> @@ -68,7 +68,7 @@ end of the slab name, in order to cover
>>  example, here's how you can poison the dentry cache as well as all kmalloc
>>  slabs:
>>  
>> -	slub_debug=P,kmalloc-*,dentry
>> +	slub_debug=P,kmalloc-\*,dentry
>>  
>>  Red zoning and tracking may realign the slab.  We can just apply sanity checks
>>  to the dentry cache with::
> 
> The better fix here is to make that a literal block ("slabs::").  Happily
> for all of us, Tobin already did that in 11ede50059d0.

Thanks for the info.

-- 
~Randy
