Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D018C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB1F2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546001066;
	bh=iO8RoXxwTgTbMF2IOJk932pJdEc29IH2p4LM4Jpb1UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K7F9u41pR7aR/er6uyaDrE5DwLuQMFXFWk47quUrp5z0cUMsWGX+2uW05rfVv96cq
	 iiRoIIg3gx9z4HVgizfwI/CmN5uhJFBGOOllQdhbcv1GNvO0fPhOvrUlK4OUZtPm12
	 gxKPZ6NOfMhGmRqBNXgtwNKD8gKorEjzXXDq+ohM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbeL1MoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:44:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50872 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeL1MoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:44:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so18895830wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gbpg4bS5dKA4EqIfeTpxujWmST1hw7rXzOrqemUGMAY=;
        b=itQ6CUedaMORK4R3EwZLl7dgQ/h6vMhnd0sYhd+LPtTyaWGkiOxUiv6//pD9+8iVEM
         bFK0RoxSpOfuowORJGnpfCqqVhFdk5fzuXQuMo0iZeSDbTcM0JKrUS2nV5YiN+x88pK9
         u6rYwrvOa15t7mgL/u1mqkGljPInFu3jG6nqBfQDRgAwvvwacqam+TazniJHJabEq51I
         j1QprLVTzz9KlPhkS4h0SvkYgDfkhwwzTuXaza+uXIYvEhQ2El2Ul46OFbeF8uw7P49P
         z4GcnPPQA1YIeeu5mzqrMdknn2DkeAVwblHRjDbLmAyHxKXJLpSdt6fealIZUDKHQI6R
         nHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gbpg4bS5dKA4EqIfeTpxujWmST1hw7rXzOrqemUGMAY=;
        b=sQ6qG6RC31+RH6yDwOs7w9QifiI2QcxYDV8E3c9qmKa1Ga7gGxJ/ANiMCa5ze7lpyw
         PQpmn29CuMjM6cYas/SSoDxIYHQ1zJDgXgTUawnUlibsQvLK4F4+zLDxWv1uqcSmy/8O
         laIKZ/Lw3oQXmVC9mn7qaA5r244UaUT0lvoxiE/sqc/wWAbuyT1HoHk6UeZiYZr/M+ys
         sQzo1lI0DmlU+pd4zibymxHzNm+xOLGLoJUobtqfiUfeXSwFzzhQkCdS8xgQ/SEoKKJA
         O852GtJh6CKtxBzJXmqifgKgJ7etof0GMyDmc/ALMjpMAPG24g/Rr7VwCGh2/JNj6vMi
         X86A==
X-Gm-Message-State: AJcUukcw6Vlbq9imPsDbHlEG681/AEaepKV9LagmJNfRKzGORWW7bQPs
        a6M8ATLZoTEzxqmhqLdplu0=
X-Google-Smtp-Source: ALg8bN6bdMLebzvVP+p9ka3Mj4NBrpSfojmp5IzYKYSjgsYtEaK3u02Emqw8qRhBSkvNzYudZJcoOg==
X-Received: by 2002:a1c:7c3:: with SMTP id 186mr11962032wmh.41.1546001061510;
        Fri, 28 Dec 2018 04:44:21 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 126sm22283943wmd.1.2018.12.28.04.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 04:44:20 -0800 (PST)
Date:   Fri, 28 Dec 2018 13:44:18 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] scheduler changes for v4.21
Message-ID: <20181228124418.GA20003@gmail.com>
References: <20181224224509.GA67077@gmail.com>
 <CAOesGMjQg2vo2-fbjppumttN1Mz9Ce6VqvK0SkfhdkHPxhP=DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMjQg2vo2-fbjppumttN1Mz9Ce6VqvK0SkfhdkHPxhP=DQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Olof Johansson <olof@lixom.net> wrote:

> Hi,
> 
> On Mon, Dec 24, 2018 at 2:45 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Linus,
> >
> > Please pull the latest sched-core-for-linus git tree from:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus
> >
> >    # HEAD: 732cd75b8c920d3727e69957b14faa7c2d7c3b75 sched/fair: Select an energy-efficient CPU on task wake-up
> >
> > The main changes in this cycle were:
> >
> >  - Introduce "Energy Aware Scheduling" - by Quentin Perret. This is a
> >    coherent topology description of CPUs in cooperation with the PM
> >    subsystem, with the goal to schedule more energy-efficiently on
> >    assymetric SMP platform - such as waking up tasks to the more
> >    energy-efficient CPUs first, as long as the system isn't
> >    oversubscribed.
> >
> >    For details of the design, see:
> >
> >       https://marc.info/?l=linux-kernel&m=153243513908731&w=2
> >
> >  - Misc cleanups and smaller enhancements.
> 
> Looks like my warnings fix never made it in, even after a few pings.
> 
> Linus, can you apply directly? Causes warning noise on all !SMP ARM builds:
> 
> https://lore.kernel.org/lkml/20181125224105.123568-1-olof@lixom.net/

Thanks and sorry about that!

	Ingo
