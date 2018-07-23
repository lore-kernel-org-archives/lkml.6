Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702AFECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F16A2089A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8gts/QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F16A2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbeGWNX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:23:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46299 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbeGWNX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:23:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so257436pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UhpfyV0vupGIAoVBD4WxS43npYMzWVhRjU2QYbmw3wE=;
        b=p8gts/QAWugczV1k6vm5EmNdZNklNNMVkDmajaJb3Nc8RNKIELgtViNgTFs+IVI4ba
         U0wmAtI1+6aqP1w53lQOd1LiKwRAXjOlOfbeo9s2fJ9MRSSZTlCDa4Fbq1XDbncUdwGh
         Ga7bIFVcKRF2OwixfqO1lWmiB3ZfRH28SaxJ2TdghO5t1K8lFRcLieYXXXtYFLX5yyZO
         NI1kJvwryASR/a5lIt1LHu1kXf3njjycW2TWkZpJmbpK++YIroaXuozMw7og1PDxIkLU
         OMKgr3FATLzu7tzC2b6M0hf4M0pESL8Jdy26LJFzoqZy9osDGHbVrMe+DxQqI0+MxLQT
         C04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UhpfyV0vupGIAoVBD4WxS43npYMzWVhRjU2QYbmw3wE=;
        b=LQL0Mxw8d39haxtFG4Svs4kEbN+ks77KLQOUcKUx+3W2rRv15gRWk17Pxtekb+vGuA
         hLGDMEmnH5zDlLNiV2nfF7bdaLQUHHTypxhk9MZjOViHfS2XOZo/5DA0Uka39mo1HK9T
         L/C+RsCDzDI0xEVMl/JILyj69AY+wxeWLGrV0LtF1gx3gpKKOkzW2RjJBl3aOkxP93Yo
         qbTAsCiSWdbFQasidH3TKf+Nsxu5pMzLTMocshmq2s7cNlo5y5Zhr3zF6S/G6UnHyMq1
         +M4azu+ZoAGpgmdREi1r16mvBi9Da2DJcLlR0RrzrNXxvkdSh2w+u/6B+co7IF8mIUfQ
         nkjQ==
X-Gm-Message-State: AOUpUlEj8htJnCc3FpiNaHcySzAYR/dWiDa032/ueY9XUcgeVOydxjLt
        OkhGwvX1EB667HmfQWWMPRrrnFDUu1RF5ayKUzT0onlu
X-Google-Smtp-Source: AAOMgpcRYBWXFQSv0ITjvSRhjM1dzaR1y0XHZsq/XCXSS1RAjyqQT5lDcBXnI+6R3bX2+zge9tuH9FwMtGdrhwQdWzw=
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr11890029pgu.96.1532348551603;
 Mon, 23 Jul 2018 05:22:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 23 Jul 2018 05:22:11
 -0700 (PDT)
In-Reply-To: <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
 <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 Jul 2018 14:22:11 +0200
Message-ID: <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com>
Subject: Re: INFO: task hung in fuse_reverse_inval_entry
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 2:12 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Mon, Jul 23, 2018 at 10:11 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Mon, Jul 23, 2018 at 9:59 AM, syzbot
>> <syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    d72e90f33aa4 Linux 4.18-rc6
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1324f794400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=68af3495408deac5
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bb6d800770577a083f8c
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11564d1c400000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc570c400000
>>
>>
>> Hi fuse maintainers,
>>
>> We are seeing a bunch of such deadlocks in fuse on syzbot. As far as I
>> understand this is mostly working-as-intended (parts about deadlocks
>> in Documentation/filesystems/fuse.txt). The intended way to resolve
>> this is aborting connections via fusectl, right?
>
> Yes.  Alternative is with "umount -f".
>
>> The doc says "Under
>> the fuse control filesystem each connection has a directory named by a
>> unique number". The question is: if I start a process and this process
>> can mount fuse, how do I kill it? I mean: totally and certainly get
>> rid of it right away? How do I find these unique numbers for the
>> mounts it created?
>
> It is the device number found in st_dev for the mount.  Other than
> doing stat(2) it is possible to find out the device number by reading
> /proc/$PID/mountinfo  (third field).

Thanks. I will try to figure out fusectl connection numbers and see if
it's possible to integrate aborting into syzkaller.

>> Taking into account that there is usually no
>> operator attached to each server, I wonder if kernel could somehow
>> auto-abort fuse on kill?
>
> Depends on what the fuse server is sleeping on.   If it's trying to
> acquire an inode lock (e.g. unlink(2)), which is classical way to
> deadlock a fuse filesystem, then it will go into an uninterruptible
> sleep.  There's no way in which that process can be killed except to
> force a release of the offending lock, which can only be done by
> aborting the request that is being performed while holding that lock.

I understand that it is not killed today, but I am asking if we can
make it killable. It's all code that we can change, and if a human
operator can do it, it can be done pure programmatically on kill too,
right?
