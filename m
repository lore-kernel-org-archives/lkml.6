Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E16C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E144B21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="YRJP2+e4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfAXBDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:03:08 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35231 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfAXBDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:03:08 -0500
Received: by mail-yw1-f68.google.com with SMTP id h32so1749204ywk.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 17:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ANT2kmcy8XCRyXb6bJChLK8lZ+sD1OWRerQylYMcD5Y=;
        b=YRJP2+e4GkpC3N9LH13Jklf+b52TXUIXm1aZ/dAd8d33MJPiGGyM2d/Abr6eJFIbQ+
         faCv/jKC5Y/zr8L8UO7Uvrl6xIrYt20NGZq7Qic0nboDCVjvyJx9j61Z7Xi/DnMFStZ6
         EwgUI0lE8akX0v/Km9bGvxHn+Ay5+MQh74DYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ANT2kmcy8XCRyXb6bJChLK8lZ+sD1OWRerQylYMcD5Y=;
        b=L2RaIFCcy7MAANHQ1HAQWOYb62us5cVozFETpZ+duErsSQzTSTeLjtdzclTh6zGHwH
         eKv+vLCLamW/gb4uIInMR8VCDXhRS1BLRFV3VuRnoNlqtwmhPmHBZGPNRCchisK2o4xd
         W3+gBMmO1rkZDV5UO2K4Yu0B52GQeAI3WK74ovDTz1EI/9Mgp4QTNkS64Jdte/9lx0kd
         ha9zkP4IML9eqwhVNli+eLwjjSj7Hnk+VtxfQxLPWtkIHSYG0580/CkTMsUuJ1jgieEB
         Fc5i75ol097Z8GbhtZeKNhbO5opr050AQRtyRLsNo7O7gExhYVl+gt+tKztmtInsWnO5
         CETw==
X-Gm-Message-State: AJcUukdWaovSIjfYc9ymr/1Ypce09y0Kz7Z6xmMSSsxQXrofu4wozRN0
        pwo/JNGDVXDLbogcm7qIT/rF4A==
X-Google-Smtp-Source: ALg8bN78UCoTiiIZ4NYfDgJwO0U0Qzpm5eVNWQsn9LahL7nHatXUqYrfYeqr9m3Yy/hxZiom30/pJg==
X-Received: by 2002:a81:ad8:: with SMTP id 207mr4370537ywk.188.1548291787667;
        Wed, 23 Jan 2019 17:03:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:a24b])
        by smtp.gmail.com with ESMTPSA id y187sm7668110ywf.50.2019.01.23.17.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 17:03:07 -0800 (PST)
Date:   Wed, 23 Jan 2019 20:03:06 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190124010306.GA9055@chrisdown.name>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124002359.GB21563@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190124002359.GB21563@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Gushchin writes:
>On Wed, Jan 23, 2019 at 05:31:44PM -0500, Chris Down wrote:
>> memory.stat and other files already consider subtrees in their output,
>> and we should too in order to not present an inconsistent interface.
>>
>> The current situation is fairly confusing, because people interacting
>> with cgroups expect hierarchical behaviour in the vein of memory.stat,
>> cgroup.events, and other files. For example, this causes confusion when
>> debugging reclaim events under low, as currently these always read "0"
>> at non-leaf memcg nodes, which frequently causes people to misdiagnose
>> breach behaviour. The same confusion applies to other counters in this
>> file when debugging issues.
>>
>> Aggregation is done at write time instead of at read-time since these
>> counters aren't hot (unlike memory.stat which is per-page, so it does it
>> at read time), and it makes sense to bundle this with the file
>> notifications.
>
>I agree with the consistency argument (matching cgroup.events, ...),
>and it's definitely looks better for oom* events, but at the same time it feels
>like a API break.
>
>Just for example, let's say you have a delegated sub-tree with memory.max
>set. Earlier, getting memory.high/max event meant that the whole sub-tree
>is tight on memory, and, for example, led to shutdown of some parts of the tree.
>After your change, it might mean that some sub-cgroup has reached its limit,
>and probably doesn't matter on the top level.

Yeah, this is something I was thinking about while writing it. I think there's 
an argument to be made either way, since functionally they can both represent 
the same feature set, just in different ways.

In the subtree-propagated version you can find the level of the hierarchy that 
the event fired at by checking parent events vs. their subtrees' events, and 
this also allows trivially setting up event watches per-subtree.

In the previous, non-propagated version, it's more trivial to work out the 
level as the event only appears in that memory.events file, but it's harder to 
actually find out about the existence of such an event because you need to keep 
a watch for each individual cgroup in the subtree at all times.

So I think there's a reasonable argument to be made in favour of considering 
subtrees.

1. I'm not aware of anyone major currently relying on using the individual 
subtree level to indicate only subtree-level events.
2. Also, being able to detect the level at which an event happened can be 
achieved in both versions by comparing event counters.
3. Having memory.events work like cgroup.events and others seems to fit with 
principle of least astonishment.

That said, I agree that there's a tradeoff here, but in my experience this 
behaviour more closely resembles user intuition and better matches the overall 
semantics around hierarchical behaviour we've generally established for cgroup 
v2.

>Maybe it's still ok, but we definitely need to document it better. It feels
>bad that different versions of the kernel will handle it differently, so
>the userspace has to workaround it to actually use these events.

That's perfectly reasonable. I'll update the documentation to match.

>Also, please, make sure that it doesn't break memcg kselftests.

For sure.

>We don't have memory.events file for the root cgroup, so we can stop earlier.

Oh yeah, I missed that when changing from a for loop to do/while. I'll fix that 
up, thanks.

Thanks for your feedback!
