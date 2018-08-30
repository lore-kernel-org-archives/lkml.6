Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C4DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA82420834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0Kl9BNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA82420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeH3Tnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:43:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39933 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeH3Tnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:43:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id g20-v6so4062127pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=txBJeDIQwZQ7AwCG5uPohPAPgsLya5REsTuFqq2PsWo=;
        b=X0Kl9BNavLYFYr/ZlKIlR8PYksfxA57YwLFtedaxAikYc/pdWeGczN0ZdVwa8Exd89
         nOzeyxkNYTDiycuyGGmvRjofUud4xK5hcDajE4IhXL6m3ux2apCeM0mpYd7Bn4U1dvbc
         dLPqFu8rVdfTEGSVMVHe5IB5ZOsg3l2UAWopDP7ojCG1OmX4lnQRPT586zM0AQIzA05Q
         cFeKfcAE/aZ4ylVQFE83TwPJTzGH+lQs3O8drMXbLY4aADfVTDmEqTzBY/2kbaC7qL0J
         YYeW1MYyo02LnAqxTFBIUu2Jem9SVjAldHt1jdVvFn1KOYW1NUjBHnGMrSI1WXe+o+MN
         D29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=txBJeDIQwZQ7AwCG5uPohPAPgsLya5REsTuFqq2PsWo=;
        b=qvsEQeDEIlK7iF61EpdDVd2xvNT16fZ22irATXsWW5WfWsifHueCVMFmeEWOZ/fIgs
         FslkdysEtcbbCh2Em4g+yZ9hBQFN83QVqHJ9SFaaGUSuhF2Uj6hKD34zcjdvqGxklJzv
         B1L3jjx2SXllEDN3GdlMnxVHj4QUWSm5+7zzyqt2qbUuDpBLv5RX5e5Iyebg+XtxVKA1
         EEExD0AOf2O4LzgyejsaWNE9CI01qdOibqzmRwdozOo78rpYqjH7d+uS5w/aiDskDLkH
         GPMmpKpiJn81ZT4bzXuLXcpBwrP/CFP0ceTSLEu8XI6k3zsfHURLiaWBcw1tXxhtp8w4
         2GZQ==
X-Gm-Message-State: APzg51CA5k/mvapWEZd93+uREP29QSyYpjekb5P516NaxcfNIfHFGEO7
        CA67K9gqJIhthRFqruoLlD6jf+oSg7aBmjAvG3xH9A==
X-Google-Smtp-Source: ANB0VdagaA3thX/XBJ3fm/43cW7vVcYQVZyBaz5Ii0HhMhCm+Wf99pbxYPmGCpHf4AxOpOCwLOFlo/tVsChABOvSpPw=
X-Received: by 2002:a63:4702:: with SMTP id u2-v6mr9898245pga.95.1535643655251;
 Thu, 30 Aug 2018 08:40:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 30 Aug 2018 08:40:34
 -0700 (PDT)
In-Reply-To: <CACT4Y+b7-oJCecsigTsN=OERGpMMQx+8GFNvD7JhN1vbNt4e+A@mail.gmail.com>
References: <000000000000fef39305748083ae@google.com> <20180829134620.GD7369@quack2.suse.cz>
 <CAG_fn=VMcHaGrFs_YvtBttmfuz8Rr1C_dfmKRibvPrbqeKFGCA@mail.gmail.com>
 <CACT4Y+a2bwVvDRfL=wg=5bnOv6S7RrJYoh4ygaizqVm3JpNu1A@mail.gmail.com>
 <279041ab-d449-1bfb-a05d-2d8b0d5c601b@iogearbox.net> <CACT4Y+b7-oJCecsigTsN=OERGpMMQx+8GFNvD7JhN1vbNt4e+A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 30 Aug 2018 08:40:34 -0700
Message-ID: <CACT4Y+YpGhJdi4MowaWBvqCmt7fUu2srjPhip6zJ5a7mgHOPgg@mail.gmail.com>
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

On Thu, Aug 30, 2018 at 7:19 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Aug 30, 2018 at 2:52 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following crash on:
>>>>>>
>>>>>> HEAD commit:    5b394b2ddf03 Linux 4.19-rc1
>>>>>> git tree:       upstream
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14f4d8e1400000
>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=49927b422dcf0b29
>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=45a34334c61a8ecf661d
>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13127e5a400000
>>>>>>
>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>>> Reported-by: syzbot+45a34334c61a8ecf661d@syzkaller.appspotmail.com
>>>>>>
>>>>>> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
>>>>>> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
>>>>>> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>>>>>> 8021q: adding VLAN 0 to HW filter on device team0
>>>>>> ==================================================================
>>>>>> BUG: KASAN: stack-out-of-bounds in schedule_debug kernel/sched/core.c:3285
>>>>>> [inline]
>>>>>> BUG: KASAN: stack-out-of-bounds in __schedule+0x1977/0x1df0
>>>>>> kernel/sched/core.c:3395
>>>>>> Read of size 8 at addr ffff8801ad090000 by task syz-executor0/4718
>>>>>
>>>>> Weird, can you please help me decipher this? So here KASAN complains about
>>>>> wrong memory access in the scheduler.
>>>
>>> This looks like a result of a previous bad silent memory corruption.
>>>
>>> The KASAN report says there is a stack out-of-bounds in scheduler. And
>>> that if followed by slab corruption report in another task.
>>>
>>> fs/jbd2/transaction.c happens to be the first meaningful file in this
>>> crash, and so that's where it is attributed to.
>>>
>>> Rerunning the reproducer several times can maybe give some better
>>> glues, or maybe not, maybe they all will look equally puzzling.
>>>
>>> This part of the repro looks familiar:
>>>
>>> r1 = bpf$MAP_CREATE(0x0, &(0x7f0000002e40)={0x12, 0x0, 0x4, 0x6e, 0x0,
>>> 0x1}, 0x68)
>>> bpf$MAP_UPDATE_ELEM(0x2, &(0x7f0000000180)={r1, &(0x7f0000000000),
>>> &(0x7f0000000140)}, 0x20)
>>>
>>> We had exactly such consequences of a bug in bpf map very recently,
>>> but that was claimed to be fixed. Maybe not completely?
>>> +bpf maintainers
>>
>> Looks like syzbot found this in Linus tree with HEAD commit 5b394b2ddf03 ("Linux 4.19-rc1")
>> one day later net PR got merged via 050cdc6c9501 ("Merge git://git.kernel.org/pub/...").
>>
>> This PR contained a couple of fixes I did on sockmap code during audit such as:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b845c898b2f1ea458d5453f0fa1da6e2dfce3bb4
>>
>> Looking at the reproducer syzkaller found it contains:
>>
>>   r1 = bpf$MAP_CREATE(0x0, &(0x7f0000002e40)={0x12, 0x0, 0x4, 0x6e, 0x0, 0x1}, 0x68)
>>                                                     ^^^
>>
>> So it found the crash with map type of sock hash and key size of 0x0 (which is invalid),
>> where subsequent map update triggered the corruption. I just did a 'syz test' and it
>> wasn't able to trigger the crash anymore.
>>
>> #syz fix: bpf, sockmap: fix sock_hash_alloc and reject zero-sized keys


This crash looks related:
https://groups.google.com/d/msg/syzkaller-bugs/luviyHUQ9N4/dmgK2OmLBAAJ
