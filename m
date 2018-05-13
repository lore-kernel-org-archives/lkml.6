Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2268887-1526176541-2-209604953305814727
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526176540; b=akov2STzUIjmt/a2Dgtx9b3Ofhr1NcbVryqdeQqvGidGUr/7zi
    E2sH6SYdRFMmAvDATsYP6IgEd4JyrqRGNBbHuIFXmnfiXEEPLvl6PvjbcvsnigOC
    hDEeDV1eSnxN/OYYrpCiuvFLQ8z685upWkqm3QsFQyn7q4JJyswESUFaggHqiMvg
    3pH3ty2FPu0FU17ubxzNXIIbWnAcqtUsM0V2YksLZoCBtVumTNlbvMsR3KYfOnvz
    88PjhZZl/58FIITZoZ3UCdf5EJx4y7epLweOcsRIhYvQtHnaNy33LfKGghh1B5+Z
    OCW+dHuScdOJgK+LHbJLoRv4FhQOyaFF2jJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526176540;
    bh=tRsDLy6n2vde2i+qVfAelQCQJB0VUDy6Zjul9SZ3jNo=; b=l1nBcHYWzsfz
    eRzrUWnmiT7L7TGX/UD/RN+3XZ7a3C+z4SMQ5Tvr2lfQ4fKk76B4QtRrH1x4I0Hd
    gy90z9SmwVzOVzfefMemvURnC3UqY6pfBcPPQYB8nyddDoMmdb97yjUYhtu0vQoU
    s/gbf9fvXT0PcpwLPcKVS1ilwEoRi2K+At7WBwVpUv3Z5u29geN+zLY3bRZ9QQ2r
    tdnVqPTLkCwiBnSJJvDElpbkYYkapRSf/uxSUNy7Qo6VFjpU64Znjo2pQMFj1Bkb
    GGCyauGxd33splmoRg2ZFRakkZy82ijBkrjYhgaB/HJIjLOPB/dZAhzJ0dgUsYq/
    mFUH6+hWhA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=hXaDfGb2 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=hXaDfGb2 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCMs3qwHlitg/aG+/nvqqbfl51g8q0O78CcZzLPQPIeD+bPqRiGgqWpqlFVKpJg/4XZucPg8xap0ZV1rT/QQpW0Rpt+EeZ1Iasu+VQAj3gpn16vZo6qp
    lW0S55Lyq3KFNCMNIjZBTN/eBU/foPI1MQ8QdJWma/QuuBOVrFwvFudw3CXB3+lsUFja9Xp0s4qXit2IYkgt9f7s4/HIl1HkJndJl1NnbllTbo4XNyuRMVf7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=IpFL8ALtzpIc1KZ-LMoA:9
    a=IXUuQnJ3WppalZXo:21 a=3-J0qwe5nF5fcHy6:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeEMBzi (ORCPT <rfc822;greg@kroah.com>);
        Sat, 12 May 2018 21:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbeEMBzh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 12 May 2018 21:55:37 -0400
Date: Sun, 13 May 2018 10:55:33 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jon Medhurst <tixy@linaro.org>, Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Long <dave.long@linaro.org>
Subject: Re: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on
 unsafe functions
Message-Id: <20180513105533.03647d65a97f76ddc123b757@kernel.org>
In-Reply-To: <59CD6F84-9E51-469B-BB67-340A4F376A13@gmail.com>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
        <20180508112503.GD16141@n2100.armlinux.org.uk>
        <20180512203137.4c00f301c4359de1f6253154@kernel.org>
        <59CD6F84-9E51-469B-BB67-340A4F376A13@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 12 May 2018 10:29:57 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On May 12, 2018 4:31:37 AM PDT, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >Hi Russell,
> >
> >On Tue, 8 May 2018 12:25:03 +0100
> >Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> >
> >> On Fri, May 04, 2018 at 01:14:31PM +0900, Masami Hiramatsu wrote:
> >> > Hi,
> >> > 
> >> > This is the 3rd version of bugfix series for kprobes on arm.
> >> > This series fixes 4 different issues which I found.
> >> > 
> >> >  - Fix to use smp_processor_id() after disabling preemption.
> >> >  - Prohibit probing on optimized_callback() for avoiding
> >> >    recursive probe.
> >> >  - Prohibit kprobes on do_undefinstr() by same reason.
> >> >  - Prohibit kprobes on get_user() by same reason.
> >> > 
> >> > >From v2, I included another 2 bugfixes (1/4 and 2/4)
> >> > which are not merged yet, and added "Cc: stable@vger.kernel.org",
> >> > since there are obvious bugs.
> >> 
> >> Please submit them to the patch system, thanks.
> >
> >Could you tell me what you mean the patch system?
> 
> This is in Russell's signature:
> 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/

Ah, Thanks!
OK, I'll submit via that system!


> 
> -- 
> Florian


-- 
Masami Hiramatsu <mhiramat@kernel.org>
