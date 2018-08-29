Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6308BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BE020867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Vhjcvvke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BE020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeH2QCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:02:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38453 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeH2QCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:02:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id e2-v6so2232652pgv.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NYCwXEidj3pw6nO5Zzfs+c6VqCId/sEQiDDp9hMagzY=;
        b=VhjcvvkebrP+Zr/0xhocR5xbbdYuW1ClyT4fGBfO2qm6ALutgxp1BJBt9oghMwgp3E
         MKkwf6zjU9SxO97rP4DZW71vVK2XEJRtXlMtxDnaXZEHdPyMu6N0xnkmyQrljtcCWsaN
         PX7tSn65S5KYF4pxomgjtNAsGBAYMH1IBT0VeEfSESWta7VYmUY3ZwJeBcOfTEXvajpi
         xOHwueoDyafS4iozKI1MfJ0nwkpwG+qEpgEqS41/GEY3IDLKGtuabFCupZW/udWCgFAJ
         Lz6GEaBebivt5/6pW3wYN6d3bMvenqVfeoNObMjHYjUHkLz1gC2jiaH9CdLxWXQLhMWI
         LcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NYCwXEidj3pw6nO5Zzfs+c6VqCId/sEQiDDp9hMagzY=;
        b=lLbOILTuncoPrvQ3XDH62xfhKnlIEVAfFbIABobt1g/3yOjscgGDaS+/yKi28XqO4d
         X1CcNqeDkY/0TJGoMtb3Ansn6Aomg6WLWRPWd6/iBKxyHxIJ/GTXiWKATktMGW36m9Wh
         ofikbADpiVO34jO2/ggfnkMQCy4ZRdfJUfC0lfk3hQgfQefTXjvsDPDCMXVa91Z1eQ8I
         32j0YeKB2ZgcwGenifCQJb7U8ofOEZlrvSZ6JsocPKEJWq3nzAdJkV9Z4c/v/kRme4bx
         vpRAUIic1qo5mzCudNJ3fZS6/vYmKbknqW97OZ9ARXVdgzRhEAHd5WOMgyuQ8ZkzwA0H
         WUiw==
X-Gm-Message-State: APzg51ATZqI8EyCj9U/P+MM4OUGdtqDJNOVW4GyAWL5ggU5xEeZNJ4N8
        HWzy8hWcYWPNRDYfstQcL3iRlA==
X-Google-Smtp-Source: ANB0VdbsI/jLun9Miov7AWXA4MiuCdFN2rD5P1maV9U2D3obdfK+5X3pggo/9eglDmy66t5+DrT28A==
X-Received: by 2002:a63:b19:: with SMTP id 25-v6mr5537363pgl.301.1535544335656;
        Wed, 29 Aug 2018 05:05:35 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id n24-v6sm5755092pfi.161.2018.08.29.05.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 05:05:34 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 3CD503001A3; Wed, 29 Aug 2018 15:05:30 +0300 (+03)
Date:   Wed, 29 Aug 2018 15:05:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm/KASLR: Adjust the vmemmap size according to
 paging mode
Message-ID: <20180829120530.6dhgsautjjrj4ztt@kshutemo-mobl1>
References: <20180829021754.21850-1-bhe@redhat.com>
 <20180829021754.21850-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829021754.21850-2-bhe@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:17:54AM +0800, Baoquan He wrote:
> Vmemmap area has different base and size depending on paging mode.
> Now we just hardcode its size as 1TB in memory KASLR, it's not
> right for 5-level paging mode.
> 
> Adjust it according to paging mode and use it during memory KASLR.
> 

I think 512TiB is wasteful for 5-level paging. We don't need that much.

1TiB limit with 4-level paging is required to fit struct pages for all
64TiB of physical memory, assuming each struct page is 64 bytes.

With 5-level paging the limit on physical memory is not 512-times bigger:
we cap at 52-bit physical address space. So it's just 64 times bigger and
we need only 64TiB in worst case.

I think we can limit it further by taking into account memory_tb. Most of
machines will be fine with 1TiB there and we save few more bits from
KASLR.

-- 
 Kirill A. Shutemov
