Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4528EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26372086A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FDLxTc3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26372086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933077AbeGIOgM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:36:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeGIOgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=do65+p/1fwKe/HUlk44JmPxnFidFLJM3iwwMNZoCfDc=; b=FDLxTc3FRzszE3tHxEjpVzdJV
        2eKLlUgx/tLtsbR0tCKDEkHI31oBNVKY0hd8zuB+W3bUz4h0NmdmIaIWP++Or82xdKYGED8FB/+YT
        bOmx4xXXQZPkcjmMJPrTA7t4GP45Ij8QLkWmUgfaftui4+nqk9lwE7ASPWmDfnKSxjK3sPfwVXqrC
        UzIZWeyFu/b12Gv0tqGYoVMj4nEL7yp1FIFnT85pudSSaFtSLEW8F/uQeINaWyzWxdrc/M7Eh3JEJ
        vq7g1MKU9VN/kQXHuLK9SY4U464BWUt/e7Y90BSA1YCk4xWxZ7ld0ttiZC6lqmKryizwsMWNWAOc7
        Ay2weGF/Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcXGs-00057E-7I; Mon, 09 Jul 2018 14:36:10 +0000
Date:   Mon, 9 Jul 2018 07:36:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>
Cc:     hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
Message-ID: <20180709143610.GD2662@bombadil.infradead.org>
References: <000000000000d624c605705e9010@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d624c605705e9010@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 06:19:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    526674536360 Add linux-next specific files for 20180706
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=116d16fc400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
> dashboard link: https://syzkaller.appspot.com/bug?extid=b8e0dfee3fd8c9012771
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=170e462c400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f1ba2c400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com

#syz fix: shmem: Convert shmem_add_to_page_cache to XArray
