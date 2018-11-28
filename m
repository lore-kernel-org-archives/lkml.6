Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04493C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B692120832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mIWD0H2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B692120832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeK1SMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:12:09 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43372 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1SMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KEKkaIQCIE+zRqnTVI2MPckY2tQLm68/aZoxywIM7z0=; b=mIWD0H2ObjYcfX1QbN1HXnALpx
        C1I2/jLPROER8Z0eVR72EiaiCzJCUO+Y4QHykxV6HEaCKMjUMUFQGheL04jfQE2a3A/CMP7vhFUZu
        wkgDfhthAQpJquivAC7ndfSpf09KPjNsTKQWsPUQ3/n71SN3mMXCnpWWW2NnodeTuynmUA/9om0sc
        +l55eerbVGmWqIvRz5RCYP9xSYwcd4a1JUuJML6fDY1boB2P0xbEuW0WHZpWESa3tGKx5B50PhSF9
        c9ANY0Qmz0njDXEyqEmytDW2rMgoxCj7rbm46MI3LbmNwfUZ4e6Coxg/WkvuWbFuwYvtycSrGgPDX
        1jZ9EktQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRu0N-0002Aa-SE; Wed, 28 Nov 2018 07:11:29 +0000
Subject: Re: linux-next: Tree for Nov 27 (scsi/aha1542)
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20181127152539.55426063@canb.auug.org.au>
 <ef9090cf-e86a-7fd0-dfa9-6810eaaf7e65@infradead.org>
 <20181128153847.08ead1c9@canb.auug.org.au>
 <1543383684.3518.2.camel@HansenPartnership.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3b57ed57-102e-ec3a-f68c-480252b9060f@infradead.org>
Date:   Tue, 27 Nov 2018 23:11:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1543383684.3518.2.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 9:41 PM, James Bottomley wrote:
> On Wed, 2018-11-28 at 15:38 +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> On Tue, 27 Nov 2018 20:14:58 -0800 Randy Dunlap <rdunlap@infradead.or
>> g> wrote:
>>>
>>> On 11/26/18 8:25 PM, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Changes since 20181126:
>>>>   
>>>
>>> on i386:
>>>
>>> ERROR: "__udivdi3" [drivers/scsi/aha1542.ko] undefined!
>>>
>>> somewhere in aha1542_interrupt() according to objdump.
>>
>> Presumably caused by commit
>>
>>   1794ef2b150d ("scsi: aha1542: convert to DMA mapping API")
> 
> Yes, it's because dma_addr_t can be u64 on pae systems but
> isa_virt_to_bus only ever returns unsigned long (because an ISA
> physical address can only be 24 bits).
> 
> I think this is the fix; there doesn't seem to be much point converting
> to do_div given all the limitations.
> 
> James

Yes, that works.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> 
> diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
> index a9c29757172f..afb693d7b44f 100644
> --- a/drivers/scsi/aha1542.c
> +++ b/drivers/scsi/aha1542.c
> @@ -325,7 +325,7 @@ static irqreturn_t aha1542_interrupt(int irq, void *dev_id)
>  			return IRQ_HANDLED;
>  		};
>  
> -		mbo = (scsi2int(mb[mbi].ccbptr) - aha1542->ccb_handle) / sizeof(struct ccb);
> +		mbo = (scsi2int(mb[mbi].ccbptr) - (unsigned long)aha1542->ccb_handle) / sizeof(struct ccb);
>  		mbistatus = mb[mbi].status;
>  		mb[mbi].status = 0;
>  		aha1542->aha1542_last_mbi_used = mbi;
> 


-- 
~Randy
