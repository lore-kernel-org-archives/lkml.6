Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2956902-1526406423-2-9957768454484158717
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526406423; b=he/gO71/S+x7rP4IHTX4waX/yA0AUPE9u2qHL1NIoglzG0IP3B
    fzGxp3Cg8hpxMeMHPedrHHb3q+u8mTGV0g/RUz+aLiQGrqMVKUPnKe9BScYTj0Bv
    jMg2oaqsUjwO1i9y37UXxXWM+au6DoYOUlIctNaKIpur749lahffMSGjx/zMPhxW
    NS2SGRr1SL1gZjE31J3g6VQkcB3xaXm6aSOWG1ep4MX0pGDSlXO3wezt3JFZSW2j
    k6eT31PrNE3lhpEMh2sdn5eTGr9ZLFw2vB79CtYYRbrgsGUjR1JR24ayPTGCHrfB
    onevBbXqWDtwh+MUsZ8YL+vnB6XjPimCXVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526406423; bh=1+2cH12ImSVoNNcAhnNbBJCnudBtAw
    yoJSamIIf1Nf4=; b=jteeE66r4t6X1j5Hzq7mg5TAD6OXf2UoHSyD06XmUCQETz
    kEh1XyZ3dnzXlGKQNpzdCEatjrd8S+B4Y8Zh2QKTSmkKE+I+sRaX97xl2/307wbO
    5O01uXexx9FFS4VQLgtWXvgtGdoUwQOjzmsATArWbT6eiew0sr6oRYGfclsTPluM
    Oe+YuRbbxt66ojlHPyjwH+3wY52ZDuFgvFg5hVLLpTSmZkavAjOcb2GzXSIFJEGL
    iOUYVXTbKBfRtaZ/HjxulapeudjaDU4dFmFPn3Xq0g13/4F485TaiVpjDeszunmY
    CHFBB9FpgChJr4DEuEnGzbMqRd/D99tqkmC4adJg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=om5HNFfC
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=om5HNFfC
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOlAeDMEgtgR3DQhBDavE/uC5A7Cr+tjbY4RSSD+ZU2K/oMRya9w2bvrTPtD+n3sUULUgwC+CRSMlojzpkg0TkyAaxy3m9saqYOPN+cLTOrBb0l9xPkt
    tfbnkLUxuFY6+dIZc7yayH8Vov+xbIpd3UobRuCeMm2rQBHYsJ/K+QM/2IfcP8yA5ElJ1GkbDP9ERvAYdtJw02d7WhUCISVGhBm3UKZZtMrl/epGeFMF7sQ3
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=xD6Js3U7bqTvQ6wHUBkA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeEORq7 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 13:46:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeEORq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 13:46:58 -0400
Date: Tue, 15 May 2018 19:46:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
Message-ID: <20180515174646.GK12217@hirez.programming.kicks-ass.net>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526405884-4860-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 01:38:03PM -0400, Waiman Long wrote:
> +#define WSEM_ANONYMOUSLY_OWNED	((struct task_struct *)__RWSEM_ANONYMOUSLY_OWNED)

typoed and unused..
