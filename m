Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCBCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668582070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfANSNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:13:15 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50739 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfANSNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:13:15 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gj6jZ-0004XL-26; Mon, 14 Jan 2019 11:13:13 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gj6jY-0003kN-Ec; Mon, 14 Jan 2019 11:13:12 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     zzoru <zzoru007@gmail.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
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
Date:   Mon, 14 Jan 2019 12:12:46 -0600
In-Reply-To: <CACT4Y+bPMNGRrvm-VGSmUyXYWcKWGoZY8iUwQt=-9WqxgTb0GA@mail.gmail.com>
        (Dmitry Vyukov's message of "Mon, 14 Jan 2019 12:58:02 +0100")
Message-ID: <8736pv9kgx.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gj6jY-0003kN-Ec;;;mid=<8736pv9kgx.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18k07wYSu3ey6DXsvAxu4D0CWk5gZAjbFY=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: net/core: BUG in copy_net_ns()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> This looks superciliously similar to:
> https://groups.google.com/d/msg/syzkaller-bugs/nFeC8-UG1gg/B6GFaZFrFQAJ
>
> The crux: for the last ~half a year low memory conditions randomly
> corrupt kernel memory with stack overflows.

Does enabling virtually mapped stacks catch those problems?

Eric

