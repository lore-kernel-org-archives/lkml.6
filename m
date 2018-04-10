Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-496670-1523391710-2-17219176192018591019
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523391709; b=SJChE2G8mzKBdv5/gj2QN1+NkOXcInzuLoKzXXCS9B0Wr0KqX+
    s5DM4CbOmk4hueFOR4+wQLDmfTjk33mAnnQUBquvb7iaBWaMxUAt37MpokablZCG
    WCTLzp82k2bdUUuhcBSN0fNa5cXoNEAIadWYp2NufGV0KtlWspXD3ppxZNjmKUgY
    ssaZu+57wTZS286pKBlnOhRyT7qT6kE0dpGXwIPo9qhpB/Co0sjY2LHJRwt5+BjU
    0fj5d9MB3qw9UVDBdBVB8WXMVdbW7s/MNayqXW5FeZuVL/f2R2xd1770h474wX6q
    lPlfyfiNtEH+wIivGz4Xi2cWQEXPBoWAxz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523391709; bh=j9MO1HqTLm96M0kzcMJUfWLxWDEH4hFXkQ0B1gT
    D+W0=; b=kIAw0n7U8R/kMWhxdBWAKhNCeldBg+nqB7A2APWytHCrCRpw1wEkbSI
    QZE8+90yNK7bwjCQfi/7QMuxSp9706fuRcAjIBAeMBnBpxnAYnXa7VT8U+XZzyzU
    W6VmmY45DkaJMKdIvgon17q3tQmOjR2xUze6/LxqfESv8wGkeacFb+kGGoYgwXWG
    OGgK9C2mq1bN+e2vKd69YkxCgc/4TebMvaH1fzC7KxLoztDpNvf/4Our+Hf+QpQg
    /cdINK2o55twJqpLDIJksP/aCrC1eWzm1qyS3TxCqWEthFUcprqPRw8C7exeU4X0
    Sl/YllHn9ppcsZaIzqTlveepLMXttiA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFsp9SRedBkyRIknfatO0Fgb+pShSeigmYyWrODiFiTdKlAazbMGe1NH9ETvHimRJplAm1Sneot13u0cqHGYncCSLyikIEFK0s7fmkhEjmhtSKAC32ZE
    eBFWRB9ON1VQrRaIU4nMylr7PAim12ZMpf8E2N2D18STtBNivadn8y2vGnlo5uojNg+5QJ5D8rt4zrPqF3ucoAgBJ+8Mf2bqWnCrtat8hIDeLQlw9QyK8VR4
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=khwyK8DuSVkA:10
    a=Kd1tUaAdevIA:10 a=1AlvqKCeFxXN0LRMdjsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeDJUVs (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 16:21:48 -0400
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:58276 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752064AbeDJUVr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 16:21:47 -0400
Date: Tue, 10 Apr 2018 15:21:45 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: Eric Dumazet <eric.dumazet@gmail.com>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a
 constructor
In-Reply-To: <20180410175011.GE3614@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1804101512350.30225@nuc-kabylake>
References: <20180410125351.15837-1-willy@infradead.org> <fee8a8bc-3db5-a66a-33cb-0729143ba615@gmail.com> <20180410165054.GC3614@bombadil.infradead.org> <alpine.DEB.2.20.1804101228170.29384@nuc-kabylake> <20180410173841.GD3614@bombadil.infradead.org>
 <alpine.DEB.2.20.1804101244290.29559@nuc-kabylake> <20180410175011.GE3614@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfPUKRHkC95QsYrsIT/As+M4MSZCyYLCp+5Cst2swZujtOJoUrFHU7zC4Nl1QMG4754OssGAAdlEis2Jnkr3d5BnTplf67r8GdqdzQL8jAnjP5sRgI2Gc
 j3pmFYt3AdHvOHRJLzhj3b6Vcdmh+OYTekB9puRGA0tveYrtyPA3Ft/w1j9B/ZdSJymy1S31mOdgBqtTw7HPaz2WgJqwQqbgClGy0xiG6UJn81qgSKse348b
 yoKp+1qBggTOQLgWOuwmGEzvqJ6f78E3wgj/gvNiV8qyUr5R0i9k91YPOHiX36b4Jrz1tOHk4xRXy+vQwaItR4Z8VEVwR0PDXV34+9BsTgKRH8tV93DgPqrV
 cVGg6cvraYbImt7vG1iJ4DBWp3CBRNFit8iQGmZDHH/8ipyt8ogyGOvULfJQ/YrXm30yxzHYoJ7Out4N0By4ITrTbNlx90A2kU1AVUT0oIi3Bjob/SjagaSR
 8myGqifIT2oxKk2KqJJEEQvQ9zWEEqcrkBcDiUMv9YXpDi0yV5fzydZGj41mOd1cM6avl+nNpRFrMrpTAjOouxI9aJpkOG/zqwwj/Q==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 10 Apr 2018, Matthew Wilcox wrote:

> > Objects can be freed and reused and still be accessed from code that
> > thinks the object is the old and not the new object....
>
> Yes, I know, that's the point of RCU typesafety.  My point is that an
> object *which has never been used* can't be accessed.  So you don't *need*
> a constructor.

But the object needs to have the proper contents after it was released and
re-allocated. Some objects may rely on contents (like list heads)
surviving the realloc process because access must always be possible.

validate_slab() checks on proper metadata content in a slab
although it does not access the payload. So that may work you separate
the payload init from the metadata init.
