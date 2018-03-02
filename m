Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519978702-2-2399945135357868535
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
    t=1519978702; b=FxJMleE4argLGhkgyZfLzft+NN+Tb+NWC92GhlBfdr/4r5t
    MQ4bFtWPL95shPcD2A8Fb976hoQ19ZdeMP8mVVrvpFE1u6ScaTCyGdKZY1Ajee2h
    J4/QQU5JJACh3vP29o8PaeT6EsLXxzi0UHEsEnMoEv1xwaWauXgxxHOVZY2r1crz
    dM3YG43ZC6IX32wm1zGQpznB74KXnIWkAQNce00b4DhVW9x99Z9M2Kzvef7oYQX6
    +8bb8/2FrJHDliTo34mHRgV4uMSxJp2EF4z7ErHNdNU/1at3MZFybcbw8U014gDE
    hXesPrT6HACPAfu5iO6WthfTdJnctwdr2yoxpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519978702; bh=x3LkS5yQVeSk2x67wzNrqzOWre
    lHvzUVdwP7Znj0jzM=; b=AZ6EPPfu3jVYwIG7nBt2xg35BN55CWrgrGMSP6jfVZ
    1DVSgkvhxduJ8pqGVEdaKOULbE3hDVLHE2kIUugVEmwUPzAKwPKhmfWVBw/zL9o8
    jecegD1O81VpsSJxjDhMIORmrzfW+wn08Q3zLPHs4OPxvFIf9ec2jGl2a4+fGdfc
    1b8xVKtDvbF1XddpB4e1kXKUTae7Nu7Rl001gMtFXv12+9VUwVzuyx5qKEeX/PrM
    /sWNatkn42fmXNiIQV803rBdJxMIjdRMl3smweU1LHKZhJCwykBrAKjnDfkHCs5J
    +TWlXGyiVguef7wGMmPOvM6vNGL77qdcSAKeCFNUEa3w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=q7z2NGf+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GF/8gIT7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=q7z2NGf+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GF/8gIT7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164770AbeCBISU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:18:20 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36091 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164634AbeCBIST (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Mar 2018 03:18:19 -0500
X-Google-Smtp-Source: AG47ELvifn5yTKYAbrzuamE4j0jK7tCb6p7yMYn7VlRELPLciRuQiEaHvGE4/4QPQNjgD6VaIvrGPA==
Date: Fri, 2 Mar 2018 11:18:06 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 2/4] mm: Split page_type out from _map_count
Message-ID: <20180302081806.aokjrb27hxqki7at@node.shutemov.name>
References: <20180301211523.21104-1-willy@infradead.org>
 <20180301211523.21104-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301211523.21104-3-willy@infradead.org>
User-Agent: NeoMutt/20180223
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 01:15:21PM -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> We're already using a union of many fields here, so stop abusing the
> _map_count and make page_type its own field.  That implies renaming some

s/_map_count/_mapcount/

and in subject.

> of the machinery that creates PageBuddy, PageBalloon and PageKmemcg;
> bring back the PG_buddy, PG_balloon and PG_kmemcg names.
> 
> As suggested by Kirill, make page_type a bitmask.  Because it starts out
> life as -1 (thanks to sharing the storage with _map_count), setting a
> page flag means clearing the appropriate bit.  This gives us space for
> probably twenty or so extra bits (depending how paranoid we want to be
> about _mapcount underflow).
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
