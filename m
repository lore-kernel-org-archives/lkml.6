Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915C8C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A8B217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOr5oVu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A8B217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeHCXxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:53:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43157 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbeHCXxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:53:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id d17-v6so3415541pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S94Ur3yHnogMUMEauakXvWjD9Q/olz8XW8y6nwg3/8Y=;
        b=FOr5oVu1m0AeBEpxDhT6rUPmgnCkEEQHicJIr+l3HhevomZrzkVDb2sQaMPFjhGtFX
         GI/2UR90JOorJca+j83nzX7+xYENs7bwLJQ3LloW0VDJPM83D4bw1xZCNzJ5Inxc9X6f
         NnqjONqWcGpXYX/aCs/whC51JayteFQ+xSRlkU73MxCQh+F4gDtA+oNY0TzwsL3qsD1p
         mpn8mIOIwUnwqtYhsKDjHEPq6/6jg/Rnb5eASYpwRrSA00nutKEe3WvL10C4kZMFzOhs
         /CorpugNdBNOTz6RrXQP3wtxk9dHr3GKmWJ0DWFt5na9rQkjaOvlWQA2FUrBrUOlEOZq
         FGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S94Ur3yHnogMUMEauakXvWjD9Q/olz8XW8y6nwg3/8Y=;
        b=YcA+mK1ZGzQfv39a9FENC8Ge+07PZpXgLqpmbxloI/LnjSzFlro/SzK/vLdL8gf0gX
         W/xag74Vdh8IYWw8A0JhvyE5QV968iTv5IVxRzC8GHE6ensR41lMqJ7nrkLtZYNccSPd
         DhtcBvLnxbJRgDfVkE6HlRnAsynNgI/C0EVNhBjFo1vABPyLboBm7loYR7BWJn/UghEf
         GwRa7U5h4KVuZK9Iz2RPM3lrGFKnO+FUvkvtO8U0j8ykfFRkYaDxQP8VIRtskUJKIUS1
         4+PGNAlt7novsGIOqhmJ3DKMZT9MmhDB9aR4F1AIU6H4kyqIzEOBV3bVro/vST6hGnr0
         iHZA==
X-Gm-Message-State: AOUpUlHqdWF36x3H5lhFGAyRCruuX1elZ3WlzQbvUop6ozXZq7SIItmX
        Hk2mpL79b4x+5obQARWQ0biz7wUxL8sm/4iTge4=
X-Google-Smtp-Source: AAOMgpdMdcXQixsSWGw5/sGVvP8Rz6LTjfkK7rs8c1pAH0v32c2uH8JGidoO3vB3whEjkkUXxQS9G84i6tZFkJBjhh4=
X-Received: by 2002:a62:9683:: with SMTP id s3-v6mr6379555pfk.191.1533333322706;
 Fri, 03 Aug 2018 14:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180728002409.5781-1-xiyou.wangcong@gmail.com>
 <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com> <CAM_iQpVeK2VQDuahreZC2-L4eEzx0WtD8Bz=oHH68VSAiMqLGQ@mail.gmail.com>
 <fad5ebe6-ec49-c67b-7b4f-78a413723aa8@linux.alibaba.com> <xm26ftzz8h0r.fsf@bsegall-linux.svl.corp.google.com>
 <CAM_iQpXGCqo9AAp2kpSKk9sHx0ZRK7JU_c07sWh4vR9kFQ+LxA@mail.gmail.com> <xm267ela80qn.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm267ela80qn.fsf@bsegall-linux.svl.corp.google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 3 Aug 2018 14:56:03 -0700
Message-ID: <CAM_iQpUA8mn_kTGsJJDKBH0gF1tErg3RnuG0bYd6amH2T_YLHw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: sync expires_seq in distribute_cfs_runtime()
To:     Ben Segall <bsegall@google.com>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 10:17 AM <bsegall@google.com> wrote:
> Yes, in practice what's actually going to happen is that the
> runtime_remaining will be put to 1 by distribute, the cfs_rq will be
> unthrottled, and then when it runs it will go negative immediately and
> hit the negative check in expires, so expires_seq being wrong will not
> actually matter. In addition, the worst thing that will happen if one of
> the account_cfs_rq_runtime(cfs_rq, 0) paths is hit first is that it will
> lose 1ns of quota, which also doesn't really matter.

Ah, I see.

Thanks!
