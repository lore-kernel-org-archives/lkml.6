Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE59160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2C920870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TohjyIPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2C920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeG3RUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:20:04 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:40671 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeG3RUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:20:02 -0400
Received: by mail-yw0-f195.google.com with SMTP id z143-v6so4524192ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CcwF2WCmVNa8GOt+pNf/D8vUHQHv+t38WGd7Mgl+/PE=;
        b=TohjyIPrbbw+CN4fwhkRrt6d4Quha94lKt3Oa/ESxwBl+IlgwbhVCXGIG/YuUtXVzN
         ytEA+00By6g2EjiuahbxaWvnfFoIWu0KTuz88v/aL08eaKdncW87N5F7jCEZN4HoUmx2
         plA3yzSUTAvzDfOamHbeRTYdL7oofrFzMVy6Y3dtcuSzvA6g6uEvaRu9WrUSuAqk0rpV
         MlLW/ct65ziYYdeoAnhmkTgzmiCWOUkchcpEnWNqYek9W+w9eREwFNa7v/J2TiQmX1kW
         ErKdz/oOeJv6dphkrCW4Kn1qpE9216cIqksoMByS8eyTf9W3aFgWU+GKeQUFZH/hN6FQ
         RwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CcwF2WCmVNa8GOt+pNf/D8vUHQHv+t38WGd7Mgl+/PE=;
        b=A+FQahz+mNBrCVW27q0i+8sqHRg6e/ewHAhhES/i9UKjiMKVfZBTXbolNLCnmRa00B
         JAjOURNvtXzX6Vzr/RImBCun3Qx8XRFWmcIsfTuMYJQyJQm5dRrs4bt/Jr4O/1gfr1op
         S4iGJETXAZrMt+n13JZERx2u6IQU6U3EeISTElWOe4jM98CX63efapglo+n6GbCJHn9W
         83+UlX97QrI5GmncM0tHFx0juBKF8UKFe4iWQ+7QHdAeo/G5mW/98ftM6Jass1EaOrot
         vRoJyAeDhcj7RDA2qnnihnL03DAVFh2WHFLLeVz04Yb1pYCsIEz8zofke0qzPAnrYSsP
         +gsw==
X-Gm-Message-State: AOUpUlFJ3duSlLhpWVhGmg8x/4S6gnndCYrLFJjWpLYqdmt+lzm2Rmvu
        ptooGoLMdBQ9FuAipIRlCjU=
X-Google-Smtp-Source: AAOMgpeRL+0mOIiO9JXKP+/Uu5+uIuhfywChLt7SrQvzVvFZAVBuoORtSaGiqbvx4erEncv6lh6ntg==
X-Received: by 2002:a0d:d48d:: with SMTP id w135-v6mr8581381ywd.185.1532965467622;
        Mon, 30 Jul 2018 08:44:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:4bfe])
        by smtp.gmail.com with ESMTPSA id w143-v6sm19139747yww.49.2018.07.30.08.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:44:26 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:44:24 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
Message-ID: <20180730154424.GG1206094@devbig004.ftw2.facebook.com>
References: <ca3da8b8-1bb5-c302-b190-fa6cebab58ca@I-love.SAKURA.ne.jp>
 <20180726113958.GE28386@dhcp22.suse.cz>
 <55c9da7f-e448-964a-5b50-47f89a24235b@i-love.sakura.ne.jp>
 <20180730093257.GG24267@dhcp22.suse.cz>
 <9158a23e-7793-7735-e35c-acd540ca59bf@i-love.sakura.ne.jp>
 <20180730144647.GX24267@dhcp22.suse.cz>
 <20180730145425.GE1206094@devbig004.ftw2.facebook.com>
 <0018ac3b-94ee-5f09-e4e0-df53d2cbc925@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0018ac3b-94ee-5f09-e4e0-df53d2cbc925@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 31, 2018 at 12:25:04AM +0900, Tetsuo Handa wrote:
> WQ_MEM_RECLAIM guarantees that "struct task_struct" is preallocated. But
> WQ_MEM_RECLAIM does not guarantee that the pending work is started as soon
> as an item was queued. Same rule applies to both WQ_MEM_RECLAIM workqueues 
> and !WQ_MEM_RECLAIM workqueues regarding when to start a pending work (i.e.
> when schedule_timeout_*() is called).
> 
> Is this correct?

WQ_MEM_RECLAIM guarantees that there's always gonna exist at least one
kworker running the workqueue.  But all per-cpu kworkers are subject
to concurrency limiting execution - ie. if there are any per-cpu
actively running on a cpu, no futher kworkers will be scheduled.

> >              We can add timeout mechanism to workqueue so that it
> > kicks off other kworkers if one of them is in running state for too
> > long, but idk, if there's an indefinite busy loop condition in kernel
> > threads, we really should get rid of them and hung task watchdog is
> > pretty effective at finding these cases (at least with preemption
> > disabled).
> 
> Currently the page allocator has a path which can loop forever with
> only cond_resched().

Yeah, workqueue can choke on things like that and kthread indefinitely
busy looping doesn't do anybody any good.

Thanks.

-- 
tejun
