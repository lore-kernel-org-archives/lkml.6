Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7BCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE11A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="tmPMzeR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbfBLQIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:08:36 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33760 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbfBLQIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:08:36 -0500
Received: by mail-yw1-f66.google.com with SMTP id p17so1216662ywg.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=25s6ZzpZBvcdHA9iUQ1peThatSnI2TBHe3HYkjmpXe0=;
        b=tmPMzeR5aNZd2v/KezfkXsfcEtRhX0m2PsZ9JjbgFgY4LQZw+t96OPzWv93Aofc0gd
         zGqfDwR3lKpwbqviQ5bLjsJlC5PcacEYfsxRcYXCt/J368b/xmGd/8jVT8TF54feRZv6
         dB/qomR9zsAogwAaE/QaKxihmDPc9fyuoypeSfxz6Qb9reiSC0CZadM7o1a0Uy52Q4XE
         rXPQYgDv1OWEVDNDr3u2aisXLMEhZTYl0KNN9kp1ySgRyxZkDgl9hS9Gx+EWj4YqUCTK
         +uaiYapXarW8+FUqyqQdDbvbooF02ADtwASSBowC4E4ad1IcBngSDe71j/ncajjU38WO
         jD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=25s6ZzpZBvcdHA9iUQ1peThatSnI2TBHe3HYkjmpXe0=;
        b=Fv3GnlpPlujHjaBO80E6tcUcilQqHIt335iRX20q7LILeLx/A7nQjZ2Z78xrzx8YQC
         JYx+3FGRcs3mX3ggmDJWybHR/qdSm43tOt7QQ3Vc/IOpviN/EcDJUNVG7rVd016DBIVT
         s4dWQ3t0vzdX3eg0e5tghIGFDRy0ximh+2ZfbLtsN2i2h71Hl+m562WvU7V7AMfgTb3F
         724+kE/qB5KbHb7bo7E2R+8nusq8hUUCylIo4oljvU/HC8F8BKlQosS/8804+SLck272
         oCUo3Mroo9tofB7xvhMNtTmRjUHt2UbrBpKXlCoURpjzyRoIrd1So1UnXF3CmtpCGKFU
         PPzg==
X-Gm-Message-State: AHQUAuYGf70DunIK7PBNY3ZRLD8wIb4aEra6MPkLct9hJSNL3n4Eh5xZ
        V6f7T6+xOEGUsh/eSpjeWvfiDQ==
X-Google-Smtp-Source: AHgI3Iar1Fw4cjlPFNp8NTALnE9GYU54kXPdqThc74HyaWjuSGDpvOQijVQSKBMX40Xk85wN8su1Lg==
X-Received: by 2002:a81:1690:: with SMTP id 138mr684794yww.276.1549987714740;
        Tue, 12 Feb 2019 08:08:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:41f4])
        by smtp.gmail.com with ESMTPSA id s7sm5004150ywe.20.2019.02.12.08.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 08:08:33 -0800 (PST)
Date:   Tue, 12 Feb 2019 11:08:32 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yong-Taek Lee <ytk.lee@samsung.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] proc, oom: do not report alien mms when setting
 oom_score_adj
Message-ID: <20190212160832.GB14231@cmpxchg.org>
References: <20190212102129.26288-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212102129.26288-1-mhocko@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:21:29AM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Tetsuo has reported that creating a thousands of processes sharing MM
> without SIGHAND (aka alien threads) and setting
> /proc/<pid>/oom_score_adj will swamp the kernel log and takes ages [1]
> to finish. This is especially worrisome that all that printing is done
> under RCU lock and this can potentially trigger RCU stall or softlockup
> detector.
> 
> The primary reason for the printk was to catch potential users who might
> depend on the behavior prior to 44a70adec910 ("mm, oom_adj: make sure
> processes sharing mm have same view of oom_score_adj") but after more
> than 2 years without a single report I guess it is safe to simply remove
> the printk altogether.
> 
> The next step should be moving oom_score_adj over to the mm struct and
> remove all the tasks crawling as suggested by [2]
> 
> [1] http://lkml.kernel.org/r/97fce864-6f75-bca5-14bc-12c9f890e740@i-love.sakura.ne.jp
> [2] http://lkml.kernel.org/r/20190117155159.GA4087@dhcp22.suse.cz
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
