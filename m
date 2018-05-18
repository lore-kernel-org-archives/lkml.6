Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4169591-1526659336-2-4022668612853989149
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526659335; b=LY7FtuR2ZCpdQvSkdjchVICmQ9hNKjAiqAhPJqN7lWV8AAj75m
    DBLhErY/hOTXOAhQeRVNTkRWm6I47R5j4fzytx3JUh96M3izmKeTHtbdxUnb4Tkb
    +ntvf3swgEvXCl/8CamqpJmndfNxjnDkPTb8nY2s0hpKx86m5axodTtks8SsiHzF
    1cFN+vg+UeuhrLIMR0aHF5jSEQpEdFE5A6cr+T7eC9BKlIRulEmtZPOPiZLqP/Zg
    HM41nqSSAwSeODbB8l14hrLfeQMAD8sYU1x6wLhqIlniXOELhbbhWl38OCt+XlFQ
    n/1CaqEy4orkjowuT5Ah/PROR/gY4STJ+XjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526659335; bh=VZxRZbl+ByplLqxudRj6q63xPBKQCa
    pYYZtKtkDiIvk=; b=KkBrnEtF98dDPtJl33rBnI5pkt7otKwdC3dX52NT9WoQXZ
    IdyrBxmPhOPwHtSNvj5rMTn6IHOM6Nn0l1IGg5tgsc7Mnqm6xGgxZXQqBfr4GQfE
    UCYLyLmFNSSu0G77KK1mNCIhQcvCcqHqgFWjc2i1962h+wIJBoFwdrsObadQaAmQ
    Ae5yy3qaZeo+gtv3Z+244u2cwR+DDAFKYhxeljrZGEnTxCvTfyo4ROHUzdyscCE1
    Ym8QaizCGQ7ZKQTL90BGaBNs0VX1bWAgi9wSb1IiKzDmzeSqfXE7irM7GK6IseAY
    4i7fl4cPYDpcPcZ0RqVP4ZLl5LP6wrnETLkvy8ag==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=opOvkO4E
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=opOvkO4E
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
X-CM-Envelope: MS4wfCefjfMdi69Gr413UpRZy00G2fFS42wysMbRoy3zCO+naPs4LW9loAXO/icjy7C/eMnVhOc/AufALhXKKDpvMiJ7CGxH2xBxTiL99glZRt5N0mQ/kNuf
    2cBAi9WS/saAWq82YJKX9B002/DGP7oLT9qlp+yUw+Ev0+R+kysxEfLljyL9Im5p/CRfK8C34d1wxo+g3DV8mIDETeGS65jI99bt3+qN8NF9DcOSP3cDbvni
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=wVxt_QWzq7v-y8deSeMA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeERQCM (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 12:02:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeERQCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 12:02:05 -0400
Date: Fri, 18 May 2018 09:02:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com,
        jbacik@fb.com, viro@zeniv.linux.org.uk, willy@infradead.org,
        peterz@infradead.org
Subject: Re: [PATCH 06/10] Generic radix trees
Message-ID: <20180518160203.GC22791@infradead.org>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-13-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518074918.13816-13-kent.overstreet@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Completely lacks any explanation, including why this should be
in lib/.  Also should come in the same series with actual users
of the infrastructure.
