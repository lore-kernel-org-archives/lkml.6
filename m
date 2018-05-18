Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4167094-1526659553-2-1933029183254576547
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526659552; b=cP0vJdLSxTmrjlLDVL0rNXMrZahyjFyDL4PQv/WvdYbX86jfjH
    4DCC7AHfSTTmusThlIDHUT95OvrvBW5/KJL/d3k4H4jIineTe/akMXZqB9ThmXYN
    i5p/kWQof7JsGY3O7ZGoJhKSo8vQttcb3o7mBuFZaRF6SP6qW4yHZWnTiIif3vqe
    Ek4/aisnq7jlgV95iFIxdzEQiAmilyyF6bQN0j+4JRKCsVwdPFuQAAiXjyyV2qNY
    b02fCfHRD276kUY4hUOnYWuIYDaJyOvo/pjcro3bne3A0xFZAczGrJiKgv+JpTu2
    ly8rAJkieZ7fDmbN/Nf8YszpFOqnAY58KpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526659552; bh=BIjikhYJ19Aqu/It+h+pf0VuBHUHlW
    YLRaNiN8QXFJk=; b=ZVxeAlcQ6litZqiN9vo1SlN9mGq1bxpTGMEaorzj8j1/l8
    oOr4d7a9GtmLk2ct9kMLiwpg48SiNq6mJQdjt2chG8a9+qMF2ZmBxnYlZ7OzlCNd
    wxRplyG78Ji4UAWyBH/DZnb182HCbtW3HpuyfKg94L3zDJJWSzIEx8xfKOvqc1FS
    ga7l8Z0jZLBRMVUHJ/zTsAyudK5oToOuKilFzC60QsXAoxOd0Dyna8RlRXY0LRtW
    b/HmZo/9nOjXP66wUL85siTnegglY+pOBUCJkAOBb194PKkl3IuMvfTL60Dx4Elw
    yPirobW2Hb2qcDZ5RSbtndc/yyw9Z20s1YzX+Z2Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=leM3WcXd
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=leM3WcXd
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLSthocPLt26z7Mb84oHKH54LS+mA2ZRswcRqOV9VFx17Jt7fH9VyIsm2WGeOd3ES8JS6aEKwrCDla0G6RF/N5VryR+ITnAK5qtgZ5ESAfK/CoygiThu
    G4QeyrdpnjqsiEkzHUZumH1nSjwEQxTTVLUvOuTswBOlwDmP7ULlAWJHj5pagyQr86o4iOg/YX3oHRYO0bx9NIk6aaBUSpEA5HWevDvTDAWMWP283D3VLqd3
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=5TJM2D6xJvL0myhLN5IA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeERQFT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 12:05:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbeERQFP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 May 2018 12:05:15 -0400
Date: Fri, 18 May 2018 09:05:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org, mingo@kernel.org,
        peterz@infradead.org, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 2/3] fs: Convert kiocb rw_hint from enum to u16
Message-ID: <20180518160512.GG22791@infradead.org>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <20180517203803.2664-3-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517203803.2664-3-adam.manzanares@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> +/* ki_hint changed from enum to u16, make sure rw_hint fits into u16 */

I don't think this comment is very useful.

> +static inline u16 ki_hint_valid(enum rw_hint hint)

I'd call this ki_hint_validate.

> +{
> +	if (hint > MAX_KI_HINT)
> +		return 0;
> +
> +	return hint;

Nit: kill the empty line.
