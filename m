Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B97C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839CF206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="gQCkCkBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfAIVXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:23:38 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33150 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfAIVXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:23:37 -0500
Received: by mail-yb1-f196.google.com with SMTP id o73so3602474ybc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 13:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kfFoE86abS3p8Fs1VfcYmGgBPBRGbAxZVbI0XgjcWOE=;
        b=gQCkCkBRANwch9nBpN2mXOwU5nTY9Yi9e5cM+ZfzTUzr15AuQShCmzvmumgREGnX0a
         GNzAzRVC8wrd1gy1pYZlbBEHWestM29tSNpvivyYH2y7BmI5QiY+JH7CK6iYiIBb/FTh
         LjlipZf2PfnTq9fQ0yQiX1Je5l6oE6plLwXlrwyYLddPE/WGNX6CYNK3nwT1OP/QEcXn
         zIl3PDUlT0ksHLwqc7HEJYqeYfSbn+j1OGroY3omaplEMagiZRzf5ftf4HBMubUDOaqP
         QHw7osyPDV5QaAZpmO4t503bVrHOvHCyqf6dyZtOGZr8P3qQflUWyG05fXHYCstdbOfu
         eliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kfFoE86abS3p8Fs1VfcYmGgBPBRGbAxZVbI0XgjcWOE=;
        b=pf2BFV15q/FCCTPzxzlWKxZM4cHApW6ZegRdIWcZzlQ43qeM4f+KttMNtGtkpJiaW2
         PE5F4uFMfKGXJwRDtDna4224W/rtf8LyH21icRl0m7Iq3dYs7O7jN377SgAp8MBzXVu5
         QMxstouzqzKprPwUzHG6G4+UupSiDgH7mRjzRG4pAXvJYY7NqwPl0J8uJKEOJAR04qHo
         cCVuKJqRDndGMSnmAqyBlY1kQDVGiMIy3bQ0oIcM0j4ze40ONHnuLwUQA+WmESjgQbMI
         sFugFpFSwWAInqPp7ZB6zEBzZy8c6x09PcOx4k3UVYwdLwxHgV+kiMm+U07nZJZ78HRC
         sqmg==
X-Gm-Message-State: AJcUukfahsoHWEonvqI21MPltLbXq9JRWEGtkpQgQvuy9Lze8BzaiMV6
        /8t67syS83ufORXRUb3C2P6mdQ==
X-Google-Smtp-Source: ALg8bN6ye/lNUL4fYCnvsTnc5SMLGZTPIs8R1YA9vf4m7tPeXHO+Vp6V0HmcfoDI3m4qMHxVEZKOqQ==
X-Received: by 2002:a25:b321:: with SMTP id l33mr7119551ybj.280.1547069016441;
        Wed, 09 Jan 2019 13:23:36 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:f15b])
        by smtp.gmail.com with ESMTPSA id s185sm36693021yws.69.2019.01.09.13.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 13:23:35 -0800 (PST)
Date:   Wed, 9 Jan 2019 16:23:34 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 0/5] mm: memcontrol: do memory reclaim when
 offlining
Message-ID: <20190109212334.GA18978@cmpxchg.org>
References: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190109193247.GA16319@cmpxchg.org>
 <d92912c7-511e-2ab5-39a6-38af3209fcaf@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d92912c7-511e-2ab5-39a6-38af3209fcaf@linux.alibaba.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:36:11PM -0800, Yang Shi wrote:
> As I mentioned above, if we know some page caches from some memcgs
> are referenced one-off and unlikely shared, why just keep them
> around to increase memory pressure?

It's just not clear to me that your scenarios are generic enough to
justify adding two interfaces that we have to maintain forever, and
that they couldn't be solved with existing mechanisms.

Please explain:

- Unmapped clean page cache isn't expensive to reclaim, certainly
  cheaper than the IO involved in new application startup. How could
  recycling clean cache be a prohibitive part of workload warmup?

- Why you cannot temporarily raise the kswapd watermarks right before
  an important application starts up (your answer was sorta handwavy)

- Why you cannot use madvise/fadvise when an application whose cache
  you won't reuse exits

- Why you couldn't set memory.high or memory.max to 0 after the
  application quits and before you call rmdir on the cgroup

Adding a permanent kernel interface is a serious measure. I think you
need to make a much better case for it, discuss why other options are
not practical, and show that this will be a generally useful thing for
cgroup users and not just a niche fix for very specific situations.
