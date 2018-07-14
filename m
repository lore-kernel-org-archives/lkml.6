Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BED6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F1E20834
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6Sz+C2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F1E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbeGNP57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 11:57:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34137 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeGNP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 11:57:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so27747824wrt.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iluyll3MCCBbrDy+jCMfsrBekBknlCkm0XifQvaH1mE=;
        b=M6Sz+C2P0N3PoJ0mQ2Gasps7WsdEUP/I8XExH8cIdMf+umBw99aG5DcAocXVXrFs8F
         bGleg9/NiJQ21OGl88F5BBYsb0zJ+nJ7U9sVyiFCk83FgclMilHDHzZVWD5utHBDutDR
         9Q1U05yS6BwyOpTt07JQK31m19nIIYNPXwjhKwYeuSBKoCROzb3sfH6rEzhrJOUaieU1
         /pD6q9/NFNzi5/nvTyvZ/Uw7G+mLPvgNfdt7YceCPN0D6oyB0ZpTwLw9u16gOO334y8R
         RwBVWm9tMQXA81RYF7bV5mWDRhWUJS1kI1EEU73vCN+nvV/6dS+IjgdX8+A8qrYQkGM3
         fskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iluyll3MCCBbrDy+jCMfsrBekBknlCkm0XifQvaH1mE=;
        b=NCwKY7Qz2C5D7r88NiVY+TLpES83GA6sBpWJNPXNTS8D8YimrPdU2Mynyz5MweUzef
         iLOr2KJZV/XGwxeGFqyHDWcigUBqX2IWhMzv07f7OgNfFUx0cnC5k9FB72veTblJqo4x
         QaztVvBiQXNX535XVSZLcnKhu/RTo9GTp/HlrIw1PeItuUfH3qcWNZu5dSKRw+wLZgEu
         X19DrsvoyCroQzUESjwsuWeUY5EOzab59er1LsgxaGUPZoC9Nn6JbsHH7RU7S1sF4VCF
         Uq46FQCMC+5XrfuEgemtlLkWXpnK5GjDa99/BxmkzS9XK9O7CCrVPJ/1gCg9fHqRney/
         hrYQ==
X-Gm-Message-State: AOUpUlHoKy0idWfdjptd4ut95y6509l2B62FsuD3ySXw2HK4Xfwl6bFi
        bKPuURUO5TusU4+ix2Edj7Rd89UFpoFCSFrWDmMgnw==
X-Google-Smtp-Source: AAOMgpcBSSCycD53SxVevnlZFsSbYL3AWbCRUyqvkb3mNBJpAMQBcBxMGoS0zPxQUTuFjYACCKTtPalKV0+fCt0rmX8=
X-Received: by 2002:a5d:4a07:: with SMTP id m7-v6mr8459698wrq.8.1531582711174;
 Sat, 14 Jul 2018 08:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 14 Jul 2018 08:38:17 -0700
Message-ID: <CALvZod57QFRVQ7kM4LSNQJACQ+dGC_otJkqK-5+i-0b53Zq5aA@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid bothering interrupted task when charge memcg in softirq
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 1:32 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> try_charge maybe executed in packet receive path, which is in interrupt
> context.
> In this situation, the 'current' is the interrupted task, which may has
> no relation to the rx softirq, So it is nonsense to use 'current'.
>

Have you actually seen this occurring? I am not very familiar with the
network code but I can think of two ways try_charge() can be called
from network code. Either through kmem charging or through
mem_cgroup_charge_skmem() and both locations correctly handle
interrupt context.

Shakeel
