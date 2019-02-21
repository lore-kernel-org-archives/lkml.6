Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B467C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FD32086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ip8+0gIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfBUKyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:54:54 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38439 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUKyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:54:54 -0500
Received: by mail-it1-f196.google.com with SMTP id l66so22119016itg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 02:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkAeuej3gdZFNiFWlqKwdOkIgpTFqwzSdrNs/9nMtvM=;
        b=Ip8+0gIrEZSN5YIq+9JgarDrUD2oKawKiGhquHBepSQj2xKVBC3UwMRdAoU+ITPRGZ
         bwSCeIILbFqNQNoWV3lZyRfv1Ba4rMpgnfajjqwYc6RgS9uRFK/v/1i32UHHuVM9LkET
         6lQUJw10Nwde0w/i7BLw4ms32C5w32HF8hEq2Q/31fAugzbbMow1lypDiaxj9N51UFXg
         6AL57Ad3dSfTdprqnHsTpEOVyu95rskRqOje/TI6a6YVIJs1QFsE3M+cbl3mnR4EC3wc
         2oRkjtMh3UiyVhvkxtzKmBtNReGQfFksRdLffw2JrcUUxszs4yMaxho1oLls1T3+tzjP
         YEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkAeuej3gdZFNiFWlqKwdOkIgpTFqwzSdrNs/9nMtvM=;
        b=D3q1x/XuqgMALNxHJulxosYXpk0xNOSZMSY30jstf9yA+xoNb6qE+a7XeBT+HMUg4O
         kh6Jy2B6/Q3zGBxz4JKOJKkLdRA3S5vqG5SrrNyB0o75vavM2IghfaG/zx83+XMosTIn
         lqPNB7dTWp5kAYycMVKoMzngGc4fhaQjclVk8oCbG85xf5toOKCaaZ7Jad1VUhR8UVG4
         JQAXm4u1hNiwyRiEVmn0ql1i8frAXc9d9r04p9njCiT3mpv2UeF2RMEXQRHJmJRsEcSS
         MUMQe3gPUAWvVuJJQ5VZ4BDK/u1HJDz5Fm/GrqJAJOJDAmqYIedc7zVSYrGBfa8e8wpF
         sDHQ==
X-Gm-Message-State: AHQUAuYYgPcEXK7F3WSkHhfnwoPFYKQQA6/XJq3bEor5z6tC/XVc55W8
        fdG3MNWvQ7ciomVKTSsjWvsjGtw5zO3rkTmnOB9XYw==
X-Google-Smtp-Source: AHgI3IawoKxpK5KIMC4CWQ2Mi2RL2H5lMTAXNE/ecL3NjrTOgqp7XwOIhHyzOApRtP40Ufz6hM0uMrsRrENmUanM668=
X-Received: by 2002:a02:9089:: with SMTP id x9mr19657187jaf.72.1550746493511;
 Thu, 21 Feb 2019 02:54:53 -0800 (PST)
MIME-Version: 1.0
References: <000000000000862b160580765e94@google.com> <3c44c1ff-2790-ec06-35c6-3572b92170c7@cumulusnetworks.com>
 <CACT4Y+ZA8gBURbeZaDtrt5NoqFy8a8W3jyaWbs34Qjic4Bu+DA@mail.gmail.com> <20190220102327.lq2zyqups2fso75z@gondor.apana.org.au>
In-Reply-To: <20190220102327.lq2zyqups2fso75z@gondor.apana.org.au>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 Feb 2019 11:54:42 +0100
Message-ID: <CACT4Y+bUTWcvqEebNjoagw0JtM77NXwVu+i3cYmhgnntZRWyfg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in br_mdb_ip_get
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Thomas Graf <tgraf@suug.ch>,
        syzbot <syzbot+bc5ab0af2dbf3b0ae897@syzkaller.appspotmail.com>,
        bridge@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:23 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Mon, Jan 28, 2019 at 09:28:36AM +0100, Dmitry Vyukov wrote:
> >
> > > Weird, this is the kfree() on the error path of br_multicast_new_group()
> > > when rhashtable_lookup_insert_fast() fails, which means the entry should
> > > not be linked in the rhashtable or the hlist.
> > > All other frees are via kfree_rcu. I'll keep looking..
> >
> > Humm.... +rhashtable.c maintianers
> >
> > The code in br_multicast_new_group is effectively:
> >
> > mp = kzalloc(sizeof(*mp), GFP_ATOMIC);
> > err = rhashtable_lookup_insert_fast(&br->mdb_hash_tbl, &mp->rhnode,
> > br_mdb_rht_params);
> > if (err)
> >     kfree(mp);
> >
> > So it looks like rhashtable_lookup_insert_fast both returned an error
> > and left the new object linked in the table. Since it happened only
> > once, it may have something to do with concurrent resizing/shrinking.
>
> I've looked through the rhashtable code in question and everything
> looks OK.  So I suspect some earlier corruption has occured to cause
> this anomalous result.


Taking into account that this still happened only once, I tend to
write it off onto a previous silent memory corruption (we have dozens
of known bugs that corrupt memory). So if several people already
looked at it and don't see the root cause, it's probably time to stop
spending time on this until we have more info.

Although, there was also this one:
https://groups.google.com/d/msg/syzkaller-bugs/QfCCSxdB1aM/y2cn9IZJCwAJ
I have not checked if it can be the root cause of this report, but it
points suspiciously close to this stack and when I looked at it, it
the report looked legit.


> Is it possible to collect earlier alloc/free stack traces on the object in question?

You mean even before the alloc/free of the current incarnation this
object? This looks challenging from memory consumption point of view.
Also how many of them will we print in reports? Also the page can go
through page_alloc and then tracking will be even more challenging.
And in the end the object can be corrupted by an out-of-bounds write
or a like. Heap object reuse quarantine should take care of the common
case, and I don't see a reasonable way to handle all possible corner
cases...
