Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE79C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB0220811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB0220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeLLSyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:54:51 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35776 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbeLLSys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:54:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0EDC61493518C;
        Wed, 12 Dec 2018 10:54:47 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:54:43 -0800 (PST)
Message-Id: <20181212.105443.739412722995225625.davem@davemloft.net>
To:     sam@ravnborg.org
Cc:     hch@lst.de, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: linux-next: manual merge of the sparc-next tree with the
 dma-mapping tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181212163208.GA15535@ravnborg.org>
References: <20181212074420.GB29137@lst.de>
        <20181212161146.GA7176@lst.de>
        <20181212163208.GA15535@ravnborg.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Dec 2018 10:54:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 12 Dec 2018 17:32:08 +0100

> On Wed, Dec 12, 2018 at 05:11:46PM +0100, Christoph Hellwig wrote:
>> On Wed, Dec 12, 2018 at 08:44:20AM +0100, Christoph Hellwig wrote:
>> > Dave, Sam:
>> > 
>> > should I just apply a version of Rob's tree that takes the refactoring
>> > into account to the dma-mapping tree?  That way we should get the right
>> > result independent of the merge order.
>> 
>> E.g. something like the patch below:
>> 
>> --
>> >From 6ee3d6c39a0c8bc4b58fa601bb4370bdec785be7 Mon Sep 17 00:00:00 2001
>> From: Christoph Hellwig <hch@lst.de>
>> Date: Wed, 12 Dec 2018 17:09:58 +0100
>> Subject: sparc: use DT node full_name in sparc_dma_alloc_resource
>> 
>> The sparc tree already has this change for the pre-refactored code,
>> but pulling it into the dma-mapping tree like this should ease
>> the merge conflicts a bit.
>> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  arch/sparc/kernel/ioport.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
>> index 51c128d80193..baa235652c27 100644
>> --- a/arch/sparc/kernel/ioport.c
>> +++ b/arch/sparc/kernel/ioport.c
>> @@ -252,7 +252,7 @@ unsigned long sparc_dma_alloc_resource(struct device *dev, size_t len)
>>  	res = kzalloc(sizeof(*res), GFP_KERNEL);
>>  	if (!res)
>>  		return 0;
>> -	res->name = dev->of_node->name;
>> +	res->name = dev->of_node->full_name;
>>  
>>  	if (allocate_resource(&_sparc_dvma, res, len, _sparc_dvma.start,
>>  			      _sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
> 
> Whatever works best for everyone is fine for me, so ack from me.

Yeah I'm fine with this too.

