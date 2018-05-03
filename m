Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2941320-1525372453-2-9228420298735545981
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525372452; b=SndakOyfrJWlkDc47AaEcrJ8eYCWZXxVflNWq66KN2BpMYKx3R
    PCgNGmsE+EPrKoZeC8UtwRizR/38r4jv956rATg/TZAUpJsp9gpHtiKCDwIQFJDF
    natnb56a39pO/hgEZOsdiHqw6s3gX5SMtwxciEnIqiVVvZlNZRCzRcejPykU2yTh
    lKMQ7mxNScNtKKHXGzuh9aipO86hQlZOjwjLc//R/CUlTkf0hkjiXNZ6sVSLZiFa
    GPGGuBDVlGhhSFQmLVnEo3N2pOSRRgeR6gUEQZQZMrFBfz7Ul8xTwAFIM4WPmNbA
    /uA/6oUj+riFUZDng4dw5WXihB2JIwDQBMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525372452; bh=9gh8xEK10/zJhjAeNplk2TsRGWcWWo
    6BnSNuNS0eAFg=; b=S+jviLyrtlry2rEFSIibdc+dZfLEy+wWyUM1U/sGGrCGUx
    S0GXK/qeE9lrlZgWrIUvHpCCPhVnO2PNoHLUlow85c44WlXU4fMmMzlt7j3D0on3
    k12hACAhPKFS5MjqH1/Szx3GUPGg1d7YMldPGkH/P222fqwRcIGTAc2G2eotL7rl
    cj8aBeDu8p2gxHiWU3Enmll2HkC6rDk5I2mFwHcWCNl6Z5+JOdx4b7uF1soRc6Z8
    5iC6rYxLIMbbTH92ka2lpXd5TbyrLF7OQY+F3iJNF6VAafUwUBfD155wHKNBnlPz
    hvfRXESqmQJ2Xb60FJEKSxvpClN3DUU/Qr+9msVQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=qxWAmNAY
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=qxWAmNAY
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
X-CM-Envelope: MS4wfBSrlx6iQKBxbqHvagEgg/sr7sOLTGiDjAuzKixU8qzEMk8rsKuIGm2q4kkOMv+iAZTn9BE5J44S/nLggCVevBue+8e+e5X+xzxDq7m36id/KCzi6qEL
    q8QwTUBgdAgi8wuopO9F6ft/gnPmPi4l/tGIqwEWG4xFwxdkAEYKsg8WZJr+fO5wJLQ0f3/UKtc10k2WADl1fObj6bhJXyfijRilHx9anmGejtSXJtKAQCp6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=gwo8flyW-quAeku2H8cA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeECSd4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 14:33:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECSdz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 14:33:55 -0400
Date: Thu, 3 May 2018 11:33:53 -0700
From: Matthew Wilcox <willy@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: Add aio iopriority support for block_dev
Message-ID: <20180503183353.GC1562@bombadil.infradead.org>
References: <20180503182114.2797-1-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503182114.2797-1-adam.manzanares@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 11:21:14AM -0700, adam.manzanares@wdc.com wrote:
> If we want to avoid bloating struct kiocb, I suggest we turn the private field 
> into a union of the private and ki_ioprio field. It seems like the users of 
> the private field all use it at a point where we can yank the priority from 
> the kiocb before the private field is used. Comments and suggestions welcome.

Or we could just make ki_hint a u8 or u16 ... seems unlikely we'll need
32 bits of ki_hint.  (currently defined values are 1-5)

> @@ -300,6 +301,7 @@ struct kiocb {
>  	void			*private;
>  	int			ki_flags;
>  	enum rw_hint		ki_hint;
> +	u16			ki_ioprio; /* See linux/ioprio.h */
>  } __randomize_layout;
>  
>  static inline bool is_sync_kiocb(struct kiocb *kiocb)
