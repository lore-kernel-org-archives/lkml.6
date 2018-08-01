Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4A1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC9320844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbkbFZiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC9320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbeHAK7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:59:51 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:33847 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388818AbeHAK7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:59:51 -0400
Received: by mail-pg1-f174.google.com with SMTP id y5-v6so10522014pgv.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 02:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=55zGgw+CX5X2osF6D/AcGZLqTtAwyWlmWCcVQ4UDT0Y=;
        b=dbkbFZiS3SXTqGHwibQiLzENyywXJHoFHVO4qIrV8u7IMeTqebluJZYdPM8EAZBlnM
         WX6miTlGwTYxNgOX9+iOM/oQZBCZezCZz63jOmc2kUXKMN+tIWBf1Uf5uXMwOTkmcyV/
         7hlJhndSYu4PCLRD9m5+fG1yhDPwc3dznhK/NxO3WOmoUvWJcvl9AhT3dHw+FSPGLBu/
         K7/i3HTniQrA1Hq3uygTo9owgjTVO97zyigEjOVzrSE4IzJdquzmhaDxvfGbwvbktYDf
         jBlV+3oeSfDuvwI7XAC7J9OEVVchYhF25/8YeCnOs5By7U2WSyfKQmM+p0x1AzbBB51H
         v9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=55zGgw+CX5X2osF6D/AcGZLqTtAwyWlmWCcVQ4UDT0Y=;
        b=cI8VGxgEUjSgPpQGqJqxsA79ZsEVzmo0M/wsoxewx4S0/Rq3kULjUQ77IK1UAvb3Qm
         ckA06PRpslDVWfwcAIXaHYnorpIFfCPgxZr88z45OdYCUwAmw7c+ZbVGr5LQrCyULBPQ
         68zgvADfJY7tVW+HNRxtLIpCE0MQRvf/j191ftlp2hZP2bOrKFSnWp+CUsb8IeXV33gV
         DTA2342AbUFmwcRoIngamA4dQyG0CoN06uCtS8PxW5afP1OKAn17TGrutqVj0TDzejhW
         MFzTDPdHzU4aOYMpJeWYQi5jW0FfPjfSCUhQBnE99v1xZeUK7mYJ83sJgfgC5DL2cciY
         uh2g==
X-Gm-Message-State: AOUpUlEAegGqbRlsIeUbi5nufL9SG4nq/1qRNIeEHbe0Q/a9DRiz24em
        rfuGGKJbaXSpfgjRb5YjxAfLOCH135NK/cCoIFLxAw==
X-Google-Smtp-Source: AAOMgpcZNAzHWA4qia+L78P8SJtJdB7xoD3H6trL18dyjmeSdN5c7FhUxVMrzvd8BjXZQVUqIWdKsmpv43ph459epYs=
X-Received: by 2002:a62:d10d:: with SMTP id z13-v6mr2179872pfg.98.1533114904308;
 Wed, 01 Aug 2018 02:15:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 1 Aug 2018 02:14:43
 -0700 (PDT)
In-Reply-To: <20180801085749.3nf5hbxjxoafangb@gauss3.secunet.de>
References: <000000000000d71bf6056a34b628@google.com> <000000000000ed9844056a507832@google.com>
 <50d24879-7f38-f8c5-982f-b3fc5d3a9cc6@I-love.SAKURA.ne.jp>
 <11ddcad9-f3fa-dfbc-18a0-e5facc37a4a3@I-love.SAKURA.ne.jp>
 <20180731113152.4pes5xwhae2xydqg@gauss3.secunet.de> <20180801085749.3nf5hbxjxoafangb@gauss3.secunet.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Aug 2018 11:14:43 +0200
Message-ID: <CACT4Y+bNWOsq4ZABF67ye6SMddfffEvmdUzu9EfEr77j7XpzRA@mail.gmail.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot <syzbot+2dfb68e639f0621b19fb@syzkaller.appspotmail.com>,
        Dan Streetman <ddstreet@ieee.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 10:57 AM, Steffen Klassert
<steffen.klassert@secunet.com> wrote:
> On Tue, Jul 31, 2018 at 01:31:52PM +0200, Steffen Klassert wrote:
>> On Tue, Jul 31, 2018 at 08:16:22PM +0900, Tetsuo Handa wrote:
>> > Steffen and Herbert,
>> >
>> > Do you have any question? I think I provided enough information for debugging.
>>
>> It seems that I was not on Cc at the beginning of the threat,
>> so I had to search the web for some context.
>>
>> I'm currently trying your reproducer (still with my .config) but I don't
>> hit the problem.
>
> Actually, I did not hit it because it is already fixed in my tree.
>
> It is fixed by:
>
> commit 8cc88773855f988d6a3bbf102bbd9dd9c828eb81
> xfrm: fix missing dst_release() after policy blocking lbcast and multicast
>
> This fix went to mainline on Monday.

Thanks, let's tell syzbot:

#syz fix:
xfrm: fix missing dst_release() after policy blocking lbcast and multicast
