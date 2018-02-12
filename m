Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeBLHYn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 02:24:43 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39029 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932584AbeBLHYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 02:24:40 -0500
X-Google-Smtp-Source: AH8x2244vyBiSLQdJvoNuuQ9WILSaLwrDOjY7Lg4e8XpLc5Ho2N/wrupAf3lwoSm5gvRo+HtIeg4uA==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <6394471.U0O273vb9H@natalenko.name>
Date: Mon, 12 Feb 2018 08:24:36 +0100
Cc: Mike Galbraith <efault@gmx.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Ivan Kozik <ivan@ludios.org>,
        169364@studenti.unimore.it, holger@applied-asynchrony.com,
        Serena Ziviani <ziviani.serena@gmail.com>
Message-Id: <9E24F648-C93A-4CEA-A1B6-B041540CEAAE@linaro.org>
References: <20180207211920.6343-1-paolo.valente@linaro.org>
 <b5d4a3bc8946db0a696e8398b68adba0@natalenko.name>
 <1518197379.26824.31.camel@gmx.de> <6394471.U0O273vb9H@natalenko.name>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1C7Ol5G016075



> Il giorno 10 feb 2018, alle ore 09:29, Oleksandr Natalenko <oleksandr@natalenko.name> ha scritto:
> 
> Hi.
> 
> On pátek 9. února 2018 18:29:39 CET Mike Galbraith wrote:
>> On Fri, 2018-02-09 at 14:21 +0100, Oleksandr Natalenko wrote:
>>> In addition to this I think it should be worth considering CC'ing Greg
>>> to pull this fix into 4.15 stable tree.
>> 
>> This isn't one he can cherry-pick, some munging required, in which case
>> he usually wants a properly tested backport.
>> 
>> 	-Mike
> 
> Maybe, this could be a good opportunity to push all the pending BFQ patches 
> into the stable 4.15 branch? Because IIUC currently BFQ in 4.15 is just 
> unusable.
> 
> Paolo?
> 

Of course ok for me, and thanks Oleksandr for proposing this.  These
commits should apply cleanly on 4.15, and FWIW have been tested, by me
and BFQ users, on 4.15 too in these months.

Thanks,
Paolo

> ---
> 
> block, bfq: add requeue-request hook
> bfq-iosched: don't call bfqg_and_blkg_put for !CONFIG_BFQ_GROUP_IOSCHED
> block, bfq: release oom-queue ref to root group on exit
> block, bfq: put async queues for root bfq groups too
> block, bfq: limit sectors served with interactive weight raising
> block, bfq: limit tags for writes and async I/O
> block, bfq: increase threshold to deem I/O as random
> block, bfq: remove superfluous check in queue-merging setup
> block, bfq: let a queue be merged only shortly after starting I/O
> block, bfq: check low_latency flag in bfq_bfqq_save_state()
> block, bfq: add missing rq_pos_tree update on rq removal
> block, bfq: fix occurrences of request finish method's old name
> block, bfq: consider also past I/O in soft real-time detection
> block, bfq: remove batches of confusing ifdefs
> 
> 
