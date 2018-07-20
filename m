Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951EEECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4115120661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lB6bPnQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4115120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeGTUwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:52:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36571 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeGTUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:52:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id s7-v6so4277276pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=U95wxqtS68PgL/wEjb2QH8e7ZhgUqbKMAwpAR9PEnYo=;
        b=lB6bPnQQj3ZjkYGq4qveIXejJuLOa4UyQVnlyxADJc+YL4qMk/s09r5xH+OQfzcQ4v
         Rzdsy5j/oT/UFDCdlmtoOeBH6B1f3ySAI0EqBBCU4YjDyqEin++jQscaz99rZ2x8yYUD
         vqrZtt3EWceSdvR/8P8bhWUJxpTNSnkRHADmc3MSqJLzoebABZvzeeCCxqrjlm1Lg7U+
         4MaG/eBV3MQqQ4zoaAQ/fBk32lF/WToFfc1j7VzZVPOndKtcCMadwwOPd6tCF+wkLO5N
         nHCZO/AqLr06FUCDK5F3+x+4/K/NjERS4gUq1NrTbIKBQrvQgYmQE7cDfqgdR7a0yMCa
         YpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=U95wxqtS68PgL/wEjb2QH8e7ZhgUqbKMAwpAR9PEnYo=;
        b=kP0KzWdC6fOSQIbEnIFMRnt5ml0CuA4mnBEmvOJCjheINVDb+uMz59BC5eQw+SEKPr
         /RXk46R/ShKXcVfWvjsaeXrLl1jaVM6F9oZLUYz0ogDUdSeweSZmsFwyInRtPHu0Qq8G
         s/eWNLDdQzHHq1wBTfaA/dAD1sA/jfcUnjF4lOuaFtRl40JKoEMM+8bzPWPvFXnWB1Oz
         3mEdiRBqcuXAdyiM/OfDDyt49Id65j52EbkTK+vhsTSVa4vryrK7Wk4pwxix8nDIruTu
         nzxQsAeFW1qXTQekA++EGrZlTRqjP+kkVYZarCU+h1B84oWJDImetO0XiMXX/BbIUTQf
         X+Aw==
X-Gm-Message-State: AOUpUlHFUkN2Twf53Kpn/zn5sdo2mZOB4i62eueo2SBO+bpBe/y2SBmJ
        wgLfc24VAS3o9BLiIMJstHtbvg==
X-Google-Smtp-Source: AAOMgpeS8UjxyKKjGXTvN9YeSKtDMWMM6rQYvdrWMmXOImJtM3g6e3nxUVPfV/ZFNXH+rWquDUOITQ==
X-Received: by 2002:a63:b349:: with SMTP id x9-v6mr3278961pgt.337.1532116954297;
        Fri, 20 Jul 2018 13:02:34 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d123-v6sm3816721pfa.22.2018.07.20.13.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 13:02:33 -0700 (PDT)
Date:   Fri, 20 Jul 2018 13:02:33 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yang Shi <yang.shi@linux.alibaba.com>, kirill@shutemov.name,
        hughd@google.com, aaron.lu@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
In-Reply-To: <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1807201300290.224013@chino.kir.corp.google.com>
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com> <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018, Andrew Morton wrote:

> > By digging into the original review, it looks use_zero_page sysfs knob
> > was added to help ease-of-testing and give user a way to mitigate
> > refcounting overhead.
> > 
> > It has been a few years since the knob was added at the first place, I
> > think we are confident that it is stable enough. And, since commit
> > 6fcb52a56ff60 ("thp: reduce usage of huge zero page's atomic counter"),
> > it looks refcounting overhead has been reduced significantly.
> > 
> > Other than the above, the value of the knob is always 1 (enabled by
> > default), I'm supposed very few people turn it off by default.
> > 
> > So, it sounds not worth to still keep this knob around.
> 
> Probably OK.  Might not be OK, nobody knows.
> 
> It's been there for seven years so another six months won't kill us. 
> How about as an intermediate step we add a printk("use_zero_page is
> scheduled for removal.  Please contact linux-mm@kvack.org if you need
> it").
> 

We disable the huge zero page through this interface, there were issues 
related to the huge zero page shrinker (probably best to never free a 
per-node huge zero page after allocated) and CVE-2017-1000405 for huge 
dirty COW.
