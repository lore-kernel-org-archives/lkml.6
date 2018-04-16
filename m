Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4109416-1523912915-2-7876554624685368316
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523912915; b=o1EfrOW4aBpPyiGsTUEaHkZeZLYIfk81/LOBDJqyymuGEqTJol
    7PFr1ymfG6JVG/r6Ej1jonnFUi78zLGP/gv9PYzhV7DGSWg/raz7un4M2rwWWtFA
    9Z8RwpPQP6sJF2DYMzQPbcmeH+UC3Q071YCe1PcdEwz0TbZa+cN8mfVaWr2gCjqk
    zKJDNGuAFqckTElS7/yqqMWahTQtXo/w9n+h3695DNkWyTrCioCYTe1XZfcySmUQ
    M7gSwSAA5zeFjhCr2vETs3/reOBPlog6GlNhLEyeXoppMwgacuofTE8qTbawnmyr
    a0KaSii8cFblW2xzn1Y1MIQa0TanHPLB3QYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523912915; bh=d18T/WOr6Kx85IX1pEdCtkUrwJ9ExLXtOO8NTtr
    JE+g=; b=ZN4UVSRF3+Ra+uLb+OOMP3frxkVgu26vrT/Z4O1DgQSeeJD7njftWaU
    fjcrGQFA1D6Ge7jcENfdDmU9Da7jWZ5jlFEVMzYIjRl7UoXPTKfF5lDPu0BWv4vr
    pcEHkH6J+Qy6jatDr+rVN7SM3fXD/EC0TdmlcclaR6eNGFKAYbIwI9EMvVCzz+WI
    FIrpYUeozs1pSyQ4rZhaBiaOm028m3utB7K32es+ltl+xPmeXb3HA/wKjuF1eOrs
    XnpeSAI6RocNMOyr7Nrm5xgPaDJlV25nFMHCGnyaiehRayrFv6camhjqRysm73Bi
    pnksAx4Wmm0Tn/Th6kW1Y0AwHLLPLDQ==
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
X-CM-Envelope: MS4wfMP2KoHrYsjfZBJhdX4ID022n0YjDV6rqzLhPKMOjmwomXCLvPuJ3JjMJzL1H24W8z6B7jZTi0aWXsbngFq0Erjwy/vjPNYkYgaitd3BkR+A0BRKKEIo
    P8iUINtVEHVkWvYlxVz8XHxFEcc8cNFvcxJKD/ZTK9Z5jBcqYsPW+tRZjY08QUO3Hi0xbqw45YKXnov5TfDD2dhomU+xDv8rC64AgsQV0//JqLQT5BxFoGqr
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=nPrQgheNp4Hoj8gRxwsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeDPVIc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 17:08:32 -0400
Received: from twin.jikos.cz ([91.219.245.39]:58197 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750917AbeDPVIc (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 17:08:32 -0400
Date: Mon, 16 Apr 2018 22:17:17 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
cc: Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
In-Reply-To: <20180416171607.GJ2341@sasha-vm>
Message-ID: <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm>
References: <20180409001936.162706-15-alexander.levin@microsoft.com> <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz> <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home> <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm> <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm> <20180416170501.GB11034@amd> <20180416171607.GJ2341@sasha-vm>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018, Sasha Levin wrote:

> So if a user is operating a nuclear power plant, and has 2 leds: green 
> one that says "All OK!" and a red one saying "NUCLEAR MELTDOWN!", and 
> once in a blue moon a race condition is causing the red one to go on and 
> cause panic in the little province he lives in, we should tell that user 
> to fuck off?
> 
> LEDs may not be critical for you, but they can be critical for someone
> else. Think of all the different users we have and the wildly different
> ways they use the kernel.

I am pretty sure that for almost every fix there is a person on a planet 
that'd rate it "critical". We can't really use this as an argument for 
inclusion of code into -stable, as that'd mean that -stable and Linus' 
tree would have to be basically the same.

-- 
Jiri Kosina
SUSE Labs
