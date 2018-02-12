Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1689219-1518450557-2-1149494844838199222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518450556; b=TvBzIJb1veQTF4K+GIDguz01CM+E1Lfj/isVMrX/WOLhDGQ
    0NHsOh4JYdUbtDLvE1+NLTtoD4W001LHtq6kGpKikywHwgj2Fek3i8agHc/MERAk
    KvgOL8t48uuIep4CTX/+y1rBloTa7T9sLQshlj8mS/8jAuNUohe5lkMsfENL1cwi
    reZZeu2vOuZXQKD1WNO5Tw4gDaYUGWP0I9hJXCLA01LYBqRv9uFpxiEiDpdUTuK+
    Gs2DU6s1SMYPORR6Zi7OcRy9lNnfYRGPW2oguk6tvaYN1rO1a1qG/7VOIl5mNwFs
    RsJBEDmkwkqADQLcTyOt8zGfHL2Dhi26agVLXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518450556; bh=uwnggR5wQJVCH1DggC0YUEvsFn
    I7NDdjp2DFm3QC0ZQ=; b=f7HFhUBBYSDyRkJ7+h3EeFIbVUMhC9QZAmr2P7gZtG
    jvj9vExpcq5ywW0R7o0DRpcPNMz3dlO9500JiTELBYTs1J+SrTx+1uvTyoXbzAHU
    r81qafYUdyB5ol2SWBCuiFyLie6vSZuFtMbx2h34SROW8EngeNKVsu81kLcm23hC
    d+yIjqeX2JnEStFTfL9648qyfc0yQKjAiMqnr1jTG+4YcrJBZ8WenjOUazTaFH/d
    5h0DfdreFQx8vBQmMuXojuhxC8Ag6DyFJnJiwULURnikh+UC1g1r/mH3z/uC9xpe
    9Ehe41T41hJ8pEsxfr5WEvbYBlx1l9YfLbHJ+8rPX1Hw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FA2sjPXW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=gu1ORJbp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FA2sjPXW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=gu1ORJbp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeBLPtO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 10:49:14 -0500
Received: from casper.infradead.org ([85.118.1.10]:42636 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753500AbeBLPtG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Feb 2018 10:49:06 -0500
Date: Mon, 12 Feb 2018 16:44:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Timur Tabi <timur@codeaurora.org>, graeme.gregory@linaro.org,
        mark.salter@redhat.com
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
Message-ID: <20180212154434.GX25201@hirez.programming.kicks-ass.net>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
 <20180212145652.GM25181@hirez.programming.kicks-ass.net>
 <03e799c6-a0f3-eccf-882d-78205e9335ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e799c6-a0f3-eccf-882d-78205e9335ad@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 10:18:06AM -0500, Prarit Bhargava wrote:
> > But when I specify "earlyprintk=serial,ttyS0,115200" this SPCR crud will
> > not interfere?
> > 
> 
> I tested "earlyprintk=serial,ttyS0,115200" on a system which is known to have a
> functional console with "console=ttyS0,1152008N1" both with and without
> CONFIG_ACPI_SPCR_TABLE enabled.

OK, but my point was that SPCR will never override explicit earlyprintk
stuff. There is absolutely nothing worse than breaking working setups.
