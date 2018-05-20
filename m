Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3248904-1526837251-2-11004494077368704523
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526837250; b=TjPAeJ74AjtXEXzQQOdgZJO1o3y48rZOEcK00yZszoYofPqHzX
    nBrOm8sIFMLcRBx3MVYTgkei6yqFkeBfdYyZY65mi6KLSVtdtX5u5v6xkyI9b7jJ
    JNdo0WoUD6fXy11YR3G5dMySi2QZXaXS9xMPAiYnurkjqsBdHfOtVA0IelVc/Jx1
    RPdNe7gMlpjiAFTLWJZL7/tXiFYqyMb8mXepEZOtEUefVILcHc+GsHxePDFCNzNd
    dXcRZWtPSvEkgyDfPLpA2AHMXSa/YdIaKYM+Ez9nQSOZ99/7Qqu0OaxH6s+lRhKU
    0tm7OmkKUDsP9zGkLohqt2QfEyQA4ez71vWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526837250; bh=oCjQGR0U/nDl57xQjJ6XkbLCqXrJAO
    BWJiJxPs2gXtw=; b=ZfEk2KVtI24SowAw2iiiVWIKmCdCGWi03h0nLaUL2GkXJU
    9tjHxSLCbY2puEiXUPcCkMzmTTsO91QZfZoiqxzvFlkPG8L4CE8IBAPsX4IZU/wf
    XkVaOKlFm9jEmBpOU3dcIdIb7+66Wvw4dREYTV8MIEcCvc9LwrNWlRBlTJzsVPQk
    YRCv60YSrkeEhXizESSWsqYhworUagIzCHWoa4eQQZ+6hT2YcscTt5NXq8bakAIX
    OwsU2yvZbXUAgFmGduVPT/T+sJtYpIhBM6yD9jzv+e4wQHRwgvipvqwZGnneKrlm
    /cEPZF5N2MVeGfijICoPRxevKkexZfE50BU7tEQg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN6R2VlX3h536L9IuObBB24lN75sTFbllnPGMXWKBfPTeVXaGWI8NsQFE7vdudfkvZgbExNDAnn9hdcTFkoEWIVYGyc7j/0j3l/eUznoTLjfGdidGrZz
    zHvJxAwtWqYm78MUO2k+HWZgLRo8GyS+W7znVeN9dy3EjTw2R8sBofd8OdofiutrQxMjFG7u3Zy/9m0b9MBfRLOxeXtlHlMmniWmspe91jnqHv89NQb8e+q5
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=Uhte7rCN35jURlK5xjkA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeETR13 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 20 May 2018 13:27:29 -0400
Received: from verein.lst.de ([213.95.11.211]:39624 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbeETR12 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 20 May 2018 13:27:28 -0400
Date: Sun, 20 May 2018 19:32:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/32] aio: implement IOCB_CMD_POLL
Message-ID: <20180520173228.GA864@lst.de>
References: <20180515194833.6906-1-hch@lst.de> <20180515194833.6906-11-hch@lst.de> <20180520053219.GZ30522@ZenIV.linux.org.uk> <20180520073332.GA30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180520073332.GA30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 20, 2018 at 08:33:39AM +0100, Al Viro wrote:
> > ... get buggered on attempt to dereference a pointer fetched from freed and
> > reused object.
> 
> FWIW, how painful would it be to pull the following trick:
> 	* insert into wait queue under ->ctx_lock
> 	* have wakeup do schedule_work() with aio_complete() done from that
> 	* have ->ki_cancel() grab queue lock, remove from queue and use
> the same schedule_work()
> 
> That way you'd get ->ki_cancel() with the same semantics as originally for
> everything - "ask politely to finish ASAP", and called in the same locking
> environment for everyone - under ->ctx_lock, that is.  queue lock nests
> inside ->ctx_lock; no magical flags, etc.
> 
> The cost is schedule_work() for each async poll-related completion as you
> have for fsync.  I don't know whether that's too costly or not; it certainly
> simplifies the things, but whether it's OK performance-wise...

I think it is doable:

	http://git.infradead.org/users/hch/vfs.git/commitdiff/c441130e405465268ea10c9ddd5639c155f779e8

downside is that sizeof(struct aio_kiocb) grows a bit.

For the completion performance we can use a spin_trylock to still avoid
the context switch for the common case:

	http://git.infradead.org/users/hch/vfs.git/commitdiff/6cc1827afbea87c52fe425cf533bfcf5f3308163

