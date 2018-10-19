Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B90ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDE321470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gbp2uC8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDE321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeJTDcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:32:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45066 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeJTDcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:32:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id m8-v6so21680513qka.12;
        Fri, 19 Oct 2018 12:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jHydDG8+60wpJW/CzjZHlAATZ1UOTmTYFr6noyYndLY=;
        b=Gbp2uC8rJfrn6zjV3mVIIh+M6Z5vFHBiIkE6Hhac3yxx2vHU4dyWUsne6aB214PVCf
         hY8C61E7xp/DO0F9kIYg55EteS7MlW3WNDgRgQ9aFRj+7+tyVyYSWkokCisKA4jG9JPp
         YvKh7vsKkiJs6jrU3PTCw/lkuF0BhDQ/ax9iku0hP4lSNM0i4E8c88z/1MPmpvJ/lAZt
         mK+oCQscWinWN0UdhxNj+N2H5OO0G+tJu4UeO4yhulBlFxKZ3VBgaVDcSsNx49lFdflq
         p95PYi4LbbAaT32eGIkc4AAzlywgOslneVrM6pglGBO9ignvhNa4sAi9vEtfpicXRPnw
         MDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jHydDG8+60wpJW/CzjZHlAATZ1UOTmTYFr6noyYndLY=;
        b=L2AWDX+PP4covlQ3mjaA/nTTDjOIcPS3j5G3uvDBviRSE2s5Q7hBSWE98oAOwNwxdU
         KODJk/9AlrIMqrPP4+rcbWX8h4KfhK84bNK7iUSiKzjqfU4vak3lmhcXoQg/NqBOkfau
         0TiqlakGi/iVsJ79Z1+n/2DIkekkG5cjFrRSqwoo38sL9O/xXuWetpYke3PfP2IGVeP6
         UVndIvf3KK+Qd5UekP8TmGAQMSMMRjH0DSfMLAKFEbbGyMelbkOLtPlZTSXXycM51Cnt
         Ekpw7mjLNLgnnLLTZg1o9IkTdh5jHfjqp9nQDsFib/a1/WgcKLQXL+ocgrB3Nw8mqORp
         z6eQ==
X-Gm-Message-State: ABuFfohrzhRpGRz5JC3ACIdVgno9bB5jbwRCGnb8hWekhpk96Sn2lW4t
        GnGoK40bxaEesVlP7PncwfM=
X-Google-Smtp-Source: ACcGV61V6gRiJK6u8m+b/G7kLFFJr7+cP+53Zruc9hHyNZMG61Hc4IsstK3XKDxEv2tmUZhTyhyg2Q==
X-Received: by 2002:a37:711:: with SMTP id 17-v6mr11016728qkh.64.1539977088233;
        Fri, 19 Oct 2018 12:24:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:1eb8])
        by smtp.gmail.com with ESMTPSA id 14-v6sm8110608qki.73.2018.10.19.12.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 12:24:47 -0700 (PDT)
Date:   Fri, 19 Oct 2018 12:24:44 -0700
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
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 12/12] cpuset: Show descriptive text when reading
 cpuset.sched.partition
Message-ID: <20181019192444.GV270328@devbig004.ftw2.facebook.com>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <1539635377-22335-13-git-send-email-longman@redhat.com>
 <20181017150836.GS270328@devbig004.ftw2.facebook.com>
 <b797288a-6088-f7b0-c881-81633c071754@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b797288a-6088-f7b0-c881-81633c071754@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 02:56:13PM -0400, Waiman Long wrote:
> On 10/17/2018 11:08 AM, Tejun Heo wrote:
> > On Mon, Oct 15, 2018 at 04:29:37PM -0400, Waiman Long wrote:
> >> Currently, cpuset.sched.partition returns the values, 0, 1 or -1 on
> >> read. A person who is not familiar with the partition code may not
> >> understand what they mean.
> >>
> >> In order to make cpuset.sched.partition more user-friendly, it will
> >> now display the following descriptive text on read:
> >>
> >>   "normal" - A normal cpuset, not a partition root
> >>   "partition" - A partition root
> >>   "partition invalid" - An invalid partition root
> >>
> >> Suggested-by: Tejun Heo <tj@kernel.org>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> > Can you also make this consistent when writing to the file?
> >
> > Thanks.
> >
> How about the attached patch instead?

Looks good to me.  Once Peter is okay with it, I'll roll it into
cgroup devel branch.  As v4.19 is almost done, I think it makes more
sense to target the next merge window (v4.21).

Thanks.

-- 
tejun
