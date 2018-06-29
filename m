Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11F8C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4927927F19
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4927927F19
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936432AbeF2M6d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:58:33 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44716 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934758AbeF2M6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:58:31 -0400
Received: from localhost (unknown [183.108.164.149])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E7A92142404B0;
        Fri, 29 Jun 2018 05:58:28 -0700 (PDT)
Date:   Fri, 29 Jun 2018 21:57:05 +0900 (KST)
Message-Id: <20180629.215705.881234148380578564.davem@davemloft.net>
To:     shakeelb@google.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, gthelen@google.com, guro@fb.com,
        edumazet@google.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] net, mm: account sock objects to kmemcg
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180627221642.247448-1-shakeelb@google.com>
References: <20180627221642.247448-1-shakeelb@google.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 29 Jun 2018 05:58:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 27 Jun 2018 15:16:42 -0700

> Currently the kernel accounts the memory for network traffic through
> mem_cgroup_[un]charge_skmem() interface. However the memory accounted
> only includes the truesize of sk_buff which does not include the size of
> sock objects. In our production environment, with opt-out kmem
> accounting, the sock kmem caches (TCP[v6], UDP[v6], RAW[v6], UNIX) are
> among the top most charged kmem caches and consume a significant amount
> of memory which can not be left as system overhead. So, this patch
> converts the kmem caches of all sock objects to SLAB_ACCOUNT.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> ---
> Changelog since v1:
> - Instead of specific sock kmem_caches, convert all sock kmem_caches to
>   use SLAB_ACCOUNT.

Applied, thank you.
