Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A187C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7BA26F40
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHiHfMcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7BA26F40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933982AbeFZUcX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:32:23 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36813 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933050AbeFZUcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:32:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so18522752wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q764Gp4PWxLNJtP7XFQVaMpRK/3uK+/IB4VilfSUX3Y=;
        b=oHiHfMcZAbPrqtERB5AMJWLzZZaZ9dwUs4BTomsjHyQI4ajsTmq3ewdasIDs7h+vv1
         43sX3aLulh2zQbjiLBbewjP/IG70ueNXHQwIcAqgfSvc+TypBHN0LU0squ2k96vYkCzZ
         0KfLEEP2iuqQNhRGh//CqYl8Yw7PpHJO/5MzIze90b93pIsfKI4Oxq9VqLLznudG7k7M
         A5g9Nl5G3P84d2LduDIOhKQu43mjZ8Gd96cV0YM41mpbd5RVwAPExKo0CW0x+b0D9SlA
         oUyeqR10DWIxE5ImX7Sx8zmPicninvDqEvqry72VpQP6t0p5TPAakzSU/PCobkOlH6mn
         5ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q764Gp4PWxLNJtP7XFQVaMpRK/3uK+/IB4VilfSUX3Y=;
        b=DPWpbIPhXxzzp6h3stRoOARJ5GMpLrhv14rbUwi6tkT/DZdJIFQafx5JBvKQG20ScE
         zdG7no6iQB0KlR56OHny4e/ma/34olojdz1uX8EJU+jQ9y2rU8rh8lRKrx0+tN+g5WCF
         gEd8WX1QBfNnJFmxvufpXKhu5r/Hn52hdjQK/0II3bng2P4RYQ4m8639ZQ24aioZrIcd
         bjCikbrEYmmLlyIdMPHzM6vvn9XyzH1uih1lVVBOYJUHNpDpMEre3q9dvZNJBYDLOfBb
         S8DtvXyy+oZV3RjeiLY9m/tBmJlj4sc+uE5NJTXRqZ/c2J8c3X6XhoA7IwWdGFSqhDCe
         j86Q==
X-Gm-Message-State: APt69E3eQHZhDxXxuZpkc19j147MMEzrX5MJzQZEFfYQkZhPvTluErLT
        aPigyn85RhaZb8ZEpYNsisLCu5hy
X-Google-Smtp-Source: AAOMgpeby+FKQ+h2l86cXso6NJHCI1x/8lbWLJtazyM2PBJBWk3rI3X3LwPL9rigii2MsJRLE6oUkQ==
X-Received: by 2002:adf:f60a:: with SMTP id t10-v6mr2547742wrp.97.1530045137849;
        Tue, 26 Jun 2018 13:32:17 -0700 (PDT)
Received: from [192.168.1.4] (x590c812a.dyn.telefonica.de. [89.12.129.42])
        by smtp.gmail.com with ESMTPSA id n10-v6sm3913165wrs.64.2018.06.26.13.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 13:32:17 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in
 rtw_macaddr_cfg()
To:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20180626081409.9518-1-straube.linux@gmail.com>
 <20180626081409.9518-3-straube.linux@gmail.com>
 <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
 <37cca7e4-3c1f-b1ab-14b3-fd3dbbae8b01@gmail.com>
 <96782a8bbc8d5a8a911447beda78ca4eed6b9f04.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <2a49e8e7-15ef-af4f-1039-b15ae60df11b@gmail.com>
Date:   Tue, 26 Jun 2018 22:32:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <96782a8bbc8d5a8a911447beda78ca4eed6b9f04.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/26/18 22:17, Joe Perches wrote:
> On Tue, 2018-06-26 at 21:44 +0200, Michael Straube wrote:
>> On 06/26/18 19:32, Andy Shevchenko wrote:
>>> On Tue, Jun 26, 2018 at 11:14 AM, Michael Straube
>>> <straube.linux@gmail.com> wrote:
>>>> Use ether_addr_copy() instead of memcpy() to copy the mac address.
>>>>
>>>
>>> Suggested-by ?
>>>
>>
>> I'll add it. Sorry, I was not aware of the Suggested-by tag.
>>
>>> Btw, ensure that the source and destination buffers are aligned to u16
>>> as required by API.
>>
>> To be honest I'm not sure how to do that excactly.
>>
>> Use __align(2) in the array declarations? e.g.:
>>
>>           u8 mac[ETH_ALEN] __align(2);
> 
> All initial function automatics are naturally aligned.
>>
So there is nothing to change? Now I'm confused.
