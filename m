Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5752C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A07C21569
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFB4O4Rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A07C21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390959AbeIUXmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:42:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42846 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390365AbeIUXmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:42:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so12430155ljc.9;
        Fri, 21 Sep 2018 10:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjdnF9JhheDC00YB9GXuJM45dF09prjtWC3y2nAc3HQ=;
        b=HFB4O4RknAKTu9H4TK8E0iW7LkovZl02F8SORdYo0NzCmy3mrwsvCNAJeOeQEfTYoB
         yDVPVTVniuBkXa14y0CyCOQd/SjmW0dvJzQSSf8qJ7oK5F043CzMs8YcpNExsLAvFIH8
         bYn9z28/pTS3zSiHJXr/z42y/MMXUCPYZ3bEiG8lRW8D8ckpCpDQkJvJ4hlYzL6e/QJR
         2xLUgT+3Rd73yn1MqGwFZOwsz0pKetI0mFClIjco+GjjNWoKn89H9abjgctb2EM4OEjD
         QtjwKyCXpmcF1jMIvv0vGHCaKfwMvYqgS0HvOZ/70umrOJj6zk0dINMTuDzqyZOE3R30
         i8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjdnF9JhheDC00YB9GXuJM45dF09prjtWC3y2nAc3HQ=;
        b=tUlNWrDovQXWMptV78YfFwowWHgEEnyENtMfAynnxxfumJm0acFM3uWUSuCbAzI4zF
         bCtOmDX3e3RyGfHVUPYsHspjGJVFk03u+Pzh7eFQeTuN0SjV5q5k10MwUIHAVbzV/LHz
         WMjXDj3AOYXJLmF3050S6vThu6f7p0k1Q9TXxaWf5cWh2r5ct8Pm/P9nHlai9oGQs3E3
         yFcmcrTzcGEYETrCeW4Vd8G5JBSPwOdgWQlD0qEDYWrkgCuiVFRaruIxyeOlStUh8aMm
         cVDZXQ8xpZorBqCFhZ0BJbwERxM9PwNFMi5ZdmpfBdpYX5gzyA7ddqyoSVqet95x3b3o
         F4vA==
X-Gm-Message-State: ABuFfoiLJ/I21yrNMGcJ3st8pVdI5WqDgUsb+GUO0ynBGzevOrVs++Qc
        p/dvZnElmMoXM2vMEAtjFwpSqCLxSeuc9RN+N+k=
X-Google-Smtp-Source: ANB0VdaBrWURfj2aWveKQkJ3Jyp0gmDckDiVGgxk7yqa1QBqALqMCTBKBdvZrev8Mhktd6Ul/v26mc7ZCIi/bd4PsyQ=
X-Received: by 2002:a2e:87cf:: with SMTP id v15-v6mr2679833ljj.13.1537552350812;
 Fri, 21 Sep 2018 10:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e5f76c057664e73d@google.com>
In-Reply-To: <000000000000e5f76c057664e73d@google.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 21 Sep 2018 10:52:19 -0700
Message-ID: <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
To:     syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:24 AM syzbot
<syzbot+87829a10073277282ad1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    234b69e3e089 ocfs2: fix ocfs2 read block panic
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=131f761a400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
> dashboard link: https://syzkaller.appspot.com/bug?extid=87829a10073277282ad1
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126ca61a400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119d6511400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+87829a10073277282ad1@syzkaller.appspotmail.com
>
> input: syz0 as /devices/virtual/input/input25382
> WARNING: CPU: 0 PID: 11238 at mm/slab_common.c:1031 kmalloc_slab+0x56/0x70
> mm/slab_common.c:1031
> Kernel panic - not syncing: panic_on_warn set ...

This is coming from:

commit 6286ae97d10ea2b5cd90532163797ab217bfdbdf
Author: Christoph Lameter <cl@linux.com>
Date:   Fri May 3 15:43:18 2013 +0000

   slab: Return NULL for oversized allocations

   The inline path seems to have changed the SLAB behavior for very large
   kmalloc allocations with  commit e3366016 ("slab: Use common
   kmalloc_index/kmalloc_size functions"). This patch restores the old
   behavior but also adds diagnostics so that we can figure where in the
   code these large allocations occur.

   Reported-and-tested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
   Signed-off-by: Christoph Lameter <cl@linux.com>
   Link: http://lkml.kernel.org/r/201305040348.CIF81716.OStQOHFJMFLOVF@I-love.SAKURA.ne.jp
   [ penberg@kernel.org: use WARN_ON_ONCE ]
   Signed-off-by: Pekka Enberg <penberg@kernel.org>

You'll have to convince Cristoph that WARN_ON_ONCE() there is evil and
has to be eradicated so that KASAN can run (but then we'd not know
easily that some allocation failed because it was too big and never
had a chance of succeeding vs. ordinary memory failure).

Can I recommend that maybe you introduce infrastructure for
panic_on_warn to ignore certain "well known" warnings?

Thanks.

-- 
Dmitry
