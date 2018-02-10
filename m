Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbeBJI3e (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 03:29:34 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:36312 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 03:29:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 93AEB2F0586
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Mike Galbraith <efault@gmx.de>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
Date: Sat, 10 Feb 2018 09:29:29 +0100
Message-ID: <6394471.U0O273vb9H@natalenko.name>
In-Reply-To: <1518197379.26824.31.camel@gmx.de>
References: <20180207211920.6343-1-paolo.valente@linaro.org> <b5d4a3bc8946db0a696e8398b68adba0@natalenko.name> <1518197379.26824.31.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1518251370;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=RNdKgTt6AOokXZ/f/IS+/NaRzy7RXDO8/2yWd5Q+LWs=;
        b=RSW5LYsr+nQlWv4UFqfvkgxh5EvM1VAmhQp4OSVJDbFrMgRZHQytozUfPCOgolNHfAi3fH
        j9VtzEg6VHbiwuzLFpNrkuA8orP4oyL4e3cXkgWcwixxPbty/2sc59Fe1fr/rS0tor0B3W
        zp1UFm4lHl36P8xKRAJ/5gwJckd3PJM=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1518251370; a=rsa-sha256;
        cv=none;
        b=Yv/vbewZunKfLOFOmwEWpfzKhGudsfI7Nl98k7IZBlbmRcQtUVdip40XUpV6DRSkgWCZ4ZUaifVRrJzVaEbeaEp/aiwm7JZELIWFUQN/831wIX7daz1Pk2gW0iLDgY+pFgkfvmxoPbzhOfKD57DtR+Umovt50pkd6+u0aDXZRjo=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1A8TcJL027737

Hi.

On pátek 9. února 2018 18:29:39 CET Mike Galbraith wrote:
> On Fri, 2018-02-09 at 14:21 +0100, Oleksandr Natalenko wrote:
> > In addition to this I think it should be worth considering CC'ing Greg
> > to pull this fix into 4.15 stable tree.
> 
> This isn't one he can cherry-pick, some munging required, in which case
> he usually wants a properly tested backport.
> 
> 	-Mike

Maybe, this could be a good opportunity to push all the pending BFQ patches 
into the stable 4.15 branch? Because IIUC currently BFQ in 4.15 is just 
unusable.

Paolo?

---

block, bfq: add requeue-request hook
bfq-iosched: don't call bfqg_and_blkg_put for !CONFIG_BFQ_GROUP_IOSCHED
block, bfq: release oom-queue ref to root group on exit
block, bfq: put async queues for root bfq groups too
block, bfq: limit sectors served with interactive weight raising
block, bfq: limit tags for writes and async I/O
block, bfq: increase threshold to deem I/O as random
block, bfq: remove superfluous check in queue-merging setup
block, bfq: let a queue be merged only shortly after starting I/O
block, bfq: check low_latency flag in bfq_bfqq_save_state()
block, bfq: add missing rq_pos_tree update on rq removal
block, bfq: fix occurrences of request finish method's old name
block, bfq: consider also past I/O in soft real-time detection
block, bfq: remove batches of confusing ifdefs
