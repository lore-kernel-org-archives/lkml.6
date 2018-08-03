Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6852C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD6E2174B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIywzkq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD6E2174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeHCLF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:05:56 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:42178 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbeHCLF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:05:56 -0400
Received: by mail-ua0-f193.google.com with SMTP id w7-v6so3576511uan.9;
        Fri, 03 Aug 2018 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MjfqrzZHfRpozr0wDlqX5EDiihimjWJcn//FJkUZtP4=;
        b=vIywzkq+zZGo1gXRL6N5GpAeWidMCFUBKtamGi5SdPJrGYovjblX8W67OXnwOmZefj
         EzvnRNFzeKSRZmkcMyYzW9gJrF6hSYtOnoTpd/HgMrzMuzcg8Qb48dw4qBU29v31EDh8
         mwnBh9gVd1kXALXlvcEK/aZVTAKCXmyn0mVDhguY6LoOwHyr6m33CRjySNQpQF70KvI7
         N6ZemmQ7BJt7KfvytTUW8gWhlh+7CGb20QJke12oyT5Rum5MO9l3PgPWhDA9M6OrRW5b
         RP2K1Je13wrUuDCpWsO7F1pVdzOC3XXlCa3C8AV/ZxGRmgVLJ1kG2xCc7lLS3CGjCunK
         6vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MjfqrzZHfRpozr0wDlqX5EDiihimjWJcn//FJkUZtP4=;
        b=NVUp+7hL5ftnOlDMJvtk2EgH9EGLev9L8sKjoYBsqr3br9MGMrSPmr5FMNnLSiSNSR
         ic8qpbLa7BQDwoZfL+uWtT1H3DmjGhzYgr9sMjXjryimkWhhcTSU6TVJGMXvPvIakowd
         V65ZejLNsHb+Vkr0FD7AdWLgrK5Lvr1jyRz7vPre7ERtFGqYlUxonFdXswFwrAPga7v0
         cBla5UGgXolJZ3cYFzigSceBG7i9MNa2tHZfNMXnn2g07A0KVSWVJ0xEhCBYxKhXEm/m
         DjnIshGbHmKenht3qLDiEI5njSLvJJlKLeyqvEJA2VwRkiBd8y8hqCM6unQE1K7ga/i5
         i5Lw==
X-Gm-Message-State: AOUpUlHqS4KPeubqDOsQ7O5x/i14pKvs+mp+F6V6FZbNNX6UVmsDYHus
        Gwu0XwJU78Uth0atv5DUTD/8gq2iO9Tv4Y2L+vw=
X-Google-Smtp-Source: AAOMgpcWyJHYu7+Ux6JlHtGu0msuR1OEDr12Eb3YM21cGeSsFUWlh9tLUvfNdjaR8SF+8nddE+PX12fVWK897q2Tehs=
X-Received: by 2002:a1f:4c7:: with SMTP id 190-v6mr1819497vke.63.1533287432131;
 Fri, 03 Aug 2018 02:10:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 02:10:31 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.21.1808031156350.16@nippy.intranet>
References: <1533179408-20631-1-git-send-email-zhongjiang@huawei.com> <alpine.LNX.2.21.1808031156350.16@nippy.intranet>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Aug 2018 12:10:31 +0300
Message-ID: <CAHp75Vc8tWKUpKS8yY52CdJ=mU-iqcrUCz32ZSSJixLA1bM0tQ@mail.gmail.com>
Subject: Re: [PATCH] scsi:NCR5380: remove same check condition in NCR5380_select
To:     Finn Thain <fthain@telegraphics.com.au>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 5:24 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Thu, 2 Aug 2018, zhong jiang wrote:
>
>> The same check condition is redundant, so remove one of them.
>>
>
> If you are trying to find redundant code, your coccinelle script is
> dangerously flawed.

These days too many coccinelle helpers make people think they are
doing right "clean ups" when in the practice they bring the
regressions.

Julia, is possible by coccinelle to distinguish memory accesses versus
I/O? At least it would increase robustness in some cases.

-- 
With Best Regards,
Andy Shevchenko
