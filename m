Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7C9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A48E208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPJC9rJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A48E208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390118AbeHASC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:02:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46525 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389854AbeHASC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:02:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so17346726ljj.13;
        Wed, 01 Aug 2018 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+XWLmaBxsOaii9QFXMGaBQV2UtUeOG2s2buJkAeluX0=;
        b=dPJC9rJW9lZo0406nuZmtMK6ifqUOXtoZFoirzQ2PnhF6jAfprqx2dXHg7XdMeMd+T
         2uaSrxTmdTZEwCbUIhfpIIBQ41EIlIOOe28mM+J6YJDQhZ1/SF4cV4W1lcll1d1/HsMI
         iGUJs/3OdfzdwtHem+KjpC8YoAbCN772iGfG5Nxa1UieJXcjTbQ22DN07ZK5hcROpIzm
         4MdbY/ddzyj9ScNUqIUyihRXkQsGIb4t6q2kLk1MaocCC0FPC+tCN0OQim+L4B+eIZ+B
         SzhZ1bdhh7d7HY0gToKUHvZK7XGunguCuw8IMf0f9DOmqRtMPJNGKZAT/OaC8FAIHoMB
         mHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+XWLmaBxsOaii9QFXMGaBQV2UtUeOG2s2buJkAeluX0=;
        b=BoJ+u07Fp/lPnAxFpgy7ouHqs/DJCnz354l66qGL43RhLVSgag+Tv47i4vCDxQMY/M
         hGqNeFC2AZr59LZscoOpxLDyymozagmGDUQrKdKItWxJJQIxC15sZEQt5g+LiDGZiiLK
         ftYGpZb6TvQjNSP9llv+11TnCx8PbzjgpCLh94lksKsWMgYwNlk1lCbHjBJYWbDcNQqi
         YX2QC9Jz6Y5MYVFCiyn4EQQkj9HP8lcryVcMdZtsW8u61G8EH+YcQPC4wTgNIrFmy1bO
         zUv50BaWuUPjTg2wZoLAiDzi16bcVrU3/arQb4DvA8HDbHKROHdvLA14Js6X5xelZ3Y4
         rm7Q==
X-Gm-Message-State: AOUpUlEuIkIDqY19shOFXPU6bvTyZq7PClBT8b3V7qWmPDXh8QhFTcwe
        QcQ2nkh6CQbzNytmlVxG6o2pOhuH
X-Google-Smtp-Source: AAOMgpeMN8Ow7GtKSV+xEaFhaWe09eHfG+UKtTMNC5OlcCIO51BmD9/jvEfB9b99T+eZ5tQw28XJMA==
X-Received: by 2002:a2e:5f89:: with SMTP id x9-v6mr19769033lje.16.1533140189737;
        Wed, 01 Aug 2018 09:16:29 -0700 (PDT)
Received: from esperanza ([185.6.245.156])
        by smtp.gmail.com with ESMTPSA id m129-v6sm2453858lfe.50.2018.08.01.09.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 09:16:28 -0700 (PDT)
Date:   Wed, 1 Aug 2018 19:16:26 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: Remove memcg_cgroup::id from IDR on
 mem_cgroup_css_alloc() failure
Message-ID: <20180801161626.j2575eru2x3lukfj@esperanza>
References: <20180413113855.GI17484@dhcp22.suse.cz>
 <8a81c801-35c8-767d-54b0-df9f1ca0abc0@virtuozzo.com>
 <20180413115454.GL17484@dhcp22.suse.cz>
 <abfd4903-c455-fac2-7ed6-73707cda64d1@virtuozzo.com>
 <20180413121433.GM17484@dhcp22.suse.cz>
 <20180413125101.GO17484@dhcp22.suse.cz>
 <20180726162512.6056b5d7c1d2a5fbff6ce214@linux-foundation.org>
 <20180727193134.GA10996@cmpxchg.org>
 <20180729192621.py4znecoinw5mqcp@esperanza>
 <20180730153113.GB4567@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730153113.GB4567@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:31:13AM -0400, Johannes Weiner wrote:
> On Sun, Jul 29, 2018 at 10:26:21PM +0300, Vladimir Davydov wrote:
> > On Fri, Jul 27, 2018 at 03:31:34PM -0400, Johannes Weiner wrote:
> > > That said, the lifetime of the root reference on the ID is the online
> > > state, we put that in css_offline. Is there a reason we need to have
> > > the ID ready and the memcg in the IDR before onlining it?
> > 
> > I fail to see any reason for this in the code.
> 
> Me neither, thanks for double checking.
> 
> The patch also survives stress testing cgroup creation and destruction
> with the script from 73f576c04b94 ("mm: memcontrol: fix cgroup
> creation failure after many small jobs").
> 
> > > Can we do something like this and not mess with the alloc/free
> > > sequence at all?
> > 
> > I guess so, and this definitely looks better to me.
> 
> Cool, then I think we should merge Kirill's patch as the fix and mine
> as a follow-up cleanup.
> 
> ---
> 
> From b4106ea1f163479da805eceada60c942bd66e524 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 30 Jul 2018 11:03:55 -0400
> Subject: [PATCH] mm: memcontrol: simplify memcg idr allocation and error
>  unwinding
> 
> The memcg ID is allocated early in the multi-step memcg creation
> process, which needs 2-step ID allocation and IDR publishing, as well
> as two separate IDR cleanup/unwind sites on error.
> 
> Defer the IDR allocation until the last second during onlining to
> eliminate all this complexity. There is no requirement to have the ID
> and IDR entry earlier than that. And the root reference to the ID is
> put in the offline path, so this matches nicely.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
