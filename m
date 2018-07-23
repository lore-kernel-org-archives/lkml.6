Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA490ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5474620881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7BcRt9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5474620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388561AbeGWQVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:21:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38239 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387852AbeGWQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:21:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so614935pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AjUUPyvR0aerapMgloa/wxnWUHh9hZ9fSl1E6f0oM5s=;
        b=S7BcRt9bwqK7gzBbya8hXOmz9+n4e2YjhcwigfclAGdoELujefWEbNKsIUbCMCljRG
         2hKAyLY5ZXHpzlnAgLZplfiknJEvYxH0jd8S9s4czepVPBPRx5l+c47T2aXcU3pcQkyH
         asdPixOa82g96C/h2qMR1Wyl592uInz2TIZfX6dFw+NgzUOe030HrCsWD2uHFg+gkqg0
         U75OhHb2ejaRujZA5cUc3Kl8R4pyfvLrBjxfhA+ZnhbC+/La3vHPoZaJ3/5Im7Y0iyiM
         Pi/27WetaHur3G+sdyMrt776QNegOeb8fvy85d8c6/mktAtRkv5IzCZpPRV9BdTPBSOQ
         8C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AjUUPyvR0aerapMgloa/wxnWUHh9hZ9fSl1E6f0oM5s=;
        b=BsI6Nlk3mp5y1yTVeo6aug3ccjwSACZENH5ORbahckN27phNl5HaetB9kOV/gCzmiz
         SxL+5cX/WR0vdvtJHIIrvp09ve2X1dmpWoeuprUKrpfPou+lWC4bPVN/rc552EmQGstY
         W3lfaOf6Sa1E8uldabhhrYW2B/iwFFrSJPRXLw6878Sa0NkEh4QZ9H8aGS0WWzinFCZP
         Pd1rIHOZyffV/8ncZymem1qEtIElgpocQ+QQHPkQyhjjk4TfyaGaDV3+nTT82hkrsdrD
         FPl/dpKfnlSmJnmGVrAzdZuXYBJKFUb745izNifiNcMU+tKtW+p2vhoFPsbPpqzOVBOl
         DhgA==
X-Gm-Message-State: AOUpUlFc/B5CBUEGc+fS0G24va0CVV6cVMDmS0Apiqu50GD1Rw5yAY2t
        LuEI2NdvNVA0CvEVnbl69GgooXJu28Uw+mHTQvhXpA==
X-Google-Smtp-Source: AAOMgpegHKYTMsWjxtHwiTkvqR+mcCyidfSle6uvv7l9qjGa07m5D6X9HLpQ1BrpOPVp/N8VbxDO+a80OuXGb9TOGFg=
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr13017223pgh.216.1532359160897;
 Mon, 23 Jul 2018 08:19:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 23 Jul 2018 08:19:00
 -0700 (PDT)
In-Reply-To: <CAJfpeguni8JReXKXU_yUFqBfHav1-JFHfHzhxc=kaXu3ME6Qsw@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
 <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
 <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com>
 <CAJfpegs0by5OJ7iqtg6L3T1w2RrFRiU6yRufVNbt=tNpJCbf2A@mail.gmail.com>
 <CACT4Y+bSnJjtgeLdusj6czbH8080XfRs2b8L0V4R0TAixqxX6Q@mail.gmail.com>
 <CAJfpegvYHYUMdo14J_of10rmg0krjd_eiATJ3D4+XqaNys9bqQ@mail.gmail.com>
 <CACT4Y+Y2ec4-ywG+FWocir6XXkwt-11qD+SAFwswtG2Ng6BS4A@mail.gmail.com> <CAJfpeguni8JReXKXU_yUFqBfHav1-JFHfHzhxc=kaXu3ME6Qsw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 Jul 2018 17:19:00 +0200
Message-ID: <CACT4Y+YiGEX7_naGDTDNWCKnjQAisYrmBOYNejasfidaCRP7xA@mail.gmail.com>
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

On Mon, Jul 23, 2018 at 5:09 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Mon, Jul 23, 2018 at 3:37 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Mon, Jul 23, 2018 at 3:05 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>>> Biggest conceptual problem: your definition of fuse-server is weak.
>>> Take the following example: process A is holding the fuse device fd
>>> and is forwarding requests and replies to/from process B via a pipe.
>>> So basically A is just a proxy that does nothing interesting, the
>>> "real" server is B.  But according to your definition B is not a
>>> server, only A is.
>>
>> I proposed to abort fuse conn when all fuse device fd's are "killed"
>> (all processes having the fd opened are killed). So if _only_ process
>> B is killed, then, yes, it will still hang. However if A is killed or
>> both A and B (say, process group, everything inside of pid namespace,
>> etc) then the deadlock will be autoresolved without human
>> intervention.
>
> Okay, so you're saying:
>
> 1) when process gets SIGKILL and is uninterruptible sleep mark process as doomed
> 2) for a particular fuse instance find set of fuse device fd
> references that are in non-doomed tasks; if there are none then abort
> fuse instance
>
> Right?


Yes, something like this.
Perhaps checking for "uninterruptible sleep" is excessive. If it has
SIGKILL pending it's pretty much doomed already. This info should be
already available for tasks.
Not saying that it's better, but what I described was the other way
around: when a task killed it drops a reference to all opened fuse
fds, when the last fd is dropped, the connection can be aborted.


> The above is not an implementation proposal, just to get us on the
> same page regarding the concept.
>
>>> And this is just a simple example, parts of the server might be on
>>> different machines, etc...  It's impossible to automatically detect if
>>> a process is acting as a fuse server or not.
>>
>> It does not seem we need the precise definition. If no one ever can
>> write anything into the fd, we can safely abort the connection (?).
>
> Seems to me so.
>
>> If
>> we don't, we can either get that the process exits normally and the
>> connection is doomed anyway, so no difference in behavior, or we can
>> get a deadlock.
>>
>>> We could let the fuse server itself notify the kernel that it's a fuse
>>> server.  That might help in the cases where the deadlock is
>>> accidental, but obviously not in the case when done by a malicious
>>> agent.  I'm not sure it's worth the effort.   Also I have no idea how
>>> the respective maintainers would take the idea of "kill hooks"...   It
>>> would probably be a lot of work for little gain.
>>
>> What looks wrong to me here is that fuse is only (?) subsystem in
>> kernel that stops SIGKILL from working and requires complex custom
>> dance performed by a human operator (which is not necessary there at
>> all). Say, if a process has opened a socket, whatever, I don't need to
>> locate and abort something in socketctl fs, just SIGKILL. If a
>> processes has opened a file, I don't need to locate the fd in /proc
>> and abort it, just SIGKILL. If a process has created an ipc object, I
>> don't need to do any special dance, just SIGKILL. fuse is somehow very
>> special, if we have more such cases, it definitely won't scale.
>> I understand that there can be implementation difficulties, but
>> fundamentally that's how things should work -- choose target
>> processes, kill, done, right?
>
> Yes, it would be nice.
>
> But I'm not sure it will fly due to implementation difficulties.  It's
> definitely not  a high prio feature currently for me, but I'll happily
> accept patches.

I see. Thanks for bearing with me.
