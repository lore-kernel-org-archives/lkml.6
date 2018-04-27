Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3435361-1524791639-2-4914171313913763171
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524791639; b=ivFQ/Wzx556D/qUePIRwEszp+kJcH8truU9aMZnG3JplXmYP6f
    Fxg8fM6cGCa24nLUckpFeDnNpVukas6UDBP7Bz1EDK4oVYd2w8LRHc/JjYlj+f18
    4f+9Hs0UrVsuozNmaXBMwGdS3G/lGpM63VvRvhXoJaoWVFazfE9x7S4tqrTUQ7e5
    9d9he6nD3CXQ9OB6c3vBnfzB7OUpu06ix2cAbxdpPP9rzl9nTjLXqJsNToV5eqvP
    XVe2+OXNjkv0G5kohPzjsp+lX9RwPbbhyv+YSLhTOrEHX1UHOBSpm2mDM4o02eS7
    046OZpGWYFTYdAPcNkltN0HdqE3ENdlSrNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524791639;
    bh=EaMExUYl/eYn6qW3AFsd3Ah117V5UZ8qKjhxc3CYNEI=; b=Nxrbc6dYiHas
    3jw2SV4pwtSO7UjGHNEd6hfRbR/WYKv8KuHKMEHXucadjvgCEVEDsKeHMMaHspZP
    5q394+l19sYlsmg/FCL8lxQEybvSCxu+mVpQ4TCR147rVVZchbB2gfVr+n1+Im1W
    C3Vr3WAJpoAT3EQtGSJ8kPBsAC47VT1ecVTh9Hs6GKWLUDvtXNPC/W0+U+9wcBar
    sBjn3kW2aseoyrcxN0DgluHYgZjGicADqm4LfHZ9vn5HmBo5WT71TzFu+DvI9Js6
    YzhSuh0PLHPvTi/jbHUrCMsU7JngfpnSjSIXpoLB0jyvSHh+f/yV4qVLJUS1O8gq
    AR7tWmcgsQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOGfBiPALqKznfdjW4UQE8HExhN8zn5USxwDx6Ycl3mJ4KTEmv9CPKciMNbfBzDX0x3gspn9vWXTfJuz6iuL7dMqbG8k/caHH62ao35elPmvM3mDhKNM
    A3w0+LEZI/tbWQryWUOTyqhrwXosNhM9aL+f03A6RI2c3yfule43irprTWbuSybiHYOHg8yXbpruKlomo/RWFMhg5KtglP3KLHFMvHjqfSBcDp180DQJEXkR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=i5IZh5tSkWVHgG_UL-sA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757261AbeD0BN5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 21:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755199AbeD0BN4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 21:13:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F392184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 26 Apr 2018 21:13:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH -tip v2 4/7] kprobes: Replace %p with other pointer
 types
Message-ID: <20180426211351.419d3502@vmware.local.home>
In-Reply-To: <152473020349.8819.11597612324633031612.stgit@devbox>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
        <152473020349.8819.11597612324633031612.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 26 Apr 2018 17:10:03 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Replace %p with appropriate pointer types (or just remove it)
>  - Use %pS if possible
>  - Use %px only for the function right before BUG().
>  - Remove unneeded error message.

I'm not sure "right before BUG()" is legitimate for using %px. Why not
still use %pS?

-- Steve
