Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13C3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C922206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+ndBDgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C922206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390332AbeKVJ3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:29:20 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40323 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbeKVJ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:29:20 -0500
Received: by mail-ua1-f66.google.com with SMTP id n7so2504361uao.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o23S7xtxzBQk8WzRwVhA8U0qrvy0Ap95NL75oi/N7gA=;
        b=b+ndBDgrx9paBwOIKFj0/SUQ8n24/m5kOtIWtJWSxT4X+VRvsGB0UJPvVggbva/G7b
         ScGvBU/IqHYd3cQOAXhctTmYRVsAlQ+kIj7iPRLN7Ga9Vx5b4XbGQ/hf23AsZrpYtOJY
         V6vWXkRgYIIzYVvZ73BndsY+9ajEIrKMteGoO0sBaBS4gjWIV96Rb5/bs55C5XiDhHjS
         yUSXPQB0aWVQ4a1Wm6zN5aOEQnPMTAN1cIEC17bCEg3j1EAh9GsV1ULHvqWxhTAe7MhT
         yejNwFno+TBqKpYmKKjFncNn62smbg4K6+mA9R4YLYOi0lcRPr1ravRAhET/hEPAAK4H
         nqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o23S7xtxzBQk8WzRwVhA8U0qrvy0Ap95NL75oi/N7gA=;
        b=OTmRO4eVoBea8WI3ZYSWs6AVFnLAK9jDk5qx4/DF0qJIclxFrPIdcRX34ZZ4ch2/Gg
         p1mWZtxO3RlZHBZWY0TvMtzNjuu7OA1p2KnqziSOhlsedJflgh5574dw+QBGu8XUZ1vw
         +zCiHyU0bkYMZrgs+3Z1jyyNh+1LiUi2USb2JmFljqRTGIibJolAonyXUrtGtHcz0PKp
         xmqSzX1eUzTU8WQWO6pYab3nWoGGX+xdoFrotf4a+zcxmqrEw7yRJbWuh6NdHp3BGb5u
         Cr1g/dsiMxZp/6rUTyua9Mis1RTIwAI7Wc8PlmnyNQMM2psgxLvdt+3V6erpxMfta7Gl
         CAOw==
X-Gm-Message-State: AA+aEWY/AIthqmk9ZTToDH3YqJVTW2USDgBwDMWxlCdTF0aPb/4Vn3ae
        EZVIkhPhfklPkpTZk4t7b244JC+J19bDUYNM1GbEcg==
X-Google-Smtp-Source: AFSGD/WzWFnjSwXWceg79kGxHFKQ/8X+b4warsKuUvSFfNLYzMPkzS26yEvYGFaEVys5rXKLKdhlPiiz5yCdaKmhEwU=
X-Received: by 2002:ab0:225a:: with SMTP id z26mr230497uan.100.1542840772383;
 Wed, 21 Nov 2018 14:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20181121201452.77173-1-dancol@google.com> <20181121205428.165205-1-dancol@google.com>
 <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org>
 <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com> <CAG48ez3kgFC74jTmxqL5aPgmqcN-W4E9bR7Fz3V=Vt4qkpx2Pg@mail.gmail.com>
In-Reply-To: <CAG48ez3kgFC74jTmxqL5aPgmqcN-W4E9bR7Fz3V=Vt4qkpx2Pg@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 21 Nov 2018 14:52:40 -0800
Message-ID: <CAKOZuetQPAKKxsZw2ExAsUdiRfSm-rVonqLD86vs1bnwyW1+pg@mail.gmail.com>
Subject: Re: [PATCH v2] Add /proc/pid_gen
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Primiano Tucci <primiano@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rostedt@goodmis.org,
        tglx@linutronix.de, mingo@kernel.org, linux@dominikbrodowski.net,
        jpoimboe@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>, sfr@canb.auug.org.au,
        ktsanaktsidis@zendesk.com, David Howells <dhowells@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 2:49 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Nov 21, 2018 at 11:40 PM Daniel Colascione <dancol@google.com> wrote:
> > On Wed, Nov 21, 2018 at 2:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > On Wed, 21 Nov 2018 12:54:20 -0800 Daniel Colascione <dancol@google.com> wrote:
> > > > +u64 read_pid_generation(struct pid_namespace *ns)
> > > > +{
> > > > +     u64 generation;
> > > > +
> > > > +
> > > > +     spin_lock_irq(&pidmap_lock);
> > > > +     generation = ns->generation;
> > > > +     spin_unlock_irq(&pidmap_lock);
> > > > +     return generation;
> > > > +}
> > >
> > > What is the spinlocking in here for?  afaict the only purpose it serves
> > > is to make the 64-bit read atomic, so it isn't needed on 32-bit?
> >
> > ITYM the spinlock is necessary *only* on 32-bit, since 64-bit
> > architectures have atomic 64-bit reads, and 64-bit reads on 32-bit
> > architectures can tear. This function isn't a particularly hot path,
> > so I thought consistency across architectures would be more valuable
> > than avoiding the lock on some systems.
>
> Linux has atomic64_t/atomic64_read()/atomic64_inc() for this, which
> should automatically do the right thing - processor-supported atomic
> ops when possible, spinlock otherwise.

I wanted to take advantage of the existing spinlock to synchronize
instead of adding more atomic operations to the rollover path.
