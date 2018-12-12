Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFB2C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4337820849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544624744;
	bh=aZEPwGQRPgAnsuyH5sxrD5SwCuUh70oKSz5p8NwcTCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LoLeD2Po+VTIpCxJDhX+SiztPrHDf5etPp7qJLc8PXHYdoNMsMkJhpltIyfzWqEp6
	 NOgfJmpcWRCq8pdvB534y05cHJa5+msvNhDGdrsIeUktND53YwuxINFLAhsIzig+8O
	 XkZHUMIvAqi/9bKMXYtkTgj+up+ZJnxdLluABV8M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4337820849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeLLOZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:25:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:55556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbeLLOZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:25:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC6ADADF3;
        Wed, 12 Dec 2018 14:25:40 +0000 (UTC)
Date:   Wed, 12 Dec 2018 15:25:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] mm: lower the printk loglevel for __dump_page
 messages
Message-ID: <20181212142540.GA7378@dhcp22.suse.cz>
References: <20181107101830.17405-1-mhocko@kernel.org>
 <20181107101830.17405-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107101830.17405-3-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems one follow up fix got lost on my side. Andrew, could you fold
this in please?

diff --git a/mm/debug.c b/mm/debug.c
index 68e9a9f2df16..4c916e1abedc 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -88,7 +88,7 @@ void __dump_page(struct page *page, const char *reason)
 	pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
 
 hex_only:
-	print_hex_dump(KERN_ALERT, "raw: ", DUMP_PREFIX_NONE, 32,
+	print_hex_dump(KERN_WARN, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
 
-- 
Michal Hocko
SUSE Labs
