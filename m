Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1080424-1519978830-2-6911794090467525760
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519978829; b=odPaCBB5Jdqb3O+EUqsbjS3msG91usUCigqGFee620HoV8t
    yUGC7+8WdG50Qnd0LnZdiB6pvUkyYHjTU9TDfk05GduBqgNVU2AjES1EHf/o3tVD
    EFdOHwU1RgXSSYb4Xa6puyHWp089iVFHt3BUdDqETuW4uEmZTKdHfgnVznWF90H/
    UEOEd1cdecPhgcfyu/xC2q6NCqA2gezWTdy0MZNA43wWq6WJRcG14r2P0iYhPvbQ
    D7bzcQk1Xl5WZACmFcTLAOpj55TO5AqLFRSj5ChI5lwT1SvBnv5ATDuuPQSs/wWC
    H/YVK26RyICVZ7rULFyQPFR9m/gABHfE/fbXmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519978829; bh=J1N7XAWDzZd43Y0Woan9iBvjW8
    9c345N0dlMnlTqdGA=; b=pjpRqbUyaX9eQhDqfOovVq/t+L25ZxIivPiv/ScM9I
    5LHdRybstotI6y6rD9hHKqeNS0wJqsBRW+ypR75mtgeI4j1P3DnEqIQJxc05f101
    +HsOohZfRcTWUZUzvTPo9p1vcN874qblrtmwqBQ2f9CAR9qHAlPKClQ+vAsY16Wf
    fxYfVI/CCMHGFW9dWhfHI9o0KlGKT75ZHN32zSkbarst1sC81dmtukGAX3H+sTHD
    BpwFaub4YomxDmlC9UFlSb6gyN97wucn0dIUlJTbvwJkQQr5K1rRiBTX8RMfim3h
    6JtrA+nSaQY+mxdnssWRTqsHnLeC/HHcw3x5aFQB2SFw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=2TGRxKEW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NZJ4FXbm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=2TGRxKEW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NZJ4FXbm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164789AbeCBIU2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:20:28 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33501 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164680AbeCBIU1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Mar 2018 03:20:27 -0500
X-Google-Smtp-Source: AG47ELu7pXo18R1d/1FcPOFXwKhZENNaVkEZECkhm4vm05+dsoYiKcKlkAynM38KHLYcowqhyg/5TA==
Date: Fri, 2 Mar 2018 11:20:14 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 3/4] mm: Mark pages allocated through vmalloc
Message-ID: <20180302082014.4zlhvot6lzg75x66@node.shutemov.name>
References: <20180301211523.21104-1-willy@infradead.org>
 <20180301211523.21104-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301211523.21104-4-willy@infradead.org>
User-Agent: NeoMutt/20180223
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 01:15:22PM -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Use a bit in page_type to mark pages which have been allocated through
> vmalloc.  This can be helpful when debugging crashdumps or analysing
> memory fragmentation.  Add a KPF flag to report these pages to userspace
> and update page-types.c to interpret that flag.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
