Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68109C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFC520844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="wvCQo91d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFC520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeIHStD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:49:03 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:44293 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeIHStD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:49:03 -0400
Received: by mail-qt0-f179.google.com with SMTP id k38-v6so19217185qtk.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pn8fMccewwLUfhmX1hn+26GDWIuo17JaTVwJ+5ZuTOU=;
        b=wvCQo91dZmZGMMTqtO61FM5dcRR2ttHrUKWfO3l1YGbbuxw0xUytetzzAVhZRzU6zs
         8wBApYFlmsmLHlkXFqOKctGJAHB9WNLF++PdpmmJ9fbBfAQIY7aw8mDEaYu01w8OcYOM
         EdOOI8r16qZtrTxn+UUeLIHttA74FlkWvDCphO1wT41sroTp+p0NfR7JmPcNvr1na+3Q
         /6+ZjHCCfuOubF8b+IP1w2cQwJOBEiQbTPFFqCHCMpXZXg61m4SaXB6kv6KsLTrvqoJ/
         6OYXleNsBgdYoW5Dhy1plpa2OMm6HwUGXib4fFDEppms7z+BixnNq86FwhlbOSRwT/Nb
         PTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pn8fMccewwLUfhmX1hn+26GDWIuo17JaTVwJ+5ZuTOU=;
        b=jyBEcWCl3b7aKUbzrj3VIwMuaWPZpV65jG1rFgUvN7nHdS2UO9pjJLh6qyPtnB0Gvh
         +g+FUEphbMCjF8iaPRcfkEacHw2SJd9zM+vB6nRDqjTblx/XNKa5lvTqKGINSXANQbDa
         BTNYBUJ8O0baR5g4oW/LX9Iz585WCGwhTQBKmrHo5J/tr5lm031D/BGdkijYAa/DHktp
         UUM2l2YT9vWiwYADw/A5wkNmF+0Nx9sr3PL+F4y6S2TgjA5utlJe8syJG0t7M1guygWZ
         7qEABmMwHzcPCFdmr3LfgPafoOKUXVmePCJonwfTOimDHm/fXTs88jZe9D/sniM+goCF
         YEJA==
X-Gm-Message-State: APzg51Dx6t0iGPUBrX7w3szeWYaAXg59XAJPg2s0hXnfMhLmA56V2+xd
        pvL81eOQmqUfnSzDn+/eB8ExnA==
X-Google-Smtp-Source: ANB0VdaJAutDo6zqSDLk4qRwkGSJKHu1s1He9UF0iW27+koVnf8eswAQU8DHne+Qc9J+eywc9NSqlQ==
X-Received: by 2002:ac8:19d0:: with SMTP id s16-v6mr9944671qtk.215.1536415388175;
        Sat, 08 Sep 2018 07:03:08 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id w12-v6sm7188510qtj.93.2018.09.08.07.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 07:03:07 -0700 (PDT)
Date:   Sat, 8 Sep 2018 10:03:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        vjitta@codeaurora.org, sumit.semwal@linaro.org,
        rientjes@google.com, mhocko@kernel.org,
        mgorman@techsingularity.net, labbott@redhat.com,
        iamjoonsoo.kim@lge.com, guro@fb.com, cl@linux.com, vbabka@suse.cz
Subject: Re: + mm-slab-shorten-kmalloc-cache-names-for-large-sizes.patch
 added to -mm tree
Message-ID: <20180908140306.GB17637@cmpxchg.org>
References: <20180906224849.1JOWr%akpm@linux-foundation.org>
 <20180907195816.GA28375@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907195816.GA28375@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:58:16PM +0300, Alexey Dobriyan wrote:
> On Thu, Sep 06, 2018 at 03:48:49PM -0700, akpm@linux-foundation.org wrote:
> > -	{"kmalloc-1024",         1024},		{"kmalloc-2048",         2048},
> > -	{"kmalloc-4096",         4096},		{"kmalloc-8192",         8192},
> > -	{"kmalloc-16384",       16384},		{"kmalloc-32768",       32768},
> > -	{"kmalloc-65536",       65536},		{"kmalloc-131072",     131072},
> > -	{"kmalloc-262144",     262144},		{"kmalloc-524288",     524288},
> > -	{"kmalloc-1048576",   1048576},		{"kmalloc-2097152",   2097152},
> > -	{"kmalloc-4194304",   4194304},		{"kmalloc-8388608",   8388608},
> > -	{"kmalloc-16777216", 16777216},		{"kmalloc-33554432", 33554432},
> > -	{"kmalloc-67108864", 67108864}
> > +	{"kmalloc-1k",           1024},		{"kmalloc-2k",           2048},
> > +	{"kmalloc-4k",           4096},		{"kmalloc-8k",           8192},
> > +	{"kmalloc-16k",         16384},		{"kmalloc-32k",         32768},
> > +	{"kmalloc-64k",         65536},		{"kmalloc-128k",       131072},
> > +	{"kmalloc-256k",       262144},		{"kmalloc-512k",       524288},
> > +	{"kmalloc-1M",        1048576},		{"kmalloc-2M",        2097152},
> > +	{"kmalloc-4M",        4194304},		{"kmalloc-8M",        8388608},
> > +	{"kmalloc-16M",      16777216},		{"kmalloc-32M",      33554432},
> > +	{"kmalloc-64M",      67108864}
> 
> I'd rather use KB and MB suffixes or at least capital 'K'.

I like k and M better.
