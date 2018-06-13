Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DE614C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C352086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmS8s8OX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C352086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935971AbeFMP4F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:56:05 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35669 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935694AbeFMP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:56:03 -0400
Received: by mail-pl0-f68.google.com with SMTP id k1-v6so1794618plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ynJ21TXU/tX5WK70IqFau6rKUf9vU66RiXtFD0kQf18=;
        b=CmS8s8OXtmzlQXKG7gSlWjkrmcjnLmZ5keabrLLy0L2tO6LbDNWqCrHM7h2TTgj/+h
         Zaoa2H1e21YbbZlhlPSbIkUL/7F6k+O/fYyo+U5UvNyt8CLB5Gq6BitRNcsn7bLpWwkT
         6H2LpIPvP1HxIaTwkRFg5HKv/ulIQ9Nmzzg0zk+NA16j1CUQnz/SwooJiqv0o/XIhfK8
         VwH06DjIwy74LuzL4lJssiu9rxHSS6J0N9VPg91JzV8qMzVNHgnver2Uki+amsgB6OE3
         zjHPLAutSNq2N4VWFlNbSh+lkoXypIyB4INPwNTRj/ZeWaeNZzApkRc6odl429pXlLqA
         RzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ynJ21TXU/tX5WK70IqFau6rKUf9vU66RiXtFD0kQf18=;
        b=GaRb1Ru+2QYmIUoBfBnov/Spi4w4WQpX+YWyPsoCDFCgjQY0DF62APdsG2kRlKbHHV
         JVXFU/WOSU7pIiTvEeT+xUkT5/+Nfh6gzA40yAnRCDn9WJMj0iD8qfhPbkurUvCcGmpb
         lqIjZ59rH61KW6iXb5Gin7pVxMpPKiv1hSBIFnll0w8G9y+qkMfmp9dGd6Ywey5tD+qd
         2TSqhgW0eFpSGsBShfvIP0wWKvzQe1FMbyk6NoXiqlUGytesr9mH4dchfGqwqgqxjktZ
         kM1cQg1x4jVZ1mGQYc+/Znqw64B1NCP2obJ79CiMcQ6Aq+BDNgATuooDoPfMG+RuBpUv
         Rasw==
X-Gm-Message-State: APt69E3NhLndef9LEMIESYVL2Nt1Zc0a9oqi+/+xxpfsRqgiKp9xpTEV
        FHsk4Q3+ZEbERF10e53ctB/G37K7TlLBPlzD2hM/CA==
X-Google-Smtp-Source: ADUXVKKGPEb4iwBLajv9p2PXqQVvInTV/jDKAyIrvj8KUhtxApAbCdxWi7kskCQl1tYPzgK6RtzkNHX37Sapg8tDoQg=
X-Received: by 2002:a17:902:ab95:: with SMTP id f21-v6mr5615623plr.264.1528905362728;
 Wed, 13 Jun 2018 08:56:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 13 Jun 2018 08:55:42
 -0700 (PDT)
In-Reply-To: <20180521125000.hlgdsvlzlr7xw3bx@quack2.suse.cz>
References: <089e0825cec8180a2b0568c4ee1d@google.com> <0000000000003a8d73056cb11ca3@google.com>
 <20180521125000.hlgdsvlzlr7xw3bx@quack2.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 13 Jun 2018 17:55:42 +0200
Message-ID: <CACT4Y+bwuRKAXj7gkPa3=ADk7JMBRd61YCWr=6bRkd6fmz_fCQ@mail.gmail.com>
Subject: Re: WARNING in ext4_set_page_dirty
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+9a44753ac327c557796a@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:50 PM, Jan Kara <jack@suse.cz> wrote:
> On Sun 20-05-18 23:07:02, syzbot wrote:
>> syzbot has found a reproducer for the following crash on:
>>
>> HEAD commit:    771c577c23ba Linux 4.17-rc6
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=108c9f37800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>> dashboard link: https://syzkaller.appspot.com/bug?extid=9a44753ac327c557796a
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1655584f800000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15134357800000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+9a44753ac327c557796a@syzkaller.appspotmail.com
>>
>> WARNING: CPU: 0 PID: 4577 at fs/ext4/inode.c:3894
>> ext4_set_page_dirty+0x28d/0x330 fs/ext4/inode.c:3894
>> Kernel panic - not syncing: panic_on_warn set ...
>
> Looking at the reproducer, this is the issue we have been speaking about at
> LSF/MM - direct IO read dirties pages after writeback has written them out
> and so we don't expect them to be dirtied. If someone told me I would not
> believe this is possible to hit by fuzzing ;) Good job from the syzkaller
> guys!

Thanks, Jan! Very nice to hear.
I believe we are not yet at the limit of what's possible :)
