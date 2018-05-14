Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1368942-1526329818-5-15394712517835721702
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526329818; b=WWYYZTUvjKH12K+yR7PWppUuZq2EIaG+iU51FJtTcsTZpzw3Tr
    L4i+9cGhFguDceRGN80Ig/OSUeqJb82u10wRk626wAsxvGsxyn0kOrC6kTFAoM8V
    X/ElfLNJwNVuc0ZJkScjcX5nGOhy36W9OXCpQfdLbMzUdT+RW0jkbnBUNfI5ri4B
    LsxfbjHnybUQnOC+eVYzVhUgy13v0+5vB+RlsJSNpMhz6VR5jChQzLbih8WlRB7s
    yP0poy4BHmoBYyqhx55dqQpUg79hDu9VUZNJLBja+5PmkfCyLXXPnvzPhgw4tMsr
    0TjVKrqXl+Ngvrn4HU24dtRGo1xaBX2Z3POw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526329818;
    bh=XlWtDI1AAsziUByW9XNMbqltEFpy5gLbUJ/+n4abFAc=; b=ncc9cM7CdvDE
    UmkPc0Bl7UHGeFF0HF/TLTGkrOOAwgzZAwvxOmx8yjzb9m5JFp6NLL/jZqae49PF
    H+rvTTb098hWUzs8d03XgpnVtU3UI71qtb2Yobh5Tz2t7CaJvaN+LInVaihwyMid
    f1HOeReClU2DyBTfcY+vCCQ7SJU6R/zEK7/66BcUYaxuB/KbjVBpPwPRgnEv7UA5
    ehZvU4ouGFivwTOPNrZheCi2GIAB0AVwGmisvw5J3QCpr0Rl/scT6szbIjcn78dO
    3WK+Bxzgy7oeD/P+q4IZWrwHoLApEAlY1z8hgoW+pGGvs4JYHCV4L4yVgzYIHBmo
    1ScmqWPn+w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMvX/e5XuC9FTT29nV2VxW+Z/GFIpibiLayjWJv8gXDaGZNO7WeI5bvYr865fIryxL89V/y3GhwmDcunIiXo6RIyvS7UZ6FG4OuFKZpEyuCdoZ6c2eDr
    a6EVcykU8ATXH3eET5oK5PRAWnzaJ7uXNXaHTUUTQASoIYQSaBBe/EdNfXqLkCfGw0R0U3oz6BK5RgAfA51hl4MlgjRZwffMS6oSTpZtOyAXUsEoZpedShPd
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=Liw12kgf9JG06bkJUVMA:9
    a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeENUaC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 16:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbeENU3s (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 16:29:48 -0400
Date: Mon, 14 May 2018 16:29:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Juergen Gross <jgross@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jingjie Jiang <jingjie.jiang@oracle.com>,
        Mukesh Rathor <mukesh.rathor@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] tracing/x86/xen: Remove zero data size trace events
 trace_xen_mmu_flush_tlb{_all}
Message-ID: <20180514162944.35f5debf@gandalf.local.home>
In-Reply-To: <54c0a807-87e3-866f-aaa8-de383d567d50@suse.com>
References: <20180509144605.5a220327@gandalf.local.home>
        <54c0a807-87e3-866f-aaa8-de383d567d50@suse.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 11 May 2018 06:14:07 +0200
Juergen Gross <jgross@suse.com> wrote:

> > Cc: stable@vger.kernel.org
> > Fixes: 95a7d76897c1e ("xen/mmu: Use Xen specific TLB flush instead of the generic one.")
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Any reason not sending this patch to the Xen maintainers?
> 
> I can take it through the Xen tree. :-)
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Are you going to take it?

Hmm, I guess I probably should as my patch depends on it. I'll add your
reviewed-by tag and take it.

Thanks!

-- Steve
