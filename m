Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B99CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DA82243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASezcexs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DA82243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbeKMXQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:16:51 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42091 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733226AbeKMXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:16:50 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so5423668edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 05:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YmOqzatQnn5Z7oda5wWT+SOf34ejkrcnDJLV30OzCYM=;
        b=ASezcexszYbAuYDSVCq+8AOLN6lvWFARkRcQueHQG5b4PhTv3I0qzcb8RH/BE5kl3V
         rGEF5M8VsowKAK9Eayb1xvHbvc4cAcToqRTBQDNJ6qaYSriPM95QiIFdwiBPQbU824wo
         AMEFY/ifb9V1hhMJqo4YsQRA6pMPPy86jIWuRBz7j+VdgGfNRJLARegfUMIiGKoMRT3V
         6KG5HJ9taAILIWdVdlgZlZzf2mJ7UqhPk8TJ1cIOkxm0BqxJs68yp3G3UfjkxX+SMLZd
         8cxwhej/uGYTGPERS5JYayEiiVOJi6V82LFqgmUEGIDZqlJkpAIEL9wT6VkiyS3N0DVa
         ehzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YmOqzatQnn5Z7oda5wWT+SOf34ejkrcnDJLV30OzCYM=;
        b=IKYukAs9F8bopow2+oLw4asWgNiN9WCFIi5xnsO7Ve5mamjX/3C+WgucefcdoI3q+V
         7aAY0Up4ockWdIv9wCZ698g6cJjMrCbtROE3KORrV7TWfR3VE17sSEAp2Mgefngsps0W
         kLcOjGJph+9UvaKgOE4dWp6pB0641MvpHzTPm1j5jovYGoEd9komr+4aCxNBaCXK89wd
         ndDv6AQ0X0E4V9q3OGTIebQohB7njQ6ADbcdgFK9t8pYhOG3UM76bKWvlCQ5h9lFYU8o
         b5jLIE6lowK3/o6b3inMo5UxM9x5MOp+QMxzD3CQ4GqdFkUz8kg6rjiPuhqSQ4y0tToU
         3vxw==
X-Gm-Message-State: AGRZ1gKnhlM9Sl0+DnmZsKqQ85zwpaxLEElTrh92068pnkuMUemNxkPf
        uEeXKwGzdP3rHu5aMfUjijE=
X-Google-Smtp-Source: AJdET5dlN0pSOn1zf/7VZzvlbYg4+l1KVaJMIjq9ZyXdz3MoutjP8W8nyr5LJ5aIKvq1l/VUiG6dVg==
X-Received: by 2002:a50:98a6:: with SMTP id j35-v6mr16161500edb.273.1542115122687;
        Tue, 13 Nov 2018 05:18:42 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id o62-v6sm5272874edd.13.2018.11.13.05.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 05:18:42 -0800 (PST)
Date:   Tue, 13 Nov 2018 13:18:41 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vmscan: return NODE_RECLAIM_NOSCAN in node_reclaim()
 when CONFIG_NUMA is n
Message-ID: <20181113131841.z5t7uckslfjq2mwe@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181113041750.20784-1-richard.weiyang@gmail.com>
 <20181113080436.22078-1-richard.weiyang@gmail.com>
 <20181113130420.GV21824@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113130420.GV21824@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 05:04:20AM -0800, Matthew Wilcox wrote:
>On Tue, Nov 13, 2018 at 04:04:36PM +0800, Wei Yang wrote:
>> Commit fa5e084e43eb ("vmscan: do not unconditionally treat zones that
>> fail zone_reclaim() as full") changed the return value of node_reclaim().
>> The original return value 0 means NODE_RECLAIM_SOME after this commit.
>> 
>> While the return value of node_reclaim() when CONFIG_NUMA is n is not
>> changed. This will leads to call zone_watermark_ok() again.
>> 
>> This patch fix the return value by adjusting to NODE_RECLAIM_NOSCAN. Since
>> node_reclaim() is only called in page_alloc.c, move it to mm/internal.h.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>Reviewed-by: Matthew Wilcox <willy@infradead.org>

Thanks

-- 
Wei Yang
Help you, Help me
