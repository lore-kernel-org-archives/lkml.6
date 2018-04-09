Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-442848-1523262173-2-18277121246882639624
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
    1523262172; b=bS+L2ACpvFz1GCWXub7GTgqkDfnsxmeGys2+FRUVwnA/a4FTY+
    3hIHDMQ/Zpu8FdoV03mHgvcM9TlffQ5QdXm4hAWpw5BDi0kGHojSUIMT4nr/rpyw
    eKPT6875rGbDjMJDZcp46oE7Z+t7CmTtW8Jv1cWsP/VSm5eWGH+HvcqbAN2el4Rz
    Uz0mFPNCU/iAQ9t/nRycdcC5w2vyhGJq5nQP9JKJ4y6aPHhAsWyrrb7jl6eOUe2P
    X6R3bHREXUazs71WzyR9OjFs3v2J8LHGofhk25ifgRqPZWPU2RBry0vbfPKOnt3Z
    xIToDegv17NcAyxsAiRm2NmcJ6QIBTa3W8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523262172; bh=gcn68oFQRaz8vNRzq1yEwQdPEYmkZB
    PDrX60oqMtN+I=; b=YytfcyYV9a/pLVqObTweBZ85TOnOQd4Ho+5aZdQhk5bQBo
    llJI6jrxtIlWon3nRn/uMj5uv8GGpb6/wSrlYh7ZVq6HdBP2PYYFYB13bx5SFtzE
    Ot3SOZsl4Tmdy6YzsGEHZkiW/5dhiu9pHythTkzEmyMEcjdsx3mJtxw2OGSuuqBw
    /SgdMSlnpGBkYM+9lorOShmJ1kOcSCnhdE6gGDxdeOOCmh2TE9jD7yC9LoGP8Y/0
    aO7WP9FNkISZm9m/jNq8hQpgSzunSqR1VAjgKlfA43wSoi/Oz1rx6ilUaKvldDSN
    YP3kmV4Rng/sgvcC66ucGjWA1skDZbnYeeQLvaTQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfMswIPb1ih9q24E1IQNhjAUSI+b9vd8t5ux8PtkUu/yisHoS7hQqht3lotehC1qQOBcSBVZ9ykqtw5q6eCbMqnm+BLgXe/2WFCe0zbwNBKvnlpeCzMLX
    Upz1vP5jKsIv1OvxqGTajB3SOlBNHELH7qhh5eaev22Wsc5vmgc1G1VHYsYbAWK4VLMNo8yEIQpn7VSX8amioIQgSXUcpuxlSQR0j7Tn4uLX4/AZpv/ho4DR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=dXzCWX43MyEELooMGfYA:9 a=CjuIK1q_8ugA:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeDIIWu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 04:22:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:44087 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbeDIIWt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 04:22:49 -0400
Date: Mon, 9 Apr 2018 10:22:46 +0200
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
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409001936.162706-15-alexander.levin@microsoft.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 2018-04-09 00:19:53, Sasha Levin wrote:
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

Same here. I do not thing that this is a material for stable backport.
More details can be found in my reply to the patch for 4.15, see
https://lkml.kernel.org/r/20180409081535.dq7p5bfnpvd3xk3t@pathway.suse.cz

Best Regards,
Petr

PS: I wonder how much time you give people to react before releasing
this. The number of autosel mails is increasing and I am involved
only in very small amount of them. I wonder if some other people
gets overwhelmed by this.
