Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2424450-1527188908-2-6856926277813389796
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527188907; b=autVwCJoNPk8si/DRJHhF6XctjXdm1AepXCXsQlyn4jiS0QZLR
    2qK13CKRfBIF0c8vIRwoe4CnJ6xhfs7tC8ODPIWkwJWoPFMw2X+FDMwVPMrUohYm
    WNTEiFIph8eIJqvcyu8EdAQs57MX6T+YJ6Pr1fKKXRALc0et7N1i0KA1x/CILi63
    sUvl9RVcfyMJfhQn1Yr61SxmT4uRl2IGjAEgWT+DpoKg2IE0c+/wFSFcdKFDDAGc
    nbDLgWLP7kEAsPi/oB0bnprmFWZ/c6K8uIF0xIiLq0+ExTXas92PhY8PJyvZ3eQU
    8TuGFIyfb/ig19fFo0VpJxeZFYNqx+Gf06Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527188907; bh=31g+1kOgLm3vYS6bGAEZZBeO6wxhPC
    qB246A04hw3HE=; b=IGIa9/B54DOut4vDiPVwhDjH5zTfO/a/lkgmgP1qE6Kyu+
    BSdPw5Q0qY3HDcxXBjgVZGV4l6ot7/AksDneMg56LqgxyekuKJLEPlMFycbJ/OG+
    2uiazff7MH4c+EEgAKx5WWVElUSheVDNOpZ0oJixFsW8wRWO/SUG119/7zgDRYpR
    F7SvkWu7R131cKtY8QkRB/v6jeW/QZ8X8Gq2DdlpZ3clERfEnIMRez2tMjmHCZGY
    KfJxNGlY1O/PQSLB0cuWepNkeewADssNOsAYP/x7w0SILXPCNu6U96kv5X+dOpTS
    dsxzjwKdtR/14miPNAU4AJZufxAXBxsBbE1Vuq7w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=stgolabs.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=stgolabs.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPZkgpctvh2NeFaxYGMkwXjsIeMi0ufdRpwJS+jKF0CEaNyREH/tbKsZfdBuQsluXsQTxZtVyhx/KGNEKRTB2mkGG+yTX3sZ0dmpDBuHHJbPyDgHflCH
    eOPPf/Z2u7u2RzanCrsXWF9zyEpk9Gb6H1M66SkI6VWgY7VDmsrOoll/qKIH7v9d8VxbOLkkeayYm3iwEeUvVeLEZfMHvumApj+fd/vzPVQ0/YnJuDNvKkf+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=RYMOejngr5RU2EfprLAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034452AbeEXTIZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 15:08:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:33743 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030244AbeEXTIY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 May 2018 15:08:24 -0400
Date: Thu, 24 May 2018 11:51:55 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        guillaume.knispel@supersonicimagine.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: semantics of rhashtable and sysvipc
Message-ID: <20180524185155.3bx4ujgz5f5g3epi@linux-n805>
References: <20180523172500.anfvmjtumww65ief@linux-n805>
 <CA+55aFwAtfiMa22-OFGf1dNR8CNzSKjjLLj5UL-HqgapV7Tf1A@mail.gmail.com>
 <20180524170700.wblnybinjzx5rwky@linux-n805>
 <CA+55aFwhkOnHngHpQ3wif5iy7PtOAVdjTcwce=kgBq0TCgmfJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+55aFwhkOnHngHpQ3wif5iy7PtOAVdjTcwce=kgBq0TCgmfJA@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 24 May 2018, Linus Torvalds wrote:

>This doesn't seem to be taking 'param->min_size' into account.

It was in that rounded_hashtable_size() does, however, after more
thought I think we can do better by taking it much more into account.

>
>I'm not sure that matters, but right now, if you have nelem_hint set and a
>min_size, the min_size is honored (if you have just min_size it's already
>ignored because the rhashtable always starts with HASH_DEFAULT_SIZE). So I
>could imagine that somebody uses it to guarantee something. The docs say
>that "min_size" is the minimum size for *shrinking* not for initializing,
>so I guess it's debatable.
>
>Also, wouldn't it make sense to make this all be a while loop? Or are you
>just depending on the knowledge that HASH_DEFAULT_SIZE / 2 is already
>guaranteed to be so small that there's no point? A comment to that effect
>would be good, perhaps.

Yes, this is why I didn't loop. With the default size of 64 buckets, we
allocate 640 + 128 = 768 bytes for the tbl and the lock array, respectively.
By halving this, upon retrying, I was relying on it being to "small to fail".

However, after how about the resize being based on HASH_MIN_SIZE instead of
HASH_DEFAULT_SIZE? That way the initial table would be a _lot_ smaller and
aid the allocator that much more; which is why we're here in the first place.
Any performance costs of collisions would be completely unimportant in this
scenario.

Considering that some users set p.min_size to be rather large-ish (up to 1024
buckets afaict), we'd need the following:

	size = min(ht->p.min_size, HASH_MIN_SIZE);

Which takes into account the min_size = max(ht->p.min_size, HASH_MIN_SIZE)
which came before, thus p.min_size == 0 is already taken into account.

Thanks,
Davidlohr
