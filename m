Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A726DECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6087920685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+9cEnTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6087920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbeGWVbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:31:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37718 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388056AbeGWVbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:31:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id a26-v6so313364pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xOWqm0a+Cdy4lBwXBzXMerNrIuCNQhmpk+71lRXuYGo=;
        b=Z+9cEnTnKPWmVynuetxxZ/MIIGvzwcyXZ8nDjSvG5NzRBcy+SskxwlhW430KhGvUzb
         4p+veTQV7uVACTa3SP/u8LwvwqKpZOgccm+pAExyAzXqIbDUJXtlACz9a3g/h6Vceshk
         I/TwoslOOz4T9AMMMm/KFKzVKRnHNlz9GiQfi0h3rITPxwh9viEzymOxiAZIvubKUX3k
         a8Cl0O7Q7X69nt0daamL+lyP2/BoXqpkqhgth/9rtD38aJVwWrjSHj8CpoFxm8U1PFDd
         zwNIvINK/BnWty+BVCa2KiynhodoB/ccApYFp5NMeUvK/j/CUfcmw28MjENYEkC5IYrM
         7lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xOWqm0a+Cdy4lBwXBzXMerNrIuCNQhmpk+71lRXuYGo=;
        b=Hw9In1JndMjceZg6bipaF2rDXk7E0fiCJs9gfOms3kD5q4YMyyKWesAhDrThCY06zf
         HcOHdaVsEVnqZBQjcaK4NROv60jZyGGS2ONb410K/CIMRLh9URnruZ5bw36exZ111IYy
         ujUGvG29xvzpMInxVyeRSfj4gB7N2aQuzEyOmU4Uv7WQgf4MGL4ZJLonVE/DO3uca2bg
         KzGIK6M9dfAJx3RtnAriRXeXPC34NT+ntn1JP9F1PXvNiirhFrPpuBOHBqaj+T3wJ5vx
         qTHyzn30hed2iFvKFaZvv/oauLANUh08ay2ZweFrm5KAd/VUkga0UONCZxFqoZfuEqMd
         gBvQ==
X-Gm-Message-State: AOUpUlEf7d6QWlJs8lxFYAr5eaNHtKNdD9PhmW2D7p7u/OAQe4qdTNli
        0933bxfzHUky3U9RD5PrrY8JtQ==
X-Google-Smtp-Source: AAOMgpduydYsAzeUqRodaQCGGdIx59Fa8W7GlUrQrXTcdIibCsmBWQ2GyYDwk1RXsU72ZV+saBUiOA==
X-Received: by 2002:a63:1403:: with SMTP id u3-v6mr13608389pgl.13.1532377731148;
        Mon, 23 Jul 2018 13:28:51 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h24-v6sm22010680pfk.113.2018.07.23.13.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 13:28:50 -0700 (PDT)
Date:   Mon, 23 Jul 2018 13:28:49 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill@shutemov.name, hughd@google.com, aaron.lu@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
In-Reply-To: <20180722035156.GA12125@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.21.1807231323460.105582@chino.kir.corp.google.com>
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com> <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org> <alpine.DEB.2.21.1807201300290.224013@chino.kir.corp.google.com> <3238b5d2-fd89-a6be-0382-027a24a4d3ad@linux.alibaba.com>
 <alpine.DEB.2.21.1807201401390.231119@chino.kir.corp.google.com> <20180722035156.GA12125@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018, Matthew Wilcox wrote:

> > The huge zero page can be reclaimed under memory pressure and, if it is, 
> > it is attempted to be allocted again with gfp flags that attempt memory 
> > compaction that can become expensive.  If we are constantly under memory 
> > pressure, it gets freed and reallocated millions of times always trying to 
> > compact memory both directly and by kicking kcompactd in the background.
> > 
> > It likely should also be per node.
> 
> Have you benchmarked making the non-huge zero page per-node?
> 

Not since we disable it :)  I will, though.  The more concerning issue for 
us, modulo CVE-2017-1000405, is the cpu cost of constantly directly 
compacting memory for allocating the hzp in real time after it has been 
reclaimed.  We've observed this happening tens or hundreds of thousands 
of times on some systems.  It will be 2MB per node on x86 if the data 
suggests we should make it NUMA aware, I don't think the cost is too high 
to leave it persistently available even under memory pressure if 
use_zero_page is enabled.
