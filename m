Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F00ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE01120C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Hn/vgjdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE01120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbeGQMqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:46:16 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33290 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731258AbeGQMqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:46:16 -0400
Received: by mail-oi0-f53.google.com with SMTP id l10-v6so1577681oii.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 05:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RFSxLmV5XRvk6onU0K53XB6cLUvMH5u79t53P9Dy/Eo=;
        b=Hn/vgjdwQ197IABewW6nhn0MEvTvwSPWR1dWb5zfGjKiYusfmy6Xa1+Gp/hvpi2OpB
         v3afJDJLv8k6jWdzt1A9GPwKm6vbbbDjajMz4G+XncsRqkbhBmvCgD8A5qVIBoX4s1zH
         9+vFIZHogZGCJUoNO8uyehBfO/ckOlLBwVT/g7YQpAJYETVvKLeh7YxvK0q/BMVbtw7D
         mmJsj1/Z25f6MR0U65F0Pq4dGe4yXz7cvkqnyRYBedL4I+9ptUoZ1hsQoDtEASISOqye
         v2Tix9mXAR+lxz8tSixWk3ze04XodMSYdOZLSN9oORZMGKDmLt8U9z74x6M0qOrCNW7z
         a0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RFSxLmV5XRvk6onU0K53XB6cLUvMH5u79t53P9Dy/Eo=;
        b=OTXnYwTg9vsskUXLY1i+DbgTBD6zl4jh09mez4o736VuTKbgC5qOm3Bi8iknvY574k
         b0MM6R99jkw1bB58fBKHdOv4AdIvofA+4C1rXt/pmjjxx9CVbvF07wMWggWQxk3XCoIA
         8hm4N3JMUa/zYEY9pjibAPQ8GZTIf2RwaQ4P1Oxg27Jh/sM+GovUBkKHSErcuog3Cw5s
         AWUzSfzQdIglXWy210W0drar6YH35ZHSzOVDdKD+q3e6dJiP7dgwaIPusFLcObhuOZx6
         wuglRLXvwyJkW0DqKDI7Hyvrt44cK6qXxjIiH+GFXSI+OoZvPYfwX7dVol8HvSEhIazp
         Jb1g==
X-Gm-Message-State: AOUpUlHjDMDyjaiMqP4U6+YdPaF1uI8mSThR7wuZAOgpr01HAWZbfvyq
        U+d0jEDyP9icB1gCDgcnYLo1jJteVIxr/TqrGlr/yw==
X-Google-Smtp-Source: AAOMgpcr1SKvKvwUPLXSJbRQHUYLxO/ehrGyy8OR+/SGFSPJuzZ+9B1k0IBxm1z5XVp8uhgc7jva6EH5LBNRk2rT7wE=
X-Received: by 2002:aca:afcc:: with SMTP id y195-v6mr1452082oie.322.1531829633203;
 Tue, 17 Jul 2018 05:13:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3e18:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 05:13:52
 -0700 (PDT)
In-Reply-To: <20180717112515.GE7193@dhcp22.suse.cz>
References: <20180712172942.10094-1-hannes@cmpxchg.org> <20180716155745.10368-1-drake@endlessm.com>
 <20180717112515.GE7193@dhcp22.suse.cz>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 17 Jul 2018 07:13:52 -0500
Message-ID: <CAD8Lp45W00ga-P-nb6iytgSGW4xwSzmaTHA87DOvSotN0S2edw@mail.gmail.com>
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory, and
 IO v2
To:     Michal Hocko <mhocko@kernel.org>
Cc:     hannes@cmpxchg.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        linux-block@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>,
        Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>,
        Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 6:25 AM, Michal Hocko <mhocko@kernel.org> wrote:
> Yes this is really unfortunate. One thing that could help would be to
> consider a trashing level during the reclaim (get_scan_count) to simply
> forget about LRUs which are constantly refaulting pages back. We already
> have the infrastructure for that. We just need to plumb it in.

Can you go into a bit more detail about that infrastructure and how we
might detect which pages are being constantly refaulted? I'm
interested in spending a few hours on this topic to see if I can come
up with anything.

Thanks
Daniel
