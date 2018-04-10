Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-157256-1523381429-2-765392821758300777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523381428; b=ps/lWziJ3MMwou5I3BsdY90Q4XvMrRkPMxuc3hBqTJALEh4yUj
    9JRzP0wJwgpO3K4n/iUNaWxCoUH7uoKUQqZn73ydNYQbyALL29Bt+bHR3YIWC/bB
    3AbSTixQawATmzXYUEsZFB0B76f5nogBMDBcJVxB7szcRKyLUu/tpypGtIpC5ou3
    aU0EZm0khuN2a/rYt/hXwhVr0ZOuUtNmNOR9fQwKzdFUitqWapP7cZpN4PL6iwyM
    xGmACGHUbiXvxpX4CLynOI9tVFaDJsaBYal+Lvu3MSYuGkkwy2bN0bKFmSoMQxvq
    6Ntr6TIlJIcmvtHZgQ9B3HRyfcqn0XwZt6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523381428; bh=y0YfzCp6PG1/Tkx+vRCawXy1qOB+8RC8LR+yTEE
    S7VA=; b=v7FxJMA+lfFbg+SRwBSHn2iXdC67uK3RzVqXmgeZkKco/5VAFG1YBMo
    gEZA8U8W4km8552RdS9oDFK26Xf7ACoRiy6Mo4nrmbFeE8dGTDT+/eKLhWqqU0l3
    5BhQpuDF6j1S162/K4FF2rLfetIye8DD4ysEsTbo37P6EjygmdUlzHpkm3pAy+af
    yjaUYPAES4aetTLzTKF2naWPYorIuaQmhWvJSkcy5K571KqQZHbt3CUOigZOLM4S
    sFzGlzIj6cw0tOg5A5nr8NgzkoCl9ViwDBxKMbUXq6PwBoOHXvYTQAyrJtTWeewR
    /IuZ1gwwizRGSMgACeI1qOBGnSIHT9g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDlRXXYPzXWoYt7CCX/Lf6nDmRGtUuDICjqEZylN8QAZ+U2km3qN4yqYfQOxUBLtHXdDt985g+nQNBwEz64b1KXtYYNdMjNb7Y9Zi1Qwa7yZ2Z+JjTyi
    ls3pJPi1quBUZYxe90u4FUnpVMMZlIRuxhNEnUdPzZfFuV9b53RApeU9jjHtmQct+hGRNEzHZpbz06LQrDPwIMq7Fz9Z4ciXRxWBD3QlhgpGChRZ5yNFvEzW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=khwyK8DuSVkA:10
    a=Kd1tUaAdevIA:10 a=KBlYRy2rSXyWRtoMcXoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeDJRa1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 13:30:27 -0400
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:42828 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752016AbeDJRa1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 13:30:27 -0400
Date: Tue, 10 Apr 2018 12:30:23 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: Eric Dumazet <eric.dumazet@gmail.com>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a
 constructor
In-Reply-To: <20180410165054.GC3614@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1804101228170.29384@nuc-kabylake>
References: <20180410125351.15837-1-willy@infradead.org> <fee8a8bc-3db5-a66a-33cb-0729143ba615@gmail.com> <20180410165054.GC3614@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfMT783t3W6VDnS5BMNi/dXae33+W6vKnGhR+4E6OtmIeuLQBz2eQrDhJeFxz/Ds14d+R12UAtRvAiJla837yr1wnifThlbeTskDdinZVC8A/sSbs20UX
 ma265iMQQKAk8GhZtA0pUJyLUFVXBpXbLxDxOWwPEausom3SgMVid4CEpVapGe3Dxisl9kpWUCL81A/OVSVq1AUu4qNP/02nW6WkyW/eec+FQiLra5gQhVwv
 4WbJOeFshglwcm/UO5rbqceXg2dI47GT23n3nQppR+IqYx0hG0PhaGWfMlG3/bCWHgEiQW3h7kIDo7RFviWkV46OZhm6qnYg06Xv4+Mg7lr/KSZPVHzOsH55
 Rr37SXYx2ZLA5Vv+MZHG3nJXl2Bkz4YC9QNKHwqwk8ye4CqHxaGumJzHW8OA2A7UbEwyKCVZlUtqilWNWXcWU1l2xMYNQLKt6PqpJSCPLPEfdDwOzQH9BHYf
 F86iK7RUPBk3sXWorZ4ZQZn20+qNdkWpnQAz7FAcou3WYKSTcZh/W+1/N1OrfgmnkTZxT8xYgyRaI9vaBo05Gz6OQwU+xetpsUsiCw==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 10 Apr 2018, Matthew Wilcox wrote:

> If we want to get rid of the concept of constructors, it's doable,
> but somebody needs to do the work to show what the effects will be.

How do you envision dealing with the SLAB_TYPESAFE_BY_RCU slab caches?
Those must have a defined state of the objects at all times and a constructor is
required for that. And their use of RCU is required for numerous lockless
lookup algorithms in the kernhel.
