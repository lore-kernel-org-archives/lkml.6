Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E43C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64D7206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkMSbU62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64D7206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJCCve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:51:34 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34751 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJCCve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:51:34 -0400
Received: by mail-yb1-f195.google.com with SMTP id 184-v6so1365868ybg.1;
        Tue, 02 Oct 2018 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QlWTy0mqvsJMaoHzIum62k26GAzGa4P6alp0zN7hjTc=;
        b=lkMSbU62adT7EicXRo7qEQQ9IoIpQjiEvv/fSozErRkZFpeTI21t0sKNa8BFLHq2vZ
         dYNm/w8wxmj7fXYblwLV1vb1YcR18FP5BSQAQiY3mtmjUmRZqNvdQZiQnQfaHEc2wlNd
         vso0tS+JmaFiT6OefvK3dsCayG2i38tfLk4AIBNv0dV3mfKy5VIV2lj1mGdISEbz+QVL
         Bzhcuf+huTyp7AHIR4TnhUFhnz0TypzjEipersOKHdzH4lte8Gj+Jex7lC1qeL/DEcFf
         RhmcZHBYZ2+KsUioqQPOX9Esm3jPI0NID60w9lHKMlCvm8YlMGEYETnMd+61UIoqX1Gs
         /IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QlWTy0mqvsJMaoHzIum62k26GAzGa4P6alp0zN7hjTc=;
        b=Yn7H9EBKs1ZmRv8IcMSvk9dNjmxy313BxNwemsry6aJlKuPECE+IKR3EvMBJHv/BMX
         gWhc083AL/Q3+S8X9AlexI/uHuAbX5qH1klIJ+llySPraU+XqQV01o36DKs9f05cVJDo
         /4LLhsCe9aXqyrk/TjRQbdz5DrflBhb5Bh9PqAoLHGruty71Tm47YVEzfyO72E6GQLhW
         GCbO6lbJqObpRFlrmUz8NWuBDYw/G3CGPkRvCXuKNAJUV7BVyfCunNlNOyDM53sdpQft
         V1ZwqnSHx9H50uydckTbjr3GavNduxXMXLZ0Vs0Heohx7HROq+S7o697ANUwxV8cVX5Y
         FkmQ==
X-Gm-Message-State: ABuFfoi8TYZ6CGdfQXd1AAlfmMt9YpKBl8HrnpxrnBSrBbzfUaaXGXPg
        jPcmMk5g+eIGjQ6EF3NMj2E=
X-Google-Smtp-Source: ACcGV62+aeHGWzfwcsGqonBnnAhxwiAF7M5o20eVvFEQ0WYyDDDwusZlqXQrA79BZZBxNk+wQiQbTA==
X-Received: by 2002:a25:185:: with SMTP id 127-v6mr300818ybb.154.1538510790401;
        Tue, 02 Oct 2018 13:06:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::7:aff1])
        by smtp.gmail.com with ESMTPSA id v34-v6sm14678106ywh.45.2018.10.02.13.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 13:06:29 -0700 (PDT)
Date:   Tue, 2 Oct 2018 13:06:27 -0700
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
Subject: Re: [PATCH v12 9/9] cpuset: Support forced turning off of partition
 flag
Message-ID: <20181002200627.GI270328@devbig004.ftw2.facebook.com>
References: <1535380884-31308-1-git-send-email-longman@redhat.com>
 <1535380884-31308-10-git-send-email-longman@redhat.com>
 <20180827164004.GE3978217@devbig004.ftw2.facebook.com>
 <0daf1f43-2292-0281-3ab8-aef20d0475dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0daf1f43-2292-0281-3ab8-aef20d0475dc@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Waiman.

My apologies for the delay.

On Mon, Aug 27, 2018 at 01:50:18PM -0400, Waiman Long wrote:
> My current code has explicitly assumed the following relationship for
> partition root.
> 
>     cpus_allowed = effective_cpus + reserved_cpus
> 
> Also effective_cpus cannot be empty. Specifically, cpus_allowed has to
> be equal to effective_cpus before a cpuset can be made a partition root.
> 
> Any changes that break the above conditions will turn off the partition
> flag forcefully. The only exception is cpu offlining where cpus_allowed
> > effective_cpus + reserved_cpus can happen.
> 
> One reason for doing so is because reserved_cpus is hidden. So the main
> way to infer that is to do cpus_allowed - effective_cpus.
> 
> It is probably doable to make cpus_allowed >= effective_cpus +
> reserved_cpus in general, but we may need to expose reserved_cpus as a
> read-only file, for instance. There may also be other complications that
> we will need to take care of if this is supported. My current preference
> is to not doing that unless there is compelling reason to do so.

So, if we're gonna make this hierarchical, I think it probably would
be better to go in all the way.  It's kinda weird to mix the two
approaches - the normal cpuset operation following the usual
convention (it'd be really great to fix the removal part too) and
parition code doing something else.

I think adding another interface file should be fine here.

Thanks.

-- 
tejun
