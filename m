Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519978934-2-4279958001434171862
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
    t=1519978934; b=g3xThCFhFKgj4DZ+UmThWfGZi1r+9F940XmrjrdhVLUsROZ
    NQ8MhIvXbY+9zV3CaeV5TVlgROGSBystv1eIn2nPBK2L/nYDHXyLGffnnYI9A/du
    5WAkYW3Y7UsacUB5v0+wTbj5j8Eo2z2M2UdSxM9I5ykJIZc7w068jIYU1BMDuFha
    uKf0RFxIp9sDPjh+SE8bLUW2IimpJf8wwPooGzNkxEt+LqCHfCwRTIKzASc4zReg
    3i+jL22ybT94tno87+v7NgGvsNY6aKh6mJkeoNhE/iVD1T8FlqH01+K0WMV14BxN
    MpFxcJKM32H5CccE8zxAAyhD2LNierCRl1S8gHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519978934; bh=PzCQTeQcQ3UvLWRSH9g8BnnCpq
    P7SkSaa8IyRvrqWX0=; b=hp1Ejtw6l9lrNur7R8Sb7mboofuhYXP/nsPxdd6A8U
    /Her9pmjP/gLs9bj1UIlas8FMN0j4uLs3h4/qyrHtanvXoFu2pL5dcBOU2s0xEBq
    4/FXB+yOVJVZG33MQNM9kuvropQWSOMuU2HWC4xH4sWsfLGy8bFki+UvDPphD0aK
    mW6Fo1d9wQy70J9XHvECJDXgW0F4QZcfdPpQMaAjiAD5C/sDaTIIz81Iae+B3udn
    6uhik5EnsQICjzfoD60K+LsoDfS2bZjdkuDCQrKDtNnHocs5zo/qO5xKpP3GSpxW
    FHOiMB7zBOuefRWww6zG5FPWiFZIo7/oFrJ+KhhfIz6Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=RIEgaK19 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AYveS2Bl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=RIEgaK19 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AYveS2Bl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422856AbeCBIWM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:22:12 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54372 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422853AbeCBIWK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Mar 2018 03:22:10 -0500
X-Google-Smtp-Source: AG47ELt0AY4R7tZpjzdpCSMS0RALzLXIK9jg+L7MUNFHPHhYmmM0TaPq0WwhAAcrjU5m38mDSW0PKw==
Date: Fri, 2 Mar 2018 11:21:56 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 4/4] mm: Mark pages in use for page tables
Message-ID: <20180302082156.ty6nchnmwpniicyb@node.shutemov.name>
References: <20180301211523.21104-1-willy@infradead.org>
 <20180301211523.21104-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301211523.21104-5-willy@infradead.org>
User-Agent: NeoMutt/20180223
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 01:15:23PM -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Define a new PageTable bit in the page_type and use it to mark pages in
> use as page tables.  This can be helpful when debugging crashdumps or
> analysing memory fragmentation.  Add a KPF flag to report these pages
> to userspace and update page-types.c to interpret that flag.

I guess it's worth noting in the commit message that PGD and P4D page
tables are not acoounted to NR_PAGETABLE and not marked with PageTable().
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
