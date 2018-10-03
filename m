Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDDDC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE773213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWZLQ02F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE773213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeJCPPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:15:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42916 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeJCPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:15:37 -0400
Received: by mail-io1-f67.google.com with SMTP id n18-v6so4321189ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ObwC7a46g9Ry41+lSvCg0g83+v1bUn/Gdbe+Tq2ZyxE=;
        b=eWZLQ02FRIHlPd20BFtykatz4VA7Sla552XaQECgBaAchCZLVtJ3c/u3Tr08DbUy/2
         VNu1UATgZb4AHtUCEuaj+7xGLAuGWhQsskcfxsH2lmWMiZhLPwVYXUM0zA3pAAGWxt7P
         0bEGCOMQRKUbs2WsrbfXTUdWWu2LBGreOaOhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObwC7a46g9Ry41+lSvCg0g83+v1bUn/Gdbe+Tq2ZyxE=;
        b=CEk0OVt4DoTSa/WwIdOvYHNhISOu4nRot9exfgC0RU3WYEY08bY737Z+rLyWx23XDL
         GRPwfeCtBudXyhBy1k2HGDIClQEelWNvNcOUYzxPpHWYbuBEa5hIiIjQkI/zWG8R7omZ
         IsQXRhWOf30IslSl9R7Bs0OlEEMHa2TIiFvtLZcpdhm9DTU0+RcSo3nK3s7N1KUqu/fs
         2kAmpxGgRAnfD0O6pfFULYbqIJKZ1JEfveo4MxLRSY9zoqKZvq86r7Zb6Hu9dvJ+KNKD
         oPWYjCNfnwrZQnXEjpsqNUu4RQpJlEIg2B7N7NHLEGvqrfXA1r3eWKSbomt0vd+cWH/B
         zdFQ==
X-Gm-Message-State: ABuFfogjqguJs4e13BzmrKOyTm2ZOTy6CdOIURnmJevW4pg+QOrjjDv9
        NwycyXlbhKreXsd2BQQXBChLwbhEVb0KWJE5Jh76Ag==
X-Google-Smtp-Source: ACcGV61owGuEnO4vVz4tcAZ/N3ZW0FJX0KAEI76C/uefI2rru4omOTNuRU6PObIOv64uQlH0tmEQixx5aOLE+s0pQpY=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr208029ioa.277.1538555295351;
 Wed, 03 Oct 2018 01:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com> <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
In-Reply-To: <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Oct 2018 10:28:03 +0200
Message-ID: <CACRpkdbHiq9bstRzyg-fJfXKnXr8wD1YzAooLAwQKM0OzP=HVA@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To:     Damien.LeMoal@wdc.com
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, aherrmann@suse.com, mgorman@suse.com,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 9:42 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:

> There is another class of outliers: host-managed SMR disks (SATA and SCSI,
> definitely single hw queue). For these, using mq-deadline is mandatory in many
> cases in order to guarantee sequential write command delivery to the device
> driver. Having the default changed to bfq, which as far as I know is not SMR
> friendly (can sequential writes within a single zone be reordered ?) is asking
> for troubles (unaligned write errors showing up).

Ah, that is interesting.

Which device driver files are we talking about here, specifically?
I'd like to take a look.

I guess what you say is not that you are looking for the deadline
scheduling per se (as in deadline scheduling is nice), what you want is
the zone locking semantics in that scheduler, is that right?

I.e. this business:
blk_queue_is_zoned(q)
blk_req_zone_write_lock(rq);
blk_req_zone_write_unlock(rq);
and mq-deadline solves this with a spinlock.

I will augment the patch to enforce mq-deadline
if blk_queue_is_zoned(q) is true, as it is clear that
any device with that characteristic must use mq-deadline.

Paoly might be interested in looking into whether BFQ could
also handle zoned devices in the future, I have no idea of how
hard that would be.

The zoned business seems a bit fragile. Should it even be
allowed to select any other scheduler than deadline on these
devices? Presenting all compiled in schedulers in
/sysblock/device/queue/scheduler sounds like just giving
sysadmins too much rope.

Yours,
Linus Walleij
