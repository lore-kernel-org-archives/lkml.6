Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3467C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F002089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB/luPtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F002089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJPAVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:21:43 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35076 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeJPAVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:21:42 -0400
Received: by mail-yw1-f65.google.com with SMTP id y76-v6so7760490ywd.2;
        Mon, 15 Oct 2018 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t0IESHF1ZWVIQ9LLdT48/Dib/xD5iVXdavDQf2nKJoQ=;
        b=aB/luPtq6Fyw3ZPiaiNEe6MADBTomOHOTAtnyZQs1B+xXIlKXKE9Ic0sF/I9O5DoMl
         UgWeLl5fmFy5ZzPiNr7YMfIWhDunnb5R6Xt28XgU19rycd4c60rvntUay/Xe4myc9Ui+
         TrIgO2Kvc0ETwqiLP6yfNA2SiDK/Xb/viRUA6vzPZCA/IeI0zW8bTxiZD3U3ADU6h6eb
         UzQT0xjdK1SU5Vdvj56+MNelWqZh+DTNKJt6l4R1TVheuXeUhXUAlObogHfQoQ87LGDW
         232Q/C5PYCgKV2ZfyIMIUkvhT6iS8bnyoy9UO3jvT1dy19/wt8gdffGYmIE/o3AEBZzM
         erQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t0IESHF1ZWVIQ9LLdT48/Dib/xD5iVXdavDQf2nKJoQ=;
        b=DPtGTD9h1p31rz17KGtvO2xY33SQyF2/iIuBTg1ji8NUTWX+VLPWfbqs00rkzfcf/I
         QxXe/b8qRzYJg0C4NC306F9ZvkdglGi6+ePU5Abkchwi1wJwujYVm8w4sftivQ5MLSiO
         +J2iK+I0hS3D3YQwUcvJS9OaKMliOHdO4eBxb1CZb28qlPSKP9shKfmmkgR6AzNcCJw5
         z41kLMeg/vd4NUuR7CJFcQwMZ/h7nsm6d9cD/li/VWGJt1Zwbq9DjLvSgKiHWuM5h2O9
         cBKoZ7WvsD7LASVNef09KUY+fqiVVQyPdF+Mt6V6l+vqXBhF159jI15PC4U/gfXb7fP2
         SC/g==
X-Gm-Message-State: ABuFfoiCNneL4PLncsw0BpIGPzRuaCvvLs2zb6ktjszMsoVqbndMhMwT
        m+BXaSOwYVT+bP7cvrh5hfg=
X-Google-Smtp-Source: ACcGV62BMfuk7oVAC8RxjnQDtMkt/PPGh4ZO0uDVWjf/GEcpdzeRsvVbvJDqgrQDYFm5PvKKGDQO8A==
X-Received: by 2002:a81:ae5f:: with SMTP id g31-v6mr9672666ywk.372.1539621344048;
        Mon, 15 Oct 2018 09:35:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:c108])
        by smtp.gmail.com with ESMTPSA id c128-v6sm4052762ywb.68.2018.10.15.09.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 09:35:42 -0700 (PDT)
Date:   Mon, 15 Oct 2018 09:35:40 -0700
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
Subject: Re: [PATCH v13 00/11] cpuset: Enable cpuset controller in default
 hierarchy
Message-ID: <20181015163540.GQ270328@devbig004.ftw2.facebook.com>
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539366951-8498-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Waiman.

This looks great to me.  I have only one small nit in terms of
interface.  Currently, cpuset.partition file uses -1, 0, 1; however,
given that this is consistent with how cgroup.type behaves (something
can be set but may be invalid), I wonder whether using a similar
syntax would be more consistent.  e.g. sth like cpuset.type which
takes "normal" or "partition" and shows one of "normal", "partition"
and "partition invalid".  I'd be perfectly happy with that being a
follow-up patch.

Peter, does the patchset look good to you?  It does everything we want
it to in terms of sched domain partitioning and is compliant all
cgroup2 conventions.  If so, I'll apply the series to the cgroup devel
branch.

Thank you very much for the work and persistence!

-- 
tejun
