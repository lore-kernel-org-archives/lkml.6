Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCAAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6700E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soG+wHgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6700E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755596AbeFSEhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:37:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33758 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeFSEhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:37:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so9278257pfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 21:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iVpZQylV/l4YCrHe7uhcehF0o/upZdwbWIREzqPsPUw=;
        b=soG+wHgdK2fZwx7MwLgjWH0McBjgIGQMsxxemz3Cb81raMqQz+ZdCQe3gegi8iz07t
         FxMVnExmqVb72Sd8y/ILb86yexF72glGxQMg8tGRPB0eVaX9zEVcFQvHEtCvCnDD776V
         NXgTQJZ1wCN+2Bt7cnGpNzuzyqqqEHkuKLnMXNjuq8s0XP+GVnrsGVnXAXn0F5Lputul
         q486RwWIHv0dpE6082rPTex1x6+EQf42zd4L5pW096tTd+E2lUiA77nVpANQvH7aa6Yx
         7HIpHf91+QDjNY6Bzj4kYauxHRZOUr0zv0eL5TYWurBqiUWqW90959ZIF9bMWiywr+/9
         pegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iVpZQylV/l4YCrHe7uhcehF0o/upZdwbWIREzqPsPUw=;
        b=km9nGpsZhwd54keOZvMaaor98XqVYtNJ7yGuh45lRUlvRhsNg4/Qxy2tiCAtT/hNKz
         /UDCE/cT/r0l+7vV4Y6FRraiuIAeNyRdMfMq1qFVB/1c1FDHm6kw6snqPbheH266bh3k
         0zFt7ahloII58boSusrnQ9T1Y7OTKzlf4UR+jYdsfibBEtFJDlCOAIYGrY5nCxmjMGBn
         ok+kBm15aZ55W6SOyBB5XtBcpRYwBApnxF+USthzKFaZPid2sC3yu54CKlI+L4QRis4c
         LMEQvLQQT7QJ+d9oNIwY41L69d1v1QdFZUhdDiKuSkkw/6FHs3LBI3+b094A3fUOm7nV
         +L1g==
X-Gm-Message-State: APt69E0mFL+SgoBtmax+NkdlZgqxic8qt92ZSetJvxsXSV+5cv4u9lFw
        JIaNyq4qdk7uKL1rpEcnQjNmceCP3xHL4THw/KM=
X-Google-Smtp-Source: ADUXVKJ6L5cuvAnYaNJqJVFazMeLSMfwx5bjbdDQTFqSzsXAoolTqOu60SEGsh6+YaNMJsno7dQscRwKcgUaa03EARk=
X-Received: by 2002:a63:62c7:: with SMTP id w190-v6mr13740891pgb.104.1529383029713;
 Mon, 18 Jun 2018 21:37:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:284f:0:0:0:0 with HTTP; Mon, 18 Jun 2018 21:36:49
 -0700 (PDT)
In-Reply-To: <20180618091657.21939-1-xlpang@linux.alibaba.com>
References: <20180618091657.21939-1-xlpang@linux.alibaba.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 18 Jun 2018 21:36:49 -0700
Message-ID: <CAM_iQpV-9_Q_xdNAobSq1bZXPm0kALAq1+Jc3BFpVAaQ2E_czQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Advance global expiration when period
 timer is restarted
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ben Segall <bsegall@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 2:16 AM, Xunlei Pang <xlpang@linux.alibaba.com> wrote:
> I noticed the group frequently got throttled even it consumed
> low cpu usage, this caused some jitters on the response time
> to some of our business containers enabling cpu quota.
>
> It's very easy to reproduce:
> mkdir /sys/fs/cgroup/cpu/test
> cd /sys/fs/cgroup/cpu/test
> echo 100000 > cpu.cfs_quota_us
> echo $$ > tasks
> then repeat:
> cat cpu.stat |grep nr_throttled  // nr_throttled will increase
>
> After some analysis, we found that cfs_rq::runtime_remaining will
> be cleared by expire_cfs_rq_runtime() due to two equal but stale
> "cfs_{b|q}->runtime_expires" after period timer is re-armed.
>
> The global expiration should be advanced accordingly when the
> bandwidth period timer is restarted.
>

I observed the same problem and already sent some patches:

https://lkml.org/lkml/2018/5/22/37
https://lkml.org/lkml/2018/5/22/38
https://lkml.org/lkml/2018/5/22/35
