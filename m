Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A4BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE49D2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="XK6G7TxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE49D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407124AbeHATO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:14:59 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39348 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390368AbeHATO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:14:58 -0400
Received: by mail-qt0-f195.google.com with SMTP id q12-v6so20750806qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LdYOrKffseY9Ibr4wJLPfivG16efjzPdtcBxMjZGAcs=;
        b=XK6G7TxBRwuw1X/7Bx22v6NNxJte6ntY943o337w4gINLKfgCRy7iwuR0AcsjG35wW
         OyX9xq6433Fks5YjFE/7icaLp9iWvNkDtLKOq9ojiYaLo+MHoNd2Hg+5beXt9TXKQ5ki
         rDNw0inbUmjSnV+uM5Po8UFvF/AabMWTU2UB3kXoIloCBGZY3Ltmx5akXITAoMRQpv/3
         xRscZFRwJQX8QDvy0RFoVJ8lNqttnAqrrkxYo+/6qtuAd8pxyi3n5h35cLER46dFXZxw
         Erit6bBGkndb0ZxAKwDeMYkQpi1Z7omDOvUOFhgs/5drr0+wf0cJOf1ayWUVhZIeJ14X
         5JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LdYOrKffseY9Ibr4wJLPfivG16efjzPdtcBxMjZGAcs=;
        b=pj849IOAY31C+Mn5DPTCMt+m/Xb0AV4gRb72dEQihCKgyAY6VXsNXAhPflHUgjnB8s
         on3rqgz6VIF7opp2c0NWAi58QTZ7i2F1S6hH+mG4Yq8tEEOj+rV1HVdXSfjVGs1NK1vM
         CDmgo7bZHKbAOGQpMMgXrADMDiya3YY9gsf9qScKfH5ZpuNLXttoye5wYkQHkQTTqMX7
         zgVH5x3G7PqNZVR16qBzrx+eoe+Mb01s2mZN2hSoWMIIkbiOHJcviFFw15gsPoV0J/uN
         Nina5cAQYFZL1+cX5OklMbcCjrGfFFGXTubgYpR2zkz3PKe10HNLZ5CEYKIeK33HLfkp
         S94A==
X-Gm-Message-State: AOUpUlHXZq2bVk+WEsl/BrnhuH0Z57E7XhLDO0wjHI3pUGLYPxQ7DzPG
        QMF7Xbs2IuybDFQYcTzO/BcWaA==
X-Google-Smtp-Source: AAOMgpd56V4TYsHU9GzckfOEoKyHA9r+0WQDjTFHIjuPLPhPwQmyNP8zPhFGNI1AJbkeSRjqGg564Q==
X-Received: by 2002:a0c:c90d:: with SMTP id r13-v6mr23953155qvj.45.1533144494632;
        Wed, 01 Aug 2018 10:28:14 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id y8-v6sm13802635qta.42.2018.08.01.10.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:28:13 -0700 (PDT)
Date:   Wed, 1 Aug 2018 13:31:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] mm: introduce mem_cgroup_put() helper
Message-ID: <20180801173108.GA11386@cmpxchg.org>
References: <20180730180100.25079-1-guro@fb.com>
 <20180730180100.25079-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730180100.25079-2-guro@fb.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:00:58AM -0700, Roman Gushchin wrote:
> Introduce the mem_cgroup_put() helper, which helps to eliminate guarding
> memcg css release with "#ifdef CONFIG_MEMCG" in multiple places.
> 
> Link: http://lkml.kernel.org/r/20180623000600.5818-2-guro@fb.com
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
