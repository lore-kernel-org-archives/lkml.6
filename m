Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B8F160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0306A208A2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="JUWDBi++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0306A208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeG3RNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:13:13 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38532 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeG3RNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:13:13 -0400
Received: by mail-qt0-f193.google.com with SMTP id y19-v6so12529188qto.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iehqudg7CKqI1RcAVqsYmuSRAZls32znE68LmEY9744=;
        b=JUWDBi++8tdTDhWMmCZNk+2ryfskvCC2KHCWHh2YOifEyrUUNGbnLKhEFH/K8a/FXV
         IlN71yO9e84YO9sqCOLMC2ndIDrvwUIWDSO8/bbOE56D7ppMnzwWVwYwUfWpGw2xwtKn
         bvKp5btEUMa4iSzczGRBf6Z7h+1v5Trxy6V7g+t4lYXMp9XUe7Lu1KtROskDJVX9kAiR
         opdhgldh01iCHrN/DX65/ZD8seeZWnRs9VNOO9Vjt1dMbW6a8MG5bcGGdvai7KVOIrsN
         PnDOYyzTYi2xxPrZ/rBHkkN5tL+fWM/O7tzcP15wxcuXMNTSpPsrF0D4In6dAGl4lpah
         y7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iehqudg7CKqI1RcAVqsYmuSRAZls32znE68LmEY9744=;
        b=C+ccM5MoUL0ZLQeynrKS/hfe5Y8fXYA0wIy954cXeUa4ynAye7xuklMjU/oIrsNcnr
         RKpXo8AmdrH+75ZWmsZOp/9ErASBN6Y0N3CAObbiHJFDmnkuPKraw4fi42o3yI6zwiN+
         69e5iSn70gRzSxCbDGNThFwn/Q3OgtBQt6mpjO1SjMUo4XVUXpKZ7SIvhHQOfZqHqFOB
         g1Uzkcl7x8xvNlmf9myJKW3jfDRY2WfwAuRB/MCLdENRJSzFkWcOz4+tPoEfyWdGsZZQ
         Z6dp3XIKVzuZoGasSI0etGdBZH/FNGwLhAlU0mgXD0Sw4SSosdi7UEidjokAWM7Z/e+v
         giVA==
X-Gm-Message-State: AOUpUlFakfz9vnv8L4lkI6WNjzLZ6oophr9qU5mkwP+i9wa324k8Isf+
        959sqVe2q7ps15r7Nv3HNtDkpw==
X-Google-Smtp-Source: AAOMgpex0VengVj8vevolBpiq27LQJqlV87R5ZfrAkjWgcd39xHXihfmvrEZTzC8mnfIUWkKf3iDFA==
X-Received: by 2002:ac8:34b2:: with SMTP id w47-v6mr16884784qtb.172.1532965061102;
        Mon, 30 Jul 2018 08:37:41 -0700 (PDT)
Received: from localhost (pool-96-246-38-36.nycmny.fios.verizon.net. [96.246.38.36])
        by smtp.gmail.com with ESMTPSA id s31-v6sm4555811qtg.19.2018.07.30.08.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 08:37:40 -0700 (PDT)
Date:   Mon, 30 Jul 2018 11:40:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180730154035.GC4567@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180727220123.GB18879@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727220123.GB18879@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 12:01:23AM +0200, Pavel Machek wrote:
> > 		How do you use this feature?
> > 
> > A kernel with CONFIG_PSI=y will create a /proc/pressure directory with
> > 3 files: cpu, memory, and io. If using cgroup2, cgroups will also
> 
> Could we get the config named CONFIG_PRESSURE to match /proc/pressure?
> "PSI" is little too terse...

I'd rather have the internal config symbol match the naming scheme in
the code, where psi is a shorter, unique token as copmared to e.g.
pressure, press, prsr, etc.

The prompt text that the user primarily sees spells out "Pressure", so
I don't think this is confusing.
