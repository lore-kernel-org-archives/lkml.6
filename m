Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720D1C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2146727C9F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EvCOj8cS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2146727C9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937387AbeF2U3E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:29:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936738AbeF2U3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XdqbzRM2fL4sHCREk2YqBPrG9SZT7eplLBUONwyFZgk=; b=EvCOj8cSSkftHjmQjDzWWCbco
        pCYFBNonjrHM6lbkD76K9FpOsMRailRf0vsl/P+/g1clf2Q8vT810BMN2rO6Sq8Wcq6ZEp1jT/SHA
        hhNsDnwr9DQKWcYK44aL7qWo2D6rRl/Jj5UHnS+G4n8O6kw4AuEYQWndYkC1kHLJpU8OTpcfJHL/1
        UGjFTWu1JeF/zPEl53oZneako9nh/h/G+B7gMR5KraNq2Lac1welItmg9b+oql/hs5MgbPFj2sPhz
        xD0WYIduBe7/GSaKAVIgNqs4VUORLAMDYCURUKX+ufzhEU1JdA56FpHtOQerXueYy4zWt4B1GBdBL
        boYzOnMvA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZ00s-0003Ji-VK; Fri, 29 Jun 2018 20:29:03 +0000
Subject: Re: [PATCH] arc/Kconfig: include mm/Kconfig inside "ARC system
 configuration"
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <1530279747-25320-1-git-send-email-rppt@linux.vnet.ibm.com>
 <4c84ef6c-fa71-8b74-826a-d81dac8c71e7@infradead.org>
 <20180629192838.GE4799@rapoport-lnx>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e18f80e1-fc59-9487-95eb-7cb6cda976c5@infradead.org>
Date:   Fri, 29 Jun 2018 13:28:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629192838.GE4799@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 12:28 PM, Mike Rapoport wrote:
> Hi Randy, 
> 
> On Fri, Jun 29, 2018 at 09:34:55AM -0700, Randy Dunlap wrote:
>> On 06/29/2018 06:42 AM, Mike Rapoport wrote:
>>> Otherwise mm configuration options show up in the top level menu.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
>>
>> Hi Mike,
>>
>> In which config tool does this matter?
>>
>> For xconfig, it seems to me that this patch hides the MM menu, whereas
>> before this patch, the MM menu is easy to find (although it could
>> use some kind of heading).
> 
> With xconfig the menu gets into the top right pane when you click on "ARC
> architecture configuration", similar to what one gets on x86 with
> "Processor type and features" or "Kernel features" on ARM.
> 
> With menuconfig it looks a bit more prominent, note that mm options are
> between "ARC Architecture Configuration" and "Networking support":

I know.  I ran all 4 of menuconfig, nconfig, xconfig, and gconfig.

I would prefer to see Memory Management options have its own top-level
menu, but that's a different patch.  Then menuconfig would look like this:



│ │        *** Compiler: arc-linux-gcc (GCC) 8.1.0 ***                  │ │  
  │ │        General setup  --->                                          │ │  
  │ │    [*] Enable loadable module support  --->                         │ │  
  │ │    [*] Enable the block layer  --->                                 │ │  
  │ │        ARC Architecture Configuration  --->                         │ │  
  │ │        Memory Management options  --->                              │ │  
  │ │    (11) Maximum zone order                                          │ │  
  │ │    [*] Networking support  --->                                     │ │  
  │ │        Device Drivers  --->                                         │ │  
  │ │        Bus Support  ---> 


but that "Maximum zone order" needs to be moved or taken care of somehow.


[snip]

> 
> 
> 
>>>  	default "12" if ARC_HUGEPAGE_16M
>>>  	default "11"
>>>  
>>> +endmenu	 # "ARC Architecture Configuration"
>>> +
>>>  source "net/Kconfig"
>>>  source "drivers/Kconfig"


thanks,
-- 
~Randy
