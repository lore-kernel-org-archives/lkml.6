Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E7EC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769282087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="mGct0Tld";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bKWlwGvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfARQFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:05:25 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38685 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbfARQFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:05:25 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 63BC728E66;
        Fri, 18 Jan 2019 11:05:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 18 Jan 2019 11:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=X2L8VwOL2rRdX/MgdkVIYdvbbZf
        KTaZ1urvf7X9UIck=; b=mGct0TldXocejbq4U7G2CkQXoT4qPErrNA9nelh6haH
        4yCb04geQobpvIuQnglNH3DayyjS/FCNdanS47Tw20uP4dW2/SptYGK/vCvr3AHf
        l+8U6I+QA0QF0Ec9fPIJH0ZKVbDdmzNghM0K+mYBm2O3fnJS6+dpxo3/5m8/ZxdJ
        FOFeuZ5hRfaXlHIECi72o3VIw1oFdJctaYZSivAsOh0VGsrQ9y7yR5quL/4fgO91
        nATT9Wq+vvPivBJ5fjgbwM5Lc+zKICHK73U8Z6mkHfsa/pXHNXaYL2VDqQbvAWBi
        p+8MQu0JB7wGsImOz+ZwgDFJvHGq64VA9opo6Rvi3vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=X2L8Vw
        OL2rRdX/MgdkVIYdvbbZfKTaZ1urvf7X9UIck=; b=bKWlwGvlhPmd24VSsQWEHt
        2DHTcN57JKo+Ocl/dIogv+8rr2xaDqbastgHmUY6yIX+KAttVF6duiKYTjd2E4np
        AP1prN3C8zALOshfOKlZpBGq739P1dNr22qfvhw7HDIxxnI6cxQDoSjYFpJ3Z7Fz
        qJy2pZbDarCU6ax73pWs1pxKoc28khaqfgxE173wi+1veEzdiT6X6Q75s4ofaFxT
        cmK3TxFh9WmZ2qYWa6nBq12iJGelJXPGYFxAaCoYOiUvjHHwxT3ayE6u3ZlO+atG
        DgbZsiyeZ92JTzyux495QQ7WyJ3U1I6yB5iSbyQZpuld/woTa05tvJoJAJ/pYcaQ
        ==
X-ME-Sender: <xms:Q_lBXOwIneczqTeS7LkgORKYxJQT33k4LxCL2ZOqpEjtFxBOxKQGVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrhedtgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttd
    dmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekle
    druddtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Q_lBXDMubZmDmA0Le3t4Ml8G0pePBIakJgM7c3_dsgx_66I_k_S3YQ>
    <xmx:Q_lBXL7FO5KTPXRVi7SO_2JHH657b89uaApcoRxxhMo4x3kzaSU2mg>
    <xmx:Q_lBXEkntf3zeuFxYA9jjRRzA7S_NASFyWALICmYLuYAleb5LT5BuA>
    <xmx:RPlBXIMgEnjIeZXTGeTQ9UdyM9XSOQaQEDDyZ6IUsFWLhXo8kZn49w>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 46A52E40FF;
        Fri, 18 Jan 2019 11:05:22 -0500 (EST)
Date:   Fri, 18 Jan 2019 17:05:20 +0100
From:   Greg KH <greg@kroah.com>
To:     Alakesh Haloi <alakeshh@amazon.com>
Cc:     stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: Re: [PATCH] sched/fair: Fix bandwidth timer clock drift condition
Message-ID: <20190118160520.GD11503@kroah.com>
References: <20190116195202.GA89178@dev-dsk-alakeshh-2c-f8a3e6e0.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116195202.GA89178@dev-dsk-alakeshh-2c-f8a3e6e0.us-west-2.amazon.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 07:52:08PM +0000, Alakesh Haloi wrote:
> [ Upstream commit 512ac999d2755d2b7109e996a76b6fb8b888631d ]
> 
> I noticed that cgroup task groups constantly get throttled even
> if they have low CPU usage, this causes some jitters on the response
> time to some of our business containers when enabling CPU quotas.
> 
> It's very simple to reproduce:
> 
>   mkdir /sys/fs/cgroup/cpu/test
>   cd /sys/fs/cgroup/cpu/test
>   echo 100000 > cpu.cfs_quota_us
>   echo $$ > tasks
> 
> then repeat:
> 
>   cat cpu.stat | grep nr_throttled  # nr_throttled will increase steadily
> 
> After some analysis, we found that cfs_rq::runtime_remaining will
> be cleared by expire_cfs_rq_runtime() due to two equal but stale
> "cfs_{b|q}->runtime_expires" after period timer is re-armed.
> 
> The current condition to judge clock drift in expire_cfs_rq_runtime()
> is wrong, the two runtime_expires are actually the same when clock
> drift happens, so this condtion can never hit. The orginal design was
> correctly done by this commit:
> 
>   a9cf55b28610 ("sched: Expire invalid runtime")
> 
> ... but was changed to be the current implementation due to its locking bug.
> 
> This patch introduces another way, it adds a new field in both structures
> cfs_rq and cfs_bandwidth to record the expiration update sequence, and
> uses them to figure out if clock drift happens (true if they are equal).
> 
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [alakeshh: backport: Fixed merge conflicts:
>  - sched.h: Fix the indentation and order in which the variables are
>    declared to match with coding style of the existing code in 4.14
>    Struct members of same type were declared in separate lines in
>    upstream patch which has been changed back to having multiple
>    members of same type in the same line.
>    e.g. int a; int b; ->  int a, b; ]

Now queued up, thanks!

greg k-h
