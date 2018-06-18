Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62838C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261E120852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261E120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934847AbeFROUn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:20:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38565 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934284AbeFROUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:20:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so15933414wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=udMFiR+A6fu0YVugLCc1lt47GsnICt8roV0x8/yYyy0=;
        b=QbyPl0Xkf//H8ptu/tJR6/zgjBGTYs5b+b42ulwahoKzJYNn0lMrLYJ2k1SVf3jsA+
         vAAW2o1vG/CIoWcwSnaeArVOGZaS8XN4Gntuf60cMuit6Uze61jAuY5fKRgorcB3cJ6G
         i6xrKPeAYAJae6VgEKdy7E6quhfQaa4ftKY7rf5Grvu7zhw3ybFzJAo1FBqbLNMo6GTh
         iAhA8W5KV6QpTeiZAYbTK78b4MBcoviZnCiveBP/sneKJividBg+b1daACXxGBy1JpD7
         p6LIZSZkLrADgkVansXuHRG83l9nMnNhCcIariLxDrfA85kUlootlDzLQMbWKK7XtXd1
         RKdw==
X-Gm-Message-State: APt69E08bHx73Lg0ymg2D777/kIVNT3JWi5AwQPUFgrw7yoJMtaPRiU3
        2XXiFVJqG82lnmhVYdWgJBfi1Q==
X-Google-Smtp-Source: ADUXVKI3czwOzX+EAeazELMIYomwIeKl+T6MRz2746CxsijB6m0xBZRQNLKYrzE1mZ2mIyrH4G70Yw==
X-Received: by 2002:a1c:110a:: with SMTP id 10-v6mr8049986wmr.130.1529331639589;
        Mon, 18 Jun 2018 07:20:39 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id z83-v6sm9209058wmb.8.2018.06.18.07.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 07:20:38 -0700 (PDT)
Date:   Mon, 18 Jun 2018 16:20:36 +0200
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
Message-ID: <20180618142036.GA13097@localhost.localdomain>
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

There seem to be two (similar but different) 6/9 in the set. Something
went wrong?

Also I can't seem to be able to create a subgroup with an isolated
domain root. I think that, when doing the following

 # mount -t cgroup2 none /sys/fs/cgroup
 # echo "+cpuset" >/sys/fs/cgroup/cgroup.subtree_control 
 # mkdir /sys/fs/cgroup/g1
 # echo 0-1 >/sys/fs/cgroup/g1/cpuset.cpus
 # echo 1 >/sys/fs/cgroup/g1/cpuset.sched.domain_root

rebuild_sched_domains_locked exits early, since
top_cpuset.effective_cpus != cpu_active_mask. (effective_cpus being 2-3
at this point since I'm testing this on a 0-3 system)

In your v9 this [1] was adding a special condition to make rebuilding of
domains happen. Was the change intentional?

Thanks,

- Juri

[1] https://marc.info/?l=linux-kernel&m=152760142531222&w=2
