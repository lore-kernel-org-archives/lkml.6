Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3539782-1524796801-2-3743238312860546721
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524796800; b=LHrr03Z61MUE8WtuP2dv59CDQg4rQBmSP5A+mXoqS3eZJZeGXb
    zZnXmrdiX7kdtOCvqEye4+p0ucrdIh4Ckf3CE7kyn6TDmf8YNw1KgOxywmDOLZ6Y
    LTi86ePwl1v5i6iXVBO+131AX7DdjX7uGq4QJOctlMgtdaMghahEdU3P3S12St2j
    PxmlkvLK8Ny3FT4o82livZxNUxDpCfc0YtpJlBoyd55cWRcJuKderZmVbyjboyfW
    AviolzPU/BoTseY+prBsly9KxZbBvgIPE1Nw1jYP+ZWGRKzi4rmWSEx0ubjkFCCq
    Bk1RFqgmoZlPHlHZwIuXVRhvePuee5ztWEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524796800;
    bh=JvpZWsfcxxv/027e7PSpoi16N6ODCzukbqver7IdM44=; b=mzSecQHDzznE
    duUqz0ikZ6H79hem0C4oO823S5LOKfZcFtewNtfE40MOaDfjX3zCjoyH4MfyWO8K
    YDxsL5hrrLaymi4NO49NPouIsgUJjdeph7mdq4sAKKfdk51AOcYUMGHAXYD9bSx1
    UGxL+fLInub5mXC15HeQAXzoY8keIAG+lhwIecegnIry+jughQedc6GvLbHaUoQ9
    4aEhOrL8UcH8Kt0YRlsxUlkhaYDpwIC8Q3GQq4Dzcfm+1VQthWLYyN7h/YbMUyp/
    J2LY+E5fBjeuCeG4Jr7OYEQJb18/jxyqsBXRObFaqBrlDSsoAcgyZgq8qK/Xuk/h
    uhEIB/T0CA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAHZEO3FqxNMwH2kCcbVEzUDZP0RTtdf5EKcSxlc9Vy8vURArXpJTi82x9HfIUaUAHoOjfkOpIdj8Ry4nACdzDRKCZqGxOX6/Ehu82VEcCCk8TSaLcwb
    YZ7fPzS+urxqusPl83bRVg9/F8Quqxn1XdJWzHhgbSFJ7Z2KtIOZfdILlQIR0CxvKS/9gI1zQSs51SGjvBoTpuR/N0LeuTTAfIThbJv6czLMDl/mBMyPj6F3
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=yHOcn8UJK1w06LgXrnEA:9
    a=yRkg8bYQHL3Gs1iQ:21 a=xTtev-0JZbO3otkb:21 a=CjuIK1q_8ugA:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757197AbeD0Cj7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 22:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757029AbeD0Cj6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 22:39:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686572184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 27 Apr 2018 11:39:51 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20180427113951.8e3192af570c0bae925b2a71@kernel.org>
In-Reply-To: <20180426211351.419d3502@vmware.local.home>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
        <152473020349.8819.11597612324633031612.stgit@devbox>
        <20180426211351.419d3502@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 26 Apr 2018 21:13:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Apr 2018 17:10:03 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Replace %p with appropriate pointer types (or just remove it)
> >  - Use %pS if possible
> >  - Use %px only for the function right before BUG().
> >  - Remove unneeded error message.
> 
> I'm not sure "right before BUG()" is legitimate for using %px. Why not
> still use %pS?

Since BUG() will dump all registers and stacks which includes
raw address information and reboot the system (means reset the
kaslr base offset), I thought it may not add additional damage.

Anyway, for this patch we can use %pS. For the next [5/7] patch,
I'm not sure %pS is good for dumping a stack address...

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
