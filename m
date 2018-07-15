Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7D6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BED0208CE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPzgGwem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BED0208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbeGOCb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:31:59 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55664 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731950AbeGOCb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:31:59 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so16297567itl.5;
        Sat, 14 Jul 2018 19:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kqJSv2Ubljjt/IjTKrl1FAo40tWJZsUFjKXl1ffUHqA=;
        b=XPzgGwem3J1j0z49Ln85QCWkZl6/MRuHIe4Ep2JbH5r5bBDuHy4mvGwcQqOtvUgVox
         yDxgtLUICSGdPZ8Lcy9DGeurC7cn6s2p5ndbDZWdF4Hy6310dd1edj8GPgrsuc+Agxvu
         65QIYT/9oZCw5JkjulBgJYvdbnytcv5wInB73ATfVHxdU/fQzvSo8YwapGkElGY26SJL
         sUoRc3C3uJNd9y7zDAXNINW3GIfrLOo+rhtpZpUX/83fS54ZhUdtVsBL24kyVbbrdN+f
         upIwKKZCwswbPXboZbdRVC1iEIh2CxOhwJi+n37gpn/uH8nU6iqHEpxGxzL6EfOunbbM
         dP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kqJSv2Ubljjt/IjTKrl1FAo40tWJZsUFjKXl1ffUHqA=;
        b=IfZdv7YDBuXrwQZizahWLhVL20BRNfgNfOUOr4WiN6x/BbworLOouQT6GcmhmPE4GR
         mFMd6t+br//mZwgOg6UYAYsVONCO7aVU+oknP8KQ3wzHqgwCL1/ehOZWg7HYxPmPfL8f
         0iZv54EBMs7t4dAEj37yTL9rMU5jQmu3Z85gPEJwTxoYZnd7rtxLEH6Ic70Aafb1LhmS
         fy1e3zVWm3U1eHse/uUIeI3vbjTcwJTkKHVcppRTt7d25i4inadyUOTJtjQc4as+cjnY
         J4oQvI2NMeY20DwoXKV/6vMeE6DzvqN9jnq53bnGYyVnHWpnK7hFcXfQ6DfX+71VV9N8
         MIHA==
X-Gm-Message-State: AOUpUlEuWracABVLJROCrt0o3dQRfhVJO6WQ037EIxQiAZTS8920gM+O
        IfqManxnfU6fm6zj6G3wRNHZrw203lDs+zaC5hI=
X-Google-Smtp-Source: AAOMgpdQQpwJIAny18VVMPiso/54YQdm2c7QT9eQBPivYD4EsUXFgolaDJIQ1x2CuguPhq5Blzw1D7VAGRMRcabjKks=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr8854447itb.38.1531620650437;
 Sat, 14 Jul 2018 19:10:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:10:10
 -0700 (PDT)
In-Reply-To: <CALvZod57QFRVQ7kM4LSNQJACQ+dGC_otJkqK-5+i-0b53Zq5aA@mail.gmail.com>
References: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com> <CALvZod57QFRVQ7kM4LSNQJACQ+dGC_otJkqK-5+i-0b53Zq5aA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 15 Jul 2018 10:10:10 +0800
Message-ID: <CALOAHbDV73+X-y7V2Z4nX1C7uCY6yzBPTPZhEvTpN3f7_qWwUw@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid bothering interrupted task when charge memcg in softirq
To:     Shakeel Butt <shakeelb@google.com>
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

On Sat, Jul 14, 2018 at 11:38 PM, Shakeel Butt <shakeelb@google.com> wrote:
> On Sat, Jul 14, 2018 at 1:32 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> try_charge maybe executed in packet receive path, which is in interrupt
>> context.
>> In this situation, the 'current' is the interrupted task, which may has
>> no relation to the rx softirq, So it is nonsense to use 'current'.
>>
>
> Have you actually seen this occurring?

Hi Shakeel,

I'm trying to produce this issue, but haven't find it occur yet.

> I am not very familiar with the
> network code but I can think of two ways try_charge() can be called
> from network code. Either through kmem charging or through
> mem_cgroup_charge_skmem() and both locations correctly handle
> interrupt context.
>

Why do you say that mem_cgroup_charge_skmem() correctly hanle
interrupt context ?

Let me show you why mem_cgroup_charge_skmem isn't hanling interrupt
context correctly.

mem_cgroup_charge_skmem() is calling  try_charge() twice.
The first one is with GFP_NOWAIT as the gfp_mask, and the second one
is with  (GFP_NOWAIT |  __GFP_NOFAIL) as the gfp_mask.

If page_counter_try_charge() failes at the first time, -ENOMEM is returned.
Then mem_cgroup_charge_skmem() will call try_charge() once more with
__GFP_NOFAIL set, and this time if If page_counter_try_charge() failes
again the '
force' label in  try_charge() will be executed and 0 is returned.

No matter what, the 'current' will be used and touched, that is
meaning mem_cgroup_charge_skmem() isn't hanling the interrupt context
correctly.

Pls. let me know if I miss something.


Thanks
Yafang
