Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9BAECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4742083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT6ysxuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4742083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJVJvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 05:51:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45584 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeJVJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 05:51:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id t10-v6so3590568eds.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2STM3QACkcoRYLYc6fyQbtAZ2peEJasfGTy1/bhwUO4=;
        b=AT6ysxuBoX4f1P1KMN5+SYXzfju75m9+kIPcd8xfcngYDlKs/s1I2lRqb8RDcp+bmD
         Owceb2z4CLC3O7wtowboN2+vS07lmlOoD8xWXCs3AYKoH4JUAIN9gVGFyBTN4Gp9DQ3p
         NzDsEs+o2X791U0N6ise0TW29YcHOMhUwWk0K/zR1MlgjNdFhQOYUGGJKn/sgEHX+VXh
         6KUXLC0/AuCZqe+TehmWhGS/B19z4U75GIWo7lDeKUDYd8DKgN5sxHtHAK9QMtD2bIbm
         1Wjf0E5VhTEzj/oOZk0y7DhxWNdmMujAuWJG7GxtRayuWXHmDcOVk17Wf5nN/UbULjle
         zI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2STM3QACkcoRYLYc6fyQbtAZ2peEJasfGTy1/bhwUO4=;
        b=I5+DNGzy9PU/A3mX7YvpLqKXo4EijSG8yx9SKxMaEQ4V8qmsPRQNFrBd4JDEnogVAO
         6DOSTARUDNEtLtjJgdYYLUlcdyoBIOwdSGWSz32/Utbj4SB7Th5eSmrP/icau6CciCpe
         Wf7emA17Ad8LQTYSds16onXKhbyek91eK6YIqLMa4RwCc0E3lkOXkHQx4h8Vy/2OREvO
         9VtHDPWiYmyBKikL3egkDXXaJdsBejhH8MkzA2kXeZeIu9FqbFjvVllykVySUZE8rM/R
         zI7lJT0H5YpcFWXaJv3P8MIypY5XqrAAcNoUzqgR7hFvAjc5DubXpIvQPiIBlAhTCxiT
         d1/Q==
X-Gm-Message-State: ABuFfoi1lzJhLapGjbj0hNebj45BXSvlwhqARpXybLefUVGVFGk8EB7z
        QYB+Gc3xs1N+3STsmYRpqSo=
X-Google-Smtp-Source: AJdET5c9qdzBH7OX2CBeh97QYjzf2qzdjoutaMAiZr7JRvukQ4Kv6tt33LoZvUugOhfpyLvinA3Tsw==
X-Received: by 2002:a17:906:c2c6:: with SMTP id ch6-v6mr1969921ejb.9.1540172116830;
        Sun, 21 Oct 2018 18:35:16 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id gt25-v6sm6445070ejb.33.2018.10.21.18.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 18:35:15 -0700 (PDT)
Date:   Mon, 22 Oct 2018 01:35:15 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: remove stale #else and the code it protects
Message-ID: <20181022013515.frvzqvccrrp3qiw4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1538067825-24835-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20181019081729.klvckcytnhheaian@master>
 <6EEAA7EC-75B7-4899-A562-35A58FC037E6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6EEAA7EC-75B7-4899-A562-35A58FC037E6@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:30:16AM +0300, Mike Rapoport wrote:
>
>
>On October 19, 2018 11:17:30 AM GMT+03:00, Wei Yang <richard.weiyang@gmail.com> wrote:
>>Which tree it applies?
>
>To mmotm of the end of September.
>

I may lost some background of this change.

The file I am looking at is
https://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git/tree/include/linux/memblock.h
which has CONFIG_HAVE_MEMBLOCK in line 5.

>>On Thu, Sep 27, 2018 at 08:03:45PM +0300, Mike Rapoport wrote:
>>>During removal of HAVE_MEMBLOCK definition, the #else clause of the
>>>
>>>	#ifdef CONFIG_HAVE_MEMBLOCK
>>>		...
>>>	#else
>>>		...
>>>	#endif
>>>
>>>conditional was not removed.
>>>
>>>Remove it now.
>>>
>>>Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
>>>Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
>>>Cc: Michal Hocko <mhocko@suse.com>
>>>---
>>> include/linux/memblock.h | 5 -----
>>> 1 file changed, 5 deletions(-)
>>>
>>>diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>>index d3bc270..d4d0e01 100644
>>>--- a/include/linux/memblock.h
>>>+++ b/include/linux/memblock.h
>>>@@ -597,11 +597,6 @@ static inline void early_memtest(phys_addr_t
>>start, phys_addr_t end)
>>> {
>>> }
>>> #endif
>>>-#else
>>>-static inline phys_addr_t memblock_alloc(phys_addr_t size,
>>phys_addr_t align)
>>>-{
>>>-	return 0;
>>>-}
>>> 

And in that file, here is memblock_reserved_memory_within.

I guess this is not the version you are trying to fix.

BTW, if you could put the commit SHA which removes the
CONFIG_HAVE_MEMBLOCK, it would be easier for others to catch up.

>>> #endif /* __KERNEL__ */
>>> 
>>>-- 
>>>2.7.4
>
>-- 
>Sent from my Android device with K-9 Mail. Please excuse my brevity.

-- 
Wei Yang
Help you, Help me
