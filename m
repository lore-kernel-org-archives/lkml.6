Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D332089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJMM9uB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D332089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJPA7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:59:05 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37680 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeJPA7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:59:04 -0400
Received: by mail-it1-f193.google.com with SMTP id e74-v6so28710945ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gsIjagZNQQkA9ksth8WVhZslPoiX8pxtrxY0yInE/5E=;
        b=QJMM9uB180Cbwfc4yBHdtMF/w60gdxlosriR7PLx6f8mr0mx/2CyXkL0J3svQs5Qcw
         KQF2efQXzgQdUF3fedI+BOac8h4kypxGNyubglKlefuUjVFm1H2S+92nQesAOG7cP7aG
         NT1/iTfaZh2ugJ5ZgTBoTbui17tUXcolLXr6/cR33GlAgf1A15iKtJ49pHlBVXDLZcLR
         rzXWrnrocIAKcaI7TOAdAZ1RdBMhS4fpu+MjWO7yWAgPOzh9zGH67NLCunIQmTluil/t
         n9nrswxhHZxl3gH/ylwc79XlsJ/yVswrKI/g/T6pvsuZuGwTRlcyUE5TgwVacxyOQMtN
         zgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gsIjagZNQQkA9ksth8WVhZslPoiX8pxtrxY0yInE/5E=;
        b=jSdpOnVQ7RI2AP+aWoxfXVe1mlJ7bBnLNy1tfJveX6g0Vn+ADbhRe+uRS3ADRmbX0u
         Z9oRPW/sxX1K1riM2vNM8SL+BNLBab/qfJI4KiDG6zfG9nlQFU26aKFyph10suncwOJ2
         5Eb97SlhfBq6WcCqNgF9WVDQ/ugkb5iNsOeYzYGc57C+q8uEbviU2YRQw02uMmSUcky+
         zDMIaZLu/+KSBha9t5droVJ92eJIKnoxlL0ScuJB1a4g0pm02UNFiToc8RzjoWm4TYXd
         oQd94s5bdha5MXU/4sE+Rxv7cbh8udxZI/bo4BpX37ZxI8v0g/GAe3AjJhNONZtxCdrU
         DzcA==
X-Gm-Message-State: ABuFfoglE8PbB7jWcOGnPDjf6VkyR8bmQrGCYZJYWaca2u0Qrlj9ILcy
        7oReFOWYNBsKeQO3GtaCfYy8ACQLpXvO7xYzbHX2bA==
X-Google-Smtp-Source: ACcGV600JB+z5+1XCg77dZqE48RTBQVBNITjNZSr/hoKN5IiaiAnrpe3FdQY3iQ7Rl2RCqUIbcKsDpX4DN6KRj5Oo1I=
X-Received: by 2002:a24:f584:: with SMTP id k126-v6mr12170786ith.166.1539623576986;
 Mon, 15 Oct 2018 10:12:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 10:12:36
 -0700 (PDT)
In-Reply-To: <20181015124552.GD30927@quack2.suse.cz>
References: <00000000000036c76a057842c97f@google.com> <20181015121541.GC30927@quack2.suse.cz>
 <CACT4Y+ZabUTpP6HZQVkVDvMYbktn=gP2C-m=ueKK3NRh7teY5A@mail.gmail.com> <20181015124552.GD30927@quack2.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Oct 2018 19:12:36 +0200
Message-ID: <CACT4Y+ZrMvNi8GvO3S5gSf7ofcQKFNG_JuusSOUXCxZEx5R8Ag@mail.gmail.com>
Subject: Re: INFO: task hung in fanotify_handle_event
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+29143581b0ded3213e99@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 2:45 PM, Jan Kara <jack@suse.cz> wrote:
> Hi Dmirty!
>
> On Mon 15-10-18 14:29:14, Dmitry Vyukov wrote:
>> On Mon, Oct 15, 2018 at 2:15 PM, Jan Kara <jack@suse.cz> wrote:
>> > Hello,
>> >
>> > On Mon 15-10-18 04:32:02, syzbot wrote:
>> >> syzbot found the following crash on:
>> >>
>> >> HEAD commit:    90ad18418c2d Merge git://git.kernel.org/pub/scm/linux/kern..
>> >> git tree:       upstream
>> >> console output: https://syzkaller.appspot.com/x/log.txt?x=17f1776e400000
>> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
>> >> dashboard link: https://syzkaller.appspot.com/bug?extid=29143581b0ded3213e99
>> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123459d6400000
>> >>
>> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> >> Reported-by: syzbot+29143581b0ded3213e99@syzkaller.appspotmail.com
>> >
>> > Syzbot has apparently generated fanotify watch for FAN_OPEN_PERM event and
>> > then the process got stuck waiting for userspace to respond to that event -
>> > which never happened. So everything works as designed here - the process
>> > placing FAN_OPEN_PERM mark is responsible for replying to the generated
>> > events as all opens hang waiting for responses. That's why the
>> > functionality is behind CAP_SYS_ADMIN after all... Could we fix syzbot to
>> > actually generate replies for these events?
>>
>> Is there a reliable way to kill such processes?
>> Or admins are never supposed to kill any root processes and have not
>> bugs whatsoever? :)
>
> Currently the wait is not killable but yes, we want to make it killable
> exactly because of userspace bugs :). But it is non-trivial because
> currently the waker has also other responsibilities and all that stuff has
> to be cleaned up when handling killed wait. Konstantin Khlebnikov was
> working on that so I might need to prod him.
>
>> syzkaller probably capable of generating replies in some cases, but
>> unfortunately it can't work this way. It's practically not possible to
>> ensure that it will always generate a proper reply and it will be
>> actually delivered and the process won't be killed in the middle, or
>> another thread won't crash or call exit_group concurrently, etc. The
>> thing either needs to be reliable, work without any but's and be
>> reliably killable, or it's not suitable for stress testing.
>> If there is no reliable way to kill it, I think we need to disable
>> FAN_OPEN_PERM entirely.
>
> Understood. Then just disable FAN_OPEN_PERM & FAN_ACCESS_PERM for now.


Disabled FAN_OPEN_PERM & FAN_ACCESS_PERM for now:
https://github.com/google/syzkaller/commit/6ce17935cb99fa11aaa2f2d1889261da6b298013


#syz invalid
