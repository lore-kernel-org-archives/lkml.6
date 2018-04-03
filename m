Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2119239-1522779303-2-14132728540629842887
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522779303; b=CoMLspWYeI5Ha9rL/4yF7VJUXw+cuj+yjLjenv72lLOIij8i22
    YvzPbfru6ugKC9DMoHX8urNwz782qxh9mw+n9A9CYs/GlmCqgoKr8PUYmTWFhF31
    IKMe67bjhgOudA/RwcB0jlrIVVuSZvlK2cWgsI/G8f6gV9TnH3ww8rc+NW0LKoNM
    6zcY3HVAOlj8qzdcmOZFaOPDjDRjZ2uY+M889GkTj5OGOXn67BBIbhj5INwxliS1
    gSWPDT6bsdb8SGOQ12WDVFMgCFkf7mec5MWh09tDjMSknE3Mr7Bf69G4GPlWpOeT
    JJgwyEKWNCKcHP7/t4CudYEQMQ9vg87V6K+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522779303; bh=jS0/LS5NMCB/4aP1UK3JZFUrQxV2Ng
    N8yUoNQoXi3tY=; b=nECOd+AjwFeCtWFTT/SH84wSf7qlQL8rSctCRLt8MFIhL/
    w4zq4Wdj7UcrIepApzzM1wFvGuCngdJRS3/zyj/Ly9rUrlcXJk7u0BBgVxAZUGg3
    2enRhvgDtZ2w+POwyf7T3n/K+eXo2IPbZE1DuHS2INyy0qQ3Dfor9NqYBZvRjGKC
    4WBHFif12CpqNgMXOPW4IERODhe/bjibNuflq4zbScHuH9wN2Ae9DYouXD3v2yFp
    zohDpc82rrSubINJl8jNRfLGze5WkRQ2L4HuJASop9fgZkYFvvatqfxcvsMwAA1a
    5evt9klwaiTJd+oNJigw0Lcx8PmeTFDn6kyZDMew==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b=IPi9zL9V x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=osandov.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GFdo+5Ar;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osandov.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b=IPi9zL9V x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=osandov.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GFdo+5Ar;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osandov.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHL6YXzQ+QDhsJwktMi19Gg5Ha5+XpRoz+cCovv9lCaaHKpIPCd6B4zFZhupdYD15+FQBVSs0MI6wHy70EgSgWPlc50DRw18ebTjDbwTMDGmYqNksIx8
    twz9J7lBJxklLmDE7JBtrD7K5SC8LdM7TIHJ7zU1in9pzxtpCPCbqyjqQvYjgkQYWDrJ86UuPLdwxh9sbFZ73ANbHtcwYEQjKv4lETkdYKP7PO20b6/NFJC9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=VX7HnwCTLfMqDp4L-zMA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeDCSPA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 14:15:00 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:33088 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeDCSO7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 14:14:59 -0400
X-Google-Smtp-Source: AIpwx49/5JDizOajnSxnV1HWxxudlN37LgvO0+rwE8qO83yDFnlJ8y9hc/LgD8XhOitmMm+EQ0twww==
Date: Tue, 3 Apr 2018 11:14:57 -0700
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: kernel-team@fb.com, Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Please add 21035965f60b ("bitmap: fix memset optimization on
 big-endian systems") to the stable tree
Message-ID: <20180403181457.GB17679@vader>
References: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Just wanted to make sure this doesn't get missed because I misspelled
the stable email address in the patch. It applies to v4.13+.
