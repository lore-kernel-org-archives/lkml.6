Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA0AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0042195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="mwNp/uzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389338AbeLVTHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:07:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54890 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbeLVTHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:07:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so8156961wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 11:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=a7Ldk9zEQDziUqDFDSx0CQIpB1gzF4eBck12WXp0Iew=;
        b=mwNp/uzuRRBtCzli2TDERZVGMKxBcuRxm5duWoQN8l2QbbUKWeVdHCnQIJVIY2mxV1
         0NWPQXE4lE0hTr7KhC71/qvnnDKHvxSTFtNuojd0/hKb/Xh9xXsxFCYyM+8CZi865mOl
         bOHzAh3uk+kq0tWaz8tGa62kV5VZbVJVgdke85sBy/PyH+a8+P5+VNrkJJzJOJqWT7cu
         Diu1hEnDTKarBDXukQTl9i902XCb8xTMzQX40MGX94j2/ezhM3EjH5MNzDLSIgqxaP/b
         T7Nm/X8hQkVQxezVqv3vjHjPi20y/crKPO4GozpKvC7GAJ4jyzJ1xFLjSc7gbffsAu6c
         TNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=a7Ldk9zEQDziUqDFDSx0CQIpB1gzF4eBck12WXp0Iew=;
        b=ADYhy978a4GEh+XPiTc7TaJ9XPxa44SWLVbdT/Hj7lpvI09Rrnobsb36hPjuV3D9Ju
         I0qcZeENXmY91hJIv1EWwzjMcszU8ZryreXz9xAKh6cNtVGID8HxaN8NyQFbAmYrx/6f
         zSIULIaIrxOAi7UAzkbh/DqV51jU7IGPwqP2D4F0f1nNAcqYlvl9WMkCutW7f+Mrvl4S
         jxlMOKmumiMQMLmwQxmIN5TFPlzskw+wdN4ORExLVnxnS+K8sf4R/A2zDj6+C3rjeqJ6
         I9Yv556hmQ6Vg+ICfPtb+TF2oRc1u3AgW1/ANARet/eHx0odxXF3N8LaW15MeDjaKSqL
         UjYw==
X-Gm-Message-State: AA+aEWZwWS/orBy+o7THl+ntWD2j/JF+mo52JGzduGKmu9z9lAVQIXqD
        1wWWlIpeaxXfdc9lKpQImA6+Iw==
X-Google-Smtp-Source: AFSGD/W/s1rp6dBxQ6rcUpJapjI12ZocV+4wRMLDKBnSYPOKwp4hfaQa2A+T/1axrsNL4ledWkditg==
X-Received: by 2002:a1c:5892:: with SMTP id m140mr7228131wmb.60.1545505653578;
        Sat, 22 Dec 2018 11:07:33 -0800 (PST)
Received: from linux.fritz.box (p200300D993F675004C4DDF6F0E256EAC.dip0.t-ipconnect.de. [2003:d9:93f6:7500:4c4d:df6f:e25:6eac])
        by smtp.googlemail.com with ESMTPSA id y145sm13970412wmd.30.2018.12.22.11.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 11:07:32 -0800 (PST)
Subject: Re: general protection fault in put_pid
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ktsanaktsidis@zendesk.com, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <00000000000051ee78057cc4d98f@google.com>
 <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
 <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com>
 <CACT4Y+Y-c7FgSTKyHqpRZu3eKLo5QfXy10axTSwWkU4MUgjFgw@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <87614226-e895-c3a3-3626-b0fbe7e191be@colorfullife.com>
Date:   Sat, 22 Dec 2018 20:07:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y-c7FgSTKyHqpRZu3eKLo5QfXy10axTSwWkU4MUgjFgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 12/20/18 4:36 PM, Dmitry Vyukov wrote:
> On Wed, Dec 19, 2018 at 10:04 AM Manfred Spraul
> <manfred@colorfullife.com> wrote:
>> Hello Dmitry,
>>
>> On 12/12/18 11:55 AM, Dmitry Vyukov wrote:
>>> On Tue, Dec 11, 2018 at 9:23 PM syzbot
>>> <syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com> wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=135bc547400000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16803afb400000
>>> +Manfred, this looks similar to the other few crashes related to
>>> semget$private(0x0, 0x4000, 0x3f) that you looked at.
>> I found one unexpected (incorrect?) locking, see the attached patch.
>>
>> But I doubt that this is the root cause of the crashes.
>
> But why? These one-off sporadic crashes reported by syzbot looks
> exactly like a subtle race and your patch touches sem_exit_ns involved
> in all reports.
> So if you don't spot anything else, I would say close these 3 reports
> with this patch (I see you already included Reported-by tags which is
> great!) and then wait for syzbot reaction. Since we got 3 of them, if
> it's still not fixed I would expect that syzbot will be able to
> retrigger this later again.

As I wrote, unless semop() is used, sma->use_global_lock is always 9 and 
nothing can happen.

Every single-operation semop() reduces use_global_lock by one, i.e a 
single semop call as done here cannot trigger the bug:

https://syzkaller.appspot.com/text?tag=ReproSyz&x=16803afb400000


But, one more finding:

https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac

https://syzkaller.appspot.com/text?tag=CrashLog&x=109ecf6e400000

The log file contain 1080 lines like these:

> semget$private(..., 0x4003, ...)
>
> semget$private(..., 0x4006, ...)
>
> semget$private(..., 0x4007, ...)

It ends up as kmalloc(128*0x400x), i.e. slightly more than 2 MB, an 
allocation in the 4 MB kmalloc buffer:

> [ 1201.210245] kmalloc-4194304      4698112KB    4698112KB
>
i.e.: 1147 4 MB kmalloc blocks --> are we leaking nearly 100% of the 
semaphore arrays??


This one looks similar:

https://syzkaller.appspot.com/bug?extid=c92d3646e35bc5d1a909

except that the array sizes are mixed, and thus there are kmalloc-1M and 
kmalloc-2M as well.

(and I did not count the number of semget calls)


The test apps use unshare(CLONE_NEWNS) and unshare(CLONE_NEWIPC), correct?

I.e. no CLONE_NEWUSER.

https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L1523


--

     Manfred


