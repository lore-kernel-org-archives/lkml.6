Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD41CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76160217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbeLRFib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:38:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52340 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbeLRFib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:38:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 587E3133FC85E;
        Mon, 17 Dec 2018 21:38:30 -0800 (PST)
Date:   Mon, 17 Dec 2018 21:38:27 -0800 (PST)
Message-Id: <20181217.213827.862306592325778210.davem@davemloft.net>
To:     sbrivio@redhat.com
Cc:     syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com,
        dvyukov@google.com, paulmck@linux.ibm.com, eric.dumazet@gmail.com,
        arjan@linux.intel.com, akpm@linux-foundation.org,
        josh@joshtriplett.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] fou: Prevent unbounded recursion in GUE error
 handler
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4d5bd8cb8d2b22cd6332a71428278eea6a091326.1545088026.git.sbrivio@redhat.com>
References: <4d5bd8cb8d2b22cd6332a71428278eea6a091326.1545088026.git.sbrivio@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Dec 2018 21:38:30 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Brivio <sbrivio@redhat.com>
Date: Tue, 18 Dec 2018 00:13:17 +0100

> Handling exceptions for direct UDP encapsulation in GUE (that is,
> UDP-in-UDP) leads to unbounded recursion in the GUE exception handler,
> syzbot reported.
> 
> While draft-ietf-intarea-gue-06 doesn't explicitly forbid direct
> encapsulation of UDP in GUE, it probably doesn't make sense to set up GUE
> this way, and it's currently not even possible to configure this.
> 
> Skip exception handling if the GUE proto/ctype field is set to the UDP
> protocol number. Should we need to handle exceptions for UDP-in-GUE one
> day, we might need to either explicitly set a bound for recursion, or
> implement a special iterative handling for these cases.
> 
> Reported-and-tested-by: syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com
> Fixes: b8a51b38e4d4 ("fou, fou6: ICMP error handlers for FoU and GUE")
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>

Applied, thanks.
