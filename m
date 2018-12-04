Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DA5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2A12082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="e9VoNikx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2A12082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbeLDTxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:53:31 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46845 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeLDTxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:53:31 -0500
Received: by mail-yb1-f193.google.com with SMTP id l126so3419908ybf.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eibZSqqt2fdedYCZEqGEWncABakoTV+JJrqQAPkEo70=;
        b=e9VoNikxb1yKN7yTDxfP/PRQF4kY+TdUAo3Dd3k5vpDc+QARcG7zgJemnx15g8VY6p
         6bhUEmuGlIKOXF6xLNjIU9HGHXoFIl/oquJXyBoaUJGHBARVys3B7pUpNG0nJEjZAcrD
         UN6f0n0A4jCJqVCJWi1bVL82RRNES0O87NRcvQmIY3KHj0i7zeq0eBGVxHhv/eFwMnzb
         5hGdgwIZERYn9tAsQJ94snlf4ajwSFw28zvESwq1SMlEyNamlKEsca0TfjfvDUgkn/Ys
         wRXMuqUEWrew3IgJ7OppvojSxbs0mvrHT9hAT5LDNh21RKViLdkpnnV3JvU3uXNOav3v
         yV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eibZSqqt2fdedYCZEqGEWncABakoTV+JJrqQAPkEo70=;
        b=djsBujcwyO6AMcuRgqsfeOv5IVFnoJgDIKtb1jFgjKVbGZYUrH9TxxfqKfeOuTdZEq
         2IfFb380fyVZqZaITsQQbVDu0ugbujYg0/+tUX7stE61YfXAEBbpfyI7d+XT2D38A9e3
         UFVlkrzIRz+yc8rJaZAEsV0LSFXh8m7d5TY7c2ov+gttnvELhftqlc9VIzYCTF6PkT6W
         gMrTGxBEQlBwToSSS1S9PAhufzEcct3r1XADTmzR7Av/6tcWoWi77z/P87lMCHipp4wT
         9LtbkTVewZ5JBQzlnLBKHpIrvzN6QhqXYs3wmoWuX0IUYJ071JOymVyv2X88WuBQwq80
         n7mg==
X-Gm-Message-State: AA+aEWZiZ4Kmxjz7YIR/rGgEZsuIqK8gw1hhww9T9plyqnplgGKLgb05
        Sw9CM9o5BbauuysEw/XqQnPKyQ==
X-Google-Smtp-Source: AFSGD/UTE0bvOsreCKqgIK6Xzu31gV/GpETf49LS2dFN5W7bWw6Zze9tE4kiTYDwN4fIt48XvWlw/g==
X-Received: by 2002:a25:1e56:: with SMTP id e83-v6mr16986454ybe.163.1543953210567;
        Tue, 04 Dec 2018 11:53:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b144sm8042496ywa.33.2018.12.04.11.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:53:29 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:53:28 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] blkcg: remove bio_disassociate_task()
Message-ID: <20181204195327.upryhcrqaxjxgrzd@MacBook-Pro-91.local>
References: <20181204183600.99746-1-dennis@kernel.org>
 <20181204183600.99746-13-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204183600.99746-13-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:35:58PM -0500, Dennis Zhou wrote:
> Now that a bio only holds a blkg reference, so clean up is simply
> putting back that reference. Remove bio_disassociate_task() as it just
> calls bio_disassociate_blkg() and call the latter directly.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
