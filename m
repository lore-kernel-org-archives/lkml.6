Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-157256-1523379885-2-9818856379609720649
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
    1523379884; b=wneCYmB7hk1XDbGUvNI6cIg+Qp6xYhdGOoiITQkt9I9mcXDoOS
    1CA2kiLNWo9X+qXkQlbiubH4nVYDtX9zrUaOksrBB/TY56K7u6k55/oYaBH9NNVI
    e3WmfKfbYnKl660x/LwNN5mXoPdSplOk5OFvU0kFRMi9TS7a9rpG686xnfaXyvQM
    /N03YMm/wqrqjpGL6WCaAuVDbY8Y1KD5o06jqoT5aAfRFG/QAkmi5MhZ4xx45sGQ
    qSUWFBW81eRMYX+juht7HTQrkpMNRc8snxp7Je2fpyuuJohAth7DJwyRadNy3zsm
    l6fe8L/RyMspO50wGAsEiyDPJERlZj7nXKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523379884; bh=8KZJsCkbVZHb0lzJMMYQNjVsvFq4i5r4spuQUpJ
    7rc4=; b=l5H2D8uE4Gz9kNKgO1ieodVj58KkzqxJ2CO7medrdlqftnt3oJ8aaFU
    SzutCgYWn4FnBIp6qb9vWnoHwljZ/7YLSQA02q8AN+a0MS/FxwjhWHpQAXvxNNZN
    MXU7CrfiDgRYSJjKpHAVEam4rt46gMD5Rph4pnhRTdGF8WHPK1oON6At0+lS2O4X
    DlXJDXy3cyYQQKYxqzwOc/qKsxVqHwi+wm91xfA3fePSPV0O18yZushASRy50j+e
    7ORpdUR/By485SwhLBdEwwxAWmOAx098ZveQNIhywiEc9P8JgoJWeO4VokizzMQh
    gtdGSow5o02KsJfehB0luh7mAbq0uGA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfCKcnh7N3oeneWLdHlF700xV8XxrqYY9cVnt4SUvu+dvYCwYrrYjhf/BP4IoD6fZpWYPwiDa20kOK5pJedyCg0AIptzWqYn/a54ZhWL1N7XGe5tk6Mp5
    FyxoRzvuEI8EpAUgjktOS0reYJJpMn5WEcFHfnrLnHNWHS9EkHWmXx7NHr83McfKtOR8yxTRqsq+psXpMDibDzM6ZDUspCX7qji30Pf+Sq+1tHDtkJueKL60
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=khwyK8DuSVkA:10
    a=Kd1tUaAdevIA:10 a=05zQUA_FAQEl1kfunGEA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeDJREl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 13:04:41 -0400
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:44534 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751589AbeDJREl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 13:04:41 -0400
Date: Tue, 10 Apr 2018 12:04:38 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
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
In-Reply-To: <20180410155442.GA3614@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1804101203320.29042@nuc-kabylake>
References: <20180410125351.15837-1-willy@infradead.org> <alpine.DEB.2.20.1804100920110.27333@nuc-kabylake> <20180410155442.GA3614@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfEocr3AJO2EAlOw6+AOBgDYuFAGN3oMqRazwgpfnGNFWv/g/1+rE2p78U2WIRi6ETRW9nqjm6R9Ya9Y4gHAArBRejFSjbs2MAWJ5R8FzC32DHKSOY4Rf
 omw/rpt/3Hl6w/oKvZ1e4phQwOjYgZdDcYkI1Qg+aV9BrpV9Bu5sngZeP/XC7x4sp9AzvLSjSJNIrPq5q1ctuW9+/Fo0w/86wfQSrAoF+jL1dhIh/PZZsRn8
 LiBZAZ4aRRmupdiQSUdzSVehB6GvGwtZBZmLXXuJ9MlKzZuHm+m2oMwkO7Vpr8U4pSHXDluSyfgjKxwNhl8eCjZQjfpI0WsggFwIoVlUYQErOR93T2rNPOO8
 DrchIVN3ARpzJ1206vwRK/Xwer6EdeT4bpoVqP3UmnO4MnT2Nx5D5SKaGQTeYtp5I51gpxk0TP3YHyYhoMTgKatQJCno23LdtylkApPcGBDAJzbXTpliivs6
 Pd+nT/Ny3Uuhxkcczx2W3dKpjp7si+BhxndVAWFhG4kavDlg+rIIW00eH1k=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 10 Apr 2018, Matthew Wilcox wrote:

> Are you willing to have this kind of bug go uncaught for a while?

There will be frequent allocations and this will show up at some point.

Also you could put this into the debug only portions somehwere so we
always catch it when debugging is on,
'
