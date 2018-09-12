Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB29C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966B720833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsNrjgqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966B720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeILU6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:58:32 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46721 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeILU6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:58:32 -0400
Received: by mail-yb1-f194.google.com with SMTP id y20-v6so1799764ybi.13;
        Wed, 12 Sep 2018 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yI51Z9UB0cP6kOmWw0BDYiaUUdJ1OPStl/j3dR5AFw0=;
        b=LsNrjgqcDE+b2XDAklwUb6byaXU0Va6dHPDQe9iMsxcnRnm6kPUEXiyXq2QMdfVr1Z
         y9/hj7G1P4VgUyvkhc66u5Z7oqGwHP3SqfwY970Y6FamVZFJ+jWRBVCl5C/OWTl16EID
         ihDlrvY24kJIwV+RSegNEU+u8cdn2ggPKIGjcB7ckbkQbYMvJZ1jC67tLQqUw6ZaEu3j
         MVqkDN4fARzVBfazzSrCgl5e1QxpO1qeJtZ30d+j9SoisqCv/VYt347tTB2Y7xndvSFA
         I1NUstpd74kbZY2BNA+jQM2X1tCP40ZnCrCDMxsFqr8q0nbOEkzu/OLP7JKyB+ViDXKT
         Enkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yI51Z9UB0cP6kOmWw0BDYiaUUdJ1OPStl/j3dR5AFw0=;
        b=bVWvjE0gpuPh0e/02UYaWqOlTYICCeu9SchdxsZ0LtTidlD+7Gxa6R/P7S+j2X/we0
         JLaIQuzQA8fM+DYuQwKmfBHGxpq+0pFAlbYUVIcgcDUaC6iGHc2qUywu7RSYU6yY2tbR
         Bav3SR1Qkzd+AQVmMPc9nfhdjslC9FFS68Nr4tH9XQIQhlMdE1MnxKrIUW3CLruaA4Ko
         VYEnGnea+x4Es29zpM6st/PG2gWW0hlY+u1V4s//YyWkmaBOaf/ECCu6WB706mqKJdGI
         UDd6Bukip2ozDx975HGE5Gv0CPEXZoenr3JMaMeSQdqETus7yqdwqEF+SMWDrXuxL6i8
         QKhg==
X-Gm-Message-State: APzg51C0Hhgv+JCOXXXruJNIDPiAB78vhKjTIFeRqWyAYkmZwLEJ7edY
        +LuSG2UavPaGRbHKdd8Q8Kw=
X-Google-Smtp-Source: ANB0VdajzRuKsANPU/VH41Y17fW+R+FaKW7985zL4xM0BTq4lbOhJJQQdoATNX3xRN/I4IGQua6Ufw==
X-Received: by 2002:a25:5205:: with SMTP id g5-v6mr1270056ybb.238.1536767604617;
        Wed, 12 Sep 2018 08:53:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6304])
        by smtp.gmail.com with ESMTPSA id r3-v6sm991294ywr.80.2018.09.12.08.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 08:53:23 -0700 (PDT)
Date:   Wed, 12 Sep 2018 08:53:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180912155321.GE2966370@devbig004.ftw2.facebook.com>
References: <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
 <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
 <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
 <20180911163443.GD10082@ming.t460p>
 <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
 <20180912015247.GA12475@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912015247.GA12475@ming.t460p>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Sep 12, 2018 at 09:52:48AM +0800, Ming Lei wrote:
> > If you killed and waited until kill finished, you should be able to
> > re-init.  Is it that you want to kill but abort killing in some cases?
> 
> Yes, it can be re-init, just with the warning of WARN_ON_ONCE(!percpu_ref_is_zero(ref)).

We can add another interface but it can't be re _init_.

> > How do you then handle the race against release?  Can you please
> 
> The .release is only called at atomic mode, and once we switch to
> percpu mode, .release can't be called at all. Or I may not follow you,
> could you explain a bit the race with release?

Yeah but what guards ->release() starting to run and then the ref
being switched to percpu mode?  Or maybe that doesn't matter?

> > describe the exact usage you have on mind?
> 
> Let me explain the use case:
> 
> 1) nvme timeout comes
> 
> 2) all pending requests are canceled, but won't be completed because
> they have to be retried after the controller is recovered
> 
> 3) meantime, the queue has to be frozen for avoiding new request, so
> the refcount is killed via percpu_ref_kill().
> 
> 4) after the queue is recovered(or the controller is reset successfully), it
> isn't necessary to wait until the refcount drops zero, since it is fine to
> reinit it by clearing DEAD and switching back to percpu mode from atomic mode.
> And waiting for the refcount dropping to zero in the reset handler may trigger
> IO hang if IO timeout happens again during reset.

Does the recovery need the in-flight commands actually drained or does
it just need to block new issues for a while.  If latter, why is
percpu_ref even being used?

> So what I am trying to propose is the following usage:
> 
> 1) percpu_ref_kill() on .q_usage_counter before recovering the controller for
> preventing new requests from entering queue

The way you're describing it, the above part is no different from
having a global bool which gates new issues.

> 2) controller is recovered
> 
> 3) percpu_ref_reinit() on .q_usage_counter, and do not wait for
> .q_usage_counter dropping to zero, then we needn't to wait in NVMe reset
> handler which can be thought as single thread, and avoid IO hang when
> new timeout is triggered during the waiting.

This sounds possibly confused to me.  Can you please explain how the
recovery may hang if you wait for the ref to drain?

Thanks.

-- 
tejun
