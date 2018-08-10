Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD2C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D69223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxWxqFcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D69223E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeHKBYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:24:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46564 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeHKBYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:24:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so5138042pfn.13;
        Fri, 10 Aug 2018 15:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r5Zx3jLyz5UnPm5gmBTdOTfJdyK5/0tWjYpELaC+tT8=;
        b=IxWxqFcnLD0mb1DuYuCnPPfRaTonUXh9yYRCyEbfE5i2kxNYK/BVA8f13PY8ZPwvQC
         wHBrnqUhP7Ty/d2BJvkJ8KoG2sFp6MfkO7erCvsrz5j3SULSSAEZrD6wotk4J30/lxH9
         T4OtdayVnRoM/2UxBtAkH78hVSc6vHla8eU4AReP4k7qBEun+gqws8dRr5zZamLMEH/t
         /zht7qafwsBZgmjcvWdqlRlJz8tM87ExakUhUG5fVDrOrLIAIA74qWYv/z8vTSYrkur8
         Sd9lM6oJpHe9aB4BycTQ6NiBz4Yj977OVI4Ib8olG9nJAD4uf18Zc3j+9coKNT+iflvn
         cfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r5Zx3jLyz5UnPm5gmBTdOTfJdyK5/0tWjYpELaC+tT8=;
        b=m2WcKmKO+2NISjBmPPzyr++KISRe+4oqF6kjIX7Nd9MW0Yl0E0kTuu5CAxcb1/f9XJ
         H/TZKL526+uB0Z6Z4Pv+/MBOkIYeQvUvIQTL6hc5zmhP6FzZR/nxgBt+eNiz4Ce6RNg+
         Ot1MVkM4LtFjfdOvUui0APHmSaGoqUsdDumL4+c4cBNyNqtiDrcFM4pqwDO3Mow4LZdS
         sGTpwktYReGaKleyYHx3pDmgCmXABweCnRah77NHvaAoSpMrDjzNeVyR1u0/w02EgfXm
         +P3iAB6oCMe384FsXX/njg15rIoFV9WgzI+yiw9sguYuhusZXAMFQkU08DekYbzRuNoS
         6qyw==
X-Gm-Message-State: AOUpUlGNWi/RRtFkMAr/fAJO/O9MsznSbUhkKh/iP/Voi+39L/c9W1tS
        k5KpV/D6bx1oRE1/a4vv3R4Y9dzR
X-Google-Smtp-Source: AA+uWPylrqkpg0badehA+YXmiIqL+oPUvPLFMXnl0pUWwiDk65OwJ6cgDtG42DwF63mrvDX6UVKZvQ==
X-Received: by 2002:a65:60cd:: with SMTP id r13-v6mr8157371pgv.232.1533941569897;
        Fri, 10 Aug 2018 15:52:49 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::6:e23f])
        by smtp.gmail.com with ESMTPSA id w192-v6sm12586819pfd.74.2018.08.10.15.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:52:48 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:52:47 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Colascione <dancol@google.com>
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
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2)
 command
Message-ID: <20180810225246.3d3pa5qvbtoh42bt@ast-mbp.dhcp.thefacebook.com>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
 <20180729205835.34850-1-dancol@google.com>
 <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
 <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com>
 <20180730172641.7d516231@cakuba.netronome.com>
 <CAKOZuesNnY8oKimMk+gnUppMgZt92F+razSZCSfHu=xfq+snGg@mail.gmail.com>
 <67423232-be56-fd47-06e6-394812c2b918@iogearbox.net>
 <CAKOZueu5VdzCEkEv_nR4D0CtYi5r9XOdKOfpKvYWDGPnQGqMHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueu5VdzCEkEv_nR4D0CtYi5r9XOdKOfpKvYWDGPnQGqMHQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 02:36:39AM -0700, Daniel Colascione wrote:
> 
> > An API command name
> > such as BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES is simply non-generic, and
> > exposes specific map details (here: map-in-map) into the UAPI whereas it
> > should reside within a specific implementation instead similar to other ops
> > we have for maps.
> 
> But synchronize isn't conceptually a command that applies to a
> specific map. It waits on all references. Did you address my point
> about your proposed map-specific interface requiring redundant
> synchronize_rcu calls in the case where we swap multiple maps and want
> to wait for all the references to drain? Under my proposal, you'd just
> BPF_SYNCHRONIZE_WHATEVER and call schedule_rcu once. Under your
> proposal, we'd make it a per-map operation, so we'd issue one
> synchronize_rcu per map.

optimizing for multi-map sync sounds like premature optimization.
In general I'd prefer DanielB proposal to make the sync logic map and fd specific,
but before we argue about implementation further let's agree on
the problem we're trying to solve.
I believe the only issue being discussed is user space doesn't know
when it's ok to start draining the inner map when it was replaced
by bpf_map_update syscall command with another map, right?
If we agree on that, should bpf_map_update handle it then?
Wouldn't it be much easier to understand and use from user pov?
No new commands to learn. map_update syscall replaced the map
and old map is no longer accessed by the program via this given map-in-map.
But if the replaced map is used directly or it sits in some other
map-in-map slot the progs can still access it.

My issue with DanielC SYNC cmd that it exposes implementation details
and introduces complex 'synchronization' semantics. To majority of
the users it won't be obvious what is being synchronized.

My issue with DanielB WAIT_REF map_fd cmd that it needs to wait for all refs
to this map to be dropped. I think combination of usercnt and refcnt
can answer that, but feels dangerous to sleep potentially forever
in a syscall until all prog->map references are gone, though such
cmd is useful beyond map-in-map use case.

