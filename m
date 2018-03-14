Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2464639-1521057859-2-2884023808312385028
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521057859; b=hfYmdb1d3YCqTbMLl62LAz8sCaq8Li+gSvgCaI/eR/Pkpmx
    /LEdZ2ywk6S/yu179BNt74PbBGWYYebukVAxsJmjb6yDQ+xieeakVVKouNCg2bG3
    SinYk1xb4VU46rw3xplnmaijpuMmFxOZvDm85NMnjbzws+3vwhPqDHkOa2EWkNkN
    VQOJ+sqgvSnRba6Vrc3hobQ3h382/2kqsuyM1g/iskln1BqMv0NwipCks5oTvMON
    HWNaiX86PBQcmwpu21VoRhHsSVH/1PcVkAg8/TJp8r/zVjVaUSD4GwWxPDDzL2Hz
    V7fBkKapgNVFtIIXGblwp8rx2SvojZ6pw7F8YLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=arctest; t=1521057859; bh=tIAVw5xQuxjBwYp5bGZXIOwwzC2HJ8Az8Of
    Q8AatBS8=; b=PpsgSbgemp58fc0yYRb4vvRzNL8RExZuSGEAnnvp3JUPJjq7ULB
    JkARvkg7okfIsIhanDZvfYU2IORFsERFwmuvPLnjIV//uCrcL03n3uWAK48Ok1vi
    ncbNOCsSv/42IDljqWDwTDF7ejjrxhQFSjrec4medxr2Xv39o3NhL0aBZtjhdKOv
    FRWwCI2yXP6MXp1eHcf/xI7uiUiMcN7gjMYfrZ53ODyaKLt4/KH1iSSqSec0nC9D
    pvNUhVOMSNVqemJXNwZbE7rQA1bGbQnwbMjGDzuJIxzpg0fWTcX7xaGJE/cU1Vh0
    UX6q8gqLSXKujbIqluW6XwNsrUT5A887RMg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbeCNUES (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 16:04:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52144 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNUER (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Mar 2018 16:04:17 -0400
Date: Wed, 14 Mar 2018 21:04:13 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Tautschnig, Michael" <tautschn@amazon.co.uk>
cc: "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jaswinder Singh <jaswinder@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] x86/sigreturn: use SYSCALL_DEFINE0 
In-Reply-To: <9C9981F4-0E5E-42A7-8788-70F3DEAD258D@amazon.com>
Message-ID: <alpine.DEB.2.21.1803142102300.1946@nanos.tec.linutronix.de>
References: <9C9981F4-0E5E-42A7-8788-70F3DEAD258D@amazon.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 14 Mar 2018, Tautschnig, Michael wrote:

> All definitions of syscalls in x86 except for those patched here have
> already been using the appropriate SYSCALL_DEFINE*.

Dominik, do you have more urgent stuff queued in that area?

If yes, please add: Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

If not, I simply route it through x86/urgent for 4.16.

Thanks,

	tglx
