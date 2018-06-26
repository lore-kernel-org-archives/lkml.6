Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B313C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D08268B5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EqgBgunt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D08268B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeFZRq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:46:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54416 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeFZRq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:46:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so2895323wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HF4EPIGxxb248SaFHrCzIKbApJ5DBG/24sqrNbFkO8g=;
        b=EqgBgunt60JjR8mSM+9mjGdx39hHjcFN9ruMuCNPrfyf9hyWCc6/jSOyevlRjEL88O
         6BNxQrZPrE9dKnq/zAaY0cNX+76nIA4ZAoy+S6MAcOXjukxAcucI3f8Jnv8A8lJ8etwI
         jFUnZPTw/wI7A1zxAgO+e8pvxVW311XN+owHNxcMuEdmvRACzyu147U8DP7ZLyPoSPAC
         ZCxMhD/z+0HU3TBSXlNwhKFGhlcmx9cuVHg91uTg/C8b+kpR/DXpNiMckwecGZG10V/n
         bjFvtrEkDjndnYwhNUjEe5NIWVo16w1iji7CySvrRcltpuo2MtpB7yozme57dDTuh6zq
         +fAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HF4EPIGxxb248SaFHrCzIKbApJ5DBG/24sqrNbFkO8g=;
        b=t++0L4Sp8omuqOls79HrN7hNSsWGjLWkzcD4mnYmQrqKH8C2AaASkcLt52QplrtRgO
         X5PCqzpL35+X/+cffRD+M3p/QWwVDA9kZYpU2vkJ37dXgpLetr5vAZ97KPuxDEyaVjNX
         C8jzU64OJc5H/jP7qORYYqcEHEjK0U9AcyM5oJ98GCsGTUghai0l23Ea2KyqZzw6iUGR
         Pwgp51J4fkm6ZOgpvcz4Q8+IZ433t/zQZL6kXO+oEc5bZrBdfbA5vL3aQmKs8RLiBqPc
         2d+GgvSCO2BpQEBerZCW21QHG6nfDIDSUQrJM5PfV1DYD4vJNflp7r3NxgCLmKzjPVrs
         +xTQ==
X-Gm-Message-State: APt69E0UY53TLmDl6Tv7Qmfupf8Yw9ih9PkKrr7tn7/tKz3flaZhhBT1
        svZqouVGeGKtyzy7izrE0HiwjRGo6NY=
X-Google-Smtp-Source: AAOMgpcQVtZ0c5SyjFiELCexUTPggzoridn1rX0M7BtpcQa7LVPopQMmRXASXuhvXLHs6eP3B8NleQ==
X-Received: by 2002:a1c:903:: with SMTP id 3-v6mr2385383wmj.130.1530035185098;
        Tue, 26 Jun 2018 10:46:25 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p2-v6sm2576214wrn.31.2018.06.26.10.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:46:24 -0700 (PDT)
Message-ID: <1530035183.3205.6.camel@arista.com>
Subject: Re: [PATCHv2] lib/ratelimit: Lockless ratelimiting
From:   Dmitry Safonov <dima@arista.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Date:   Tue, 26 Jun 2018 18:46:23 +0100
In-Reply-To: <CAHp75VchWpr+76rBCmXctpYi5a06pr-MT==FrNDy03g=boxfog@mail.gmail.com>
References: <20180626162438.16306-1-dima@arista.com>
         <CAHp75VchWpr+76rBCmXctpYi5a06pr-MT==FrNDy03g=boxfog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, thanks for the review,

On Tue, 2018-06-26 at 20:04 +0300, Andy Shevchenko wrote
[..]
> >  #define RATELIMIT_STATE_INIT(name, interval_init, burst_init)
> > {                \
> > -               .lock           =
> > __RAW_SPIN_LOCK_UNLOCKED(name.lock),  \
> 
> name is now redundant, isn't it?

It is. Worth to split on the second patch or keep callers changes in
this patch?

> > @@ -42,9 +41,10 @@ static inline void ratelimit_state_init(struct
> > ratelimit_state *rs,
> >  {
> >         memset(rs, 0, sizeof(*rs));
> > 
> > -       raw_spin_lock_init(&rs->lock);
> >         rs->interval    = interval;
> >         rs->burst       = burst;
> > +       atomic_set(&rs->printed, 0);
> > +       atomic_set(&rs->missed, 0);
> 
> Can it be
> 
> *rs = RATELIMIT_STATE_INIT(interval, burst);
> 
> ?
> 
> (Yes, the '(struct ratelimit_state)' has to be added to macro to
> allow this)

Sure.

> >  static inline void ratelimit_state_exit(struct ratelimit_state
> > *rs)
> >  {
> > +       int missed;
> > +
> >         if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE))
> >                 return;
> > 
> > -       if (rs->missed) {
> > +       if ((missed = atomic_xchg(&rs->missed, 0)))
> 
> Perhaps
> 
> missed = ...
> if (missed)
> 
> ?

Ok, will change - checkpatch has warned me, but I thought it's just a
preference than a rule.

> 
> >                 pr_warn("%s: %d output lines suppressed due to
> > ratelimiting\n",
> > -                       current->comm, rs->missed);
> > -               rs->missed = 0;
> > -       }
> > +                       current->comm, missed);
> >  }
> > +static void ratelimit_end_interval(struct ratelimit_state *rs,
> > const char *func)
> > +{
> > +       rs->begin = jiffies;
> > +
> > +       if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
> > +               unsigned missed = (unsigned)atomic_xchg(&rs-
> > >missed, 0);
> > +
> > +               if (missed)
> > +                       pr_warn("%s: %u callbacks suppressed\n",
> > func, missed);
> 
> Instead of casting, perhaps
> 
> int missed = ...
> 
> I think you already has a guard against going it below zero. Or I
> missed something?

No, I do:
atomic_add_unless(&rs->missed, 1, -1);

So, it's guard against overflow, but not against negative.
That's why I do print it as unsigned.

-- 
Thanks,
             Dmitry
