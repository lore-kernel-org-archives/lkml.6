Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8FFC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643B820870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="VFur41+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfBBR6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:58:16 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37322 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfBBR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:58:16 -0500
Received: by mail-qt1-f194.google.com with SMTP id t33so11414267qtt.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 09:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZWmrYNGvbbe+wJXyf/nwvl9ZIbUGwDA3IPzZCpJys6o=;
        b=VFur41+XCyU0GMwecXdWhdyPG+Gu+SE5KwLmgDO9vuA/0NCHiyeT3T5xNmuSZTiAGh
         sgWTHTbV9mg8Rk9OaHsM2G0pF7ifA/YFXvkX4pcUc6Faxlj75hRsfVZHtCgDcK3WIm09
         0bjAjSNJd6lWGyjHxgmmB6b44o9iLq+HybhiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZWmrYNGvbbe+wJXyf/nwvl9ZIbUGwDA3IPzZCpJys6o=;
        b=BYwIM5xhOCYbEC1oVMc26IVw77G/9k02qWo5JGnZMoWqyPi6KF4FmNr6EiPkU9ZV/5
         XPmH7oRh2kqQGN/nZaudmSJN+C69hnlwhsd+WJ/K3f5/JUKuVIX5GWr52Z4VMdAnzeMR
         eH/lkLd3nWxONhxI4tuhYhLKfOeMm0daobUIm1VlOPe/+q27Wpx9p3WDDXBPNUbmHjrv
         FaDVneKvbTkf0fIFQLGj9ePsPn74qxKH7AsCZe27A49wG0HE35j5AM4gW6G7WzeSV7/5
         4ArYPYQpIaoliGTVLMC5GmCgg91xdpq2G5ek/nxYkWQChQmWgzbOMWnBEqV8QlfU9sti
         rp0w==
X-Gm-Message-State: AJcUukfWKzPKgyn7UXJReoqv8TdKpN0HJUK9CqSGtMUkGuMNPr4jHFBv
        hZMWB7AavDxBWutyyCXtKBDiqCzFqsg=
X-Google-Smtp-Source: ALg8bN4MCfoRhpjf9tMrp/13O2maJOGAL68l0Zd78u6td0XkHDc9UTNkWngZQZ7Ogc/yJJfW5FR4ew==
X-Received: by 2002:ac8:7153:: with SMTP id h19mr41526273qtp.92.1549130295287;
        Sat, 02 Feb 2019 09:58:15 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d21sm6782003qtr.34.2019.02.02.09.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 09:58:14 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Sat, 2 Feb 2019 12:58:07 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Jiri Olsa <jolsa@redhat.com>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, eranian@google.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
In-Reply-To: <20190201173816.GA19907@krava>
Message-ID: <alpine.DEB.2.21.1902021255370.5674@macbook-air>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com> <20190130183648.GA24233@krava> <20190131082711.GC24233@krava> <20190201074353.GA8778@krava> <alpine.DEB.2.21.1902011125290.25915@macbook-air> <20190201173816.GA19907@krava>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019, Jiri Olsa wrote:

> > 
> > I've just started fuzzing with the patch applied.  Often it takes a few 
> > hours to trigger the bug.
> 
> cool, thanks

I let it run overnight and no crash.

> > Added question about this bug.  It appeared that the crash was triggered 
> > by the BTS driver over-writing kernel memory.  The data being written, was 
> > this user controllable?  Meaning, is this a security issue being fixed, or 
> > just a crashing issue?
> 
> yea, I have an example that can trigger it immediately

I mean: the crash is happening because data structures are getting 
over-written by the BTS driver.  Depending who and what is doing this, 
this could be a security issue (i.e. if it was raw BTS data that was 
partially userspace controlled values).  Though even if this were the case 
it would probably be hard to exploit.

Vince
