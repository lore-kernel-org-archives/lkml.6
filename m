Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F60BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBB520838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5S9d4Mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBB520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLGJ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:26:50 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:35932 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:26:49 -0500
Received: by mail-ed1-f48.google.com with SMTP id f23so3155089edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EXuIkNCq3bJVuoZPevNt7bNuW5dFAHJpQGXSc1UTOQM=;
        b=b5S9d4MoHbSw1GWIvewSvJBTk6gcx5tAqOxPEWM05a37x5t4C6xbGqDqegnKCMHRkl
         KOh0F8l7yrs2SSUa04ENdiXbcoYeaENgtfSH03WnAWs7q/8iMd57g98LainQW8jxIRHj
         Agyk6dYkrGZ312XMpkjm5gGxxPoD/JA3kIbMZIbME22NMVc41q9iGG7QqweHxAi7itHA
         lXEk+eijHYthqUMrXepW8ozvDQqVP/WFTPd8z/968bOIkl/j331UPCxiJOQhlsgaRPRq
         uQziIbfJs4n3KoQ0KxBsBiUn0qYEkOiSU/VBu5f7jdj2cpunD+22zw5hrYI7uOUjVyBo
         Nuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EXuIkNCq3bJVuoZPevNt7bNuW5dFAHJpQGXSc1UTOQM=;
        b=WNFyu1lvfHZRrFiJ9Nblo7cGFVJFoji84HU0MU2PyA0+Hzpwc1Decg9kfH9t7lSGcB
         oEjmB5SQQh29DzWzwMnMk2FUd5dL+ubF1Wq2SGalDTZQR5hQEeaQ0zLHD+ifGxy099s+
         /K58lV/rTySm7UVX4cvtrrt3tCK7T1yUjHTMTGzVTMY0gDk+t9CdFOuJXVENSDJS5wCw
         MIUizJkO2o45lP5CXzuGli2ekPTSfFssMf8z5DNaqbGTXGJiZf55sYnPxdGDXL4tLOX7
         ZuwqWUrbETbaF1OrOjiDk4R7rGtg/TXjhTkC2iFPiD3mPWHSsFecWnJQHwfclawNG+pj
         y6gA==
X-Gm-Message-State: AA+aEWY/9HJtPgsascq7bXmXJUPKjUYYUOaId5hNOklDUAjqmj8Q4bmP
        GBpHDTqAEiZYRe8bD28tG1M=
X-Google-Smtp-Source: AFSGD/UpSsgoGXpA5fwlXJTY/URxtyZ9T1APjuDbmrtVkU+5bFLAfN1ELbpEFMrf5aiGx6JXCzPvQw==
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9-v6mr1406379ejh.236.1544174807646;
        Fri, 07 Dec 2018 01:26:47 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a13sm786137edt.83.2018.12.07.01.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 01:26:47 -0800 (PST)
Date:   Fri, 7 Dec 2018 09:26:46 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com
Subject: Re: [PATCH] mm, kmemleak: Little optimization while scanning
Message-ID: <20181207092646.zygzfrdnqcq6xvqm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181206131918.25099-1-osalvador@suse.de>
 <20181207041528.xs4xnw6vpsbu5csx@master>
 <1544163250.3008.7.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544163250.3008.7.camel@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 07:14:10AM +0100, Oscar Salvador wrote:
>
>> > +
>> 
>> This one maybe not necessary.
>
>Yeah, that is a remind of an include file I used for time measurement.
>I hope Andrew can drop that if this is taken.
>
>> > /*
>> >  * Kmemleak configuration and common defines.
>> >  */
>> > @@ -1547,11 +1548,14 @@ static void kmemleak_scan(void)
>> > 		unsigned long pfn;
>> > 
>> > 		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>> > -			struct page *page;
>> > +			struct page *page =
>> > pfn_to_online_page(pfn);
>> > +
>> > +			if (!page)
>> > +				continue;
>> > 
>> > -			if (!pfn_valid(pfn))
>> > +			/* only scan pages belonging to this node
>> > */
>> > +			if (page_to_nid(page) != i)
>> > 				continue;
>> 
>> Not farmiliar with this situation. Is this often?
>Well, hard to tell how often that happens because that mostly depends
>on the Hardware in case of baremetal.
>Virtual systems can also have it though.
>

Ok, generally looks good to me.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>> 
>> > -			page = pfn_to_page(pfn);
>> > 			/* only scan if page is in use */
>> > 			if (page_count(page) == 0)
>> > 				continue;
>> > -- 
>> > 2.13.7
>> 
>> 
>-- 
>Oscar Salvador
>SUSE L3

-- 
Wei Yang
Help you, Help me
