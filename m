Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9013EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8A22082F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbfBMWc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:32:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34428 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfBMWc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:32:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so1864616pgd.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+CCXuNWz6DxN+r3F1hHqeSqXrw7Y/kUe+BLSxvQ5cQ=;
        b=nW/WXfZwLFVXFFZ5YtN2fJAANnl5AknqNm5xr0phrDoQW3lDwEZ0xM5wTwQGy4L4JD
         qxf59KvnbQTtP0qYZKlRj2CUM43dmNN4ly9QcqrRrSVJuxEjtbaAs0DBlnq9omLHarxh
         JM8Z2DFpXIeCAZ2pzkGnhwHkQ5mo1KEeQrjx0HAcBjwAGituH4fQEhj/VLBvB/lvcJlt
         lufG5c87feSx0H0poXqgDAjrwyerzIrzfivvfVfVZA9JZ8uP/6xFAytXDF8D+ODSiG4q
         sgexP0I39aZlNm9Im4CPOniC76xSIytuvRwZciZQYEIKwnxQqQ5h630s3hHtjGTzB2fS
         Uang==
X-Gm-Message-State: AHQUAuYEgIzlOp14FH80pFTxQjdNWoRLSJMdfJ2tOmDBJ0BaONzJZcl9
        W5sVJ50YHc0WNyVMgRS9lGQ=
X-Google-Smtp-Source: AHgI3IYYmrXrGYeeWMUHDS7RK6PgnHRYZfmodEkrF6QgBUR6XRCTpzhZVES/FET5o7b/SMFEeQCtjA==
X-Received: by 2002:a62:560f:: with SMTP id k15mr471326pfb.231.1550097145384;
        Wed, 13 Feb 2019 14:32:25 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id v75sm419822pfa.164.2019.02.13.14.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:32:24 -0800 (PST)
Message-ID: <1550097142.31902.55.camel@acm.org>
Subject: Re: [PATCH v6 00/16] locking/lockdep: Add support for dynamic keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tj@kernel.org, longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Date:   Wed, 13 Feb 2019 14:32:22 -0800
In-Reply-To: <20190208114315.GD6972@fuggles.cambridge.arm.com>
References: <20190111124835.GP1900@hirez.programming.kicks-ass.net>
         <1547222103.83374.72.camel@acm.org>
         <20190111165529.GA14054@worktop.programming.kicks-ass.net>
         <1547226101.83374.80.camel@acm.org>
         <20190114125235.GB20726@hirez.programming.kicks-ass.net>
         <1547484753.83374.109.camel@acm.org>
         <20190118094808.GA27931@hirez.programming.kicks-ass.net>
         <1250147c-27bc-92e1-3ff5-211f3ba56891@acm.org>
         <20190201121510.GC31516@hirez.programming.kicks-ass.net>
         <3c533b0e-b079-79ad-4935-cd61af000ce6@acm.org>
         <20190208114315.GD6972@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 11:43 +-0000, Will Deacon wrote:
+AD4 I've also been trying to understand why it's necessary to check both of the
+AD4 pending+AF8-free entries, and I'm still struggling somewhat. It's true that the
+AD4 wakeup in get+AF8-pending+AF8-free+AF8-lock() could lead to both entries being used
+AD4 without the RCU call back running in between, however in this scenario then
+AD4 any list entries marked for freeing in the first pf will have been unhashed
+AD4 and therefore made unreachable to look+AF8-up+AF8-lock+AF8-class().
+AD4 
+AD4 So I think the concern remains that entries are somehow remaining visible
+AD4 after being zapped.
+AD4 
+AD4 You mentioned earlier in the thread that people actually complained about
+AD4 list corruption if you only checked the current pf:
+AD4 
+AD4   +AHw The list+AF8-del+AF8-rcu() call must only happen once. I ran into complaints
+AD4   +AHw reporting that the list+AF8-del+AF8-rcu() call triggered list corruption. This
+AD4   +AHw change made these complaints disappear.
+AD4 
+AD4 Do you have any more details about these complaints (e.g. kernel logs etc)?
+AD4 Failing that, any idea how to reproduce them?

Hi Will,

Since elements of the list+AF8-entries+AFsAXQ array are always accessed with the graph
lock held, how about removing the list+AF8-entries+AF8-being+AF8-freed bitmap and making
zap+AF8-class() clear the appropriate bits in the list+AF8-entries+AF8-in+AF8-use bitmap?

Thanks,

Bart.
