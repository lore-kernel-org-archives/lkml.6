Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185BBC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC2B20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+kdv+GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC2B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754252AbeFSW6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:58:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40047 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754177AbeFSW6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:58:51 -0400
Received: by mail-wr0-f195.google.com with SMTP id l41-v6so1255903wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zb3AjJowosb9dhIaQWVidJRDXoJHlmvZeXg5JHXf2xg=;
        b=o+kdv+GSp/AQxWgH4loxhm4G7MLU9afWCP2I8pgEwr24jnPSbZGqm/jRg1iP4gePW1
         UwmrDpSEvwAv1RcPe/nJX1BNZ8FKPBng+YRmS8CuFnKTLrFbmptc0w+gKxgoqHWPGGQE
         eDJSa5B1Q+320W7PfohDAVQk/1ZvADDF3bQxt5TCQ7R1TYAQiLehY+MT5urDSV40Bb4P
         q4ZbvCTzDZhustuEQWOlrWjK3ISVDYb4SRHeukzaRafhtoofYK8mO2dtYak5nA2cqndu
         NugDjEfIY/U/O68/vF3J01WkIknbZQHS4WSnhoX/GVOau8XTIY4W+ItvX+RTETU/8Cdk
         xZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zb3AjJowosb9dhIaQWVidJRDXoJHlmvZeXg5JHXf2xg=;
        b=pNHo8U2LX3Z9u6UoLqRER7pj6savOflmll2eauhOcnDNj9GS5BHietINZHOSY91If2
         53bx2CHvQ2FD2szrHH9xwiS2e96aeKeMqCLg7l6g5tIOY5BKM71pkr63mh05LJ7x56TX
         /ZOpvcuMVp1uNxXKNqSboEf015AvsfJYqBirV8q4sv3jYzL4vPXZSeRFr3bNG3z97wOh
         EEeZ999qiFy+mTd9JKez3SQ8IXueBkXHN/JvoAcEsWdpw5hYOoD6LmNXPuj0tt+zi5IY
         8Qy96RO6wrrSm3QukXCdoB/VwmcJUUnONSeCxCEvCcYbzS5j7udRAbT1tGd+UCe0h/eb
         pd1g==
X-Gm-Message-State: APt69E0zjw8gQbb6Ve0TALxFUrKmSzHYy+bfjkEMGcHpkUPS597YLzur
        z64G4WDxNqwQN2mabGga00kdD/9/KtpkR9ookGPyew==
X-Google-Smtp-Source: ADUXVKLNXcGaPf2Md1deTRiepWMFIB2Ly/hfue8UQrifRvS9egJL29MLvq0G0fYVVjHshmgWKSr6EMH32hdROUspweg=
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr16117740wrd.272.1529449129647;
 Tue, 19 Jun 2018 15:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180619051327.149716-1-shakeelb@google.com> <20180619161149.GA27423@cmpxchg.org>
In-Reply-To: <20180619161149.GA27423@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 Jun 2018 15:58:38 -0700
Message-ID: <CALvZod56hRAjCE25Wc-+O-rc+v_t6a9n3JrD4gTRaFotkcrMCQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Directed kmem charging
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 9:09 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hi Shakeel,
>
> this looks generally reasonable to me.
>
> However, patch 1 introduces API that isn't used until patch 2 and 3,
> which makes reviewing harder since you have to jump back and forth
> between emails. Please fold patch 1 and introduce API along with the
> users.
>

Thanks a lot for the review. Ack, I will do as you suggested in next version.

> On Mon, Jun 18, 2018 at 10:13:24PM -0700, Shakeel Butt wrote:
> > This patchset introduces memcg variant memory allocation functions.  The
> > caller can explicitly pass the memcg to charge for kmem allocations.
> > Currently the kernel, for __GFP_ACCOUNT memory allocation requests,
> > extract the memcg of the current task to charge for the kmem allocation.
> > This patch series introduces kmem allocation functions where the caller
> > can pass the pointer to the remote memcg.  The remote memcg will be
> > charged for the allocation instead of the memcg of the caller.  However
> > the caller must have a reference to the remote memcg.  This patch series
> > also introduces scope API for targeted memcg charging. So, all the
> > __GFP_ACCOUNT alloctions within the specified scope will be charged to
> > the given target memcg.
>
> Can you open with the rationale for the series, i.e. the problem
> statement (fsnotify and bh memory footprint), *then* follow with the
> proposed solution?
>

Sure.

thanks,
Shakeel
