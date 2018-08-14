Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F21C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5297321725
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcCFwxla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5297321725
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeHNX0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:26:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37752 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbeHNX0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:26:08 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so19638988ioh.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aeEMnJx+uI+EpPSjRM7zCv3uaeUzXJ9j3MIMcn/Wt/U=;
        b=fcCFwxlamSrMaYIQZof2svsrgyXqBSwCMyHKwUiKBeCf1OPENgTbQIQinX4DV5vHRe
         kUpaZmDQ0AK2Pz2JWosJXElbs1Dw9neoS67tJ521aHj1OD7AOssQ2Sn2tG2FyzCY6GHd
         7aUBJD1OSH4+GXpWcgNEpuQOzPUd67o3ags6INMAaF5oXugJkQ7HDNiWGFfiW0uTAwk6
         tBzonCNPHz3+8BkA2B+beSnSuUrO3dikCbPQhSgIclBbuhMirzSm0iGAyTPecFHQ1jOS
         Kd7F2uVSB/m2uWf/biqcERzKi7wg2wAed7Pxk1Vr0AsbVXKIjltseKNbUE2KJSDxwpmy
         hLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aeEMnJx+uI+EpPSjRM7zCv3uaeUzXJ9j3MIMcn/Wt/U=;
        b=Dss9QwVC5uBo4SO7/BES41p7X6dEJi8LygDAkJhpFeu1nmPl9h2JEOCnZcCaQyg1JF
         lxK7Mxelq1uRgkmeX+Degwt9ItFfyubN09MEt9WdnGHCK5OvWaonPYmLVmv6LnBPPrab
         iyL5UTOkQggDb6kMRFCItPZl2iNwIZo4hSVsNpQBJWMLSk5xddDpTmlOUVBkGZeFEort
         wISpQvaHXkL5BuYMWBfpB8kMbBg1Jz5HAB0P8doMUlXEklB42SyEBZsFkyUY8G9IJyg3
         dStFDItvfth8ACDVOGz2oOwcItOTgYjTgGUm2DogWJMccF0LEO+Iaelq0mjv/fkVOOSQ
         gxjQ==
X-Gm-Message-State: AOUpUlG5Xhr6nfaK7Es+mUuIEEy0llr8V+nklMTMjzr8mebhjmvqEKvs
        dpMGqzFwzGlUZDu5c72OOM8X23aRWBnBhphkV5vPWA==
X-Google-Smtp-Source: AA+uWPxtOL54PmraDmcv+4X7LDagJK644S6HuXAv2KWU1IXlNqFbqtigStwKq+RLYcHWfBoa6r3wM+9QX2ZVuLBr/Ng=
X-Received: by 2002:a6b:8f4e:: with SMTP id r75-v6mr20603469iod.252.1534279033821;
 Tue, 14 Aug 2018 13:37:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:ba01:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 13:37:12
 -0700 (PDT)
In-Reply-To: <20180810225246.3d3pa5qvbtoh42bt@ast-mbp.dhcp.thefacebook.com>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
 <20180729205835.34850-1-dancol@google.com> <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
 <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com>
 <20180730172641.7d516231@cakuba.netronome.com> <CAKOZuesNnY8oKimMk+gnUppMgZt92F+razSZCSfHu=xfq+snGg@mail.gmail.com>
 <67423232-be56-fd47-06e6-394812c2b918@iogearbox.net> <CAKOZueu5VdzCEkEv_nR4D0CtYi5r9XOdKOfpKvYWDGPnQGqMHQ@mail.gmail.com>
 <20180810225246.3d3pa5qvbtoh42bt@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 14 Aug 2018 13:37:12 -0700
Message-ID: <CAKOZueuACjK0W4byW7omPvEJ-H-8MK1OU3ORrAfNtsEi8NxoPQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2) command
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 3:52 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Jul 31, 2018 at 02:36:39AM -0700, Daniel Colascione wrote:
>>
>> > An API command name
>> > such as BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES is simply non-generic, and
>> > exposes specific map details (here: map-in-map) into the UAPI whereas it
>> > should reside within a specific implementation instead similar to other ops
>> > we have for maps.
>>
>> But synchronize isn't conceptually a command that applies to a
>> specific map. It waits on all references. Did you address my point
>> about your proposed map-specific interface requiring redundant
>> synchronize_rcu calls in the case where we swap multiple maps and want
>> to wait for all the references to drain? Under my proposal, you'd just
>> BPF_SYNCHRONIZE_WHATEVER and call schedule_rcu once. Under your
>> proposal, we'd make it a per-map operation, so we'd issue one
>> synchronize_rcu per map.
>
> optimizing for multi-map sync sounds like premature optimization.

Maybe, but the per-map proposal is less efficient *and* more
complicated! I don't want to spend more code just to go slower.

> I believe the only issue being discussed is user space doesn't know
> when it's ok to start draining the inner map when it was replaced
> by bpf_map_update syscall command with another map, right?

Yes.

> If we agree on that, should bpf_map_update handle it then?
> Wouldn't it be much easier to understand and use from user pov?
> No new commands to learn. map_update syscall replaced the map
> and old map is no longer accessed by the program via this given map-in-map.

Maybe with a new BPF_SYNCHRONIZE flag for BPF_MAP_UPDATE_ELEM and
BPF_MAP_DELETE_ELEM. Otherwise, it seems wrong to make every user of
these commands pay for synchronization that only a few will need.

> But if the replaced map is used directly or it sits in some other
> map-in-map slot the progs can still access it.
>
> My issue with DanielC SYNC cmd that it exposes implementation details

What implementation details? The command semantics are defined
entirely in terms of existing user-visible primitives.

> and introduces complex 'synchronization' semantics. To majority of
> the users it won't be obvious what is being synchronized.
>
> My issue with DanielB WAIT_REF map_fd cmd that it needs to wait for all refs
> to this map to be dropped. I think combination of usercnt and refcnt
> can answer that, but feels dangerous to sleep potentially forever
> in a syscall until all prog->map references are gone, though such
> cmd is useful beyond map-in-map use case.

In what scenarios?

In any case, can we submit _something_?
