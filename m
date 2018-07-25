Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFAEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9805720890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYBrnSLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9805720890
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeGYKXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:23:08 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41398 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbeGYKXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:23:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so3027423ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 02:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BFuqaqx6n586KjnMkNGhA15MtbnEZS/yag2dYBNfJbI=;
        b=hYBrnSLz23/9TFOAYLieXCFHZGg8WiWcl9KW6gwAU0zl2rDZIM09MEBpNVAjj9ncvc
         vnHyn6aScykM8U/i/aM5hUNPxxYxGXz3k2wCQJN514x8oyVjPmeoTgJMK8EV5reTTb1Q
         hukGhkgUtw2qaBBUqYRY5ciAJVpMxq20Fu6P31zlEus4sbGz2XFGrMCj1QKrQDQqLfvj
         IBSyWiU+GRqAdX77xaUNuTkrGqqqfT44yrhPPDIetdARrNuVKUShce+ukIBfU7udC09g
         xoKjsjE8NB/IKDWs5v1DABkCjuixqiVj2xwavDGu07iesPMh6NLDVrUguPBHmmcTJ6+d
         CVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BFuqaqx6n586KjnMkNGhA15MtbnEZS/yag2dYBNfJbI=;
        b=GX5t1j8g8AMWGQPTyKvSyIZ0RYs4WVb68CvB58WKcfWMTrnn3qm8KG9IikekWA/l1d
         hHxnsoCe/t4QnbUzlkE1OWtUjhJ9JYtsB/viz1dI2B7Z858IEw1S1JLP6BgGvjitcbKb
         50fzOmXfyscnNsk1KR+SopHq1C86cLzaIMDDjqdgluzCGHdDEGoURWr9Pgl8+yBimCBg
         eHJUWfkTrbUJXSMmwILiCMi6mWX4HnoMtflr0Ee7Y5wF7+jqPaHihb8XJxCy3on0MmuX
         4Ado2J+EWItwA4fJeQBZEqH4XD875R254Dj72mqQM3BhN1COMT9oUaNM84Tufu4i85S1
         E0jA==
X-Gm-Message-State: AOUpUlELSoPjJZdjt3Zjb/AV08x/1Jpn/VuARUBBi9+vowVGFs4OsieJ
        nTcOJOlm4PuZ/8IT0+7QzgJ9hKhqt/R6AGquRHECdg==
X-Google-Smtp-Source: AAOMgpc3OthpgD2T93/nSsDf0bXczQg/eAN9KV/zpwiUi0sBTCQ9tiik4NiVJyKAvd0jtT2UTHVTbxlPkeiAtE2fE28=
X-Received: by 2002:a17:902:d710:: with SMTP id w16-v6mr20315527ply.93.1532509941039;
 Wed, 25 Jul 2018 02:12:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 25 Jul 2018 02:12:00
 -0700 (PDT)
In-Reply-To: <CAJfpegtXhRmSTxEbvGZGUCORoxKvsjeJEfFtUEzGuC76ZE3rmA@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
 <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
 <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com>
 <CAJfpegs0by5OJ7iqtg6L3T1w2RrFRiU6yRufVNbt=tNpJCbf2A@mail.gmail.com>
 <CACT4Y+bSnJjtgeLdusj6czbH8080XfRs2b8L0V4R0TAixqxX6Q@mail.gmail.com>
 <CAJfpegvYHYUMdo14J_of10rmg0krjd_eiATJ3D4+XqaNys9bqQ@mail.gmail.com>
 <CACT4Y+Y2ec4-ywG+FWocir6XXkwt-11qD+SAFwswtG2Ng6BS4A@mail.gmail.com>
 <CAJfpeguni8JReXKXU_yUFqBfHav1-JFHfHzhxc=kaXu3ME6Qsw@mail.gmail.com>
 <CACT4Y+YiGEX7_naGDTDNWCKnjQAisYrmBOYNejasfidaCRP7xA@mail.gmail.com> <CAJfpegtXhRmSTxEbvGZGUCORoxKvsjeJEfFtUEzGuC76ZE3rmA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 25 Jul 2018 11:12:00 +0200
Message-ID: <CACT4Y+ZZ_v6izsiCGym=r+MiRmxaFE=eH54dz7t0BOQ7VxTNiw@mail.gmail.com>
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

On Tue, Jul 24, 2018 at 5:17 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>> Biggest conceptual problem: your definition of fuse-server is weak.
>>>>> Take the following example: process A is holding the fuse device fd
>>>>> and is forwarding requests and replies to/from process B via a pipe.
>>>>> So basically A is just a proxy that does nothing interesting, the
>>>>> "real" server is B.  But according to your definition B is not a
>>>>> server, only A is.
>>>>
>>>> I proposed to abort fuse conn when all fuse device fd's are "killed"
>>>> (all processes having the fd opened are killed). So if _only_ process
>>>> B is killed, then, yes, it will still hang. However if A is killed or
>>>> both A and B (say, process group, everything inside of pid namespace,
>>>> etc) then the deadlock will be autoresolved without human
>>>> intervention.
>>>
>>> Okay, so you're saying:
>>>
>>> 1) when process gets SIGKILL and is uninterruptible sleep mark process as doomed
>>> 2) for a particular fuse instance find set of fuse device fd
>>> references that are in non-doomed tasks; if there are none then abort
>>> fuse instance
>>>
>>> Right?
>>
>>
>> Yes, something like this.
>> Perhaps checking for "uninterruptible sleep" is excessive. If it has
>> SIGKILL pending it's pretty much doomed already. This info should be
>> already available for tasks.
>> Not saying that it's better, but what I described was the other way
>> around: when a task killed it drops a reference to all opened fuse
>> fds, when the last fd is dropped, the connection can be aborted.
>
> struct task_struct {
> [...]
>     struct files_struct        *files;
> [...]
> };
>
> struct files_struct {
> [...]
>     struct fdtable __rcu *fdt;
> [...]
> };
>
> struct fdtable {
> [...]
>     struct file __rcu **fd;      /* current fd array */
> [...]
> };
>
> So there we have an array of pointers to struct files.  Suppose we'd
> magically be able to find files that point to fuse devices upon
> receiving SIGKILL, what would we do with them?  We can't close them:
> other tasks might still be pointing to the same files_struct.
>
> We could do a global search for non-doomed tasks referencing the same
> fuse device, but I have no clue how we'd go about doing that without
> racing with forks, fd sending, etc...


Good questions for which I don't have answers.

Maybe more waits in fuse need to be interruptible? E.g. request_wait_answer?
