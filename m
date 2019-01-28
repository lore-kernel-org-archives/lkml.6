Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02045C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56532147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOXE9mls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbfA1QIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:08:44 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35377 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731771AbfA1QIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:08:39 -0500
Received: by mail-yw1-f67.google.com with SMTP id h32so6937724ywk.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0rb+admgqujxz8uCtJLl0Rf7qV1TQ5qEBaCJcsbcKE=;
        b=wOXE9mlsqSzCnNKDjZ4de5VkO420siVjvekQdDBL2INCdraE6pj5XAX+vhi4jyxdXW
         yDCJyDgEAeh+fT7R6wF1MjXjTejgF8pb5/MfAurddLddFBlZXOSuoxuE233Qi3HjVSqo
         4GoZCjUBcPzKXWpUw1LcvBnU5kU3ubaHiZQclCUtzFKiL4hJHZ/MOAOwguW0MY2W+ZrX
         F6zCrCUEuwRXz/80NBnkgnrbHR9sL0VgmzPbZNQjiwerNp2Q9J13nCdAoPxwwD5K51g+
         tpnGlywKwCDWKUuQeurnWePHgElLGsMvJeWbyO0eh+ZkjFYyh1NP/o3GlX9dOCEavRlk
         xU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0rb+admgqujxz8uCtJLl0Rf7qV1TQ5qEBaCJcsbcKE=;
        b=Ok0JRJmEs+jMKfXULIaHE5pcvWsE/v4W0xkBpwa4gAgPGqz697RxBVZCx9TzaxjlHK
         QJ//oYlgJ7tgI5p5/E+Gz49RIbhGsI89L6H3opLg+gk4Qk7MZbWtrRsYN887KdCQ070I
         9UTPGOQNr73VApcPs3K9mJPYIMzOVIEgrP+6D033HStu41jIY5XytCUmApKMTS6CvKjf
         Mr1s2ldIQypG/41yvxdAPi3Yb6VhPYxqBW2/qIVC6F8pJzqxqgLJwTMUCjUaUlmtska7
         maIANXmcfUIM8hz0Twt76hqK5kva3bsJUbvvbH9I2ZgNHJ8+1zjeUE/kOeDFrN7jdBWF
         2HIA==
X-Gm-Message-State: AJcUukdUVi10lbc/53+9rFHCYitYvXxf9pchZSO02tAx1WWAvFKuWj5y
        1kSDhZC6CF9f5q/70LCXQ/tPiZhmfzdyn7esbgDeqg==
X-Google-Smtp-Source: ALg8bN4RMJBWBGwdTY3r88jgG3etUuaEixGDkGVTMtKvivTJl1EKc4QuLJQ7/1dgTKj1KyPF3jcfX2IZmpCtemH2i6o=
X-Received: by 2002:a81:ee07:: with SMTP id l7mr21449063ywm.489.1548691718003;
 Mon, 28 Jan 2019 08:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20190123223144.GA10798@chrisdown.name> <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org> <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org> <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com> <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com> <CALvZod6LFY+FYfBcAX0kLxV5KKB1-TX2cU5EDyyyjvHOtuWWbA@mail.gmail.com>
 <20190128160512.GR50184@devbig004.ftw2.facebook.com>
In-Reply-To: <20190128160512.GR50184@devbig004.ftw2.facebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 28 Jan 2019 08:08:26 -0800
Message-ID: <CALvZod5Rrr6ENW5yLNzniFeFmGB=mDRH+guNLmcayTX-_xDAGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Mon, Jan 28, 2019 at 8:05 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Shakeel.
>
> On Mon, Jan 28, 2019 at 07:59:33AM -0800, Shakeel Butt wrote:
> > Why not make this configurable at the delegation boundary? As you
> > mentioned, there are jobs who want centralized workload manager to
> > watch over their subtrees while there can be jobs which want to
> > monitor their subtree themselves. For example I can have a job which
> > know how to act when one of the children cgroup goes OOM. However if
> > the root of that job goes OOM then the centralized workload manager
> > should do something about it. With this change, how to implement this
> > scenario? How will the central manager differentiates between that a
> > subtree of a job goes OOM or the root of that job? I guess from the
> > discussion it seems like the centralized manager has to traverse that
> > job's subtree to find the source of OOM.
> >
> > Why can't we let the implementation of centralized manager easier by
> > allowing to configure the propagation of these notifications across
> > delegation boundary.
>
> I think the right way to achieve the above would be having separate
> recursive and local counters.
>

Do you envision a separate interface/file for recursive and local
counters? That would make notifications simpler but that is an
additional interface.

Shakeel
