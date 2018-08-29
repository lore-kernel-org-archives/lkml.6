Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1702C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A765120850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="KVwPJtof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A765120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeH2QXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:23:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40054 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeH2QXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:23:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id s13-v6so2197020pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eUIek8UlmxHeMhucPIvkcoFkmlt+KCBWfQhcIeFGEb8=;
        b=KVwPJtofxG6Lw/49x95GAHLtdIB+7fDBdiTSQFQURk9B19LUVGdVlpeD2Q9y2i7Pul
         TU9/t+u7tiS/fkPEo6YhB4tN64WAYyTCUPpBkUbRv9aoykb5Hiyya3Kps6MeGWYx2jkz
         9eplFb9QLO+iDVbWvirSq/w1sefU4HtSqqGqEEDgfKpZB0APy8UxcT4zNta5iAb/Dbi2
         QeBczk6ysIpcfmVzbwifTLQqhytOhLODZQAZrjYFrgv1ibWMQ+LCeiNbBvLWkOHwGT9h
         l4c557CWK0ZeGmZXH32MQOo8xSyatlzj0bOiexmc/+euYdmH/IqdyMBAvXVwunxSj+N4
         uvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eUIek8UlmxHeMhucPIvkcoFkmlt+KCBWfQhcIeFGEb8=;
        b=BffruFlZK8Qc8pO6n7Q0WdUx91hgYUraEPQkfooY/ISYojYku9l9IJcwbbt3UUWuhu
         ryoS34j+0sgpkmxhOkKNqMKf61QqBBjCLQ9CleY2BsBlDhWsmjbva2xslDXIadzWeupe
         Oog/IkW0E71zk5Is9BOxMRl99ocu6hjd5uuwSaaGireuMZGpELyYBIeaxJY28E/ZLpB7
         P64yaH0qN5rxG89Tkfgv7YzYqk33seH8cq5h15LKbTOQP/fHeC0CsMWXvZbN+I3dvcX1
         TTU9Hr+XEV9TGf4GICs8e9YJDBOJKWP8kr4+SyxpVgAJ2vPuBVXe0RV+lDNAERdtS5R+
         X4CA==
X-Gm-Message-State: APzg51An3A3mU9zBxBnKdEcgL+0Owdzd6AYI27h6TS0tq26qNnJc+5WW
        KaUfG6XuUQc0r9bi0ETT+5L3FQ==
X-Google-Smtp-Source: ANB0VdbzrHYXw0p6lujzV2MYG4wHAyCcOuCLH1HYNwrdN59hBj6/xwzIwFMl4OTAymPivbWIQgf+Vg==
X-Received: by 2002:a63:df4e:: with SMTP id h14-v6mr5581337pgj.300.1535545612712;
        Wed, 29 Aug 2018 05:26:52 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id v7-v6sm6492468pgh.57.2018.08.29.05.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 05:26:51 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 42D743001A3; Wed, 29 Aug 2018 15:26:47 +0300 (+03)
Date:   Wed, 29 Aug 2018 15:26:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm/KASLR: Adjust the vmemmap size according to
 paging mode
Message-ID: <20180829122647.pbe4uexc3h7azvxo@kshutemo-mobl1>
References: <20180829021754.21850-1-bhe@redhat.com>
 <20180829021754.21850-2-bhe@redhat.com>
 <20180829120530.6dhgsautjjrj4ztt@kshutemo-mobl1>
 <20180829121856.GB1885@192.168.1.4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829121856.GB1885@192.168.1.4>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:18:56PM +0800, Baoquan He wrote:
> On 08/29/18 at 03:05pm, Kirill A. Shutemov wrote:
> > On Wed, Aug 29, 2018 at 10:17:54AM +0800, Baoquan He wrote:
> > > Vmemmap area has different base and size depending on paging mode.
> > > Now we just hardcode its size as 1TB in memory KASLR, it's not
> > > right for 5-level paging mode.
> > > 
> > > Adjust it according to paging mode and use it during memory KASLR.
> > > 
> > 
> > I think 512TiB is wasteful for 5-level paging. We don't need that much.
> > 
> > 1TiB limit with 4-level paging is required to fit struct pages for all
> > 64TiB of physical memory, assuming each struct page is 64 bytes.
> > 
> > With 5-level paging the limit on physical memory is not 512-times bigger:
> > we cap at 52-bit physical address space. So it's just 64 times bigger and
> > we need only 64TiB in worst case.
> > 
> > I think we can limit it further by taking into account memory_tb. Most of
> > machines will be fine with 1TiB there and we save few more bits from
> > KASLR.
> 
> Oh, do you mean to make a calculation according to the actual size of
> system RAM? And still taking 1TB as default, then adapt later by RAM? 

Right, actual system RAM plus padding for memory hotplug.

> Then, no need to introduce VMEMMAP_SIZE_TB, this also looks good to me.

There's a tricky part that we ignore now. struct page might be larger than
64 bytes depending on debug options enabled. We may include the actual
size of struct page in calculation.

-- 
 Kirill A. Shutemov
