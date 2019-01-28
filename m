Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963A5C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5559E2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548716515;
	bh=ebqpyxFJCfFEC5OAjn/SpAmIwxFq2i7YUX3t8E+s3XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=apOsN5jdu305ShmqE91NjDwaYIJfi0km4jwQTaKcIIEgqPN7l5IUvl0GuSUjmek/y
	 bAOvDBqJr4GuQocqoX+5qYRe8iKUtsm6yglzp9h4bou3tbszrG6nhOcOz0ju+E2Jdn
	 7prBroEMzxlpyk2Rd04hkicH4BJxFFNEqcO0xL4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfA1XBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:01:53 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34390 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1XBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:01:53 -0500
Received: by mail-yb1-f193.google.com with SMTP id k9so6917882ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vxgoQPA6ZPYEYvlFa80nTtCjSTPua4RFULptDtxyoro=;
        b=ffnL71qRlAnZTtFGlt0tV8/oBIKgUbazgwFjcSNAP3j3TtaFNQ31yI4TV0qI1Cgsth
         cnjSWNDrhNzaSiRCAmKQnAp+p8r9ENst3w8mS9MyRIk47sNRKJpksXNZJTCSLBa+RvqC
         rMQisXqBkhPPlChjyExdnINQ69derhJCtmHt4t4Dtg0jGVcShfdxwuzmLwn1oT/0w95y
         bvfjq9tW/HVRSk3cOcPnInCl7hGYaE3pMqyctAySJ5ghakHJAK0RVt7gm5qjVIlTrncj
         sCd+4zaVmF7QdbhIrs/k7sBgZiDKTbn2EqncBLmI2EMZrHivMjZg6CNyUsdHb4mzpdiq
         tIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxgoQPA6ZPYEYvlFa80nTtCjSTPua4RFULptDtxyoro=;
        b=DtoV1GWZPr22dQjoAoWr1VRiWSdkjm7r6hKL3j/ZKN+zIpnKbI0TDji0myxjhgRMxs
         tAULYq+hUMYvJQNa8Cq8O/Cny1rciEdYkXEP/b2d7qlRLnB6MgI4laMCUa2jYuU4WL4o
         Ld72GdD4tS2MJ1ANTuLZeUGmHQUAL55V29c0b+G82nO70wA/Qv/9uBHIQm7+dyKpoJDs
         6ygRPjuwpDJGFGVnXSqVHHwcy8u7nV0gghhWRxvE0mk9mu+9P01xjGp4Kczg8jSRmSgW
         py5oB3RDgI0NFF9RdYw4gApIYZETzfRU1sIpkijNI6u0/MRepvSNHJ+CG8pnBto/bRig
         UzMA==
X-Gm-Message-State: AHQUAuYPPtdNvK96pDh3d4OubwJgh1O2mMg4MzwdR2Kx8E85ZSCiizsZ
        IjAYq12Ck1ZY1nC8R7MBk0g=
X-Google-Smtp-Source: AHgI3IbxsjXUbjB2JBT1RbvmsvTf2kh4q2fXkI9mcGDprsh/hY3lOBEzN8q5CUcUWyCHbmiqaTpvAg==
X-Received: by 2002:a25:bcc3:: with SMTP id l3mr1677649ybm.478.1548716512207;
        Mon, 28 Jan 2019 15:01:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:31a1])
        by smtp.gmail.com with ESMTPSA id m126sm14426774ywd.39.2019.01.28.15.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 15:01:51 -0800 (PST)
Date:   Mon, 28 Jan 2019 15:01:49 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: fix aggregation idle shut-off
Message-ID: <20190128230149.GW50184@devbig004.ftw2.facebook.com>
References: <20190116193501.1910-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116193501.1910-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 16, 2019 at 02:35:01PM -0500, Johannes Weiner wrote:
> +/**
> + * wq_worker_last_func - retrieve worker's last work function
> + *
> + * Determine the last function a worker executed. This is called from
> + * the scheduler to get a worker's last known identity.

Maybe it can describe better why this is safe in this use case and
not suitable as a generic interface but other than that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
