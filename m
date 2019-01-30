Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ECBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA812075D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK4TeC23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfA3Xx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:53:26 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:44375 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfA3Xx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:53:26 -0500
Received: by mail-qt1-f182.google.com with SMTP id n32so1587041qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHTmlSdsw0ddv0WZw6NQBaf+Lx/v0lncj03Huj6mH3Y=;
        b=bK4TeC23YsjsP8RNdRKPxHm1ViwVEHRD6VQtzGDNTmcZTErjiXAPaCF5azuC4F2rkC
         kYLbhBtHWvyDyAhDY02uEB6Zpw0kjXIHiTDSjqNitSW3exLUEtHNV8gbs0pZ8CKknGlZ
         cBx50IZSB3mHYo/gce5rIAlWQVq1cE0SY7EyXWosrf+7BS4DXcnGNYpi+6YaFAa7UFBY
         2Z+9okFNtpOOcvWqOz68sRKeuvbMx0oHNhcUgZOu8+y1pfuWnYRQzJblcGGGY8XokKS0
         aRe/2cK9DvDfKzFucfkjVYhv0reC1415nsQagi5tHgpJwt1Fs1Ovl4u3qXdQeNTvjtZt
         S7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHTmlSdsw0ddv0WZw6NQBaf+Lx/v0lncj03Huj6mH3Y=;
        b=ignxDNLyIKn3W00sHxCUURYipSMTvtiA3shXXUgpiUII4PpcNajxlAwNJPtwasR7VE
         WGop+36I+7SiD/S3yoAzBcPKk+Kjl1/r2y7vMfXRnKV2Qe7DHq69QV2gnlhCWvKTrRFY
         0CF77YuWrwD6NhSVjNoV5A1ylz0+y8P9CeJTXWvYDNTwQB98RIgkYQFnCVgLOHJGhwRL
         WhL4j8xow78zQb6QMEaA36N1IK7OU4nYgozhxDcs1FnTljPFrh7Dii55BeA49Jt1jJcE
         vGWKq+Y2NgSYRojlZ6iooJKm+qa9lpYddicgP1FS/upRT247I9wdsCk/UL5M1ewRh8ua
         umEw==
X-Gm-Message-State: AJcUukfNtuxjJqKRhQwrPlqceqUK7Bnk4RBUf7KYB+A90w5cONL2AfWw
        rgt0gRZaSZA0/rKfiHFH4lv0soLix8KuMy/aoa8+Rg==
X-Google-Smtp-Source: ALg8bN7l1pcTFadDQJBk1003WV7PL3Ec7DdZpdu4BhZ+NzS6ABGQhPB26K4s11LeGdULTR4OOaaLmo987JTe5Yg9c5w=
X-Received: by 2002:a0c:d29b:: with SMTP id q27mr30512882qvh.62.1548892405083;
 Wed, 30 Jan 2019 15:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20190130174847.GD18811@dhcp22.suse.cz>
In-Reply-To: <20190130174847.GD18811@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 30 Jan 2019 15:53:13 -0800
Message-ID: <CAHbLzkpbWEVpeH9YsbBNy-Etfe0Pza5rPAe3b50sXq4rV4C+xQ@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] memory reclaim with NUMA rebalancing
To:     Michal Hocko <mhocko@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 9:48 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> Hi,
> I would like to propose the following topic for the MM track. Different
> group of people would like to use NVIDMMs as a low cost & slower memory
> which is presented to the system as a NUMA node. We do have a NUMA API
> but it doesn't really fit to "balance the memory between nodes" needs.
> People would like to have hot pages in the regular RAM while cold pages
> might be at lower speed NUMA nodes. We do have NUMA balancing for
> promotion path but there is notIhing for the other direction. Can we
> start considering memory reclaim to move pages to more distant and idle
> NUMA nodes rather than reclaim them? There are certainly details that
> will get quite complicated but I guess it is time to start discussing
> this at least.

I would be interested in this topic too.  We (Alibaba) do have some
usecases with using NVDIMM as NUMA node.  The node balancing (or
cold/hot data migration) is one of our needs to achieve optimal
performance for some workloads.  I also proposed a related topic.

Regards,
Yang

> --
> Michal Hocko
> SUSE Labs
>
