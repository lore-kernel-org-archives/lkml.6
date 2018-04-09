Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-442848-1523261745-5-2153354358515829383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523261744; b=YIsHbosg/djx+Ua7hwSW4i90nA/xAia5PmlZr80rVVu27T9R2r
    0yWoc4zV5M4oICHuu59NYt5BEuaoJi/3UAbK7IlNG3ubeFPHE042KDCQuuzuEip6
    J2p+ygehdqJAdKYslejx48oC56zGL78cx4OyYL5tTFhmL3XNtFY89Sbm7MAsU+jk
    Rp7+YQ2jokpFRILvsLHd7hvc/zaFbkkTMMeVuf49+6GPTkX28TM6VNTOxB13KUbp
    Hk9GHbnH5wwPmlhEq24NfxQyl5a/Y6K+m4V87yxDIbVTd6gPabcLJ9/rBDy3xVTa
    QKWVBQVgXZ47ISLx5p6LsumMeM9uq2hdBM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523261744; bh=UPpA/MttgjqV0dkq6ATXpMnXO6a9TX
    zSiY1WflDpxZg=; b=iSNsyAyN0mP8saEqbkn0H/pMRwyTjG2Tj7KdrO0fnGloms
    P+l+WQ1D6Xb9eM1g63qsXOSIX1rYwgx5L/Z/hN69rnTzSd9MKbhNXnj5mcK/w7gu
    oi8uGFPcc6bNT4j8cL9cPHgxcKVxIuTc+IHsoKnCeT2xgkqfnTWpvQ/Ajn/xKUxp
    0RQkziCfmC2i3eYYYy8Gm7bjgRAkWU23zaRkjnWG+Sq4ixTobDNUMdnpx0kvu9Bl
    xV//UYNg/fmdkXT4xtlkG/FVfXpcgDO/Hqns6QUrpgD0Ygt/v5P9AMW11+fpouuq
    caECWm7CdxlN4QgFM/JDbE/LL/tiVp3Nx4H51q0w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIIVakSJaUBUsweudYx6UIokuRfU/PAWsGDM9eHQrd+YYjq4j1r0h3ULFmAe1llKQ/xC4JJQeTAHw1aVmNHAGiqTFVOFzjwP+Og/0xl6n0haNDAITbTd
    k8eli1wbUxCsHEK7GYkd3zSfFPbak9y6eGbjoQIwm2aRvI+9tTu2GGaUcCLy2wKyHFPzLX1sL2rf9PE5T+g/xobaIXIBKLKcWFAsKdLaPXwLM5ePTdmg8FvZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=seTcLqlwIumQldi3Q_MA:9 a=CjuIK1q_8ugA:10
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeDIIPl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 04:15:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:43346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbeDIIPk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 04:15:40 -0400
Date: Mon, 9 Apr 2018 10:15:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL for 4.15 019/189] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180409081535.dq7p5bfnpvd3xk3t@pathway.suse.cz>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-19-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409001637.162453-19-alexander.levin@microsoft.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 2018-04-09 00:16:59, Sasha Levin wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> [ Upstream commit dbdda842fe96f8932bae554f0adf463c27c42bc7 ]
> 
> This patch implements what I discussed in Kernel Summit. I added
> lockdep annotation (hopefully correctly), and it hasn't had any splats
> (since I fixed some bugs in the first iterations). It did catch
> problems when I had the owner covering too much. But now that the owner
> is only set when actively calling the consoles, lockdep has stayed
> quiet.

I do not think that this is a material for stable backports. Yes, it
is a fix but it is not trivial. There are already 3 follow up commits:

c162d5b4338d72deed6 ("printk: Hide console waiter logic into helpers")
fd5f7cde1b85d4c8e09 ("printk: Never set console_may_schedule in
		console_trylock()")
c14376de3a1befa70d9 ("printk: Wake klogd when passing console_lock owner")

One is just a code clean up but the other two are changes/fixes that
should go together with Steven's patch.

These changes tries to prevent softlockups. It is a problem that is
being discussed for years. We are still waiting for feedback to see if
more changes will be necessary. IMHO, there is no reason to hurry and
backport it everywhere.

Best Regards,
Petr
