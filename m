Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB78ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C656C2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="RfPu4v/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C656C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbeGMXDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:03:15 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33679 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGMXDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:03:15 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so13378010ybb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HZKdE5BEkuE41busR47XjmYnRCtqFvpmYwJ64dAu8iU=;
        b=RfPu4v/XumHDR+n+s8fcBUN+mzsf8UVrzt5PgLxCRGYRdHEwfcCXpc3LlZfMgz7t6e
         s+y+uo/IYQYbDXLiJE0NjWCaWHA315ilkxI/tBTDRPgH7CBlOzoyg/Q9RSZeFdVqUM9u
         cidAzqAKgO0wKELYoZOPfR8BQGFy9dx5Lkt+VRxi8XNw9SobhD5yBiIRB19EHSBUTrZn
         28A54Lh2FIEYS5hkFOTqoKgzjuxbvzzN+ul4ks6Yqla3LIxEJ0eFgWzSMH7QhVl2VTiL
         gdj90CU3rqiO7dHORF9aYdZIsJ+DBDuyVkUWGrj9TvKrQKHExpY6uf1YrsIVIslHoidD
         8Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZKdE5BEkuE41busR47XjmYnRCtqFvpmYwJ64dAu8iU=;
        b=NhyYdQtwNdSip4vappq9F888Glq1mqtLP7Cm4xYTTaLe0Yf5ZJNJdC5Gl00JbsrRw3
         QkwWtch8OGNDpB00cOSpScMQ5pv66ysdJasWIczUfN7vjY1VVNA3hZuXYDfaF5TBm2md
         SO7PJqJXDh0o2Tv6RehgyNl+OLZIPdRusoSNIPqrNWewmxjb/IokNVezfkFZtBtn59I6
         ilEqcXNL2DKAlWwxutEDCizoEWmJ460qhT5vXgQBWBbww5wi1bXaA2SmJPszQQ2aORPJ
         yK3xUzO6/OfD5YVv9heteretL63gGZHamYGTMKUGHunEZWGqkdUDq/2jYANPPVsLjI+p
         /nSg==
X-Gm-Message-State: AOUpUlHNN4/XBFTiZmxPwGGdAb63KXPQqP/vZL9ui61b0J0nAghmQLvr
        chffVSf+NjDCYjlR+jeqQlhYZA==
X-Google-Smtp-Source: AAOMgpdGCFC9PqQAXimZLjVFWaeqMSUze9NNNkxvJaEKZ4nK5+WWc9ID5iWmzLq4GUF2xgzV3r8BZg==
X-Received: by 2002:a25:30d6:: with SMTP id w205-v6mr4542621ybw.52.1531521996293;
        Fri, 13 Jul 2018 15:46:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:23bd])
        by smtp.gmail.com with ESMTPSA id u64-v6sm1590819ywu.107.2018.07.13.15.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 15:46:35 -0700 (PDT)
Date:   Fri, 13 Jul 2018 18:49:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH 10/10] psi: aggregate ongoing stall events when
 somebody reads pressure
Message-ID: <20180713224920.GA31566@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-11-hannes@cmpxchg.org>
 <CAJuCfpHGhSs6upZj0ARng-rE1Nbtcr_XHynZhN7EgGdC16tpPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHGhSs6upZj0ARng-rE1Nbtcr_XHynZhN7EgGdC16tpPg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 03:13:07PM -0700, Suren Baghdasaryan wrote:
> On Thu, Jul 12, 2018 at 10:29 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > might want to know about and react to stall states before they have
> > even concluded (e.g. a prolonged reclaim cycle).
> >
> > This patches the procfs/cgroupfs interface such that when the pressure
> > metrics are read, the current per-cpu states, if any, are taken into
> > account as well.
> >
> > Any ongoing states are concluded, their time snapshotted, and then
> > restarted. This requires holding the rq lock to avoid corruption. It
> > could use some form of rq lock ratelimiting or avoidance.
> >
> > Requested-by: Suren Baghdasaryan <surenb@google.com>
> > Not-yet-signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> 
> IMHO this description is a little difficult to understand. In essence,
> PSI information is being updated periodically every 2secs and without
> this patch the data can be stale at the time when we read it (because
> it was last updated up to 2secs ago). To avoid this we update the PSI
> "total" values when data is being read.

That fix I actually folded into the main patch. We now always update
the total= field at the time the user reads to include all concluded
events, even if we sampled less than 2s ago. Only the running averages
are still bound to the 2s sampling window.

What this patch adds on top is for total= to include any *ongoing*
stall events that might be happening on a CPU at the time of reading
from the interface, like a reclaim cycle that hasn't finished yet.
