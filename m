Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C040C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6263120823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfBHQcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:32:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39147 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfBHQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:32:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so1917263pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYWOZOCvWzvRJBXd+ukKOOnZ0fWObvJWXkXGjelr6Gw=;
        b=ee7WDKEK5BMWqGlHp5Em5bWDvk9aM3KmEyCLfS5bFCnQ0xgJ5hJo/bGYGygNGSPgWx
         /ylbziDdSPiC+Ez5BWvbqjMymbBpw4x8X/YplG6jhmESjxLTQHRLgeRatZren4AHKnPq
         Dw/T6habIjxgyfbhrD06e5uJkcE+ChYOqYO6u+MmQPj8zjV9AwFCenSuX0Bls0ZsN+rj
         toyBiTjZefrL+fE33cic0cWitxnlTxY6l6EHMHjRoO8jS9bzfA50/PAlq3jVrZZ1jiPS
         0z4ZUeraUpO4BOiMTH4WqBK3dh4YvPCS9bi82EtwpPz22mOSbtY3wT3AyzE6ssc/OQi+
         HY7A==
X-Gm-Message-State: AHQUAuZ7rM7qIcgQX6YPga4gvWWPWMOYC4aLT41zSCISOvRBzfgFzSXt
        Q9YR1wm7x/01l0XKYA0KLOI=
X-Google-Smtp-Source: AHgI3IZvzR9JL59EP+nFxTt3UCG9mgmh3c6qSZw1bFInZSnPdmMe3zM9eTpUgebT7aE5hdAZdZLG5w==
X-Received: by 2002:a17:902:8f91:: with SMTP id z17mr23108295plo.300.1549643520524;
        Fri, 08 Feb 2019 08:32:00 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h129sm9043550pfb.110.2019.02.08.08.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 08:31:59 -0800 (PST)
Message-ID: <1549643518.34241.101.camel@acm.org>
Subject: Re: [PATCH v6 00/16] locking/lockdep: Add support for dynamic keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tj@kernel.org, longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Date:   Fri, 08 Feb 2019 08:31:58 -0800
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

The approach I use to test this patch series is to run the following shell
code for several days:

    git clone https://github.com/osandov/blktests/
    cd blktests
    make
    while ./check -q srp+ADs do :+ADs done

This test not only triggers plenty of lock and unlock calls but also
frequently causes kernel modules to be loaded and unloaded.

The oldest kernel logs I have in the VM I use for testing this patch series
are four weeks old. Sorry but that means that these logs do not go back far
enough to retrieve the list corruption issue I mentioned in a previous
e-mail.

Regarding the concern that +ACI-entries somehow remain visible after being
zapped+ACI: in a previous version of this patch series a struct list+AF8-head was
added in struct lock+AF8-list. That list head was used to maintain a linked list
of all elements of the list+AF8-entries+AFsAXQ array that are in use. zap+AF8-class()
used that list to iterate over all list entries that are in use. With that
approach it was not necessary to check in zap+AF8-class() whether or not a list
entry was being removed because it got removed from that list before
zap+AF8-class() was called again. I removed that list head because Peter asked
me reduce the amount of memory required at runtime. Using one bitmap to
track list entries that are in use and using two bitmaps to track list
entries that are being freed implies that code that iterates over all
list entries that are in use (zap+AF8-class()) must check all three bitmaps. The
only alternative I see when using bitmaps is that zap+AF8-class() clears the
bits in list+AF8-entries+AF8-in+AF8-use for bits that are being freed and that
alloc+AF8-list+AF8-entry() checks the two bitmaps with list entries that are being
freed. I'm not sure whether one of these two approaches is really better
than the other.

Bart.
