Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC42C67838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B402082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjVTZGAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B402082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeLGEPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:15:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39954 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeLGEPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 23:15:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so2612540edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 20:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fYnV/EO4xTIHV6ubHlOYZNuYjGOKKK4VA8dvnyVZ/vI=;
        b=WjVTZGAI5mU/xUcQbxIH3olcK8m1Jg5qZJ+SyM5GOUoC4b87aXQcirbTyEfIOVh8CZ
         KiJgOm0lBJ/Q+W5hoVvttUJq+HbP5PeKtdMjCxEDZjUh4nl0Q+YIs8o41ma22pn8BpXc
         ngrnHh1Om9363Y+qWDOjGlPLK/x9MKkn74zzejSprD3nw3TTZwyt+BlmpD5QpCfjnZu0
         gVonRFh8fwsw6qon9eXs4/72V0++eAmPnD8fWTW6tqWgPKR3jWOPuGaxzcsSq4m6dVOo
         3GCsCg8q792ieFgFyHGOxNiPs6GNnULl1GRuXc5srPSMQ+BTsO+BySKNsN6VQ33FIMzb
         NCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fYnV/EO4xTIHV6ubHlOYZNuYjGOKKK4VA8dvnyVZ/vI=;
        b=KvQpJEApLfyJNDqK8YiVM5TCmLMkdjsg7PMzxvifqvdU7aKyXEFgSkvrL1P8DpR1Pj
         DBZkWLfTfGKzZHot1co0KItUCFjJxfnufPQ/79KyHdApF0F0kSrBjiGp671+kUQT2Xg1
         Nl6zlOzcSNsbgLQn6wA3p3kSOBJ5U4YLjtsGrtHiEeUk4cxYQ80J9eIICNp+gbtvdLvR
         IEARYdgT54o5ALw0/DwjXdjI4H/wMFeTEmj0LWgPa++qnMHvIOB9tusW84wBEfegRXOm
         EQNZ3dBRhq34Sxd69PgngA0QYKfs6ZMNZuICPhMSnAH13Xivi1DVmF/7gPRr4e2tDR/K
         Kchg==
X-Gm-Message-State: AA+aEWZi5BYq0GkTGIb1YQ8zE24FQxHHYtSFGokZ6/tTPb6euGIBjIDp
        Q5wrVmecKDpZuqu7IRrCBBkPllSI
X-Google-Smtp-Source: AFSGD/WHaO/M/QmusgsSTCZd3Fv72Dwcq9GBWDzNlLU3wHnei0AeR9iogT07LcayEwYlQq4xOpvD+Q==
X-Received: by 2002:a50:ba3d:: with SMTP id g58mr818433edc.35.1544156130409;
        Thu, 06 Dec 2018 20:15:30 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v43sm683219edc.18.2018.12.06.20.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 20:15:29 -0800 (PST)
Date:   Fri, 7 Dec 2018 04:15:28 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, kmemleak: Little optimization while scanning
Message-ID: <20181207041528.xs4xnw6vpsbu5csx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181206131918.25099-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206131918.25099-1-osalvador@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 02:19:18PM +0100, Oscar Salvador wrote:
>kmemleak_scan() goes through all online nodes and tries
>to scan all used pages.
>We can do better and use pfn_to_online_page(), so in case we have
>CONFIG_MEMORY_HOTPLUG, offlined pages will be skiped automatically.
>For boxes where CONFIG_MEMORY_HOTPLUG is not present, pfn_to_online_page()
>will fallback to pfn_valid().
>
>Another little optimization is to check if the page belongs to the node
>we are currently checking, so in case we have nodes interleaved we will
>not check the same pfn multiple times.
>
>I ran some tests:
>
>Add some memory to node1 and node2 making it interleaved:
>
>(qemu) object_add memory-backend-ram,id=ram0,size=1G
>(qemu) device_add pc-dimm,id=dimm0,memdev=ram0,node=1
>(qemu) object_add memory-backend-ram,id=ram1,size=1G
>(qemu) device_add pc-dimm,id=dimm1,memdev=ram1,node=2
>(qemu) object_add memory-backend-ram,id=ram2,size=1G
>(qemu) device_add pc-dimm,id=dimm2,memdev=ram2,node=1
>
>Then, we offline that memory:
> # for i in {32..39} ; do echo "offline" > /sys/devices/system/node/node1/memory$i/state;done
> # for i in {48..55} ; do echo "offline" > /sys/devices/system/node/node1/memory$i/state;don
> # for i in {40..47} ; do echo "offline" > /sys/devices/system/node/node2/memory$i/state;done
>
>And we run kmemleak_scan:
>
> # echo "scan" > /sys/kernel/debug/kmemleak
>
>before the patch:
>
>kmemleak: time spend: 41596 us
>
>after the patch:
>
>kmemleak: time spend: 34899 us
>
>Signed-off-by: Oscar Salvador <osalvador@suse.de>
>---
> mm/kmemleak.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>index 877de4fa0720..5ce1e6a46d77 100644
>--- a/mm/kmemleak.c
>+++ b/mm/kmemleak.c
>@@ -113,6 +113,7 @@
> #include <linux/kmemleak.h>
> #include <linux/memory_hotplug.h>
> 
>+

This one maybe not necessary.

> /*
>  * Kmemleak configuration and common defines.
>  */
>@@ -1547,11 +1548,14 @@ static void kmemleak_scan(void)
> 		unsigned long pfn;
> 
> 		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>-			struct page *page;
>+			struct page *page = pfn_to_online_page(pfn);
>+
>+			if (!page)
>+				continue;
> 
>-			if (!pfn_valid(pfn))
>+			/* only scan pages belonging to this node */
>+			if (page_to_nid(page) != i)
> 				continue;

Not farmiliar with this situation. Is this often?

>-			page = pfn_to_page(pfn);
> 			/* only scan if page is in use */
> 			if (page_count(page) == 0)
> 				continue;
>-- 
>2.13.7

-- 
Wei Yang
Help you, Help me
