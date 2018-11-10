Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054F6C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B379820855
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FMUXn4cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B379820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeKJLAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 06:00:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40061 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeKJLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 06:00:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so4923804qki.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 17:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j3HNAWMYoutagkGQSGAXBA/wFjM51PBrzQw2atvbdSU=;
        b=FMUXn4cyWFv3EMbT0Jot7sprxClThucCoyrcCPYN4owZwxSsWuNXbpYFKhsZr+ZdpN
         tfnWWMTZKuaPYiK3lDEt7xzBNADGxlFHQMHGoi2Nokrc4L1arzqNQ12kg3/dbfV9oitA
         tTrJDcH7H5mEv6SOY6QCfUzcIQ7ifSwqDpfZMe+1LV4JDirKO5cDwG7hGf7Tck1LW9G6
         PeD6jSZugqpWxE+Pm+2SlM5dX09sjoc8vAybJk4C1+74+qpOefyhkxd5lD15xFg7+mly
         C1xeqHuPKsRdcRwdi9ZtpIcJSZZ5REQTBW1tyrkRkZHs9JoH0+/r76NhX2yaySgDmOee
         ko4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j3HNAWMYoutagkGQSGAXBA/wFjM51PBrzQw2atvbdSU=;
        b=N4+4Y9ak1+NmfSaZx7A6bXSVdTx+4vBSeLxQsrHTHJ4XQiYK1cK4THtsUs/hEZ4aWF
         nDdrl8+6S9VXxdmrD/WCDlJOUGhVLQVgQQhmtKmIgFhekp9xHnSbf3CqyNnzJHLa/fLq
         BZ+uvgRK0zAJJI9gf4ejX39shMWhIysYz/2KytnqRm4rsjvHvl9SnlCNA7ZNSEZ1GHOy
         M/RBTN7CYoUjZjVvZ8AUjGMHPMJC84xAbRRnWaVoUJvOA/B0TQ6xKGmIIjkgOC/l8axC
         uTXzPIuH0NibQ8wFsD/DZmro0jYNeW/yISUJ5sfiRn2hSKnEZKOurZMeLkztk28IBccp
         frBA==
X-Gm-Message-State: AGRZ1gJdvK6W3pPorYozAQWfTXltMs7vVLa4i4JY9DQUn3Wg9TwZja1p
        Avk8GLlTY4pccqn+jUugFz2KVQ==
X-Google-Smtp-Source: AJdET5d5BlfSlca7ISr3jlF+tBIhjeRc7bf5V08mZyQD+ad5l6EeA7GNKr11jLYp9VW3wZKs36QhMQ==
X-Received: by 2002:ac8:fd4:: with SMTP id f20mr11281043qtk.63.1541812615094;
        Fri, 09 Nov 2018 17:16:55 -0800 (PST)
Received: from xakep.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u199-v6sm4924855qka.47.2018.11.09.17.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 17:16:54 -0800 (PST)
Date:   Fri, 9 Nov 2018 20:16:52 -0500
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     daniel.m.jordan@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        davem@davemloft.net, pavel.tatashin@microsoft.com, mhocko@suse.com,
        mingo@kernel.org, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        rppt@linux.vnet.ibm.com, willy@infradead.org, vbabka@suse.cz,
        khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
Message-ID: <20181110011652.2wozbvfimcnhogfj@xakep.localdomain>
References: <20181109211521.5ospn33pp552k2xv@xakep.localdomain>
 <18b6634b912af7b4ec01396a2b0f3b31737c9ea2.camel@linux.intel.com>
 <20181110000006.tmcfnzynelaznn7u@xakep.localdomain>
 <0d8782742d016565870c578848138aaedf873a7c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d8782742d016565870c578848138aaedf873a7c.camel@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-09 16:46:02, Alexander Duyck wrote:
> On Fri, 2018-11-09 at 19:00 -0500, Pavel Tatashin wrote:
> > On 18-11-09 15:14:35, Alexander Duyck wrote:
> > > On Fri, 2018-11-09 at 16:15 -0500, Pavel Tatashin wrote:
> > > > On 18-11-05 13:19:25, Alexander Duyck wrote:
> > > > > This patchset is essentially a refactor of the page initialization logic
> > > > > that is meant to provide for better code reuse while providing a
> > > > > significant improvement in deferred page initialization performance.
> > > > > 
> > > > > In my testing on an x86_64 system with 384GB of RAM and 3TB of persistent
> > > > > memory per node I have seen the following. In the case of regular memory
> > > > > initialization the deferred init time was decreased from 3.75s to 1.06s on
> > > > > average. For the persistent memory the initialization time dropped from
> > > > > 24.17s to 19.12s on average. This amounts to a 253% improvement for the
> > > > > deferred memory initialization performance, and a 26% improvement in the
> > > > > persistent memory initialization performance.
> > > > 
> > > > Hi Alex,
> > > > 
> > > > Please try to run your persistent memory init experiment with Daniel's
> > > > patches:
> > > > 
> > > > https://lore.kernel.org/lkml/20181105165558.11698-1-daniel.m.jordan@oracle.com/
> > > 
> > > I've taken a quick look at it. It seems like a bit of a brute force way
> > > to try and speed things up. I would be worried about it potentially
> > 
> > There is a limit to max number of threads that ktasks start. The memory
> > throughput is *much* higher than what one CPU can maxout in a node, so
> > there is no reason to leave the other CPUs sit idle during boot when
> > they can help to initialize.
> 
> Right, but right now that limit can still be pretty big when it is
> something like 25% of all the CPUs on a 288 CPU system.

It is still OK. About 9 threads per node.

That machine has 1T of memory, which means 8 nodes need to initialize 2G
of memory each. With 46G/s throughout it should take 0.043s Which is 10
times higher than what Daniel sees with 0.325s, so there is still room
to saturate the memory throughput.

Now, if the multi-threadding efficiency is good, it should take
1.261s / 9 threads =  0.14s

> 
> One issue is the way the code was ends up essentially blowing out the
> cache over and over again. Doing things in two passes made it really
> expensive as you took one cache miss to initialize it, and another to
> free it. I think getting rid of that is one of the biggest gains with
> my patch set.

I am not arguing that your patches make sense, all I am saying that
ktasks improve time order of magnitude better on machines with large
amount of memory.

Pasha
