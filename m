Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEAFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DABC2147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DABC2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbeHPJMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 05:12:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51036 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387511AbeHPJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 05:12:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so3313629wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 23:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+mygP+IKuArot9650jmifudk6KYbMg2Dus6itp5Eg4=;
        b=TFF7XnjdR6Ebg9Jgvc6kXob2gpsgH6YApT6Ft92d3KOi8Xbce+XHD4+tInFyjG12fr
         qamOO7RnLomN4+3bkz5tQOEbmRsfecjnEJP5giFJQxlqDFP+QCdBKNCAa5RAn+UpgX3Q
         wBSqWhiQ1VH3F4eIuGAGgwy9kNpiYu22QCw6PTJZn72oNycrG8LDil7e7MaFfR8s8NHO
         sGujWw5aaOvVjGvghmb08sKdVyypk8uaU3LB61KtCJdFiYxnWy5kdSKEc/eyvjEvj1Or
         /ayW7J1Ovzy9bMw++qs4f4hI6azdn7cpJMhXpIt/IUViYWQToDLB5saSXEhRMthesaC2
         FtzA==
X-Gm-Message-State: AOUpUlGvHRI5NVM620VMEUxHJbumhz5rrdPRU+aIVLdvpWqgKDnQnJnX
        O569oAOLhaae10hz7V5u9J7dWNURtxo=
X-Google-Smtp-Source: AA+uWPzlljJ3iyKaOaDVguQXNOymqrPODPzcGoHlMe8qEtP/AvcIFrgzgTX0hKeTv1nzUf6KRq2yvw==
X-Received: by 2002:a1c:e3d5:: with SMTP id a204-v6mr14834252wmh.20.1534400153346;
        Wed, 15 Aug 2018 23:15:53 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l72-v6sm1098911wma.17.2018.08.15.23.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 23:15:52 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 188021248C8; Thu, 16 Aug 2018 08:15:52 +0200 (CEST)
Date:   Thu, 16 Aug 2018 08:15:52 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.com, vbabka@suse.cz, pavel.tatashin@microsoft.com,
        Jonathan.Cameron@huawei.com, arbab@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/4] mm/memory_hotplug: Make
 register_mem_sect_under_node a cb of walk_memory_range
Message-ID: <20180816061552.GA15875@techadventures.net>
References: <20180622111839.10071-1-osalvador@techadventures.net>
 <20180622111839.10071-4-osalvador@techadventures.net>
 <20180815152135.4f755e25c865af2054cfaf02@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815152135.4f755e25c865af2054cfaf02@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 03:21:35PM -0700, Andrew Morton wrote:
> On Fri, 22 Jun 2018 13:18:38 +0200 osalvador@techadventures.net wrote:
> 
> > From: Oscar Salvador <osalvador@suse.de>
> > 
> > link_mem_sections() and walk_memory_range() share most of the code,
> > so we can use convert link_mem_sections() into a dummy function that calls
> > walk_memory_range() with a callback to register_mem_sect_under_node().
> > 
> > This patch converts register_mem_sect_under_node() in order to
> > match a walk_memory_range's callback, getting rid of the
> > check_nid argument and checking instead if the system is still
> > boothing, since we only have to check for the nid if the system
> > is in such state.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Suggested-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> 
> We have two tested-by's bu no reviewers or ackers?
 
Pavel, would you be so kind to review this patch?
It is the only patch from the patchset which did not get a 
review.

Thanks!
-- 
Oscar Salvador
SUSE L3
