Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475045-2-416612911863151554
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475045; b=t8KyaMSlDrlmXDiOMWEhBLcP/WfadeUIRK8VLtM5SwKKZ/q
    i4U7dE4vFWEqLjbc9YwkMike3OvP8VymQZRR4K/J8yuUS1SmCrWJOGdhMnnsk+WW
    zyep8e3lS+DF6yNxHqS5IQ7NHJ7HYc/jPnOhdTltFBpramY04ufyD8r6fjmnZpsJ
    UYF0JI1ezucqS1K5J98zAbAOrNrAqi+RXqghwL6qLzeLPb1dhAfm+VSE1g5sIVWt
    HDmMxgLFZAwhPJrOU38vh8NlskPLJmr1k/PEb3hzGVqGuT+DpaGJyMnI+DZuE90f
    eAbKFq/3vthDUvwK0mNBCFN+TJJREigh/8alIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521475045; bh=urnEFuR9F+Mcm1pHIGn4KuJjVa
    MqMZnzsluGO9nAtEU=; b=Jv9axOUF6E26cecZoqURH/t1sH/77PyBxcTN6MXJuZ
    /4l8kmBwGdSRUu+Doko34yr1ZxdqTpYpbb2dsTy+gqhITuIyE9BTQ8ZQ/jtNgkSU
    rhTugVSh0pFRtCuY9+6DN+Y5UNEBvLW6h9PcxnBIKhYsWitmY/aOWESfBUq7sRMo
    oqi0xJ2/Qimsmi9yAam6UdWGNI2y/aJckk4CIHJtetpzLhSc8T1rSFQIWqxSvCfL
    9YKDuZS4qIWYOSea6AhLEYYSsfMWL46iyrSYF3JYtsTNgoZk53zJ2t6qCyETCVkN
    rEMxSv1LQSUvM7hVjwfzY4x38cbU0Q0uXnBskIhP/C5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=strlen.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-90 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdluddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomhephfhlohhrihgrnhcuhggvshhtphhhrghluceofhifsehsthhrlhgvnhdruggvqeenucfkphepvddtledrudefvddrudektddrieejpddugeeirddtrddvfeekrdeijeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedujeehjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=strlen.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=strlen.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-90 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdluddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomhephfhlohhrihgrnhcuhggvshhtphhhrghluceofhifsehsthhrlhgvnhdruggvqeenucfkphepvddtledrudefvddrudektddrieejpddugeeirddtrddvfeekrdeijeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedujeehjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=strlen.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964818AbeCSP5S (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:57:18 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:38980 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934671AbeCSP4v (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 11:56:51 -0400
Date: Mon, 19 Mar 2018 16:56:49 +0100
From: Florian Westphal <fw@strlen.de>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH AUTOSEL for 4.15 070/124] netfilter: core: only allow one
 nat hook per hook point
Message-ID: <20180319155649.GF13873@breakpoint.cc>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-70-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319154645.11350-70-alexander.levin@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sasha Levin <Alexander.Levin@microsoft.com> wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> [ Upstream commit f92b40a8b2645af38bd6814651c59c1e690db53d ]

This patch is broken and a fix is not in any tree yet.
