Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D635BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 06:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686CC27533
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 06:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J1GigZIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686CC27533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeF3GIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 02:08:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbeF3GId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 02:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1PxNnUq6RvHnVz3pq0J+nl7T4VIfZoafiKkPd0k37aM=; b=J1GigZImIjYdeC5tNOgchy+J/
        S2b7FdI0ckVlWWcTE+GARzlh64Q6vx9YSYwQahgeuZiwF77uyBcd8Rok5dmDu72fFcU9SRvYYNm+K
        42Z7YgISuIjvCzKKCMANdtfyMmnLZknr0JuhU5VdifoObEGtMyGHlOjriRfSAF8f85lZ4b3fSLhc2
        GE0sROG4F+ZSwGIhb+aEwPb98rNiNx9ioE8FvCzScc1cHaEumfyNBgpg5AQbudB88FESRWqQI5Nf+
        5r86oGo59yMA0LvLiRxUzCRjdpZwuQU1h8c/uRKFuivq6KrZeOPt6gI5I2KGEy5ZaGCvNd/7deSIq
        e0bgdnt7w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZ93f-0004Bd-SI; Sat, 30 Jun 2018 06:08:31 +0000
Subject: Re: [PATCH] arc/Kconfig: include mm/Kconfig inside "ARC system
 configuration"
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1530279747-25320-1-git-send-email-rppt@linux.vnet.ibm.com>
 <4c84ef6c-fa71-8b74-826a-d81dac8c71e7@infradead.org>
 <20180629192838.GE4799@rapoport-lnx>
 <e18f80e1-fc59-9487-95eb-7cb6cda976c5@infradead.org>
 <20180629205716.GG4799@rapoport-lnx>
 <e2876cca-ea7f-25fd-8e32-c691717a8b7b@synopsys.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c190ac79-4668-424e-67d2-1c49a88f23e7@infradead.org>
Date:   Fri, 29 Jun 2018 23:08:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e2876cca-ea7f-25fd-8e32-c691717a8b7b@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 02:12 PM, Vineet Gupta wrote:
> On 06/29/2018 01:57 PM, Mike Rapoport wrote:
>> I think that would be something like this:
>> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>> index e81bcd271be7..44a20141639a 100644
>> --- a/arch/arc/Kconfig
>> +++ b/arch/arc/Kconfig
>> @@ -556,12 +556,14 @@ endmenu
>>  
>>  endmenu	 # "ARC Architecture Configuration"
>>  
>> +menu "Memory Management"
>>  source "mm/Kconfig"
>>  
>>  config FORCE_MAX_ZONEORDER
>>  	int "Maximum zone order"
>>  	default "12" if ARC_HUGEPAGE_16M
>>  	default "11"
>> +endmenu # "Memory Management"
>>  
>>  source "net/Kconfig"
>>  source "drivers/Kconfig"
>>
> 
> Awesome, this is exactly we want - care to send a formal patch ?
> 
> -Vineet

Mike, I interpret this as a reply to you.

And you can add:
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

and possibly:
Suggested-by: Randy Dunlap <rdunlap@infradead.org>


thanks,
-- 
~Randy
