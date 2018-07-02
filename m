Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85132C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F26424FAE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTF0KCkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F26424FAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeGBQx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:53:27 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39474 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbeGBQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:53:25 -0400
Received: by mail-yb0-f194.google.com with SMTP id k127-v6so5330974ybk.6;
        Mon, 02 Jul 2018 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Jg384EXlL606hr7KDYmXTRZefett+h7ct6FErCR4KM=;
        b=vTF0KCkjDxod1McirjGM++UnOdf+UcWoBW/8oUucmewwqecKbdt7WSYmldW4vaG5oi
         6hLyF3FnVo9BLcbHnRpQw5GYkThh6rbYlo9hA6KhL9F1XQ0Qw/eMecwBZiEni1nigOkC
         2ug5+0NodhNdWJ2y6/0RigvZIqHBEl5AhYTl2XIpwZtapo1w4mCM3QxJT1BwCa4DMhhd
         Ek2BNz+thz+9AR8ym7mH1felvuD/hUd4qpsgg80RtDQr+Vz/pfQ38Q4JQMeY7OeLghxx
         thKh03zSSeoiTvHOCMmlUe5GxUjVOIccEIS/nKjDkwME3uIupnfOjAtrORkpMFyYsi4v
         L02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Jg384EXlL606hr7KDYmXTRZefett+h7ct6FErCR4KM=;
        b=GhoaVDQkRPYBZ48xdSEiZDraYOr4Xs5qkV2/YoVc6cNpOFFjtfsNktJ6uypzMl4ofu
         899f47sqyiNzZzNmnZjBaaDWfZCULZFGdI6E6+FiRq88gpFApSDqLlyGfVJMIGioQMwz
         Z4ny/LKcL0cwnUsKH1K3fkSjFsFlO18ojAsJvN6Mmua6IPrcJiLenaYa1sTNUTOndhWh
         o2AIQxIK7s3/lwSBB7tabniSvOWABvFBKSDqO8GSAuGRlIBCYtt32/fecHg0Hg/aUCV0
         7z28P8qq8uST3Tx0wGLUKc7YhbEhs9dnZgSa86tZkHOwspzEgutT4ZRfzqXEeRzcXbkg
         QZng==
X-Gm-Message-State: APt69E0XmGg/X44XP+ign/d1/PWuv32BaKu66D63j6LeJwqtfjmnySKH
        6G1XgaVkrZmnQYKtvkpMp1M=
X-Google-Smtp-Source: ADUXVKJxJIABeAqEZRq7DYC3VEbFtUz1If9+GedVhIoCX7dZ3xJTchOJQxW+BwSXEzWltjE/8fjhGg==
X-Received: by 2002:a25:f510:: with SMTP id a16-v6mr13787283ybe.36.1530550404910;
        Mon, 02 Jul 2018 09:53:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id d11-v6sm6576877ywd.1.2018.07.02.09.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 09:53:23 -0700 (PDT)
Date:   Mon, 2 Jul 2018 09:53:22 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
Message-ID: <20180702165322.GI533219@devbig577.frc2.facebook.com>
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
 <1529825440-9574-8-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529825440-9574-8-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Waiman.

On Sun, Jun 24, 2018 at 03:30:38PM +0800, Waiman Long wrote:
> Because of the fact that setting the "cpuset.sched.partition" in
> a direct child of root can remove CPUs from the root's effective CPU
> list, it makes sense to know what CPUs are left in the root cgroup for
> scheduling purpose. So the "cpuset.cpus.effective" control file is now
> exposed in the v2 cgroup root.

So, effective changing when enabling partition on a child feels wrong
to me.  It's supposed to contain what's actually allowed to the cgroup
from its parent and that shouldn't change regardless of how those
resources are used.  It's still given to the cgroup from its parent.

It's a bit different because the way partition behaves is different
from other resource konbs in that it locks away those cpus so that
they can't be taken back.

What do people think about restricting partition to the first level
children for now at least?  That way we aren't locked into the special
semantics and we can figure out how to this down the hierarchy later.
Given that we ignore the regular cpuset settings when the set goes
empty (which also is a special condition which only exists for cpuset)
and inherits the parent's, I think the consistent thing to do is doing
the same for partition - if it can't be satisfied, ignore it, but
maybe there is a better way.

Thanks.

-- 
tejun
