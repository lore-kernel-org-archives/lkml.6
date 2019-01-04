Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4999EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002E62184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODsjbh8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfADJBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:01:23 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36883 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfADJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:01:21 -0500
Received: by mail-io1-f66.google.com with SMTP id g8so17705968iok.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 01:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dL7DdFogTaGK/C1f0o7MPX4SYHIrTik8QeCp4BRs48Q=;
        b=ODsjbh8Rv7doTXP1+40w8VPGhwmlUE1twPhFTk2fJCFTha3TK2nVjCYKLBBWl9iUG7
         AmHF32YJk5uYWqXWOcWd7BLLspWp5OA20Q7mh0KiS6tu2JhVMuoBtn4bTVHqXrCH5a8i
         /vfe/1SRrRZH+58G/FloATrO4meusvfSHFFPMLT4Cxq+q08D4ikrfmcej73+7zZz/1sZ
         KxVwAHDevrPl8Imev9uq89QqLTPKh7Z2uy7olFl1gN2quDGhdXefnmQKG9uLzGC/4CtE
         IXgF9Fy0Do8O2S5EhbUElO1JElsihFAiNPbvYiFrcVBzYc0n9+7SuMiFpRQjpw4/QS3r
         CXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dL7DdFogTaGK/C1f0o7MPX4SYHIrTik8QeCp4BRs48Q=;
        b=qVhcgrgjyNVYqpvENpT7ebyc9zDfTj2kNL4DSdWULlL6aftMJA4KT+vX6uePGbUKo8
         n7rn90gnGpf5LWKQad8CQ1PRR0v0JW9AHz1ywaeIbVX46e6eFq8Y8gaGR6LEd9zQ92mU
         gnSY4DPhzybvb/Amss6+Sd/usRoHaTeH+tflsuRpuSDt34Z7pzqJgjMattG/wBLy1KK4
         qcFTMotMV+rfE0/vJIJLBxX0sqMps/kybNEvlnyPGMghs6jvNGUIeAyNMu137T+mAOyj
         fV/N5VcOqpcz+qWubWNtoJ0YMMH7h9v3UugqsKuY9GuOzBkSA2wWeCYMxCs10xZQ+jhf
         JMpA==
X-Gm-Message-State: AJcUukeA16ukRwpwoyajm04G+GVhw76Sl12AuI8eey4Lsz1inop765rr
        9t4Jh5sPYabFdrPde6M8dkA5ujqtqIPLIBbyPsC1J9o5
X-Google-Smtp-Source: ALg8bN5YBuk0c2WqfA87Fv5Qch5+e5KSZZVr/UkcHtGZRd8NMfIk0jBhFpk+I8JDLh8CtkSUvcPuk7kcElCuAdOkhcg=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr35528540iom.11.1546592480919;
 Fri, 04 Jan 2019 01:01:20 -0800 (PST)
MIME-Version: 1.0
References: <1541484194-1493-1-git-send-email-arunks@codeaurora.org>
 <20181106140638.GN27423@dhcp22.suse.cz> <542cd3516b54d88d1bffede02c6045b8@codeaurora.org>
 <20181106200823.GT27423@dhcp22.suse.cz> <5e55c6e64a2bfd6eed855ea17a34788b@codeaurora.org>
 <40a4d5154fbd0006fbe55eb68703bb65@codeaurora.org> <20190104085801.GH31793@dhcp22.suse.cz>
In-Reply-To: <20190104085801.GH31793@dhcp22.suse.cz>
From:   Arun Sudhilal <getarunks@gmail.com>
Date:   Fri, 4 Jan 2019 14:31:09 +0530
Message-ID: <CABOM9ZpAEp_BMBcy-ywj0J33CNuMRwNeS9tUainOxRgPOndxfQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] memory_hotplug: Free pages as higher order
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Arun KS <arunks@codeaurora.org>,
        "arunks.linux" <arunks.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 2:28 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 04-01-19 10:35:58, Arun KS wrote:
> > On 2018-11-07 11:51, Arun KS wrote:
> > > On 2018-11-07 01:38, Michal Hocko wrote:
> > > > On Tue 06-11-18 21:01:29, Arun KS wrote:
> > > > > On 2018-11-06 19:36, Michal Hocko wrote:
> > > > > > On Tue 06-11-18 11:33:13, Arun KS wrote:
> > > > > > > When free pages are done with higher order, time spend on
> > > > > > > coalescing pages by buddy allocator can be reduced. With
> > > > > > > section size of 256MB, hot add latency of a single section
> > > > > > > shows improvement from 50-60 ms to less than 1 ms, hence
> > > > > > > improving the hot add latency by 60%. Modify external
> > > > > > > providers of online callback to align with the change.
> > > > > > >
> > > > > > > This patch modifies totalram_pages, zone->managed_pages and
> > > > > > > totalhigh_pages outside managed_page_count_lock. A follow up
> > > > > > > series will be send to convert these variable to atomic to
> > > > > > > avoid readers potentially seeing a store tear.
> > > > > >
> > > > > > Is there any reason to rush this through rather than wait for counters
> > > > > > conversion first?
> > > > >
> > > > > Sure Michal.
> > > > >
> > > > > Conversion patch, https://patchwork.kernel.org/cover/10657217/
> > > > > is currently
> > > > > incremental to this patch.
> > > >
> > > > The ordering should be other way around. Because as things stand with
> > > > this patch first it is possible to introduce a subtle race prone
> > > > updates. As I've said I am skeptical the race would matter, really,
> > > > but
> > > > there is no real reason to risk for that. Especially when you have the
> > > > other (first) half ready.
> > >
> > > Makes sense. I have rebased the preparatory patch on top of -rc1.
> > > https://patchwork.kernel.org/patch/10670787/
> >
> > Hello Michal,
> >
> > Please review version 7 sent,
> > https://lore.kernel.org/patchwork/patch/1028908/
>
> I believe I have give my Acked-by to this version already, and v7 indeed
> has it. Are there any relevant changes since v6 for me to do the review
> again. If yes you should have dropped the Acked-by.

No Michal. Patch is same. Only difference is this patch is re-based on
top of preparatory patch.
https://patchwork.kernel.org/patch/10670787/

Regards,
Arun

> --
> Michal Hocko
> SUSE Labs
