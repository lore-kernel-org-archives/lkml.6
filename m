Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58047C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FB321547
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="b4ZSXKT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FB321547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbeI1R7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:59:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39663 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbeI1R7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:59:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id c25-v6so6192713qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zRPAcBZ0jXExz0b9Z/2xy54NjiQ4uqpuPp/PL1Sdyig=;
        b=b4ZSXKT6F2jUh2N/0+0f6amJx8k2m1O5JtT77YQ7ndzKzALwp8nwiLjkht1KzsLmNJ
         thVrca3Y2SVtQ6zK0fKryDP/yTToKNa1ndHX3x4ISz8rSPsWchMUFd5AItMpLME3DQEn
         fGykCCt46WE37QDcIcdHs0GxU9GgVMolER9ZDP2qoue7Lj6m1mWRmofOBvBX0YqU/vp6
         r/6/K0QD1ZwGa+WGksCWNTvlsNCQpraLKEb4sE6ucvDN1v47A9OVmN+pkwDwxFmncPND
         0RhhWT9fQYUmSXXA7gxkNFyOcLioXqBI4r0Q8vh0UazsWo34vX6ukOA1LXQx/GhFQDYU
         cQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zRPAcBZ0jXExz0b9Z/2xy54NjiQ4uqpuPp/PL1Sdyig=;
        b=ghc6TG7+NGyvJohwsDzhOz0Ywa/ncmNu61Yj4SDdP8e5+NHXeZXofJIcYtx6JevfNH
         xi0NML4oBXsFpbNPB/a2QH8Yw/4oznWWWvChB76b+2N8nRH8ep4XO/VMGJ+cVhkyhzQW
         d5VkXgJ1cEyhNbBJ4xqiekPnE3UuJZ/R+gNzSYyh+MaSDim4gLPo/Q4WpqPg8rJepxEw
         XO5TfLMNUgSNBkbFHS30xfgnqqFP6C+AKBmm3a5kI2CZzmoVokt5tZpTBSfBrTIIz962
         25qfr7/SzmIYUu0I/6IIyIhtj/OGSOTr1o5tO4wSF4uPXMFPy9eBnmlbUau1Sqey5Zf1
         EQzA==
X-Gm-Message-State: ABuFfogDFF5cNaOeo7MZWV1gfH9LojdFlu38/8L0rxz/5f7x/f4b2t2a
        RP9tqL6MLoFoSlMNfLQ+2CcGWQ==
X-Google-Smtp-Source: ACcGV61tp02EO4UDQfPkGeza6oT1sCB5D/EO9RIUeXywL6mFfbBiTPTWHJ/v1z4qAMf1/gKsh9KtTg==
X-Received: by 2002:a0c:8748:: with SMTP id 8-v6mr11630332qvi.223.1538134549862;
        Fri, 28 Sep 2018 04:35:49 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i14-v6sm2991116qta.53.2018.09.28.04.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 04:35:48 -0700 (PDT)
Date:   Fri, 28 Sep 2018 07:35:48 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, gorcunov@openvz.org, mhocko@suse.com,
        aryabinin@virtuozzo.com, hannes@cmpxchg.org,
        penguin-kernel@I-love.SAKURA.ne.jp, shakeelb@google.com,
        jbacik@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix int overflow in callers of do_shrink_slab()
Message-ID: <20180928113546.sc7cztwsja4advli@destiny>
References: <153813407177.17544.14888305435570723973.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153813407177.17544.14888305435570723973.stgit@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 02:28:32PM +0300, Kirill Tkhai wrote:
> do_shrink_slab() returns unsigned long value, and
> the placing into int variable cuts high bytes off.
> Then we compare ret and 0xfffffffe (since SHRINK_EMPTY
> is converted to ret type).
> 
> Thus, big number of objects returned by do_shrink_slab()
> may be interpreted as SHRINK_EMPTY, if low bytes of
> their value are equal to 0xfffffffe. Fix that
> by declaration ret as unsigned long in these functions.
> 
> Reported-by: Cyrill Gorcunov <gorcunov@openvz.org>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
