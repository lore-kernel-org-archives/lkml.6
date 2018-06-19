Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC8D2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC8D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965829AbeFSJwK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:52:10 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34325 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965682AbeFSJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:52:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so19874547wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 02:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dz8mTuvwsgnK5meC62JXAVfSSPMAUjJcUX43uqxR/b4=;
        b=UTNTKn9BqHODQLGO92/35TmKRY3vLm8lG/gZAChpsiOnTp98bdb/chqhEOjP1ISg0O
         ShTgJLjsWfG/S7ARSm5PpJKOkkCDXm2dXR1yZURcLPAhJ+yQpoGFTGbV9L5Ab3ujvo7Q
         76zqaw8MSKh1jqR0zxjXmnsClxYARzYwVPDnghDPyhyziLiwqr9LcRz3LKv4vnro8fv8
         UZl0j75wrcajh1TyD3E0RBPvaf5G2qcU2+vJ0UGA3+dAGdv2xXQ4eNM265FHwPelj56L
         JtiJTPpCxJWOCg3viNtJQ5cd9OmrmaUlW3bU5gzMN3FDOGrnCFaSMjXJ3L7Jea3EMsSR
         /Gug==
X-Gm-Message-State: APt69E1UxATQ9g5YGXxdPv/UKqYW5Q2u2CVx38AZ2nyYMDOgHwkS8UIO
        DGMnwUa1Y2obAVyb2Famx0opvQ==
X-Google-Smtp-Source: ADUXVKIFV4qYDhPy/3SmZxWqWqMSMz9pTHroHhIK42G6QTgcuqKDjWGL/O8mFmcoSP+LpGC9TVgvTQ==
X-Received: by 2002:adf:ea44:: with SMTP id j4-v6mr13624045wrn.224.1529401925476;
        Tue, 19 Jun 2018 02:52:05 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id v68-v6sm13853222wmd.12.2018.06.19.02.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 02:52:04 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:52:02 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v10 0/9] cpuset: Enable cpuset controller in default
 hierarchy
Message-ID: <20180619095202.GB13617@localhost.localdomain>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529295249-5207-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/06/18 12:13, Waiman Long wrote:
> v10:
>  - Remove the cpuset.sched.load_balance patch for now as it may not
>    be that useful.
>  - Break the large patch 2 into smaller patches to make them a bit
>    easier to review.
>  - Test and fix issues related to changing "cpuset.cpus" and cpu
>    online/offline in a domain root.
>  - Rename isolated_cpus to reserved_cpus as this cpumask holds CPUs
>    reserved for child sched domains.
>  - Rework the scheduling domain debug printing code in the last patch.
>  - Document update to the newly moved
>    Documentation/admin-guide/cgroup-v2.rst.

By removing the redundant 6/9 as advised, I could test that this is
working as expected (at least by me :): https://git.io/fURIC

I played a bit with creating and modifying domain root(s), both with
legacy and default hierarchies. Looks good to me, you can add

Tested-by: Juri Lelli <juri.lelli@redhat.com>

to the series.

Best,

- Juri
