Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3869068-1524812226-2-737035615806032011
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524812225; b=mJorN0fKvtYguezeU+fvnHGj5sEMRKYfO0PHX+mdQy+AUo9qmg
    fP+MjFTYR3hI1N+6J7FmATNdSrYT9QWRvWSTzajsQ4ej3njFUMAkgLcLmnI1pBrL
    KwHANXaVVgQjSR9ekWQHACLo5bG/71/AA3SCg90MQHPac+iAMpq/9Sim6EicBHJm
    Wldr9tdf7dhVJjPcdIkelGLRE2SuKfP0isgMoa1sI5AGGLIAFnO3j4U9HhvCbExm
    5Mynnr9qoU7KWKgOV++uJrT/9i16twIdxA9sWl36NM0jIKnTiZrJJpsjw4nAh4Dq
    /QijQpaqIqEMdefc+blw13o9uqI7CorcWVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524812225; bh=M2mrHHxvGywHQ+QrY3xDQEPAVC0MQV
    K+N6chFa04H1Y=; b=IrS/JgclLGkl9CCr5BV1pYbSN6RWc7TYZYMovORjWDYRHM
    ESmpmYz0PZaJHM+SRY/f1024g2BkOUaF6Pr/xJxKq3SWEP2eG/CFtNVtH0vLfzOs
    z7B4GKT3kFeRswiY0jigPHrEJRgZsVsMgJBmjNnGXMfUplw9r7Bqx4H/SYhfM2Xm
    lkKA/LUwjDR8ROH2EmYEOyplVPUTLRwVlTe8AtdLxXpNPANvWY+GAIdoWYLDv1vK
    hhAciHO6hVlpUN1p+TR28TPgSpFaHVvyHs+Z3+eQP9PI0sktd5GiLtNla29Zo3S6
    ybyAomTV+2g0WbVKG9LNs+ZIa9+g6DYL4qzqQE/A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBTySmA2n2kq5CU6TH/TCEDdOHJ7DsQ8BX4ZM7qWAnqO7toaRRs/wyv6My5lB7sHX6gbRzqVovO0aE9qt6bbv2JaRZYIEzrXq4cJM10hFcW8PPMEvS20
    GCBPzeWqMqxfCwua+fL6OAhdIQNe431clWndPRCDPOgCokR/0+wOvnCBEdr1jC/RRVi/13oSbwxBarzQ9vdbqi29NyIcs8NY4ABMc1rGk46VgbY2yR9DDl9w
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=W_HDCjAPB_eNgXVgXZ4A:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=pRQRx_yQ9a0A:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757481AbeD0G4u (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757283AbeD0G4q (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 02:56:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F94E214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 08:56:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
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
Subject: Re: [PATCH -tip v2 0/7] kprobes: Fix %p in kprobes
Message-ID: <20180427065637.GB4361@kroah.com>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
 <20180426084022.GA6777@kroah.com>
 <20180426211434.140fa33d@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426211434.140fa33d@vmware.local.home>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 09:14:34PM -0400, Steven Rostedt wrote:
> On Thu, 26 Apr 2018 10:40:22 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> Is it because he didn't add the Cc: stable@vger.kernel.org tag?

Yes.
