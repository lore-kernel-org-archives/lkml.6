Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42495C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1246B2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNMvnrM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389743AbfBMCrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:47:45 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50371 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732993AbfBMCrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:47:36 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so2222433iti.0;
        Tue, 12 Feb 2019 18:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1DWd8/tKpU2pyvWFgPd32wgFX3JllDhgcMA7u9cW20=;
        b=pNMvnrM3qy/hbUTRJQG60Fg4zMNGE0k3kbvjvMQavzGUSp3fAs8yKtDDDgcezVfnWj
         /zK2Q4ZiGHS9oLC1wbMzqR60xymrFbFRA9TsumaMU8mgKTkbIbLHTYPKkL7TP7w+KetZ
         SQ4JR2WMrKEcLSIl1nhG57IME/XMGtAETNxXgkHhR18KWYh/oLb092AhQcbwoTRV9PiH
         rFulMKF4RwxlJ16CjppBx4QXNOTO4c8u/cXFReqflbKk1V4rXsTQr3N6g0+yKWz2d1rR
         ZO4VGvr/5unQj2tyyJd/s8DtVGKXY1n/rH5yEYDLYuhfq0Ub4jEae5s9E2TZaNv8xjXL
         XJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1DWd8/tKpU2pyvWFgPd32wgFX3JllDhgcMA7u9cW20=;
        b=ZjXnffQBg7bVxVBgyA9fRYed9sHv3A5PyshrCwomNCIFMSyTvOnUjThbge1U//fGT/
         hLscIRRwvYkyA+TbEoQsPdy6NK7WbW9ZSjISHv1/Kwj3DQitcFLoW18BqKE2i2FVXNgK
         jWVC1fRml05CfF3TpWncbwBuz2ZWvmml7A9hPTQ+C7+Dg3ENfSyEY0qV+brhLgx458uL
         9VBJBiJqtwM5lokCJVSt3gshZCCg91u50Q+b54s0ZPZSC3vqcRZNZK+az98YKY93ImF2
         eKxCz3Q1mSfMmJH4w8n7YsyRhNe9udHwsX1FO03rc2Zv+9W1YpIQVp9EUMAd3KfCv6zz
         gNaw==
X-Gm-Message-State: AHQUAuYpT7yq2bKVzS5c3P2o/1pTyJWZl4kMCIuK5JLOsBsyYefWVmUz
        wPJaxHnI7JFUaR/rWT2bPAvV1N9kd/ouicDG9Tk=
X-Google-Smtp-Source: AHgI3IYBucP831EhxW9i+3YMlSVgLP2Qr8enYchslbFB38JghhWomDvR0Qdw4auISYARKrwUnoilFG8cGGUgJpoDGZ0=
X-Received: by 2002:a24:e44:: with SMTP id 65mr959158ite.154.1550026055687;
 Tue, 12 Feb 2019 18:47:35 -0800 (PST)
MIME-Version: 1.0
References: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
 <1549971097-12627-2-git-send-email-laoar.shao@gmail.com> <38d07cb3-b767-bfc4-9ae5-48367971d839@gmail.com>
 <CALOAHbAskuYhs3KQTJtT0Y7hjFcOyab-JpG4GCPENUxOk34-eA@mail.gmail.com> <CANn89i+2JB1UfdTmVMPMP-fEeYm9safcO49ygKn6fccEP1rpYA@mail.gmail.com>
In-Reply-To: <CANn89i+2JB1UfdTmVMPMP-fEeYm9safcO49ygKn6fccEP1rpYA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 13 Feb 2019 10:46:59 +0800
Message-ID: <CALOAHbCLR-Eyr=7fFmU=_gRN-7HPiOdbFYbNNK_xNqmPFYFfOw@mail.gmail.com>
Subject: Re: [bpf-next 1/2] tcp: replace SOCK_DEBUG() with tcp_stats()
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
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

On Wed, Feb 13, 2019 at 10:15 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Feb 12, 2019 at 6:07 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
>
> > Let me explain the background for you.
> > I want to track some TCP abnormal  behavior in TCP/IP stack. But I
> > find there's no good way to do it.
> > The current MIBs are per net, other than per socket, that makes it not
> > very powerful.
> > And the ancient SOCK_DEBUG is not good as well.
> > So we think why not cleanup this ancient SOCK_DEBUG() and introduce a
> > more powerful method.
>
>
> I am all for it, but this more powerful method does nothing at all in
> the current patches.
>
> I can not accept patches just because they seem to be harmless,
> knowing that  the next patches
> will be pushed later changing more stuff, just because the new
> infrastructure is there "and can be used"
>
> Just remove all SOCK_DEBUG() calls, there are leftovers of very ancient times.
>

OK. I will send a patch for it.

> Do not add more debugging stuff unless you can demonstrate
> they actually allowed you to find a real bug and that you sent a
> public fix for it.
>

Sure.

> Just adding "cool stuff" in TCP stack does not please me, it is only
> more complexity for unproven gain.
>
> Otherwise, I am tempted to think that these BPF hooks are there only
> so that a company can more
> easily build a private variant of TCP, yet letting the community
> maintaining the hard part of TCP stack.

:-)

>
> Thank you.


Thanks
Yafang
