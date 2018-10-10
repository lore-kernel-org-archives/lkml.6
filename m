Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122A32086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeGqpC79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122A32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeJJW7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:59:49 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40806 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJJW7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:59:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id l79-v6so2339830ywc.7;
        Wed, 10 Oct 2018 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/hUymq0CBb6jTlNVcfDNUEEgUA4I0Ld2rJBBkWVbRqc=;
        b=TeGqpC79pWORz5dO6p8cu4qMYFLe1820OrRixRzHK5pIRne1WuQY9F5KbiZTBhfG1w
         Sit/u29KXK1mIg+/gw5lm3oUcRnk3VGKRXGHVMD13Q+M0nTwLtCLL4+/n9VtZljynKbw
         /2FnSiuswf8P3elz3njRlUjRzSYNVpJCQ7DAWI16Z/gzMx9sJmMG+0LNGaHKK10krtgl
         4hpuEzOquw7BeP5lgo5qvUKJpsDB/8ygQ+V2DgddCfO4WqwyD47HLvIX0EmdKVkBS9PX
         Tctcx/hvRTGs8T0YNFdGmYQyeymSXmaMnoJ9R/zcysmp0/WMUD+MgFnKZ9E9IlQMk+78
         9YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/hUymq0CBb6jTlNVcfDNUEEgUA4I0Ld2rJBBkWVbRqc=;
        b=jG46pN/2Tf8V+JLLgUo8MA5M/u1UNqHfdSnQgz649bz/UnrQmr1bzFmOTF3mcKbMF3
         TUTsR4p5YUCE1mVqPau2c5aiFVSrzYmG9vev6fo7m/jybkg18JyMX5AtRdhQuz08gVRq
         KX+E2AXvNRpzzsp0JIc59GAaG2r/v4rm19Bx+L+3Zh46sQ3XP+l01q904zPO3o+wdgfT
         1TYw5HckNemBipEgYFqR4Zjn4jdzygSlrXI8u82sG0iE8+umylKNNQF8bVUZOXmffa/C
         6vGWuVeOkQYK1rxRXrN2ihkIy9+MKKwRFbV4OMSAMrAc8Oc7S81XKy9WcLVEluK7gYev
         7iBQ==
X-Gm-Message-State: ABuFfoge+Pbas+un5sM3ZzeHXb909XLMXBwFYIE1v6wpi9OkwjqBUf2S
        8Ik0M3K+HVJp34UJtQ6MoSc=
X-Google-Smtp-Source: ACcGV61JWqH3Y3j1aBoZBqoxdBdH7odhhx0p65Y7YQQ4M1e4IYpx4YsL53/hXYOU7K5Q3ZL0yQj0HA==
X-Received: by 2002:a0d:f144:: with SMTP id a65-v6mr1103828ywf.330.1539185825342;
        Wed, 10 Oct 2018 08:37:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:78ae])
        by smtp.gmail.com with ESMTPSA id g14-v6sm8927976ywk.94.2018.10.10.08.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 08:37:04 -0700 (PDT)
Date:   Wed, 10 Oct 2018 08:37:02 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
Subject: Re: [workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Message-ID: <20181010153702.GN270328@devbig004.ftw2.facebook.com>
References: <20181005183239.8790.28631.stgit@localhost.localdomain>
 <20181005183406.8790.70621.stgit@localhost.localdomain>
 <20181010153011.GM270328@devbig004.ftw2.facebook.com>
 <36fd7d36-ea79-bd69-4576-06ab4635f0d3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36fd7d36-ea79-bd69-4576-06ab4635f0d3@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 10, 2018 at 08:34:06AM -0700, Alexander Duyck wrote:
> >Maybe we wanna round-robin within the node?
> 
> I had thought about it. It adds extra complexity to do it and for
> unbound work queues it doesn't really add anything since it gets
> converted back into a node anyway.

Yeap, it only makes sense for per-cpu workqueues.

> If you wanted I could look at adding extra logic that would do the
> round-robin for non-unbound workqueues. I just wasn't sure if it was
> worth the effort since the current users are all unbound workqueues.

It doesn't have to be complex, just a per-node unsynchronized int
which gets incremented and %'s would work fine.  Alternatively, we can
trigger WARN_ON_ONCE() if the function is used on a per-cpu workqueue.

Thanks.

-- 
tejun
