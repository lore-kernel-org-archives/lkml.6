Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE90C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC9F217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkXZ5/pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC9F217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeHDQB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:01:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36285 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeHDQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:01:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so4697990pfo.3;
        Sat, 04 Aug 2018 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=If84yWVo0jUwk8qOhUiq/TGCaAKJpnXEvNFizfvv/54=;
        b=IkXZ5/paOHYgNUxDCtsRhA2DGzyf0JqRhChVKKbn5MMGZzun8/nq4WOhnIIjP+2w7y
         1/IWoAZDVr4S5OG2TEn//95gqo2IkFcqAjB/gYfx8efnIuHfC11y+2Qxb+bWbfHfUSfa
         lbn8bUtuRRxktX8P1+ttPmslCY/a2CVge42djvPS93tFW3w4RKN/doJllUr6ACcStOAV
         +gwm0+CejyLyO6iG7YIAhjXjX+UzYyLiUee3b4HtCIAweLh7/4b2JG9nfEgnTI0CBuGr
         0qtXHT9kRxNW+hXj48Go/nNJP4DcT8zJuZ+hbrIvdlYQxMQHpAlyeV2z3dC4H18Zmzvf
         u5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=If84yWVo0jUwk8qOhUiq/TGCaAKJpnXEvNFizfvv/54=;
        b=jq2tWHuuv5N8tawl1wQzWCDlEQpNGdQpxO7VyIdNbqUBmubHFjNrOYF7btDyP+GmNe
         vPmnC39MYPsoHPrrM3sV4vYVnQNOINZH/F8PfoX8Yu7ZAuTkx7UibEgmsMxY5w+skZ1S
         Og4rGJWlXhac0RW/ATH1pAEZLWMWvTaN9udlw4vowjQpht4sI2MtuOxlzFG8mddygdc5
         30cZEgPhMnO9E4SCu9kqKHf9cm+CPZtmKrDNmAdMCy51uge2Jolz9PRp85rm5tn9CGCe
         45MoAxJc3Cj9chx1Aqn/s8zbA6Xt5+w85T8bC/ezIFexY1Pi0UgYUoMbmQkzR7yMAEkM
         HhwA==
X-Gm-Message-State: AOUpUlGR4ZOm/ZibLz8/btMpNx/xzFbrD50psprfGSvP8jgX3H8u25Be
        ECCb6sSgNNUT11OztsRSYvqpTnfR
X-Google-Smtp-Source: AAOMgpd8CY3Zi8RQ3Ma2AQ3uIgnAos6b6JGxH7ewCxs474U3QDhhLo0/eYlaRtyRTTyxueirTy1Mig==
X-Received: by 2002:a63:f414:: with SMTP id g20-v6mr7819321pgi.407.1533391238846;
        Sat, 04 Aug 2018 07:00:38 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a11-v6sm13907850pfl.66.2018.08.04.07.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:00:37 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] slab: __GFP_ZERO is incompatible with a
 constructor
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Lameter <cl@linux.com>, Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, jlayton@redhat.com,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20180411060320.14458-1-willy@infradead.org>
 <20180411060320.14458-3-willy@infradead.org>
 <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake>
 <20180411192448.GD22494@bombadil.infradead.org>
 <alpine.DEB.2.20.1804111601090.7458@nuc-kabylake>
 <20180411235652.GA28279@bombadil.infradead.org>
 <alpine.DEB.2.20.1804120907100.11220@nuc-kabylake>
 <20180412142718.GA20398@bombadil.infradead.org>
 <20180412191322.GA21205@bombadil.infradead.org>
 <20180803212257.GA5922@roeck-us.net>
 <20180803223357.GA23284@bombadil.infradead.org>
 <CAMuHMdXXYH_7oVJJ5sGWFj_-WbjuMdooXTqBfV+z0CzR193T3A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e14d7aea-233d-57ae-c1e2-1d14369dd305@roeck-us.net>
Date:   Sat, 4 Aug 2018 07:00:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXXYH_7oVJJ5sGWFj_-WbjuMdooXTqBfV+z0CzR193T3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2018 02:28 AM, Geert Uytterhoeven wrote:
> On Sat, Aug 4, 2018 at 12:34 AM Matthew Wilcox <willy@infradead.org> wrote:
>> On Fri, Aug 03, 2018 at 02:22:57PM -0700, Guenter Roeck wrote:
>>> On Thu, Apr 12, 2018 at 12:13:22PM -0700, Matthew Wilcox wrote:
>>>> From: Matthew Wilcox <mawilcox@microsoft.com>
>>>> __GFP_ZERO requests that the object be initialised to all-zeroes,
>>>> while the purpose of a constructor is to initialise an object to a
>>>> particular pattern.  We cannot do both.  Add a warning to catch any
>>>> users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
>>>> a constructor.
>>>>
>>>> Fixes: d07dbea46405 ("Slab allocators: support __GFP_ZERO in all allocators")
>>>> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>
>>> Seen with v4.18-rc7-139-gef46808 and v4.18-rc7-178-g0b5b1f9a78b5 when
>>> booting sh4 images in qemu:
>>
>> Thanks!  It's under discussion here:
>>
>> https://marc.info/?t=153301426900002&r=1&w=2
> 
> and https://www.spinics.net/lists/linux-sh/msg53298.html
> 
>> also reported here with a bogus backtrace:
>>
>> https://marc.info/?l=linux-sh&m=153305755505935&w=2
>>
>> Short version: It's a bug that's been present since 2009 and nobody
>> noticed until now.  And nobody's quite sure what the effect of this
>> bug is.

Though now it is making a lot of noise :-).

I just found two more 0-day bugs, so maybe improved testing and log messages
such as the one encountered here do help a bit.

Guenter
