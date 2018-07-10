Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1588FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF59820834
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CdJuQ8hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF59820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbeGJUPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:15:52 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36699 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbeGJUPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:15:52 -0400
Received: by mail-it0-f43.google.com with SMTP id j185-v6so467714ite.1;
        Tue, 10 Jul 2018 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d75Zz5jkwot3JOPf8mNiIOEIqXlBvu4oQIskgwi/BU8=;
        b=CdJuQ8hcaYWjYxOhukfN0fL5up9s+MAKEdCAKd1M2gkJ9NxZpCNIHk2ecfWnu5Uxlj
         rQ2jMBLZcSGXqIJPAr2OWdHQ2oJpkWGtZ4U90kd0q+k4qS9HzYZtjA7fbgH1P2ola3G+
         Rn4DR2DZkUHzBiKCurdDD7q9+WuaHouhQGLO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d75Zz5jkwot3JOPf8mNiIOEIqXlBvu4oQIskgwi/BU8=;
        b=G8vbPq28CtIOVhuqSROTsOL1cFKjdxRdwnKTjC4znY5CpahJPaGTjDfTFiCa02dPSA
         onsf7S49c1zKYFYfv/np+kr8UaF+hpq0IoDjY4dY8BK1zqvqRlPM0Spr3IZRGugJ/B7m
         Cs0AwKgzV5tvbz3A2FxvktnSn/lvptLaWcRAOObKLqgY9mtAaHgm2Cc4V/UHyO1KppkB
         nABJbgxJoQ2/ejQnoi7+nzdp46z2lGos78xQIZUkqyL0HoIWEiH5uuwhGtKJORuihhEf
         U4ts4Jmu7n5Tk6HLbs+o/4pPwgwqXHFNvVCqWEOZJ9DYb8uFG3liTt5Kw42Q1wxArCUe
         WaDQ==
X-Gm-Message-State: APt69E2oX97V0HjCYnuAYsHsu0jXe0CX9bq+V14tpmamiY2FBEFvdQPP
        1kYcsQSmBqZlp49hTlkgxQ2ByQDqIbwbt1ayMrY=
X-Google-Smtp-Source: AAOMgpdBHerIKpxx82zJr07jmx+c6PBunj5QYb03EDfBGi6KIPNk7p2y60+hcd6gyQrSpLKxd2JYyzEDw8bU4NOoGyg=
X-Received: by 2002:a02:664b:: with SMTP id l11-v6mr22496481jaf.70.1531253713457;
 Tue, 10 Jul 2018 13:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c242e90570aa0062@google.com> <CA+55aFyEZR=v2GySzWWF3uh9ZB53CFFv460Wzg4n8DGze8GFfw@mail.gmail.com>
 <CACT4Y+bOJx+SnkMqzDDUTU1iztQ7DpMBG7Z-oV5wArRaSEzh+Q@mail.gmail.com>
In-Reply-To: <CACT4Y+bOJx+SnkMqzDDUTU1iztQ7DpMBG7Z-oV5wArRaSEzh+Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 13:15:02 -0700
Message-ID: <CA+55aFz1GVHUGiX1SE_5C-e9LdXdx3pBB10zwga1LOy6axk5Ww@mail.gmail.com>
Subject: Re: general protection fault in in_aton
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot+2a831e062bb4aebd8755@syzkaller.appspotmail.com,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        syzkaller-bugs@googlegroups.com,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 12:57 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Is it really hard to get fault address? I know that userspace
> generally receives fault address in siginfo.

For an actual page fault it's trivial.

However, for invalid addresses (aka "non-canonical"), you don't even
get a page fault, you get a GP like in this case. And then the actual
address is not available.

                 Linus
