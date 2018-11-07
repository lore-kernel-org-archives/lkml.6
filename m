Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8C7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC78220862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcliHLl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC78220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeKHHEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:04:48 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39390 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbeKHHEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:04:48 -0500
Received: by mail-yw1-f68.google.com with SMTP id v8-v6so5607569ywh.6;
        Wed, 07 Nov 2018 13:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ocqIJI97jpN2dVlV1t1A/wPKjhZZa+9X2Rj+z/TPzm0=;
        b=QcliHLl8U0U/LckvbdwuWgns7Sys/Ajc/dyupghRVgVL9fjW4dMTC3mmCQ2jviMJXy
         aJzZA854k8CtKAhWxFBeBDLSjKtmmMUZIiARA6gl+JJc+EL68abLyU9MgZKHKdrbZoLb
         8Oj/U+soaqUllCN5k+4uBnKsfVx33Kc+7+pTOpLMtcvphgrQ7ney6QRxTo3unQD/BXBD
         v/PhHifrsNA2C3rP1iHKlFg1TMOhaIuKSSbDqvuihI/KMUcbMDvC84A+DAB4PP0bRl8y
         0UrF2pC290gBPuN5JyI3WTG1M3ncu9z8YaAlZnun57+HqdHtCbSvxu6s8Sri8Bdt3kzd
         crkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ocqIJI97jpN2dVlV1t1A/wPKjhZZa+9X2Rj+z/TPzm0=;
        b=SRx5AK+NcxKQFnG9nN9Fih4epwdWxXtd2gUXqXz9nH8T4yaAx1QjZxVdxe3a0EYzlH
         qprlVDNNcYOLy5cZRI5n1yBvaiuCkZd1qH/Kyc8l1graHLWMSlBrH8T5fOAQXMNZtDT9
         JMR9UbiOpJRTTVEi0Fu6On7JjW0dUKCL6B9QakAEVgfAkxcTKCvqEIOLozTdGuPXY9H5
         FPdkNKLzGCosvi96KRUyG47w9NsK1fmtiqlHwON2aZQKipp+7Z+aA7fssORJATsKiukg
         m7ZENo8qxK5M0xEIK+r7uE8wALRUYey4HRVX5D2ggxQ4GhfgiK3mCvCejC1M1Izjz4KM
         RVPQ==
X-Gm-Message-State: AGRZ1gKrv1E73PsbCJfOD8Sk7k/HebMfsgYiOOWAbjuckY4GwCWxqAiV
        j+Q5fp/0mWQjBQLcTlShYtQ=
X-Google-Smtp-Source: AJdET5dUaqB2sRe5ZW2mI80McxL/+9fLVXp0ZjE6Z5aBMinmT8/YuLQcLarqnHlFTZnNRQQtTX9nNA==
X-Received: by 2002:a81:b2c8:: with SMTP id q191-v6mr1901532ywh.313.1541626353041;
        Wed, 07 Nov 2018 13:32:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:5ca9])
        by smtp.gmail.com with ESMTPSA id o66-v6sm1073096ywo.39.2018.11.07.13.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 13:32:32 -0800 (PST)
Date:   Wed, 7 Nov 2018 13:32:29 -0800
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
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 00/12] Enable cpuset controller in default hierarchy
Message-ID: <20181107213229.GB2509588@devbig004.ftw2.facebook.com>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <20181105163656.GK4182586@devbig004.ftw2.facebook.com>
 <20181106115335.GQ22431@hirez.programming.kicks-ass.net>
 <20181106115558.GB22485@hirez.programming.kicks-ass.net>
 <8c386375-b801-8adb-602e-40c73a7efedc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c386375-b801-8adb-602e-40c73a7efedc@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 06, 2018 at 09:06:01AM -0500, Waiman Long wrote:
> On 11/06/2018 06:55 AM, Peter Zijlstra wrote:
> > On Tue, Nov 06, 2018 at 12:53:35PM +0100, Peter Zijlstra wrote:
> >> On Mon, Nov 05, 2018 at 08:36:56AM -0800, Tejun Heo wrote:
> >>> Hello,
> >>>
> >>> So, this looks good to me.  Peter, I'm gonna roll the series into
> >>> cgroup/for-4.21-cpuset.  Please holler if you have any objections /
> >>> comments.
> >> Mostly nits, except I think the interface for cpuset.sched.partition
> >> needs to find another term for "not a parition", "normal" really doesn't
> >> work for me.
> > cpuset.sched.partition: "true", "false", "error"
> >
> > makes more sense to me.
> 
> The terms "true", "false", "error" look good to me. I can change the
> patchset to use those if Tejun has no objection. I will fix the other
> nits you have as well.

How about the following?

Interface file is named "cpuset.cpus.partition" as it's a partition of
cpus.  The writeable keys are "root" and "member" - a partition root
and a partition member.  When "root" is requested but can't be
satisfied it shows "root invalid".  This seems pretty consistent with
cgroup.type and other cpuset files.

Thanks.

-- 
tejun
