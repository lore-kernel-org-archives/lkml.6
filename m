Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE180C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9921C20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikW4vcOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9921C20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbeGZLLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:11:05 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39310 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbeGZLLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:11:05 -0400
Received: by mail-pl0-f65.google.com with SMTP id m1-v6so601315plt.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9nMhknhIfuD5vGUWbHq4oAU1nSJWeTVBGyl65/cSTFk=;
        b=ikW4vcOzBKqgKn3+SFAfH7Im1enmmLZ76SwG8JX8oqU/U3MyzmfhxPRGj64wU9IjAJ
         +pKGXtbLT+J/rWI6Vz2zUeQGRix285x8jCsiV5bWxa/weG7TCmzmTIFen3Ics3UEgo0+
         iAG83VJ5+NZRdO1oJNgMDj6XTD6oePntvJbv8YzaaM6k4lxCZXHEUEvBQ7Rmc+Ub7xQl
         DkkcJleruFpHxzTP6Vm4Bxry+95F9HG7M4YQf00/MPX2AaypDY0Mih281rp8/BvX4u7U
         o7SA0PaDXirc1f7WIY5B8GTR5fgkXAEx18qhEf32iIKq0JvVgPzv7FDAy8z3bCjloLPO
         QNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9nMhknhIfuD5vGUWbHq4oAU1nSJWeTVBGyl65/cSTFk=;
        b=U8fYbnAwaWuQtx9Izjiy7OuZaD7KT3qybW/4EZ+/MeL8vduzVjWDr4kBeXGn4qBEcn
         PxDstLoRCroVWMqeFwuy4hoPg4uPlkU1C3QTnR4LReS7LFSApQcYnp9T0hHuyyMV+tNG
         knHk45UQeeCeGRkl+Plf+Y3dpsuiiU5od09R8Bc62NEAIBRwZ9Y1+c5L1HYon8CVnbCq
         S5kzVvYYS9g8iqdEn0GaNrGMhbA7RybIgj3pkP2ABCunLmW07+c/HHMaJFzEOYWzZLIu
         oQ2456eVcRcHsi9dtLtmzh3wjzFwJoq65+J0XCTwH5dLmqeA5IJK8ZoPu2ljv+vuWl4z
         f8kQ==
X-Gm-Message-State: AOUpUlEA/xBwpkNrWZQKboi55uDaEMWWDq9dsn/4LdILeF2lCUztR6M+
        MMW3lOHjJjZLD1gTJ2tdDsqeFr6D23MT6O8l+ZWCBg==
X-Google-Smtp-Source: AAOMgpeN0jFhtzGFcrv9fvx11GcIz5o99Lch2jNBLFVS7bxbVCtdW35QNdYhL8IoLs8lqOPM9WSV2wW93CuDpFnRPs8=
X-Received: by 2002:a17:902:b48c:: with SMTP id y12-v6mr1277259plr.97.1532598900312;
 Thu, 26 Jul 2018 02:55:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 26 Jul 2018 02:54:39
 -0700 (PDT)
In-Reply-To: <20180726094849.GA18334@nautica>
References: <20180726081049.10527-1-tomasbortoli@gmail.com>
 <20180726081727.GA6699@nautica> <CACT4Y+ark+0EYSZaOX-qDKpOkyfLgSO9CkidZzx=xkUuhpr65A@mail.gmail.com>
 <20180726094849.GA18334@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 26 Jul 2018 11:54:39 +0200
Message-ID: <CACT4Y+Zk_d_Ea-oM0R4cRsdnXogq4S+MZMLHJiJuYzibUkanfA@mail.gmail.com>
Subject: Re: [PATCH] 9p: fix NULL pointer dereferences
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        David Miller <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 11:48 AM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Dmitry Vyukov wrote on Thu, Jul 26, 2018:
>> > Let's refuse that at much higher level, like v9fs_mount() in
>> > fs/9p/vfs_super.c
>> >
>> > I can't think of any valid reason for dev_name to be NULL, it's the
>> > target IP or virtio handle.
>>
>> But I think trans=fd allows NULL addr today, no?
>
> Ah, right, I read the patch too fast and read unix_create as fd_create,
> I never realized there was a unix_create variant...
>
> fd legitimately doesn't need a name, you are correct.
>
> I'm really curious if anyone ever uses the unix/fd variants for "real"
> stuff though! (not meaning syzbot isn't real, but I have yet to see
> anything take advantage of this, even if I could imagine some fun
> applications by piping the wmii libixp server socket.. and just crashed
> my laptop trying because of the (fixed) trans put bug.. I have yet to
> see anyone actually doing this)

I don't really know any real-world cases, but 9p over fd it looks like
a kind of fuse, so perhaps somebody uses it this way.
Also, fd allows to use something like sctp socket, and if I am not
mistaken, trans=tcp can't even do ipv6 tcp (?).


> On the other hand, virtio, rdma and xen all have the same problem, so
> Thomas, please fix them instead :)
