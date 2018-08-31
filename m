Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B25C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F15120658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWBhN5TA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F15120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeIADzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:55:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46803 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:55:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so6162288pfn.13;
        Fri, 31 Aug 2018 16:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zvFghNppYyZBqHCLnWMPO4VCWSZqUB1Oh/HejIwRyhg=;
        b=QWBhN5TAIxBr0QMhHHAeehcxrNYbYXO2jLGzf53oCTvWwQi+uW2LyMELp/GphZIbf+
         newm4DkacPYykCLTo0E5Irx+ADWlHewboIBPvHv9XgUEYbeMEEFq4f0CQXGhoSunSwGT
         EP8l3ab3oUfBP2d1EHCDPGsZn43FwvJUEUW9wlP7nxVUgfxF/OlNzL6LRSzBDPpHCZmt
         q46osqkPGTRTuMOdEj7Z8mJ+rP4VC2PVk58p8TSOBIkECBIv9IXJGBlJ+C+b/YcLqsb/
         MV7bvKJhS8uGZY/oBkSKsWxZsG5lVIOKav9rL8h6YhdoyaOfqIXOXl/JiOXNCrhXA/NJ
         DnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zvFghNppYyZBqHCLnWMPO4VCWSZqUB1Oh/HejIwRyhg=;
        b=GOAdUu391I6Vi2aVNWZo2g5rneEOeEhj9wZhnZJAWSDGR4dHlHT6BUPZS7iLBo8LC6
         aujj9ARwj8/W/6EwTmu/3LgdjmDk9MOBADrfKQCQLqu+h3KPvzwYXKkJ3vW180QxPtRZ
         a0K4Aw2FLTYgzdnkO5z68CpAqlysX6z+h9u6F4hoEuYR4DKktJodFYYQ+ESL1A/oxKnV
         muvgBzpXF3F9nVl/E4HvExh5K5pwMDQM8XS4sPVNhcuNgmE914xD9wrp0nzmyT76JFcS
         /rI7VkpsuiIEgb4xkaba64DdO7ZtBUjupYaREfvxVWs3T0uNkpRnSnJ+stq3cuiwwlur
         lblg==
X-Gm-Message-State: APzg51Dz1eSmGXxvJOdWVGFzPv5SVPbJ1jxpolhqSQgOKs+oxbIW6OcA
        iezSrIuJCR3SDRkNc69ygFI=
X-Google-Smtp-Source: ANB0VdYZoNTxpAtv1TwQYguTbRL1ZPU5S1+4MeBjmofjZVQ0zCDvbySCHNmZuHanIpI6jU1jLrVSog==
X-Received: by 2002:a63:ff54:: with SMTP id s20-v6mr16660985pgk.241.1535759118983;
        Fri, 31 Aug 2018 16:45:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id 64-v6sm22003971pfi.89.2018.08.31.16.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:45:18 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:45:14 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] blkcg: consolidate bio_issue_init and blkg
 association
Message-ID: <20180831234514.GE1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-8-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-8-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:48PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> This removes the now duplicate association logic in blk-throttle and
> blk-iolatency. bio_issue_init is moved into blkcg_bio_issue_check and
> into the bio clone variants to allow for the future addition of a
> latency moving average for IOs.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

I don't have strong feelings about where the removal goes, so please
feel free to reorganize patches per Josef's suggestion.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
