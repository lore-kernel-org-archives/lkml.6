Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A55C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDC22082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNx22Z5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDC22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeKCEjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:39:55 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52155 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeKCEjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:39:55 -0400
Received: by mail-it1-f193.google.com with SMTP id h13so4684715itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IlJ7Js4FnCaUqfAF1jGQAt9i057licATsE4kCOqOQTA=;
        b=FNx22Z5QOCVK1W6R1d215O7NpwQxjuqYqwJI3MaNOi0av/D4uJs5Om2FyLsH1ur1Qj
         4co/Z+fEU/4UJXsIpOyz4DOUwinsjt3uwntMr71nGeUR8Ky805JAjRuPxuDw/myBLUuq
         mY086/gxuDGmWupl6N6SyZBBVu80oSLAKzC9b3jojhUHLmtduH12iRZj8MJMQy7lE5x5
         Qx7tLzvkJIqN47xCj2Trx2uQzkHD6uDafmo1BAEEf6aoHqiYeSkPUSf98MYEExGtgBaX
         t6Om2TJHJNm+KZPbiAwrLcthzIKJZh2hWrjGbYW/cLPukwceVZ0psPj78Ad7KbZFXm4n
         7PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IlJ7Js4FnCaUqfAF1jGQAt9i057licATsE4kCOqOQTA=;
        b=eTELiZ4klSLbarJOTqGPcfjnsO0j9PDXP1pMijsEeS0EZtCgdhuIe2z52ZZGO7122K
         NAq8dD8DhtQz1MxqXE6dhInvu/uXOu2yXgMuSgRdsVCKbMatqnyotXTKhRuyeViql3L9
         gnkItB+fX1OhSJT8Ebvxw4uVnDkFkkBP42bLuWbu+hC+9b830mM/uTafDZzLE1lylV7P
         9Ie7vGgA6pqgZHdttYoPxxFUm8sHpE3T9AWAfi0MJusLUcNH7linXIHxE2iQ+0QqE4rx
         o6h+MX6FOkCsalJqd1dYyAKPNwLMJ7NCJR4fMlL2kOsVhPe0/B/Ncl/Zh8oYcImLAmvu
         4bKw==
X-Gm-Message-State: AGRZ1gJXkvl9b9GTai3rjYyIgr+oiEN/8JHwpbW1V/f+P9LtsMkvpziQ
        Z/ctuMMYJyawycBEcqGuqP2FMkoQy9/Mr9+btOLDYA==
X-Google-Smtp-Source: AJdET5e9bjtLkMqPHUCRyAXrjKTxr8mA5yy33qbDt4XaBf+iQvc4I9QT+/79TFSwi/IUsCarZTVr1dIfAagtX6S2Phk=
X-Received: by 2002:a02:1548:: with SMTP id j69-v6mr10825427jad.72.1541187088555;
 Fri, 02 Nov 2018 12:31:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:b01b:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 12:31:07 -0700 (PDT)
In-Reply-To: <CAJfpegsbfRSYtjVGtGjik=1UNnh=T1AmBjpvNU3G382FxD-sNQ@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
 <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
 <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com>
 <CAJfpegs0by5OJ7iqtg6L3T1w2RrFRiU6yRufVNbt=tNpJCbf2A@mail.gmail.com>
 <CACT4Y+bSnJjtgeLdusj6czbH8080XfRs2b8L0V4R0TAixqxX6Q@mail.gmail.com>
 <CAJfpegvYHYUMdo14J_of10rmg0krjd_eiATJ3D4+XqaNys9bqQ@mail.gmail.com>
 <CACT4Y+Y2ec4-ywG+FWocir6XXkwt-11qD+SAFwswtG2Ng6BS4A@mail.gmail.com>
 <CAJfpeguni8JReXKXU_yUFqBfHav1-JFHfHzhxc=kaXu3ME6Qsw@mail.gmail.com>
 <CACT4Y+YiGEX7_naGDTDNWCKnjQAisYrmBOYNejasfidaCRP7xA@mail.gmail.com>
 <CAJfpegtXhRmSTxEbvGZGUCORoxKvsjeJEfFtUEzGuC76ZE3rmA@mail.gmail.com>
 <CACT4Y+ZZ_v6izsiCGym=r+MiRmxaFE=eH54dz7t0BOQ7VxTNiw@mail.gmail.com>
 <CAJfpegvp8xEJc2-MkQvS-HEhtTAt-sZb1VvDPPUx1c+FdqcjEg@mail.gmail.com> <CAJfpegsbfRSYtjVGtGjik=1UNnh=T1AmBjpvNU3G382FxD-sNQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 2 Nov 2018 20:31:07 +0100
Message-ID: <CACT4Y+aGjM-7ZmKj2YpfD80a1Bjb4=X1r6efCfNXauec83wfjQ@mail.gmail.com>
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

On Thu, Jul 26, 2018 at 11:12 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Thu, Jul 26, 2018 at 10:44 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> On Wed, Jul 25, 2018 at 11:12 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> On Tue, Jul 24, 2018 at 5:17 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>>> Maybe more waits in fuse need to be interruptible? E.g. request_wait_answer?
>>
>> That's an interesting aspect.  Making request_wait_answer always be
>> killable would help with the issue you raise (killing set of processes
>> taking part in deadlock should resolve deadlock), but it breaks
>> another aspect of the interface.
>>
>> Namely that userspace filesystems expect some serialization from
>> kernel when performing operations.  If we allow killing of a process
>> in the middle of an fs operation, then that serialization is no longer
>> there, which can break the server.
>>
>> One solution to that is to duplicate all locking in the server
>> (libfuse normally), but it would not solve the issue for legacy
>> libfuse or legacy non-libfuse servers.  It would also be difficult to
>> test.  Also it doesn't solve the problem of killing the server, as
>> that alone doesn't resolve the deadlock.
>
> Umm, we can actually do better.   Duplicate all vfs locking in the
> fuse kernel implementation: when killing a task that has an
> outstanding request, return immediately (which results in releasing
> the VFS level lock and hence the deadlock) but hold onto our own lock
> until the reply from the userspace server comes back.
>
> Need to think about the details; this might not be easy to do this
> properly.   Notably memory management locks (page->lock, mmap_sem,
> etc) are notoriously tricky.

Hi Miklos,

Any updates on this?

syzbot recently found this hang in fuse, which looks real (totally unkillable):
https://syzkaller.appspot.com/bug?id=0d08132d6dac82ae63b7b8d4a9d027d30b46167d

but this one still happens, and it's hard to tell if it's real or not:
https://syzkaller.appspot.com/bug?id=76f8203fef423375d230f14b8f5b45617ab945e2
