Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1547173-1528101822-5-10362613782921198573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528101822; b=a64KpLMwc72jLLJ+4oWC0zkal26oWwVavE9cflFZrG/qItm8Wd
    m4winkoyh2JL8sKLqQf/Ga+LnQSiBq4LjC6y7KzfAvf1a4uASvKQVzqxv/EbyPW9
    TWy+qEhEvRbcHUj0fnDp5UpUnDDhLfFlqApQX2yPiu9dekZmkXfcbYrLQzfM+xOy
    R3zZnU9jirSuVnxZYR04mhPAA9ftCXQria3z13yrOLzPs05cQLs0Z3xxtz+YatsH
    ceK/oB7JkgrotD9xb7Z05nihOVJMtAnmro+yH7EXMT2PW+Blf4vxwWt0N+Gj/AJ5
    yYezxhhrxMtNZnYqprMg6SeXCCJQ/iJVgPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1528101822; bh=OLPUYUf/2I4ODyfCR4DMAyQ/WMj34r
    tnJ3LX8rjP5RQ=; b=fXG6rh3kIKlQtZi2kFt+vaZk6wsyxy6rHzhKtV33g4ZSTq
    f6iaqkxN0dMEe9ze0uKfa2XoHISG0IT+oNbk1UIv0DpkG5w0znhjVkUO8uetZboP
    /jF2m8T8d0UqyYwbDIvmPtIUfNphsS29JM32Twqt3T6lNzTDh6SI6q3F0BniN/jS
    DHdZWlHK+JIWV+KqmLM39Hy97rCAXix5K/xivfQUz3AUbVBtd9Ijfyf1Y6C2vCeY
    V/sWSiT1Len8qzHDb08QwXz5/1TI3ZpgvVGPDB6eAiZolSN/X8zDhgqEG2UbcCLN
    IHGM3+Xhz1qs3jbtAgN8s4imWGaOYxiX99qZigBA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=sxVLK5KR
    header.a=rsa-sha256 header.s=bombadil.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=sxVLK5KR
      header.a=rsa-sha256 header.s=bombadil.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFbJytajD/pfUDSFL8Sj+u3EJJxSr9F0iGunqn2wgoQSNlxVz+YseKmWITXBY1TD4+TiYeVazS06t5/W8FFdqPkBy3a9j095oRPOAmMlGDAALMhfQ2D/
    PWe/PMvLw4Wrd196E7uC+RQXZaoABOIE5Vupu1+mhUdX0G1217b2cZLfKB6qQlHUWc5pUnjbJjVZLejhg/KTYm1QvTsENWTDVoKbix2LT2ff/bPTVhFq5IuS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=1ViOiqilcncwyHl6zTMA:9 a=W5bW43uPeTNn-hPF:21 a=2O8VI6626rqOCqgr:21
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeFDIni (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 04:43:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeFDInh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:43:37 -0400
Date: Mon, 4 Jun 2018 01:43:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 01/39] vfs: dedpue: return loff_t
Message-ID: <20180604084336.GA11333@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529144339.16538-2-mszeredi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 04:43:01PM +0200, Miklos Szeredi wrote:
> f_op->dedupe_file_range() gets a u64 length to dedup and returns an ssize_t
> actual length deduped.  This breaks badly on 32bit archs since the returned
> length will be truncated and possibly overflow into the sign bit (xfs and
> ocfs2 are affected, btrfs limits actual length to 16MiB).

Can we just make it return 0 vs errno?  The only time we return
a different length than the one passed in is due to the btrfs cap.

Given that this API started out on btrfs we should just do the cap
everywhere to not confuse userspace.
