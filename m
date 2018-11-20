Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5230C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A065214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="H1N3wco9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A065214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeKUG0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:26:17 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44845 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeKUG0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:26:17 -0500
Received: by mail-vs1-f65.google.com with SMTP id g68so1824977vsd.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYVR6WxMSD2Ly1obkFCk4J7fsBZbqRtYof4ux6e/Pcw=;
        b=H1N3wco95Fro27YYiZCg8/b9YZ70PIHWolfSQjrLdwl25EAkUP7hZPLYS86ZhuiBqW
         stfef/y79JA+4ZIi4f8N+F2tMoPsvlM1mYehkiee45Uh6bvVV+TWmqJkB7GiBR2dxzKa
         WwpoG04rp3OHzNVOYTtsXBbPEv2v6p8QQa2wZHLUwD+SjM7JRxFbdHeiej28N3pgDzJZ
         Pq2DNqbzNhIkJfTb+f/70gxmpdqh6CU8XVLs2M3yGGhfQaDdius/jQFxXJQlgHUEo6w3
         lWn231VaeK/jsqWxK6zfMuGtgD+qSmsCFdpDjtya7vdX79aciC9ItxVHenlVfxxMBzi2
         TUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYVR6WxMSD2Ly1obkFCk4J7fsBZbqRtYof4ux6e/Pcw=;
        b=Rg5G/iLat/PWCn12AwDebEHLByzlO+XABpePkEXIeKsDiCnq0wLWMx5U8Iv0qX8YAo
         SFUqeHhkufdizlP2m1ZsY056pvIMEmPLjEchObvAFW2Z1yBmI321ARiI1cFTV7bFr+dQ
         o4s7YSvWJLbppyq5ARTEkDL+WkGRPcuRgIVHXbABz7fG/MZX8PIS+kk3reWmpvH+n9k3
         S7KSbOTMfiQJI/+MypZALFltGOyDqIVuQF7CKBJR1Cqk+IYvk9TvRCq4j5G/4MiKGv6+
         Q0bR0Qq+yfEuYmD/MPSszR6819ryjfcxWrm05ntRQmCbME5Rxi8NPMVYb80lotvvDV6L
         joEA==
X-Gm-Message-State: AGRZ1gJaCaCZJoE3CMBI28P58ehRHZZx4HGxQ4TiZVuhz0IIolqdUGhX
        61ePov41cCSoVDOQP5oZvkRgUT/5NrwlH+iFVETqJA==
X-Google-Smtp-Source: AFSGD/XDkiKIIXlHfDzFLJJBP5MveFJ8Gf8jLxE+1mnuIhCqpKkdCrxcNi0XBz5JDTW11DBJYtuk+nMCK45baZP5Afc=
X-Received: by 2002:a67:db06:: with SMTP id z6mr1476864vsj.73.1542743725946;
 Tue, 20 Nov 2018 11:55:25 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com>
In-Reply-To: <20181120194129.GC13936@tassilo.jf.intel.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 20 Nov 2018 11:54:56 -0800
Message-ID: <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:41 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> > rr, a userspace record and replay debugger[0], uses the PMU interrupt
> > (PMI) to stop a program during replay to inject asynchronous events
> > such as signals. With perf counter freezing enabled we are reliably
> > seeing perf event overcounts during replay. This behavior is easily
>
> It's hard to see how it could over count since the PMU freezes
> earlier than the PMI with freezing. So it should count less.
> Did you mean under count?

Yes, I did mean under count, see my last email.

> > Given that we're already at rc3, and that this renders rr unusable,
> > we'd ask that counter freezing be disabled for the 4.20 release.
>
> The boot option should be good enough for the release?

I'm not entirely sure what you mean here. We want you to flip the
default boot option so this feature is off for this release. i.e. rr
should work by default on 4.20 and people should have to opt into the
inaccurate behavior if they want faster PMI servicing.

> A reasonable future option would be to expose an option to disable it in
> the perf_event. Then rr could set it.

- Kyle
