Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF95DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C61924E2F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYX166Fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C61924E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeGBVOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:14:02 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:45593 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753087AbeGBVOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:14:00 -0400
Received: by mail-yb0-f195.google.com with SMTP id h127-v6so5609261ybg.12;
        Mon, 02 Jul 2018 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7/6lZy8CsUNIIIhuX98vCeKoNgj0huEvr8rgBZq2pwg=;
        b=eYX166FpSypCS3ugz2utPN7fdWlg1PAlNN0+g15O0RQeq8a3B/+RTP2iVVvBzxkCoJ
         EfipudezyG/6nXgcT3tOg6kh1MaU8ZSHqrCKGI7wwYJ+cCTJ+lRKIip/sLVGLhZ9Ir7D
         2HseFKxlRMFMX1tpO6TPX9Zq3tfGXkNgUGU+F34G90x4EpHK/V7WccT6TE5xrMCapPPt
         hoNKh2MG45jzGbaPGm714agavzpiSU86xk2+zcI8Cyl/C6Sk0Ht2/OrNUfePxYVdnsBJ
         5A8R0N9NktkYhRUnRhVXehgbJs3lgGMAJ+8BXpPB9ZZDRZJRCfOjP8bVpSGSDOdYeqr8
         syuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7/6lZy8CsUNIIIhuX98vCeKoNgj0huEvr8rgBZq2pwg=;
        b=kTTFhh0tS7g7anQP8w4nBV46koewWMQnqNTPyLmRH4/bSFFrqz4B1qyVD/mPsCmdBh
         b4AyEO7z8Hfpu4iGgIeTxaroQMCCTQL7o7tFijr04hb6Qo2bTUelb0F5w2v53AJeKytv
         M2EaOC/91u2L8IH8zJIXNLzaqImdTGM3ItTKfxopRVKwQiXyEPKK+l9vUKHExCIxtusJ
         eOjGJ2aLc9bfHggZUm0awxyasTletpNCKlkvdo/YrxC+7BbQ0GkGEGUs2P3hDDt6i66D
         btDWFw4477RAHntffEIdWnC0xvx7dVBzacJOoUbKqSQ8oX7gbAMlTYpIluOfXJlgro7A
         uEpA==
X-Gm-Message-State: APt69E1XSeugC0Cgim7mGngG7Gzbmoool/zoTCLHl+iPTb9Y97a2MIAg
        YObqYJ3Qa+gYszbidsCxisc=
X-Google-Smtp-Source: AAOMgpeawQYAmQqtjw7RLwZP9Px5svHjU4WOegMCnxLVtBGDweQug4N+DegFze4SJFSfQjKUXJ0V+g==
X-Received: by 2002:a25:6e54:: with SMTP id j81-v6mr8861944ybc.430.1530566039900;
        Mon, 02 Jul 2018 14:13:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id q131-v6sm9151328ywq.8.2018.07.02.14.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:13:59 -0700 (PDT)
Date:   Mon, 2 Jul 2018 14:13:57 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 14/14] skip readahead if the cgroup is congested
Message-ID: <20180702211357.GN533219@devbig577.frc2.facebook.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
 <20180629192542.26649-15-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629192542.26649-15-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:25:42PM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> We noticed in testing we'd get pretty bad latency stalls under heavy
> pressure because read ahead would try to do its thing while the cgroup
> was under severe pressure.  If we're under this much pressure we want to
> do as little IO as possible so we can still make progress on real work
> if we're a throttled cgroup, so just skip readahead if our group is
> under pressure.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
