Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-392315-1518538290-2-5182270115263966835
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518538289; b=TFPp4NKjFklts4Oazh/Sg5+s9ZTh8hc+BmKIxdxQtT/bDq6
    V6ipHqBmHUPh8PSta/PYqp3Sk72OV7pgi90orbvc0z6BjxGo/7mF6VEppBWClGIr
    6YbkessGu8ah7CaA8lpuJ+S1JM28+/m3rlS66iVdom3G4CdWLLJadawqhQrqBFro
    E72Z4xQ2YhvdSF24Nwu/TqafmF7RgWaR4EYPaqzKat8AjOkqPYfA3+5iDTCq7zmq
    4HyVVAQhTfoIz1PvMNPgnHKatLEabf3j8L1nnefQBm+tRd0L1jyAh+6XRIVGfXk4
    qjvbJrWod5TGa3qQ2uHmMz+BQhWb08FBtGJ45Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1518538289; bh=USE8wB5
    LRW9g1aLJ5yE6B1UEOZYYjzpl8ABd75AiRww=; b=I/w/lW7eZKJwZz4zepHxgfE
    2jbo5gdiS+d9I8zkoB9eKQAL2jpXhjvBAAOOT6+09Z0RvtbKEFw6LrOgJtzqWR6E
    9jxpyEyBsVEcIczUcw6Kh0anf9dQ5d+6/MNiCmqfa0hVaRGu2hxevJ0eLz/mrUwK
    5mVP4Mf8/etVEEVQ6/AKFEuOzEf419nOwPUq+j1YfQYWCHaKSme5be/1BXa+IlnG
    mlpythQG9+b8BKeW8wNb8UWp0Gu/cpjlUefqda6luBqoWgCErBLpS9K2mu85g0AU
    eHyT/zgsN+dCvaP5b54e4dvM6AC08LqWzpfHAwbpHiymLjEF5bGz3JtzCDVgdnA=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934454AbeBMQL2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 11:11:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:37875 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934405AbeBMQL1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Feb 2018 11:11:27 -0500
Date: Tue, 13 Feb 2018 17:10:55 +0100
From: Borislav Petkov <bp@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Lowe <nick.lowe@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Dave Hansen <dave.hansen@intel.com>,
        gnomes@lxorguk.ukuu.org.uk, ashok.raj@intel.com,
        karahmed@amazon.de, torvalds@linux-foundation.org,
        peterz@infradead.org, pbonzini@redhat.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are
 not vulnerable to Meltdown
Message-ID: <20180213161055.GD12578@pd.tnic>
References: <20180209133931.211869118@linuxfoundation.org>
 <20180209133934.259299920@linuxfoundation.org>
 <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com>
 <20180213150007.GJ26982@kroah.com>
 <b0680083-5cd2-e152-0d64-f5a931274a8e@linux.intel.com>
 <20180213155603.GK10945@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1802131659520.1130@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1802131659520.1130@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 05:02:59PM +0100, Thomas Gleixner wrote:
> No. The table is basically excluding families <=5 and a few individual
> ones. Anything newer than that should tell via ARCH_CAP_RDCL_NO and not
> need any entry.

It looks to me like Nick wants 4.9 to test X86_BUG_CPU_MELTDOWN in
kaiser_check_boottime_disable() not X86_VENDOR_AMD. I.e., the auto
disable should pay attention to the CPUs in the table like upstream.

4.9 got the kaiser backports which explains the difference.

IMHO, of course.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
