Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA09C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564082083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="xFPHzLgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564082083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeHaT60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:58:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39523 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbeHaT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:58:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id b19-v6so1689556qkc.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UqaA9H8RxsZ7IIFSLpndjVyK5I3+eZWdGd5MwXiwCqQ=;
        b=xFPHzLgC4sh+KhS4ZP9khaBXROOYwkCxcppvRlSRnZwE/Fk4jSXgWzsTkC1d/QwWoL
         ULECdegUNk6v49JIUEau+Lgmytsx96g++icAS0OrqGmpsa8GbFHVqRqauGJIboC9JH9I
         G62OsSkIcfQudGL7RpUYOgeSlbottNanch3F3HDOULvSgVZjx6SXtOAsgSdhOdjsK9qK
         q416PyTf4iul1hZll4jhEmnHqyQ5GkCD5cjNfZRrB9Z0N+Dle4LyBdvXWQXeF703PWmU
         B+umTNjO+2ampF1Y4tJt1LWuxgjKFeWH/ZOLy15b9BpAsyxoVkBKzCQUeyk/aSYffZ/A
         hCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UqaA9H8RxsZ7IIFSLpndjVyK5I3+eZWdGd5MwXiwCqQ=;
        b=tdvMDrnjmQXcDgErcyo/eU+I2SNGsUk9rPrhxkeAKgRlk8HeYuNAW5+SduP0bdSc4M
         kykVSyPXNUtaNxncr1gGynbg+zJhq9gLBKgDD1KpdquTSqkHy5zS5BVKTq2krRpvF5zl
         1cRILqqGzwMan5CaQZwnQBBAmZGlq+8CFlnO8/VVdg6bYsdUPkQRP0Dho1V9lL9QEVyA
         FHqmEaisKDd0Yz55yL0iezb7hORzpkuwFw5bIxVGKBx5VrK3Sf6gtEcLDl02yIXLdf05
         IzjkC9m1nrB+8pFt9hwI5av7xccFqDOw6Czjkz9PxGNAoe69+iugwTIzhUyo6y6islOm
         ARYA==
X-Gm-Message-State: APzg51Ap//pIzoU8SQTvE488D8WoMoed8or+RyUJiFexcrtdI63q29FX
        5jlWdQ4DhgEqNB/TO90LgtxVsw==
X-Google-Smtp-Source: ANB0VdZWq+5TxuwWkuCfhugDL7+n7H9jLvY3ES+/Kx6GLVxAl57yzMmcxIBOVfo4J6lvBIDvIjeaxg==
X-Received: by 2002:ae9:eb58:: with SMTP id b85-v6mr16252484qkg.110.1535730619226;
        Fri, 31 Aug 2018 08:50:19 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l87-v6sm6793765qki.82.2018.08.31.08.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:50:18 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:50:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] blkcg: rename blkg_try_get to blkg_tryget
Message-ID: <20180831155016.2u5erpni5omhcncr@destiny>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-15-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-15-dennisszhou@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:55PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> blkg reference counting now uses percpu_ref rather than atomic_t. Let's
> make this consistent with css_tryget. This renames blkg_try_get to
> blkg_tryget and now returns a bool rather than the blkg or NULL.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
