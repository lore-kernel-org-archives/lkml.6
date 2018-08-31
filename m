Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AA3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F098D2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="z122gRW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F098D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeHaTy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:54:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41451 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbeHaTy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:54:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id h138-v6so1678272qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GjuXbKG3zC5ZeoI1mrigFO88zTTATgokvREWmhDfYH0=;
        b=z122gRW94GqDvKrJxmwDyv5Yusp1xa5fclzTmIQdDt+xlqlJVnwo86dn+SAUJ8M1uf
         mriz637qSZ02mntaT7CCylWykPAI0bp58M164P9MjYJzeiIE1b13EfaoKF7Evfq3Nema
         x4+eFJJG7GrJMAakUVaARQmj3v8QPCR9vjfu9L2Wf6MnTgBjYVleAW3XiHa0xOOMFAo/
         lZlNDsQWPtcmVmKRBQGMDb3VQ5lUrGzIndyyYDuBTwKcuXy1QWF4J/oogPKYntHbdRu3
         7X7lVy4tkzPJiKyov5qVX3bxwz9IJUc6o6G33V+5sO+W+zYs4Cf4v9OZ6RepEjOrs0o/
         mJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GjuXbKG3zC5ZeoI1mrigFO88zTTATgokvREWmhDfYH0=;
        b=Stfv/THzqjX3yE9sBMVClRMFu2+lKHuunHqj2nuPIhVAa9jJlLFEMhiq6ulaHd+3Qg
         dnjNdNGlye2t73QeFbYK1J8SvFbH5PImPWkB8DEQ26zip3zc2AWgTuE6iNTO5nAIg+cR
         vlAoBF/AD9aPZa1sND/VrzBzjTZy5+g4hp8F/yQ+ULtB4oiIrNwuBYkpJPEE94V6aICb
         cgk74/yDEXS2EIThqDa+B6fGydZ8m6NhHmJCKaGOpTMgw1JoIhor3OfIKPI5UyBQr/hB
         UySxa1HAuL4SZ56USvK3wx2X7hcGWzX8FUeJsdUF+A/sejG7uZISEYYp90m8vlga6pnC
         bLcg==
X-Gm-Message-State: APzg51Bs5VQyDet6oYI5kBfV+PvzkKI6QyyZeROBN0TpEJZZyaCl0Htg
        ocIlt6UbnG19XKJuqaNT5BZQKg==
X-Google-Smtp-Source: ANB0VdYpRO86f8YoWVOLXiopjhwyN/mwAvU4eDiWdXZnsZv2xjkxcf6dcYeNf7dcvb0YKz8XRfRy4g==
X-Received: by 2002:a37:c5d4:: with SMTP id k81-v6mr15639490qkl.66.1535730383421;
        Fri, 31 Aug 2018 08:46:23 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g14-v6sm7247985qtc.66.2018.08.31.08.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:46:22 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:46:21 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] blkcg: remove bio->bi_css and instead use
 bio->bi_blkg
Message-ID: <20180831154620.ivdpptlo7o6ipebu@destiny>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-11-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-11-dennisszhou@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:51PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Prior patches ensured that all bios are now associated with some blkg.
> This now makes bio->bi_css unnecessary as blkg maintains a reference to
> the blkcg already.
> 
> This patch removes the field bi_css and transfers corresponding uses to
> access via bi_blkg.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
