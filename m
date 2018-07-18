Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55841ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105C220854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5waLQeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105C220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbeGRQMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:12:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34458 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbeGRQMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:12:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so1677344wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7J26Y6B0RT/seCOATRmWvj06Rt/t35UqXC3SFIon3EM=;
        b=m5waLQeS47+QenvdEprAditz8p6FO5K/Ram+aRuxlabypKzqCqJn49y3jWUVcGb7ou
         Qz7YZOcr1fl27+EvtwZX/e8kx6qY3+VD5z1RqTx3Ohtd98Z38KFXuY1injmT9C/E94dd
         Izoyc1d3KH4c6GKNngyW7VB7R4rgDaKx9i8M64FaHJ0FLx4112ln3rJUqxbmluRj9xGE
         LjC9jCT+YO097+quViOgGr/eLVyDiHJW7HKyMnqeauJiwGjQSg5aYYXA3mrAMTZZzUey
         PLv7dgeYG3gEDyo6G7rnI55wpnBsm2Q9tD6Lksoq08PWqQwNkcre2HQnto3WSQWbICFP
         qDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7J26Y6B0RT/seCOATRmWvj06Rt/t35UqXC3SFIon3EM=;
        b=DGmyDnZNQHaytPdTnF7NoLVjAy3yeirO782EYWE0jWsDskHY+iWIYL8xwq8c/BMYgH
         vqCIh7X7Ds1Clz8573XPN286oeZ81WZuIjJFCIC2E13+y5katw8K0lZMUNmsdyR9nSUL
         ZPhJ9w4cv1D3PykGR10w2xQy2APhqnKZ+eFF7exRmVz0dslsuVnlK06N8XQUPOFwueGj
         zhQUomNHPEqasYJKar/c1j+XOBptFqnDdkRf0H+jX4R3sXSgrHwOHcl7AlZ/TT4rE2A1
         V+CTVbMNa5cBaJE6tbzk9CQHz+2aQFJbm1ftcXI8dkT3Xi0hEjeYjfISsI1woOcKsfGW
         edrA==
X-Gm-Message-State: AOUpUlE1S4Wl9+IqzJgZuvlRL0d7ifbqVJl5BR8wiV1SEVAegkW6AI3M
        ff8mQZJYoMj2KJNE515FIy7P4zVHNF8LE4rPIvTs3g==
X-Google-Smtp-Source: AAOMgpchmSsNflnTI9kAvl2HBK5ogAtZhJ+7WTLzPG/eTwrk60GAv2Kf+vwLR520ei7EVFuTDE3UzzW2DWQuYFREmBM=
X-Received: by 2002:a1c:91c7:: with SMTP id t190-v6mr1997941wmd.2.1531928024851;
 Wed, 18 Jul 2018 08:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <20180718144710.GI7193@dhcp22.suse.cz> <CAOm-9aqLopJouRFd6sQr95yYTJmuoE6y9=VoMEJeyr_OVfQxnw@mail.gmail.com>
In-Reply-To: <CAOm-9aqLopJouRFd6sQr95yYTJmuoE6y9=VoMEJeyr_OVfQxnw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 Jul 2018 08:33:33 -0700
Message-ID: <CALvZod5zCeXECsOeRzkqpKWsG1X4xM-vcv62kzXJTRouvqZgww@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     bmerry@ska.ac.za
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 8:27 AM Bruce Merry <bmerry@ska.ac.za> wrote:
>
> On 18 July 2018 at 16:47, Michal Hocko <mhocko@kernel.org> wrote:
> >> Thanks for looking into this. I'm not familiar with ftrace. Can you
> >> give me a specific command line to run? Based on "perf record cat
> >> /sys/fs/cgroup/memory/memory.stat"/"perf report", I see the following:
> >>
> >>   42.09%  cat      [kernel.kallsyms]  [k] memcg_stat_show
> >>   29.19%  cat      [kernel.kallsyms]  [k] memcg_sum_events.isra.22
> >>   12.41%  cat      [kernel.kallsyms]  [k] mem_cgroup_iter
> >>    5.42%  cat      [kernel.kallsyms]  [k] _find_next_bit
> >>    4.14%  cat      [kernel.kallsyms]  [k] css_next_descendant_pre
> >>    3.44%  cat      [kernel.kallsyms]  [k] find_next_bit
> >>    2.84%  cat      [kernel.kallsyms]  [k] mem_cgroup_node_nr_lru_pages
> >
> > I would just use perf record as you did. How long did the call take?
> > Also is the excessive time an outlier or a more consistent thing? If the
> > former does perf record show any difference?
>
> I didn't note the exact time for that particular run, but it's pretty
> consistently 372-377ms on the machine that has that perf report. The
> times differ between machines showing the symptom (anywhere from
> 200-500ms), but are consistent (within a few ms) in back-to-back runs
> on each machine.
>
> >> Ubuntu 16.04 with kernel 4.13.0-41-generic (so presumably includes
> >> some Ubuntu special sauce).
> >
> > Do you see the same whe running with the vanilla kernel?
>
> We don't currently have any boxes running vanilla kernels. While I
> could install a test box with a vanilla kernel, I don't know how to
> reproduce the problem, what piece of our production environment is
> triggering it, or even why some machines are unaffected, so if the
> problem didn't re-occur on the test box I wouldn't be able to conclude
> anything useful.
>
> Do you have suggestions on things I could try that might trigger this?
> e.g. are there cases where a cgroup no longer shows up in the
> filesystem but is still lingering while waiting for its refcount to
> hit zero? Does every child cgroup contribute to the stat_show cost of
> its parent or does it have to have some non-trivial variation from its
> parent?
>

The memcg tree does include all zombie memcgs and these zombies does
contribute to the memcg_stat_show cost.

Shakeel
