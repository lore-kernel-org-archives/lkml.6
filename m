Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F964ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE11D20647
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OodYqxgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE11D20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbeGWWgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:36:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41097 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388052AbeGWWgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:36:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id y10-v6so342158pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fyAHSROpRYFFVw5kEfjbZbLFe4lOE/YZUVuTP00qnj8=;
        b=OodYqxgS3nB9EF+Qy+MeJ4s5Dp49TXSncJ3m3GIYOGMLuN0d+lfYTf6+rjgcjHdJdT
         inFNGZGJvKGi9o93QcYGQ/t4tKbZTb1Xt476GUul1zP1zhLr9ddgOlQxrv2iWT/zcgkD
         XYB1ax5LB/SNMq3Qdz530NcbO90S+AClE/A5HbJQTXKFf2HqvuzjjifJH0bxsSTBfAog
         V6HG8VZzMsR3UtWMe+5bB5vjnJj6dK7aAXAY/hVywKiXfcioDZgywDrGfMKHH6X1bDDu
         F3LLtsKDMYoelMrUzwZyAfR1kj4KMz7I4SPPN3S3H6+eXgzHN/cqfD+8TY1o2q35oimV
         rlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fyAHSROpRYFFVw5kEfjbZbLFe4lOE/YZUVuTP00qnj8=;
        b=fUowIBQsoStO8CoIPmQtdg61aAf43CtZOHjAcjeE5gxPH5ZnONjc55+XskueWN8Qff
         qiNx+rR7hUWkpglTEfcQ4g6dyw/Om6/tspAzYap8FAoKkfmsvXyIRJ/65k62wG2j0W6p
         5bSUkCnKzxvPJikVGiz2IEqpDu2PODT59DUm/7OcpIykDZYO7Gh/iNsSHh1UHELHhOBS
         /EqBcst0L5XhnVRNLFjXjQotCp55GzXeUm+itRamWcNFEFdlx7UAoIzxc/kT2jWOFH9p
         xKRnLBgF9TyzAhp0kp3EcGuG3KTFXqBNWQj5qYbOy7gfhhX4tPVz/UqPqLB+db8jn/Xx
         pSgw==
X-Gm-Message-State: AOUpUlH39xTZbiwxynUsuL2VPSbslYCwv4mcL+oIjqgU39q7O2QybN88
        YHQQBsSkMVqyeghKc2WNLgPhrw==
X-Google-Smtp-Source: AAOMgpfafSX9JppaTCUhKu537mw5iOmv6rvE5zP1Ac0OajqVJhxbFzPt1SaNTuxB/5tejqb1jzmBhA==
X-Received: by 2002:a63:4951:: with SMTP id y17-v6mr13956367pgk.32.1532381590170;
        Mon, 23 Jul 2018 14:33:10 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y5-v6sm9032128pfj.169.2018.07.23.14.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 14:33:09 -0700 (PDT)
Date:   Mon, 23 Jul 2018 14:33:08 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill@shutemov.name, hughd@google.com, aaron.lu@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
In-Reply-To: <alpine.DEB.2.21.1807231323460.105582@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1807231427550.103523@chino.kir.corp.google.com>
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com> <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org> <alpine.DEB.2.21.1807201300290.224013@chino.kir.corp.google.com> <3238b5d2-fd89-a6be-0382-027a24a4d3ad@linux.alibaba.com>
 <alpine.DEB.2.21.1807201401390.231119@chino.kir.corp.google.com> <20180722035156.GA12125@bombadil.infradead.org> <alpine.DEB.2.21.1807231323460.105582@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018, David Rientjes wrote:

> > > The huge zero page can be reclaimed under memory pressure and, if it is, 
> > > it is attempted to be allocted again with gfp flags that attempt memory 
> > > compaction that can become expensive.  If we are constantly under memory 
> > > pressure, it gets freed and reallocated millions of times always trying to 
> > > compact memory both directly and by kicking kcompactd in the background.
> > > 
> > > It likely should also be per node.
> > 
> > Have you benchmarked making the non-huge zero page per-node?
> > 
> 
> Not since we disable it :)  I will, though.  The more concerning issue for 
> us, modulo CVE-2017-1000405, is the cpu cost of constantly directly 
> compacting memory for allocating the hzp in real time after it has been 
> reclaimed.  We've observed this happening tens or hundreds of thousands 
> of times on some systems.  It will be 2MB per node on x86 if the data 
> suggests we should make it NUMA aware, I don't think the cost is too high 
> to leave it persistently available even under memory pressure if 
> use_zero_page is enabled.
> 

Measuring access latency to 4GB of memory on Naples I observe ~6.7% 
slower access latency intrasocket and ~14% slower intersocket.

use_zero_page is currently a simple thp flag, meaning it rejects writes 
where val != !!val, so perhaps it would be best to overload it with 
additional options?  I can imagine 0x2 defining persistent allocation so 
that the hzp is not freed when the refcount goes to 0 and 0x4 defining if 
the hzp should be per node.  Implementing persistent allocation fixes our 
concern with it, so I'd like to start there.  Comments?
