Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195013-1518534009-2-13211581572695350828
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518534009; b=PDPvS05JXx3fXzGxjFwU96XS+VE9heI/dDOVpP8Sprxv/P3
    skeSj+qINz+jg4C+YCZo1AO1mTZvTefyqWJ+NEMgtdsOLQI7lrX2gPaFR4ur963q
    RdphWxeHEsfaUZX1wgmOUC+2+3tPhRdqoA0X/gefsF4MqYCGz6+nvM07sJoeZLV+
    J3kSLxXN55Vr8soWuEDiutray23cYRUFJVZffTi8AURwvMhm9yT+mnMoO3X5agg9
    HHcq3Td3x3jBm85/mYU5RQoxZMdg2cdGKFoLN7jcK5/1Z+mHRvc9RHXIv7BUCPE/
    JkaU7bje74/x81Zwcx1qyINdrxRixJ1AGmTVh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518534009; bh=uqOqDPT107L8Ke48yVrauwRF3M
    4VNBVIrTlaaHaU0Mg=; b=pQYFeD0pf+gpsD8jufcB3C7vfzWf6xog/8mRKkMehu
    jaez2CVFvP/UVdjAUda91N9wuDnOeSi/JygDg5tRZcLmo+d0iuZLMrbAHHcoLsoh
    KmP+O/B0mXUfxHKVesM4YMElTriSAvlMtqnWmuIQT/uwBR8wdzAbk7f6I/o+8nNE
    4ckljjRCjmkn8ldRXTdl1vusHwlzYhF4y8M0TDSOG81/Lwe3SqmmjQwwhhCoWSxf
    LSVCWymlHvg3eUS4WHq5O70S3uCSXQLggelLgTDsh3Di5SCdhZ9ZoQou8RNcL3aF
    B/uxKDNdP1Em/+FuvKOorFl3LKuPVc2Q6lfUSB4wnXiw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965048AbeBMPAG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 10:00:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45758 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965029AbeBMPAG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 10:00:06 -0500
Date: Tue, 13 Feb 2018 16:00:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nick Lowe <nick.lowe@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
        ashok.raj@intel.com, karahmed@amazon.de, arjan@linux.intel.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are
 not vulnerable to Meltdown
Message-ID: <20180213150007.GJ26982@kroah.com>
References: <20180209133931.211869118@linuxfoundation.org>
 <20180209133934.259299920@linuxfoundation.org>
 <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 01:34:07PM +0000, Nick Lowe wrote:
> Hi,
> 
> This does not seem to have subsumed the AMD specific code in
> 
> x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown
> Commit a8799fd14d9f7f385a5a5c86cde247caf4bb0320
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=v4.9.81&id=a8799fd14d9f7f385a5a5c86cde247caf4bb0320
> 
> x86/kaiser: Check boottime cmdline params
> Commit 8018307a45a90ab2eecfd03d48b7efb31707df37
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/arch/x86/mm/kaiser.c?h=v4.9.75&id=8018307a45a90ab2eecfd03d48b7efb31707df37
> 
> Here, we can see:
> 
> +skip:
> + if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> + goto disable;
> 
> Refer to 4.9.81's kaiser.c
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/arch/x86/mm/kaiser.c?h=v4.9.81
> 
> Also 4.4.115's kaiser.c
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/arch/x86/mm/kaiser.c?h=v4.4.115

So, any hints on what you think should be the correct fix here?

thanks,

greg k-h
