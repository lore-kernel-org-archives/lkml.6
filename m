Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7699C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F522243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+knboG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F522243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbeKMXQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:16:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34651 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbeKMXQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:16:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so10448939eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 05:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JINnWs6I+DAyIuG/TaFp3j9T4yviEzmoOVuTlpQGPr0=;
        b=X+knboG4uUdC9CurbFLaQiD/5q/QquG/E0/o/5XQTy3v0+pmhHz77IC6BgFz4BAtfq
         7Xg9of103Xf6ooYW0CgLx0mxWTzt/Q5nV4M+j2GcoIJtnN7xVFMDXiOfdDsqWaGONgjq
         4NtzR6Xl/phEYKUueXQ4ZT9kZZs/yYVRihOBtCfPzp3qTygWOsdPnKwKqRJQjRiBBnSy
         tWhUF67B/FhtKIV50bIf4w8o0T5M/a45e+XoIZiWh1At4xYcymuQC2DJu6Ulbwl0WP1n
         sZ3LCPeCPXB4G0gkULk5wzYhRKXqli0oWxZKr63ksvh+B1YoLF/p2QRuQv/Ro+9Ms1aU
         9nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JINnWs6I+DAyIuG/TaFp3j9T4yviEzmoOVuTlpQGPr0=;
        b=LG3kCXdt8ySCh6pQcgy0UiS5OXvyMuqQRfDwmIIYQ79q8K/N+YjmiJwC1LdjEV4qWb
         9EkxFYR+0QzSvMvr3avbE1FgYW9iMOKtEMiEdDETWYjbr9cVGcok2MIytEWou+Q9yElu
         TV9M0g+oeAPORpXMBJ2fDF3LqCiRQQFFG2eKYtf2qsiUEuxhGZEZA7Cgx9PDXDxmd/Ly
         Plqojp/ai9ZFJvQNQ5XiZEbmrA7pbYzIACExVN+6HRxGEgzinTJT4IQEmf6xif51hqxp
         Q2dpwU6dgHItfiLxDqqiDCeZzXqD+N4RTj4Ms9YFYOUWqw17OK5dHz0TYdGK7Btnw2v7
         0NrQ==
X-Gm-Message-State: AGRZ1gIAbq+EQwK5wbyss9Ne7FxWzM0P1tsfDRVHG+iflZq+fmE1O/lZ
        /a4kHp1HUc0vGnx2ib0lQJ0=
X-Google-Smtp-Source: AJdET5e6byFvDmt52MSvQ4huBg/6ZS4aiLe3Sjc4J4RxjEXQZvalucTLR/UpnQq8GIroqKh5vnOoKA==
X-Received: by 2002:a17:906:2ec6:: with SMTP id s6-v6mr12611169eji.93.1542115100266;
        Tue, 13 Nov 2018 05:18:20 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id f6-v6sm5372494edr.18.2018.11.13.05.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 05:18:19 -0800 (PST)
Date:   Tue, 13 Nov 2018 13:18:18 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vmscan: return NODE_RECLAIM_NOSCAN in node_reclaim()
 when CONFIG_NUMA is n
Message-ID: <20181113131818.qusgwarnzcektr53@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181113041750.20784-1-richard.weiyang@gmail.com>
 <20181113080436.22078-1-richard.weiyang@gmail.com>
 <20181113125611.GA16182@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113125611.GA16182@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 01:56:11PM +0100, Michal Hocko wrote:
>On Tue 13-11-18 16:04:36, Wei Yang wrote:
>> Commit fa5e084e43eb ("vmscan: do not unconditionally treat zones that
>> fail zone_reclaim() as full") changed the return value of node_reclaim().
>> The original return value 0 means NODE_RECLAIM_SOME after this commit.
>> 
>> While the return value of node_reclaim() when CONFIG_NUMA is n is not
>> changed. This will leads to call zone_watermark_ok() again.
>> 
>> This patch fix the return value by adjusting to NODE_RECLAIM_NOSCAN. Since
>> node_reclaim() is only called in page_alloc.c, move it to mm/internal.h.
>
>The issue should be cosmetic but the code consistency is definitely an
>improvement. Moving this from swap.h makes a lot of sense as well.
>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

>
>> ---
>> v2:  move node_reclaim() to mm/internal.h
>> ---
>>  include/linux/swap.h |  6 ------
>>  mm/internal.h        | 10 ++++++++++
>>  2 files changed, 10 insertions(+), 6 deletions(-)
>> 
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index d8a07a4f171d..065988c27373 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -358,14 +358,8 @@ extern unsigned long vm_total_pages;
>>  extern int node_reclaim_mode;
>>  extern int sysctl_min_unmapped_ratio;
>>  extern int sysctl_min_slab_ratio;
>> -extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
>>  #else
>>  #define node_reclaim_mode 0
>> -static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
>> -				unsigned int order)
>> -{
>> -	return 0;
>> -}
>>  #endif
>>  
>>  extern int page_evictable(struct page *page);
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 291eb2b6d1d8..6a57811ae47d 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -444,6 +444,16 @@ static inline void mminit_validate_memmodel_limits(unsigned long *start_pfn,
>>  #define NODE_RECLAIM_SOME	0
>>  #define NODE_RECLAIM_SUCCESS	1
>>  
>> +#ifdef CONFIG_NUMA
>> +extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
>> +#else
>> +static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
>> +				unsigned int order)
>> +{
>> +	return NODE_RECLAIM_NOSCAN;
>> +}
>> +#endif
>> +
>>  extern int hwpoison_filter(struct page *p);
>>  
>>  extern u32 hwpoison_filter_dev_major;
>> -- 
>> 2.15.1
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
