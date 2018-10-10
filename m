Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C53C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB222075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ootROG/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB222075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJJWvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:51:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39049 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJJWvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:51:15 -0400
Received: by mail-io1-f68.google.com with SMTP id z16-v6so4187040iol.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0gxVXvZ+rps9+bIj4SrYSmlA7/NTm39wELBVHT5F4Zc=;
        b=ootROG/hHYBsbiMHuYgrDkvgeUPCXoVtGQQbWJf20gU04WRcuMrXL1sn9xoZaxfAuF
         kaHheOGn8qiAEHg2A+08bJ1O7fes3Ct89MH9iO2EHGcFAntSjD/NRJEgzxs7SYaQlrl0
         Sr4KcOawiRCGB6RD4voTUWAUXJqfkLe1ilqv7n3jlbgnQOFzcp26OSB1ZyHNkV0z66H7
         jbKThUunxCrInMIZIlCfNPr2EXfB15rONSfxMfv9mdQac5LvexGwoWRN2TgDwGv4WWbZ
         HaQ3hG8bahB30meMiLcsKn0+UtZX7WQoEo3YiazKa0lyesPEpWxdeEKHhyaQtCdMHWWn
         kbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0gxVXvZ+rps9+bIj4SrYSmlA7/NTm39wELBVHT5F4Zc=;
        b=P5INZd2h1wF9K0sYDXUe4Cf48eQ0lsH+f7xbVUG4RZ+ScK898YON3Fa8mvv1q+chN1
         1gYCht+FsxhyQXXGoCeYagh4gHigQDzrJp94BXOd37Y3yzbE6uoSNVbMukcbaBVtOmI/
         BDNiKzy+IsYHay+3d6f864StnKbkAKTiokQnMadaBmXJTOfl2PWkl6kPuxZVitp9Cyul
         YY6aNrjyPjjxqPRt9+kaEPjEeGFwRZYmYDiYtoJDGLsXYO5wK8mIpBvJwQ2Ur0bIIXI3
         9phE6624bzZMFOHF2JmvrRYGTGCceHYc8t6enRNdALJt5EXxnczg63xR5Zo7QRU8nXuP
         a1CQ==
X-Gm-Message-State: ABuFfog2ZhLffLUkPOf68Oe+NylHE+TOJkatJWePoTQZYbM5KUEFzevZ
        Bb2b7OCVYO9RSasGVMLFLCIyfUQeHKROGIv7NHe39C+takM=
X-Google-Smtp-Source: ACcGV61yXKQK0H4VYmpy0NBmGOIiIxycM9EpLxstmFdsIZHNbCXsWiEFsS3OqF/my6NxD3DiDKiboXnLnwqRCCMK5Og=
X-Received: by 2002:a6b:f10f:: with SMTP id e15-v6mr20728839iog.271.1539185313517;
 Wed, 10 Oct 2018 08:28:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 08:28:12
 -0700 (PDT)
In-Reply-To: <20181005145855.GB6761@localhost.localdomain>
References: <0000000000007e767d05776336da@google.com> <20181005145855.GB6761@localhost.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 17:28:12 +0200
Message-ID: <CACT4Y+YVRWSF+VyoBB1vwDevt0gwZYz69bSAivmZDG6r4J-kaA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in sctp_id2assoc
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     syzbot <syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-sctp@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 4:58 PM, Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
> On Thu, Oct 04, 2018 at 01:48:03AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    4e6d47206c32 tls: Add support for inplace records encryption
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13834b81400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e569aa5632ebd436
>> dashboard link: https://syzkaller.appspot.com/bug?extid=c7dd55d7aec49d48e49a
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com
>>
>> netlink: 'syz-executor1': attribute type 1 has an invalid length.
>> ==================================================================
>> BUG: KASAN: use-after-free in sctp_id2assoc+0x3a7/0x3e0
>> net/sctp/socket.c:276
>> Read of size 8 at addr ffff880195b3eb20 by task syz-executor2/15454
>>
>> CPU: 1 PID: 15454 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #242
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>>  sctp_id2assoc+0x3a7/0x3e0 net/sctp/socket.c:276
>
> I'm not seeing yet how this could happen.
> All sockopts here are serialized by sock_lock.
> do_peeloff here would create another socket, but the issue was
> triggered before that.
> The same function that freed this memory, also removes the entry from
> idr mapping, so this entry shouldn't be there anymore.
>
> I have only two theories so far:
> - an issue with IDR/RCU.
> - something else happened that just the call stacks are not revealing.

The "asoc->base.sk != sk" check after idr_find suggests that we don't
actually know what sock it belongs to. And if we don't know then
locking this sock can't help keeping another sock association alive.
Am I missing something obvious here? Should we take assoc ref while we
are still holding sctp_assocs_id_lock?
