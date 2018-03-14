Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2597693-1521060115-2-691258785584524664
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521060114; b=TodQ/IRwpHRnqU0cxy4SWu5sL1/SkDkc5k9tdBQ68t4sq7u
    RdHE8aOR2jhDDJgaFHKZeADil5NXIwcoxYPTsX6Auvq6p4wkFyAG77Q4K8M3Z8uo
    7R7VyD+LUnzG4JHv7sUL18EA1aOYd3ABemVgRD8QV8K8dXN72ezS+Y1DIcLOwQE0
    HG41f48Vlne4GrdVOPjpOYv0U+Te91xPZQhfpfvdBAWtPn8hN7NU9VwqBBK9nECf
    qQeBppOu0DTrr6ZuNsjVwcCJ8LUzvK1GyO7lgpNgvBN/LXDW7RSyrUO7pV+G6PGk
    f7bIIPLKndi+pAjXvsY59DXmQSz6oApV9i44bHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521060114; bh=Z+ZHlvBSTXwY+8StaU9dDBejVF
    NNiMBzId5N/xq9E0Q=; b=eLw7pLgpJnrmqiGcZqPrY87quHzULmba2sS2qE5AMz
    JBC6scJYSLxglWSmgnnizM9kQxAaPo7Ybo/dqVqucw9E6ZgtNJ+G7n9FdxDWjlpO
    Plx7qHbdN5d7gLCmC3UhhyB+2EfTUNwUzLqB67rd322TfOKxSJthRmAskVvtbOvj
    UXiT6oA0GSYx9QbUFvTOik1qsPdScj89N8jh0C4edzHrZfgA2xqug+yU2jdYlR5Q
    FmHH3DH7ldOB5xIe+iNyHmT3XZCHdsG4CVbp+KRGUUIywKohvCXQ77K9smQntihu
    A4Y144mPMm5Ztbt7/jzTHiGEmdC4DyMzcuKOm5pM9Y5A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dominikbrodowski.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dominikbrodowski.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dominikbrodowski.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dominikbrodowski.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeCNUlO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 16:41:14 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:59206 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCNUlM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Mar 2018 16:41:12 -0400
Date: Wed, 14 Mar 2018 21:36:45 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Tautschnig, Michael" <tautschn@amazon.co.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jaswinder Singh <jaswinder@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/sigreturn: use SYSCALL_DEFINE0
Message-ID: <20180314203645.GA21437@light.dominikbrodowski.net>
References: <9C9981F4-0E5E-42A7-8788-70F3DEAD258D@amazon.com>
 <alpine.DEB.2.21.1803142102300.1946@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803142102300.1946@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 09:04:13PM +0100, Thomas Gleixner wrote:
> On Wed, 14 Mar 2018, Tautschnig, Michael wrote:
> 
> > All definitions of syscalls in x86 except for those patched here have
> > already been using the appropriate SYSCALL_DEFINE*.
> 
> Dominik, do you have more urgent stuff queued in that area?
> 
> If yes, please add: Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> If not, I simply route it through x86/urgent for 4.16.

Thanks for asking! Nothing urgent from my side, only stuff for 4.17, so it
would be great if you could route it through x86/urgent.

Thanks,
	Dominik
