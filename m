Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6181C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD9B21A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tc42xgkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD9B21A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbeHFRRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:17:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34077 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeHFRRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:17:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so7015138pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fqjl90GKjEPj39+GQcvXhwqPK+DveuoeIiSsfVpvUKA=;
        b=tc42xgkBUIrDxWAibgxXIjRvDi2rtRaJGGKSgvQRP05uvgrVbECuY3SYE9C+Zh2qsO
         3lrw27+/dhJ/DJWpU1QueCnMq9SulmEvHi1uX2A0w/LVmhfva7iy7fniMOqv6wNi07+5
         ibW2fJSoMqqOPSiWr9gQF86iIUIJItqmvA7xHteYZpVEWXzyUFOEfd+aFb4DmvyZGniW
         AsWEkXGFz8IfSp7tOoSv5iBAYTPheeiuSODisombUV9ltFSXwog9vkuu1vBSAf9Q92me
         LX5WvXXuHVz/4XhGiTtpb1a2QD4Lw3y7H7t4LRoYRZ2N/LhxBPIM2tuXobfvwFVlO7kJ
         +w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fqjl90GKjEPj39+GQcvXhwqPK+DveuoeIiSsfVpvUKA=;
        b=DeEsB5hSSQ1HfkC2BQOrIRB9dLK4DuBGSBe0xMrMMSE1OAVaCbia49XIvZlyQfzVgK
         SrkXZQHyAfLku2c0RjA8hxRGL2JyrMEBOZEg0P3Jltp+aCkzJ7E0eHm4bH5yvjRITEAF
         qPhW3lt1ukhoSY1cUffwKwxYNoHGvJ3YFRB3mumXDBP+2UgEzbH4qwlBvDgjOcIYevvw
         0XLWbz06nfZB6hlpaznJuLTN0nJKSL3iHfS9/b+2YsJAiHetRv7buiaPApXPKQEYP189
         kHOdcOPFyVXihsY3k+YAEUGUsz3SEBNBuTDKz5yJi38jiO2RTptQsFCcBWjvg0YACNg3
         YMjA==
X-Gm-Message-State: AOUpUlE4juWGExnsgpYsZvwh7LJJ3HTXGa2Qg2JWFXpyxaUHChQaeZVs
        PfykgKimiWvWZgc1NKvgST4M+M5ZmpE6Tw1Uyfxaag==
X-Google-Smtp-Source: AAOMgpfRLK6LCvab1mbmFkcLqASS8UvtZrUIYSo6syoYii3pOjDK8NnBspwYkzOZALrjBc3iDvsgT14r0wpkHpvbuOw=
X-Received: by 2002:a63:d443:: with SMTP id i3-v6mr15299255pgj.216.1533568067338;
 Mon, 06 Aug 2018 08:07:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 6 Aug 2018 08:07:26
 -0700 (PDT)
In-Reply-To: <20180806142124.GP19540@dhcp22.suse.cz>
References: <0000000000005e979605729c1564@google.com> <20180806091552.GE19540@dhcp22.suse.cz>
 <CACT4Y+Ystnwv4M6Uh+HBKbdADAnJ6otfR0GoA20crzqV+b2onQ@mail.gmail.com>
 <20180806094827.GH19540@dhcp22.suse.cz> <CACT4Y+ZJsDo1gjzHvbFVqHcrL=tFJXTAAWLs9mAJSv3+LiCdmA@mail.gmail.com>
 <20180806110224.GI19540@dhcp22.suse.cz> <CACT4Y+awxBatn3GQc7EWHVfHqMLKC9eVKjQMbJkCk0Po-X4VDQ@mail.gmail.com>
 <20180806142124.GP19540@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Aug 2018 17:07:26 +0200
Message-ID: <CACT4Y+bbKG4SQoEY+DVYRzyYN4aBJ1goC+B1R26dGtMVPkMonQ@mail.gmail.com>
Subject: Re: WARNING in try_charge
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 4:21 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 06-08-18 13:57:38, Dmitry Vyukov wrote:
>> On Mon, Aug 6, 2018 at 1:02 PM, Michal Hocko <mhocko@kernel.org> wrote:
> [...]
>> >> A much
>> >> friendlier for user way to say this would be print a message at the
>> >> point of misconfiguration saying what exactly is wrong, e.g. "pid $PID
>> >> misconfigures cgroup /cgroup/path with mem.limit=0" without a stack
>> >> trace (does not give any useful info for user). And return EINVAL if
>> >> it can't fly at all? And then leave the "or a kernel bug" part for the
>> >> WARNING each occurrence of which we do want to be reported to kernel
>> >> developers.
>> >
>> > But this is not applicable here. Your misconfiguration is quite obvious
>> > because you simply set the hard limit to 0. This is not the only
>> > situation when this can happen. There is no clear point to tell, you are
>> > doing this wrong. If it was we would do it at that point obviously.
>>
>> But, isn't there a point were hard limit is set to 0? I would expect
>> there is a something like cgroup file write handler with a value of 0
>> or something.
>
> Yeah, but this is only one instance of the problem. Other is that the
> memcg is not reclaimable for any other reasons. And we do not know what
> those might be
>
>>
>> > If you have a strong reason to believe that this is an abuse of WARN I
>> > am all happy to change that. But I haven't heard any yet, to be honest.
>>
>> WARN must not be used for anything that is not kernel bugs. If this is
>> not kernel bug, WARN must not be used here.
>
> This is rather strong wording without any backing arguments. I strongly
> doubt 90% of existing WARN* match this expectation. WARN* has
> traditionally been a way to tell that something suspicious is going on.
> Those situation are mostly likely not fatal but it is good to know they
> are happening.

Today syzbot covers about 1M lines of kernel code, and we fuzz for
several years with panic_on_warn=1 and each unique crash is recorded
and reported. Over several thousands bugs that we reported, there were
maybe 2 dozens of such cases (WARN on invalid user inputs, ENOMEM,
etc). The solution always was to remove the WARNING on covert to
pr_err. As of now, I see only 2 such cases open: this one and WARN on
ENOMEM in input subsystem.

Either way, we do badly need this separation. If there are deviations
we need to continue fixing them.
