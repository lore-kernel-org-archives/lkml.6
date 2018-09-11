Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D624C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285A72086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pk9r3kZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285A72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeIKUSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:18:08 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:43382 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKUSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:18:08 -0400
Received: by mail-yb1-f169.google.com with SMTP id k5-v6so9457124ybo.10;
        Tue, 11 Sep 2018 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YzMnzUIfQpQFvFW/ZeM8wlK+eBtanAQXNZTavhCdMOo=;
        b=pk9r3kZ962muNQ6KFD4GVEEF+UPKwzfBI6Bv9EOQBuMg8QoidQblX8UGk835Z4Lq6x
         NOYQ0UugQyWGidkAmNPC5kUYOoSvWeh/oknCdqKK5a+X9bbEPWeLEILiPkeUxBcSLPuo
         s6/1bweHVEoooM4Rh43w6HhiUAuVyG6823w3Vab9Wl5UPLxj1gQscHeX0ZkFeXH9JUMN
         5nxv6HECUj1ZlDlkP4DdE6/hIdKK+1qvYzgk0OUMILhCM6RNj/JrlborYOB+K/KngWdU
         spu+c3qWNJF+RyTuFWFdDZDiseM6MfCqVWnJqe20NYXKZsVWXe/fFiT/upvSRJk3rWP/
         s2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YzMnzUIfQpQFvFW/ZeM8wlK+eBtanAQXNZTavhCdMOo=;
        b=jkcHmu8TmrsJdU7B+WmD61gYKFxzAVjgyOVeqRovS3wvTCHJ+fK7coe0MmlxCgrBU+
         ctSHOqY8xp2nWPJLnJcFKvGw32t3HRZlz+DHV0AEDy8aKmg6O0ozbP3CDDp0ENXJQpcz
         YjDCeJRer4hVAy/3U70hxFWPr0Bc/kIz6QTYWQvXQQEFiQb+Oz2es2DpjO2GVAj39i4K
         jQ83IIoGApRl1MELIIsgCNaT6preeDbE+A9rbdGoTidA/vt51oXc8zHUmbx0SAgw7H1l
         T5A+EX1FWGVCIdizS/I6pNsDT04E7cBBgx1Q1RaHyqYj0jte6ACjUUMgN2ZePQDDx86b
         0A8A==
X-Gm-Message-State: APzg51ADxcCGG+e4UWuoIaUCWSJEynjILWgpkz64BUHYf4HsS2X3a1kb
        q4zF5j4DFOhsTbMIcUZU+Yk=
X-Google-Smtp-Source: ANB0VdZexa3itYsjCf/Qj/S6RloVNJcb4MzCwD871u/URQPUWf8mYOdqdEaJx06X9nKS0r8vqHhOBA==
X-Received: by 2002:a25:ab01:: with SMTP id u1-v6mr13022226ybi.273.1536679102012;
        Tue, 11 Sep 2018 08:18:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6304])
        by smtp.gmail.com with ESMTPSA id b6-v6sm8089906ywb.78.2018.09.11.08.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 08:18:20 -0700 (PDT)
Date:   Tue, 11 Sep 2018 08:18:19 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 08/16] sched/core: uclamp: propagate parent clamps
Message-ID: <20180911151819.GH1100574@devbig004.ftw2.facebook.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-9-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-9-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Patrick.

Can we first concentrate on getting in the non-cgroup part first?  The
feature has to make sense without cgroup too and I think it'd be a lot
easier to discuss cgroup details once the scheduler core side is
settled.

Thanks.

-- 
tejun
