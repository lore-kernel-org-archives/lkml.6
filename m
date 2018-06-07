Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LlAJMCZdGVtbKQAAmS7hNA
	; Thu, 07 Jun 2018 16:28:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 76AD86089E; Thu,  7 Jun 2018 16:28:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKfTlVWD"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B096860590;
	Thu,  7 Jun 2018 16:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B096860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeFGQ2b (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:28:31 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36450 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932160AbeFGQ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:28:23 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so3965796plp.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=Bix4pk4nM4frknzm5oL/wBUaoXyVZw50N9nXaUuhfSw=;
        b=pKfTlVWDb/PMlmjzRALWDzpmeFEMcKOIEaEq6X5m5bl2FdbHReGLYhG5kAHV2SJNnZ
         kSbcrOIhJxcGKQ/O3gWanS9KLY2f0VDgTOtkUAYC4H3ZQbde1BtZGg+TAHtzRrsfekV4
         3b1lCdpTymELm69gvndBPv0MYFKd+WSpxHPjPqtCm8dPsTLzJaojbV1GyX5/l6O+he2G
         LP5ZlmpqhPJZmZO5Km5zd4azAK0DAah2gAWX2QBfQy0MrLW0mA0cqoTXa/r2JgXdLgro
         y67+yNXgufpbyx8P9vKSVmW97dnVNuNG9ewHn9LchAZnMoXOQgcpL48GmTKa/j0xGegH
         FTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=Bix4pk4nM4frknzm5oL/wBUaoXyVZw50N9nXaUuhfSw=;
        b=nnHpA15rexf7aX32iLLYOQmLMLRvcBN7EP433PFu1IA9S3RJo1g6ZajJ6GB4q8ZRFi
         i3QKvdiT1FNSd3OZ0eZ+j8P/1ATd+aJUcKdxoro7qI2XFj1LVo1qiCsthNbWgssTygoP
         nYD4cRDBUH2XxMjjbyajzXR8XZl/lfLJ1xwFAGSAJHndEVWt3jQHopZfD0iyMRqNuh2h
         cVe8NUPgb/ij9FpDd46zMCTH23e5c/uvnlJTh6F6ixQh0WaWEV+LJhFicL6jX2ckaiKH
         f57kSKVuoKG2c+69t6Ndjvh0Qn+0bOekcEAUbDjondY17LPKO45TJSi6KF7Y4BBu5zYc
         Uscg==
X-Gm-Message-State: APt69E0Um2llVx/2ZBEJ5rqACatphSl3cgU0tHySCmy9bx3xw/EMPwgx
        DUuwJqmB253SNAKeESowgHRmJSWGkCcJB89xvKOc/g==
X-Google-Smtp-Source: ADUXVKI1LBDrccTDb17gk+KBFgue7nP48AwEkqNiufEGnk0IDMOXFrFz95PtubJLj2wETbl2mUWKvbvChdNIlPP2P7w=
X-Received: by 2002:a17:902:7d09:: with SMTP id z9-v6mr2706918pll.233.1528388902549;
 Thu, 07 Jun 2018 09:28:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Thu, 7 Jun 2018 09:28:02
 -0700 (PDT)
In-Reply-To: <20180607153450.GF3215@twin.jikos.cz>
References: <00000000000096009b056df92dc1@google.com> <70a3c2d1-3f53-d4c0-13b3-29f836ec46d9@oracle.com>
 <20180607153450.GF3215@twin.jikos.cz>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Jun 2018 18:28:02 +0200
Message-ID: <CACT4Y+arBwkwhD-kob9fg1pVBXiMepW6KBK2LkhwjQ9HnDcoqw@mail.gmail.com>
Subject: Re: kernel BUG at fs/btrfs/volumes.c:LINE!
To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        syzbot <syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, Josef Bacik <jbacik@fb.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 5:34 PM, David Sterba <dsterba@suse.cz> wrote:
> On Thu, Jun 07, 2018 at 12:15:04AM +0800, Anand Jain wrote:
>>
>>
>> On 06/06/2018 09:31 PM, syzbot wrote:
>> > Hello,
>> >
>> > syzbot found the following crash on:
>> >
>> > HEAD commit:    af6c5d5e01ad Merge branch 'for-4.18' of
>> > git://git.kernel.o..
>> > git tree:       upstream
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=15f700af800000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=12ff770540994680
>> > dashboard link:
>> > https://syzkaller.appspot.com/bug?extid=5b658d997a83984507a6
>> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> >
>> > Unfortunately, I don't have any reproducer for this crash yet.
>> >
>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com
>> >
>> > RDX: 0000000020000080 RSI: 0000000020000040 RDI: 00007f787067fbf0
>> > RBP: 0000000000000001 R08: 00000000200000c0 R09: 0000000020000080
>> > R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000014
>> > R13: 0000000000000001 R14: 0000000000700008 R15: 0000000000000043
>> > ------------[ cut here ]------------
>> > kernel BUG at fs/btrfs/volumes.c:1032!
>> > invalid opcode: 0000 [#1] SMP KASAN
>> > CPU: 1 PID: 22303 Comm: syz-executor1 Not tainted 4.17.0+ #86
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> > Google 01/01/2011
>> > RIP: 0010:btrfs_prepare_close_one_device fs/btrfs/volumes.c:1032 [inline]
>>
>> btrfs_prepare_close_one_device()
>> ::
>> 1031           name = rcu_string_strdup(device->name->str, GFP_NOFS);
>> 1032           BUG_ON(!name); /* -ENOMEM */
>>
>> The way we close our devices needs new memory allocations
>> at the time of device close. By doing this apart from the BUG_ON
>> reported here, there _were_ other complications like managing the sysfs
>> links and moving them to the newly allocated btrfs_fs_devices.
>> So sometime back I attempted to correct this approach to a simple
>> device close without fresh allocation, however it wasn't successful.
>> I am going to try that again, but its not p1.
>
> Yeah, getting rid of the allocations while freeing device would be great
> but unfortunatelly is not simple.
>
> Normally the GFP_NOFS allocations do not fail so I think the fuzzer
> environment is tuned to allow that, which is fine for coverage but does
> not happen in practice. This will be fixed eventually.

Isn't GFP_NOFS more restricted than normal allocations? Are these
allocations accounted against memcg? It's easy to fail any allocation
within a memory container.
