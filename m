Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FED2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C29C2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OuXecmrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C29C2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeKACIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:08:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40809 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbeKACIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:08:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so7913927pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=AsXg857izCpeTVDxK4Kso/YE4Hfm18P1OOkhWRrs/8k=;
        b=OuXecmrIK7FRamaSghnfVdpiXmd6Ey7Tp9/DHzo3iICkrv6DOTVH+llV65iOZU1AVw
         abfrpZGyWP9jEeqxNxoJ7w4JRBbEDBlQGqGhbFHsgSzkukK69uoDgSl7w7sSNG0GdTYm
         Z/o0jptejm4Tsoj8jSxgSRy/GPqWewMRI5AswznK+ZbdKV++gQoxnhSTLXeATzW6/z2e
         /b3lvztL6WDz8pOrMkv0d4zcZE8VM/bwmkjQUZ6SFRRbbN5gl3kcH5J7dKn9O12LmtVO
         99S5qMYkyu2lh/6qFfu4+vwBRA2rLc8zCFQ/8/o+dGDNx9XadDvw+gdr0+xnea84P80R
         t9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=AsXg857izCpeTVDxK4Kso/YE4Hfm18P1OOkhWRrs/8k=;
        b=hiqEdVDviNShhvrp6p4Sjbk+38YRDB8yxpaybeC9uxZOE2+gogtjIyNnUPysxJuPE3
         Y1TBLkK2TQVYFhMWhHZ0Yjwh83qs3ToDSxg2GE05jj2bc0RZytoZ/Qyt1bwMtWjpDZc/
         AcTGLNFSNxaFzKypcYrEYd9+IM8V0a2UCX/5O2cVqPfSuTrhIsEGqkdhqJUaR9yHXFoc
         wgrkg+gBbgUunCs05Xv8qwjAfnTzJOu6y7m0z5S8aiebA6vWZsfipeefJe4t2p83DITN
         5YiQmSfj+usr7oAHerEmiF0AHEB1HJdMF1JL2ACAEbci+Kf04eM7WddBPylGZBjEV4Bq
         52fA==
X-Gm-Message-State: AGRZ1gJoqxUjkPueFUwSnIjljSu4wTR+ZADdSW3EsgiuwOijhFBZDQL7
        LbuqQgj65kDSptBzWuGLg8Wv1g==
X-Google-Smtp-Source: AJdET5cZYhgVxWlaSuWYOUOUX4SQkeq1kjnVstsuRypYVN4dBncSbg3XZJhLabOHLhq1lQEnMxAENQ==
X-Received: by 2002:a63:81c7:: with SMTP id t190mr1237601pgd.393.1541005748738;
        Wed, 31 Oct 2018 10:09:08 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m1-v6sm31868906pgl.33.2018.10.31.10.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 10:09:07 -0700 (PDT)
Date:   Wed, 31 Oct 2018 10:09:07 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Oct 2018 10:08:24 PDT (-0700)
Subject:     Re: [PATCH 0/3] RISC-V: A few build/warning fixes and cleanup
In-Reply-To: <20181031064709.30981-1-olof@lixom.net>
CC:     aou@eecs.berkeley.edu, zongbox@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Olof Johansson <olof@lixom.net>
Message-ID: <mhng-74b51433-1762-4741-935d-56ca1b3548a0@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 23:47:06 PDT (-0700), Olof Johansson wrote:
> A couple of fixes for build breakage or warnings, and a small whitespace/asm
> cleanup. The non-cleanups would be good to see in 4.20 to keep builds green.

I'm happy to just keep them all together, since the cleanups are non-functional 
changes.  Patch 1/3 appears to have disappeared from my inbox and I can't get 
to the infradead archives, do you mind re-sending it?

This also brings up a bigger issue: I need to stop breaking the build, 
particularly as we now support a bunch of configurations.  Is your CI stuff 
still running?  It'd be great to have it run against some of our integration 
branches so I can catch these before they make it upstream.  I haven't been 
getting any emails.
