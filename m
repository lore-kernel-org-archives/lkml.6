Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABF0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F6020685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E53zWqLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F6020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389702AbeGWNsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37717 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388694AbeGWNsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so320459pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/5YxtGZgTCmQKm0sbyWEDDDFMeqig/MjaP6JxIx331U=;
        b=E53zWqLNbiHkTDZ0yhHVHQiYaNvGUS4vKi2NS67zQgKbYvkG3tDwKZ+BpdpN2o5yqf
         gpBn8hGImoRnoWPEuyBn80m41UKaYzMb8kKA6lap1Z/OgtIxlTYvBL2WwfBzEKUXGV0t
         q5q6lZrL2ZATSHRrR2Y52QtAAPjjX6clRhlReNDi2BqcU51mJ+6qlaHK/iqJf7r9tLdj
         4nRs9UluFfnwB5OxYh5H23U+c1xNITyUHMIs1fBE3uiWJzorbclf3EBxgThN0HjtAGop
         LuPBJ4yv1Mo82bXr81NG76ET2p+cys9JwKQ401FdWpqkGSW/5Y+N6OxiP8jjDKmBaOUj
         sSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/5YxtGZgTCmQKm0sbyWEDDDFMeqig/MjaP6JxIx331U=;
        b=jdYYuyeVVUVJoPhdBdrqL+HDbuJw4aiL1KBDcWn/wP12hbBUwBDcFuPgQRP1F/jAqe
         FL4VGE/UdgfTB2wo8G94wad6AebM3GAZAhmqMwEr5vPIOh+CKyAAo2aljRQcfYDAOhjE
         TEYo0ZWdTkWus7X13pHDT6DGvFbfVgh7QVMfeMcdStvIbOG5RuVYp1lV6lIgmlJBIQcN
         1SZRvRfyG6eToXB3RCr7ZRmBHicvX0/W4xV0qhjpGsJqVGQp59qoRXqs5ywKaBTYwTZ5
         b/cD5y7xLwl6ICUiv1nmvpSMl2kufoABRDjuCFq08qKnC64tzYi7NCJ8lU0FmJ4D03A+
         dTgA==
X-Gm-Message-State: AOUpUlFLEwES5JxaBSEWtwXwEOnN1r4tn/qFZaaUV7agKKXoSxI24dss
        B7TxB+aXqdoVbK25mxjiDzRpAgPjn7LXH4g3wdgOvihx
X-Google-Smtp-Source: AAOMgpc9RxleGql9h8+Oycqpknt0eXdW5UPyOUjKLdl7h7bWMMC/qPXq2B/y9T86NWeoozFn96HiOYpk7zy8CcTqGss=
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr12477735pgh.216.1532350025109;
 Mon, 23 Jul 2018 05:47:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 23 Jul 2018 05:46:44
 -0700 (PDT)
In-Reply-To: <CAJfpegs0by5OJ7iqtg6L3T1w2RrFRiU6yRufVNbt=tNpJCbf2A@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
 <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
 <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com> <CAJfpegs0by5OJ7iqtg6L3T1w2RrFRiU6yRufVNbt=tNpJCbf2A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 Jul 2018 14:46:44 +0200
Message-ID: <CACT4Y+bSnJjtgeLdusj6czbH8080XfRs2b8L0V4R0TAixqxX6Q@mail.gmail.com>
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

On Mon, Jul 23, 2018 at 2:33 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>> On Mon, Jul 23, 2018 at 9:59 AM, syzbot
>>>> <syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com> wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following crash on:
>>>>>
>>>>> HEAD commit:    d72e90f33aa4 Linux 4.18-rc6
>>>>> git tree:       upstream
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1324f794400000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=68af3495408deac5
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bb6d800770577a083f8c
>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11564d1c400000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc570c400000
>>>>
>>>>
>>>> Hi fuse maintainers,
>>>>
>>>> We are seeing a bunch of such deadlocks in fuse on syzbot. As far as I
>>>> understand this is mostly working-as-intended (parts about deadlocks
>>>> in Documentation/filesystems/fuse.txt). The intended way to resolve
>>>> this is aborting connections via fusectl, right?
>>>
>>> Yes.  Alternative is with "umount -f".
>>>
>>>> The doc says "Under
>>>> the fuse control filesystem each connection has a directory named by a
>>>> unique number". The question is: if I start a process and this process
>>>> can mount fuse, how do I kill it? I mean: totally and certainly get
>>>> rid of it right away? How do I find these unique numbers for the
>>>> mounts it created?
>>>
>>> It is the device number found in st_dev for the mount.  Other than
>>> doing stat(2) it is possible to find out the device number by reading
>>> /proc/$PID/mountinfo  (third field).
>>
>> Thanks. I will try to figure out fusectl connection numbers and see if
>> it's possible to integrate aborting into syzkaller.
>>
>>>> Taking into account that there is usually no
>>>> operator attached to each server, I wonder if kernel could somehow
>>>> auto-abort fuse on kill?
>>>
>>> Depends on what the fuse server is sleeping on.   If it's trying to
>>> acquire an inode lock (e.g. unlink(2)), which is classical way to
>>> deadlock a fuse filesystem, then it will go into an uninterruptible
>>> sleep.  There's no way in which that process can be killed except to
>>> force a release of the offending lock, which can only be done by
>>> aborting the request that is being performed while holding that lock.
>>
>> I understand that it is not killed today, but I am asking if we can
>> make it killable. It's all code that we can change, and if a human
>> operator can do it, it can be done pure programmatically on kill too,
>> right?
>
> Hmm, you mean if a process is in an uninterruptible sleep trying to
> acquire a lock on a fuse filesystem and is killed, then the fuse
> filesystem should be aborted?
>
> Even if we'd manage to implement that, it's a large backward
> incompatibility risk.
>
> I don't argue that it can be done, but I would definitely argue *if*
> it should be done.


I understand that we should abort only if we are sure that it's
actually deadlocked and there is no other way.
So if fuse-user process is blocked on fuse lock, then we probably
should do nothing. However, if the fuse-server is killed, then perhaps
we could abort the connection at that point. Namely, if a process that
has a fuse fd open is killed and it is the only process that shared
this fd, then we could abort the connection on arrival of the kill
signal (rather than wait untill all it's threads finish and then start
closing all fd's, this is where we get the deadlock -- some of its
threads won't finish). I don't know if such synchronous kill hook is
available, though. If several processes shared the same fuse fd, then
we could close the fd in each process on SIGKILL arrival, then when
all of these processes are killed, fuse fd will be closed and we can
abort the connection, which will un-deadlock all of these processes.
Does this look any reasonable?
