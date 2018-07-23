Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462BC20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmJsNnVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462BC20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbeGWOi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:38:59 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33013 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387871AbeGWOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:38:58 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so251497plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D4uZZWNzdtLQRfVcOmn79Hs1Zy6g2vxbe3X1mVJYdoE=;
        b=LmJsNnVwt+BaMkpP0rsxZpIhDbh6AOKaVknDLVukOFxw4G+iHpQpCWJ6SdVkuCHEnw
         VYewCHAWJxGFP5mwxrWRqaa33zd9n/J+2eprjAkCLliGQHIvewSbPpW3wmysmiFZVAdP
         K2igcc16SLX9UNaXUqqTXY17S4eCJqH1pQArUI0qVPHaW8nzcyJiFfq2V73lbmVppNwV
         y56bgpwMLjvj+03+wpR1Eo9ics41mp/7/MXPcqsfm0F/5HL20BljbVq+kSiqbksFtaxX
         9eFLxpORXAl3DqOM/mwCh2IrZ5/TTM1dmtjkW3rMr+laBJZ/MxWxgHvCOSF9d4G1RAPB
         R6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D4uZZWNzdtLQRfVcOmn79Hs1Zy6g2vxbe3X1mVJYdoE=;
        b=sKrOXr7XC7m7PpW5I/3j1aaqyukYEupf+HT1B/A2tnU5V+CWxOkAZUHMol8kwFHcvs
         KjxktV+aucN3QeSPMTvIXS3pXY8/E5xLHdZ9bYFk+SXRo4r+uo3JtvHv6ZgECep3bFCC
         GHXcwXF6PSfFRLDTBDg8qama1m1Z2s64TyqVxgymycSo0ffRzFe7fDm+RbY41vTlsHwK
         D7r/WQ3jC/iXhwtn/BHtiP4WI8liv/tWLbmzYD+Fdv86WZbd4zXqzrzXt1KacwXdc6KB
         HoT56WeOyjttN1Jt5mWRn2XdxPBfXXjfsPvZpaJGC3ojd9GxW9CSf219yY8CiDfHTqEg
         /sAQ==
X-Gm-Message-State: AOUpUlF1U3ndWQP+ix6mEjtzNIUWEukqE2bcfJJxvNyTfDutP1lheJDv
        iA8wu5buw8BdbS1xqcFQay4rceuiG0jcugcNlpHK0g==
X-Google-Smtp-Source: AAOMgpetbDyF1H0Qr1OqyuFLKN4U3OpS7qSSJiE7sjdTyxNw6V3qKqctn0RC4rcEEPy6QyATTihPROxkKVPObWl7lLc=
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr13129891pll.85.1532353059804;
 Mon, 23 Jul 2018 06:37:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 23 Jul 2018 06:37:19
 -0700 (PDT)
In-Reply-To: <CAJfpegvYHYUMdo14J_of10rmg0krjd_eiATJ3D4+XqaNys9bqQ@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
 <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
 <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com>
 <CAJfpegs0by5OJ7iqtg6L3T1w2RrFRiU6yRufVNbt=tNpJCbf2A@mail.gmail.com>
 <CACT4Y+bSnJjtgeLdusj6czbH8080XfRs2b8L0V4R0TAixqxX6Q@mail.gmail.com> <CAJfpegvYHYUMdo14J_of10rmg0krjd_eiATJ3D4+XqaNys9bqQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 Jul 2018 15:37:19 +0200
Message-ID: <CACT4Y+Y2ec4-ywG+FWocir6XXkwt-11qD+SAFwswtG2Ng6BS4A@mail.gmail.com>
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

