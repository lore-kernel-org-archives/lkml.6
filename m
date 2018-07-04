Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C945C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF43F21564
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqu1oKsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF43F21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeGDQ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:59:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51134 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeGDQ7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:59:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so7007446wmc.0;
        Wed, 04 Jul 2018 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zfQsH2yr4Tx0T1cj99IgCP6C42ir3zji2fxU18+BvJU=;
        b=Xqu1oKsI+pPyWXMwaAomCvzafZMD2O15sdQbmUTi6Oti9WEGGRUt2Pkj5Kz1DOyQpB
         8cwqzr3dqKIeSm8SPp7n2w8o6jP37Dn5H7QvGt8DJQdtQrwz58OtsBs7QlgAMtn10/4C
         r1y1OB83VBbDUbrm/bNvJIQX7KkUpAjw4aZ/f2KzdvZ9ze9tQrUPigmiu/OSIN/a3qCy
         YkBE6tjIZPN7HLpy2mtDcV7l2HcCzEWGCAz0AUjfqkknGx7ab/5vF+7xWwQEBIXNvB8B
         u8n+70vtkMN1/UFiJngkBZk/wFheGmOC/nZCVPwrIFGExplE8h/ckUVyFV5YrcdHsPL5
         mq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zfQsH2yr4Tx0T1cj99IgCP6C42ir3zji2fxU18+BvJU=;
        b=jw/z4ZgFF2YdYFM6EKvxCEaxrkCLG9CpClKShL2XQgal/zS0HQBFhs09eI9/4p8UXG
         TpRZzBmkLxLvufkcYdItGZfnYsqiR1BCiPGcSN4eFgVUllwu99Y3jiX9J6mh7OxfB6YA
         5s1X7w5BgHP+7wLYVsTM5gLMKvsYPJmjWBzzimMUGbf0+nhMphw57rJ3uXvOJo2dyFcQ
         XpYpW1Fo5dppH12GrZEflEEBE8tmE4CRocbKknaNzCICi4luaPfjaTfQfXXCUDKEuVoU
         k+D0UjYmrPd4pnIUBJaQSxTDv2dwJDfQNcJQErFc625iLZSap4y0PHqEhcs5MRsFgOTz
         8a+Q==
X-Gm-Message-State: APt69E0QVj/roBgcpw5OCmTtR6cXl7Hufwmz/EVsk66bXpKdJ8nxSBb0
        OjVe/oLi8OZ0v+Fg4i5JR6LAW7f5oh6qicsWMx0=
X-Google-Smtp-Source: AAOMgpdBh2dofPbVmb2RAC7KTbWFW9TxKUxfkXZ3E2Q+no0geZp6gKVuYi0kFuuWjw/sYlhXgh9gm9NPn1mB/RrqGAY=
X-Received: by 2002:adf:d08c:: with SMTP id y12-v6mr2240302wrh.152.1530723585775;
 Wed, 04 Jul 2018 09:59:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e64f:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:59:25 -0700 (PDT)
In-Reply-To: <CACT4Y+b0fysS3D4QCcfw5X-rFt3c1a7XAHntN4Q7p9tdHNCuow@mail.gmail.com>
References: <000000000000b2989805702eedd3@google.com> <CACT4Y+b0fysS3D4QCcfw5X-rFt3c1a7XAHntN4Q7p9tdHNCuow@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 4 Jul 2018 09:59:25 -0700
Message-ID: <CAADnVQ+3QO_T52ip4k6SBEyQfWT5pFjdTFGuFKCVpnqoWXp5Ag@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in timerqueue_add
To:     Dmitry Vyukov <dvyukov@google.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     syzbot <syzbot+b680e42077a0d7c9a0c4@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 9:34 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Jul 4, 2018 at 6:29 PM, syzbot
> <syzbot+b680e42077a0d7c9a0c4@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    fc36def997cf mm: teach dump_page() to correctly output poi..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=167e3b92400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b680e42077a0d7c9a0c4
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1030a858400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1167aaa4400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+b680e42077a0d7c9a0c4@syzkaller.appspotmail.com
>
> +bpf maintainers since the repro seems to deal to bpf maps
>
> We've got a splash of crashes today, all seem to suggest some kind of
> stack corruption/overflow, see the last 6 bugs here:
> https://syzkaller.appspot.com/

John, this is sockhash map related. Please take a look asap.
