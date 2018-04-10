Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836988-1523365645-2-6901053484492101509
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523365644; b=EWGKm0MOFLxN44fvTO8kJeKtgkoUFUzLG3FrR9oVJ5P5vCDFDw
    XwZK1uvs7oq39u26BbFF6SCJio2NoH7DFuz5XcfYOUYfujhBQBy2GlO5LnAmG4tA
    gBA+joNbe8l+qaLPPywPNCu8MUH8u0HsOrB/2u54sBgq5fHyt2f2qBZMZVLCVt+Y
    p/jaGU0ONFZ8JWSdg8ngt7f0DxYDhww6jeApx4MZ24EwzcjxgkopQkEJkCqpxX3D
    lFG5smuJ6MjbfFrS8CPEs4Imix5S0tdCEj6kwNSBXrVArVC09N9z4U3QET+ElDHx
    F1H9bdSLo8tsK4Tz8P4j1ZaZRQRY7uiNzcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523365644; bh=dIKbYe+gTrcof2J5fhGCtbWdBzRQPT
    xr6l1axsHRNJE=; b=bEa8IU+vr57438ig1r0TMz7VPXKxLL1VRW69a4vvhciTXH
    +jQQlG0owffXVUj7kdBsurLXUr5dyWKE1oaijPVdeQNq9eMit3eDZ/I6sSht2pbD
    FPkGjDXhhYVHCRonFIP0CQaptpINkN4QXdMSn00X9v1ccRBnX/xnWz62dhI59Qpl
    mgAhTPwJxTXFIa7aepQ1gjAH5vJ4lCExKa4WNIzY3ecR7XxcgTzXkds/dG4YEuE7
    xC1NPeingsOVririS27sk9OcaTUbbNUZsT4Nta3SOfb1JhVdWZDXBO/DLXrHb+/h
    Jzuwd+TRozlo4cI9CEHalYIbJDa22pzpT3uypoag==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=jfwr8kHu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=x;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=cmpxchg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cmpxchg.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=jfwr8kHu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=x;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=cmpxchg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cmpxchg.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEpT+mfrQrpUtgtFghXwjryko1e90Zzu8oIRPCahHLC7ZxjDGSKrnCch1/b81m0NSKWPlCa9kaDfQhx2bANlrP8UWzrsKTHaov00Eef2gcc5/I0kYyf6
    /pitbXwRL5lqdAAPboSiDU50NKg7wkfZMnVn7oHK6UFDoBAtJe6JRwFSHTkOWSR8mLHLZapMOQoTGihwLQDFXENIPOCDh8zZ6I6lLAFsj6N7IRDPgQ47nYnp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=ufHFDILaAAAA:8 a=aC5eC-Sa5YakOoIEPgEA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeDJNHV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:07:21 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:50970 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753181AbeDJNHV (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:07:21 -0400
Date: Tue, 10 Apr 2018 09:08:30 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] page cache: Mask off unwanted GFP flags
Message-ID: <20180410130830.GB7010@cmpxchg.org>
References: <20180410125351.15837-1-willy@infradead.org>
 <20180410125351.15837-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410125351.15837-2-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 05:53:51AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> The page cache has used the mapping's GFP flags for allocating
> radix tree nodes for a long time.  It took care to always mask off the
> __GFP_HIGHMEM flag, and masked off other flags in other paths, but the
> __GFP_ZERO flag was still able to sneak through.  The __GFP_DMA and
> __GFP_DMA32 flags would also have been able to sneak through if they
> were ever used.  Fix them all by using GFP_RECLAIM_MASK at the innermost
> location, and remove it from earlier in the callchain.

Could you please mention the nullptr crash here, maybe even in the
patch subject? That makes it much easier to find this patch when you
run into that bug or when evaluating backport candidates.

Other than that,

> Fixes: 19f99cee206c ("f2fs: add core inode operations")
> Reported-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: stable@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
