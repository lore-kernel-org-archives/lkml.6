Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B43C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC7A20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgH3HA9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC7A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeILExc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:53:32 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42942 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeILExc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:53:32 -0400
Received: by mail-yb1-f196.google.com with SMTP id j8-v6so51498ybg.9;
        Tue, 11 Sep 2018 16:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0rCgQO6XgVZi1lpxhVm/fJTejrvktbRjuN4qfvXFmE8=;
        b=KgH3HA9uLhe3ncZ8+5SZsBNQ2wsOOVyiPczLdlZrTEXRPHf4MIo0MHmd/8r46F6l0h
         GALy4DIRIkt+Fo3aj/yXMK+Hz/ZhZeX41Ue1eW2cDPfOO56221tHQ+Gzcpv7/zbvz+zz
         BuKpEoKA401kJNliLsVNszgpTumHJ/1JkB+IvAmetq1MPAtFGRi5ji24daYVmMo9SVBt
         wpUzN4SDvNN3qSPh+nmJE3veuWOUDovR0L5k26EdJGIqCMf7w4s+hK6XYdwJHy9fBBXk
         BhRs9rftICDTIEC/QXO83TXBxURUgTCUCHfRhBJ0CjFy7aNN47XEysIHj42BLzE8e0Za
         WkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0rCgQO6XgVZi1lpxhVm/fJTejrvktbRjuN4qfvXFmE8=;
        b=PS1ct00cBLgOeY4hsbBWLrWVYFS46Pe36P8n+dpJG6svYWz/dow5t39Npc3Uzm2v4k
         fZDfEomCB4m74dJXMUeT0qik1Ravvm7VhthJ3c9J8N/twPJZ4K/20bYR0SZNQPk1FDvA
         boarg6tSKcL+gAopmF7nujfhBQu0xZ2tv60kNJc/yyogocyDlPdEwqOIqUEXeR2HQIOl
         sSxRIjTcVXWE0qHtUIMTDftB4ifH9yTOVjcamPR0KAOWsxod4GXSGDUjrTwJien6qAVw
         nvkKRu/9fbkURkzFnLYIDnrXjMM8JIrTEPN1zTLAGGVCIDCVZNg+uGvEosRxNxDWjPJc
         GLkg==
X-Gm-Message-State: APzg51CSQrzv5Oz9rh2cRo/r5OCR8GoJydYHAuaArAukw+ZQWF7tOgfj
        OxhGC3VvWe0SUjUcknYc31M=
X-Google-Smtp-Source: ANB0VdYyziE43hXL1LEY3TlIkx2/bqSd5fKAV8cK/S8yXApQlM+Gcz6CHcIR1CQpX9so6UDPMFC9gg==
X-Received: by 2002:a81:7852:: with SMTP id t79-v6mr13813666ywc.329.1536709912991;
        Tue, 11 Sep 2018 16:51:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6304])
        by smtp.gmail.com with ESMTPSA id z193-v6sm7705397ywd.90.2018.09.11.16.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 16:51:52 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:51:50 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] blkcg: remove additional reference to the css
Message-ID: <20180911235150.GD2966370@devbig004.ftw2.facebook.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
 <20180911184137.35897-10-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911184137.35897-10-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:41:34PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> The previous patch in this series removed carrying around a pointer to
> the css in blkg. However, the blkg association logic still relied on
> taking a reference on the css to ensure we wouldn't fail in getting a
> reference for the blkg.
> 
> Here the implicit dependency on the css is removed. The association
> continues to rely on the tryget logic walking up the blkg tree. This
> streamlines the three ways that association can happen: normal, swap,
> and writeback.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
