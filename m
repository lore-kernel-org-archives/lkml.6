Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37037C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E609920673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ska-ac-za.20150623.gappssmtp.com header.i=@ska-ac-za.20150623.gappssmtp.com header.b="F1nxndX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E609920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ska.ac.za
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbeGZNwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:52:16 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40820 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbeGZNwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:52:16 -0400
Received: by mail-vk0-f68.google.com with SMTP id s23-v6so696141vks.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+FOiMJjvfPs29OxsbCavUxCAo/pJnqFid62oP1UYVAo=;
        b=F1nxndX9YK2lTBf1ROGZEG30oTh1BhWrqlyPj3mWn7xoSlJEI0R/+W0FryqgS239S7
         q1FBk7EMWLHtAvxY+gPJS2v36W96m2XDkkXyZr9UcvLZQUuaTbWaPCnu9ccuSN7xgHdt
         LhRFR8PLeinxC92XOX8Np0jXMDoow1X8XU+my7Tgk5fr8jf/7XFPVIRkeDWQp96VbAlc
         h8mWtSeNEsfcZ65EV/qd9FVpxEHCmCSR5OTlWo6LUw/WTf/hPc4RfSItLb5cxdqt4OmX
         HulHhFb2kjB+9pbrkC3o9ZwIhC2wtZmTFg3aZkzh5VhQ87+IzQAyiRRkmhZrVlrLE356
         7G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+FOiMJjvfPs29OxsbCavUxCAo/pJnqFid62oP1UYVAo=;
        b=Nz8DDoxft7K8PnCnsCDArpFs2R8mWACbc5+1Ajzur2sXpcW5Qy2ICW6pj03nNRfd1s
         yPXn33G7hVxO3bgzoYW+/++z3KbwcY2bh5VQZSo4T5L0mam5D9kjEv0lnMfPfGebsH/M
         UQc5UireRELZAUE6WDPED+rcCefFS27D/Lwcem3kwKSi7rSQp5tn4W4Ciw8VQkCKzJxa
         mUiFr5SkF7lLamrfcLfucOFRmbfYH1Z2ka3Ag8u8kv0KDAcmjJ7DtAmFoVzKZxLipnUa
         bVFwVKilbci0WbT9wD/zfISzJ895pmGto2RC89GgoXFF6Wli9YwMDDl/0Tvw1iZZYU1k
         VNZg==
X-Gm-Message-State: AOUpUlFFcNvmf9SEh5Ib8TQealC6GQEKJ/YCr3hvOblO7x4JM8pIZq1V
        5ySYs+c6kazaxSBA/o8F71/UAB3Eso01y889isYIbQ==
X-Google-Smtp-Source: AAOMgpdEVO1AL8NNRSvZE4fGjdunmtfJ37qHnUZTB36Zh1GJW0WJ94n6AF1Zccunf1FY1OjoTe/LlMaQyLh219tBdjA=
X-Received: by 2002:a1f:5fc5:: with SMTP id t188-v6mr1022149vkb.86.1532608535509;
 Thu, 26 Jul 2018 05:35:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:d97:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 05:35:34 -0700 (PDT)
In-Reply-To: <CAOm-9aqYLExQZUvfk9ucCoSPoaA67D6ncEDR2+UZBMLhv4-r_A@mail.gmail.com>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
 <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
 <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com>
 <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com> <CAOm-9aqYLExQZUvfk9ucCoSPoaA67D6ncEDR2+UZBMLhv4-r_A@mail.gmail.com>
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Thu, 26 Jul 2018 14:35:34 +0200
Message-ID: <CAOm-9arV_OC5XQquSUHy6WbsxC7s1gUWQDKKLkR+Ctvq6=A-BQ@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     Shakeel Butt <shakeelb@google.com>
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

On 24 July 2018 at 12:05, Bruce Merry <bmerry@ska.ac.za> wrote:
> To reproduce:
> 1. Start cadvisor running. I use the 0.30.2 binary from Github, and
> run it with sudo ./cadvisor-0.30.2 --logtostderr=true
> 2. Run the Python 3 script below, which repeatedly creates a cgroup,
> enters it, stats some files in it, and leaves it again (and removes
> it). It takes a few minutes to run.
> 3. time cat /sys/fs/cgroup/memory/memory.stat. It now takes about 20ms for me.
> 4. sudo sysctl vm.drop_caches=2
> 5. time cat /sys/fs/cgroup/memory/memory.stat. It is back to 1-2ms.
>
> I've also added some code to memcg_stat_show to report the number of
> cgroups in the hierarchy (iterations in for_each_mem_cgroup_tree).
> Running the script increases it from ~700 to ~41000. The script
> iterates 250,000 times, so only some fraction of the cgroups become
> zombies.

I've discovered that I'd messed up that instrumentation code (it was
incrementing inside a loop so counted 5x too many cgroups), so some of
the things I said turn out to be wrong. Let me try again:
- Running the script generates about 8000 zombies (not 40000), with or
without Shakeel's patch (for 250,000 cgroups created/destroyed - so
possibly there is some timing condition that makes them into zombies.
I've only measured it with 4.17, but based on timing results I have no
particular reason to think it's wildly different to older kernels.
- After running the script 5 times (to generate 40K zombies), getting
the stats takes 20ms with Shakeel's patch and 80ms without it (on
4.17.9) - which is a speedup of the same order of magnitude as Shakeel
observed with non-zombies.
- 4.17.9 already seems to be an improvement over 4.15: with 40K
(non-zombie) cgroups, memory.stat time decreases from 200ms to 75ms.

So with 4.15 -> 4.17.9 plus Shakeel's patch, the effects are reduced
by an order of magnitude, which is good news. Of course, that doesn't
solve the fundamental issue of why the zombies get generated in the
first place. I'm not a kernel developer and I very much doubt I'll
have the time to try to debug what may turn out to be a race
condition, but let me know if I can help with testing things.

Regards
Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SKA South Africa
