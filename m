Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB52CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A652A20651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfANSaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:30:08 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:44911 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfANSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:30:06 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gj6zr-0007Lz-V4; Mon, 14 Jan 2019 11:30:04 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gj6zq-0006gT-SX; Mon, 14 Jan 2019 11:30:03 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     zzoru <zzoru007@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        Andrey Vagin <avagin@virtuozzo.com>,
        "dsahern\@gmail.com" <dsahern@gmail.com>,
        "nicolas.dichtel\@6wind.com" <nicolas.dichtel@6wind.com>,
        "tyhicks\@canonical.com" <tyhicks@canonical.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller\@googlegroups.com" <syzkaller@googlegroups.com>
References: <bc63c776-99f9-ca6e-0e81-f91b1448932b@gmail.com>
        <87fttzaq8k.fsf@xmission.com>
        <fa46d362-9ced-8376-0770-e39a658c24ec@virtuozzo.com>
        <81dab6a7-a28d-552f-d0d8-f83f9d261200@gmail.com>
        <87imyuah41.fsf@xmission.com>
        <CALRZ7Utk6NCGRN6mZQnF1v1a=cTWt1-JzRjLdiD14FTQC=fysg@mail.gmail.com>
        <CACT4Y+bPMNGRrvm-VGSmUyXYWcKWGoZY8iUwQt=-9WqxgTb0GA@mail.gmail.com>
        <CALRZ7UvMbrwLb7UVgcVa9+z5yqVfJ6taj2tzpsFhWU1Cdw2J1A@mail.gmail.com>
Date:   Mon, 14 Jan 2019 12:29:38 -0600
In-Reply-To: <CALRZ7UvMbrwLb7UVgcVa9+z5yqVfJ6taj2tzpsFhWU1Cdw2J1A@mail.gmail.com>
        (zzoru's message of "Mon, 14 Jan 2019 21:06:27 +0900")
Message-ID: <87h8eb854d.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gj6zq-0006gT-SX;;;mid=<87h8eb854d.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+aWmKwDw/g7YCjeieJcFsbSn7H4TudJ4Y=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: net/core: BUG in copy_net_ns()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zzoru <zzoru007@gmail.com> writes:

> I think that it is exactly same to:
> https://groups.google.com/forum/#!searchin/linux.kernel/cleanup_net$20is$20slow%7Csort:date/linux.kernel/IMJ9OzonDSI/QH86oy1PAQAJ
> Already, patch was maded, but maybe he forgot to push it.

That patch was made to address speed, and lifetime of network stack
objects.  At best it will make things go faster (a good thing), and
reduce the memory consumption during a test (another good thing).
The patch you point to will not correct your memory corruption.

So right now the best hypothesis seems to be Dmitriy's idea that
there is stack overflow causing corruption. You have a lot of stack
debugging already enabled but I don't see CONFIG_VMAP_STACK enabled
which might catch something ordinary stack overflow checking won't.

Any chance you can enable CONFIG_VMAP_STACK and see if it is stack
overflow?

With a little luck you will catch the stack overflow in the act and we
can see the problematic code path.

Eric
