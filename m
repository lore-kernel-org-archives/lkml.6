Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F6CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207E920873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qT3SePYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207E920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbeGMXvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:51:49 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35743 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbeGMXvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:51:49 -0400
Received: by mail-io0-f194.google.com with SMTP id q4-v6so32738105iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 16:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LbuajyqVafS+Oe0uGJrsnT4wqPiXVRFSTfmkTnit5WY=;
        b=qT3SePYjvLFlPgcGsDtTeG5wOek+6Fff0AME4B/qoaS/iNMptN03hbtYFhonUtd+m6
         issLWguzjzOZZjClJzoHhUKdX8S8v2zOcfrbhP5cyjY+Gguxb/cpy25unXLj+GlckHXi
         gR4GyCXiYVumG/wYOGhtF96pDzntEgB0O4cpMgsd3YvSLT1mivMx/elyxLT6blG7c8KZ
         L2zMHl77WSWjd51PxUTFRSa2jRpPD6VbINsUkadJ+phb/wLZIVeJGgMo5ggXrG7dfjMx
         R6eeEgqs7LXRX79hW2IX9viVVs3fn1Ls3EcYrQr+oO+TYrb5SdweaMuj8SSsquTuTQAD
         WzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LbuajyqVafS+Oe0uGJrsnT4wqPiXVRFSTfmkTnit5WY=;
        b=a6a8JTs6KXsfTdkt95CXZPgPkUYHkowp1o9+Qoz1pS0C9CXxIX+i31et5u3fLFkn5l
         Uizinuza88Fl0/fO7QIpYAM9yEUlyteHPMu5YaWflUhUor5lpkvWxZ//15DCVwzLNVaF
         IK78eZoZzwHQ7hDs36M0X6mTGV6wDYlZodZYgNajtVhKecdB3oZHZQSbr/egZ5bVsdpx
         I67Zq63dgutg+9fxzp+rUJYx36kfayf79KO0SpeECBt5RhgceHyBrGuARSrr1yM+IO54
         tiXdBGQFyjdU/acXKWsVCODzi+NDykS1iF3v7I2QHeE9H5j+7owHoHZL6G+TXmNKj5QB
         Z+Lw==
X-Gm-Message-State: AOUpUlE4W5KAIj9hCGOh1iESP+Rx2vVh+Xqbc8bDeiqtnUnpv+vlzEHh
        3wUmHuWDwcAVPIp3Mz9wiikjAIDO1Cl4gnJn6zJIhA==
X-Google-Smtp-Source: AAOMgpdUFUqOo4sgRcyVgUzHre1Bk/81u8A5MdKzJMBLYdZt5O9bat7KIgrSHBoUI/rz82B4ucfBEDFVOrZOY/OXFBI=
X-Received: by 2002:a6b:fb04:: with SMTP id h4-v6mr13483672iog.193.1531524900391;
 Fri, 13 Jul 2018 16:35:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 16:34:59
 -0700 (PDT)
In-Reply-To: <20180713224920.GA31566@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org> <20180712172942.10094-11-hannes@cmpxchg.org>
 <CAJuCfpHGhSs6upZj0ARng-rE1Nbtcr_XHynZhN7EgGdC16tpPg@mail.gmail.com> <20180713224920.GA31566@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 13 Jul 2018 16:34:59 -0700
Message-ID: <CAJuCfpFe-tfcK3BPZ2Y9AEC56PtYpCc04YPGF+fs=e=RqkW-XA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] psi: aggregate ongoing stall events when
 somebody reads pressure
To:     Johannes Weiner <hannes@cmpxchg.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 3:49 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> On Fri, Jul 13, 2018 at 03:13:07PM -0700, Suren Baghdasaryan wrote:
>> On Thu, Jul 12, 2018 at 10:29 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
>> > might want to know about and react to stall states before they have
>> > even concluded (e.g. a prolonged reclaim cycle).
>> >
>> > This patches the procfs/cgroupfs interface such that when the pressure
>> > metrics are read, the current per-cpu states, if any, are taken into
>> > account as well.
>> >
>> > Any ongoing states are concluded, their time snapshotted, and then
>> > restarted. This requires holding the rq lock to avoid corruption. It
>> > could use some form of rq lock ratelimiting or avoidance.
>> >
>> > Requested-by: Suren Baghdasaryan <surenb@google.com>
>> > Not-yet-signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>> > ---
>>
>> IMHO this description is a little difficult to understand. In essence,
>> PSI information is being updated periodically every 2secs and without
>> this patch the data can be stale at the time when we read it (because
>> it was last updated up to 2secs ago). To avoid this we update the PSI
>> "total" values when data is being read.
>
> That fix I actually folded into the main patch. We now always update
> the total= field at the time the user reads to include all concluded
> events, even if we sampled less than 2s ago. Only the running averages
> are still bound to the 2s sampling window.
>
> What this patch adds on top is for total= to include any *ongoing*
> stall events that might be happening on a CPU at the time of reading
> from the interface, like a reclaim cycle that hasn't finished yet.

Ok, I see now what you mean. So ondemand flag controls whether
*ongoing* stall events are accounted for or not. Nit: maybe rename
that flag to better explain it's function?
