Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-309776-1518537381-2-5622042844169422341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518537380; b=T5tBalNmCxQVGIotfts+RGaGBSy8CPCJju9BO0sJ+MhPzSR
    RJ1TegDfc6W9qXAOEhZu0IkLdpuUXMN7Hc5V5ORU/yyNzYW0wtZM2v3WbgPTQJpr
    gAudoPySHUZ8xKKMd4iN4TPnrbVw76jZnEaVHr+03NU1+d7Isw62ncPWP5rji27Q
    JD5Z1ixuIJWcW36uLIPMxzzJpRmVxxKnOuen5sdNKiBZEf7hb2VuD0C/Lv8XjEhB
    wd16eangbdFAF35Rv39JYYO9EbpAbVc4niWzUgvk6VrXZ28TRcEWkr4R2gbDIdUf
    +L60DK0uzHM5Caphee+KMq+xgT8MkBTPEzEpuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518537380; bh=TuwBfnGcQ4RTcAVd5VOLnwiI5Q
    kQj7l/SQ/1tx/onQA=; b=Q+5SatKy3yPWQX9YFgAzuGEJOltq2e1o5cED7GdhlC
    YLcP0rMejs2dqwodC+isW7Z0gVdoaCUd4j03RuE6e7AmD6Se2aFXXSYLT07r/C9b
    3YiD2PBOuK9ttsSinOxM5MN9vmkRDs0YASyg1iUWEQYu8lGR6kq5rbFl1OyjbCmu
    gb7e7iFwZX6+KkCt1Yr4lJCUMgz6BpzvnGSj1aNhp/YEwqnAscRC1ipoMQHDINP1
    fWcA5e+g6z+H1Iq/HMR/VxLaukahDt4Cmw4x5f7tbVjWZgNBXGfWbG8xC3B2gNCz
    VfOg/19UfBQWN0cbguPeNZYgeuMkzNe6OyzHfFgyapRQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933698AbeBMP4S (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 10:56:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:35211 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933440AbeBMP4R (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Feb 2018 10:56:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="200832115"
Date: Tue, 13 Feb 2018 07:56:03 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Lowe <nick.lowe@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        gnomes@lxorguk.ukuu.org.uk, ashok.raj@intel.com,
        karahmed@amazon.de, torvalds@linux-foundation.org,
        peterz@infradead.org, Borislav Petkov <bp@alien8.de>,
        pbonzini@redhat.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are
 not vulnerable to Meltdown
Message-ID: <20180213155603.GK10945@tassilo.jf.intel.com>
References: <20180209133931.211869118@linuxfoundation.org>
 <20180209133934.259299920@linuxfoundation.org>
 <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com>
 <20180213150007.GJ26982@kroah.com>
 <b0680083-5cd2-e152-0d64-f5a931274a8e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0680083-5cd2-e152-0d64-f5a931274a8e@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 07:09:44AM -0800, Arjan van de Ven wrote:
> > 
> > So, any hints on what you think should be the correct fix here?
> 
> the patch sure looks correct to me, it now has a nice table for CPU IDs
> including all of AMD (and soon hopefully the existing Intel ones that are not exposed to meltdown)

I don't think the table is nice, it's a white list that would need
to be maintained forever.

-Andi 
