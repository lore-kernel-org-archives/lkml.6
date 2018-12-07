Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F5EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6A620989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMGxavd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6A620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLGGzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:55:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45412 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLGGzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:55:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so2583686ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVDlOoRHAydJItIWSkkCWeeUUtGh4EBNNdqZFwwlDRQ=;
        b=TMGxavd9PBX0uK54j1n6yYJEfPAunZKFo27+ttUvVPM6M765sRdMY80W/7iDWG6SlM
         5zHV7UFTR6chwiB174efPC+IgVUgS4h/cociZSFg5EuyG4K3y/Z1EgpNuddA67Tzz/bY
         H/WQfzPSgeunNHzF8HI9ydmfBwF4bzZx6q6Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVDlOoRHAydJItIWSkkCWeeUUtGh4EBNNdqZFwwlDRQ=;
        b=iPXqJ/MiCCzWSdx4KxUNb7sEqfAWcQRRpWEJD1cs27pic0xTK7GJq+UyyIXJUGfop2
         iVJEgCkGnoanKD3rxO+EOISIDMpPuozMUXKkDmW58Cqeq6Xry8+JemG3ja1P6RnvDAlF
         dqcBUF8PZRu3ISH0vLt2HnwJAL9u4+qjmo8tmvT9rKbHG6ct30tkEagfDjl62avSSYix
         q72qLdLdw01g0DixMRWjMsVesBZwxW+6VdGogoUt3rJnwEhrU0AumWbwTK0Tmy3moqHL
         u3TvggrEF7/z7iUJ8WxjTmPf6PPvQZctNs4lBs4v/ei79Zf0xGIeuC6104MSJfNGtuc4
         faTQ==
X-Gm-Message-State: AA+aEWY/cQJ0BJltkIIM/bN/TFznsb1/DwIqArCR2bUue0szfhAXDvf/
        54mgNOXI5WNjYVZxIKAdMW2tgKCCnnyOSUzXoTvKGLm3ZoE=
X-Google-Smtp-Source: AFSGD/XiDNX+C46fqDL4QiXHRiyQxXSqiqJW8Iv3FRhC5eVx0VbRsHq1hm3FstAprx0eQP+PYetcMA93veeyhoik9u0=
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr587079lji.30.1544165715672;
 Thu, 06 Dec 2018 22:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20181205093555.5386-1-sashal@kernel.org> <20181205093555.5386-40-sashal@kernel.org>
 <CA+G9fYt9o298ZzaiFWDrxMW8OvC2BqvY45r7oU9kz=jtmrUZ-Q@mail.gmail.com>
In-Reply-To: <CA+G9fYt9o298ZzaiFWDrxMW8OvC2BqvY45r7oU9kz=jtmrUZ-Q@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 7 Dec 2018 12:25:04 +0530
Message-ID: <CA+G9fYv_4BgrWQC4w1d-nv1XfOgWAc6K96Lus_wpPwzAqqkmqw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 040/123] bpf: allocate local storage buffers
 using GFP_ATOMIC
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>
Cc:     linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, guroan@gmail.com,
        ast@kernel.org, sashal@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018 at 12:10, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Wed, 5 Dec 2018 at 15:08, Sasha Levin <sashal@kernel.org> wrote:
> >
> > From: Roman Gushchin <guroan@gmail.com>
> >
> > [ Upstream commit 569a933b03f3c48b392fe67c0086b3a6b9306b5a ]
> >
> > Naresh reported an issue with the non-atomic memory allocation of
> > cgroup local storage buffers:
> >
> > [   73.047526] BUG: sleeping function called from invalid context at
> > /srv/oe/build/tmp-rpb-glibc/work-shared/intel-corei7-64/kernel-source/mm/slab.h:421
> > [   73.060915] in_atomic(): 1, irqs_disabled(): 0, pid: 3157, name: test_cgroup_sto
> > [   73.068342] INFO: lockdep is turned off.
> > [   73.072293] CPU: 2 PID: 3157 Comm: test_cgroup_sto Not tainted
> > 4.20.0-rc2-next-20181113 #1
> > [   73.080548] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.0b 07/27/2017
> > [   73.088018] Call Trace:
> > [   73.090463]  dump_stack+0x70/0xa5
> > [   73.093783]  ___might_sleep+0x152/0x240
> > [   73.097619]  __might_sleep+0x4a/0x80
> > [   73.101191]  __kmalloc_node+0x1cf/0x2f0
> > [   73.105031]  ? cgroup_storage_update_elem+0x46/0x90
> > [   73.109909]  cgroup_storage_update_elem+0x46/0x90
> >
> > cgroup_storage_update_elem() (as well as other update map update
> > callbacks) is called with disabled preemption, so GFP_ATOMIC
> > allocation should be used: e.g. alloc_htab_elem() in hashtab.c.
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> I have reported above issue on 4.20.0-rc2-next-20181113.
> Now this BUG re-occurring on 4.19.8-rc1 on x86_64 and arm64 devices.

This BUG: was seen on 4.19.1-rc1 also on x86_64 and arm64 devices.

- Naresh
