Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517592889-2-17020843477241998565
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_05 -0.5, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517592888; b=HnmHdSNWlEXroswETFK5psaWhzbnUtpD4pXxGqN+fYwzRCS
    OwDyQxa0cWUUs3uXddrPB3MeOKyfRi8uiQVEvyYK/RgIjEVnqq857Zbije4vHBvM
    1T43y023fJPtiEZmZsMbLNxfDlvecJsHOtGrZrip4uUhUnhHnGAN3bbxHgAgwN0Q
    Bc+X7yj4ImAg1aZ4tjlvd29m1z1n64ZB1S6yx2IKjfZkt0BbDfzYzP7v8NXWyLeM
    6oKeRqQvEtHrNrs1voG5MJNahUcVSl8eURQpFBQkdcwLfh3gWTO51dL83kfkFUbv
    vHneQqU4Fg0UrIqXpky40YeJKRBT3ta2kfEnh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517592888; bh=LGsiEmHZQxnIv4PCL8lI+jVrZx
    ONP7d3IWdbXE6/HRY=; b=D5HcDfes+j1/wLJTbhJ5P5HcTklU3vnVt/CKRBde8c
    gjTIJ/jA/wROK2LnnCp35bydClsDbt0G7rse/8g+ne8BlUTUOgmDO19kTz/3iG5r
    HnC+u/uWYme7Dn2rYZKkydu2knJDXFiYuohvxlMg4s7f/3BpPo9Vz1ckRpMNGLlQ
    TZKRLMqpNT5moKkugqwIkVVO2hRh/DszptfpTHDjFB5HTSi3mi6EnPNIPfJgxhnl
    WqPRzo+cUhKDbvy24FtyHO/c4kDA2bYDtQNUe8ocn7xWVopQj2G4v1/CUAIHrhlU
    7ycrW/GYQSzQ06tl4AFX8uUZMSCoAya4c4twqr9xHRsw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=T5CupFk6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=T5CupFk6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeBBRUn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:20:43 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:51597 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753888AbeBBRUh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:20:37 -0500
Date: Fri, 2 Feb 2018 09:20:27 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/kasan: Don't vfree() nonexistent vm_area.
Message-ID: <20180202172027.GB16840@bombadil.infradead.org>
References: <12c9e499-9c11-d248-6a3f-14ec8c4e07f1@molgen.mpg.de>
 <20180201163349.8700-1-aryabinin@virtuozzo.com>
 <20180201195757.GC20742@bombadil.infradead.org>
 <e1cf8e8e-4cc4-ff4f-92e1-f6fcf373c67f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1cf8e8e-4cc4-ff4f-92e1-f6fcf373c67f@virtuozzo.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 11:22:55PM +0300, Andrey Ryabinin wrote:
> >> +		vm = find_vm_area((void *)shadow_start);
> >> +		if (vm)
> >> +			vfree((void *)shadow_start);
> >> +	}
> > 
> > This looks like a complicated way to spell 'is_vmalloc_addr' ...
> > 
> 
> It's not. shadow_start is never vmalloc address.

I'm confused.  How can you call vfree() on something that isn't a vmalloc
address?
