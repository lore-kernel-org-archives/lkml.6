Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DE8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A922073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHGR+t6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A922073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbeH3SV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:21:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40359 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbeH3SVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:21:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so3904380plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V/HI96+g1hthoJ+H54iIa0R/hHe4c1bwCUk2CUrrlFI=;
        b=GHGR+t6D4Y61Qc8ObIumP9aTV3O02G4KAHG9+waTmyIcPoYuKa6A0SATJNJbDrVVP/
         r1FXTtesPE4nDuFivhqEgq0Wm3W8WsxXMr74nTqVSj6kcDYLWUv9GU89+oOcpeOuk1s+
         NyBATCg1iU8QKRKsN2ZxkZEPs4LO5q8RPg9bo2T53vb5bkNP2mLUj7hJmDyo/jqQ/dO3
         2inelrgLb75KIY2XHC1i1HSlRM9msWMGfkWzlDRdGuw2A8wYKfX8LWUicG01SuGt/wTd
         3FMYIoEM86o56cPXwRpagsmjzFMWIEXzVdRVWmLf9at1WqWjhUaFxM7Fz1xGZZ5jhH30
         VOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V/HI96+g1hthoJ+H54iIa0R/hHe4c1bwCUk2CUrrlFI=;
        b=P7T80F8hiRdfkC4lygesnq1+clJPlGmRRLQepldrKLBBv8maX7WzLeyZ4PV0iFyxsR
         LDfYEJwZJA15N3qheQdklZvY96VzLtcDtuGEfKlibCES2Qvzd4hM3SdxWV9zro3ftlwo
         FwiW2xbBxBtgiX46majc+cTG/Wwmz6T7yASiwSBQTwhblAqUHMNLatpbQNqVFXdkScAR
         RkAzl8tbTqexUZG6J3cI09pJERCtjRfKUBMSl4bu3We0agYa7axRGXeX0ulwgFZ3oU/V
         vSIX2IvFxEQHG0R424GlLn9UQU/okuOaufkEWJNZoDcjrDICEEc/XdwD6XtvMx2Oi0f9
         l/IQ==
X-Gm-Message-State: APzg51BENDLzGyH14ZF1hSxjCLmCiAdAW2Aky9sibqblno+qHy3A0D08
        fo8XP+zy7DXJHVf6c/O47dqEBwdnXQcDbwX0X7YDmQ==
X-Google-Smtp-Source: ANB0VdZYdLgb0eHHXWojhtWz8ZVIBRiSX96eIy0kw1hc/Q0HA+cShq7CPrQDvGJhNByIb22K2HNwLSvG//1j43JYjFs=
X-Received: by 2002:a17:902:6f10:: with SMTP id w16-v6mr10320727plk.216.1535638773472;
 Thu, 30 Aug 2018 07:19:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 30 Aug 2018 07:19:12
 -0700 (PDT)
In-Reply-To: <279041ab-d449-1bfb-a05d-2d8b0d5c601b@iogearbox.net>
References: <000000000000fef39305748083ae@google.com> <20180829134620.GD7369@quack2.suse.cz>
 <CAG_fn=VMcHaGrFs_YvtBttmfuz8Rr1C_dfmKRibvPrbqeKFGCA@mail.gmail.com>
 <CACT4Y+a2bwVvDRfL=wg=5bnOv6S7RrJYoh4ygaizqVm3JpNu1A@mail.gmail.com> <279041ab-d449-1bfb-a05d-2d8b0d5c601b@iogearbox.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 30 Aug 2018 07:19:12 -0700
Message-ID: <CACT4Y+b7-oJCecsigTsN=OERGpMMQx+8GFNvD7JhN1vbNt4e+A@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in __schedule
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexander Potapenko <glider@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        syzbot+45a34334c61a8ecf661d@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 2:52 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following crash on:
>>>>>
>>>>> HEAD commit:    5b394b2ddf03 Linux 4.19-rc1
>>>>> git tree:       upstream
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14f4d8e1400000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=49927b422dcf0b29
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=45a34334c61a8ecf661d
>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13127e5a400000
>>>>>
>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>> Reported-by: syzbot+45a34334c61a8ecf661d@syzkaller.appspotmail.com
>>>>>
>>>>> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
>>>>> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
>>>>> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>>>>> 8021q: adding VLAN 0 to HW filter on device team0
>>>>> ==================================================================
>>>>> BUG: KASAN: stack-out-of-bounds in schedule_debug kernel/sched/core.c:3285
>>>>> [inline]
>>>>> BUG: KASAN: stack-out-of-bounds in __schedule+0x1977/0x1df0
>>>>> kernel/sched/core.c:3395
>>>>> Read of size 8 at addr ffff8801ad090000 by task syz-executor0/4718
>>>>
>>>> Weird, can you please help me decipher this? So here KASAN complains about
>>>> wrong memory access in the scheduler.
>>
>> This looks like a result of a previous bad silent memory corruption.
>>
>> The KASAN report says there is a stack out-of-bounds in scheduler. And
>> that if followed by slab corruption report in another task.
>>
>> fs/jbd2/transaction.c happens to be the first meaningful file in this
>> crash, and so that's where it is attributed to.
>>
>> Rerunning the reproducer several times can maybe give some better
>> glues, or maybe not, maybe they all will look equally puzzling.
>>
>> This part of the repro looks familiar:
>>
>> r1 = bpf$MAP_CREATE(0x0, &(0x7f0000002e40)={0x12, 0x0, 0x4, 0x6e, 0x0,
>> 0x1}, 0x68)
>> bpf$MAP_UPDATE_ELEM(0x2, &(0x7f0000000180)={r1, &(0x7f0000000000),
>> &(0x7f0000000140)}, 0x20)
>>
>> We had exactly such consequences of a bug in bpf map very recently,
>> but that was claimed to be fixed. Maybe not completely?
>> +bpf maintainers
>
> Looks like syzbot found this in Linus tree with HEAD commit 5b394b2ddf03 ("Linux 4.19-rc1")
> one day later net PR got merged via 050cdc6c9501 ("Merge git://git.kernel.org/pub/...").
>
> This PR contained a couple of fixes I did on sockmap code during audit such as:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b845c898b2f1ea458d5453f0fa1da6e2dfce3bb4
>
> Looking at the reproducer syzkaller found it contains:
>
>   r1 = bpf$MAP_CREATE(0x0, &(0x7f0000002e40)={0x12, 0x0, 0x4, 0x6e, 0x0, 0x1}, 0x68)
>                                                     ^^^
>
> So it found the crash with map type of sock hash and key size of 0x0 (which is invalid),
> where subsequent map update triggered the corruption. I just did a 'syz test' and it
> wasn't able to trigger the crash anymore.
>
> #syz fix: bpf, sockmap: fix sock_hash_alloc and reject zero-sized keys


Thanks.

I am again trying to figure out how/why this causes such bad failure modes.
Looking at sock_hash_ctx_update_elem it seems that all of
htab_map_hash/lookup_elem_raw/alloc_sock_hash_elem should handle
key_size=0 fine hashing/comparing/updating 0 bytes. Do you have any
ideas as to what could have gone wrong?
