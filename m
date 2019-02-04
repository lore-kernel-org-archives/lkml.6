Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96F6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4FF218A1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIqvX9gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfBDSGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:06:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46841 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:06:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so620088ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 10:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tifl2fjh91CXdZBD9PbeUXjB2c6ZnYPpiuLFbU9AUnM=;
        b=KIqvX9gLXtt/OXJFsfOAqj1Oxn4uJd4F0HpBDR5cn0hTtQQ1WpQqXFEZ4wCjGxqZ71
         e17Q7KISuQ0FGzUno9RhpmbgDk0tNsw1l6BJLrVC2SNMTm2PTpVH0Zd4DkyM/mn1b3AF
         4BGgQG7kJYjcHcDxuyTR/xucUCl/MUwYDqUNESnGV608itexst6QJdhmfKvjhrVfdV1g
         KLLT/2wqOzuqIMEnTecw/e9OyEe1y9Gqr/LNBF5KKRxfkqqZAVcWUUwM4B+GZKI4AGib
         rQw8xVQPr71kmg+cvH9CnT4UQArGc1eRvkLJYA7irII8XKi8tCnQwZxWzgdjnuWzQrDY
         YgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tifl2fjh91CXdZBD9PbeUXjB2c6ZnYPpiuLFbU9AUnM=;
        b=QCgJYZU+J+2HavQsPz9hlcGi6C4brzA2ZmdmPQmyW0/cs2lYxl8SzDU1ZJDAyaQcg2
         T0cAqrULIMKrC4FL+B2DBnh1OFm+Gau+6h7jsHpqhlUnVKGqj1MD0yf9DhoH6zW6KuRi
         D1BAiolxPI3n033dDklcPPa+Ae9Sx69taqZudl99lL7D88P41xf+6WRqG1MTvTZLnN/b
         du0yn0zSxs9d61+m/i4hahIPOYwgdeRsL0OuDmsytXmmSdYfPhRdGbUMHxJtMYczFeKV
         6XkuPgA7E/bfPCQ9RXmRUQNIV0BBBjRrn+PajcXbzTobJY/4nWYrevPCHcLo1W5GNRvz
         3h8g==
X-Gm-Message-State: AHQUAuZ0MqZATzmUv//fqGgFr7JPkikS5nWS0XyD2gFg+gqFocAJDuh8
        DRlzb7w4ciY97Y5J3TpsjrE=
X-Google-Smtp-Source: AHgI3IY01oOfs6e+TgiaoojNhBLc1KIx9SaDlHviSHa5lSL/dGFNaJHq1+fPkakrkI3x3xkAXPRb9w==
X-Received: by 2002:a2e:94ce:: with SMTP id r14-v6mr421255ljh.34.1549303596004;
        Mon, 04 Feb 2019 10:06:36 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id k3-v6sm2854434lja.8.2019.02.04.10.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 10:06:35 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 Feb 2019 19:06:26 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] mm/vmalloc: convert vmap_lazy_nr to atomic_long_t
Message-ID: <20190204180626.danletd4uh3rxnyd@pc636>
References: <20190131162452.25879-1-urezki@gmail.com>
 <20190201124528.GN11599@dhcp22.suse.cz>
 <20190204104956.vg3u4jlwsjd2k7jn@pc636>
 <20190204133300.GA21860@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204133300.GA21860@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Matthew.

On Mon, Feb 04, 2019 at 05:33:00AM -0800, Matthew Wilcox wrote:
> On Mon, Feb 04, 2019 at 11:49:56AM +0100, Uladzislau Rezki wrote:
> > On Fri, Feb 01, 2019 at 01:45:28PM +0100, Michal Hocko wrote:
> > > On Thu 31-01-19 17:24:52, Uladzislau Rezki (Sony) wrote:
> > > > vmap_lazy_nr variable has atomic_t type that is 4 bytes integer
> > > > value on both 32 and 64 bit systems. lazy_max_pages() deals with
> > > > "unsigned long" that is 8 bytes on 64 bit system, thus vmap_lazy_nr
> > > > should be 8 bytes on 64 bit as well.
> > > 
> > > But do we really need 64b number of _pages_? I have hard time imagine
> > > that we would have that many lazy pages to accumulate.
> > > 
> > That is more about of using the same type of variables thus the same size
> > in 32/64 bit address space.
> > 
> > <snip>
> > static void free_vmap_area_noflush(struct vmap_area *va)
> > {
> >     int nr_lazy;
> >  
> >     nr_lazy = atomic_add_return((va->va_end - va->va_start) >> PAGE_SHIFT,
> >                                 &vmap_lazy_nr);
> > ...
> >     if (unlikely(nr_lazy > lazy_max_pages()))
> >         try_purge_vmap_area_lazy();
> > <snip>
> > 
> > va_end/va_start are "unsigned long" whereas atomit_t(vmap_lazy_nr) is "int". 
> > The same with lazy_max_pages(), it returns "unsigned long" value.
> > 
> > Answering your question, in 64bit, the "vmalloc" address space is ~8589719406
> > pages if PAGE_SIZE is 4096, i.e. a regular 4 byte integer is not enough to hold
> > it. I agree it is hard to imagine, but it also depends on physical memory a
> > system has, it has to be terabytes. I am not sure if such systems exists.
> 
> There are certainly systems with more than 16TB of memory out there.
> The question is whether we want to allow individual vmaps of 16TB.
Honestly saying, i do not know. But what i see is we are allowed to
do individual mapping as much as physical memory we have. If i do not
miss something.

>
> We currently have a 32TB vmap space (on x86-64), so that's one limit.
> Should we restrict it further to avoid this ever wrapping past a 32-bit
> limit?
We can restrict vmap space to 1 << 32 pages in 64 bit systems, but then
probably all archs have to follow that rule and patched accordingly. Apart
of that i am not sure how KASAN calculates start point for its allocation,
i mean offset within VMALLOC_START - VMALLOC_END address space. The same
regarding kernel module mapping space(if built to allocate in vmalloc space).

Also, since atomic_t is integer it can be negative, therefore we have to
use casting to "unsigned int" everywhere if deal with "vmap_lazy_nr".

Thank you.

--
Vlad Rezki
