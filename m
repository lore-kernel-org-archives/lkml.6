Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC80C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B50207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiRWnLVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390469AbfBMDFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:05:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37327 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387550AbfBMDE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:04:57 -0500
Received: by mail-it1-f194.google.com with SMTP id l131so2167799ita.2;
        Tue, 12 Feb 2019 19:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSntMJibvEZFlLbKlqVwmACNH56O++WuRx3xHgi+++M=;
        b=PiRWnLVVGzmqW28JlA44Y8K7Z6HGUHIfWQqJwSCFp8E6KyHfuOZ9Q3g97jwPmzn12Q
         aBQO+ylp0WbjVWBgH9MmgmCqijoRG5jMvbhm+cWnHujiy42+L9GHgfsvOI9XfUdwF2Km
         P9BO6PNs0hOn9urfW2PJcbVGDOz/5vADf+7hUOjyEPto1+u/MFFDq9EQqf+hyi49DSj5
         YBk9xz4Kw/sKCUKnl0b7z82hJ2h4bz4CM6S8o4GZuonjixb61EAuvsVWaDK+WPj2G1QT
         eQHHdZdgMFy6ab5NWLvrh+8nUK3H4E2d8mtlJgo6Y2RuuGHrEnxudQbzIbgs/OVJRYmZ
         Hd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSntMJibvEZFlLbKlqVwmACNH56O++WuRx3xHgi+++M=;
        b=TAzDMifqQpi95kFEUdiVorX354zgaLy7tEntzyN8CVp8z8w+Qd5XjHsfFqzAb3NIeh
         KHtEO+IZktNlqFEMnD1cEfQ0WsJMVaCe7xokkTSOr9RJDUOYYFu+SFzc3MvtQQAiO2Nc
         ep1iNELGaaf8BNbd981LEUqwCHghFxwAi37dFhHwDxcyLQpG23opVZ180GvzxDU4aVPt
         FFoESq0EqrrGwn0H0XmeJHBjp3aqzJJxcfq2YzJQZs2Xoitp9u3MCCe7TxpQSK/cn5Wf
         CHaewZvWHEZxj2aUX5gx+nLYhtk/xRuH6mzMpNd15EhKIrpLmv05ZbONFFM6X3AA6/qV
         DLag==
X-Gm-Message-State: AHQUAuYElx1wqQJ8t7KXQfhb/H7BFx/H81LszLQFUQwzx1N/QOLRSnsg
        Zh9fVSRlR9bFd7FLQl+WYbolIM4Gi7bBlsGwT7k=
X-Google-Smtp-Source: AHgI3IZ2EbMKQPz9Fie8/4JCA6OIhVwq6BQCL4pzb+mri4csISNngZUP/Gw4UC0ur5jrHnhc7aflbXVUjw+DfWn2X/I=
X-Received: by 2002:a24:e44:: with SMTP id 65mr983901ite.154.1550027097064;
 Tue, 12 Feb 2019 19:04:57 -0800 (PST)
MIME-Version: 1.0
References: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
 <1549971097-12627-2-git-send-email-laoar.shao@gmail.com> <38d07cb3-b767-bfc4-9ae5-48367971d839@gmail.com>
 <CALOAHbAskuYhs3KQTJtT0Y7hjFcOyab-JpG4GCPENUxOk34-eA@mail.gmail.com>
 <CANn89i+2JB1UfdTmVMPMP-fEeYm9safcO49ygKn6fccEP1rpYA@mail.gmail.com> <CAADnVQKhEshkWSDeYJ92pWnJjqawGSScBH+LU4iXsqwwxYjO9g@mail.gmail.com>
In-Reply-To: <CAADnVQKhEshkWSDeYJ92pWnJjqawGSScBH+LU4iXsqwwxYjO9g@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 13 Feb 2019 11:04:21 +0800
Message-ID: <CALOAHbA4PrgV8tem3cMt+22Vm2GQw=oaRsXMcAr2XBgX8hhjKw@mail.gmail.com>
Subject: Re: [bpf-next 1/2] tcp: replace SOCK_DEBUG() with tcp_stats()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Lawrence Brakmo <brakmo@fb.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:49 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 12, 2019 at 6:15 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > Do not add more debugging stuff unless you can demonstrate
> > they actually allowed you to find a real bug and that you sent a
> > public fix for it.
> >
> > Just adding "cool stuff" in TCP stack does not please me, it is only
> > more complexity for unproven gain.
>
> I agree.
> I don't see why this debugging of 'abnormal TCP' cannot be done
> with kprobes and tracepoints.

kprobe is not suitable, because we have to use the line number, that's
a trouble cross all kernel versions.
Regarding  tracepoints, I don't think it is a good idea to introduce
more and more tcp tracepoints and make them crowed as well.

> Instrumenting every tcp counter increment is overkill.
