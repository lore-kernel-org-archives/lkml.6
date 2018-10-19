Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7708CECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C24F2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ/q34I6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C24F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJSQWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:22:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38991 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeJSQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:22:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id d15-v6so30642376edq.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 01:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZg0kGQbzA1q4AVBwEpmWKwln8RWfeHxLgwGYvHtXZs=;
        b=PQ/q34I6n4a3qcQ8ZoSaphkK3zEzvLtHE4xVAzZ8jlEYH2ysBndLw1q791AB0jzvYu
         CvmnC+ry9OH+XCrwz2tvbgCY4b2S1xt2pgMMiAdfwCezRF6WGS8kh04P2C9MyB0/VyJz
         A7MTzXjLtlZfwixHMqD9K4/U97hYq3ZQsKRWhwe1fiJS3C9xJ7oS2r7H8Gu1GT/w4dCd
         N+71IbjzK5stnWgkzr00Gof6muI1PYh6T9qFU9KocMAJN6jmLObIY1r5DsxYgFcfL8ST
         0cZzfJjy/cHdYi8sxdAl7qreY/oo8qxdMmXJoly9udO7k2usnrDPQM4KhnUBfq7EqH34
         QvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZg0kGQbzA1q4AVBwEpmWKwln8RWfeHxLgwGYvHtXZs=;
        b=AYPlROpbBh222/qfYvLOEOJb79IhQcil8G1vQUB4yfjAbOWuk+x7bHtp5fPwdEFRxu
         Z2qqvN4G8hOHaIgdhHGJEAn+1zgmSspWXjKhHwdSW2j7vLO3MmWTPtQxM/gn5NFiRjQu
         W6FO9nScSiXRtHR/Hn82zbFyarYcTMrlv6tPuNpVEFm9G9WgLIUMvdSzRNi5rtTWTekp
         6xZGZ65ihzxd7eW2EFZxQ6JJT1LLOTE5wPfn15IdhXzyQmxUYyj4IXz6Rqn/NFI6bYZs
         S8f1lj/l9Jeh1EKPjugM40GRwKx5jA2OGBQCvMfz2kDg/98PiNZX8S6aKnumqKex0hl2
         PldA==
X-Gm-Message-State: ABuFfojZQNIa2V9WVPUIBCqkAxrhicT0SngTB/orTpA+Z2bujbAgvnj6
        G0bEJ/Bclyx+yMQIokZzbMM=
X-Google-Smtp-Source: ACcGV62gnR1H9eJI3Uq13IhCjR7F61UtaBspbHArZgmhZCFwz1102/7GGz93lGHMP/j4CiOlKhkURQ==
X-Received: by 2002:a17:906:480e:: with SMTP id w14-v6mr30418468ejq.68.1539937051581;
        Fri, 19 Oct 2018 01:17:31 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z7-v6sm4842072ejp.49.2018.10.19.01.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 01:17:30 -0700 (PDT)
Date:   Fri, 19 Oct 2018 08:17:30 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: remove stale #else and the code it protects
Message-ID: <20181019081729.klvckcytnhheaian@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1538067825-24835-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538067825-24835-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Which tree it applies?

On Thu, Sep 27, 2018 at 08:03:45PM +0300, Mike Rapoport wrote:
>During removal of HAVE_MEMBLOCK definition, the #else clause of the
>
>	#ifdef CONFIG_HAVE_MEMBLOCK
>		...
>	#else
>		...
>	#endif
>
>conditional was not removed.
>
>Remove it now.
>
>Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
>Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
>Cc: Michal Hocko <mhocko@suse.com>
>---
> include/linux/memblock.h | 5 -----
> 1 file changed, 5 deletions(-)
>
>diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>index d3bc270..d4d0e01 100644
>--- a/include/linux/memblock.h
>+++ b/include/linux/memblock.h
>@@ -597,11 +597,6 @@ static inline void early_memtest(phys_addr_t start, phys_addr_t end)
> {
> }
> #endif
>-#else
>-static inline phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align)
>-{
>-	return 0;
>-}
> 
> #endif /* __KERNEL__ */
> 
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me
