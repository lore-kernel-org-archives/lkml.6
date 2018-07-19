Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A427EECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F27B20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3I+R6/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F27B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbeGSRgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:36:07 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40335 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbeGSRgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:36:06 -0400
Received: by mail-yw0-f196.google.com with SMTP id p129-v6so3315185ywg.7;
        Thu, 19 Jul 2018 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S11QxldGb2rueyxaC44wods7Mrexh/qBlnMNZmhzCsE=;
        b=d3I+R6/dVKJ/ByZS3i5E/MQVNNXGPhHTCGua0IYNTSIDDusgYui+slnnSmN3+H/SPU
         kHqRNrcKKUs3FAbLr9L8trLadP+IgJFvlE+M5ji1s7HOxjL8QCcetLrssg2qEYzg3Moz
         lG6+dpj96Qj4jSHkspN3M57Yhh1Qom5uauTlrCt7pz80Zo/h9cPKRj87vbePV8cTBx2d
         9zOkqYh118nmtn91wxo0yNlqhq2pE+vHRdnSerYMs0I1MvLhhV0glNffOTWwG4JH4AsN
         F6fJ4FJkvieSR5xqQChUN0/mS30fDvZj2kQgl0YueVLxWguforOnaV+dkFEE5bX3LDh2
         YOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=S11QxldGb2rueyxaC44wods7Mrexh/qBlnMNZmhzCsE=;
        b=QZGYfz8sq7RZddMJ71LNcZqGG6pRV3lo/O1UZ6n5xTJC8x8H9DBgz816ulYrbogooe
         XDGE76SV+tnFk/FCC2UA+6bCLM27TuO9135PlzHpZouvOMFttJjv0w3chpId3xgVhqSw
         2OqbK5tszRLwHoz9BrOsmjNXZxoeJh9geVprs2WFb30p82iKZMdrGQougEzDzsSclOui
         krqgtMZNmzWLt6ht7phu8KZg2ZPcH9xVh5j5qmA8XbrhalQUjrrKBItXaiSdHRK5K7gm
         S3lc2EDcqtqdeSDT8D+XRMid/0ItiwbgzSdI9YZivACyHSq1WXduhJqXhxMw0HTq+V9B
         wa4Q==
X-Gm-Message-State: AOUpUlHouzQ6S/UoL3upazSw4mJ2iLFrdPUsoMxcbf7UM9r8rlyrrDPB
        /28Vs0xZr5oFeJ1HGXFZosE=
X-Google-Smtp-Source: AAOMgpfOepzKPCja2sphOOasR66akfn1EaE0wz4BT5aXjh0BnkGPvzGTWACSAYM7uIfiLZXXNmrKKg==
X-Received: by 2002:a81:5194:: with SMTP id f142-v6mr5519752ywb.46.1532019124102;
        Thu, 19 Jul 2018 09:52:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1d36])
        by smtp.gmail.com with ESMTPSA id g203-v6sm3395834ywb.69.2018.07.19.09.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 09:52:03 -0700 (PDT)
Date:   Thu, 19 Jul 2018 09:52:01 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
Message-ID: <20180719165201.GU72677@devbig577.frc2.facebook.com>
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
 <1529825440-9574-8-git-send-email-longman@redhat.com>
 <20180702165322.GI533219@devbig577.frc2.facebook.com>
 <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
 <20180703155823.GS533219@devbig577.frc2.facebook.com>
 <20180719135224.GE2494@hirez.programming.kicks-ass.net>
 <1107494a-9667-df58-dcac-9366e969dc3a@redhat.com>
 <20180719153045.GT72677@devbig577.frc2.facebook.com>
 <de6f931d-613a-3e6a-2a4d-0e49b3bfe2e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de6f931d-613a-3e6a-2a4d-0e49b3bfe2e5@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jul 19, 2018 at 11:52:46AM -0400, Waiman Long wrote:
> BTW, the way the partition is currently implemented right now is that a
> child cannot be a partition root unless its parent is a partition root
> itself. That is to avoid turning on partition to affect ancestors
> further up the hierarchy than just the parent. So in the case of a
> container, it cannot allocate sub-partitions underneath it unless it is
> a partition itself. Will that solve your concern?

Hmm... so a given ancestor must be able to both

1. control which cpus are moved into a partition in all of its
   subtree.

2. take away any given cpu from ist subtree.

Right now, I don't think it's achieving either, right?

Thanks.

-- 
tejun
