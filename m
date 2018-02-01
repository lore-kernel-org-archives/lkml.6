Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-278363-1517515094-2-2571620385291079962
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517515093; b=ZflG99kNk4zzlguxABTVPZO5KUXh1hoeEU4hiknHRYDI/tF
    +VjIrQsZtoF9dO6DFq0o9gzHeWNt2u9cPaMVTBQo6+/KQGxb4sJRUlGOQVLYYN6b
    GpdLlujLiKbOcC5cDL7vD79jmSxcx0A83YuAXaisFnbcqa6zHyAz/E2hfxx84OTR
    XkJiQ2mQP3I7pXwDBXm4rs+AamEBJOVybdo9Rwdt8xICJKTH7h2h58vkX5PVeahw
    Yeg3et1BdIzKBWCrcIDcHAW90CoZeXZVOVRxmR86yncvsEeM1v5uUSCwjDEhGQy2
    mxIwTsJEuOyey3mfW9Yx814x7hUEAnniWcTF2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517515093; bh=UEZXVMsWcQmpBrcUqpLjBAUUDS
    bgb6OeeiQnwWVFAk8=; b=wYHpTcDxpbkJh6b+KBkRuBrBsu8W2WR1ixEqh2tgmk
    e5PSgrq4SXwmTjcMNVlRglHazIkV/8YImsbQ4NUzMFr8mvY2DMG87/5f3l5pkSdS
    wZqBH3hf+GVjSnIh1aSGx7fGEM8EOFiOdnVSsO1aIdAARUbBoTLeK4S5oNwVDwX0
    sP7GRqU7mFfAvYocnSocJjj0NwlOBgmQkfnJzBm96d/4Yr9VD5TlaLYGeTwfIyFg
    +vJ/1BdzuTSGW7DEMd/odcxuwMjqOw2saeisGJ4TtKxZH+DYKOtqMP7u/8nACbfw
    fPjlye+r9iXr79mqJBfqFgoEfFqAGTtTUYpdCU4q16kA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=tsv+Ur4L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=tsv+Ur4L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754857AbeBAT6E (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 14:58:04 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:47353 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754594AbeBAT6E (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 14:58:04 -0500
Date: Thu, 1 Feb 2018 11:57:57 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/kasan: Don't vfree() nonexistent vm_area.
Message-ID: <20180201195757.GC20742@bombadil.infradead.org>
References: <12c9e499-9c11-d248-6a3f-14ec8c4e07f1@molgen.mpg.de>
 <20180201163349.8700-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201163349.8700-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 07:33:49PM +0300, Andrey Ryabinin wrote:
> +	case MEM_OFFLINE: {
> +		struct vm_struct *vm;
> +
> +		/*
> +		 * Only hot-added memory have vm_area. Freeing shadow
> +		 * mapped during boot would be tricky, so we'll just
> +		 * have to keep it.
> +		 */
> +		vm = find_vm_area((void *)shadow_start);
> +		if (vm)
> +			vfree((void *)shadow_start);
> +	}

This looks like a complicated way to spell 'is_vmalloc_addr' ...
