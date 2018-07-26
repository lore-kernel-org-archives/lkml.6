Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AA3C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5862083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ska-ac-za.20150623.gappssmtp.com header.i=@ska-ac-za.20150623.gappssmtp.com header.b="k097vu0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5862083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ska.ac.za
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeGZH44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:56:56 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:38713 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeGZH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:56:56 -0400
Received: by mail-ua0-f169.google.com with SMTP id o11-v6so386190uak.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 23:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D5mFvR2va/Ciy5LWl0IU0wcwU8yOAIQ84fnDdY9SYGA=;
        b=k097vu0tooVe7Jc6FE1ggQQ26KoezreUGkZSVS2kTwhTcST8HJ8w8mPaPIMlLYilk2
         pC+h2Db2IAaik3HCzU4sgt+dh2SL4Zuu0ZKL8cWHAmleH5dscWugyY67NyREfjjpbWMd
         kX5LR42W9q3jikJ1RX7DkCaKM2o0TtccwmKdHcYEjx8Jf+Us6TBi9doLjT3SxQkXO4hp
         hfHJUvlDRyCfVmFxOAK6k36/Onc4M/FxfcVBiyu9qm6aIn3ncGEXRwVUDBzgdoSwbjAq
         SUdt0/ymzNVtZ7h6mQLR1fRwET0EvXCSL4lXoSqxJ7RZROEnGbiMpR4riDe/9MP+X8ma
         mIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D5mFvR2va/Ciy5LWl0IU0wcwU8yOAIQ84fnDdY9SYGA=;
        b=RGKoXkVsqCpgTY76OJa1hWET3VeFKQRgPAcsOc8sqBQFRdsiTyRy3unzMpdQwNNsZx
         Qz6Btb8d8AfVQeU1aI4TyarBo7S8qul/dKp2JX40eJeYM6B5hGakbYsPjDSC3FWKG+kG
         NaH05Xg3GbEATIkybsGMZoxyso4gW0jVe7fsf4gv8oY/B75qvjiXq7SBVWTb+34pY9eR
         b1FaikEkhOdHzgExU5CbQUYdvic12U8YpohZvU1JH7O4x+IHZCDekskgHlUNTLhOIhTl
         V+AV1ODhOV1Y1gRSLhkNRbthdqj9FMkXAb3dHan+qWlHKdCpeVyoD3yAguRDMBRyYtT1
         OMuQ==
X-Gm-Message-State: AOUpUlF+mKf+omRycuOoy3Sl89u4Q1sB4R3Z2kFMLWKKkc6X1Xmyj9+q
        r2uY5Zf2SGHGaJtuyH2BK8LQsWK72dIr6EEc5CsWEg==
X-Google-Smtp-Source: AAOMgpf6q/nr39UY5FHn7Cv+N2qFNXFKXywGeQ+gfF9qrw0JgWQXO1nFfZ/xrAzDjNSK1b7qxEVaUWj+UfREmhTMPFo=
X-Received: by 2002:ab0:210b:: with SMTP id d11-v6mr458870ual.108.1532587295752;
 Wed, 25 Jul 2018 23:41:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:d97:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 23:41:35 -0700 (PDT)
In-Reply-To: <dda7b095-db84-7e69-a03e-d8ce64fc9b8e@gmail.com>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
 <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
 <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com>
 <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com> <dda7b095-db84-7e69-a03e-d8ce64fc9b8e@gmail.com>
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Thu, 26 Jul 2018 08:41:35 +0200
Message-ID: <CAOm-9ar2zzxZvZ9A0Yu0knn_LNcHsck72wXShFXutYvAN2qu9Q@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     "Singh, Balbir" <bsingharora@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
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

On 26 July 2018 at 02:55, Singh, Balbir <bsingharora@gmail.com> wrote:
> Do you by any chance have use_hierarch=1? memcg_stat_show should just rely on counters inside the memory cgroup and the the LRU sizes for each node.

Yes, /sys/fs/cgroup/memory/memory.use_hierarchy is 1. I assume systemd
is doing that.

Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SKA South Africa
