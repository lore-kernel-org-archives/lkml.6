Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13FCC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6172075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="kpQXdqNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6172075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeIGMQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:16:38 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35204 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeIGMQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:16:38 -0400
Received: by mail-qt0-f179.google.com with SMTP id j7-v6so15332681qtp.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r8ccPo/7uRlB+FgFLfDdo+e5tdArx5VEGHE51bjxrEE=;
        b=kpQXdqNTGkxpHlUhmQ0QdSFCfd6m7vVvZgwSxWboGJ1gn5rlg4ycazarMfwbxC9HoD
         kHT9ddJ24h6qxEwSQyH3aorgIT2X43MwLFf0q9aKG8VFppYBaOEimhmDRWFyN6x4yZ2i
         2D9Ie3cpMRVvNQawQi9KtM4SfHvlBBNfxN+0mq1mYsKGCv32jwzXxM/jRlwu0V2s6DQU
         y5usao1+PGUDUFjW6qhPz0EHGu4aeOfhV6ZYTbktSi0WEZHuYb7LmV+QSU7Wnvc+0jZI
         tbAQIhLLv7IzO4WP+S65IOandeUKJlwy1aMbRnOMv4yjRPtkDE5bm707GJACjGSqMPVP
         2T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r8ccPo/7uRlB+FgFLfDdo+e5tdArx5VEGHE51bjxrEE=;
        b=VlOWY4o3bPm7BVmwAxsC0mmY6xA2+VL7xqO/57+tR5RN0BLEm5aZFGkYhHqhEsXLhU
         FutBoJICs9NXBiQ1M7PMWBvi8zKymEVMauvtMIOqQbXuy070hvKhnRZVz/11FRXOjyeH
         DteivnG4Q9k7VihVR8Gg+RjO0Ov4Y69JkTTuTrRfNNvElmT0GOqrWOoG/+ft5b4YXIYN
         UTLQCsYSUO6chrrGDbP0sFwizlSZ96wYuxARokKdfoy5tAlQI7mRx+c3rCfUcExDgvP5
         U92GS916ctE0KmVWendJQR8tdH0V3rnQL1evVF+IBop7AqrQ6lhbINBe6VutfaR5SLIM
         grcw==
X-Gm-Message-State: APzg51BzPBMFCGX6uINQd/+btRVMCcSdpTO9R80Ng24LF9KT7HnoSobx
        WBCtMhOJ2zzxwfwk2fy8/cNml60IRS7oC1zv5Yi8KQ==
X-Google-Smtp-Source: ANB0VdayjcUyTuJwMjY16bDKUftIzdr4uhVsuAOLc0iE4wmNlFZJ134dhRKSWLiST/+90g/Hz6bIos1F6ljbxFV50Rg=
X-Received: by 2002:a0c:bfe3:: with SMTP id u32-v6mr4844463qvj.172.1536305817171;
 Fri, 07 Sep 2018 00:36:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:147:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 00:36:56 -0700 (PDT)
In-Reply-To: <20180905214303.GA30178@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org> <20180905214303.GA30178@cmpxchg.org>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 7 Sep 2018 15:36:56 +0800
Message-ID: <CAD8Lp44vHpMiWZdU9+mp-pe2kXmnxF1zm20SNWf2BVunk8c46g@mail.gmail.com>
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 5:43 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> Peter, do the changes from v3 look sane to you?
>
> If there aren't any further objections, I was hoping we could get this
> lined up for 4.20.

That would be excellent. I just retested the latest version at
http://git.cmpxchg.org/cgit.cgi/linux-psi.git (Linux 4.18) and the
results are great.

Test setup:
Endless OS
GeminiLake N4200 low end laptop
2GB RAM
swap (and zram swap) disabled

Baseline test: open a handful of large-ish apps and several website
tabs in Google Chrome.
Results: after a couple of minutes, system is excessively thrashing,
mouse cursor can barely be moved, UI is not responding to mouse
clicks, so it's impractical to recover from this situation as an
ordinary user

Add my simple killer:
https://gist.github.com/dsd/a8988bf0b81a6163475988120fe8d9cd
Results: when the thrashing causes the UI to become sluggish, the
killer steps in and kills something (usually a chrome tab), and the
system remains usable. I repeatedly opened more apps and more websites
over a 15 minute period but I wasn't able to get the system to a point
of UI unresponsiveness.

Thanks,
Daniel
