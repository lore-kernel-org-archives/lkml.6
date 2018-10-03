Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AF1C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA542089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+FMALWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA542089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeJCOF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:05:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39778 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJCOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:05:57 -0400
Received: by mail-it1-f194.google.com with SMTP id w200-v6so7408787itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIQSR79HpzKO9Jk+wfe5HSCY8E47uZn9+4M9QuVy/Pk=;
        b=D+FMALWGalw4AH6LMJgmvUop11Kd3co3P6KD/C74+cb6UQZsSi8IKlo4dyzJ9kou1I
         yKe842j1Eo6uLybFDPZEzrLLtqAkyJBzSPauiAUv16j+dggAWTjJE5AGRhspGPkPChhk
         4m3uYGXTsdUrj91LEqqAeExILyQgWZVrWXVhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIQSR79HpzKO9Jk+wfe5HSCY8E47uZn9+4M9QuVy/Pk=;
        b=HGsRdtHEZlmQjwgTleTBidhJggmCvp8vHZ0YT/fRqgwMFy5X4FaLrWzfL3Ckofy7wk
         fc2smznA3f0Imeq0tXSTf3dx0AgqwBVBB9TfNmpCsdkmy7KHrpWi2exinWqNyd/hQl10
         Pz7+2qB6aDQeE20CIUTlPVgGn9Y3C4o1bG9P+6VKptq8JzRALriVGoh8OSFLtDRRvWsS
         w5DEuf5Rqv5r9iHG+riG2frK9tuZDVXxIAgN+ZWbgUsXXOnMgDff4JjYHi8RjnBJ8gjg
         gTzy9PIri3Ry4xvPxvXQi8Rybf4nK1Oz4U6pz0Tb9JWk4hUDo1bT+NE3HpIC6xBj/Wrq
         qzWw==
X-Gm-Message-State: ABuFfohbjqnNE1flE7t4QjxNeuV1UiR9QhMOq6kPeokSZiNZnFIZyCeB
        Ben3Pipd7GxnHLU51WTbAtqqUUiBiTy1yR1TZ2rSTQ==
X-Google-Smtp-Source: ACcGV63IG9kMX63ncGEqiYmbdbR4jEM6dxvViFksD1hsaTUFt8q8zqa+PUjBmXy/ehglNQezcPs12Zci2kEnMLHp1b4=
X-Received: by 2002:a24:83c1:: with SMTP id d184-v6mr409928ite.16.1538551130031;
 Wed, 03 Oct 2018 00:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
In-Reply-To: <1538550325.14984.108.camel@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Oct 2018 09:18:37 +0200
Message-ID: <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
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

On Wed, Oct 3, 2018 at 9:05 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:
> > So, I do understand your need for conservativeness, but, after so much
> > evidence on single-queue devices, and so many years! :), what's the
> > point in keeping Linux worse for virtually everybody, by default?
>
> Sounds like what we just need a mechanism for the device (ubi block in
> this case) to select the I/O scheduler. I doubt enhancing the default
> scheduler selection logic in 'elevator.c' is the right answer. Just
> give the driver authority to override the defaults.

This might be true in the wider sense (like for what scheduler to
select for an NVME device with N channels) but $SUBJECT is just
trying to select BFQ (if available) for devices with one and only one
hardware queue.

That is AFAICT the only reasonable choice for anything with just
one hardware queue as things stand right now.

I have a slight reservation for the weird outliers like loopdev, which
has "one hardware queue" (.nr_hw_queues == 1) though this
makes no sense at all. So I would like to know what people think
about that. Maybe we should have .nr_queues and .nr_hw_queues
where the former is the number of logical queues and the latter
the actual number of hardware queues.

Yours,
Linus Walleij