On Mon, Jul 23, 2018 at 3:05 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>>> <syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com> wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> syzbot found the following crash on:
>>>>>>>
>>>>>>> HEAD commit:    d72e90f33aa4 Linux 4.18-rc6
>>>>>>> git tree:       upstream
>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1324f794400000
>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=68af3495408deac5
>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bb6d800770577a083f8c
>>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11564d1c400000
>>>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc570c400000
>>>>>>
>>>>>>
>>>>>> Hi fuse maintainers,
>>>>>>
>>>>>> We are seeing a bunch of such deadlocks in fuse on syzbot. As far as I
>>>>>> understand this is mostly working-as-intended (parts about deadlocks
>>>>>> in Documentation/filesystems/fuse.txt). The intended way to resolve
>>>>>> this is aborting connections via fusectl, right?
>>>>>
>>>>> Yes.  Alternative is with "umount -f".
>>>>>
>>>>>> The doc says "Under
>>>>>> the fuse control filesystem each connection has a directory named by a
>>>>>> unique number". The question is: if I start a process and this process
>>>>>> can mount fuse, how do I kill it? I mean: totally and certainly get
>>>>>> rid of it right away? How do I find these unique numbers for the
>>>>>> mounts it created?
>>>>>
>>>>> It is the device number found in st_dev for the mount.  Other than
>>>>> doing stat(2) it is possible to find out the device number by reading
>>>>> /proc/$PID/mountinfo  (third field).
>>>>
>>>> Thanks. I will try to figure out fusectl connection numbers and see if
>>>> it's possible to integrate aborting into syzkaller.
>>>>
>>>>>> Taking into account that there is usually no
>>>>>> operator attached to each server, I wonder if kernel could somehow
>>>>>> auto-abort fuse on kill?
>>>>>
>>>>> Depends on what the fuse server is sleeping on.   If it's trying to
>>>>> acquire an inode lock (e.g. unlink(2)), which is classical way to
>>>>> deadlock a fuse filesystem, then it will go into an uninterruptible
>>>>> sleep.  There's no way in which that process can be killed except to
>>>>> force a release of the offending lock, which can only be done by
>>>>> aborting the request that is being performed while holding that lock.
>>>>
>>>> I understand that it is not killed today, but I am asking if we can
>>>> make it killable. It's all code that we can change, and if a human
>>>> operator can do it, it can be done pure programmatically on kill too,
>>>> right?
>>>
>>> Hmm, you mean if a process is in an uninterruptible sleep trying to
>>> acquire a lock on a fuse filesystem and is killed, then the fuse
>>> filesystem should be aborted?
>>>
>>> Even if we'd manage to implement that, it's a large backward
>>> incompatibility risk.
>>>
>>> I don't argue that it can be done, but I would definitely argue *if*
>>> it should be done.
>>
>>
>> I understand that we should abort only if we are sure that it's
>> actually deadlocked and there is no other way.
>> So if fuse-user process is blocked on fuse lock, then we probably
>> should do nothing. However, if the fuse-server is killed, then perhaps
>> we could abort the connection at that point. Namely, if a process that
>> has a fuse fd open is killed and it is the only process that shared
>> this fd, then we could abort the connection on arrival of the kill
>> signal (rather than wait untill all it's threads finish and then start
>> closing all fd's, this is where we get the deadlock -- some of its
>> threads won't finish). I don't know if such synchronous kill hook is
>> available, though. If several processes shared the same fuse fd, then
>> we could close the fd in each process on SIGKILL arrival, then when
>> all of these processes are killed, fuse fd will be closed and we can
>> abort the connection, which will un-deadlock all of these processes.
>> Does this look any reasonable?
>
> Biggest conceptual problem: your definition of fuse-server is weak.
> Take the following example: process A is holding the fuse device fd
> and is forwarding requests and replies to/from process B via a pipe.
> So basically A is just a proxy that does nothing interesting, the
> "real" server is B.  But according to your definition B is not a
> server, only A is.

I proposed to abort fuse conn when all fuse device fd's are "killed"
(all processes having the fd opened are killed). So if _only_ process
B is killed, then, yes, it will still hang. However if A is killed or
both A and B (say, process group, everything inside of pid namespace,
etc) then the deadlock will be autoresolved without human
intervention.

> And this is just a simple example, parts of the server might be on
> different machines, etc...  It's impossible to automatically detect if
> a process is acting as a fuse server or not.

It does not seem we need the precise definition. If no one ever can
write anything into the fd, we can safely abort the connection (?). If
we don't, we can either get that the process exits normally and the
connection is doomed anyway, so no difference in behavior, or we can
get a deadlock.

> We could let the fuse server itself notify the kernel that it's a fuse
> server.  That might help in the cases where the deadlock is
> accidental, but obviously not in the case when done by a malicious
> agent.  I'm not sure it's worth the effort.   Also I have no idea how
> the respective maintainers would take the idea of "kill hooks"...   It
> would probably be a lot of work for little gain.

What looks wrong to me here is that fuse is only (?) subsystem in
kernel that stops SIGKILL from working and requires complex custom
dance performed by a human operator (which is not necessary there at
all). Say, if a process has opened a socket, whatever, I don't need to
locate and abort something in socketctl fs, just SIGKILL. If a
processes has opened a file, I don't need to locate the fd in /proc
and abort it, just SIGKILL. If a process has created an ipc object, I
don't need to do any special dance, just SIGKILL. fuse is somehow very
special, if we have more such cases, it definitely won't scale.
I understand that there can be implementation difficulties, but
fundamentally that's how things should work -- choose target
processes, kill, done, right?
