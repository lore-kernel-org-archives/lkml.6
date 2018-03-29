Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-551127-1522320968-2-2739088381776358568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522320968; b=ZhIZu51Tznh4ArUs1Dy9GY2gleycmM24BuqA0fQ3FIRJjChyKf
    LLsVrXWHOBr7WCl45sy7/SrDRnEz6bWUPt6hPRAhjI9inpbS4QsB3mm+paXvP67p
    +cWI5SHK8HqWraMwNWEBy+NMUeFmb/GREPVsy3smi9Xi27ZtVH9ofFpWiNbjzPZP
    HL+Yp9giEmlhYXLod2jVtRF5Z9eo1tYX3YpqIDn2DyXLqCXSdmOkQSQJw7bnBUTw
    F57B+ceoIqLGaEnUR/7cbI9N2MJfah3nQ1qRnwpoQvW+ZQBHKlzNBonqajww+ew8
    GkRmKRa5WEYhvjBVsvif9K5HjTDwno4NVEJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522320968; bh=dL/tlwGZp9bx8UblrjIF9vfMB83OOx
    GksgaIz38rFko=; b=El/VbjGkbk90kLRT4NKPxLvB4oN2jJZF+KEDQls9tuuW/i
    0Z/Z+ZGhFztUmL2Saf3uxsT2UmBdp6nurEWU9qYmuGLyKyTLOV9IOtmsFepsszU5
    lyTNnnhgxRaYnSbaGab56t/wx8tDMjmo3nBbaDJYWJLCkqvm1e2ToYl9BMV3gQo4
    g9SdKRBxGhxrRnA6gSY/utRZnoXLbOCPrSANUYtjNqwVlpuOZuPq0rJeENNPgEWc
    KwnZkSkj5Q6jolWsEkA0HluK/aj24+8eQn9Hc2K2jUOb1DqIlsbZ4FpvM659iuhq
    6zbgnug3DYOo5yq+Lz9Detdk66GJE+MWq3JrHmuQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YSYtw4Yt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YSYtw4Yt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAz+SXvh6b+5YjFXTZ9cNJhHaNkPkiV4hCyxPUIYj8hP8VlLBRZZXRdQBLE0ftyyEhbbE0Jy76KST82UmWlV1GCg/g2T2cnIf9VXigWCAd18gGg/bNI+
    8qdS/xcxmrvalomP7rraW7r+lc+w8SAs29zBMqrj5+l17KmtmRGS7X3U8hqLE5BSpMttp6SCjIjhn4tswqMNfOpD1f8hgEeSABbI/aJ58/R/VFmR92uFX5K+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=nOlvpsTn5Fq-4zXP1N4A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeC2K4F (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 06:56:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbeC2K4E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 06:56:04 -0400
Date: Thu, 29 Mar 2018 03:56:01 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH] ipc: Remove IPCMNI
Message-ID: <20180329105601.GA597@bombadil.infradead.org>
References: <87woyfyh57.fsf@xmission.com>
 <5d4a858a-3136-5ef4-76fe-a61e7f2aed56@redhat.com>
 <87o9jru3bf.fsf@xmission.com>
 <935a7c50-50cc-2dc0-33bb-92c000d039bc@redhat.com>
 <87woyego2u.fsf_-_@xmission.com>
 <047c6ed6-6581-b543-ba3d-cadc543d3d25@redhat.com>
 <87h8ph6u67.fsf@xmission.com>
 <7d3a1f93-f8e5-5325-f9a7-0079f7777b6f@redhat.com>
 <20180329021409.gcjjrmviw2lckbfk@linux-n805>
 <3e201de2-bed2-6f7d-0783-700d095142e0@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e201de2-bed2-6f7d-0783-700d095142e0@colorfullife.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 10:47:45AM +0200, Manfred Spraul wrote:
> > > > > > This can be implemented trivially with the current code
> > > > > > using idr_alloc_cyclic.
>
> Is there a performance impact?
> Right now, the idr tree is only large if there are lots of objects.
> What happens if we have only 1 object, with id=INT_MAX-1?

The radix tree uses a branching factor of 64 entries (6 bits) per level.
The maximum ID is 31 bits (positive signed 32-bit integer).  So the
worst case for a single object is 6 pointer dereferences to find the
object anywhere in the range (INT_MAX/2 - INT_MAX].  That will read 12
cachelines.  If we were to constrain ourselves to a maximum of INT_MAX/2
(30 bits), we'd reduce that to 5 pointer dereferences and 10 cachelines.

I have plans to make the representation more efficient and bring
the specific case of one element with a high ID down to one pointer
dereference and 2 cachelines, but I have not yet had time to implement
those plans.

>From a memory consumption point of view, 6 layers of tree will consume
6/7 of a page on a 64-bit x86 kernel.  I'm aiming to bring that down to
1/7 of a page.  We get 7 radix_tree_nodes per 4kB page.

(The old IDR tree had 256 entries per level which would have taken only
four layers to get us to 31 bits, but the cost was getting only 3 layers
per 8kB order-1 page, so we'd've taken 2 + 2/3 page to accomplish the
same goal).
